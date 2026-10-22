local logger = require('scripts/ezlibs-scripts/ezlogger').get('ezcheckpoints')
local ezmemory = require('scripts/ezlibs-scripts/ezmemory')
local helpers = require('scripts/ezlibs-scripts/helpers')
local condition = require('scripts/ezlibs-scripts/condition')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local tu = require('scripts/ezlibs-scripts/utils/eztiledutils')

-- Optional schema-driven validation. If the generated schema file is not
-- present yet (user hasn't run generate-ezlibs-tiled.lua), validation is
-- skipped silently so the module continues to load.
local tiled_schema = nil
do
    local ok, mod = pcall(require, "scripts.ezlibs-scripts.ezlibs-tiled-schema")
    if ok and type(mod) == "table" and mod.classes then
        tiled_schema = mod
    end
end

local ezcheckpoints = {}

-- ==========================================================================
-- Player liveness + Net call helpers
--
-- Checkpoint operations frequently arrive after a player has disconnected
-- (queued group effects, delayed button deactivations, area-wide unlocks
-- applied to a player mid-transfer, etc.). Every player-targeting Net call
-- must be treated as potentially stale. These helpers centralize that.
-- ==========================================================================

-- Returns true if the player is still connected.
-- Conservative: if the check itself fails or Net.is_player is missing, we
-- assume the player is alive rather than silently skipping the action.
local function is_player_alive(player_id)
    if player_id == nil then return false end
    if type(Net.is_player) ~= "function" then return true end
    local ok, alive = pcall(Net.is_player, player_id)
    if not ok then return true end
    return not not alive
end

-- Run a Net function under pcall; return true on success. Logs failures at
-- info level so they're visible without crashing the server or being spammy
-- as a warning.
local function safe_net(fn, ...)
    if type(fn) ~= "function" then return false, "not a function" end
    local ok, err = pcall(fn, ...)
    if not ok then
        logger:info("[ezcheckpoints] Net call failed:", tostring(err))
    end
    return ok, err
end

-- ==========================================================================
-- Navi cache
--
-- Populated from Net:on("player_avatar_change"), whose event carries:
--   { player_id, texture_path, animation_path, name, element, max_health,
--     prevent_default }
-- ==========================================================================
local navi_cache = {}

Net:on("player_avatar_change", function(event)
    if not event or not event.player_id then return end
    navi_cache[event.player_id] = {
        name         = event.name,
        element      = event.element,
        texture_path = event.texture_path,
        animation_path = event.animation_path,
        max_health   = event.max_health,
    }
    logger:for_player(event.player_id):debug(
        "[ezcheckpoints] navi cache updated: name=", tostring(event.name),
        "element=", tostring(event.element))
end)

-- Best-effort cache cleanup. Registered as a Net event, and also exposed as
-- handle_player_disconnect for dispatchers that call it directly.
Net:on("player_disconnect", function(event)
    local player_id = (type(event) == "table") and event.player_id or event
    if player_id then
        navi_cache[player_id] = nil
    end
end)

function ezcheckpoints.handle_player_disconnect(player_id)
    if player_id then
        navi_cache[player_id] = nil
    end
end

-- Public accessor. Override at startup if your game derives navi data from a
-- different source than the avatar_change event.
function ezcheckpoints.get_player_navi_info(player_id)
    return navi_cache[player_id]
end

-- ==========================================================================
-- Navi check helpers
-- ==========================================================================

local function names_equal(a, b)
    if type(a) ~= "string" or type(b) ~= "string" then return false end
    return a:lower() == b:lower()
end

function ezcheckpoints.player_has_navi(player_id, name)
    local info = ezcheckpoints.get_player_navi_info(player_id)
    return info ~= nil and names_equal(info.name, name)
end

function ezcheckpoints.player_has_navi_element(player_id, element)
    local info = ezcheckpoints.get_player_navi_info(player_id)
    return info ~= nil and names_equal(info.element, element)
end

function ezcheckpoints.player_has_any_navi(player_id, names)
    local info = ezcheckpoints.get_player_navi_info(player_id)
    if not info or not info.name then return false end
    for _, n in ipairs(names) do
        if names_equal(info.name, n) then return true end
    end
    return false
end

local function evaluate_navi_check(player_id, navi_check)
    if not navi_check then return false, "no check" end

    local info = ezcheckpoints.get_player_navi_info(player_id)
    if not info then
        logger:for_player(player_id):warn(
            "[ezcheckpoints] navi unlock requested but get_player_navi_info() " ..
            "returned nil (player has no cached avatar). Ensure " ..
            "Net:on('player_avatar_change') fires for this player, or override " ..
            "ezcheckpoints.get_player_navi_info.")
        return false, "no navi info"
    end

    if navi_check.kind == "navi_name" then
        if names_equal(info.name, navi_check.required) then return true, "match" end
        return false, "expected=" .. tostring(navi_check.required)
            .. " got=" .. tostring(info.name)
    end
    if navi_check.kind == "navi_element" then
        if names_equal(info.element, navi_check.required) then return true, "match" end
        return false, "expected=" .. tostring(navi_check.required)
            .. " got=" .. tostring(info.element)
    end
    if navi_check.kind == "navi_list" then
        for _, n in ipairs(navi_check.names or {}) do
            if names_equal(info.name, n) then return true, "match " .. n end
        end
        return false, "not in list, got=" .. tostring(info.name)
    end
    return false, "unknown kind " .. tostring(navi_check.kind)
end

-- ==========================================================================
-- Unlock / relock
-- ==========================================================================

-- Helper that unlocks the checkpoint for a player.
--
-- Persistent state (the hide) is ALWAYS applied, even when the player is no
-- longer connected: that is what their reconnect state is driven from, and
-- silently skipping it would leave a checkpoint unlocked across reconnects
-- because a button fired just as they dropped.
--
-- Live effects (input lock, sound, animation bot, input unlock) run only when
-- the player is confirmed connected, and every Net call is pcall-guarded so a
-- mid-await disconnect cannot crash the coroutine.
function ezcheckpoints.unlock_checkpoint_for_player(player_id, area_id, object_id, unlocking_asset_name, unlocking_sound_path, unlocking_animation_time, once)
    return async(function ()
        local object = Net.get_object_by_id(area_id, object_id)
        if not object then
            return false
        end

        -- Persistent hide: apply regardless of player presence.
        if once then
            pcall(ezmemory.hide_object_from_player, player_id, area_id, object_id)
        else
            pcall(ezmemory.hide_object_from_player_till_disconnect, player_id, area_id, object_id)
        end

        -- Live effects: only if the player is still connected.
        if is_player_alive(player_id) then
            safe_net(Net.lock_player_input, player_id)
            safe_net(Net.play_sound_for_player, player_id, unlocking_sound_path)

            if unlocking_animation_time > 0 then
                local new_bot_props = {
                    x = object.x,
                    y = object.y,
                    z = object.z,
                    texture_path = "/server/assets/ezlibs-assets/ezcheckpoints/" .. unlocking_asset_name .. ".png",
                    animation_path = "/server/assets/ezlibs-assets/ezcheckpoints/" .. unlocking_asset_name .. ".animation",
                    animation = "UNLOCKING",
                    warp_in = false,
                    area_id = area_id
                }
                safe_net(Net.provide_asset, area_id, new_bot_props.texture_path)

                local bot_id = Net.create_bot(new_bot_props)
                await(Async.sleep(unlocking_animation_time))

                -- Player may have disconnected during the animation; the
                -- remaining live Net calls must be re-checked.
                if bot_id then
                    safe_net(Net.remove_bot, bot_id, false)
                end
                if is_player_alive(player_id) then
                    safe_net(Net.unlock_player_input, player_id)
                end
            else
                if is_player_alive(player_id) then
                    safe_net(Net.unlock_player_input, player_id)
                end
            end
        end

        ezbus:emit("checkpoint_unlocked", {
            player_id = player_id,
            area_id = area_id,
            object_id = object_id
        })
        return true
    end)
end

-- Public shortcut to force-unlock a checkpoint using its own properties
function ezcheckpoints.force_unlock_checkpoint(player_id, area_id, object_id, once)
    local obj = Net.get_object_by_id(area_id, object_id)
    if not obj or obj.type ~= "Checkpoint" then
        logger:for_area(area_id):warn("[ezcheckpoints] force_unlock_checkpoint: object not found or not a checkpoint")
        return false
    end
    local props = obj.custom_properties or {}
    local asset = tu.get_string_from(props, "Unlocking Asset Name", "bn5cubegreen_bot")
    local sound = tu.get_string_from(props, "Unlocking Sound Path", "/server/assets/ezlibs-assets/sfx/panel_change.ogg")
    local anim_time = tu.get_number_from(props, "Unlocking Animation Time", 0)
    return ezcheckpoints.unlock_checkpoint_for_player(player_id, area_id, object_id, asset, sound, anim_time, once)
end

-- Re-lock a checkpoint for a player.
--
-- Persistent unhide always runs (that is how the player's reconnect state is
-- cleared). The live object include runs only when the player is confirmed
-- connected and still in the checkpoint's area. All memory/Net access is
-- guarded so callers wrapping this in pcall isn't required for safety.
function ezcheckpoints.relock_checkpoint(player_id, area_id, object_id)
    if player_id == nil then return false end

    local persistent_ok = true
    if type(ezmemory.unhide_object_from_player) == "function" then
        local ok, result = pcall(ezmemory.unhide_object_from_player, player_id, area_id, object_id)
        if ok then
            persistent_ok = result ~= false
        else
            persistent_ok = false
            logger:for_player(player_id):info(
                "[ezcheckpoints] unhide_object_from_player failed:", tostring(result))
        end
    end
    if type(ezmemory.unhide_object_from_player_till_disconnect) == "function" then
        pcall(ezmemory.unhide_object_from_player_till_disconnect, player_id, area_id, object_id)
    end

    if not is_player_alive(player_id) then
        return persistent_ok
    end

    local area_ok, player_area = false, nil
    if type(Net.get_player_area) == "function" then
        area_ok, player_area = pcall(Net.get_player_area, player_id)
    end
    if not area_ok then
        logger:for_player(player_id):warn(
            "[ezcheckpoints] relock_checkpoint: player area unavailable; skipping live include")
        return persistent_ok
    end

    if Net.include_object_for_player and player_area == area_id then
        pcall(Net.include_object_for_player, player_id, object_id)
    end

    return persistent_ok
end

-- ==========================================================================
-- Object interaction
-- ==========================================================================

Net:on("object_interaction", function(event)
    local button = event.button
    if button ~= 0 then return end

    local player_id = event.player_id
    local object_id = event.object_id
    local area_id = Net.get_player_area(player_id)

    local checkpoint_object = Net.get_object_by_id(area_id, object_id)
    if not checkpoint_object then return end
    if checkpoint_object.type ~= "Checkpoint" then return end

    local lock_id = player_id.."_"..area_id.."_"..checkpoint_object.id
    local lock = helpers.get_lock(player_id, lock_id)
    if not lock then
        return
    end

    local cp = checkpoint_object.custom_properties or {}

    if tiled_schema then
        local class_def = tiled_schema.classes["Checkpoint"]
        if class_def then
            local ok, report = tu.validate_properties(
                checkpoint_object, class_def.members, tiled_schema.enums)
            if not ok then
                for _, e in ipairs(report.errors) do
                    logger:for_area(area_id):warn(string.format(
                        "[ezcheckpoints] Checkpoint %s: %s (expected %s, got %s)",
                        tostring(checkpoint_object.id), e.issue,
                        tostring(e.expected), tostring(e.got)))
                end
            end
        end
    end

    local password_raw             = tu.get_string_from(cp, "Password", "")
    local has_password             = password_raw ~= ""
    local key_type                 = tu.get_string_from(cp, "Key Type", "money")
    local key_item_name            = tu.get_string_from(cp, "Key Item Name", "")
    local required_keys            = tu.get_number_from(cp, "Required Keys", 1)
    local consume                  = tu.is_true(cp["Consume"])
    local once                     = tu.is_true(cp["Once"])
    local unlocking_asset_name     = tu.get_string_from(cp, "Unlocking Asset Name", "bn5cubegreen_bot")
    local unlocking_animation_time = tu.get_number_from(cp, "Unlocking Animation Time", 0)
    local unlocking_sound_path     = tu.get_string_from(cp, "Unlocking Sound Path",
                                         "/server/assets/ezlibs-assets/sfx/panel_change.ogg")
    local skip_prompt              = tu.is_true(cp["Skip Prompt"])
    local description              = tu.get_string_from(cp, "Description", "It's a Security Cube")
    local unlocked_message         = tu.get_string_from(cp, "Unlocked Message",
                                         "The Security Cube was unlocked!")
    local unlock_failed_message    = tu.get_string_from(cp, "Unlock Failed Message",
                                         "You were unable to unlock the Security Cube")

    local boss_gate_flag = tu.is_true(cp["Boss Gate"])
    local is_boss_gate = boss_gate_flag or (key_type == "bossgate")

    return async(function ()
        if #tostring(description or "") > 0 then
            await(Async.message_player(player_id, description))
        end

        if is_boss_gate then
            -- [[BOSS_GATE: keep your existing boss gate logic here]]
        end

        local prompt_message = ""
        local cond = nil
        local navi_check = nil

        if has_password then
            prompt_message = "Please input the password"
        elseif key_type == "money" then
            cond = { type = "money", amount = required_keys, consume = consume }
            prompt_message = (consume and "Spend " or "Show ")
                .. required_keys .. "$ to Unlock?"
        elseif key_type == "fragments" then
            cond = { type = "fragments", amount = required_keys, consume = consume }
            prompt_message = (consume and "Spend " or "Show ")
                .. required_keys .. " Fragments to Unlock?"
        elseif key_type == "tokens" then
            cond = { type = "tokens", amount = required_keys, consume = consume }
            prompt_message = (consume and "Spend " or "Show ")
                .. required_keys .. " Tokens to Unlock?"
        elseif key_type == "item" then
            if key_item_name == "" then
                await(Async.message_player(player_id,
                    "This checkpoint requires an item, but no item name was set."))
                lock.release()
                return
            end
            cond = { type = "item", name = key_item_name,
                     amount = required_keys, consume = consume }
            if required_keys > 1 then
                prompt_message = (consume and "Use " or "Show ")
                    .. required_keys .. " " .. key_item_name .. " to Unlock?"
            else
                prompt_message = (consume and "Use " or "Show ")
                    .. key_item_name .. " to Unlock?"
            end
        elseif key_type == "navi_name" then
            local required_navi = tu.get_string_from(cp, "Navi Name", "")
            if required_navi == "" then
                await(Async.message_player(player_id,
                    "This checkpoint requires a Navi name, but none was set."))
                lock.release()
                return
            end
            navi_check = { kind = "navi_name", required = required_navi }
            prompt_message = "This lock requires the Navi '"
                .. required_navi .. "'. Unlock?"
        elseif key_type == "navi_element" then
            local required_elem = tu.get_string_from(cp, "Navi Element", "")
            if required_elem == "" then
                await(Async.message_player(player_id,
                    "This checkpoint requires a Navi element, but none was set."))
                lock.release()
                return
            end
            navi_check = { kind = "navi_element", required = required_elem }
            prompt_message = "This lock requires a "
                .. required_elem .. "-element Navi. Unlock?"
        elseif key_type == "navi_list" then
            local navi_list = {}
            for i = 1, 10 do
                local name = cp["Navi " .. i]
                if type(name) == "string" and name ~= "" then
                    navi_list[#navi_list + 1] = name
                end
            end
            if #navi_list == 0 then
                await(Async.message_player(player_id,
                    "This checkpoint requires an approved Navi, but no list was set."))
                lock.release()
                return
            end
            navi_check = { kind = "navi_list", names = navi_list }
            prompt_message = "This lock requires an approved Navi. Unlock?"
        else
            await(Async.message_player(player_id, "Invalid key type for this checkpoint."))
            lock.release()
            return
        end

        local unlocked = false

        if has_password then
            if not skip_prompt and #prompt_message > 0 then
                await(Async.message_player(player_id, prompt_message))
            end
            local input = await(Async.prompt_player(player_id))
            unlocked = (input == password_raw)
        elseif navi_check then
            if not skip_prompt and #prompt_message > 0 then
                local choice = await(Async.question_player(player_id, prompt_message))
                if choice == 0 then
                    lock.release()
                    return
                end
            end
            local passed, detail = evaluate_navi_check(player_id, navi_check)
            if not passed then
                logger:for_player(player_id):info(
                    "[ezcheckpoints] navi check failed:", navi_check.kind, detail)
            end
            unlocked = passed
        elseif cond then
            if not skip_prompt and #prompt_message > 0 then
                local choice = await(Async.question_player(player_id, prompt_message))
                if choice == 0 then
                    lock.release()
                    return
                end
            end
            unlocked = condition.evaluate(player_id, cond)
        end

        if unlocked then
            await(ezcheckpoints.unlock_checkpoint_for_player(
                player_id,
                area_id,
                object_id,
                unlocking_asset_name,
                unlocking_sound_path,
                unlocking_animation_time,
                once
            ))
            if #tostring(unlocked_message or "") > 0 then
                await(Async.message_player(player_id, unlocked_message))
            end
        else
            await(Async.message_player(player_id, unlock_failed_message))
        end

        lock.release()
    end)
end)

return ezcheckpoints