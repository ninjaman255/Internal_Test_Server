-- ezbuttons.lua
-- Creates trigger-based buttons (non-solid NPCs).
-- Logical relationships are defined with groups and button/group effects.
-- Supports five interaction behaviors: Pressure Plate, One-Time, Toggle, Custom, Timed.
-- Supports area-wide unlock/relock via "Area Wide" flag on Unlock/Relock Behavior objects.
--
-- Optional per-button flag "Bots Can Trigger" (bool, default false) causes the
-- button to register a parallel ezbottriggers rectangle/ellipse in addition to
-- its eztriggers one, so NPCs entering or leaving can drive the same
-- Pressure Plate / One-Time / Toggle / Timed state machine. Custom behavior is
-- excluded because custom scripts receive a player_id.
--
-- Bot-triggered activations pass nil as the activator, so per-player
-- checkpoint unlocks and relocks have no target. When that happens, the
-- deactivation path falls back to area-wide so the button's state change is
-- fully reversed - matching player behavior as closely as possible.

local logger = require('scripts/ezlibs-scripts/ezlogger').get('ezbuttons')
local object_registry = require('scripts/ezlibs-scripts/object_registry')
local eznpcs = require('scripts/ezlibs-scripts/eznpcs/eznpcs')
local eztriggers = require('scripts/ezlibs-scripts/eztriggers/eztriggers')
local ezmemory = require('scripts/ezlibs-scripts/ezmemory')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local helpers = require('scripts/ezlibs-scripts/helpers')
local ezcheckpoints = require('scripts/ezlibs-scripts/ezcheckpoints')
local tu = require('scripts/ezlibs-scripts/utils/eztiledutils')

-- Optional: bot triggers back NPC entries on buttons flagged "Bots Can Trigger".
-- If this fails to load, buttons behave exactly as before (player-only).
local ok_bottriggers, ezbottriggers = pcall(require, 'scripts/ezlibs-scripts/eztriggers/ezbottriggers')
if not ok_bottriggers then
    logger:warn("[ezbuttons] ezbottriggers could not be loaded; NPC button triggers disabled.", tostring(ezbottriggers))
    ezbottriggers = nil
end

local tiled_schema = nil
do
    local ok, mod = pcall(require, "scripts.ezlibs-scripts.ezlibs-tiled-schema")
    if ok and type(mod) == "table" and mod.classes then
        tiled_schema = mod
    end
end

function async(p)
    local co = coroutine.create(p)
    return Async.promisify(co)
end

function await(v) return Async.await(v) end


local ezbuttons = {}

local button_asset_folder = '/server/assets/ezlibs-assets/ezbuttons/'
local TILE_SIZE = 32

local custom_script_cache = {}
local button_triggers = {}

local read_bool = tu.is_true

-- ==========================================================================
-- Player liveness
-- ==========================================================================
local function player_is_alive(player_id)
    if player_id == nil then return false end
    if type(Net.is_player) ~= "function" then return true end
    local ok, alive = pcall(Net.is_player, player_id)
    if not ok then return true end
    return not not alive
end

local function validate_button_object(area_id, object)
    if not tiled_schema then return end
    local class_name = object.type
    if not class_name then return end
    local class_def = tiled_schema.classes[class_name]
    if not class_def then return end
    local ok, report = tu.validate_properties(object, class_def.members, tiled_schema.enums)
    if ok then return end
    for _, e in ipairs(report.errors) do
        logger:for_area(area_id):warn(string.format(
            "[ezbuttons] %s %s: %s (expected %s, got %s)",
            class_name, tostring(object.id), e.issue,
            tostring(e.expected), tostring(e.got)))
    end
end


local function object_to_tile_pos(object)
    local x = tonumber(object.x) or 0
    local y = tonumber(object.y) or 0
    local z = tonumber(object.z or 0) or 0
    return x, y, z
end

-- Internal data
local button_placeholders = {}          -- area_id -> [object_id] = placeholder_info
local button_bots = {}                  -- bot_id -> placeholder_info

-- Forward declarations
local is_button_active
local perform_activation
local perform_deactivation
local deactivate_button_internal
local activate_button
local deactivate_button
local set_button_active_state

-- Additive group/combination/effect layer. All IDs are scoped to an area.
local button_groups = {}
local button_effects = {}
local group_effects = {}
local pending_group_objects = {}
local group_object_ids = {}
local pending_group_effect_objects = {}
local combo_object_definitions = {}
local pending_combo_objects = {}
local pending_combo_group_objects = {}
local try_configure_pending_groups
local try_configure_pending_combos
local try_configure_pending_combo_groups
local logic_queue = {}
local processing_logic_queue = false
local MAX_LOGIC_EVENTS_PER_DRAIN = 1000

local function normalize_ids(ids)
    local result, seen = {}, {}
    for _, id in ipairs(ids or {}) do
        id = tostring(id)
        if not seen[id] then
            seen[id] = true
            result[#result + 1] = id
        end
    end
    return result
end

-- ==========================================================================
-- Live-contributor resolution for group state transitions
--
-- When a group changes state, the callback normally fires with the player
-- whose action triggered the transition. If that player has disconnected
-- (typical when a pressure plate releases during cleanup) or is nil (bot
-- triggered), we search the group's required buttons for a live contributor.
-- The contributor is whoever last activated one of the required buttons and
-- is still connected - they're the one who "owns" the current combo state.
--
-- If no contributor is alive but there ARE live players in the area, fall
-- back to area-wide so the state change isn't silently lost. If nobody is
-- alive, skip (nothing to apply to).
--
-- This helper is consulted on BOTH directions:
--   * SATISFIED (unlock):  recovers achievements lost to a disconnected
--                          triggerer.
--   * INCOMPLETE (relock): ensures bot-triggered (or disconnected-triggered)
--                          deactivations still reverse the effect for
--                          someone, matching player behavior.
-- ==========================================================================

local function find_live_contributor(area_id, group)
    local function first_live_from(ids)
        for _, id in ipairs(ids or {}) do
            local info = button_placeholders[area_id] and button_placeholders[area_id][tostring(id)]
            if info and info.last_activator and player_is_alive(info.last_activator) then
                return info.last_activator
            end
        end
        return nil
    end
    if group.combo then
        return first_live_from(group.combo.button_ids)
    end
    if group.combos then
        for _, combo in ipairs(group.combos) do
            local p = first_live_from(combo.button_ids)
            if p then return p end
        end
        return nil
    end
    return first_live_from(group.button_ids)
end

-- Resolve the effective player (and possibly area-wide fallback) for a
-- transition. Returns (player_id, use_area_wide, reason).
--
--   player_id      - may be nil if no contributor and no fallback
--   use_area_wide  - true if we should apply the action to every live player
--                    in the area
--   reason         - human-readable for logging
local function resolve_transition_player(area_id, group, event_player_id)
    if event_player_id and player_is_alive(event_player_id) then
        return event_player_id, false, "triggerer"
    end

    local contributor = find_live_contributor(area_id, group)
    if contributor then
        return contributor, false, "live contributor " .. tostring(contributor)
    end

    local players = Net.list_players(area_id) or {}
    if #players > 0 then
        return nil, true, "area-wide fallback (no live contributor, "
            .. tostring(#players) .. " player(s) in area)"
    end

    return nil, false, "no live players in area"
end


local function combo_is_satisfied(area_id, combo)
    local required = {}
    for _, id in ipairs(combo.button_ids or {}) do
        required[tostring(id)] = true
        if not is_button_active(area_id, id) then return false end
    end
    if # (combo.button_ids or {}) == 0 then return false end

    for _, id in ipairs(combo.forbidden_ids or {}) do
        if is_button_active(area_id, id) then return false end
    end

    if combo.mode == "Exclusive" then
        for id, info in pairs(button_placeholders[area_id] or {}) do
            if info.group_member and is_button_active(area_id, id) and not required[tostring(id)] then
                return false
            end
        end
    end
    return true
end

local function group_is_satisfied(area_id, group)
    if group.combo then
        return combo_is_satisfied(area_id, group.combo)
    end
    if group.combos then
        for _, combo in ipairs(group.combos) do
            if combo_is_satisfied(area_id, combo) then return true end
        end
        return false
    end
    local members = group.button_ids
    if group.mode == "any_active" then
        for _, id in ipairs(members) do
            if is_button_active(area_id, id) then return true end
        end
        return false
    end

    for _, id in ipairs(members) do
        if not is_button_active(area_id, id) then return false end
    end

    if group.mode == "combination" then
        for _, id in ipairs(group.forbidden_ids) do
            if is_button_active(area_id, id) then return false end
        end
    end
    return #members > 0
end

local function apply_logic_action(area_id, target_id, action, player_id)
    -- Never propagate a dead player into a downstream activation. Otherwise
    -- the newly activated button records a stale last_activator and the same
    -- skip-on-disconnect bug cascades to further group transitions.
    if player_id and not player_is_alive(player_id) then
        player_id = nil
    end

    target_id = tostring(target_id)
    if action == "activate" then
        activate_button(area_id, target_id, player_id)
    elseif action == "deactivate" then
        deactivate_button(area_id, target_id, false)
    elseif action == "toggle" then
        if is_button_active(area_id, target_id) then
            deactivate_button(area_id, target_id, false)
        else
            activate_button(area_id, target_id, player_id)
        end
    elseif action == "reset" then
        local info = button_placeholders[area_id] and button_placeholders[area_id][target_id]
        if info then
            local was_active = is_button_active(area_id, target_id)
            set_button_active_state(area_id, target_id, info.bot_id, info.active_anim, info.inactive_anim, false)
            if was_active then
                logic_queue[#logic_queue + 1] = { area_id = area_id, object_id = target_id, active = false, player_id = player_id }
            end
        end
    else
        logger:info("[ezbuttons] Unknown logic action:", tostring(action))
    end
end

local function process_logic_event(event)
    local area_id, object_id = event.area_id, tostring(event.object_id)
    local event_name = event.active and "activated" or "deactivated"

    local by_source = button_effects[area_id] and button_effects[area_id][object_id]
    local rules = by_source and by_source[event_name]
    if rules then
        for _, rule in ipairs(rules) do
            apply_logic_action(area_id, rule.target_id, rule.action, event.player_id)
        end
    end

    local groups = button_groups[area_id]
    if not groups then return end
    for group_id, group in pairs(groups) do
        local now = group_is_satisfied(area_id, group)
        local previous = group.last_satisfied
        group.last_satisfied = now
        if (previous == false and now == true) or
           (previous == true and now == false) or
           (previous == nil and now == true) then
            local group_event = now and "completed" or "incomplete"
            if type(group.callback) == "function" then
                local ok, err = pcall(group.callback, area_id, group_id, now, event.player_id)
                if not ok then logger:warn("[ezbuttons] Group callback failed:", tostring(err)) end
            end
            local area_group_effects = group_effects[area_id] and group_effects[area_id][group_id]
            local group_rules = area_group_effects and area_group_effects[group_event]
            if group_rules then
                for _, rule in ipairs(group_rules) do
                    apply_logic_action(area_id, rule.target_id, rule.action, event.player_id)
                end
            end
            ezbus:emit("ezbuttons.group_" .. group_event, {
                area_id = area_id,
                group_id = group_id,
                player_id = event.player_id
            })
        end
    end
end

local function enqueue_logic_event(area_id, object_id, active, player_id)
    logic_queue[#logic_queue + 1] = {
        area_id = area_id,
        object_id = tostring(object_id),
        active = active,
        player_id = player_id
    }
    if processing_logic_queue then return end

    processing_logic_queue = true
    local processed = 0
    while #logic_queue > 0 and processed < MAX_LOGIC_EVENTS_PER_DRAIN do
        local event = table.remove(logic_queue, 1)
        processed = processed + 1
        local ok, err = pcall(process_logic_event, event)
        if not ok then logger:warn("[ezbuttons] Logic event processing failed:", tostring(err)) end
    end
    if #logic_queue > 0 then
        logger:info("[ezbuttons] Logic event limit reached; clearing queued events to prevent an infinite effect loop")
        logic_queue = {}
    end
    processing_logic_queue = false
end

local function hide_button_placeholder_for_player(player_id, area_id, object_id)
    if not player_id or not area_id or not object_id then return end
    local ok_area, player_area = pcall(Net.get_player_area, player_id)
    if not ok_area or player_area ~= area_id then return end
    pcall(Net.exclude_object_for_player, player_id, tostring(object_id))
end

local function hide_button_placeholders_for_player(player_id)
    if not player_id then return end
    local ok_area, area_id = pcall(Net.get_player_area, player_id)
    if not ok_area or not area_id then return end
    local area_table = button_placeholders[area_id]
    if not area_table then return end
    for object_id, _ in pairs(area_table) do
        hide_button_placeholder_for_player(player_id, area_id, object_id)
    end
end

local function set_button_animation(bot_id, anim_state, loop)
    if not bot_id or not anim_state then return end
    if loop == nil then loop = true end
    local ok, err = pcall(Net.animate_bot, bot_id, anim_state, loop)
    if not ok then
        logger:warn("[ezbuttons] animate failed bot=", tostring(bot_id), " anim=", tostring(anim_state), " err=", tostring(err))
    end
end

local function sync_button_animations_for_player(player_id)
    if not player_id then return end
    local ok_area, area_id = pcall(Net.get_player_area, player_id)
    if not ok_area or not area_id then return end
    local area_table = button_placeholders[area_id]
    if not area_table then return end

    for object_id, info in pairs(area_table) do
        local bot_id = info.bot_id
        if bot_id then
            local is_active = is_button_active(area_id, object_id)
            local anim = is_active and info.active_anim or info.inactive_anim
            set_button_animation(bot_id, anim, true)
        end
    end
end

local function apply_area_wide_unlocks(player_id, area_id)
    if not player_id or not area_id then return end
    local area_mem = ezmemory.get_area_memory(area_id)
    if not area_mem.area_wide_unlock then return end

    for _, entry in pairs(area_mem.area_wide_unlock) do
        pcall(ezcheckpoints.force_unlock_checkpoint, player_id, entry.area_id, entry.checkpoint_object_id, entry.once)
    end
end

Net:on("player_join", function(event)
    local player_id = event and event.player_id
    if not player_id then return end
    local ok, err = pcall(function()
        hide_button_placeholders_for_player(player_id)
        sync_button_animations_for_player(player_id)
        local ok_area, area_id = pcall(Net.get_player_area, player_id)
        if ok_area and area_id then
            apply_area_wide_unlocks(player_id, area_id)
        end
    end)
    if not ok then
        logger:for_player(player_id):warn("[ezbuttons] player_join handler error:", tostring(err))
    end
end)

Net:on("player_area_transfer", function(event)
    local player_id = event and event.player_id
    local new_area_id = event and event.new_area_id
    if not player_id then return end
    local ok, err = pcall(function()
        hide_button_placeholders_for_player(player_id)
        sync_button_animations_for_player(player_id)
        if new_area_id then
            apply_area_wide_unlocks(player_id, new_area_id)
        end
    end)
    if not ok then
        logger:for_player(player_id):warn("[ezbuttons] player_area_transfer handler error:", tostring(err))
    end
end)

-- ==========================================================================
-- Disconnect cleanup - deterministic three-phase
--
-- Why three phases? Because group re-evaluation fires inside deactivate, and
-- that re-evaluation may consult other buttons' last_activator as a fallback
-- when the departing player was the triggerer. If we cleared last_activators
-- in the same pass as deactivation, the order of pairs() iteration would
-- decide whether the fallback had data to work with - the symptom being that
-- "releasing one button sometimes activates the combo, sometimes doesn't".
--
-- Phase 1: clear trigger_players on every button, collect plates to release.
-- Phase 2: deactivate those plates. last_activator for every button is still
--          intact, so any transition fires with full context.
-- Phase 3: clear last_activator for the departing player on every button.
--
-- Note: a Pressure Plate is only released when NO player AND NO bot is
-- still inside. Bots (when "Bots Can Trigger" is enabled) participate in
-- the same occupancy bookkeeping.
-- ==========================================================================
local function cleanup_player_state(player_id)
    if not player_id then return end

    -- Phase 1
    local plates_to_deactivate = {}
    for area_id, area_table in pairs(button_placeholders) do
        for object_id, info in pairs(area_table) do
            if info.trigger_players then
                info.trigger_players[player_id] = nil
            end
            if info.behavior == "Pressure Plate"
                and info.trigger_players
                and next(info.trigger_players) == nil
                and (not info.trigger_bots or next(info.trigger_bots) == nil)
                and is_button_active(area_id, object_id) then
                plates_to_deactivate[#plates_to_deactivate + 1] = { area_id, object_id }
            end
        end
    end

    -- Phase 2
    for _, entry in ipairs(plates_to_deactivate) do
        local area_id, object_id = entry[1], entry[2]
        logger:info("[ezbuttons] Auto-deactivating Pressure Plate",
            tostring(object_id), "in area", tostring(area_id),
            "after last trigger departed")
        pcall(deactivate_button, area_id, object_id)
    end

    -- Phase 3
    for area_id, area_table in pairs(button_placeholders) do
        for object_id, info in pairs(area_table) do
            if info.last_activator == player_id then
                info.last_activator = nil
            end
        end
    end
end

Net:on("player_disconnect", function(event)
    local player_id = (type(event) == "table") and event.player_id or event
    if not player_id then return end
    local ok, err = pcall(cleanup_player_state, player_id)
    if not ok then
        logger:for_player(player_id):warn("[ezbuttons] player_disconnect cleanup error:", tostring(err))
    end
end)

function ezbuttons.handle_player_disconnect(player_id)
    local ok, err = pcall(cleanup_player_state, player_id)
    if not ok then
        logger:for_player(player_id):warn("[ezbuttons] handle_player_disconnect error:", tostring(err))
    end
end

-- Helper: create a non‑solid bot for the button
local function create_button_bot(area_id, asset_name, x, y, z, direction,
                                 bot_name, animation_name, mug_animation_name,
                                 initial_anim)
    local texture_path = button_asset_folder  .. asset_name .. ".png"
    local animation_path = button_asset_folder  .. asset_name .. ".animation"

    if animation_name then
        animation_path = button_asset_folder .. animation_name .. ".animation"
    end

    local npc_data = {
        asset_name = asset_name,
        bot_id = nil,
        name = bot_name,
        area_id = area_id,
        texture_path = texture_path,
        animation_path = animation_path,
        animation = initial_anim or "IDLE_D",
        direction = direction,
        x = x,
        y = y,
        z = z,
        solid = false,
        size = 0.2,
        speed = 1,
        dont_face_player = true,
        warp_in = true,
    }

    logger:info("[ezbuttons] Button texture:", texture_path)
    logger:info("[ezbuttons] Button animation:", animation_path)

    local texture_ok, texture_err = pcall(Net.provide_asset, area_id, texture_path)
    logger:info("[ezbuttons] Texture provision:", texture_ok, texture_err or "")

    local animation_ok, animation_err = pcall(Net.provide_asset, area_id, animation_path)
    logger:info("[ezbuttons] Animation provision:", animation_ok, animation_err or "")

    local bot_id = Net.create_bot(npc_data)
    if not bot_id then
        logger:warn("[ezbuttons] Failed to create bot for button", asset_name)
        return nil
    end
    logger:info("[ezbuttons] created button bot id:", bot_id, "at", x, y, z)
    return bot_id
end

is_button_active = function(area_id, object_id)
    local area_mem = ezmemory.get_area_memory(area_id)
    area_mem.buttons = area_mem.buttons or {}
    return area_mem.buttons[tostring(object_id)] == true
end

set_button_active_state = function(area_id, object_id, bot_id, active_anim, inactive_anim, active)
    local area_mem = ezmemory.get_area_memory(area_id)
    area_mem.buttons = area_mem.buttons or {}
    area_mem.buttons[tostring(object_id)] = active
    ezmemory.save_area_memory(area_id)

    local new_anim = active and active_anim or inactive_anim
    set_button_animation(bot_id, new_anim, true)
end

local function create_button_trigger(area_id, object, width_px, height_px, trigger_id)
    width_px = tonumber(width_px)
    height_px = tonumber(height_px)

    if not width_px or width_px <= 0 then
        width_px = tonumber(object and object.width) or 4
    end
    if not height_px or height_px <= 0 then
        height_px = tonumber(object and object.height) or 4
    end

    local emitter = eztriggers.add_rectangle_trigger(area_id, object, width_px, height_px, trigger_id)
    if emitter then
        button_triggers[trigger_id] = emitter
        logger:for_area(area_id):info("[ezbuttons] ✅ Trigger created successfully: " .. trigger_id)
    else
        logger:for_area(area_id):warn("[ezbuttons] ❌ FAILED to create trigger for " .. trigger_id)
    end
    return emitter
end

-- ============================================================
-- PERFORM ACTIVATION
-- ============================================================
perform_activation = function(area_id, object_id, player_id, info)
    if is_button_active(area_id, object_id) then
        return false
    end

    info.last_activator = player_id

    set_button_active_state(area_id, object_id, info.bot_id, info.active_anim, info.inactive_anim, true)
    logger:for_player(player_id):info("[ezbuttons] Button", object_id, "activated in area", area_id)
    enqueue_logic_event(area_id, object_id, true, player_id)

    local cp_id = not info.group_member and info.unlock_checkpoint_obj or nil
    if cp_id and cp_id ~= "" then
        if info.unlock_area_wide then
            local players = Net.list_players(info.area_id) or {}
            for _, pid in ipairs(players) do
                pcall(ezcheckpoints.force_unlock_checkpoint, pid, info.area_id, cp_id, info.unlock_permanently)
            end
            if not info.unlock_permanently then
                local cp_area_mem = ezmemory.get_area_memory(info.area_id)
                cp_area_mem.area_wide_unlock = cp_area_mem.area_wide_unlock or {}
                cp_area_mem.area_wide_unlock[tostring(object_id)] = {
                    area_id = info.area_id,
                    checkpoint_object_id = tostring(cp_id),
                    once = false,
                }
                ezmemory.save_area_memory(info.area_id)
            end
            logger:info("[ezbuttons] Area-wide checkpoint unlock applied by button " .. tostring(object_id))
        elseif player_is_alive(player_id) then
            local ok, err = pcall(ezcheckpoints.force_unlock_checkpoint, player_id, info.area_id, cp_id, info.unlock_permanently)
            if not ok then
                logger:for_area(area_id):warn("[ezbuttons] Failed to unlock checkpoint: " .. tostring(err))
            elseif not info.unlock_permanently then
                local area_mem = ezmemory.get_area_memory(area_id)
                area_mem.timed_button_unlock_info = area_mem.timed_button_unlock_info or {}
                area_mem.timed_button_unlock_info[tostring(object_id)] = {
                    player_id = player_id,
                    area_id = info.area_id,
                    checkpoint_object_id = tostring(cp_id),
                }
                ezmemory.save_area_memory(area_id)
            end
        else
            logger:info("[ezbuttons] Skipping per-player checkpoint unlock for button "
                .. tostring(object_id) .. ": activator is no longer connected")
        end
    end

    return true
end

-- ============================================================
-- PERFORM DEACTIVATION
-- ============================================================
perform_deactivation = function(area_id, object_id, info)
    if not is_button_active(area_id, object_id) then
        return false
    end

    set_button_active_state(area_id, object_id, info.bot_id, info.active_anim, info.inactive_anim, false)
    logger:info("[ezbuttons] Button", object_id, "deactivated")

    if not info.group_member then
        local area_mem = ezmemory.get_area_memory(area_id)
        local object_key = tostring(object_id)
        local area_wide_entries = area_mem and area_mem.area_wide_unlock
        local area_wide_entry = area_wide_entries and area_wide_entries[object_key]
        if area_wide_entry then
            local players = Net.list_players(area_wide_entry.area_id) or {}
            for _, pid in ipairs(players) do
                pcall(ezcheckpoints.relock_checkpoint, pid, area_wide_entry.area_id, area_wide_entry.checkpoint_object_id)
            end
            area_wide_entries[object_key] = nil
            ezmemory.save_area_memory(area_wide_entry.area_id)
            logger:info("[ezbuttons] Area-wide checkpoint relock applied by button " .. object_key)
        else
            local unlocks = area_mem and area_mem.timed_button_unlock_info
            local unlock_info = unlocks and unlocks[object_key]
            if unlock_info then
                if player_is_alive(unlock_info.player_id) then
                    local ok, err = pcall(ezcheckpoints.relock_checkpoint,
                        unlock_info.player_id, unlock_info.area_id, unlock_info.checkpoint_object_id)
                    if not ok then
                        logger:for_area(area_id):warn("[ezbuttons] Failed to relock checkpoint: " .. tostring(err))
                    end
                else
                    logger:info("[ezbuttons] Skipping automatic relock for button "
                        .. object_key .. ": recorded player no longer connected")
                end
                unlocks[object_key] = nil
                ezmemory.save_area_memory(area_id)
            end
        end

        if info.relock_target then
            -- Three cases:
            --   * Area Wide set         -> relock for every live player.
            --   * last_activator == nil -> the button was activated by a bot
            --                              (or some other non-player actor),
            --                              so there is no specific player to
            --                              target. Fall back to area-wide so
            --                              the reversal still happens.
            --   * last_activator set    -> relock for that player if still
            --                              connected; skip otherwise (their
            --                              per-player state persists via
            --                              memory, matching the original
            --                              disconnect design).
            local use_area_wide_relock = info.relock_area_wide or (info.last_activator == nil)
            if use_area_wide_relock then
                local players = Net.list_players(info.area_id) or {}
                for _, pid in ipairs(players) do
                    pcall(ezcheckpoints.relock_checkpoint, pid, info.area_id, info.relock_target)
                end
                local reason = info.relock_area_wide and "" or " (fallback: no per-player target)"
                logger:info("[ezbuttons] Area-wide relock for checkpoint " .. info.relock_target
                    .. " in area " .. info.area_id .. reason)
            elseif player_is_alive(info.last_activator) then
                logger:info("[ezbuttons] Explicit Relock Behavior: relocking " .. info.relock_target .. " for player " .. info.last_activator)
                pcall(ezcheckpoints.relock_checkpoint, info.last_activator, info.area_id, info.relock_target)
            else
                logger:info("[ezbuttons] Skipping explicit relock for checkpoint " .. info.relock_target
                    .. ": last activator is no longer connected")
            end
        end
    end

    enqueue_logic_event(area_id, object_id, false, info.last_activator)
    return true
end

local function reconcile_pending_button_state(area_id, object_id, info)
    if not info or info.is_animating or info.pending_state == nil then
        return
    end

    local desired_state = info.pending_state
    local desired_player_id = info.pending_player_id
    info.pending_state = nil
    info.pending_player_id = nil

    if is_button_active(area_id, object_id) == desired_state then
        return
    end

    if desired_state then
        activate_button(area_id, object_id, desired_player_id)
    else
        deactivate_button_internal(area_id, object_id, info)
    end
end

deactivate_button_internal = function(area_id, object_id, info)
    if not info then
        info = button_placeholders[area_id] and button_placeholders[area_id][tostring(object_id)]
        if not info then
            logger:info("[ezbuttons] No button info for", object_id)
            return false
        end
    end

    info.timer_generation = (info.timer_generation or 0) + 1
    info.timed_cancel = true

    if info.is_animating then
        info.pending_state = false
        info.pending_player_id = nil
        logger:info("[ezbuttons] Button", object_id, "is animating; queued deactivation")
        return true
    end

    if not is_button_active(area_id, object_id) then
        logger:info("[ezbuttons] Button", object_id, "already inactive")
        return false
    end

    local deactivation_anim = info.deactivation_anim
    local deactivation_duration = info.deactivation_duration or 0.5

    local function finish_deactivation()
        perform_deactivation(area_id, object_id, info)
        reconcile_pending_button_state(area_id, object_id, info)
    end

    if deactivation_anim and deactivation_anim ~= "" then
        info.is_animating = true
        async(function()
            set_button_animation(info.bot_id, deactivation_anim, false)
            await(Async.sleep(deactivation_duration))
            info.is_animating = false
            finish_deactivation()
        end)
        return true
    else
        finish_deactivation()
        return true
    end
end

local function start_timed_deactivation(area_id, object_id, info)
    info.timer_generation = (info.timer_generation or 0) + 1
    local timer_generation = info.timer_generation
    info.timed_cancel = false

    local delay = tonumber(info.activated_time) or 0
    if delay < 0 then delay = 0 end
    logger:info(string.format("   [DEBUG] Timed deactivation scheduled for button %s in %.2f seconds (generation %d)", tostring(object_id), delay, timer_generation))

    async(function()
        await(Async.sleep(delay))
        if info.timed_cancel or info.timer_generation ~= timer_generation then
            logger:info("   [DEBUG] Timed deactivation CANCELLED for button " .. tostring(object_id) .. " (generation " .. tostring(timer_generation) .. ")")
            return
        end
        if is_button_active(area_id, object_id) then
            logger:info("   [DEBUG] Timed deactivation FIRING for button " .. tostring(object_id) .. " (generation " .. tostring(timer_generation) .. ")")
            deactivate_button_internal(area_id, object_id, info)
        else
            logger:info("   [DEBUG] Button " .. tostring(object_id) .. " already inactive, skipping timed deactivation")
        end
    end)
end

activate_button = function(area_id, object_id, player_id)
    object_id = tostring(object_id)
    local info = button_placeholders[area_id] and button_placeholders[area_id][object_id]
    if not info then
        logger:info("[ezbuttons] No button info for", object_id)
        return false
    end

    if info.is_animating then
        info.pending_state = true
        info.pending_player_id = player_id
        logger:info("[ezbuttons] Button", object_id, "is animating; queued activation")
        return true
    end

    if is_button_active(area_id, object_id) then
        logger:info("[ezbuttons] Button", object_id, "already active")
        return false
    end

    local activation_anim = info.activation_anim
    local activation_duration = info.activation_duration or 0.5

    if activation_anim and activation_anim ~= "" then
        info.is_animating = true
        async(function()
            set_button_animation(info.bot_id, activation_anim, false)
            await(Async.sleep(activation_duration))
            info.is_animating = false
            perform_activation(area_id, object_id, player_id, info)
            reconcile_pending_button_state(area_id, object_id, info)
        end)
        return true
    else
        return perform_activation(area_id, object_id, player_id, info)
    end
end

deactivate_button = function(area_id, object_id)
    object_id = tostring(object_id)
    local info = button_placeholders[area_id] and button_placeholders[area_id][object_id]
    if not info then
        logger:info("[ezbuttons] No button info for", object_id)
        return false
    end

    return deactivate_button_internal(area_id, object_id, info)
end

local function load_custom_script(script_path)
    if not script_path or script_path == "" then
        return nil, "No script path provided"
    end
    if custom_script_cache[script_path] then
        return custom_script_cache[script_path], nil
    end
    local module_path = script_path:gsub("%.lua$", "")
    local ok, module = pcall(require, module_path)
    if not ok then
        return nil, "Failed to load script: " .. tostring(module)
    end
    if type(module.on_enter) ~= "function" then
        return nil, "Custom script must provide an on_enter function"
    end
    custom_script_cache[script_path] = module
    return module, nil
end

-- ============================================================
-- OBJECT REGISTRY HANDLER FOR "OW BUTTON"
-- ============================================================
local function register_button_object(area_id, object, group_member)
    validate_button_object(area_id, object)

    local props = object.custom_properties or {}
    group_member = group_member == true

    local bot_details_obj_id = props["Bot Details"]
    if not bot_details_obj_id or bot_details_obj_id == "" then
        logger:info("[ezbuttons] OW Button missing Bot Details reference, skipping", object.id)
        return
    end

    local bot_details_obj = Net.get_object_by_id(area_id, tostring(bot_details_obj_id))
    if not bot_details_obj then
        logger:warn("[ezbuttons] OW Button Bot Details object not found in area", area_id, "for button", object.id)
        return
    end

    local details_props = bot_details_obj.custom_properties or {}
    local asset_name = details_props["Asset Name"]
    local direction = details_props["Direction"]
    if not asset_name or not direction then
        logger:info("[ezbuttons] OW Button Bot Details missing Asset Name or Direction, skipping button", object.id)
        return
    end

    local animation_name = details_props["Animation Name"]
    local mug_animation_name = details_props["Mug Animation Name"]
    local active_anim = details_props["Active Animation"] or "ACTIVE"
    local inactive_anim = details_props["Inactive Animation"] or "INACTIVE"
    local activation_anim = details_props["Activated Animation"] or nil
    local deactivation_anim = details_props["Deactivated Animation"] or nil
    local activation_duration =
        tu.get_number_from(details_props, "Activation Animation Duration", 0.5)
    local deactivation_duration =
        tu.get_number_from(details_props, "Deactivation Animation Duration", 0.5)

    local bot_name = object.name

    local behavior = props["Button Behavior"] or "One-Time"
    local script_path = props["Script Path"] or nil
    local activated_time = tu.get_number_from(props, "Activated Time", 1)

    local unlock_checkpoint_obj = nil
    local unlock_permanently = true
    local unlock_area_wide = false
    local behavior_obj_id = props["Button Activated Behavior"]
    if behavior_obj_id and behavior_obj_id ~= "" then
        local behavior_obj = Net.get_object_by_id(area_id, tostring(behavior_obj_id))
        if behavior_obj then
            local beh_props = behavior_obj.custom_properties or {}
            unlock_checkpoint_obj = beh_props["Unlock This"]
            unlock_permanently = read_bool(beh_props["Unlock Permanently"], true)
            unlock_area_wide = read_bool(beh_props["Area Wide"], false)
            logger:info(string.format("   [DEBUG] Button %s: Unlock Behavior -> checkpoint=%s, permanent=%s, area_wide=%s",
                  tostring(object.id), tostring(unlock_checkpoint_obj), tostring(unlock_permanently), tostring(unlock_area_wide)))
        else
            logger:for_area(area_id):warn("[ezbuttons] Warning: Unlock Behavior object", behavior_obj_id, "not found in area", area_id)
        end
    end

    local relock_target = nil
    local relock_area_wide = false
    local deactivated_behavior_id = props["Button Deactivated Behavior"]
    if deactivated_behavior_id and deactivated_behavior_id ~= "" then
        local relock_obj = Net.get_object_by_id(area_id, tostring(deactivated_behavior_id))
        if relock_obj then
            local relock_props = relock_obj.custom_properties or {}
            relock_target = relock_props["Relock This"]
            relock_area_wide = read_bool(relock_props["Area Wide"], false)
            if relock_target and relock_target ~= "" then
                logger:info("[ezbuttons] Button " .. tostring(object.id) .. " will relock checkpoint " .. relock_target .. " on deactivation (area_wide=" .. tostring(relock_area_wide) .. ")")
            else
                logger:for_area(area_id):warn("[ezbuttons] Warning: Relock Behavior object " .. deactivated_behavior_id .. " does not have a valid Relock This property")
                relock_target = nil
            end
        else
            logger:for_area(area_id):warn("[ezbuttons] Warning: Relock Behavior object", deactivated_behavior_id, "not found in area", area_id)
        end
    end

    local bot_x, bot_y, bot_z = object_to_tile_pos(object)
    local bot_id = create_button_bot(area_id, asset_name, bot_x, bot_y,
                                     bot_z, direction, bot_name,
                                     animation_name, mug_animation_name,
                                     inactive_anim)
    if not bot_id then return end

    local was_active = is_button_active(area_id, object.id)
    if was_active then
        set_button_animation(bot_id, active_anim, true)
    else
        set_button_animation(bot_id, inactive_anim, true)
    end

    if not button_placeholders[area_id] then
        button_placeholders[area_id] = {}
    end

    local trigger_source_obj = object
    local trigger_type = "rect"
    local trigger_width_px = 4
    local trigger_height_px = 4

    local trigger_obj_id = props["Trigger Object"]
    if trigger_obj_id and trigger_obj_id ~= "" then
        local trigger_obj = Net.get_object_by_id(area_id, trigger_obj_id)
        if trigger_obj then
            trigger_source_obj = trigger_obj
            trigger_type = (trigger_obj.custom_properties and trigger_obj.custom_properties["Trigger Type"]) or "rect"
            trigger_width_px = tonumber(trigger_obj.width) or trigger_width_px
            trigger_height_px = tonumber(trigger_obj.height) or trigger_height_px
        else
            trigger_type = props["Trigger Type"] or "rect"
            trigger_width_px = props["Trigger Width"] or 4
            trigger_height_px = props["Trigger Height"] or 4
        end
    else
        trigger_type = props["Trigger Type"] or "rect"
        trigger_width_px = props["Trigger Width"] or 4
        trigger_height_px = props["Trigger Height"] or 4
    end

    local info = {
        area_id = area_id,
        object_id = object.id,
        bot_id = bot_id,
        active_anim = active_anim,
        inactive_anim = inactive_anim,
        behavior = behavior,
        script_path = script_path,
        bot_x = bot_x,
        bot_y = bot_y,
        bot_z = bot_z,
        activation_anim = activation_anim,
        activation_duration = activation_duration,
        deactivation_anim = deactivation_anim,
        deactivation_duration = deactivation_duration,
        is_animating = false,
        pending_state = nil,
        pending_player_id = nil,
        trigger_players = {},
        trigger_bots = {},
        trigger_x = trigger_source_obj.x,
        trigger_y = trigger_source_obj.y,
        trigger_z = trigger_source_obj.z or 0,
        trigger_half_w = (TILE_SIZE / trigger_width_px) * 0.5,
        trigger_half_h = (TILE_SIZE / trigger_height_px) * 0.5,
        activated_time = activated_time,
        timed_cancel = false,
        timer_generation = 0,
        relock_target = relock_target,
        relock_area_wide = relock_area_wide,
        last_activator = nil,
        group_member = group_member,
        unlock_checkpoint_obj = unlock_checkpoint_obj,
        unlock_permanently = unlock_permanently,
        unlock_area_wide = unlock_area_wide,
    }

    button_placeholders[area_id][tostring(object.id)] = info
    button_bots[bot_id] = info

    for _, player_id in ipairs(Net.list_players(area_id) or {}) do
        hide_button_placeholder_for_player(player_id, area_id, object.id)
    end

    local trigger_id = "button_" .. area_id .. "_" .. tostring(object.id)

    -- Resolve custom handlers up-front so `behavior` reflects the
    -- post-fallback value when we decide whether to install a bot trigger.
    local custom_handlers = nil
    if behavior == "Custom" then
        local mod, err = load_custom_script(script_path)
        if not mod then
            logger:info("[ezbuttons] Custom script error for button", object.id, ":", err, "- falling back to One-Time")
            behavior = "One-Time"
        else
            custom_handlers = mod
        end
    end
    info.behavior = behavior
    info.custom_handlers = custom_handlers

    local bots_can_trigger = read_bool(props["Bots Can Trigger"]) and ezbottriggers ~= nil

    local emitter
    if trigger_type == "ellipse" then
        local center_x = trigger_width_px / 2
        local center_y = trigger_height_px / 2
        emitter = eztriggers.add_radius_trigger(area_id, trigger_source_obj, trigger_width_px,
                                                trigger_height_px, center_x, center_y, trigger_id)
    else
        emitter = create_button_trigger(area_id, trigger_source_obj, trigger_width_px, trigger_height_px, trigger_id)
    end

    if not emitter then
        logger:for_area(area_id):error("[ezbuttons] ❌ CRITICAL: Trigger creation failed for button", object.id)
        return
    end

    -- Optional bot trigger. Same rectangle / ellipse as the player trigger,
    -- but registered against ezbottriggers so NPC movement is tracked
    -- independently. `Custom` behavior is excluded because custom handlers
    -- receive a player_id and are not designed for bots.
    local bot_emitter = nil
    if bots_can_trigger then
        if behavior == "Custom" then
            logger:for_area(area_id):warn("[ezbuttons] Button", tostring(object.id),
                "has Bots Can Trigger=true but behavior is Custom; NPC triggers disabled for this button.")
        else
            local bot_trigger_id = "button_bot_" .. area_id .. "_" .. tostring(object.id)
            local ok_bot, result
            if trigger_type == "ellipse" then
                local center_x = trigger_width_px / 2
                local center_y = trigger_height_px / 2
                ok_bot, result = pcall(ezbottriggers.add_radius_trigger, area_id, trigger_source_obj,
                    trigger_width_px, trigger_height_px, center_x, center_y, bot_trigger_id)
            else
                ok_bot, result = pcall(ezbottriggers.add_rectangle_trigger, area_id, trigger_source_obj,
                    trigger_width_px, trigger_height_px, bot_trigger_id)
            end
            if ok_bot and result then
                bot_emitter = result
                logger:for_area(area_id):info("[ezbuttons] 🟢 NPC trigger registered for button", tostring(object.id))
            else
                logger:for_area(area_id):warn("[ezbuttons] ❌ Failed to register NPC trigger for button",
                    tostring(object.id), tostring(result))
            end
        end
    end

    -- Shared handler dispatch. `actor_type` is "player" or "bot"; the emitted
    -- event payloads differ (player_id vs bot_id) but the behavior rules and
    -- overlap bookkeeping are identical.
    local function resolve_actor_id(event, actor_type)
        if actor_type == "bot" then return event.bot_id end
        return event.player_id
    end

    local function mark_actor_present(actor_id, actor_type)
        if actor_type == "bot" then
            info.trigger_bots[actor_id] = true
        else
            info.trigger_players[actor_id] = true
        end
    end

    local function clear_actor_present(actor_id, actor_type)
        if actor_type == "bot" then
            info.trigger_bots[actor_id] = nil
        else
            info.trigger_players[actor_id] = nil
        end
    end

    local function on_button_entered(event, actor_type)
        if type(event) ~= "table" or not event.object
            or tostring(event.object.id) ~= tostring(trigger_source_obj.id) then
            logger:info("[ezbuttons] Ignoring enter event for mismatched trigger on button", tostring(object.id))
            return
        end
        local actor_id = resolve_actor_id(event, actor_type)
        if actor_id == nil then return end
        mark_actor_present(actor_id, actor_type)

        -- Bots never own per-player checkpoint unlocks or relocks, so they
        -- pass nil where the player's ID would normally flow through.
        local activator_player_id = (actor_type == "player") and actor_id or nil

        logger:info("[ezbuttons] 🟢 TRIGGER ENTERED:", actor_type, "button=", tostring(object.id),
            tostring(actor_type).."=", tostring(actor_id), "behavior=", behavior)

        if behavior == "Pressure Plate" then
            if not is_button_active(area_id, object.id) then
                activate_button(area_id, object.id, activator_player_id)
            elseif info.is_animating then
                info.pending_state = true
                info.pending_player_id = activator_player_id
            end
        elseif behavior == "One-Time" then
            if not is_button_active(area_id, object.id) then
                activate_button(area_id, object.id, activator_player_id)
            end
        elseif behavior == "Toggle" then
            if info.is_animating then
                local current_target = info.pending_state
                if current_target == nil then
                    current_target = is_button_active(area_id, object.id)
                end
                info.pending_state = not current_target
                info.pending_player_id = info.pending_state and activator_player_id or nil
                logger:info("[ezbuttons] Toggle requested during animation; queued state:", tostring(info.pending_state))
            elseif is_button_active(area_id, object.id) then
                deactivate_button(area_id, object.id)
            else
                activate_button(area_id, object.id, activator_player_id)
            end
        elseif behavior == "Timed" then
            if not is_button_active(area_id, object.id) then
                if activate_button(area_id, object.id, activator_player_id) then
                    start_timed_deactivation(area_id, object.id, info)
                end
            end
        elseif behavior == "Custom" and actor_type == "player" and custom_handlers and custom_handlers.on_enter then
            custom_handlers.on_enter(actor_id, info)
        end
    end

    local function on_button_departed(event, actor_type)
        if type(event) ~= "table" or not event.object
            or tostring(event.object.id) ~= tostring(trigger_source_obj.id) then
            logger:info("[ezbuttons] Ignoring depart event for mismatched trigger on button", tostring(object.id))
            return
        end
        local actor_id = resolve_actor_id(event, actor_type)
        if actor_id == nil then return end
        clear_actor_present(actor_id, actor_type)

        logger:info("[ezbuttons] 🔴 TRIGGER DEPARTED:", actor_type, "button=", tostring(object.id),
            tostring(actor_type).."=", tostring(actor_id), "behavior=", behavior)

        if behavior == "Pressure Plate" then
            local someone_inside = next(info.trigger_players) ~= nil or next(info.trigger_bots) ~= nil
            if not someone_inside and is_button_active(area_id, object.id) then
                deactivate_button(area_id, object.id)
            elseif not someone_inside and info.is_animating then
                info.pending_state = false
                info.pending_player_id = nil
            end
        elseif behavior == "One-Time" then
            -- do nothing
        elseif behavior == "Toggle" then
            -- do nothing
        elseif behavior == "Timed" then
            -- Timer handles deactivation
        elseif behavior == "Custom" and actor_type == "player" and custom_handlers and custom_handlers.on_exit then
            custom_handlers.on_exit(actor_id, info)
        end
    end

    emitter:on("entered", function(event) on_button_entered(event, "player") end)
    emitter:on("departed", function(event) on_button_departed(event, "player") end)

    if bot_emitter then
        bot_emitter:on("entered", function(event) on_button_entered(event, "bot") end)
        bot_emitter:on("departed", function(event) on_button_departed(event, "bot") end)
    end

    info.trigger_info = emitter
    info.bot_trigger_info = bot_emitter
    logger:for_area(area_id):info("[ezbuttons] ✅ OW Button fully initialized:", object.id, "behavior=", behavior, "trigger size=", trigger_width_px, "x", trigger_height_px,
        "bots_can_trigger=", tostring(bot_emitter ~= nil))

    if not group_member and unlock_checkpoint_obj and unlock_checkpoint_obj ~= "" then
        logger:info("[ezbuttons] Button", object.id, "will unlock checkpoint", unlock_checkpoint_obj,
              "when activated (area_wide=" .. tostring(unlock_area_wide) .. ")")
    elseif group_member then
        logger:info("[ezbuttons] OW Button Group Member initialized:", tostring(object.id), "(checkpoint actions are group-owned)")
    end

    if try_configure_pending_groups then try_configure_pending_groups(area_id) end
    if try_configure_pending_combos then try_configure_pending_combos(area_id) end
end

object_registry.register_handler("OW Button", function(area_id, object)
    register_button_object(area_id, object, false)
end)

object_registry.register_handler("OW Button Group Member", function(area_id, object)
    register_button_object(area_id, object, true)
end)

-- Public API
function ezbuttons.is_button_active(area_id, object_id)
    return is_button_active(area_id, object_id)
end

function ezbuttons.activate_button(area_id, object_id, player_id)
    return activate_button(area_id, object_id, player_id)
end

function ezbuttons.deactivate_button(area_id, object_id)
    return deactivate_button(area_id, object_id)
end

function ezbuttons.reset_button(area_id, object_id)
    object_id = tostring(object_id)
    local info = button_placeholders[area_id] and button_placeholders[area_id][object_id]
    if info then
        local was_active = is_button_active(area_id, object_id)
        set_button_active_state(area_id, object_id, info.bot_id, info.active_anim, info.inactive_anim, false)
        if was_active then enqueue_logic_event(area_id, object_id, false, info.last_activator) end
        return true
    end
    return false
end

function ezbuttons.define_group(area_id, group_id, button_ids, mode, options)
    if type(area_id) ~= "string" and type(area_id) ~= "number" then error("define_group: area_id is required") end
    if type(group_id) ~= "string" and type(group_id) ~= "number" then error("define_group: group_id is required") end
    if type(button_ids) ~= "table" or #button_ids == 0 then error("define_group: button_ids must be a non-empty array") end
    mode = mode or "all_active"
    if mode ~= "all_active" and mode ~= "any_active" and mode ~= "combination" then
        error("define_group: mode must be all_active, any_active, or combination")
    end
    options = options or {}
    if options.on_change ~= nil and type(options.on_change) ~= "function" then
        error("define_group: options.on_change must be a function")
    end
    if options.forbidden_ids ~= nil and type(options.forbidden_ids) ~= "table" then
        error("define_group: options.forbidden_ids must be an array")
    end
    area_id, group_id = tostring(area_id), tostring(group_id)
    button_groups[area_id] = button_groups[area_id] or {}
    button_groups[area_id][group_id] = {
        button_ids = normalize_ids(button_ids),
        forbidden_ids = normalize_ids(options.forbidden_ids),
        mode = mode,
        callback = options.on_change,
        last_satisfied = nil
    }
    return true
end

function ezbuttons.on_group_change(area_id, group_id, callback)
    if type(callback) ~= "function" then error("on_group_change: callback must be a function") end
    local group = button_groups[tostring(area_id)] and button_groups[tostring(area_id)][tostring(group_id)]
    if not group then return false end
    group.callback = callback
    return true
end

function ezbuttons.add_button_effect(area_id, source_id, event_name, target_id, action)
    if event_name ~= "activated" and event_name ~= "deactivated" then error("add_button_effect: event must be activated or deactivated") end
    if target_id == nil then error("add_button_effect: target_id is required") end
    if action ~= "activate" and action ~= "deactivate" and action ~= "toggle" and action ~= "reset" then error("add_button_effect: invalid action") end
    area_id, source_id = tostring(area_id), tostring(source_id)
    button_effects[area_id] = button_effects[area_id] or {}
    button_effects[area_id][source_id] = button_effects[area_id][source_id] or {}
    button_effects[area_id][source_id][event_name] = button_effects[area_id][source_id][event_name] or {}
    table.insert(button_effects[area_id][source_id][event_name], { target_id = tostring(target_id), action = action })
    return true
end

function ezbuttons.add_group_effect(area_id, group_id, event_name, target_id, action)
    if event_name ~= "completed" and event_name ~= "incomplete" then error("add_group_effect: event must be completed or incomplete") end
    if target_id == nil then error("add_group_effect: target_id is required") end
    if action ~= "activate" and action ~= "deactivate" and action ~= "toggle" and action ~= "reset" then error("add_group_effect: invalid action") end
    area_id, group_id = tostring(area_id), tostring(group_id)
    group_effects[area_id] = group_effects[area_id] or {}
    group_effects[area_id][group_id] = group_effects[area_id][group_id] or {}
    group_effects[area_id][group_id][event_name] = group_effects[area_id][group_id][event_name] or {}
    table.insert(group_effects[area_id][group_id][event_name], { target_id = tostring(target_id), action = action })
    return true
end

function ezbuttons.refresh_groups(area_id, player_id)
    area_id = tostring(area_id)
    local groups = button_groups[area_id]
    if not groups then return false end
    for _, group in pairs(groups) do
        group.last_satisfied = group_is_satisfied(area_id, group)
    end
    return true
end

function ezbuttons.get_group_state(area_id, group_id)
    area_id, group_id = tostring(area_id), tostring(group_id)
    local groups = button_groups[area_id]
    local group = groups and groups[group_id]
    if not group then return nil end
    return group_is_satisfied(area_id, group)
end

local function property_ids(props, prefix)
    local numbered = {}
    for name, value in pairs(props or {}) do
        if type(name) == "string" then
            local suffix = name:match("^" .. prefix .. "(%d+)$")
            if suffix and value ~= nil and tostring(value) ~= "" then
                numbered[#numbered + 1] = { index = tonumber(suffix), value = tostring(value) }
            end
        end
    end
    table.sort(numbered, function(a, b) return a.index < b.index end)
    local ids = {}
    for _, entry in ipairs(numbered) do ids[#ids + 1] = entry.value end
    return ids
end

-- Group checkpoint action. Area-wide: applies to every live player. Per-player:
-- applies to the resolved target if still alive; otherwise skips with a log.
local function apply_group_checkpoint_action(area_id, player_id, checkpoint_ids, area_wide, unlock, permanent, group_id)
    if type(checkpoint_ids) ~= "table" then
        checkpoint_ids = checkpoint_ids ~= nil and checkpoint_ids ~= "" and { checkpoint_ids } or {}
    end
    if #checkpoint_ids == 0 then return end

    area_id = tostring(area_id)
    local area_mem = ezmemory.get_area_memory(area_id)

    for _, raw_checkpoint_id in ipairs(checkpoint_ids) do
        if raw_checkpoint_id ~= nil and tostring(raw_checkpoint_id) ~= "" then
            local checkpoint_id = tostring(raw_checkpoint_id)
            if area_wide then
                local players = Net.list_players(area_id) or {}
                for _, target_player_id in ipairs(players) do
                    local ok, err
                    if unlock then
                        ok, err = pcall(ezcheckpoints.force_unlock_checkpoint,
                            target_player_id, area_id, checkpoint_id, permanent)
                    else
                        ok, err = pcall(ezcheckpoints.relock_checkpoint,
                            target_player_id, area_id, checkpoint_id)
                    end
                    if not ok then
                        logger:warn("[ezbuttons] Group checkpoint action failed:", tostring(err))
                    end
                end

                area_mem.area_wide_unlock = area_mem.area_wide_unlock or {}
                local tracking_key = "button_group:" .. tostring(group_id or "") .. ":" .. checkpoint_id
                if unlock and not permanent then
                    area_mem.area_wide_unlock[tracking_key] = {
                        area_id = area_id,
                        checkpoint_object_id = checkpoint_id,
                        once = false,
                    }
                elseif not unlock then
                    for key, entry in pairs(area_mem.area_wide_unlock) do
                        if entry.area_id == area_id and tostring(entry.checkpoint_object_id) == checkpoint_id then
                            area_mem.area_wide_unlock[key] = nil
                        end
                    end
                end
            elseif player_id then
                if player_is_alive(player_id) then
                    local ok, err
                    if unlock then
                        ok, err = pcall(ezcheckpoints.force_unlock_checkpoint,
                            player_id, area_id, checkpoint_id, permanent)
                    else
                        ok, err = pcall(ezcheckpoints.relock_checkpoint,
                            player_id, area_id, checkpoint_id)
                    end
                    if not ok then
                        logger:warn("[ezbuttons] Group checkpoint action failed:", tostring(err))
                    end
                else
                    logger:info("[ezbuttons] Group checkpoint action skipped for checkpoint "
                        .. checkpoint_id .. ": triggering player is no longer connected")
                end
            else
                logger:info("[ezbuttons] Group checkpoint action skipped: no player ID and Area Wide is false")
            end
        end
    end

    if area_wide then
        ezmemory.save_area_memory(area_id)
    end
end

-- Resolve-and-route wrapper used by every group/combo callback. Resolves a
-- concrete player (or forces area-wide) when the triggerer can't be targeted,
-- on BOTH directions:
--
--   * unlock (satisfied):   previously only resolved here, to recover
--                           achievements lost to a disconnected triggerer.
--   * relock (incomplete):  resolves here too, so a bot clearing a pressure
--                           plate (or a disconnected triggerer) still reverses
--                           the checkpoint rather than silently skipping.
local function route_group_callback(area_id, group_ref, event_player_id,
                                    checkpoint_ids, area_wide, unlock, permanent, group_id, log_tag)
    local effective_player = event_player_id
    local force_area_wide = false

    if not effective_player or not player_is_alive(effective_player) then
        local resolved_player, use_area_wide, reason =
            resolve_transition_player(area_id, group_ref, effective_player)
        effective_player = resolved_player
        force_area_wide = use_area_wide
        logger:info("[ezbuttons]", log_tag,
            unlock and "satisfied" or "incomplete", "routing via", reason)
    end

    apply_group_checkpoint_action(area_id, effective_player, checkpoint_ids,
        area_wide or force_area_wide, unlock, permanent, group_id)
end

local function configure_group_object(area_id, object)
    validate_button_object(area_id, object)

    local props = object.custom_properties or {}
    local required_ids = property_ids(props, "Button ")
    local forbidden_ids = property_ids(props, "Forbidden Button ")
    if #required_ids == 0 then
        logger:info("[ezbuttons] Button Group has no required members:", tostring(object.id))
        return false
    end

    for _, button_id in ipairs(required_ids) do
        local info = button_placeholders[area_id] and button_placeholders[area_id][button_id]
        if not info or not info.group_member then return false end
    end
    for _, button_id in ipairs(forbidden_ids) do
        local info = button_placeholders[area_id] and button_placeholders[area_id][button_id]
        if not info or not info.group_member then return false end
    end

    local group_id = props["Group ID"]
    if group_id == nil or tostring(group_id) == "" then group_id = tostring(object.id) end
    group_id = tostring(group_id)
    local mode = props["Group Mode"] or "all_active"
    local unlock_checkpoints = property_ids(props, "Unlock Checkpoint ")
    local relock_checkpoints = property_ids(props, "Relock Checkpoint ")
    local unlock_permanently = read_bool(props["Unlock Permanently"], true)
    local unlock_area_wide = read_bool(props["Unlock Area Wide"], false)
    local relock_area_wide = read_bool(props["Relock Area Wide"], false)

    local ok, err = pcall(ezbuttons.define_group, area_id, group_id, required_ids, mode, {
        forbidden_ids = forbidden_ids,
        on_change = function(changed_area_id, changed_group_id, satisfied, player_id)
            local group_ref = button_groups[changed_area_id]
                and button_groups[changed_area_id][changed_group_id]
            if satisfied then
                route_group_callback(changed_area_id, group_ref, player_id,
                    unlock_checkpoints, unlock_area_wide, true, unlock_permanently,
                    changed_group_id, "Button Group " .. tostring(changed_group_id))
            elseif #relock_checkpoints > 0 then
                route_group_callback(changed_area_id, group_ref, player_id,
                    relock_checkpoints, relock_area_wide, false, false,
                    changed_group_id, "Button Group " .. tostring(changed_group_id))
            end
        end
    })
    if not ok then
        logger:warn("[ezbuttons] Failed to configure Button Group", tostring(object.id), tostring(err))
        return false
    end

    group_object_ids[area_id] = group_object_ids[area_id] or {}
    group_object_ids[area_id][tostring(object.id)] = group_id
    logger:for_area(area_id):info("[ezbuttons] Configured Button Group:", tostring(object.id), "group_id=", group_id, "mode=", tostring(mode), "members=", #required_ids)

    local pending = pending_group_effect_objects[area_id]
    if pending then
        for index = #pending, 1, -1 do
            local effect_object = pending[index]
            local effect_props = effect_object.custom_properties or {}
            if tostring(effect_props["Button Group"] or "") == tostring(object.id) then
                local target_id = effect_props["Target Button"]
                if target_id and target_id ~= "" then
                    local effect_ok, effect_err = pcall(ezbuttons.add_group_effect, area_id, group_id,
                        effect_props["Event"] or "completed", tostring(target_id), effect_props["Action"] or "activate")
                    if not effect_ok then logger:warn("[ezbuttons] Invalid Button Group Effect:", tostring(effect_err)) end
                end
                table.remove(pending, index)
            end
        end
    end
    return true
end

try_configure_pending_groups = function(area_id)
    local pending = pending_group_objects[area_id]
    if not pending then return end
    for index = #pending, 1, -1 do
        if configure_group_object(area_id, pending[index]) then
            table.remove(pending, index)
        end
    end
end

object_registry.register_handler("Button Group", function(area_id, object)
    validate_button_object(area_id, object)
    pending_group_objects[area_id] = pending_group_objects[area_id] or {}
    pending_group_objects[area_id][#pending_group_objects[area_id] + 1] = object
    try_configure_pending_groups(area_id)
end)

local function configure_button_combo_object(area_id, object)
    validate_button_object(area_id, object)

    local props = object.custom_properties or {}
    local required_ids = property_ids(props, "Button ")
    local forbidden_ids = property_ids(props, "Forbidden Button ")
    if #required_ids == 0 then
        logger:info("[ezbuttons] Button Combo has no required buttons:", tostring(object.id))
        return false
    end

    for _, button_id in ipairs(required_ids) do
        local info = button_placeholders[area_id] and button_placeholders[area_id][button_id]
        if not info or not info.group_member then return false end
    end
    for _, button_id in ipairs(forbidden_ids) do
        local info = button_placeholders[area_id] and button_placeholders[area_id][button_id]
        if not info or not info.group_member then return false end
    end

    local unlock_checkpoints = property_ids(props, "Unlock Checkpoint ")
    local relock_checkpoints = property_ids(props, "Relock Checkpoint ")

    combo_object_definitions[area_id] = combo_object_definitions[area_id] or {}
    combo_object_definitions[area_id][tostring(object.id)] = {
        object_id = tostring(object.id),
        button_ids = normalize_ids(required_ids),
        forbidden_ids = normalize_ids(forbidden_ids),
        unlock_checkpoints = unlock_checkpoints,
        relock_checkpoints = relock_checkpoints,
        unlock_permanently = read_bool(props["Unlock Permanently"], true),
        unlock_area_wide = read_bool(props["Unlock Area Wide"], false),
        relock_area_wide = read_bool(props["Relock Area Wide"], false),
    }
    logger:for_area(area_id):info("[ezbuttons] Configured Button Combo:", tostring(object.id),
        "required=", #required_ids, "forbidden=", #forbidden_ids)

    if try_configure_pending_combo_groups then
        try_configure_pending_combo_groups(area_id)
    end
    return true
end

try_configure_pending_combos = function(area_id)
    local pending = pending_combo_objects[area_id]
    if not pending then return end
    for index = #pending, 1, -1 do
        if configure_button_combo_object(area_id, pending[index]) then
            table.remove(pending, index)
        end
    end
end

object_registry.register_handler("Button Combo", function(area_id, object)
    validate_button_object(area_id, object)
    pending_combo_objects[area_id] = pending_combo_objects[area_id] or {}
    pending_combo_objects[area_id][#pending_combo_objects[area_id] + 1] = object
    if try_configure_pending_combos then try_configure_pending_combos(area_id) end
end)

local function configure_combo_button_group_object(area_id, object)
    validate_button_object(area_id, object)

    local props = object.custom_properties or {}
    local combo_object_ids = property_ids(props, "Button Combo ")
    if #combo_object_ids == 0 then
        logger:info("[ezbuttons] Combo Button Group has no Button Combo references:", tostring(object.id))
        return false
    end

    local group_id = props["Group ID"]
    if group_id == nil or tostring(group_id) == "" then group_id = tostring(object.id) end
    group_id = tostring(group_id)

    local combo_mode = props["Combo Mode"] or "Inclusive"
    if combo_mode ~= "Inclusive" and combo_mode ~= "Exclusive" then
        logger:warn("[ezbuttons] Combo Button Group has invalid Combo Mode:", tostring(object.id), tostring(combo_mode))
        return false
    end

    local combos = {}
    local known_combos = combo_object_definitions[area_id] or {}
    for _, combo_object_id in ipairs(combo_object_ids) do
        local definition = known_combos[tostring(combo_object_id)]
        if not definition then return false end

        local combo = {
            object_id = definition.object_id,
            button_ids = normalize_ids(definition.button_ids),
            forbidden_ids = normalize_ids(definition.forbidden_ids),
            mode = combo_mode,
        }
        combos[#combos + 1] = combo

        local combo_runtime_id = "combo:" .. group_id .. ":" .. definition.object_id
        button_groups[tostring(area_id)] = button_groups[tostring(area_id)] or {}
        button_groups[tostring(area_id)][combo_runtime_id] = {
            combo = combo,
            callback = function(changed_area_id, changed_group_id, satisfied, player_id)
                local group_ref = button_groups[changed_area_id]
                    and button_groups[changed_area_id][changed_group_id]
                if satisfied then
                    route_group_callback(changed_area_id, group_ref, player_id,
                        definition.unlock_checkpoints, definition.unlock_area_wide,
                        true, definition.unlock_permanently,
                        combo_runtime_id, "Button Combo " .. tostring(definition.object_id))
                elseif #definition.relock_checkpoints > 0 then
                    route_group_callback(changed_area_id, group_ref, player_id,
                        definition.relock_checkpoints, definition.relock_area_wide,
                        false, false,
                        combo_runtime_id, "Button Combo " .. tostring(definition.object_id))
                end
            end,
            last_satisfied = nil,
        }
    end

    button_groups[tostring(area_id)] = button_groups[tostring(area_id)] or {}
    button_groups[tostring(area_id)][group_id] = {
        combos = combos,
        callback = nil,
        last_satisfied = nil,
    }

    group_object_ids[area_id] = group_object_ids[area_id] or {}
    group_object_ids[area_id][tostring(object.id)] = group_id
    logger:for_area(area_id):info("[ezbuttons] Configured Combo Button Group:", tostring(object.id), "group_id=", group_id,
        "combos=", #combos, "mode=", combo_mode, "logic=any combo matches")

    local pending = pending_group_effect_objects[area_id]
    if pending then
        for index = #pending, 1, -1 do
            local effect_object = pending[index]
            local effect_props = effect_object.custom_properties or {}
            if tostring(effect_props["Button Group"] or "") == tostring(object.id) then
                local target_id = effect_props["Target Button"]
                if target_id and target_id ~= "" then
                    local effect_ok, effect_err = pcall(ezbuttons.add_group_effect, area_id, group_id,
                        effect_props["Event"] or "completed", tostring(target_id), effect_props["Action"] or "activate")
                    if not effect_ok then logger:warn("[ezbuttons] Invalid Button Group Effect:", tostring(effect_err)) end
                end
                table.remove(pending, index)
            end
        end
    end
    return true
end

try_configure_pending_combo_groups = function(area_id)
    local pending = pending_combo_group_objects[area_id]
    if not pending then return end
    for index = #pending, 1, -1 do
        if configure_combo_button_group_object(area_id, pending[index]) then
            table.remove(pending, index)
        end
    end
end

object_registry.register_handler("Combo Button Group", function(area_id, object)
    validate_button_object(area_id, object)
    pending_combo_group_objects[area_id] = pending_combo_group_objects[area_id] or {}
    pending_combo_group_objects[area_id][#pending_combo_group_objects[area_id] + 1] = object
    if try_configure_pending_combo_groups then try_configure_pending_combo_groups(area_id) end
end)

object_registry.register_handler("Button Effect", function(area_id, object)
    validate_button_object(area_id, object)
    local props = object.custom_properties or {}
    local source_id = props["Source Button"]
    local target_id = props["Target Button"]
    if source_id == nil or source_id == "" or target_id == nil or target_id == "" then
        logger:info("[ezbuttons] Button Effect missing Source Button or Target Button:", tostring(object.id))
        return
    end
    local ok, err = pcall(ezbuttons.add_button_effect, area_id, tostring(source_id),
        props["Event"] or "activated", tostring(target_id), props["Action"] or "activate")
    if not ok then logger:warn("[ezbuttons] Invalid Button Effect:", tostring(err)) end
end)

object_registry.register_handler("Button Group Effect", function(area_id, object)
    validate_button_object(area_id, object)
    local props = object.custom_properties or {}
    local group_object_id = props["Button Group"]
    local target_id = props["Target Button"]
    if group_object_id == nil or group_object_id == "" or target_id == nil or target_id == "" then
        logger:info("[ezbuttons] Button Group Effect missing Button Group or Target Button:", tostring(object.id))
        return
    end
    local group_id = group_object_ids[area_id] and group_object_ids[area_id][tostring(group_object_id)]
    if group_id then
        local ok, err = pcall(ezbuttons.add_group_effect, area_id, group_id,
            props["Event"] or "completed", tostring(target_id), props["Action"] or "activate")
        if not ok then logger:warn("[ezbuttons] Invalid Button Group Effect:", tostring(err)) end
    else
        pending_group_effect_objects[area_id] = pending_group_effect_objects[area_id] or {}
        table.insert(pending_group_effect_objects[area_id], object)
    end
end)

logger:info("[ezbuttons] Loaded (individual OW Buttons, Button Groups, Combo Button Groups, Button Combos, Tiled checkpoint actions, button/group effects, optional NPC triggers via ezbottriggers)")
return ezbuttons