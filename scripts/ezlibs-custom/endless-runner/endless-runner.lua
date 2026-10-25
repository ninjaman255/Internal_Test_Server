--[[
endless-runner.lua — Cinematic endless-runner built on ezmapinstances,
eznpcs waypoints, and ezbottriggers.

Base area (template): "endless-runner" — the player is NEVER sent here
directly; they are warped into a per-player CLONE created from it.

Camera
------
    Net.track_with_player_camera(player_id, actor_id)   -- follow actor
    Net.track_with_player_camera(player_id)             -- follow player

The camera is set to follow the avatar bot AFTER the player has fully
committed to the clone instance (so the transfer's camera reset can't
override it). The player is then warped offscreen via the position API
(Net.set_player_position / Net.warp_player_position), which does NOT
reset the camera. A ~2s safety-net re-applies follow-bot in case another
system resets the camera.

On stop(): camera is handed back to the player BEFORE the bot is removed.

Input is LOCKED by default while the runner is active.

Options
-------
  lock_input          (bool, default true)   lock player input on enter
  follow_bot_camera   (bool, default true)   camera follows the bot
  offscreen           (bool, default true)   warp player offscreen
  offscreen_offset    (number, default 5000) X/Y offset from spawn
  offscreen_x         (number, overrides offscreen_offset)
  offscreen_y         (number, overrides offscreen_offset)
  offscreen_z         (number, default 0)
--]]

local EzMapInstance   = require("scripts/ezlibs-scripts/ezmapinstance")
local eznpcs          = require("scripts/ezlibs-scripts/eznpcs/eznpcs")
local ezbottriggers   = require("scripts/ezlibs-scripts/eztriggers/ezbottriggers")
local AvatarRegistry  = require("scripts/avatar_registry/main")

local EndlessRunner = {}

local DEFAULT_BASE_AREA_ID = "endless-runner"
local SPAWN_TYPE           = "Endless Runner Spawn"
local TRIGGER_TYPE         = "Endless Runner Trigger"

-- Position-only APIs (do not touch the camera).
local POSITION_APIS = {
    "set_player_position",
    "warp_player_position",
    "teleport_player_position",
}

-- How often to re-assert follow-bot as a safety net against external camera
-- resets. 120 ticks ≈ 2 seconds at 60 fps.
local CAMERA_REAPPLY_INTERVAL = 120
local tick_counter = 0

local active_runners = {}
local last_logged_state = {}

local function log_for(player_id, message)
    local key = tostring(player_id) .. "|" .. message
    if last_logged_state[key] then return end
    last_logged_state[key] = true
    print("[endless_runner] " .. tostring(player_id) .. " " .. message)
end

local function clear_log_for(player_id)
    local prefix = tostring(player_id) .. "|"
    for k in pairs(last_logged_state) do
        if k:sub(1, #prefix) == prefix then
            last_logged_state[k] = nil
        end
    end
end

-- ---------------------------------------------------------------------------
-- Helpers
-- ---------------------------------------------------------------------------

local function sanitize_id(value)
    return (tostring(value or ""):gsub("[^%w_%-]", "_"))
end

local function find_object_by_type(area_id, type_name)
    for _, object_id in ipairs(Net.list_objects(area_id) or {}) do
        local ok, obj = pcall(Net.get_object_by_id, area_id, object_id)
        if ok and obj and obj.type == type_name then
            return obj
        end
    end
    return nil
end

local function find_object_by_name(area_id, name)
    for _, object_id in ipairs(Net.list_objects(area_id) or {}) do
        local ok, obj = pcall(Net.get_object_by_id, area_id, object_id)
        if ok and obj and obj.name == name then
            return obj
        end
    end
    return nil
end

local function find_object_by_id(area_id, object_id)
    local ok, obj = pcall(Net.get_object_by_id, area_id, object_id)
    if ok then return obj end
    return nil
end

-- Transfer-capable warp. Uses position APIs first when already in the target
-- area; otherwise falls through to Net.transfer_player (which resets camera).
local function seamless_warp(player_id, target_area_id, x, y, z)
    local current_area = Net.get_player_area(player_id)
    if current_area == target_area_id then
        for _, name in ipairs(POSITION_APIS) do
            local fn = Net[name]
            if type(fn) == "function" then
                local ok, res = pcall(fn, player_id, x, y, z)
                if ok and res ~= false then return true end
            end
        end
    end
    if type(Net.transfer_player) == "function" then
        local ok, res = pcall(Net.transfer_player, player_id, target_area_id, false, x, y, z)
        if ok and res ~= false then return true end
        if not ok then
            print("[endless_runner] transfer_player error: " .. tostring(res))
        end
    else
        print("[endless_runner] Net.transfer_player is unavailable")
    end
    return false
end

-- Position-only warp. Never falls back to transfer_player. Returns the API
-- name that worked, or nil. Used by the offscreen move because a transfer
-- here would reset the camera we just handed to the bot.
local function try_position_only(player_id, x, y, z)
    for _, name in ipairs(POSITION_APIS) do
        local fn = Net[name]
        if type(fn) == "function" then
            local ok, res = pcall(fn, player_id, x, y, z)
            if ok and res ~= false then return name end
        end
    end
    return nil
end

local function exclude_bot_from_other_players(bot_id, owner_player_id)
    for _, area_id in ipairs(Net.list_areas() or {}) do
        for _, pid in ipairs(Net.list_players(area_id) or {}) do
            if pid ~= owner_player_id then
                pcall(Net.exclude_actor_for_player, pid, bot_id)
            end
        end
    end
end

local function wait_for_spawn(area_id, max_ticks)
    max_ticks = max_ticks or 5
    for i = 0, max_ticks do
        local obj = find_object_by_type(area_id, SPAWN_TYPE)
        if obj then return obj, i end
        if i < max_ticks then
            await(Async.sleep(0))
        end
    end
    return nil, max_ticks
end

-- Camera helpers. Net.track_with_player_camera(player_id, actor_id?)
-- with a bot_id follows the bot; with no second arg, follows the player.
local function camera_follow_actor(player_id, actor_id)
    if type(Net.track_with_player_camera) ~= "function" then return false end
    local ok, res = pcall(Net.track_with_player_camera, player_id, actor_id)
    return ok and res ~= false
end

local function camera_follow_player(player_id)
    if type(Net.track_with_player_camera) ~= "function" then return false end
    local ok, res = pcall(Net.track_with_player_camera, player_id)
    return ok and res ~= false
end

-- ---------------------------------------------------------------------------
-- Camera safety-net tick
--
-- If some other system (or a stray transfer) resets the camera to follow
-- the player, the player is 5000 units away — the client sees empty space.
-- Re-assert follow-bot every CAMERA_REAPPLY_INTERVAL ticks so we bounce
-- back within ~2 seconds at worst.
-- ---------------------------------------------------------------------------

Net:on("tick", function()
    tick_counter = tick_counter + 1
    if tick_counter % CAMERA_REAPPLY_INTERVAL ~= 0 then return end
    if type(Net.track_with_player_camera) ~= "function" then return end

    for _, r in pairs(active_runners) do
        if r and not r.pending and r.camera_tracking and r.npc then
            pcall(Net.track_with_player_camera, r.player_id, r.npc.bot_id)
        end
    end
end)

-- ---------------------------------------------------------------------------
-- Trigger registration
-- ---------------------------------------------------------------------------

local function register_trigger_for_runner(runner, trigger_obj)
    local props = trigger_obj.custom_properties or {}
    local shape = (trigger_obj.data and trigger_obj.data.type) or "rect"
    local trigger_id = "endless_trigger_" .. tostring(trigger_obj.id)

    local emitter
    if shape == "ellipse" then
        emitter = ezbottriggers.add_radius_trigger(
            runner.instance_id, trigger_obj,
            trigger_obj.width  or 0,
            trigger_obj.height or 0,
            (trigger_obj.width  or 0) / 2,
            (trigger_obj.height or 0) / 2,
            trigger_id)
    else
        emitter = ezbottriggers.add_rectangle_trigger(
            runner.instance_id, trigger_obj,
            trigger_obj.width  or 0,
            trigger_obj.height or 0,
            trigger_id)
    end

    if not emitter then
        print("[endless_runner] could not register trigger "
            .. tostring(trigger_obj.id) .. " in " .. tostring(runner.instance_id))
        return nil
    end

    local target_name = props["Warp To"] or props["Warp Target"]
    local once_raw = props["Once"]
    local once = true
    if once_raw == false or once_raw == "false" or once_raw == 0 then once = false end

    emitter:on("entered", function(event)
        if not event or event.bot_id ~= runner.npc.bot_id then return end
        if once and runner.fired_triggers[trigger_id] then return end
        runner.fired_triggers[trigger_id] = true

        local tx, ty, tz
        if not target_name or target_name == "" then
            tx, ty, tz = runner.spawn_obj.x, runner.spawn_obj.y, runner.spawn_obj.z or 0
        elseif string.lower(tostring(target_name)) == "spawn" then
            tx, ty, tz = runner.spawn_obj.x, runner.spawn_obj.y, runner.spawn_obj.z or 0
        else
            local target_obj = find_object_by_name(runner.instance_id, target_name)
                or find_object_by_id(runner.instance_id, target_name)
            if not target_obj then
                print("[endless_runner] trigger " .. tostring(trigger_obj.id)
                    .. " warp target not found: " .. tostring(target_name))
                return
            end
            tx, ty, tz = target_obj.x, target_obj.y, target_obj.z or 0
        end

        -- Teleport the bot; camera follows on the next frame.
        if runner.npc then
            pcall(Net.move_bot, runner.npc.bot_id, tx, ty, tz)
            runner.npc.x, runner.npc.y, runner.npc.z = tx, ty, tz
        end

        -- Keep player position consistent (no visual effect — camera is on
        -- bot — but keeps state coherent for stop()).
        local off_x = tonumber(runner.offscreen_offset) or 5000
        if runner.warped_offscreen then
            -- Preserve offscreen displacement so a subsequent camera reset
            -- still finds the player far away.
            try_position_only(runner.player_id, tx + off_x, ty + off_x, 0)
        else
            try_position_only(runner.player_id, tx, ty, tz)
        end
    end)

    return emitter
end

local function unregister_runner_triggers(runner)
    if not runner or not runner.triggers then return end
    local area_id = runner.instance_id
    for trigger_id in pairs(runner.triggers) do
        if ezbottriggers.radius_triggers[area_id] then
            ezbottriggers.radius_triggers[area_id][trigger_id] = nil
        end
        if ezbottriggers.rectangle_triggers[area_id] then
            ezbottriggers.rectangle_triggers[area_id][trigger_id] = nil
        end
    end
    runner.triggers = {}
end

-- ---------------------------------------------------------------------------
-- Async body for enter()
-- ---------------------------------------------------------------------------

local function do_enter(player_id, base_area_id, options)
    options = options or {}

    if not player_id then return false, "player_id required" end
    if not base_area_id or base_area_id == "" then
        return false, "base_area_id required"
    end

    log_for(player_id, "enter() begin, base=" .. tostring(base_area_id))

    local origin_area = Net.get_player_area(player_id)
    local origin_pos  = Net.get_player_position(player_id)

    if options.on_prepare then pcall(options.on_prepare, player_id) end

    local should_lock_input = options.lock_input
    if should_lock_input == nil then should_lock_input = true end

    local input_locked = false
    if should_lock_input then
        pcall(Net.lock_player_input, player_id)
        input_locked = true
        log_for(player_id, "input locked")
    end

    local function fail(msg)
        if input_locked then pcall(Net.unlock_player_input, player_id) end
        log_for(player_id, "enter() FAILED: " .. tostring(msg))
        return false, msg
    end

    local preferred_id = options.instance_id
        or (base_area_id .. "_runner_" .. sanitize_id(player_id))

    if not options.instance_id then
        local existing = EzMapInstance.get(preferred_id)
        if existing then
            log_for(player_id, "removing stale instance " .. preferred_id)
            pcall(EzMapInstance.remove, preferred_id)
        end
    end

    log_for(player_id, "cloning base area -> " .. preferred_id)
    local record = EzMapInstance.get(preferred_id)
    if not record then
        record = EzMapInstance.create(base_area_id, preferred_id, {
            host_id    = player_id,
            player_ids = {},
            metadata   = options.metadata,
        })
        if not record then
            return fail("EzMapInstance.create failed (is '" .. base_area_id
                .. "' in Net.list_areas()?)")
        end
    end
    log_for(player_id, "instance created: " .. record.id)

    await(Async.sleep(0))
    local spawn_obj, waited = wait_for_spawn(record.id, 5)
    if not spawn_obj then
        pcall(EzMapInstance.remove, record.id)
        return fail("no '" .. SPAWN_TYPE .. "' object in instance "
            .. tostring(record.id) .. " after " .. tostring(waited) .. " ticks")
    end
    log_for(player_id, "spawn located at "
        .. tostring(spawn_obj.x) .. "," .. tostring(spawn_obj.y))

    local spawn_props = spawn_obj.custom_properties or {}
    local first_wp_id = spawn_props["Next Waypoint 1"] or spawn_props["First Waypoint"]
    if not first_wp_id then
        pcall(EzMapInstance.remove, record.id)
        return fail("spawn object has no 'Next Waypoint 1'")
    end

    log_for(player_id, "copying avatar")
    local entry = AvatarRegistry.get_or_copy(player_id)
    if not entry then
        pcall(EzMapInstance.remove, record.id)
        return fail("AvatarRegistry failed to copy avatar")
    end
    await(Async.sleep(0))

    log_for(player_id, "spawning avatar bot")
    local npc = eznpcs.create_npc_from_paths(
        record.id,
        entry.texture_path,
        entry.animation_path,
        spawn_obj.x, spawn_obj.y, spawn_obj.z or 0,
        spawn_props["Direction"] or "Down",
        {
            asset_name = "avatar_" .. sanitize_id(player_id),
            name       = tostring(player_id) .. "-runner",
            solid      = false,
            warp_in    = false,
            animation  = options.initial_animation or "IDLE_DR",
        }
    )
    if not npc then
        pcall(EzMapInstance.remove, record.id)
        return fail("could not create avatar bot")
    end

    exclude_bot_from_other_players(npc.bot_id, player_id)

    local offscreen_offset = tonumber(options.offscreen_offset) or 5000

    local runner = {
        player_id           = player_id,
        instance_id         = record.id,
        instance_record     = record,
        npc                 = npc,
        spawn_obj           = spawn_obj,
        first_wp_id         = first_wp_id,
        triggers            = {},
        fired_triggers      = {},
        locked_input        = input_locked,
        camera_tracking     = false,
        warped_offscreen    = false,
        offscreen_offset    = offscreen_offset,

        origin_area         = origin_area,
        origin_pos          = origin_pos,
    }

    eznpcs.attach_waypoint_follow(npc, first_wp_id, {
        on_path_complete = function(completed_npc)
            if not options.loop then return end
            local wp = find_object_by_id(record.id, first_wp_id)
            if wp then completed_npc.next_waypoint = wp end
        end,
    })

    local trigger_count = 0
    for _, object_id in ipairs(Net.list_objects(record.id) or {}) do
        local ok, obj = pcall(Net.get_object_by_id, record.id, object_id)
        if ok and obj and obj.type == TRIGGER_TYPE then
            local emitter = register_trigger_for_runner(runner, obj)
            if emitter then
                runner.triggers[tostring(obj.id)] = emitter
                trigger_count = trigger_count + 1
            end
        end
    end
    log_for(player_id, "registered " .. trigger_count .. " trigger(s)")

    await(Async.sleep(0))

    if options.on_prepared then pcall(options.on_prepared, player_id, record) end
    local delay = tonumber(options.pre_warp_delay) or 0
    if delay > 0 then await(Async.sleep(delay)) end

    local slot = active_runners[player_id]
    if slot and slot.cancelled then
        unregister_runner_triggers(runner)
        pcall(eznpcs.remove_npc, npc)
        pcall(EzMapInstance.remove, record.id)
        if input_locked then pcall(Net.unlock_player_input, player_id) end
        return fail("cancelled before warp")
    end

    -- Step 1: warp player into the instance at spawn (this is a transfer,
    -- so it resets the camera — fine, we haven't set follow-bot yet).
    log_for(player_id, "warping into instance " .. record.id)
    if not seamless_warp(player_id, record.id,
        spawn_obj.x, spawn_obj.y, spawn_obj.z or 0) then
        unregister_runner_triggers(runner)
        pcall(eznpcs.remove_npc, npc)
        pcall(EzMapInstance.remove, record.id)
        return fail("seamless_warp failed (Net.transfer_player rejected?)")
    end
    EzMapInstance.register_player(record.id, player_id)

    -- Step 2: yield so the engine commits the transfer and
    -- Net.get_player_area(player_id) returns the instance id. Without
    -- this, the offscreen warp below would see a stale area and issue a
    -- second transfer — which would reset the camera we're about to set.
    await(Async.sleep(0))
    await(Async.sleep(0))
    log_for(player_id, "post-warp area: "
        .. tostring(Net.get_player_area(player_id)))

    -- Step 3: hand the camera to the bot. Player and bot are both at spawn,
    -- so this is visually invisible — no jump. This must happen AFTER the
    -- transfer settled, otherwise the transfer's camera reset wins.
    if options.follow_bot_camera ~= false then
        if camera_follow_actor(player_id, npc.bot_id) then
            runner.camera_tracking = true
            log_for(player_id, "camera following bot via Net.track_with_player_camera")
        else
            log_for(player_id, "WARNING: camera_follow_actor failed — camera stays on player")
        end
    end

    -- Step 4: warp the player offscreen. Use position API ONLY — a transfer
    -- here would reset the camera we just set.
    if options.offscreen ~= false and runner.camera_tracking then
        local off_x = tonumber(options.offscreen_x) or offscreen_offset
        local off_y = tonumber(options.offscreen_y) or offscreen_offset
        local off_z = tonumber(options.offscreen_z) or 0
        local target_x = spawn_obj.x + off_x
        local target_y = spawn_obj.y + off_y
        local target_z = (spawn_obj.z or 0) + off_z

        local position_api = try_position_only(player_id, target_x, target_y, target_z)
        if position_api then
            runner.warped_offscreen = true
            log_for(player_id, "warped player offscreen via Net." .. position_api
                .. " (in-place, camera unaffected)")
        else
            -- Position API unavailable. Fall back to transfer, then re-apply
            -- camera because transfer resets it.
            log_for(player_id, "position API unavailable; falling back to transfer")
            if seamless_warp(player_id, record.id, target_x, target_y, target_z) then
                await(Async.sleep(0))
                await(Async.sleep(0))
                camera_follow_actor(player_id, npc.bot_id)
                runner.warped_offscreen = true
                log_for(player_id, "warped player offscreen via transfer; camera re-applied")
            else
                log_for(player_id, "offscreen warp failed; player stays at spawn")
            end
        end
    elseif options.offscreen ~= false then
        log_for(player_id, "offscreen warp skipped (camera not tracking bot)")
    end

    active_runners[player_id] = runner
    log_for(player_id, "enter() OK — runner active")

    if options.on_warped then pcall(options.on_warped, player_id, runner) end
    return true, runner
end

-- ---------------------------------------------------------------------------
-- Public API
-- ---------------------------------------------------------------------------

function EndlessRunner.enter(player_id, base_area_id, options)
    if type(base_area_id) == "table" then
        options = base_area_id
        base_area_id = nil
    end
    base_area_id = base_area_id or DEFAULT_BASE_AREA_ID

    if not player_id then
        return async(function() return false, "player_id required" end)
    end
    if active_runners[player_id] then
        return async(function()
            return false, "runner already active for player " .. tostring(player_id)
        end)
    end

    clear_log_for(player_id)
    active_runners[player_id] = {
        pending   = true,
        cancelled = false,
        player_id = player_id,
    }

    return async(function()
        local ok, result = do_enter(player_id, base_area_id, options)
        if not ok then
            local slot = active_runners[player_id]
            if slot and slot.pending then
                active_runners[player_id] = nil
            end
        end
        return ok, result
    end)
end

function EndlessRunner.stop(player_id, options)
    local runner = active_runners[player_id]
    if not runner then return false end
    options = options or {}

    if runner.pending then
        runner.cancelled = true
        return true
    end

    -- 1. Hand camera back to player FIRST (before removing the bot, so
    --    the engine is never asked to follow a dangling actor id).
    if runner.camera_tracking then
        if camera_follow_player(player_id) then
            log_for(player_id, "camera restored to player")
        else
            log_for(player_id, "camera restore failed")
        end
        runner.camera_tracking = false
    end

    -- 2. Unregister triggers before any warp.
    unregister_runner_triggers(runner)

    -- 3. Remove the bot.
    if runner.npc then
        eznpcs.remove_npc(runner.npc)
        runner.npc = nil
    end

    -- 4. Restore player position if requested.
    local should_restore = options.restore_position or options.remove_instance
    if should_restore and runner.origin_area and runner.origin_pos then
        local ok = pcall(Net.transfer_player, player_id, runner.origin_area, false,
            runner.origin_pos.x, runner.origin_pos.y, runner.origin_pos.z or 0)
        if ok then
            log_for(player_id, "restored player to " .. tostring(runner.origin_area)
                .. " (" .. tostring(runner.origin_pos.x) .. ","
                .. tostring(runner.origin_pos.y) .. ")")
        else
            log_for(player_id, "could not restore player position on stop")
        end
    end

    -- 5. Unlock input.
    if runner.locked_input then
        pcall(Net.unlock_player_input, player_id)
        runner.locked_input = false
    end

    -- 6. Optionally destroy the instance.
    if options.remove_instance and runner.instance_record then
        EzMapInstance.remove(runner.instance_id)
    end

    active_runners[player_id] = nil
    clear_log_for(player_id)
    return true
end

function EndlessRunner.is_active(player_id)
    local r = active_runners[player_id]
    return r ~= nil and not r.pending
end

function EndlessRunner.get(player_id)
    local r = active_runners[player_id]
    if r and r.pending then return nil end
    return r
end

function EndlessRunner.list()
    local out = {}
    for pid, r in pairs(active_runners) do
        if not r.pending then out[pid] = r end
    end
    return out
end

-- ---------------------------------------------------------------------------
-- custom_warp event handler
-- ---------------------------------------------------------------------------

local function pick(...)
    for i = 1, select("#", ...) do
        local v = select(i, ...)
        if v ~= nil then return v end
    end
    return nil
end

function EndlessRunner.handle_custom_warp(event, options)
    options = options or {}

    if type(event) ~= "table" then return false end

    local player_id = pick(event.player_id, event.player, event.pid)
    if not player_id then return false end

    local base_area_ids = options.base_area_ids
        or { options.base_area_id or DEFAULT_BASE_AREA_ID }
    local base_set = {}
    for _, id in ipairs(base_area_ids) do base_set[id] = true end

    local props = event.properties or event.custom_properties or {}
    local destination = pick(
        event.destination,
        event.target_area,
        event.to_area,
        event.target,
        props["Area"],
        props["Target"],
        props["Destination"],
        props["Warp To"]
    )

    local explicit = false
    if event.handler == "endless_runner"
        or event.handler_id == "endless_runner"
        or props["Handler"] == "endless_runner"
        or props["Endless Runner"] == true
        or props["Endless Runner"] == "true"
    then
        explicit = true
    end

    if not explicit and (not destination or not base_set[destination]) then
        return false
    end

    if active_runners[player_id] then
        log_for(player_id, "custom_warp ignored — runner already active")
        if event.cancel and type(event.cancel) == "function" then
            pcall(event.cancel, event)
        end
        event.cancelled = true
        event.handled   = true
        return true
    end

    log_for(player_id, "custom_warp → starting runner (destination="
        .. tostring(destination) .. ")")

    if event.cancel and type(event.cancel) == "function" then
        pcall(event.cancel, event)
    end
    event.cancelled = true
    event.handled   = true

    local ex  = tonumber(event.x)
    local ey  = tonumber(event.y)
    local ez  = tonumber(event.z) or 0
    local edest = destination

    async(function()
        local enter_opts = options.enter_options or {}
        local ok, result = await(EndlessRunner.enter(
            player_id, base_area_ids[1], enter_opts))
        if ok then return end

        print("[endless_runner] handle_custom_warp: enter() failed for "
            .. tostring(player_id) .. ": " .. tostring(result))

        if options.fallback_to_vanilla
            and edest and ex and ey then
            log_for(player_id, "falling back to vanilla warp -> "
                .. tostring(edest))
            pcall(Net.transfer_player, player_id, edest, true, ex, ey, ez)
        end
    end)

    return true
end

function EndlessRunner.register_custom_warp(wire_fn, options)
    if type(wire_fn) ~= "function" then
        error("EndlessRunner.register_custom_warp: wire_fn must be a function")
    end

    local handler = function(event)
        return EndlessRunner.handle_custom_warp(event, options)
    end

    local unwire = wire_fn(handler)
    if type(unwire) == "function" then
        return unwire
    end
    return nil
end

-- ---------------------------------------------------------------------------
-- Area watcher
-- ---------------------------------------------------------------------------

local function normalize_watch_targets(base_area_ids)
    if type(base_area_ids) == "string" then
        print("[endless_runner] watch_areas expected a table, got a string; "
            .. "wrapping '" .. base_area_ids .. "' in { }")
        base_area_ids = { base_area_ids }
    end
    if type(base_area_ids) ~= "table" then
        print("[endless_runner] watch_areas requires a table of area ids")
        return nil
    end

    local known_areas = {}
    for _, id in ipairs(Net.list_areas() or {}) do known_areas[id] = true end

    local target = {}
    local missing = {}
    for _, id in ipairs(base_area_ids) do
        if not known_areas[id] then
            missing[#missing + 1] = tostring(id)
        end
        target[id] = true
    end

    if #missing > 0 then
        print("[endless_runner] WARNING: these watched area ids are NOT in "
            .. "Net.list_areas(): " .. table.concat(missing, ", "))
        print("[endless_runner]  registered area ids are:")
        for _, id in ipairs(Net.list_areas() or {}) do
            print("[endless_runner]    " .. tostring(id))
        end
    end

    return target
end

function EndlessRunner.watch_areas(base_area_ids, options)
    local target = normalize_watch_targets(base_area_ids)
    if not target then return end
    options = options or {}

    Net:on("tick", function()
        for _, area_id in ipairs(Net.list_areas() or {}) do
            if target[area_id] then
                local players = Net.list_players(area_id) or {}
                for _, pid in ipairs(players) do
                    if not active_runners[pid] then
                        log_for(pid, "detected in base area '" .. tostring(area_id)
                            .. "', starting runner")
                        async(function()
                            await(EndlessRunner.enter(pid, area_id, options))
                        end)
                    end
                end
            end
        end
    end)
end

function EndlessRunner.setup(options)
    options = options or {}
    local base = options.base_area_id or DEFAULT_BASE_AREA_ID

    local function registered(id)
        for _, a in ipairs(Net.list_areas() or {}) do
            if a == id then return true end
        end
        return false
    end

    if not registered(base) then
        local alt = base:gsub("%.tmx$", "")
        if alt ~= base and registered(alt) then
            print("[endless_runner] auto-corrected base area id '"
                .. base .. "' -> '" .. alt .. "'")
            base = alt
        else
            local alt2 = base .. ".tmx"
            if registered(alt2) then
                print("[endless_runner] auto-corrected base area id '"
                    .. base .. "' -> '" .. alt2 .. "'")
                base = alt2
            end
        end
    end

    if not registered(base) then
        print("[endless_runner] ERROR: base area '" .. tostring(base)
            .. "' is not registered. Available areas:")
        for _, a in ipairs(Net.list_areas() or {}) do
            print("[endless_runner]   " .. tostring(a))
        end
        return nil
    end

    print("[endless_runner] setup(): watching '" .. base .. "'")

    if type(Net.track_with_player_camera) == "function" then
        print("[endless_runner] camera ready: Net.track_with_player_camera")
    else
        print("[endless_runner] WARNING: Net.track_with_player_camera is "
            .. "unavailable. Camera-follow and offscreen mode disabled.")
    end

    -- Report which position API the offscreen warp will use.
    local pos_api
    for _, name in ipairs(POSITION_APIS) do
        if type(Net[name]) == "function" then pos_api = name; break end
    end
    if pos_api then
        print("[endless_runner] offscreen warp will use Net." .. pos_api)
    else
        print("[endless_runner] WARNING: no position API found; offscreen "
            .. "warp will fall back to transfer_player (may reset camera)")
    end

    EndlessRunner.watch_areas({ base }, options.enter_options or {})
    return base
end

-- ---------------------------------------------------------------------------
-- Diagnostics
-- ---------------------------------------------------------------------------

function EndlessRunner.dump_net_functions(filter)
    print("======== Net.* functions matching '" .. tostring(filter or "") .. "' ========")
    local names = {}
    for k, v in pairs(Net) do
        if type(v) == "function" then
            local lower = string.lower(k)
            if not filter or filter == ""
                or string.find(lower, string.lower(filter), 1, true) then
                names[#names + 1] = k
            end
        end
    end
    table.sort(names)
    for _, name in ipairs(names) do
        print("  Net." .. name)
    end
    print("======== " .. #names .. " result(s) ========")
    return names
end

function EndlessRunner.diagnose(player_id)
    print("======== EndlessRunner.diagnose ========")
    print("player_id: " .. tostring(player_id))
    print("current area: " .. tostring(Net.get_player_area(player_id)))
    local pos = Net.get_player_position(player_id)
    if pos then
        print("current pos: " .. tostring(pos.x) .. "," .. tostring(pos.y)
            .. "," .. tostring(pos.z))
    end

    local r = active_runners[player_id]
    if not r then
        print("runner slot: (none)")
    elseif r.pending then
        print("runner slot: PENDING")
    else
        print("runner slot: ACTIVE")
        print("  instance_id       : " .. tostring(r.instance_id))
        print("  bot_id            : " .. tostring(r.npc and r.npc.bot_id))
        print("  camera_tracking   : " .. tostring(r.camera_tracking))
        print("  warped_offscreen  : " .. tostring(r.warped_offscreen))
    end
    print("========================================")
end

-- ---------------------------------------------------------------------------
-- Lifecycle
-- ---------------------------------------------------------------------------

Net:on("player_disconnect", function(event)
    local pid = event.player_id
    if pid and active_runners[pid] then
        pcall(EndlessRunner.stop, pid, { remove_instance = true })
    end
end)

return EndlessRunner