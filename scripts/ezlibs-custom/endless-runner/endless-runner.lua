local LegacyCapture = require("scripts/player-control/legacy-capture")
--[[
endless-runner.lua — Cinematic endless-runner with floors, HP, and combat.

Floors
------
The run is divided into a "floor plan": an ordered list of floor
definitions passed via `enter_options.floor_plan`. When a floor's
`encounters` count is reached, `advance_floor` runs and moves the player
to the next floor's instance. If `floor_plan` is exhausted, the run ends.

Choice Waypoints
----------------
A choice waypoint is EITHER:

    type = "Waypoint"      -- recommended
    custom_properties["Is Choice"] = true
    custom_properties["Option N"]    = label
    custom_properties["Target N"]    = object id of branch N
    custom_properties["Next Waypoint 1"] = fallback object id (required)
    custom_properties["Prompt"]          = optional prompt text
    custom_properties["Default Option"]  = optional 1-based index
    custom_properties["Timeout"]         = optional seconds
    custom_properties["Wait Animation"]  = optional pose
    custom_properties["Direction"]       = optional facing

OR the legacy form:

    type = "Choice Waypoint"
    custom_properties["Option N"] / ["Target N"] as above

On resolution we set `npc.next_waypoint` to the chosen target. If the
chosen target can't be resolved (missing from the instance, wrong type,
stale ID), we fall back to the map's `Next Waypoint 1`, then to the
runner's entry waypoint, and ALWAYS release the bot's pose hold so the
bot can keep moving. A choice can never leave the bot permanently
paused.

Encounter flow
--------------
The BASE area's encounters/<base_area>.lua uses the same section format as
Nebulous Liberations: .encounters, .bosses, and .special_encounters.
Each floor may choose `encounter_section = "bosses"` etc. The legacy
`special = true` flag defaults to .bosses. A Tiled trigger may override with
`Encounter Category`. Optional `Encounter 1` / `Encounter 2` names restrict
selection only when those names exist in the active section; otherwise the
section's weighted pool is used. `Pick Mode` supports first/cycle/random.
No encounter definition is duplicated in a cloned area.

Every encounter fires via `endless_runner_encounter_triggered`:
fade to black → pause bot → battle → HP update → counter → resume
(fade in) or advance floor.

HP
--
Tracked in runner state (`runner.hp` / `runner.max_hp`) and mirrored to
Net HP APIs if available. Override with `enter_options.hp_hooks`.

Events (ezbus)
--------------
    endless_runner_choice_requested / changed / selected / cancelled
    endless_runner_encounter_started / finished
    endless_runner_floor_started / completed
    endless_runner_reward
    endless_runner_monies_awarded / reward_failed
    endless_runner_run_completed / ended
    endless_runner_hp_changed
--]]

local EzMapInstance   = require("scripts/ezlibs-scripts/ezmapinstance")
local ezmemory       = require("scripts/ezlibs-scripts/ezmemory")
local eznpcs          = require("scripts/ezlibs-scripts/eznpcs/eznpcs")
local ezbottriggers   = require("scripts/ezlibs-scripts/eztriggers/ezbottriggers")
local AvatarRegistry  = require("scripts/avatar_registry/main")

-- Dedicated JSONL trace for server-side battle handoff. Only checkpoint events
-- are logged here, never every tick. Flush each checkpoint immediately so a
-- client disconnect during package initialization leaves a useful last step.
local RunnerLog = require("scripts/logger/logger").register("endless-runner", {
    console = false,
}):register_subsystem("battle-handoff")
local function runner_checkpoint(player_id, stage, fields)
    local data = { player_id = tostring(player_id), stage = tostring(stage) }
    for key, value in pairs(fields or {}) do
        -- Keep log payload scalar and safe for the installed ezlogger JSON API.
        if type(value) == "string" or type(value) == "number"
            or type(value) == "boolean" then
            data[key] = value
        elseif value ~= nil then
            data[key] = tostring(value)
        end
    end
    local ok, err = pcall(function()
        RunnerLog:info_data("[endless-runner] " .. tostring(stage), data)
        RunnerLog:forceFlush()
    end)
    if not ok then
        print("[endless_runner] diagnostic log failed: " .. tostring(err))
    end
end

local games
do
    local ok, mod = pcall(require, "scripts/net-games/main")
    if ok and type(mod) == "table" then games = mod end
end

local TextLayout
do
    local ok, mod = pcall(require, "scripts/displayer/text-layout")
    if ok and type(mod) == "table" then TextLayout = mod end
end

local InputAPI
do
    local ok, mod = pcall(require, "scripts/input-controller/main")
    if ok and type(mod) == "table" then InputAPI = mod end
end

local EndlessRunner = {}

local DEFAULT_BASE_AREA_ID = "endless-runner"

local SPAWN_TYPE               = "Endless Runner Spawn"
local TRIGGER_TYPE             = "Endless Runner Trigger"
local RECT_ENCOUNTER_TYPE      = "Runner Rectangle Encounter"
local RADIUS_ENCOUNTER_TYPE    = "Runner Radius Encounter"
local CHOICE_WAYPOINT_TYPE     = "Choice Waypoint"   -- legacy type name

local POSITION_APIS = {
    "set_player_position",
    "warp_player_position",
    "teleport_player_position",
}

local CAMERA_REAPPLY_INTERVAL = 60
local CAMERA_DEFEND_TICKS     = 60
local CHOICE_INPUT_RELOCK_TICKS = 30

-- How long after `opened_at` a choice should be force-resolved as a safety
-- net if it hasn't already (in case input claim failed silently, or an
-- unrecoverable target-not-found trap left the bot stuck).
local CHOICE_HARD_TIMEOUT = 35

local ENCOUNTER_FADE_DURATION = 0.8
local ENCOUNTER_FADE_WAIT     = 0.85

local CHOICE_UI = {
    SCREEN_WIDTH       = 240,
    SCREEN_HEIGHT      = 160,
    PROMPT_Y           = 15,
    OPTION_START_Y     = 55,
    OPTION_SPACING     = 32,
    CURSOR_Y_ABOVE     = 18,
    CURSOR_SCALE       = 1.0,
    TEXT_SCALE         = 2.0,
    PROMPT_TEXT_SCALE  = 2.0,
    CURSOR_STATE       = "CURSOR_DOWN",
    CURSOR_TEXTURE     = "/server/assets/net-games/cursors/vibrant_text_cursor.png",
    CURSOR_ANIMATION   = "/server/assets/net-games/cursors/text_cursor.animation",
    CURSOR_SFX         = "/server/assets/net-games/sfx/cursor_move.ogg",
    CURSOR_BOB_TICKS   = 2,
    CURSOR_BOB_OFFSET  = 3,
    CURSOR_SPRITE_W    = 16,
}

local CHOICE_ACTIONS = {
    "Up", "Down", "Left", "Right", "Confirm", "Cancel",
}

local tick_counter = 0
local active_runners = {}
local last_logged_state = {}
-- Base-area entry watchers are registered once; completed runs do not
-- immediately restart just because stop() restores the player to that area.
local watched_area_options = {}
local watcher_registered = false
local watch_suppressed_until_leave = {}
-- ezwarps emits a `warp` event *after* transferring the player. It includes
-- the position sampled BEFORE the transfer, so this cache allows the area
-- watcher to restore the actual departure area rather than the Runner lobby.
local pending_entry_origins = {}
local ENTRY_ORIGIN_MAX_AGE_SECONDS = 15
-- Cancel any queued next-tick camera restoration if the player disconnects
-- (or a newer run/cleanup replaces the previous task).
local pending_camera_restore_tokens = {}

local function log_for(player_id, message)
    local key = tostring(player_id) .. "|" .. message
    if last_logged_state[key] then return end
    last_logged_state[key] = true
    print("[endless_runner] " .. tostring(player_id) .. " " .. message)
end

-- Capture only warps into configured Runner entry areas. No other warp
-- behavior is changed; these snapshots are consumed once by do_enter().
do
    local ok, ezbus = pcall(require, "scripts/ezlibs-scripts/ezbus")
    if ok and ezbus and type(ezbus.on) == "function" then
        ezbus:on("warp", function(event)
            if type(event) ~= "table" then return end
            local pid = event.player_id
            local to_area = event.to_area
            local from_area = event.from_area
            local p = event.from_position
            if not pid or not watched_area_options[to_area]
                or type(from_area) ~= "string" or from_area == ""
                or from_area == to_area or type(p) ~= "table" then
                return
            end
            local x, y, z = tonumber(p.x), tonumber(p.y), tonumber(p.z) or 0
            if not x or not y then return end
            pending_entry_origins[pid] = {
                to_area = to_area,
                from_area = from_area,
                position = { x = x, y = y, z = z },
                from_warp_object_id = event.from_warp_object_id,
                captured_at = os.time(),
            }
            runner_checkpoint(pid, "entry_origin_captured", {
                from_area = from_area, to_area = to_area,
                x = x, y = y, z = z,
            })
        end)
    end
end

local function clear_log_for(player_id)
    local prefix = tostring(player_id) .. "|"
    for k in pairs(last_logged_state) do
        if k:sub(1, #prefix) == prefix then
            last_logged_state[k] = nil
        end
    end
end

local function emit_bus(event_name, payload)
    local ok, ezbus = pcall(require, "scripts/ezlibs-scripts/ezbus")
    if ok and ezbus and type(ezbus.emit) == "function" then
        pcall(ezbus.emit, ezbus, event_name, payload)
    end
end

-- Observe the shared battle reward result so money totals and telemetry stay
-- consistent with what ezencounters actually awarded during battle_results.
do
    local ok, ezbus = pcall(require, "scripts/ezlibs-scripts/ezbus")
    if ok and ezbus and type(ezbus.on) == "function" then
        ezbus:on("encounter_finished", function(payload)
            if not payload or payload.managed ~= true then return end
            local runner = active_runners[payload.player_id]
            if not runner or not runner.encounter_in_progress then return end
            local base = runner.instance_record and runner.instance_record.base_area_id
            if payload.area_id ~= nil and tostring(payload.area_id) ~= tostring(base) then
                return
            end
            runner.last_encounter_rewards = payload.rewards
            runner.last_encounter_reward_totals = payload.reward_totals
            local amount = payload.reward_totals
                and tonumber(payload.reward_totals.money) or 0
            if amount > 0 then
                runner.monies_earned = (runner.monies_earned or 0) + amount
                emit_bus("endless_runner_monies_awarded", {
                    player_id = payload.player_id,
                    amount = amount,
                    new_balance = Net.get_player_money
                        and Net.get_player_money(payload.player_id) or nil,
                    source = "encounter",
                    encounter_name = payload.encounter_info and payload.encounter_info.name,
                    floor_index = runner.current_floor_index,
                    run_total = runner.monies_earned,
                })
            end
        end)
    end
end


-- ---------------------------------------------------------------------------
-- Input lock
-- ---------------------------------------------------------------------------

local function ensure_input_locked(player_id, runner, reason)
    if not runner or not runner.locked_input then return false end
    if type(LegacyCapture.lock) ~= "function" then return false end
    local ok = pcall(LegacyCapture.lock, player_id, "ezlibs-custom/endless-runner/endless-runner")
    if ok and reason then
        log_for(player_id, "input re-locked (" .. tostring(reason) .. ")")
    end
    return ok
end

-- ---------------------------------------------------------------------------
-- HP hooks
-- ---------------------------------------------------------------------------

local DEFAULT_HP_HOOKS = {
    get = function(pid)
        if type(Net.get_player_health) == "function" then
            local ok, hp = pcall(Net.get_player_health, pid)
            if ok and type(hp) == "number" then return hp end
        end
        return nil
    end,
    set = function(pid, hp)
        if type(Net.set_player_health) == "function" then
            return pcall(Net.set_player_health, pid, hp)
        end
        return false
    end,
    get_max = function(pid)
        if type(Net.get_player_max_health) == "function" then
            local ok, hp = pcall(Net.get_player_max_health, pid)
            if ok and type(hp) == "number" then return hp end
        end
        return nil
    end,
    set_max = function(pid, hp)
        if type(Net.set_player_max_health) == "function" then
            return pcall(Net.set_player_max_health, pid, hp)
        end
        return false
    end,
}

-- ---------------------------------------------------------------------------
-- Object lookup (with type-coercion fallback for engine quirks)
-- ---------------------------------------------------------------------------

local function find_object_by_type(area_id, type_name)
    for _, object_id in ipairs(Net.list_objects(area_id) or {}) do
        local ok, obj = pcall(Net.get_object_by_id, area_id, object_id)
        if ok and obj and obj.type == type_name then return obj end
    end
    return nil
end

local function find_object_by_name(area_id, name)
    for _, object_id in ipairs(Net.list_objects(area_id) or {}) do
        local ok, obj = pcall(Net.get_object_by_id, area_id, object_id)
        if ok and obj and obj.name == name then return obj end
    end
    return nil
end

local function find_object_by_id(area_id, object_id)
    if not area_id or not object_id then return nil end
    local ok, obj = pcall(Net.get_object_by_id, area_id, object_id)
    if ok and obj then return obj end
    -- Engine type mismatch: try the other type. Tiled object refs sometimes
    -- deserialize as strings while the engine wants numbers, or vice versa.
    if type(object_id) ~= "string" then
        ok, obj = pcall(Net.get_object_by_id, area_id, tostring(object_id))
        if ok and obj then return obj end
    end
    local as_num = tonumber(object_id)
    if as_num and as_num ~= object_id then
        ok, obj = pcall(Net.get_object_by_id, area_id, as_num)
        if ok and obj then return obj end
    end
    return nil
end

-- ---------------------------------------------------------------------------
-- Return placement after leaving a Runner instance
-- ---------------------------------------------------------------------------
-- The exact departure coordinates from a Custom Warp can still be inside its
-- trigger. After a completed/aborted run, use a nearby terrain tile center
-- outside the surrounding warp geometry instead. This does NOT change the
-- saved departure snapshot, the return-warp guard, or entry behavior.
local RETURN_TILE_MIN_DISTANCE_SQ = 2.0 * 2.0
local RETURN_TILE_MAX_SEARCH_RADIUS = 5
local RETURN_WARP_CLEARANCE = 0.75

local RETURN_WARP_TYPES = {
    ["Custom Warp"] = true,
    ["Radius Warp"] = true,
    ["Interact Warp"] = true,
    ["Server Warp"] = true,
    ["Home Warp"] = true,
}

local function return_tile_has_terrain(area_id, x, y, z)
    if type(Net.get_tile) ~= "function" then return false end
    local ok, tile = pcall(Net.get_tile, area_id, x, y, z)
    return ok and type(tile) == "table"
        and type(tile.gid) == "number" and tile.gid > 0
end

local function return_tile_overlaps_warp(x, y, z, objects)
    for _, obj in ipairs(objects) do
        if tonumber(obj.z) == nil or (tonumber(obj.z) or 0) == z then
            local ox, oy = tonumber(obj.x), tonumber(obj.y)
            if ox and oy then
                local clearance = RETURN_WARP_CLEARANCE
                local props = obj.custom_properties or {}
                if obj.type == "Radius Warp" then
                    local radius = tonumber(props["Activation Radius"])
                    if radius and radius > 0 then
                        local dx, dy = x - ox, y - oy
                        if dx * dx + dy * dy <= (radius + clearance) ^ 2 then
                            return true
                        end
                    end
                else
                    local w, h = tonumber(obj.width) or 0, tonumber(obj.height) or 0
                    if x >= ox - clearance and x <= ox + w + clearance
                        and y >= oy - clearance and y <= oy + h + clearance then
                        return true
                    end
                end
            end
        end
    end
    return false
end

local function choose_runner_return_position(area_id, origin_pos, entry_warp_id)
    local x, y = tonumber(origin_pos.x), tonumber(origin_pos.y)
    local z = tonumber(origin_pos.z) or 0
    if not x or not y or not entry_warp_id then
        return origin_pos, "no_warp_origin"
    end

    -- Do not guess a position if the original warp is no longer available.
    -- The existing per-player warp guard will still protect the old position.
    local source_warp = find_object_by_id(area_id, entry_warp_id)
    if not source_warp then return origin_pos, "warp_not_found" end

    local warp_objects = {}
    local ok_list, ids = pcall(Net.list_objects, area_id)
    if not ok_list or type(ids) ~= "table" then
        return origin_pos, "objects_unavailable"
    end
    for _, id in ipairs(ids) do
        local obj = find_object_by_id(area_id, id)
        if obj and RETURN_WARP_TYPES[obj.type] then
            warp_objects[#warp_objects + 1] = obj
        end
    end
    -- Some maps may not return the source warp from list_objects. Always
    -- consider the specific triggering warp when screening candidates.
    local source_listed = false
    for _, obj in ipairs(warp_objects) do
        if tostring(obj.id) == tostring(entry_warp_id) then
            source_listed = true
            break
        end
    end
    if not source_listed then
        warp_objects[#warp_objects + 1] = source_warp
    end

    local tile_x, tile_y = math.floor(x), math.floor(y)
    for radius = 2, RETURN_TILE_MAX_SEARCH_RADIUS do
        local best, best_score
        for dy = -radius, radius do
            for dx = -radius, radius do
                if math.max(math.abs(dx), math.abs(dy)) == radius then
                    local cx, cy = tile_x + dx + 0.5, tile_y + dy + 0.5
                    local ox, oy = cx - x, cy - y
                    local distance_sq = ox * ox + oy * oy
                    if distance_sq >= RETURN_TILE_MIN_DISTANCE_SQ
                        and return_tile_has_terrain(area_id, cx, cy, z)
                        and not return_tile_overlaps_warp(cx, cy, z, warp_objects) then
                        -- Favor the closest safe tile center to the original
                        -- departure point; iteration makes ties deterministic.
                        if not best_score or distance_sq < best_score then
                            best = { x = cx, y = cy, z = z }
                            best_score = distance_sq
                        end
                    end
                end
            end
        end
        if best then return best, "nearby_tile" end
    end

    -- Never return an unverified position outside the map. Fall back to
    -- the exact recorded origin plus the existing entrance-warp guard.
    return origin_pos, "no_terrain_candidate"
end

--- Return true if `obj` should be treated as a choice waypoint.
--- Supports both the legacy `type = "Choice Waypoint"` form and the newer
--- `type = "Waypoint"` + `Is Choice = true` form.
local function is_choice_waypoint(obj)
    if type(obj) ~= "table" then return false end
    if obj.type == CHOICE_WAYPOINT_TYPE then return true end
    if obj.type == "Waypoint" then
        local props = obj.custom_properties or {}
        local v = props["Is Choice"]
        return v == true or v == "true" or v == 1
    end
    return false
end

local function resolve_object_ref(ref_str, runner)
    if not ref_str or ref_str == "" then return nil end
    ref_str = tostring(ref_str)
    if string.lower(ref_str) == "spawn" then return runner.spawn_obj end
    local inst_ref = ref_str:match("^%$instance[:./](.+)$")
    if inst_ref then return find_object_by_id(runner.instance_id, inst_ref) end
    local base_ref = ref_str:match("^%$base[:./](.+)$")
    if base_ref then
        local base_id = runner.instance_record and runner.instance_record.base_area_id
        if base_id then return find_object_by_id(base_id, base_ref) end
        return nil
    end
    local area_name, obj_id = ref_str:match("^%$area[:./]([^:./]+)[:./](.+)$")
    if area_name and obj_id then return find_object_by_id(area_name, obj_id) end
    local obj = find_object_by_id(runner.instance_id, ref_str)
    if obj then return obj end
    return find_object_by_name(runner.instance_id, ref_str)
end

-- ---------------------------------------------------------------------------
-- Encounter / choice option extraction
-- ---------------------------------------------------------------------------

local function extract_encounter_list(props)
    if type(props) ~= "table" then return {} end
    local encs = props["Encounters"]
    if type(encs) == "table" then
        local out = {}
        for _, v in ipairs(encs) do
            if v and tostring(v) ~= "" then out[#out + 1] = tostring(v) end
        end
        if #out > 0 then return out end
    end
    local out = {}
    local i = 1
    while true do
        local v = props["Encounter " .. i]
        if v == nil then break end
        if tostring(v) ~= "" then out[#out + 1] = tostring(v) end
        i = i + 1
    end
    if #out > 0 then return out end
    local single = props["Encounter"]
    if single and tostring(single) ~= "" then return { tostring(single) } end
    local name = props["Name"]
    if name and tostring(name) ~= "" then return { tostring(name) } end
    return {}
end

local function extract_choice_options(waypoint, area_id)
    local props = waypoint.custom_properties or {}
    local options = {}
    local i = 1
    while true do
        local label = props["Option " .. i]
        local target_ref = props["Target " .. i]
        if label == nil and target_ref == nil then break end
        if label and tostring(label) ~= "" then
            local target_obj = nil
            local target_id = nil
            if target_ref and tostring(target_ref) ~= "" then
                target_id = tostring(target_ref)
                target_obj = find_object_by_id(area_id, target_id)
                if not target_obj then
                    print("[endless_runner] extract_choice_options: Target " .. i
                        .. "=" .. tostring(target_ref) .. " not found in "
                        .. tostring(area_id))
                end
            end
            options[#options + 1] = {
                index = i, label = tostring(label),
                target_id = target_id, target_obj = target_obj,
            }
        end
        i = i + 1
    end
    return options
end

-- ---------------------------------------------------------------------------
-- Warp / position
-- ---------------------------------------------------------------------------

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
    end
    return false
end

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
        if i < max_ticks then await(Async.sleep(0)) end
    end
    return nil, max_ticks
end

local function camera_follow_actor(player_id, actor_id)
    if type(Net.track_with_player_camera) ~= "function" then return false end
    local ok, res = pcall(Net.track_with_player_camera, player_id, actor_id)
    return ok and res ~= false
end

-- Net.get_player_area throws for disconnected players. Query safely before
-- performing any camera work, including delayed cleanup callbacks.
local function connected_player_area(player_id)
    if type(Net.get_player_area) ~= "function" then return nil end
    local ok, area = pcall(Net.get_player_area, player_id)
    if not ok then return nil end
    return area
end

-- Match FootBomb and the shared CameraController cleanup sequence:
-- release any camera lock before asking the camera to follow the player.
local function camera_follow_player(player_id)
    if not connected_player_area(player_id) then return false end
    if type(Net.unlock_player_camera) == "function" then
        local unlocked, result = pcall(Net.unlock_player_camera, player_id)
        if not unlocked or result == false then return false end
    end
    if type(Net.track_with_player_camera) ~= "function" then return false end
    local ok, res = pcall(Net.track_with_player_camera, player_id)
    return ok and res ~= false
end

local function fade_to_black(player_id)
    if type(Net.fade_player_camera) ~= "function" then return end
    pcall(Net.fade_player_camera, player_id, { r = 0, g = 0, b = 0, a = 255 },
        ENCOUNTER_FADE_DURATION)
end

local function fade_to_clear(player_id)
    if type(Net.fade_player_camera) ~= "function" then return end
    pcall(Net.fade_player_camera, player_id, { r = 0, g = 0, b = 0, a = 0 },
        ENCOUNTER_FADE_DURATION)
end

-- ---------------------------------------------------------------------------
-- Camera defender + safety net
-- ---------------------------------------------------------------------------

local function defend_camera_for(player_id, runner, ticks)
    ticks = ticks or CAMERA_DEFEND_TICKS
    if type(Net.track_with_player_camera) ~= "function" then return end
    async(function()
        for i = 1, ticks do
            local r = active_runners[player_id]
            if r ~= runner or not r.npc then return end
            if not r.camera_tracking then return end
            if not (Net.is_player_battling and Net.is_player_battling(player_id)) then
                pcall(Net.track_with_player_camera, player_id, r.npc.bot_id)
            end
            await(Async.sleep(0))
        end
        if active_runners[player_id] == runner then
            log_for(player_id, "camera defender finished after " .. ticks .. " ticks")
        end
    end)
end

Net:on("tick", function()
    tick_counter = tick_counter + 1
    if tick_counter % CAMERA_REAPPLY_INTERVAL ~= 0 then return end
    for _, r in pairs(active_runners) do
        if r and not r.pending then
            if r.camera_tracking and r.npc
                and type(Net.track_with_player_camera) == "function"
                and not (Net.is_player_battling and Net.is_player_battling(r.player_id)) then
                pcall(Net.track_with_player_camera, r.player_id, r.npc.bot_id)
            end
            if r.locked_input then
                ensure_input_locked(r.player_id, r, "safety-net")
            end
        end
    end
end)

-- ---------------------------------------------------------------------------
-- HP helpers
-- ---------------------------------------------------------------------------

local function runner_apply_hp(runner, new_hp)
    if not runner or type(new_hp) ~= "number" then return false end
    if new_hp < 0 then new_hp = 0 end
    if runner.max_hp and new_hp > runner.max_hp then new_hp = runner.max_hp end
    local previous = runner.hp
    runner.hp = new_hp
    if runner.hp_hooks and type(runner.hp_hooks.set) == "function" then
        pcall(runner.hp_hooks.set, runner.player_id, new_hp)
    end
    if previous ~= new_hp then
        emit_bus("endless_runner_hp_changed", {
            player_id = runner.player_id, hp = new_hp,
            max_hp = runner.max_hp, previous_hp = previous,
        })
    end
    return true
end

local function runner_heal(runner, amount)
    if not runner or type(amount) ~= "number" or amount <= 0 then return end
    runner_apply_hp(runner, (runner.hp or 0) + amount)
end

-- ---------------------------------------------------------------------------
-- Choice emit + UI
-- ---------------------------------------------------------------------------

local function emit_choice_event(event_name, runner, extra)
    local state = runner.choice_state
    if not state then return end
    local payload = {
        player_id = runner.player_id, instance_id = runner.instance_id,
        waypoint_id = state.waypoint_id,
        waypoint_name = state.waypoint and state.waypoint.name,
        waypoint_x = state.waypoint and state.waypoint.x,
        waypoint_y = state.waypoint and state.waypoint.y,
        waypoint_z = state.waypoint and (state.waypoint.z or 0),
        prompt = state.prompt, options = state.options,
        selected_index = state.selected_index,
        default_index = state.default_index,
        timeout = state.timeout or 0,
    }
    if extra then for k, v in pairs(extra) do payload[k] = v end end
    emit_bus(event_name, payload)
    if type(runner.choice_renderer) == "function" then
        pcall(runner.choice_renderer, payload)
    end
end

local function choice_ui_id(player_id, kind, index)
    local slug = tostring(player_id):gsub("[^%w_%-]", "_")
    if index then
        return "endless_choice_" .. kind .. "_" .. slug .. "_" .. tostring(index)
    end
    return "endless_choice_" .. kind .. "_" .. slug
end

local function measure_text_width(text, font, scale)
    if TextLayout and type(TextLayout.measureLine) == "function" then
        local ok, w = pcall(TextLayout.measureLine, text, {
            font = font or "THICK", scale = scale or 2.0,
        })
        if ok and type(w) == "number" and w > 0 then return w end
    end
    return #tostring(text) * 6 * (scale or 2.0)
end

local function draw_cursor_at(player_id, cursor_id, x, y, scale)
    if not games or type(games.add_ui_element) ~= "function" then return false end
    pcall(games.remove_ui_element, cursor_id, player_id)
    return pcall(games.add_ui_element, cursor_id, player_id,
        CHOICE_UI.CURSOR_TEXTURE, CHOICE_UI.CURSOR_ANIMATION,
        CHOICE_UI.CURSOR_STATE,
        x, y, 100, scale or CHOICE_UI.CURSOR_SCALE, scale or CHOICE_UI.CURSOR_SCALE)
end

local function draw_text_centered(player_id, text_id, text, y, scale)
    if not games or type(games.draw_text) ~= "function" then return end
    local w = measure_text_width(text, "THICK", scale)
    local x = math.floor((CHOICE_UI.SCREEN_WIDTH - w) / 2 + 0.5)
    pcall(games.draw_text, text_id, player_id, tostring(text),
        x, y, 100, "THICK", scale)
end

local function cursor_centered_x(scale)
    local w = CHOICE_UI.CURSOR_SPRITE_W * (scale or CHOICE_UI.CURSOR_SCALE)
    return math.floor((CHOICE_UI.SCREEN_WIDTH - w) / 2 + 0.5)
end

local function render_choice_ui(runner)
    local state = runner.choice_state
    if not state then return end
    if runner.choice_skip_render then return end
    if not games then return end
    local opts = state.options
    if #opts == 0 then return end
    if state.prompt and state.prompt ~= "" then
        draw_text_centered(runner.player_id, state.prompt_text_id, state.prompt,
            CHOICE_UI.PROMPT_Y, CHOICE_UI.PROMPT_TEXT_SCALE)
    end
    local cursor_x = cursor_centered_x(CHOICE_UI.CURSOR_SCALE)
    for i, opt in ipairs(opts) do
        local opt_y = CHOICE_UI.OPTION_START_Y + (i - 1) * CHOICE_UI.OPTION_SPACING
        opt.base_y = opt_y
        draw_text_centered(runner.player_id, state.text_ids[i], opt.label,
            opt_y, CHOICE_UI.TEXT_SCALE)
        local cursor_y = opt_y - CHOICE_UI.CURSOR_Y_ABOVE + (state.bob_offset or 0)
        draw_cursor_at(runner.player_id, state.cursor_ids[i], cursor_x, cursor_y,
            CHOICE_UI.CURSOR_SCALE)
    end
end

local function render_selected_cursor(runner)
    local state = runner.choice_state
    if not state then return end
    if runner.choice_skip_render then return end
    if not games then return end
    local idx = state.selected_index
    local opt = state.options[idx]
    if not opt or not opt.base_y then return end
    local cursor_x = cursor_centered_x(CHOICE_UI.CURSOR_SCALE)
    local cursor_y = opt.base_y - CHOICE_UI.CURSOR_Y_ABOVE + (state.bob_offset or 0)
    draw_cursor_at(runner.player_id, state.cursor_ids[idx], cursor_x, cursor_y,
        CHOICE_UI.CURSOR_SCALE)
end

local function cleanup_choice_ui(runner)
    local state = runner.choice_state
    if not state then return end
    if state.input_controller and state.input_owner then
        pcall(state.input_controller.release_input, state.input_controller, state.input_owner)
    end
    state.input_controller = nil
    state.input_owner = nil
    ensure_input_locked(runner.player_id, runner, "post-choice-release")
    if games then
        for _, id in ipairs(state.cursor_ids or {}) do
            pcall(games.remove_ui_element, id, runner.player_id)
        end
        for _, id in ipairs(state.text_ids or {}) do
            pcall(games.remove_text, id, runner.player_id)
        end
        if state.prompt_text_id then
            pcall(games.remove_text, state.prompt_text_id, runner.player_id)
        end
    end
end

-- ---------------------------------------------------------------------------
-- Choice input
-- ---------------------------------------------------------------------------

local claim_choice_input
local release_choice_input

claim_choice_input = function(runner)
    if not InputAPI then return false end
    if not (type(InputAPI.get_controller) == "function"
        or type(InputAPI.create_controller) == "function") then
        return false
    end
    local controller
    if type(InputAPI.get_controller) == "function" then
        local ok, result = pcall(InputAPI.get_controller, runner.player_id)
        if ok then controller = result end
    end
    if not controller and type(InputAPI.create_controller) == "function" then
        local ok, result = pcall(InputAPI.create_controller, runner.player_id)
        if ok then controller = result end
    end
    if not controller then return false end
    ensure_input_locked(runner.player_id, runner, "pre-claim")
    local owner = "endless_runner:choice:" .. tostring(runner.player_id)
    local claimed = false
    if type(controller.claim_input) == "function" then
        local ok, result = pcall(controller.claim_input, controller, owner, true)
        claimed = ok and result == true
    end
    if not claimed then return false end
    runner.choice_state.input_controller = controller
    runner.choice_state.input_owner = owner
    if type(controller.consume) == "function" then
        pcall(controller.consume, controller, owner)
    end
    if type(controller.require_release) == "function" then
        pcall(controller.require_release, controller, CHOICE_ACTIONS, owner)
    end
    ensure_input_locked(runner.player_id, runner, "post-claim")
    log_for(runner.player_id, "choice input claimed")
    return true
end

release_choice_input = function(runner)
    local state = runner.choice_state
    if not state or not state.input_controller then return end
    local owner = state.input_owner
    local controller = state.input_controller
    if owner and controller then
        pcall(controller.release_input, controller, owner)
    end
    state.input_controller = nil
    state.input_owner = nil
    ensure_input_locked(runner.player_id, runner, "post-release")
end

-- ---------------------------------------------------------------------------
-- Choice lifecycle
-- ---------------------------------------------------------------------------

local resolve_choice

local function begin_choice(runner, waypoint_id)
    if runner.bot_paused then
        log_for(runner.player_id, "begin_choice BAIL: bot already paused")
        return false
    end
    if runner.choice_state then
        log_for(runner.player_id, "begin_choice BAIL: choice_state already set")
        return false
    end
    if Net.is_player_battling and Net.is_player_battling(runner.player_id) then
        log_for(runner.player_id, "begin_choice BAIL: player is battling")
        return false
    end

    local waypoint = runner.choice_waypoints[tostring(waypoint_id)]
    if not waypoint then
        log_for(runner.player_id, "begin_choice BAIL: waypoint "
            .. tostring(waypoint_id) .. " not in runner.choice_waypoints (have: "
            .. (function()
                local ids = {}
                for id in pairs(runner.choice_waypoints) do ids[#ids+1] = id end
                return table.concat(ids, ",")
            end)() .. ")")
        return false
    end

    local options = extract_choice_options(waypoint, runner.instance_id)
    if #options == 0 then
        log_for(runner.player_id, "Choice Waypoint " .. tostring(waypoint_id)
            .. " has no valid Option/Target pairs — skipping")
        return false
    end

    local props = waypoint.custom_properties or {}
    local prompt = tostring(props["Prompt"] or "Choose:")
    local default_idx = tonumber(props["Default Option"]) or 1
    if default_idx < 1 or default_idx > #options then default_idx = 1 end
    local timeout = tonumber(props["Timeout"]) or 0
    if timeout < 0 then timeout = 0 end

    local state = {
        waypoint_id = tostring(waypoint_id),
        waypoint = waypoint, options = options,
        selected_index = 1, default_index = default_idx,
        prompt = prompt, timeout = timeout,
        timeout_at = (timeout > 0) and (os.time() + timeout) or nil,
        opened_at = os.time(),
        resolved = false, bob_tick = 0, bob_offset = 0, tick_count = 0,
        prompt_text_id = choice_ui_id(runner.player_id, "prompt"),
        cursor_ids = {}, text_ids = {},
    }
    for i = 1, #options do
        state.cursor_ids[i] = choice_ui_id(runner.player_id, "cursor", i)
        state.text_ids[i]   = choice_ui_id(runner.player_id, "text", i)
    end
    runner.choice_state = state

    local wait_anim = props["Wait Animation"]
    local anim
    if wait_anim and tostring(wait_anim) ~= "" then
        anim = tostring(wait_anim)
    else
        local current = runner.npc.current_animation
        local dir = current and current:match("_([UDRL]+)$") or nil
        anim = "IDLE_" .. (dir or "DR")
    end
    local dir = props["Direction"] or runner.npc.direction

    async(function()
        await(eznpcs.set_bot_pose(runner.npc, {
            animation = anim, direction = dir, hold = true, loop = true,
        }))
        ensure_input_locked(runner.player_id, runner, "choice-begin")
        render_choice_ui(runner)
        emit_choice_event("endless_runner_choice_requested", runner)
        if not runner.choice_skip_input then
            claim_choice_input(runner)
        end
    end)

    log_for(runner.player_id, "choice at waypoint " .. tostring(waypoint_id)
        .. " (" .. tostring(#options) .. " option(s))")
    return true
end

local function handle_choice_action(runner, action)
    local state = runner.choice_state
    if not state or state.resolved then return false end
    if action == "Up" or action == "Down" then
        local delta = (action == "Up") and -1 or 1
        state.selected_index = state.selected_index + delta
        if state.selected_index < 1 then state.selected_index = #state.options end
        if state.selected_index > #state.options then state.selected_index = 1 end
        state.bob_tick = 0
        state.bob_offset = 0
        render_choice_ui(runner)
        emit_choice_event("endless_runner_choice_changed", runner)
        if games and type(Net.play_sound_for_player) == "function" then
            pcall(Net.play_sound_for_player, runner.player_id, CHOICE_UI.CURSOR_SFX)
        end
        return true
    elseif action == "Left" or action == "Right" then
        return true
    elseif action == "Confirm" then
        resolve_choice(runner, state.selected_index, "confirm")
        return true
    elseif action == "Cancel" then
        resolve_choice(runner, state.default_index, "cancel")
        return true
    end
    return false
end

-- resolve_choice: never leaves the bot paused.
-- Fallback chain for target:
--   1. Chosen option's resolved target object
--   2. Choice waypoint's Next Waypoint 1 (map fallback)
--   3. Runner's first_wp_id (spawn's entry waypoint)
-- In every case, cancel_bot_hold releases the pose so move_npc can run again.
function resolve_choice(runner, index, reason)
    local state = runner.choice_state
    if not state or state.resolved then return end
    state.resolved = true

    local chosen = state.options[index]
    if not chosen then
        state.resolved = false
        return
    end

    -- Determine target via fallback chain.
    local target_obj = chosen.target_obj
    if not target_obj then
        local props = state.waypoint.custom_properties or {}
        local fallback_ref = props["Next Waypoint 1"]
        if fallback_ref and tostring(fallback_ref) ~= "" then
            target_obj = find_object_by_id(runner.instance_id, tostring(fallback_ref))
            if target_obj then
                log_for(runner.player_id, "choice: '" .. tostring(chosen.label)
                    .. "' target missing, using Next Waypoint 1="
                    .. tostring(fallback_ref))
            end
        end
    end
    if not target_obj and runner.first_wp_id then
        target_obj = find_object_by_id(runner.instance_id, runner.first_wp_id)
        if target_obj then
            log_for(runner.player_id, "choice: '" .. tostring(chosen.label)
                .. "' target missing, using first_wp=" .. tostring(runner.first_wp_id))
        end
    end

    if runner.npc and target_obj then
        runner.npc.next_waypoint = target_obj
        runner.last_next_waypoint_id = tostring(target_obj.id)
        runner.npc.wait_time = 0
    elseif runner.npc then
        log_for(runner.player_id, "choice: '" .. tostring(chosen.label)
            .. "' has NO resolvable target (target_id="
            .. tostring(chosen.target_id) .. ") — releasing bot")
    end

    local event_name = (reason == "cancel" or reason == "timeout" or reason == "api_cancel")
        and "endless_runner_choice_cancelled" or "endless_runner_choice_selected"
    emit_choice_event(event_name, runner, { option = chosen, reason = reason })
    cleanup_choice_ui(runner)

    -- CRITICAL: always release the pose. Even if no target was found, the bot
    -- must be able to move again so it can retry (or continue on whatever
    -- next_waypoint the map's fallback provided).
    if runner.npc then pcall(eznpcs.cancel_bot_hold, runner.npc) end

    log_for(runner.player_id, "choice resolved: " .. tostring(chosen.label)
        .. " -> " .. tostring(chosen.target_id) .. " (" .. tostring(reason) .. ")")
    runner.choice_state = nil
end

-- ---------------------------------------------------------------------------
-- Choice tick (input + bob + periodic re-lock + emergency auto-resolve)
-- ---------------------------------------------------------------------------

Net:on("tick", function()
    for _, r in pairs(active_runners) do
        if r and not r.pending and r.choice_state then
            local state = r.choice_state

            -- Emergency: if the choice has been open for far past any
            -- reasonable window (30s default, or the map's timeout + 5s),
            -- force-resolve via the default option. This is a safety net
            -- against a buggy input claim or an unrecoverable target trap.
            local now = os.time()
            local opened = state.opened_at or now
            local hard_deadline = opened + CHOICE_HARD_TIMEOUT
            if state.timeout_at and (state.timeout_at + 5) < hard_deadline then
                hard_deadline = state.timeout_at + 5
            end
            if now > hard_deadline then
                log_for(r.player_id, "choice: emergency auto-resolve after "
                    .. tostring(now - opened) .. "s")
                resolve_choice(r, state.default_index, "timeout")
            end

            state.tick_count = (state.tick_count or 0) + 1
            if r.locked_input and type(LegacyCapture.lock) == "function" then
                if state.tick_count <= 2
                    or state.tick_count % CHOICE_INPUT_RELOCK_TICKS == 0 then
                    pcall(LegacyCapture.lock, r.player_id, "ezlibs-custom/endless-runner/endless-runner")
                end
            end

            if state.timeout_at and os.time() >= state.timeout_at then
                resolve_choice(r, state.default_index, "timeout")
            elseif not state.resolved and state.input_controller then
                local controller = state.input_controller
                local owner = state.input_owner
                local has_control = true
                if type(controller.has_input_control) == "function" then
                    local ok, result = pcall(controller.has_input_control, controller, owner)
                    has_control = ok and result == true
                end
                if has_control and type(controller.is_action_pressed) == "function" then
                    for _, action in ipairs(CHOICE_ACTIONS) do
                        local ok, pressed = pcall(
                            controller.is_action_pressed, controller, action, owner)
                        if ok and pressed then
                            local handled = handle_choice_action(r, action)
                            if handled then
                                if type(controller.consume) == "function" then
                                    pcall(controller.consume, controller, owner)
                                end
                                if type(controller.require_release) == "function" then
                                    pcall(controller.require_release,
                                        controller, CHOICE_ACTIONS, owner)
                                end
                            end
                            break
                        end
                    end
                end
                if r.choice_state and not r.choice_state.resolved then
                    local cs = r.choice_state
                    cs.bob_tick = (cs.bob_tick or 0) + 1
                    if cs.bob_tick >= CHOICE_UI.CURSOR_BOB_TICKS then
                        cs.bob_tick = 0
                        cs.bob_offset = (cs.bob_offset or 0) == 0
                            and -CHOICE_UI.CURSOR_BOB_OFFSET or 0
                        render_selected_cursor(r)
                    end
                end
            end
        end
    end
end)

-- ---------------------------------------------------------------------------
-- Choice detection tick — retries if begin_choice bails
-- ---------------------------------------------------------------------------

Net:on("tick", function()
    for _, r in pairs(active_runners) do
        if r and not r.pending and r.npc then
            local current = r.npc.next_waypoint
            local current_id = current and tostring(current.id) or nil
            if current_id ~= r.last_next_waypoint_id then
                local arrived_id = r.last_next_waypoint_id
                r.last_next_waypoint_id = current_id
                if arrived_id then
                    r.last_arrived_id = arrived_id
                end
            end

            if r.last_arrived_id
                and not r.choice_state
                and r.choice_waypoints[r.last_arrived_id]
                and not (Net.is_player_battling and Net.is_player_battling(r.player_id)) then
                if begin_choice(r, r.last_arrived_id) then
                    r.last_arrived_id = nil
                end
            end
        end
    end
end)

-- ---------------------------------------------------------------------------
-- Floor state helpers
-- ---------------------------------------------------------------------------

local function get_floor_def(runner, index)
    if not runner or not runner.floor_plan then return nil end
    return runner.floor_plan[index]
end

local function current_floor(runner)
    if not runner then return nil end
    return get_floor_def(runner, runner.current_floor_index)
end

local function update_instance_metadata(runner)
    if not runner or not runner.instance_record then return end
    local md = runner.instance_record.metadata or {}
    md.endless_runner = {
        floor_index = runner.current_floor_index,
        encounters_defeated_this_floor = runner.encounters_defeated_this_floor,
        hp = runner.hp, max_hp = runner.max_hp,
    }
    runner.instance_record.metadata = md
end

-- ---------------------------------------------------------------------------
-- Encounter selection: shared ezencounters / Nebulous Liberations area format
-- ---------------------------------------------------------------------------

-- The base-area encounter file is the single source of truth. Instance IDs
-- must NOT be used to load an encounter table: they are unique per floor.
-- Section spelling is the same as ezencounters and PanelEncounters.
local ENCOUNTER_SECTIONS = {
    encounters = true,
    bosses = true,
    special_encounters = true,
}

local function normalize_encounter_section(value)
    if value == nil then return nil end
    local section = tostring(value):lower():gsub("^%s+", ""):gsub("%s+$", "")
    if section == "normal" or section == "random" or section == "regular" then
        section = "encounters"
    elseif section == "boss" then
        section = "bosses"
    elseif section == "special" or section == "special encounter" then
        section = "special_encounters"
    end
    return ENCOUNTER_SECTIONS[section] and section or nil
end

local function runner_encounter_section(runner, trigger_obj)
    local props = trigger_obj and trigger_obj.custom_properties or {}
    -- Explicit Tiled property takes priority over the floor default.
    local trigger_section = props["Encounter Category"] or props["Encounter Section"]
    if trigger_section ~= nil then
        local section = normalize_encounter_section(trigger_section)
        if not section then
            print("[endless_runner] WARNING: invalid Encounter Category '"
                .. tostring(trigger_section) .. "'; using floor setting")
        else
            return section
        end
    end
    local floor_def = current_floor(runner)
    local floor_section = floor_def and (floor_def.encounter_section or floor_def.encounter_category)
    if floor_section ~= nil then
        local section = normalize_encounter_section(floor_section)
        if section then return section end
        print("[endless_runner] WARNING: invalid floor encounter_section '"
            .. tostring(floor_section) .. "'; using encounters")
    end
    -- Legacy 'special' flag historically marks a boss floor in custom.lua.
    if floor_def and floor_def.special == true then return "bosses" end
    return "encounters"
end

local function load_runner_encounter_table(runner)
    local base = runner and runner.instance_record and runner.instance_record.base_area_id
    if not base then return nil, "missing base_area_id" end
    local ok_cfg, cfg = pcall(require, "scripts/ezlibs-scripts/ezconfig")
    if not ok_cfg or type(cfg) ~= "table" or type(cfg.ENCOUNTERS_PATH) ~= "string" then
        return nil, "ezconfig.ENCOUNTERS_PATH unavailable"
    end
    local candidates = { tostring(base) }
    if type(Net.get_area_name) == "function" then
        local ok_name, area_name = pcall(Net.get_area_name, base)
        if ok_name and area_name and tostring(area_name) ~= tostring(base) then
            candidates[#candidates + 1] = tostring(area_name)
        end
    end
    local load_error
    for _, key in ipairs(candidates) do
        local module_name = cfg.ENCOUNTERS_PATH .. key
        local ok_table, definition = pcall(require, module_name)
        if ok_table and type(definition) == "table" then return definition end
        load_error = tostring(module_name) .. ": "
            .. (ok_table and "module did not return a table" or tostring(definition))
    end
    return nil, "could not load encounter table for base area '"
        .. tostring(base) .. "' (" .. tostring(load_error) .. ")"
end

local function pick_weighted_encounter(options)
    if type(options) ~= "table" or #options == 0 then return nil end
    if #options == 1 then return options[1] end
    local total = 0
    for _, option in ipairs(options) do
        local weight = tonumber(option.weight)
        if weight == nil then weight = 1 end
        if weight > 0 then total = total + weight end
    end
    if total <= 0 then return options[math.random(#options)] end
    local roll = math.random() * total
    for _, option in ipairs(options) do
        local weight = tonumber(option.weight)
        if weight == nil then weight = 1 end
        if weight > 0 then
            roll = roll - weight
            if roll <= 0 then return option end
        end
    end
    return options[#options]
end

-- The explicitly requested section never borrows names from another section.
-- If a legacy area has no boss/special section, match Nebulous Liberations'
-- fallback to .encounters. A section with entries is always authoritative.
local function select_runner_encounter(runner, trigger_obj, trigger_id, encounter_names, pick_mode)
    local table_data, err = load_runner_encounter_table(runner)
    if not table_data then return nil, nil, nil, err end

    local section = runner_encounter_section(runner, trigger_obj)
    local choices = table_data[section]
    if (type(choices) ~= "table" or #choices == 0) and section ~= "encounters" then
        choices = table_data.encounters
        if type(choices) == "table" and #choices > 0 then
            print("[endless_runner] WARNING: section '" .. section
                .. "' is empty; falling back to regular encounters")
            section = "encounters"
        end
    end
    if type(choices) ~= "table" or #choices == 0 then
        return nil, section, nil, "no encounters in section '" .. section .. "'"
    end

    local allowed = {}
    for _, definition in ipairs(choices) do
        if type(definition) == "table" and definition.name then
            allowed[tostring(definition.name)] = definition
        end
    end
    local named = {}
    for _, name in ipairs(encounter_names or {}) do
        if allowed[name] then named[#named + 1] = allowed[name] end
    end

    local pool = #named > 0 and named or choices
    local source = #named > 0 and "trigger_names" or "area_section"
    if encounter_names and #encounter_names > 0 and #named == 0 then
        print("[endless_runner] trigger names have no matches in '" .. section
            .. "'; selecting from the section instead")
    end

    local mode = tostring(pick_mode or "random"):lower()
    local chosen
    if mode == "first" then
        chosen = pool[1]
    elseif mode == "cycle" then
        runner.encounter_cycle_index = runner.encounter_cycle_index or {}
        local key = tostring(trigger_id or "__default") .. ":" .. section
        local index = (runner.encounter_cycle_index[key] or 0) + 1
        if index > #pool then index = 1 end
        runner.encounter_cycle_index[key] = index
        chosen = pool[index]
    else
        chosen = pick_weighted_encounter(pool)
    end
    if not chosen or not chosen.name or not chosen.path then
        return nil, section, source, "selected encounter has no name/path"
    end
    return chosen, section, source
end

-- Money is awarded by ezmemory, which synchronizes the Net balance and
-- persistent player record. Only emit success after that API has succeeded.
local function award_runner_monies(runner, raw_amount, source, encounter_name)
    local amount = tonumber(raw_amount)
    if not amount or amount ~= amount or amount < 0 or amount % 1 ~= 0 then
        print("[endless_runner] invalid money reward: " .. tostring(raw_amount))
        return false
    end
    if amount == 0 then return true end

    local ok, balance, err = pcall(ezmemory.add_player_money, runner.player_id, amount)
    if not ok or balance == nil then
        local reason = ok and err or balance
        print("[endless_runner] money reward failed for " .. tostring(runner.player_id)
            .. ": " .. tostring(reason))
        emit_bus("endless_runner_reward_failed", {
            player_id = runner.player_id,
            amount = amount,
            source = source,
            encounter_name = encounter_name,
            floor_index = runner.current_floor_index,
            reason = tostring(reason),
        })
        return false
    end

    runner.monies_earned = (runner.monies_earned or 0) + amount
    emit_bus("endless_runner_monies_awarded", {
        player_id = runner.player_id,
        amount = amount,
        new_balance = balance,
        source = source,
        encounter_name = encounter_name,
        floor_index = runner.current_floor_index,
        run_total = runner.monies_earned,
    })
    return true
end

local function apply_floor_rewards(runner, floor_def)
    if not runner or not floor_def then return end
    if floor_def.heal and floor_def.heal > 0 then
        runner_heal(runner, floor_def.heal)
    end
    if type(floor_def.rewards) ~= "table" then return end
    for _, reward in ipairs(floor_def.rewards) do
        if type(reward) == "table" then
            if reward.type == "hp" and type(reward.amount) == "number" then
                runner_heal(runner, reward.amount)
            elseif reward.type == "money" or reward.type == "monies" then
                award_runner_monies(runner, reward.amount, "floor_reward")
            else
                emit_bus("endless_runner_reward", {
                    player_id = runner.player_id, reward = reward,
                    floor_index = runner.current_floor_index,
                })
            end
        end
    end
end

-- Clear persistent per-area and per-player map memory when a cloned runner
-- area is removed. Every floor has a new instance ID, so failing to do this
-- accumulates memory files and per-player hidden_objects entries over time.
local function remove_runner_instance(instance_id)
    if not instance_id then return false, "instance_id missing" end
    local removed, err = EzMapInstance.remove(instance_id)
    runner_checkpoint(nil, "instance_remove", {
        instance = tostring(instance_id), removed = removed == true, error = err,
    })
    if removed then
        for _, runner in pairs(active_runners) do
            if runner.provided_encounter_assets then
                runner.provided_encounter_assets[instance_id] = nil
            end
        end
    end
    if removed and type(ezmemory.clear_area_memory) == "function" then
        local ok, clear_err = pcall(ezmemory.clear_area_memory, instance_id)
        if not ok then
            print("[endless_runner] WARNING: could not clear instance memory "
                .. tostring(instance_id) .. ": " .. tostring(clear_err))
        end
    end
    return removed, err
end

-- ---------------------------------------------------------------------------
-- Forward declarations for trigger registrars — MUST come before advance_floor
-- ---------------------------------------------------------------------------

local register_warp_trigger
local register_encounter_trigger
local unregister_runner_triggers

-- ---------------------------------------------------------------------------
-- on_path_complete factory — defers to choice at choice waypoints
-- ---------------------------------------------------------------------------

local function make_on_path_complete(runner, record)
    return function(completed_npc)
        -- If the bot's current position matches any registered choice
        -- waypoint, we just arrived at one. Do NOT loop back to the spawn's
        -- first waypoint — the choice system owns the transition now.
        local bx = tonumber(completed_npc.x) or 0
        local by = tonumber(completed_npc.y) or 0
        for id, cw in pairs(runner.choice_waypoints) do
            local cx = tonumber(cw.x) or 0
            local cy = tonumber(cw.y) or 0
            local dx, dy = cx - bx, cy - by
            if (dx * dx + dy * dy) < 1.0 then
                log_for(runner.player_id, "path complete at choice waypoint "
                    .. tostring(id) .. " — deferring to choice system")
                return
            end
        end
        local wp = find_object_by_id(record.id, runner.first_wp_id)
        if wp then completed_npc.next_waypoint = wp end
    end
end

-- ---------------------------------------------------------------------------
-- Floor transition
-- ---------------------------------------------------------------------------

local advance_floor

function advance_floor(player_id, options)
    return async(function()
        local runner = active_runners[player_id]
        if not runner or runner.pending then return false end
        if runner.floor_transition_in_progress then
            log_for(player_id, "advance_floor: already in progress, bailing")
            return false
        end
        runner.floor_transition_in_progress = true

        local ok_body, err_body = pcall(function()
            local current = current_floor(runner)
            if current and current.on_complete then
                pcall(current.on_complete, player_id, current, runner)
            end
            if current then
                emit_bus("endless_runner_floor_completed", {
                    player_id = player_id,
                    floor_index = runner.current_floor_index,
                    floor_def = current,
                })
            end
            if runner.heal_per_floor and runner.heal_per_floor > 0 then
                runner_heal(runner, runner.heal_per_floor)
            end

            runner.current_floor_index = runner.current_floor_index + 1
            runner.encounters_defeated_this_floor = 0

            local next_floor = current_floor(runner)
            if not next_floor then
                log_for(player_id, "all floors cleared — run complete")
                emit_bus("endless_runner_run_completed", {
                    player_id = player_id,
                    floors_cleared = runner.current_floor_index - 1,
                    final_hp = runner.hp,
                    monies_earned = runner.monies_earned or 0,
                })
                EndlessRunner.stop(player_id, {
                    restore_position = true,
                    remove_instance = true,
                    reason = "run_completed",
                })
                return
            end

            log_for(player_id, "advancing to floor " .. tostring(runner.current_floor_index)
                .. " area=" .. tostring(next_floor.area_id or DEFAULT_BASE_AREA_ID))

            if not options or options.skip_fade_in ~= true then
                fade_to_black(player_id)
                await(Async.sleep(ENCOUNTER_FADE_WAIT))
            end

            if runner.npc then
                pcall(eznpcs.cancel_bot_hold, runner.npc)
                eznpcs.remove_npc(runner.npc)
                runner.npc = nil
            end
            unregister_runner_triggers(runner)
            runner.triggers = {}
            runner.fired_triggers = {}
            runner.choice_waypoints = {}
            if runner.choice_state then
                cleanup_choice_ui(runner)
                runner.choice_state = nil
            end

            local base_area = next_floor.area_id or DEFAULT_BASE_AREA_ID
            local new_instance_id = base_area .. "_runner_"
                .. (tostring(player_id):gsub("[^%w_%-]", "_"))
                .. "_f" .. tostring(runner.current_floor_index)

            -- Keep the old area alive until the player has safely arrived
            -- in the next instance. Removing it while occupied can disconnect
            -- the player or invalidate the ongoing transfer.
            local previous_record = runner.instance_record

            local record = EzMapInstance.create(base_area, new_instance_id, {
                host_id = player_id, player_ids = {},
                metadata = {
                    endless_runner = {
                        floor_index = runner.current_floor_index,
                        hp = runner.hp, max_hp = runner.max_hp,
                    },
                },
            })
            if not record then
                log_for(player_id, "advance_floor: create failed for " .. base_area)
                EndlessRunner.stop(player_id, {
                    restore_position = true, remove_instance = true,
                    reason = "floor_create_failed",
                })
                return
            end

            await(Async.sleep(0))
            local spawn_obj = wait_for_spawn(record.id, 5)
            if not spawn_obj then
                pcall(remove_runner_instance, record.id)
                EndlessRunner.stop(player_id, {
                    restore_position = true, reason = "floor_no_spawn",
                })
                return
            end

            local spawn_props = spawn_obj.custom_properties or {}
            local first_wp_id = spawn_props["Next Waypoint 1"] or spawn_props["First Waypoint"]

            local entry = AvatarRegistry.get_or_copy(player_id)
            if not entry then
                pcall(remove_runner_instance, record.id)
                EndlessRunner.stop(player_id, {
                    restore_position = true, reason = "floor_no_avatar",
                })
                return
            end

            local npc = eznpcs.create_npc_from_paths(
                record.id, entry.texture_path, entry.animation_path,
                spawn_obj.x, spawn_obj.y, spawn_obj.z or 0,
                spawn_props["Direction"] or "Down",
                {
                    asset_name = "avatar_" .. (tostring(player_id):gsub("[^%w_%-]", "_")),
                    name = tostring(player_id) .. "-runner",
                    solid = false, warp_in = false, animation = "IDLE_DR",
                })
            if not npc then
                pcall(remove_runner_instance, record.id)
                EndlessRunner.stop(player_id, {
                    restore_position = true, reason = "floor_no_bot",
                })
                return
            end
            exclude_bot_from_other_players(npc.bot_id, player_id)

            runner.instance_id = record.id
            runner.instance_record = record
            runner.npc = npc
            runner.spawn_obj = spawn_obj
            runner.first_wp_id = first_wp_id
            runner.last_next_waypoint_id = first_wp_id and tostring(first_wp_id) or nil
            runner.last_arrived_id = nil
            runner.camera_tracking = false
            runner.bot_paused = false

            if first_wp_id then
                eznpcs.attach_waypoint_follow(npc, first_wp_id, {
                    on_path_complete = make_on_path_complete(runner, record),
                })
            end

            local warp_n, enc_n, choice_n = 0, 0, 0
            for _, object_id in ipairs(Net.list_objects(record.id) or {}) do
                local obj_ok, obj = pcall(Net.get_object_by_id, record.id, object_id)
                if obj_ok and obj then
                    local emitter, trigger_id
                    if obj.type == TRIGGER_TYPE then
                        emitter, trigger_id = register_warp_trigger(runner, obj)
                        if emitter then
                            runner.triggers[trigger_id] = emitter
                            warp_n = warp_n + 1
                        end
                    elseif obj.type == RECT_ENCOUNTER_TYPE then
                        emitter, trigger_id = register_encounter_trigger(runner, obj, false)
                        if emitter then
                            runner.triggers[trigger_id] = emitter
                            enc_n = enc_n + 1
                        end
                    elseif obj.type == RADIUS_ENCOUNTER_TYPE then
                        emitter, trigger_id = register_encounter_trigger(runner, obj, true)
                        if emitter then
                            runner.triggers[trigger_id] = emitter
                            enc_n = enc_n + 1
                        end
                    elseif is_choice_waypoint(obj) then
                        runner.choice_waypoints[tostring(obj.id)] = obj
                        choice_n = choice_n + 1
                        log_for(player_id, "registered choice waypoint id="
                            .. tostring(obj.id) .. " type=" .. tostring(obj.type))
                    end
                end
            end
            log_for(player_id, "floor " .. tostring(runner.current_floor_index)
                .. " registered " .. warp_n .. " warp, " .. enc_n
                .. " encounter, " .. choice_n .. " choice")

            local transferred = seamless_warp(player_id, record.id,
                spawn_obj.x, spawn_obj.y, spawn_obj.z or 0)
            if not transferred then
                -- The player is still in the previous area. Roll back the
                -- runner's pointers so stop() can return them safely.
                unregister_runner_triggers(runner)
                pcall(eznpcs.remove_npc, npc)
                pcall(remove_runner_instance, record.id)
                runner.instance_record = previous_record
                runner.instance_id = previous_record and previous_record.id or nil
                runner.npc = nil
                EndlessRunner.stop(player_id, {
                    restore_position = true, remove_instance = true,
                    reason = "floor_transfer_failed",
                })
                return
            end
            EzMapInstance.register_player(record.id, player_id)
            if previous_record then
                local removed, remove_error = remove_runner_instance(previous_record.id)
                if not removed then
                    print("[endless_runner] WARNING: previous floor cleanup failed: "
                        .. tostring(remove_error))
                end
            end
            if runner.locked_input then pcall(LegacyCapture.lock, player_id, "ezlibs-custom/endless-runner/endless-runner") end

            await(Async.sleep(0))
            await(Async.sleep(0))
            if camera_follow_actor(player_id, npc.bot_id) then
                runner.camera_tracking = true
            end

            if runner.offscreen_offset then
                local off = runner.offscreen_offset
                local tx = spawn_obj.x + off
                local ty = spawn_obj.y + off
                local position_api = try_position_only(player_id, tx, ty, spawn_obj.z or 0)
                if not position_api then
                    if seamless_warp(player_id, record.id, tx, ty, spawn_obj.z or 0) then
                        await(Async.sleep(0.15))
                        defend_camera_for(player_id, runner, CAMERA_DEFEND_TICKS)
                        ensure_input_locked(player_id, runner, "floor-advance")
                    end
                end
            end

            if runner.hp_hooks and type(runner.hp_hooks.set) == "function" and runner.hp then
                pcall(runner.hp_hooks.set, player_id, runner.hp)
            end

            if next_floor.on_enter then
                pcall(next_floor.on_enter, player_id, next_floor, runner)
            end
            apply_floor_rewards(runner, next_floor)
            emit_bus("endless_runner_floor_started", {
                player_id = player_id,
                floor_index = runner.current_floor_index,
                floor_def = next_floor,
            })

            if next_floor.is_reward then
                local auto = tonumber(next_floor.auto_advance_after) or 0
                if auto > 0 then
                    async(function()
                        await(Async.sleep(auto))
                        if active_runners[player_id] == runner then
                            await(advance_floor(player_id))
                        end
                    end)
                end
            end

            await(Async.sleep(0.1))
            if not options or options.skip_fade_in ~= true then
                fade_to_clear(player_id)
            end

            log_for(player_id, "floor " .. tostring(runner.current_floor_index) .. " ready")
        end)

        runner.floor_transition_in_progress = false
        if not ok_body then
            print("[endless_runner] advance_floor error for " .. tostring(player_id)
                .. ": " .. tostring(err_body))
            return false
        end
        return true
    end)
end

EndlessRunner.advance_floor = function(player_id)
    return advance_floor(player_id)
end

-- ---------------------------------------------------------------------------
-- Encounter lifecycle
-- ---------------------------------------------------------------------------

-- This package has a distinct package ID and requires only the four enemy mods
-- used by this server's current Runner encounter table. Added/unrecognized
-- aliases automatically fall back to the original full ezencounters package.
local RUNNER_BATTLE_PACKAGE =
    "/server/assets/ezlibs-assets/ezencounters/ezencounters-runner.zip"
local RUNNER_BATTLE_ENEMIES = {
    Boomer = true, WindBox = true, Quaker = true, Fishy = true,
}
local function runner_uses_minimal_package(definition)
    if type(definition) ~= "table" or type(definition.enemies) ~= "table"
        or #definition.enemies == 0 then
        return false
    end
    for _, enemy in ipairs(definition.enemies) do
        if type(enemy) ~= "table" or not RUNNER_BATTLE_ENEMIES[enemy.name] then
            return false
        end
    end
    return true
end

local default_encounter_starter = function(player_id, encounter_name, trigger_obj, runtime_data)
    -- The player is in a cloned area, whereas ezencounters indexes named
    -- definitions by *base* area. A global lookup is unsafe because names may
    -- occur in multiple area encounter tables.
    local ok, ezencounters = pcall(require, "scripts/ezlibs-scripts/ezencounters/main")
    if not ok or type(ezencounters) ~= "table" then
        return nil, "ezencounters unavailable"
    end
    if type(ezencounters.get_encounter_by_name) ~= "function"
        or type(ezencounters.begin_encounter) ~= "function" then
        return nil, "ezencounters lookup/start API unavailable"
    end
    local runner = active_runners[player_id]
    local base_area_id = runner and runner.instance_record
        and runner.instance_record.base_area_id
    local encounter_info = ezencounters.get_encounter_by_name(
        encounter_name, base_area_id)
    if not encounter_info then
        return nil, "no encounter '" .. tostring(encounter_name)
            .. "' registered for base area '" .. tostring(base_area_id) .. "'"
    end
    -- Use a copy: never mutate the registered base-area definition used by
    -- regular encounters or by Nebulous Liberations.
    local battle_definition = {}
    for key, value in pairs(encounter_info) do battle_definition[key] = value end
    if runner_uses_minimal_package(encounter_info) then
        battle_definition.path = RUNNER_BATTLE_PACKAGE
    end

    local clone_area_id = Net.get_player_area(player_id)
    runner_checkpoint(player_id, "encounter_resolved", {
        name = encounter_name,
        base_area = tostring(base_area_id),
        clone_area = tostring(clone_area_id),
        package = tostring(battle_definition.path),
        enemies = #(encounter_info.enemies or {}),
        using_minimal_package = battle_definition.path == RUNNER_BATTLE_PACKAGE,
    })

    if not battle_definition.path then
        runner_checkpoint(player_id, "package_path_missing", {name=encounter_name})
        return nil, "encounter has no battle package path"
    end
    -- Assets originally registered against the base area are not guaranteed
    -- to be published to its clones. Cache per active clone, not per base.
    if runner and clone_area_id then
        runner.provided_encounter_assets = runner.provided_encounter_assets or {}
        local provided = runner.provided_encounter_assets[clone_area_id] or {}
        runner.provided_encounter_assets[clone_area_id] = provided
        if not provided[battle_definition.path] then
            runner_checkpoint(player_id, "package_provide_begin", {
                clone_area = tostring(clone_area_id),
                package = battle_definition.path,
            })
            local ok_asset, asset_err = pcall(
                Net.provide_asset, clone_area_id, battle_definition.path)
            if not ok_asset then
                runner_checkpoint(player_id, "package_provide_failed", {error=tostring(asset_err)})
                return nil, "failed to provide encounter package: " .. tostring(asset_err)
            end
            provided[battle_definition.path] = true
            runner_checkpoint(player_id, "package_provide_done", {
                clone_area = tostring(clone_area_id),
                package = battle_definition.path,
            })
        else
            runner_checkpoint(player_id, "package_already_provided", {
                clone_area = tostring(clone_area_id),
                package = battle_definition.path,
            })
        end
    end
    runner_checkpoint(player_id, "begin_encounter_called", {
        package = battle_definition.path,
        name = encounter_name,
    })
    return ezencounters.begin_encounter(player_id, battle_definition, trigger_obj, runtime_data)
end

function EndlessRunner.start_encounter(player_id, encounter_name, trigger_obj, encounter_section)
    return async(function()
        local runner = active_runners[player_id]
        if not runner or runner.pending then return false end
        if runner.encounter_in_progress then return false end
        if Net.is_player_battling and Net.is_player_battling(player_id) then return false end
        if not encounter_name or tostring(encounter_name) == "" then
            -- A direct start without a name draws from the floor's area table.
            local definition, section, _, selection_error = select_runner_encounter(
                runner, trigger_obj, "__direct", nil, "random")
            if not definition then
                log_for(player_id, "encounter selection failed: " .. tostring(selection_error))
                return false
            end
            encounter_name, encounter_section = definition.name, section
        end
        encounter_section = encounter_section or runner_encounter_section(runner, trigger_obj)

        runner_checkpoint(player_id, "encounter_selected", {
            name = encounter_name,
            section = encounter_section,
            instance = tostring(runner.instance_id),
            hp = runner.hp,
        })
        runner.encounter_in_progress = true
        fade_to_black(player_id)
        await(Async.sleep(ENCOUNTER_FADE_WAIT))
        await(EndlessRunner.pause_bot(player_id))
        runner_checkpoint(player_id, "bot_paused_before_battle", {
            area = tostring(Net.get_player_area(player_id)),
        })

        emit_bus("endless_runner_encounter_started", {
            player_id = player_id, encounter_name = encounter_name,
            encounter_section = encounter_section,
            trigger = trigger_obj,
        })

        local starter = runner.encounter_starter or default_encounter_starter
        -- The shared reward processor is called at battle_results time, while
        -- the native reward screen is active. This runtime override takes
        -- priority over area/encounter/enemy defaults, but does not mutate
        -- the cached encounter definition.
        local floor_def = current_floor(runner)
        local floor_rewards = floor_def and floor_def.encounter_rewards
        if floor_rewards == nil then
            local money = floor_def and floor_def.encounter_monies
            if money == nil then money = runner.encounter_monies end
            if money ~= nil then floor_rewards = { money = { base = money } } end
        end
        local runtime_data = {
            _base_area_id = runner.instance_record and runner.instance_record.base_area_id,
            rewards = floor_rewards,
        }
        runner.last_encounter_reward_totals = nil
        runner.last_encounter_rewards = nil
        local stats, err = nil, nil
        do
            runner_checkpoint(player_id, "starter_call_begin", {name=encounter_name})
            local ok, result1, result2 = pcall(starter, player_id, encounter_name, trigger_obj, runtime_data)
            runner_checkpoint(player_id, "starter_call_returned", {
                ok = ok,
                result_type = type(result1),
                error = not ok and tostring(result1) or nil,
            })
            if not ok then
                err = tostring(result1)
            elseif result1 == nil then
                err = tostring(result2 or "encounter returned nil")
            elseif type(result1) == "table" and (result1.health ~= nil
                    or result1.reason ~= nil or result1.ran ~= nil) then
                -- Custom starters may return immediate stats instead of a promise.
                stats = result1
            else
                -- An Async.initiate_encounter rejection must never leave the
                -- runner's avatar paused and the camera permanently faded.
                runner_checkpoint(player_id, "battle_await_begin", {name=encounter_name})
                local awaited, resolved, async_error = pcall(function()
                    return await(result1)
                end)
                runner_checkpoint(player_id, "battle_await_finished", {
                    awaited = awaited,
                    stats_type = type(resolved),
                    error = not awaited and tostring(resolved) or nil,
                })
                if awaited then
                    stats = resolved
                    if stats == nil then err = tostring(async_error or "battle returned nil") end
                else
                    err = tostring(resolved)
                end
            end
        end

        runner.encounter_in_progress = false

        -- An async battle may finish after a disconnect, cancelled run, or
        -- another session replacing this one. Never pay or advance a stale run.
        if active_runners[player_id] ~= runner then return false end

        if not stats then
            runner_checkpoint(player_id, "encounter_failed", {error=tostring(err)})
            log_for(player_id, "start_encounter failed: " .. tostring(err))
            EndlessRunner.resume_bot(player_id)
            fade_to_clear(player_id)
            return false
        end

        if type(stats) ~= "table" then
            runner_checkpoint(player_id, "encounter_invalid_result", {type=type(stats)})
            log_for(player_id, "encounter returned non-table stats")
            EndlessRunner.resume_bot(player_id)
            fade_to_clear(player_id)
            return false
        end

        runner_checkpoint(player_id, "battle_result_received", {
            health = stats.health, reason = stats.reason, ran = stats.ran,
        })
        local hp_before = runner.hp
        if type(stats.health) == "number" then
            runner_apply_hp(runner, stats.health)
        end
        local hp_after = runner.hp
        local reason = tonumber(stats.reason)
        local died = reason == 2 or stats.health == 0
            or (type(hp_after) == "number" and hp_after <= 0)
        local fled = stats.ran == true or reason == 3 or reason == 4
        local won = not (died or fled)
            and (reason == 1
                or (reason == nil and type(stats.health) == "number" and stats.health > 0))

        -- No second ezmemory payout here. The ezencounters battle_results
        -- listener already sent and persisted the native reward packet.
        -- A custom starter that bypasses ezencounters must explicitly use its
        -- register_external_battle API to participate in shared rewards.

        emit_bus("endless_runner_encounter_finished", {
            player_id = player_id, encounter_name = encounter_name,
            encounter_section = encounter_section,
            stats = stats, won = won,
            rewards = runner.last_encounter_rewards,
            reward_totals = runner.last_encounter_reward_totals,
            hp = hp_after, hp_before = hp_before,
        })

        if died or fled then
            log_for(player_id, "encounter " .. (died and "died" or "fled")
                .. " — ending run")
            EndlessRunner.stop(player_id, {
                restore_position = true, remove_instance = true,
                reason = died and "hp_depleted" or "fled",
            })
            return false
        end

        if not won then
            log_for(player_id, "encounter result has no confirmed victory; stopping run")
            EndlessRunner.stop(player_id, {
                restore_position = true, remove_instance = true,
                reason = "invalid_encounter_result",
            })
            return false
        end

        runner.encounters_defeated_this_floor = runner.encounters_defeated_this_floor + 1
        update_instance_metadata(runner)

        local floor_def = current_floor(runner)
        log_for(player_id, "encounter won: " .. tostring(runner.encounters_defeated_this_floor)
            .. "/" .. tostring(floor_def and floor_def.encounters or "?")
            .. " hp=" .. tostring(runner.hp))

        if floor_def and runner.encounters_defeated_this_floor >= (floor_def.encounters or 0) then
            await(advance_floor(player_id, { skip_fade_in = false }))
        else
            EndlessRunner.resume_bot(player_id)
            ensure_input_locked(player_id, runner, "encounter-end")
            await(Async.sleep(0.1))
            fade_to_clear(player_id)
        end

        return true
    end)
end

-- ---------------------------------------------------------------------------
-- Trigger registrars
-- ---------------------------------------------------------------------------

function register_warp_trigger(runner, trigger_obj)
    local props = trigger_obj.custom_properties or {}
    local shape = (trigger_obj.data and trigger_obj.data.type) or "rect"
    local trigger_id = "endless_warp_" .. tostring(trigger_obj.id)
    local emitter
    if shape == "ellipse" then
        emitter = ezbottriggers.add_radius_trigger(runner.instance_id, trigger_obj,
            trigger_obj.width or 0, trigger_obj.height or 0,
            (trigger_obj.width or 0) / 2, (trigger_obj.height or 0) / 2, trigger_id)
    else
        emitter = ezbottriggers.add_rectangle_trigger(runner.instance_id, trigger_obj,
            trigger_obj.width or 0, trigger_obj.height or 0, trigger_id)
    end
    if not emitter then
        print("[endless_runner] could not register warp trigger "
            .. tostring(trigger_obj.id))
        return nil, trigger_id
    end

    local target_ref = props["Warp To"] or props["Warp Target"]
    local resolved_target = nil
    if target_ref and tostring(target_ref) ~= "" then
        resolved_target = resolve_object_ref(tostring(target_ref), runner)
    end

    local once_raw = props["Once"]
    local once = true
    if once_raw == false or once_raw == "false" or once_raw == 0 then once = false end

    local warp_bot_too = props["Warp Bot Too"]
    warp_bot_too = (warp_bot_too == true or warp_bot_too == "true")

    emitter:on("entered", function(event)
        if not event or event.bot_id ~= runner.npc.bot_id then return end
        if once and runner.fired_triggers[trigger_id] then return end
        runner.fired_triggers[trigger_id] = true
        local target_obj = resolved_target or runner.spawn_obj
        if not target_obj then return end
        local tx, ty, tz = target_obj.x, target_obj.y, target_obj.z or 0
        if warp_bot_too and runner.npc then
            pcall(Net.move_bot, runner.npc.bot_id, tx, ty, tz)
            runner.npc.x, runner.npc.y, runner.npc.z = tx, ty, tz
        end
        if runner.warped_offscreen then
            local off = tonumber(runner.offscreen_offset) or 5000
            try_position_only(runner.player_id, tx + off, ty + off, tz)
        else
            if seamless_warp(runner.player_id, runner.instance_id, tx, ty, tz) then
                if runner.camera_tracking then
                    defend_camera_for(runner.player_id, runner, CAMERA_DEFEND_TICKS)
                end
                ensure_input_locked(runner.player_id, runner, "post-trigger-warp")
            end
        end
    end)

    return emitter, trigger_id
end

function register_encounter_trigger(runner, trigger_obj, is_ellipse)
    local props = trigger_obj.custom_properties or {}
    local trigger_id = "endless_enc_" .. tostring(trigger_obj.id)
    local emitter
    if is_ellipse then
        emitter = ezbottriggers.add_radius_trigger(runner.instance_id, trigger_obj,
            trigger_obj.width or 0, trigger_obj.height or 0,
            (trigger_obj.width or 0) / 2, (trigger_obj.height or 0) / 2, trigger_id)
    else
        emitter = ezbottriggers.add_rectangle_trigger(runner.instance_id, trigger_obj,
            trigger_obj.width or 0, trigger_obj.height or 0, trigger_id)
    end
    if not emitter then
        print("[endless_runner] could not register encounter trigger "
            .. tostring(trigger_obj.id))
        return nil, trigger_id
    end

    local once_raw = props["Once"]
    local once = false
    if once_raw == true or once_raw == "true" then once = true end

    local pick_mode = tostring(props["Pick Mode"] or "random"):lower()
    local encounter_list = extract_encounter_list(props)
    -- Trigger names are optional. The base area's .encounters/.bosses/
    -- .special_encounters section is used when none match the active section.
    print("[endless_runner] encounter trigger " .. tostring(trigger_obj.id)
        .. " — " .. tostring(#encounter_list) .. " explicit name(s), pick=" .. pick_mode)

    emitter:on("entered", function(event)
        if not event or event.bot_id ~= runner.npc.bot_id then return end
        if runner.encounter_in_progress or runner.pending or runner.floor_transition_in_progress then return end
        if once and runner.fired_triggers[trigger_id] then return end

        local selected, section, source, selection_error = select_runner_encounter(
            runner, trigger_obj, trigger_id, encounter_list, pick_mode)
        if not selected then
            log_for(runner.player_id, "encounter trigger " .. tostring(trigger_obj.id)
                .. " failed: " .. tostring(selection_error))
            return
        end
        if once then runner.fired_triggers[trigger_id] = true end

        local payload = {
            player_id = runner.player_id,
            bot_id = runner.npc.bot_id,
            instance_id = runner.instance_id,
            base_area_id = runner.instance_record and runner.instance_record.base_area_id,
            encounter_name = selected.name,
            encounter_section = section,
            encounter_source = source,
            encounter_list = encounter_list,
            trigger_object_id = trigger_obj.id,
            trigger_object_name = trigger_obj.name,
            trigger_type = trigger_obj.type,
            trigger_x = trigger_obj.x,
            trigger_y = trigger_obj.y,
            trigger_z = trigger_obj.z or 0,
        }
        log_for(runner.player_id, "encounter triggered: " .. tostring(selected.name)
            .. " [" .. section .. "] via " .. tostring(trigger_obj.type)
            .. " " .. tostring(trigger_obj.id))
        emit_bus("endless_runner_encounter_triggered", payload)
        -- A custom starter may accept runtime_data as its optional fourth
        -- argument to preserve floor-specific reward overrides.
        EndlessRunner.start_encounter(runner.player_id, selected.name, trigger_obj, section)
    end)

    return emitter, trigger_id
end

function unregister_runner_triggers(runner)
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
    -- A new instance is created for every floor; empty per-area registries
    -- must not accumulate for the lifetime of the server.
    if ezbottriggers.radius_triggers[area_id]
        and not next(ezbottriggers.radius_triggers[area_id]) then
        ezbottriggers.radius_triggers[area_id] = nil
    end
    if ezbottriggers.rectangle_triggers[area_id]
        and not next(ezbottriggers.rectangle_triggers[area_id]) then
        ezbottriggers.rectangle_triggers[area_id] = nil
    end
    runner.triggers = {}
end

-- ---------------------------------------------------------------------------
-- enter()
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
    local origin_source = "current_area"
    local entry_warp_object_id = nil

    -- When a warp led to this watched entry area, prefer its departure
    -- snapshot. The location returned by Net.get_player_area() here is
    -- already the Runner lobby and cannot be used to return from Panic.
    local incoming_origin = pending_entry_origins[player_id]
    pending_entry_origins[player_id] = nil
    if incoming_origin
        and incoming_origin.to_area == origin_area
        and (os.time() - incoming_origin.captured_at) <= ENTRY_ORIGIN_MAX_AGE_SECONDS then
        origin_area = incoming_origin.from_area
        origin_pos = incoming_origin.position
        entry_warp_object_id = incoming_origin.from_warp_object_id
        origin_source = "warp_departure"
    end
    runner_checkpoint(player_id, "entry_origin_selected", {
        source = origin_source,
        entry_warp_id = entry_warp_object_id and tostring(entry_warp_object_id),
        return_area = tostring(origin_area),
        x = origin_pos and origin_pos.x,
        y = origin_pos and origin_pos.y,
        z = origin_pos and origin_pos.z,
    })

    if options.on_prepare then pcall(options.on_prepare, player_id) end

    local should_lock_input = options.lock_input
    if should_lock_input == nil then should_lock_input = true end

    local input_locked = false
    if should_lock_input then
        pcall(LegacyCapture.lock, player_id, "ezlibs-custom/endless-runner/endless-runner")
        input_locked = true
        log_for(player_id, "input locked")
    end

    local function fail(msg)
        if input_locked then pcall(LegacyCapture.unlock, player_id, "ezlibs-custom/endless-runner/endless-runner") end
        log_for(player_id, "enter() FAILED: " .. tostring(msg))
        return false, msg
    end

    local floor_plan = options.floor_plan
    if type(floor_plan) == "table" and #floor_plan > 0 then
        local f1 = floor_plan[1]
        if f1 and f1.area_id then base_area_id = f1.area_id end
    else
        floor_plan = {
            { area_id = base_area_id, encounters = math.huge, is_endless = true },
        }
    end

    local hp_hooks = options.hp_hooks or DEFAULT_HP_HOOKS
    local max_hp = tonumber(options.max_hp)
    local starting_hp = tonumber(options.starting_hp) or max_hp

    local preferred_id = options.instance_id
        or (base_area_id .. "_runner_" .. (tostring(player_id):gsub("[^%w_%-]", "_"))
            .. "_f1")

    if not options.instance_id then
        local existing = EzMapInstance.get(preferred_id)
        if existing then
            log_for(player_id, "removing stale instance " .. preferred_id)
            pcall(remove_runner_instance, preferred_id)
        end
    end

    log_for(player_id, "cloning base area -> " .. preferred_id)
    local record = EzMapInstance.get(preferred_id)
    if not record then
        record = EzMapInstance.create(base_area_id, preferred_id, {
            host_id = player_id, player_ids = {},
            metadata = {
                endless_runner = {
                    floor_index = 1, hp = starting_hp, max_hp = max_hp,
                },
            },
        })
        if not record then
            return fail("EzMapInstance.create failed (is '" .. base_area_id
                .. "' in [Net.list_areas])?")
        end
    end
    log_for(player_id, "instance created: " .. record.id)

    await(Async.sleep(0))
    local spawn_obj, waited = wait_for_spawn(record.id, 5)
    if not spawn_obj then
        pcall(remove_runner_instance, record.id)
        return fail("no '" .. SPAWN_TYPE .. "' in instance " .. tostring(record.id)
            .. " after " .. tostring(waited) .. " ticks")
    end
    log_for(player_id, "spawn located at "
        .. tostring(spawn_obj.x) .. "," .. tostring(spawn_obj.y))

    local spawn_props = spawn_obj.custom_properties or {}
    local first_wp_id = spawn_props["Next Waypoint 1"] or spawn_props["First Waypoint"]
    if not first_wp_id then
        pcall(remove_runner_instance, record.id)
        return fail("spawn object has no 'Next Waypoint 1'")
    end

    log_for(player_id, "copying avatar")
    local entry = AvatarRegistry.get_or_copy(player_id)
    if not entry then
        pcall(remove_runner_instance, record.id)
        return fail("AvatarRegistry failed to copy avatar")
    end
    await(Async.sleep(0))

    log_for(player_id, "spawning avatar bot")
    local npc = eznpcs.create_npc_from_paths(
        record.id, entry.texture_path, entry.animation_path,
        spawn_obj.x, spawn_obj.y, spawn_obj.z or 0,
        spawn_props["Direction"] or "Down",
        {
            asset_name = "avatar_" .. (tostring(player_id):gsub("[^%w_%-]", "_")),
            name = tostring(player_id) .. "-runner",
            solid = false, warp_in = false,
            animation = options.initial_animation or "IDLE_DR",
        })
    if not npc then
        pcall(remove_runner_instance, record.id)
        return fail("could not create avatar bot")
    end
    exclude_bot_from_other_players(npc.bot_id, player_id)

    local offscreen_offset = tonumber(options.offscreen_offset) or 5000

    local runner = {
        player_id = player_id,
        instance_id = record.id,
        instance_record = record,
        npc = npc,
        spawn_obj = spawn_obj,
        first_wp_id = first_wp_id,
        triggers = {},
        fired_triggers = {},
        encounter_cycle_index = {},
        encounter_starter = options.encounter_starter,
        encounter_in_progress = false,
        choice_waypoints = {},
        choice_state = nil,
        choice_skip_input = options.choice_skip_input == true,
        choice_skip_render = options.choice_skip_render == true,
        choice_renderer = options.choice_renderer,
        last_next_waypoint_id = first_wp_id and tostring(first_wp_id) or nil,
        last_arrived_id = nil,
        locked_input = input_locked,
        camera_tracking = false,
        warped_offscreen = false,
        bot_paused = false,
        offscreen_offset = offscreen_offset,
        origin_area = origin_area,
        origin_pos = origin_pos,
        entry_warp_object_id = entry_warp_object_id,
        floor_plan = floor_plan,
        current_floor_index = 1,
        encounters_defeated_this_floor = 0,
        floor_transition_in_progress = false,
        heal_per_floor = tonumber(options.heal_per_floor) or 0,
        encounter_monies = tonumber(options.encounter_monies) or 0,
        monies_earned = 0,
        hp = starting_hp,
        max_hp = max_hp,
        hp_hooks = hp_hooks,
    }

    if max_hp and type(hp_hooks.set_max) == "function" then
        pcall(hp_hooks.set_max, player_id, max_hp)
    end
    if starting_hp and type(hp_hooks.set) == "function" then
        pcall(hp_hooks.set, player_id, starting_hp)
    end

    eznpcs.attach_waypoint_follow(npc, first_wp_id, {
        on_path_complete = make_on_path_complete(runner, record),
    })

    local warp_n, enc_n, choice_n = 0, 0, 0
    for _, object_id in ipairs(Net.list_objects(record.id) or {}) do
        local ok, obj = pcall(Net.get_object_by_id, record.id, object_id)
        if ok and obj then
            local emitter, trigger_id
            if obj.type == TRIGGER_TYPE then
                emitter, trigger_id = register_warp_trigger(runner, obj)
                if emitter then
                    runner.triggers[trigger_id] = emitter
                    warp_n = warp_n + 1
                end
            elseif obj.type == RECT_ENCOUNTER_TYPE then
                emitter, trigger_id = register_encounter_trigger(runner, obj, false)
                if emitter then
                    runner.triggers[trigger_id] = emitter
                    enc_n = enc_n + 1
                end
            elseif obj.type == RADIUS_ENCOUNTER_TYPE then
                emitter, trigger_id = register_encounter_trigger(runner, obj, true)
                if emitter then
                    runner.triggers[trigger_id] = emitter
                    enc_n = enc_n + 1
                end
            elseif is_choice_waypoint(obj) then
                runner.choice_waypoints[tostring(obj.id)] = obj
                choice_n = choice_n + 1
                log_for(player_id, "registered choice waypoint id="
                    .. tostring(obj.id) .. " type=" .. tostring(obj.type))
            end
        end
    end
    log_for(player_id, "registered " .. warp_n .. " warp, " .. enc_n
        .. " encounter, " .. choice_n .. " choice")

    await(Async.sleep(0))

    if options.on_prepared then pcall(options.on_prepared, player_id, record) end
    local delay = tonumber(options.pre_warp_delay) or 0
    if delay > 0 then await(Async.sleep(delay)) end

    local slot = active_runners[player_id]
    if slot and slot.cancelled then
        unregister_runner_triggers(runner)
        pcall(eznpcs.remove_npc, npc)
        pcall(remove_runner_instance, record.id)
        if input_locked then pcall(LegacyCapture.unlock, player_id, "ezlibs-custom/endless-runner/endless-runner") end
        return fail("cancelled before warp")
    end

    log_for(player_id, "warping into instance " .. record.id)
    if not seamless_warp(player_id, record.id,
        spawn_obj.x, spawn_obj.y, spawn_obj.z or 0) then
        unregister_runner_triggers(runner)
        pcall(eznpcs.remove_npc, npc)
        pcall(remove_runner_instance, record.id)
        return fail("seamless_warp failed")
    end
    EzMapInstance.register_player(record.id, player_id)
    ensure_input_locked(player_id, runner, "post-instance-warp")

    await(Async.sleep(0))
    await(Async.sleep(0))
    log_for(player_id, "post-warp area: "
        .. tostring(Net.get_player_area(player_id)))

    if options.follow_bot_camera ~= false then
        if camera_follow_actor(player_id, npc.bot_id) then
            runner.camera_tracking = true
            log_for(player_id, "camera following bot")
        end
    end

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
            log_for(player_id, "offscreen warp via Net." .. position_api)
        else
            if seamless_warp(player_id, record.id, target_x, target_y, target_z) then
                runner.warped_offscreen = true
                await(Async.sleep(0.15))
                defend_camera_for(player_id, runner, CAMERA_DEFEND_TICKS)
                ensure_input_locked(player_id, runner, "post-offscreen-warp")
                log_for(player_id, "offscreen warp via transfer_player")
            end
        end
    end

    active_runners[player_id] = runner
    log_for(player_id, "enter() OK — runner active on floor 1")

    local floor1 = floor_plan[1]
    if floor1 then
        if floor1.on_enter then pcall(floor1.on_enter, player_id, floor1, runner) end
        apply_floor_rewards(runner, floor1)
        emit_bus("endless_runner_floor_started", {
            player_id = player_id, floor_index = 1, floor_def = floor1,
        })
    end

    if options.on_warped then pcall(options.on_warped, player_id, runner) end
    return true, runner
end

-- ---------------------------------------------------------------------------
-- Public API
-- ---------------------------------------------------------------------------

function EndlessRunner.enter(player_id, base_area_id, options)
    if type(base_area_id) == "table" then
        options = base_area_id; base_area_id = nil
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
    runner_checkpoint(player_id, "runner_enter_requested", {
        base_area = tostring(base_area_id),
    })
    -- Direct API starts are intentional even if a previous auto-run finished
    -- in the same area. The watcher itself respects the suppression flag.
    watch_suppressed_until_leave[player_id] = nil
    active_runners[player_id] = { pending = true, cancelled = false, player_id = player_id }
    return async(function()
        local ok, result = do_enter(player_id, base_area_id, options)
        if not ok then
            local slot = active_runners[player_id]
            if slot and slot.pending then active_runners[player_id] = nil end
        end
        return ok, result
    end)
end

function EndlessRunner.stop(player_id, options)
    local runner = active_runners[player_id]
    if not runner then return false end
    options = options or {}
    if runner.pending then runner.cancelled = true; return true end

    local reason = options.reason or "manual"
    -- A disconnect can run after Net has already removed the player.
    -- Never transfer, unlock the camera, or schedule a retry in that case.
    pending_camera_restore_tokens[player_id] = nil
    local player_is_available = reason ~= "disconnect"
        and connected_player_area(player_id) ~= nil
    runner_checkpoint(player_id, "runner_stop", {
        reason = reason,
        area = tostring(runner.instance_id),
        battle_in_progress = runner.encounter_in_progress == true,
    })

    if runner.choice_state then
        runner.choice_state.resolved = true
        cleanup_choice_ui(runner)
        runner.choice_state = nil
    end
    -- Stop the Runner's camera defender immediately; do not retarget the
    -- camera until AFTER the player is back in their departure area.
    local needs_camera_restore = runner.camera_tracking == true
        and player_is_available
    runner.camera_tracking = false
    unregister_runner_triggers(runner)
    if runner.npc then
        pcall(eznpcs.cancel_bot_hold, runner.npc)
        eznpcs.remove_npc(runner.npc)
        runner.npc = nil
        runner.bot_paused = false
    end
    local should_restore = player_is_available
        and (options.restore_position or options.remove_instance)
    if should_restore and runner.origin_area and runner.origin_pos then
        -- Suppress the specific entrance Custom Warp before returning to its
        -- original coordinates. The guard clears once the player walks 1.5
        -- tiles away. Other warps and deliberate re-entry remain available.
        if runner.entry_warp_object_id then
            local warp_ok, ezwarps = pcall(require, "scripts/ezlibs-scripts/ezwarps/main")
            local armed = false
            if warp_ok and ezwarps and type(ezwarps.guard_return_warp) == "function" then
                local ok, result = pcall(ezwarps.guard_return_warp,
                    player_id, runner.origin_area,
                    runner.entry_warp_object_id, runner.origin_pos)
                armed = ok and result == true
            end
            runner_checkpoint(player_id, "return_warp_guard", {
                area = runner.origin_area,
                warp_id = tostring(runner.entry_warp_object_id),
                armed = armed,
            })
        end
        -- A run often begins when a player warps into the base area. Returning
        -- there must not instantly start the same run again on the next tick.
        if watched_area_options[runner.origin_area] then
            watch_suppressed_until_leave[player_id] = {
                area_id = runner.origin_area,
                seen_in_base = false,
            }
        end
        -- The recorded origin may lie inside the Custom Warp. Prefer a
        -- nearby tile center that exists and is clear of warp geometry.
        -- Keep runner.origin_pos untouched for future diagnostics/guarding.
        local return_pos, position_source = choose_runner_return_position(
            runner.origin_area, runner.origin_pos, runner.entry_warp_object_id)
        runner_checkpoint(player_id, "return_position_selected", {
            source = position_source,
            area = runner.origin_area,
            original_x = runner.origin_pos.x,
            original_y = runner.origin_pos.y,
            x = return_pos.x,
            y = return_pos.y,
            z = return_pos.z or 0,
        })
        runner_checkpoint(player_id, "return_transfer_begin", {
            reason = reason, return_area = runner.origin_area,
            x = return_pos.x,
            y = return_pos.y,
            z = return_pos.z or 0,
        })
        local ok, result = pcall(Net.transfer_player,
            player_id, runner.origin_area, false,
            return_pos.x, return_pos.y, return_pos.z or 0)
        runner_checkpoint(player_id, "return_transfer_finished", {
            return_area = runner.origin_area,
            ok = ok and result ~= false,
            error = not ok and tostring(result) or nil,
        })
    end
    if runner.locked_input then
        if player_is_available then
            pcall(LegacyCapture.unlock, player_id, "ezlibs-custom/endless-runner/endless-runner")
        end
        runner.locked_input = false
    end
    if options.remove_instance and runner.instance_record then
        remove_runner_instance(runner.instance_id)
    end

    -- Transfer (if requested) and clone removal are finished before camera
    -- restoration. Also reapply tracking on the following tick because the
    -- client can apply area-transfer camera state after the transfer call.
    -- Only retry while the player has not entered a new Runner session.
    if needs_camera_restore then
        local restored = camera_follow_player(player_id)
        runner_checkpoint(player_id, "camera_return_follow", {
            reason = reason,
            restored = restored,
            expected_area = runner.origin_area,
            current_area = connected_player_area(player_id),
        })
        if restored then log_for(player_id, "camera restored to player") end
    end

    emit_bus("endless_runner_run_ended", {
        player_id = player_id, reason = reason,
        floor_index = runner.current_floor_index,
        final_hp = runner.hp, max_hp = runner.max_hp,
        monies_earned = runner.monies_earned or 0,
    })

    active_runners[player_id] = nil
    pending_entry_origins[player_id] = nil
    clear_log_for(player_id)

    if needs_camera_restore then
        local expected_area = runner.origin_area
        local retry_token = {}
        pending_camera_restore_tokens[player_id] = retry_token
        async(function()
            await(Async.sleep(0))
            -- Cancellation also handles a disconnect followed by an immediate
            -- reconnect, where the same player ID could become valid again.
            if pending_camera_restore_tokens[player_id] ~= retry_token then return end
            pending_camera_restore_tokens[player_id] = nil
            if active_runners[player_id] then return end
            local current_area = connected_player_area(player_id)
            if not current_area then return end
            if expected_area and current_area ~= expected_area then return end
            local restored = camera_follow_player(player_id)
            runner_checkpoint(player_id, "camera_return_follow_retry", {
                reason = reason,
                restored = restored,
                expected_area = expected_area,
                current_area = current_area,
            })
        end)
    end
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

function EndlessRunner.get_state(player_id)
    local r = active_runners[player_id]
    if not r or r.pending then return nil end
    return {
        player_id = r.player_id, instance_id = r.instance_id,
        current_floor_index = r.current_floor_index,
        floor_def = current_floor(r),
        encounters_defeated_this_floor = r.encounters_defeated_this_floor,
        hp = r.hp, max_hp = r.max_hp,
        monies_earned = r.monies_earned or 0,
        locked_input = r.locked_input,
        camera_tracking = r.camera_tracking,
        warped_offscreen = r.warped_offscreen,
        bot_paused = r.bot_paused,
        choice_active = r.choice_state ~= nil,
        encounter_in_progress = r.encounter_in_progress,
    }
end

function EndlessRunner.get_hp(player_id)
    local r = active_runners[player_id]
    if not r or r.pending then return nil end
    return r.hp, r.max_hp
end

function EndlessRunner.set_hp(player_id, hp)
    local r = active_runners[player_id]
    if not r or r.pending then return false end
    return runner_apply_hp(r, hp)
end

function EndlessRunner.heal(player_id, amount)
    local r = active_runners[player_id]
    if not r or r.pending then return false end
    runner_heal(r, amount)
    return true
end

-- ---------------------------------------------------------------------------
-- Battle pause
-- ---------------------------------------------------------------------------

function EndlessRunner.pause_bot(player_id)
    return async(function()
        local runner = active_runners[player_id]
        if not runner or runner.pending or not runner.npc then return false end
        if runner.choice_state then return false end
        if runner.bot_paused then return true end
        local npc = runner.npc
        local anim = npc.current_animation
        local dir = anim and anim:match("_([UDRL]+)$") or nil
        local idle = "IDLE_" .. (dir or "DR")
        await(eznpcs.set_bot_pose(npc, { animation = idle, hold = true, loop = true }))
        runner.bot_paused = true
        print("[endless_runner] " .. tostring(player_id) .. " bot paused (battle)")
        return true
    end)
end

function EndlessRunner.resume_bot(player_id)
    local runner = active_runners[player_id]
    if not runner or not runner.npc then return false end
    if runner.choice_state then return false end
    if not runner.bot_paused then return true end
    eznpcs.cancel_bot_hold(runner.npc)
    runner.bot_paused = false
    print("[endless_runner] " .. tostring(player_id) .. " bot resumed (battle exit)")
    return true
end

-- ---------------------------------------------------------------------------
-- Choice public API
-- ---------------------------------------------------------------------------

function EndlessRunner.choose_option(player_id, index)
    local runner = active_runners[player_id]
    if not runner or not runner.choice_state then return false end
    if type(index) ~= "number" or index < 1 or index > #runner.choice_state.options then
        return false
    end
    resolve_choice(runner, index, "api")
    return true
end

function EndlessRunner.cancel_choice(player_id)
    local runner = active_runners[player_id]
    if not runner or not runner.choice_state then return false end
    resolve_choice(runner, runner.choice_state.default_index, "api_cancel")
    return true
end

function EndlessRunner.get_choice_state(player_id)
    local runner = active_runners[player_id]
    return runner and runner.choice_state or nil
end

-- ---------------------------------------------------------------------------
-- custom_warp handler
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
    local destination = pick(event.destination, event.target_area, event.to_area,
        event.target, props["Area"], props["Target"],
        props["Destination"], props["Warp To"])
    local explicit = false
    if event.handler == "endless_runner"
        or event.handler_id == "endless_runner"
        or props["Handler"] == "endless_runner"
        or props["Endless Runner"] == true
        or props["Endless Runner"] == "true" then
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
        event.cancelled = true; event.handled = true
        return true
    end
    if event.cancel and type(event.cancel) == "function" then
        pcall(event.cancel, event)
    end
    event.cancelled = true; event.handled = true
    local ex, ey, ez = tonumber(event.x), tonumber(event.y), tonumber(event.z) or 0
    local edest = destination
    async(function()
        local enter_opts = options.enter_options or {}
        local ok, result = await(EndlessRunner.enter(player_id, base_area_ids[1], enter_opts))
        if ok then return end
        print("[endless_runner] handle_custom_warp: enter() failed: " .. tostring(result))
        if options.fallback_to_vanilla and edest and ex and ey then
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
    if type(unwire) == "function" then return unwire end
    return nil
end

-- ---------------------------------------------------------------------------
-- Area watcher
-- ---------------------------------------------------------------------------

local function normalize_watch_targets(base_area_ids)
    if type(base_area_ids) == "string" then base_area_ids = { base_area_ids } end
    if type(base_area_ids) ~= "table" then return nil end
    local known_areas = {}
    for _, id in ipairs(Net.list_areas() or {}) do known_areas[id] = true end
    local target, missing = {}, {}
    for _, id in ipairs(base_area_ids) do
        if not known_areas[id] then missing[#missing + 1] = tostring(id) end
        target[id] = true
    end
    if #missing > 0 then
        print("[endless_runner] WARNING: watched area ids not registered: "
            .. table.concat(missing, ", "))
    end
    return target
end

function EndlessRunner.watch_areas(base_area_ids, options)
    local target = normalize_watch_targets(base_area_ids)
    if not target then return end
    options = options or {}
    for area_id in pairs(target) do watched_area_options[area_id] = options end
    if watcher_registered then return end
    watcher_registered = true
    Net:on("tick", function()
        -- Suppression is released only after physically leaving the base area;
        -- it does not prevent deliberately calling EndlessRunner.enter().
        for pid, suppression in pairs(watch_suppressed_until_leave) do
            local ok, current_area = pcall(Net.get_player_area, pid)
            if not ok or current_area == nil then
                watch_suppressed_until_leave[pid] = nil
            elseif current_area == suppression.area_id then
                suppression.seen_in_base = true
            elseif suppression.seen_in_base then
                -- Wait for a confirmed return to the base before considering
                -- subsequent departure a new, intentional entry opportunity.
                watch_suppressed_until_leave[pid] = nil
            end
        end
        for area_id, enter_options in pairs(watched_area_options) do
            for _, pid in ipairs(Net.list_players(area_id) or {}) do
                local suppressed = watch_suppressed_until_leave[pid]
                if not active_runners[pid]
                    and not (suppressed and suppressed.area_id == area_id) then
                    log_for(pid, "detected in base area '" .. tostring(area_id)
                        .. "', starting runner")
                    async(function()
                        local ok, message = await(EndlessRunner.enter(pid, area_id, enter_options))
                        if not ok then
                            print("[endless_runner] auto-enter failed for " .. tostring(pid)
                                .. ": " .. tostring(message))
                        end
                    end)
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
            print("[endless_runner] auto-corrected '" .. base .. "' -> '" .. alt .. "'")
            base = alt
        else
            local alt2 = base .. ".tmx"
            if registered(alt2) then
                print("[endless_runner] auto-corrected '" .. base .. "' -> '" .. alt2 .. "'")
                base = alt2
            end
        end
    end
    if not registered(base) then
        print("[endless_runner] ERROR: base area '" .. tostring(base) .. "' not registered.")
        for _, a in ipairs(Net.list_areas() or {}) do
            print("[endless_runner]   " .. tostring(a))
        end
        return nil
    end
    print("[endless_runner] setup(): watching '" .. base .. "'")

    local pos_api
    for _, name in ipairs(POSITION_APIS) do
        if type(Net[name]) == "function" then pos_api = name; break end
    end
    if pos_api then
        print("[endless_runner] offscreen warp via Net." .. pos_api)
    else
        print("[endless_runner] no position API — using transfer_player + defender")
    end
    if InputAPI then print("[endless_runner] choice input: InputController available")
    else print("[endless_runner] choice input: InputAPI unavailable") end
    if games then print("[endless_runner] choice UI: games module available")
    else print("[endless_runner] choice UI: games module unavailable") end

    local hp_source = "runner-state only"
    for _, name in ipairs({
        "get_player_health", "get_player_max_health",
        "set_player_health", "set_player_max_health",
    }) do
        if type(Net[name]) == "function" then
            if hp_source == "runner-state only" then hp_source = "" end
            hp_source = hp_source .. "Net." .. name .. " "
        end
    end
    print("[endless_runner] HP integration: " .. hp_source)

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
    for _, name in ipairs(names) do print("  Net." .. name) end
    print("======== " .. #names .. " result(s) ========")
    return names
end

function EndlessRunner.diagnose(player_id)
    print("======== EndlessRunner.diagnose ========")
    print("player_id: " .. tostring(player_id))
    print("current area: " .. tostring(Net.get_player_area(player_id)))
    local r = active_runners[player_id]
    if not r then print("runner slot: (none)")
    elseif r.pending then print("runner slot: PENDING")
    else
        print("runner slot: ACTIVE")
        print("  instance_id             : " .. tostring(r.instance_id))
        print("  bot_id                  : " .. tostring(r.npc and r.npc.bot_id))
        print("  camera_tracking         : " .. tostring(r.camera_tracking))
        print("  warped_offscreen        : " .. tostring(r.warped_offscreen))
        print("  bot_paused              : " .. tostring(r.bot_paused))
        print("  locked_input            : " .. tostring(r.locked_input))
        print("  current_floor_index     : " .. tostring(r.current_floor_index))
        print("  encounters_defeated     : " .. tostring(r.encounters_defeated_this_floor))
        print("  hp / max_hp             : " .. tostring(r.hp) .. " / " .. tostring(r.max_hp))
        print("  floor_transition_active : " .. tostring(r.floor_transition_in_progress))
        print("  encounter_in_progress   : " .. tostring(r.encounter_in_progress))
        local choice_n = 0
        for id in pairs(r.choice_waypoints) do choice_n = choice_n + 1 end
        print("  choice waypoints        : " .. tostring(choice_n))
        local fd = current_floor(r)
        if fd then
            print("  floor encounters needed : " .. tostring(fd.encounters))
            print("  floor is_reward         : " .. tostring(fd.is_reward))
            print("  floor special           : " .. tostring(fd.special))
        end
    end
    print("========================================")
end

-- ---------------------------------------------------------------------------
-- Lifecycle
-- ---------------------------------------------------------------------------

Net:on("player_disconnect", function(event)
    local pid = event.player_id
    -- Invalidate already-queued camera callbacks, even if stop() completed
    -- and the runner was removed before this disconnect event arrived.
    if pid then pending_camera_restore_tokens[pid] = nil end
    if pid and active_runners[pid] then
        pcall(EndlessRunner.stop, pid, { remove_instance = true, reason = "disconnect" })
    end
    if pid then
        watch_suppressed_until_leave[pid] = nil
        pending_entry_origins[pid] = nil
    end
end)

Net:on("battle_exit", function(event)
    local pid = event and event.player_id
    if not pid then return end
    local runner = active_runners[pid]
    if not runner then return end
    if runner.locked_input then
        ensure_input_locked(pid, runner, "battle-exit")
    end
    if not runner.npc or not runner.bot_paused then return end
    if runner.choice_state then return end
    if not runner.encounter_in_progress then
        pcall(EndlessRunner.resume_bot, pid)
    end
end)

return EndlessRunner