local logger = require('scripts/ezlibs-scripts/ezlogger').get('eznpcs')
local helpers = require('scripts/ezlibs-scripts/helpers')
local ezmemory = require('scripts/ezlibs-scripts/ezmemory')
local ezquests = require('scripts/ezlibs-scripts/ezquests')
local ezemail = require('scripts/ezlibs-scripts/ezemail')
local condition = require('scripts/ezlibs-scripts/condition')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local ezencounters = require('scripts/ezlibs-scripts/ezencounters/main')
local ezexplosions = require('scripts/ezlibs-scripts/ezexplosions')
local tu = require('scripts/ezlibs-scripts/utils/eztiledutils')

-- Canonical boolean normalizer. Identical contract to the old local
-- is_property_true; centralized in tiled_utils so eznpcs, eznpcs/dialogue_types,
-- ezpushback, and FootBomb all agree on how Tiled properties are read.
local is_property_true = tu.is_true

-- ==========================================================================
-- Server clock for diagnostic timing
--
-- os.clock() reports CPU time on Unix, which drifts whenever an async flow
-- yields (Async.sleep, await, network round-trips) because no CPU is being
-- consumed during the wait. That makes it useless for measuring wall-time
-- gaps like "how long between last explosion blast and kick".
--
-- Accumulating event.delta_time from the engine tick gives wall time on a
-- single, monotonic scale that matches what the player perceives. The
-- accumulator starts at 0 on module load; all markers subtract from each
-- other, so the absolute offset doesn't matter — only deltas do.
-- ==========================================================================
local server_time = 0

Net:on("tick", function(event)
    local dt = event and event.delta_time
    if type(dt) == "number" and dt > 0 then
        server_time = server_time + dt
    end
end)

local function now()
    return server_time
end

-- ==========================================================================
-- Battle result classification
--
-- Mirrors net-game-tourney/tournament-flow.lua
-- (stats_says_player_won_encounter). That module is the authoritative
-- consumer of Net:on("battle_results") in this codebase, so its rules are
-- reproduced here verbatim so battle_npc and tournaments agree on
-- win/loss semantics.
--
-- Fields available on the battle_results payload:
--
--   reason      1  → player won (definitive; health is ignored)
--               2  → player lost
--               3  → player lost
--               4  → player lost
--               0 / nil → unknown; fall back to health + enemies
--   ran         true → player fled; treated as loss
--   fled        alias for ran in some code paths
--   escape      alias for ran in some code paths
--   health      Player's post-battle HP (aliased player_hp / hp)
--   enemies     Array of { health = N, ... }; any > 0 means an enemy
--               survived → loss
--   time        Battle duration, informational only
--   emotion     Battle end emotion, informational only
--   turns       Turn count, informational only
--   score       Battle score, informational only
-- ==========================================================================
local function player_won_from_stats(stats)
    if not stats then return false end

    if stats.ran or stats.fled or stats.escape then
        return false
    end

    local reason = tonumber(stats.reason or 0) or 0
    if reason == 1 then return true end
    if reason == 2 or reason == 3 or reason == 4 then return false end

    local hp = tonumber(stats.health or stats.player_hp or stats.hp or 0) or 0
    if hp <= 0 then return false end

    if type(stats.enemies) == "table" then
        for _, enemy in ipairs(stats.enemies) do
            if tonumber(enemy.health or 0) > 0 then
                return false
            end
        end
    end

    return true
end

-- Merge result fields from exit_results into stats when present. Used so
-- a partial battle_exit payload updates only what it carries, and never
-- silently drops a ran/fled flag from the source that set it.
local RESULT_FIELDS = {
    "reason", "health", "player_hp", "hp",
    "ran", "fled", "escape", "enemies",
}

local function merge_result_fields(stats, exit_results)
    if not exit_results then return end
    for _, key in ipairs(RESULT_FIELDS) do
        if exit_results[key] ~= nil then
            stats[key] = exit_results[key]
        end
    end
end

--Dialogue Types
local dialogue_types = {
    first={
        name = "first",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function()
                local dialogue_texts = helpers.extract_numbered_properties(dialogue,"Text ")
                local next_dialogues = helpers.extract_numbered_properties(dialogue,"Next ")
                local mugshot = eznpcs.get_dialogue_mugshot(npc,player_id,dialogue)
                local res = await(Async.message_player(player_id, dialogue_texts[1], mugshot.texture_path, mugshot.animation_path))
                local next_id = first_value_from_table(next_dialogues)
                return next_id
            end)
        end
    },
    question={
        name = "question",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function ()
                local dialogue_texts = helpers.extract_numbered_properties(dialogue,"Text ")
                local next_dialogues = helpers.extract_numbered_properties(dialogue,"Next ")
                local mugshot = eznpcs.get_dialogue_mugshot(npc,player_id,dialogue)
                local res = await(Async.question_player(player_id, dialogue_texts[1], mugshot.texture_path, mugshot.animation_path))
                local next_id = next_dialogues[2-res]
                return next_id
            end)
        end
    },
    quiz={
        name = "quiz",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function ()
                local dialogue_texts = helpers.extract_numbered_properties(dialogue,"Text ")
                local next_dialogues = helpers.extract_numbered_properties(dialogue,"Next ")
                local mugshot = eznpcs.get_dialogue_mugshot(npc,player_id,dialogue)
                local res = await(Async.quiz_player(player_id, dialogue_texts[1],dialogue_texts[2],dialogue_texts[3], mugshot.texture_path, mugshot.animation_path))
                local next_id = next_dialogues[res+1]
                return next_id
            end)
        end
    },
    random={
        name = "random",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function ()
                local dialogue_texts = helpers.extract_numbered_properties(dialogue,"Text ")
                local next_dialogues = helpers.extract_numbered_properties(dialogue,"Next ")
                local mugshot = eznpcs.get_dialogue_mugshot(npc,player_id,dialogue)
                local rnd_text_index = math.random( #dialogue_texts)
                local res = await(Async.message_player(player_id, dialogue_texts[rnd_text_index], mugshot.texture_path, mugshot.animation_path))
                local next_id = next_dialogues[rnd_text_index] or next_dialogues[1]
                return next_id
            end)
        end
    },
    itemcheck={
        name = 'itemcheck',
        action = function(npc, player_id, dialogue, relay_object)
            return async(function ()
                local area_id = Net.get_player_area(player_id)
                local required_items = helpers.extract_numbered_properties(dialogue,"Item ")
                local next_dialogues = helpers.extract_numbered_properties(dialogue,"Next ")
                local take_item = tu.is_true(dialogue.custom_properties["Take Item"])
                local next_dialogue_id = nil

                local all_passed = true
                for index, item_object_id in ipairs(required_items) do
                    local item_info = helpers.read_item_information(area_id, item_object_id)
                    if item_info then
                        if item_info.type == "money" then
                            if not condition.money(player_id, item_info.amount, take_item) then
                                all_passed = false
                            end
                        else
                            if not condition.item(player_id, item_info.name, item_info.amount, take_item) then
                                all_passed = false
                            end
                        end
                    end
                end

                next_dialogue_id = all_passed and next_dialogues[1] or next_dialogues[2]
                return next_dialogue_id
            end)
        end
    },
    questcheck={
        name = "questcheck",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function ()
                local next_dialogues = helpers.extract_numbered_properties(dialogue,"Next ")
                local cond = {
                    type = "quest_flag",
                    quest = dialogue.custom_properties["Quest Name"],
                    flag = dialogue.custom_properties["Flag Name"],
                    value = dialogue.custom_properties["Flag Value"],
                    op = dialogue.custom_properties["Operator"] or dialogue.custom_properties["Op"],
                }
                local invert = tu.is_true(dialogue.custom_properties["Invert"])
                local passed = condition.evaluate(player_id, cond)
                if invert then passed = not passed end
                return passed and next_dialogues[1] or next_dialogues[2]
            end)
        end
    },
    before={
        name = "before",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function ()
                local dialogue_texts = helpers.extract_numbered_properties(dialogue,"Text ")
                local next_dialogues = helpers.extract_numbered_properties(dialogue,"Next ")
                local mugshot = eznpcs.get_dialogue_mugshot(npc,player_id,dialogue)
                local date_str = dialogue.custom_properties['Date']
                local is_before = condition.date_before(date_str)
                local message = is_before and dialogue_texts[1] or dialogue_texts[2]
                local next_id = is_before and next_dialogues[1] or next_dialogues[2]
                if message then
                    await(Async.message_player(player_id, message, mugshot.texture_path, mugshot.animation_path))
                end
                return next_id
            end)
        end
    },
    after={
        name = "after",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function ()
                local dialogue_texts = helpers.extract_numbered_properties(dialogue,"Text ")
                local next_dialogues = helpers.extract_numbered_properties(dialogue,"Next ")
                local mugshot = eznpcs.get_dialogue_mugshot(npc,player_id,dialogue)
                local date_str = dialogue.custom_properties['Date']
                local is_after = condition.date_after(date_str)
                local message = is_after and dialogue_texts[1] or dialogue_texts[2]
                local next_id = is_after and next_dialogues[1] or next_dialogues[2]
                if message then
                    await(Async.message_player(player_id, message, mugshot.texture_path, mugshot.animation_path))
                end
                return next_id
            end)
        end
    },
    shop={
        name = "shop",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function ()
                local area_id = Net.get_player_area(player_id)
                local shop_item_object_ids = helpers.extract_numbered_properties(dialogue,"Item ")
                local next_dialogues = helpers.extract_numbered_properties(dialogue,"Next ")
                local mugshot = eznpcs.get_dialogue_mugshot(npc,player_id,dialogue)
                local shop_items = {}

                for i, item_object_id in ipairs(shop_item_object_ids) do
                    local item_info = helpers.read_item_information(area_id,item_object_id)
                    if item_info then
                        local shop_item = {
                            name=item_info.name,
                            price=item_info.price,
                            description=item_info.description or "???",
                            is_key=item_info.type == 'keyitem'
                        }
                        table.insert(shop_items,shop_item)
                    end
                end

                await(ezmemory.open_shop_async(player_id,shop_items,mugshot.texture_path,mugshot.animation_path))
                local next_id = first_value_from_table(next_dialogues)
                return next_id
            end)
        end
    },
    password={
        name = "password",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function ()
                local correct_password = dialogue.custom_properties["Text 1"]
                local user_input = await(Async.prompt_player(player_id))
                if user_input == correct_password then
                    return dialogue.custom_properties["Next 1"]
                else
                    return dialogue.custom_properties["Next 2"]
                end
            end)
        end
    },
    quest_switch={
        name = "quest_switch",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function ()
                local quest_name = dialogue.custom_properties["Quest Name"]
                local quest_state = ezquests.get_player_quest_state(player_id,quest_name)
                if dialogue.custom_properties[quest_state] then
                    return dialogue.custom_properties[quest_state]
                else
                    logger:warn('[eznpcs] dialogue node',dialogue.id,'has no custom property for quest state',quest_state)
                end
            end)
        end
    },
    quest_event={
        name = "quest_event",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function ()
                local quest_name = dialogue.custom_properties["Quest Name"]
                local event_value = dialogue.custom_properties["Event Value"]
                local next_dialogues = helpers.extract_numbered_properties(dialogue,"Next ")
                await(ezquests.quest_event(player_id,quest_name,event_value))
                ezbus:emit("quest_event", {
                    player_id = player_id,
                    quest_name = quest_name,
                    event_value = event_value
                })
                return first_value_from_table(next_dialogues)
            end)
        end
    },
    item={
        name = "item",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function ()
                local area_id = Net.get_player_area(player_id)
                local gift_item_ids = helpers.extract_numbered_properties(dialogue,"Item ")
                local notify_player = not tu.is_true(dialogue.custom_properties["Dont Notify"])
                for index, item_id in ipairs(gift_item_ids) do
                    ezmemory.give_item_with_optional_notify(player_id,area_id,item_id,nil,notify_player)
                end
                return dialogue.custom_properties["Next 1"]
            end)
        end
    },
    email={
        name = "email",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function()
                local next_dialogues = helpers.extract_numbered_properties(dialogue,"Next ")
                local next_id = first_value_from_table(next_dialogues)

                local MUG_DIR = "/server/assets/ezlibs-assets/eznpcs/mug/"

                local function has_asset(path)
                    if not path or path == "" then return false end
                    if not (Net and Net.has_asset) then return true end
                    local ok, res = pcall(Net.has_asset, path)
                    if ok and res == true then return true end
                    if ok and res == false then return false end
                    return true
                end

                local function ensure_ext(p, ext)
                    if not p or p == "" then return nil end
                    if p:match("%.[%w]+$") then return p end
                    return p .. ext
                end

                local function resolve_texture(raw)
                    if not raw or raw == "" then return nil end
                    if raw:find("/") then
                        return ensure_ext(raw, ".png")
                    end
                    local name = raw
                    if not name:match("%.png$") then name = name .. ".png" end
                    return MUG_DIR .. name
                end

                local function resolve_anim(raw)
                    if raw == nil or raw == "" then
                        return MUG_DIR .. "mug.animation"
                    end
                    if raw:find("/") then
                        return ensure_ext(raw, ".animation")
                    end
                    local name = raw
                    if not name:match("%.animation$") then name = name .. ".animation" end
                    return MUG_DIR .. name
                end

                local id = dialogue.custom_properties["Email Id"]
                if not id or id == "" then
                    logger:warn("[eznpcs] email dialogue missing Email Id on node", dialogue.id)
                    return next_id
                end

                local icon  = tu.get_number_from(dialogue.custom_properties, "Email Icon", 1)
                local title = dialogue.custom_properties["Email Title"] or "Mail"
                local from  = dialogue.custom_properties["Email From"] or "???"

                local body_lines = helpers.extract_numbered_properties(dialogue,"Body ")
                local body = ""
                if body_lines and #body_lines > 0 then
                    body = table.concat(body_lines, "\n\n")
                else
                    body = dialogue.custom_properties["Email Body"] or ""
                end

                local notify  = not tu.is_true(dialogue.custom_properties["Dont Notify"])
                local delay   = tu.to_number(dialogue.custom_properties["Notify Delay"], nil)
                local msg     = dialogue.custom_properties["Notify Message"] or "Looks like you got an e-mail."
                local persist = tu.is_true(dialogue.custom_properties["Persist"], true)

                local tex_raw  = dialogue.custom_properties["Mug Texture Path"]
                local anim_raw = dialogue.custom_properties["Mug Animation Path"]

                local tex_path = resolve_texture(tex_raw)
                local anim_path = nil

                if tex_path then
                    anim_path = resolve_anim(anim_raw)

                    if not has_asset(tex_path) or not has_asset(anim_path) then
                        logger:warn("[eznpcs] email mug asset missing. tex=", tex_path, "anim=", anim_path, " -> sending without mug")
                        tex_path = nil
                        anim_path = nil
                    end
                end

                local mail = {
                    id = tostring(id),
                    icon = icon,
                    title = title,
                    from = from,
                    body = body,
                }

                if tex_path and anim_path then
                    mail.mug_texture_path = tex_path
                    mail.mug_animation_path = anim_path
                end

                if persist then
                    ezemail.send_once(player_id, mail, {
                        notify = notify,
                        notify_message = msg,
                        notify_delay = delay
                    })
                else
                    ezemail.send_temp(player_id, mail, {
                        notify = notify,
                        notify_message = msg,
                        notify_delay = delay
                    })
                end

                return next_id
            end)
        end
    },
    battle_npc={
        name = "battle_npc",
        action = function(npc, player_id, dialogue, relay_object)
            return async(function()
                local area_id = Net.get_player_area(player_id)
                local intro_message = dialogue.custom_properties["Text 1"]
                local question = dialogue.custom_properties["Text 2"] or "Ready to fight?"
                local encounter_name = dialogue.custom_properties["Encounter Name"]
                local fail_msg = dialogue.custom_properties["Failure Message"] or "You hesitated..."
                -- Kick is optional; defaults to true so existing maps keep
                -- their behavior. Set Kick On Loss = false on the Dialogue
                -- node to leave the player in place (input still unlocked).
                local kick_on_loss = tu.get_boolean_from(
                    dialogue.custom_properties, "Kick On Loss", true)

                if not encounter_name then
                    logger:warn("[eznpcs] battle_npc missing Encounter Name")
                    return
                end

                if intro_message and intro_message ~= "" then
                    local mugshot = eznpcs.get_dialogue_mugshot(npc, player_id, dialogue)
                    await(Async.message_player(player_id, intro_message, mugshot.texture_path, mugshot.animation_path))
                end

                local choice = await(Async.question_player(player_id, question))
                if choice == 0 then
                    return
                end

                eznpcs.prepare_battle_exit_wait(player_id)

                local stats = await(ezencounters.begin_encounter_by_name(player_id, encounter_name))
                if not stats then
                    eznpcs.cancel_battle_exit_wait(player_id)
                    await(Async.message_player(player_id, "The challenge could not be initiated."))
                    return
                end

                logger:for_player(player_id):info(string.format(
                    "[battle_npc] encounter completed t=%.3f initial_reason=%s initial_health=%s initial_ran=%s",
                    now(),
                    tostring(stats.reason),
                    tostring(stats.health or stats.player_hp or stats.hp),
                    tostring(stats.ran or stats.fled or stats.escape)))

                -- Wait for the engine's battle_exit. Returns (nil, nil) when
                -- the wait is cancelled — typically because the player
                -- disconnected or "panicked out" mid-battle.
                local exit_results, exit_event = await(eznpcs.wait_for_battle_exit(player_id))

                logger:for_player(player_id):info(string.format(
                    "[battle_npc] battle_exit received t=%.3f had_exit=%s",
                    now(), tostring(exit_results ~= nil)))

                -- Merge (rather than replace) the exit payload into stats.
                -- A partial battle_exit event should only update the fields
                -- it actually carries; wholesale replacement could drop a
                -- ran flag from the initial stats or vice versa.
                merge_result_fields(stats, exit_results)

                -- If the wait was cancelled (no clean exit) and we don't
                -- have a definitive win signal, treat this as an
                -- interrupted battle rather than awarding a win from
                -- partial data. This is the panic-out path: engine may
                -- still report full HP for a player who left mid-battle.
                --
                -- Exception: reason == 1 is definitive. A player who
                -- genuinely won then disconnected before battle_exit still
                -- gets the win.
                if not exit_results then
                    local reason_num = tonumber(stats.reason or 0) or 0
                    local ran_flag = stats.ran or stats.fled or stats.escape
                    if not ran_flag and reason_num ~= 1 then
                        logger:for_player(player_id):info(string.format(
                            "[battle_npc] battle interrupted (no battle_exit); " ..
                            "reason=%s ran=%s → treating as loss",
                            tostring(reason_num), tostring(ran_flag)))
                        return
                    end
                end

                local won = player_won_from_stats(stats)

                logger:for_player(player_id):info(string.format(
                    "[battle_npc] result won=%s reason=%s ran=%s fled=%s escape=%s " ..
                    "health=%s enemies=%s had_exit=%s kick_on_loss=%s bot_id=%s placeholder_id=%s",
                    tostring(won),
                    tostring(stats.reason),
                    tostring(stats.ran),
                    tostring(stats.fled),
                    tostring(stats.escape),
                    tostring(stats.health or stats.player_hp or stats.hp),
                    tostring(stats.enemies and #stats.enemies or 0),
                    tostring(exit_results ~= nil),
                    tostring(kick_on_loss),
                    tostring(npc.bot_id),
                    tostring(npc.placeholder_id)))

                if won then
                    -- Win path. Always hide the NPC placeholder even if the
                    -- player disconnected mid-effect, so their progression
                    -- persists across reconnects. Visible effects only play
                    -- when the player is still around.
                    if Net.is_player(player_id) then
                        local t_start = now()
                        logger:for_player(player_id):info(string.format(
                            "[battle_npc] win explosion starting t=%.3f", t_start))
                        await(ezexplosions.explode_and_wait(npc.bot_id, area_id, 3))
                        logger:for_player(player_id):info(string.format(
                            "[battle_npc] win explosion done t=%.3f duration=%.3f",
                            now(), now() - t_start))
                    end

                    local npc_properties = npc.placeholder_custom_properties or {}
                    if is_property_true(npc_properties["Player Exclusive"]) then
                        pcall(eznpcs.remove_exclusive_npc, player_id, npc.placeholder_id)
                    end
                    pcall(ezmemory.hide_object_from_player, player_id, area_id, npc.placeholder_id)
                else
                    -- Loss path. If the player is already gone, skip the
                    -- effect and any post-effects entirely.
                    if not Net.is_player(player_id) then
                        logger:for_player(player_id):info(
                            "[battle_npc] player disconnected after loss; skipping effects")
                        return
                    end

                    local t_explode_start = now()
                    logger:for_player(player_id):info(string.format(
                        "[battle_npc] loss explosion starting t=%.3f", t_explode_start))
                    await(ezexplosions.explode_and_wait(player_id, area_id, 3))
                    logger:for_player(player_id):info(string.format(
                        "[battle_npc] loss explosion done t=%.3f duration=%.3f",
                        now(), now() - t_explode_start))

                    if kick_on_loss then
                        -- Kick path: try to kick, tracking whether it
                        -- actually succeeded so we can fall back to an
                        -- explicit unlock if the kick silently failed.
                        local t_kick_start = now()
                        logger:for_player(player_id):info(string.format(
                            "[battle_npc] kicking t=%.3f", t_kick_start))
                        local kicked = false
                        if Net.is_player(player_id) then
                            local ok_pcall, result = pcall(
                                Net.kick_player, player_id, "You were defeated!", true)
                            kicked = ok_pcall and (result ~= false)
                        end
                        logger:for_player(player_id):info(string.format(
                            "[battle_npc] kick done t=%.3f duration=%.3f kicked=%s",
                            now(), now() - t_kick_start, tostring(kicked)))

                        if not kicked then
                            if Net.is_player(player_id) then
                                logger:for_player(player_id):warn(
                                    "[battle_npc] kick did not run or failed; " ..
                                    "unlocking input as fallback")
                                pcall(Net.unlock_player_input, player_id)
                            else
                                logger:for_player(player_id):info(
                                    "[battle_npc] player disconnected during loss explosion; " ..
                                    "no live player to unlock")
                            end
                        end
                    else
                        -- Kick On Loss disabled. Leave the player in place
                        -- (e.g. for scripted losses where they stay in the
                        -- map), but always unlock input so they aren't
                        -- stuck at 0 HP with locked controls.
                        logger:for_player(player_id):info(
                            "[battle_npc] Kick On Loss disabled; leaving " ..
                            "player in place with input unlocked")
                        pcall(Net.unlock_player_input, player_id)
                    end
                end
            end)
        end
    }
}

Net:on("battle_results", function (event)
    Net.is_player_battling(event.player_id)
    logger:for_player(event.player_id):info(string.format(
        "[battle_npc] battle_results received t=%.3f reason=%s health=%s ran=%s fled=%s escape=%s is_battling=%s",
        now(),
        tostring(event.reason),
        tostring(event.health),
        tostring(event.ran),
        tostring(event.fled),
        tostring(event.escape),
        tostring(Net.is_player_battling(event.player_id))))
end)

return dialogue_types