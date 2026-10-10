-- ezbuttons.lua
-- Creates trigger-based buttons (non-solid NPCs).
-- Logical relationships are defined with groups and button/group effects.
-- Supports five interaction behaviors: Pressure Plate, One-Time, Toggle, Custom, Timed.
-- Supports area‑wide unlock/relock via "Area Wide" flag on Unlock/Relock Behavior objects.

local object_registry = require('scripts/ezlibs-scripts/object_registry')
local eznpcs = require('scripts/ezlibs-scripts/eznpcs/eznpcs')
local eztriggers = require('scripts/ezlibs-scripts/eztriggers')
local ezmemory = require('scripts/ezlibs-scripts/ezmemory')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local helpers = require('scripts/ezlibs-scripts/helpers')
local ezcheckpoints = require('scripts/ezlibs-scripts/ezcheckpoints')

function async(p)
    local co = coroutine.create(p)
    return Async.promisify(co)
end

function await(v) return Async.await(v) end


local ezbuttons = {}

local button_asset_folder = '/server/assets/ezlibs-assets/ezbuttons/'
local TILE_SIZE = 32

-- Cache for custom behavior scripts
local custom_script_cache = {}

-- Global table to keep strong references to all button triggers
local button_triggers = {}


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
local button_groups = {}       -- area_id -> group_id -> definition
local button_effects = {}      -- area_id -> source_button_id -> { [event] = { rules... } }
local group_effects = {}       -- area_id -> group_id -> { [event] = { rules... } }
local pending_group_objects = {} -- area_id -> Tiled Button Group objects waiting for member buttons
local group_object_ids = {}       -- area_id -> Tiled Button Group object ID -> runtime group ID
local pending_group_effect_objects = {} -- group effects waiting for their group definition
local try_configure_pending_groups
local logic_queue = {}
local processing_logic_queue = false
local MAX_LOGIC_EVENTS_PER_DRAIN = 1000

-- Group modes:
--   all_active: every member is active
--   any_active: at least one member is active
--   combination: every required member is active and every forbidden member is inactive
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

local function group_is_satisfied(area_id, group)
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
        print("[ezbuttons] Unknown logic action:", tostring(action))
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
        -- First observation establishes a baseline; later state changes emit events.
        if (previous == false and now == true) or
           (previous == true and now == false) or
           (previous == nil and now == true) then
            local group_event = now and "completed" or "incomplete"
            if type(group.callback) == "function" then
                local ok, err = pcall(group.callback, area_id, group_id, now, event.player_id)
                if not ok then print("[ezbuttons] Group callback failed:", tostring(err)) end
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
        if not ok then print("[ezbuttons] Logic event processing failed:", tostring(err)) end
    end
    if #logic_queue > 0 then
        print("[ezbuttons] Logic event limit reached; clearing queued events to prevent an infinite effect loop")
        logic_queue = {}
    end
    processing_logic_queue = false
end

-- Helper: hide the original Tiled placeholder object for a player
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
        print("[ezbuttons] animate failed bot=", tostring(bot_id), " anim=", tostring(anim_state), " err=", tostring(err))
    end
end

-- Sync all button animations in an area for a specific player
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

-- Apply any area‑wide unlock flags to a player who just entered the area
local function apply_area_wide_unlocks(player_id, area_id)
    if not player_id or not area_id then return end
    local area_mem = ezmemory.get_area_memory(area_id)
    if not area_mem.area_wide_unlock then return end

    for _, entry in pairs(area_mem.area_wide_unlock) do
        -- entry contains { area_id = checkpoint_area_id, checkpoint_object_id, once }
        pcall(ezcheckpoints.force_unlock_checkpoint, player_id, entry.area_id, entry.checkpoint_object_id, entry.once)
    end
end

Net:on("player_join", function(event)
    hide_button_placeholders_for_player(event.player_id)
    sync_button_animations_for_player(event.player_id)
    local ok, area_id = pcall(Net.get_player_area, event.player_id)
    if ok and area_id then
        apply_area_wide_unlocks(event.player_id, area_id)
    end
end)

Net:on("player_area_transfer", function(event)
    hide_button_placeholders_for_player(event.player_id)
    sync_button_animations_for_player(event.player_id)
    apply_area_wide_unlocks(event.player_id, event.new_area_id)
end)

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

    -- Diagnostic: explicitly provide the button texture and animation assets
    -- before creating the bot, then report whether either call raises an error.
    print("[ezbuttons] Button texture:", texture_path)
    print("[ezbuttons] Button animation:", animation_path)

    local texture_ok, texture_err = pcall(
        Net.provide_asset,
        area_id,
        texture_path
    )
    print("[ezbuttons] Texture provision:", texture_ok, texture_err or "")

    local animation_ok, animation_err = pcall(
        Net.provide_asset,
        area_id,
        animation_path
    )
    print("[ezbuttons] Animation provision:", animation_ok, animation_err or "")

    local bot_id = Net.create_bot(npc_data)
    if not bot_id then
        print("[ezbuttons] Failed to create bot for button", asset_name)
        return nil
    end
    print("[ezbuttons] created button bot id:", bot_id, "at", x, y, z)
    return bot_id
end

-- Active state from memory
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

-- Trigger creation
local function create_button_trigger(area_id, object, width_px, height_px, trigger_id)
    -- Preserve explicitly configured Tiled dimensions. The old minimum-size
    -- clamp expanded every rectangle smaller than 4 units to 4x4, even when
    -- the Tiled trigger intentionally measured less than 4 units.
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
        print("[ezbuttons] ✅ Trigger created successfully: " .. trigger_id)
    else
        print("[ezbuttons] ❌ FAILED to create trigger for " .. trigger_id)
    end
    return emitter
end

-- ============================================================
-- PERFORM ACTIVATION (with checkpoint unlocking, area-wide support)
-- ============================================================
perform_activation = function(area_id, object_id, player_id, info)
    if is_button_active(area_id, object_id) then
        return false
    end

    -- Remember who activated this button
    info.last_activator = player_id

    set_button_active_state(area_id, object_id, info.bot_id, info.active_anim, info.inactive_anim, true)
    print("[ezbuttons] Button", object_id, "activated by player", player_id)
    enqueue_logic_event(area_id, object_id, true, player_id)

    -- Group members only report their active state to group logic. Their checkpoint
    -- actions are owned by the Button Group object, never by an individual member.
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
            print("[ezbuttons] Area-wide checkpoint unlock applied by button " .. tostring(object_id))
        else
            local ok, err = pcall(ezcheckpoints.force_unlock_checkpoint, player_id, info.area_id, cp_id, info.unlock_permanently)
            if not ok then
                print("[ezbuttons] Failed to unlock checkpoint: " .. tostring(err))
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
        end
    end

    return true
end

-- ============================================================
-- PERFORM DEACTIVATION (with optional explicit Relock Behavior, area-wide support)
-- ============================================================
perform_deactivation = function(area_id, object_id, info)
    if not is_button_active(area_id, object_id) then
        return false
    end

    set_button_active_state(area_id, object_id, info.bot_id, info.active_anim, info.inactive_anim, false)
    print("[ezbuttons] Button", object_id, "deactivated")

    -- Individual buttons own their own relock behavior. Group members must not
    -- execute per-button relocks; the owning Button Group handles its transition.
    if not info.group_member then
    -- Automatic relock is scoped to this area and button ID.
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
        print("[ezbuttons] Area-wide checkpoint relock applied by button " .. object_key)
    else
        local unlocks = area_mem and area_mem.timed_button_unlock_info
        local unlock_info = unlocks and unlocks[object_key]
        if unlock_info then
            local ok, err = pcall(ezcheckpoints.relock_checkpoint, unlock_info.player_id, unlock_info.area_id, unlock_info.checkpoint_object_id)
            if not ok then print("[ezbuttons] Failed to relock checkpoint: " .. tostring(err)) end
            unlocks[object_key] = nil
            ezmemory.save_area_memory(area_id)
        end
    end

    -- Explicit Relock Behavior (independent of automatic)
    if info.relock_target then
        if info.relock_area_wide then
            -- Area‑wide explicit relock
            local players = Net.list_players(info.area_id) or {}
            for _, pid in ipairs(players) do
                pcall(ezcheckpoints.relock_checkpoint, pid, info.area_id, info.relock_target)
            end
            print("[ezbuttons] Explicit area‑wide relock for checkpoint " .. info.relock_target .. " in area " .. info.area_id)
        else
            -- Per‑player explicit relock
            if info.last_activator then
                print("[ezbuttons] Explicit Relock Behavior: relocking " .. info.relock_target .. " for player " .. info.last_activator)
                pcall(ezcheckpoints.relock_checkpoint, info.last_activator, info.area_id, info.relock_target)
            else
                print("[ezbuttons] No last_activator for explicit relock; cannot relock")
            end
        end
    end

    end -- not info.group_member

    enqueue_logic_event(area_id, object_id, false, info.last_activator)
    return true
end

-- Reconcile the requested state after an animation completes. Enter/exit
-- events may arrive while an animation is running; retain the latest request
-- instead of dropping it, then apply it once the current transition finishes.
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

-- Internal deactivation helper
deactivate_button_internal = function(area_id, object_id, info)
    if not info then
        info = button_placeholders[area_id] and button_placeholders[area_id][tostring(object_id)]
        if not info then
            print("[ezbuttons] No button info for", object_id)
            return false
        end
    end

    -- Invalidate every outstanding Timed timer, including one that is
    -- sleeping while an animation is in progress.
    info.timer_generation = (info.timer_generation or 0) + 1
    info.timed_cancel = true

    if info.is_animating then
        info.pending_state = false
        info.pending_player_id = nil
        print("[ezbuttons] Button", object_id, "is animating; queued deactivation")
        return true
    end

    if not is_button_active(area_id, object_id) then
        print("[ezbuttons] Button", object_id, "already inactive")
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

-- Start a timer that will deactivate the button after its activated_time
local function start_timed_deactivation(area_id, object_id, info)
    -- A generation token prevents an older sleeping timer from firing after a
    -- later activation has started a replacement timer.
    info.timer_generation = (info.timer_generation or 0) + 1
    local timer_generation = info.timer_generation
    info.timed_cancel = false

    local delay = tonumber(info.activated_time) or 0
    if delay < 0 then delay = 0 end
    print(string.format("   [DEBUG] Timed deactivation scheduled for button %s in %.2f seconds (generation %d)", tostring(object_id), delay, timer_generation))

    async(function()
        await(Async.sleep(delay))
        if info.timed_cancel or info.timer_generation ~= timer_generation then
            print("   [DEBUG] Timed deactivation CANCELLED for button " .. tostring(object_id) .. " (generation " .. tostring(timer_generation) .. ")")
            return
        end
        if is_button_active(area_id, object_id) then
            print("   [DEBUG] Timed deactivation FIRING for button " .. tostring(object_id) .. " (generation " .. tostring(timer_generation) .. ")")
            deactivate_button_internal(area_id, object_id, info)
        else
            print("   [DEBUG] Button " .. tostring(object_id) .. " already inactive, skipping timed deactivation")
        end
    end)
end

-- Public activate with optional animation
activate_button = function(area_id, object_id, player_id)
    object_id = tostring(object_id)
    local info = button_placeholders[area_id] and button_placeholders[area_id][object_id]
    if not info then
        print("[ezbuttons] No button info for", object_id)
        return false
    end

    if info.is_animating then
        info.pending_state = true
        info.pending_player_id = player_id
        print("[ezbuttons] Button", object_id, "is animating; queued activation")
        return true
    end

    if is_button_active(area_id, object_id) then
        print("[ezbuttons] Button", object_id, "already active")
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

-- Public deactivate with optional animation
deactivate_button = function(area_id, object_id)
    object_id = tostring(object_id)
    local info = button_placeholders[area_id] and button_placeholders[area_id][object_id]
    if not info then
        print("[ezbuttons] No button info for", object_id)
        return false
    end

    return deactivate_button_internal(area_id, object_id, info)
end

-- Load custom behavior script
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
    local props = object.custom_properties or {}

    -- OW Button Group Member is deliberately separate from OW Button. It uses the
    -- same trigger/visual machinery but never runs individual checkpoint actions.
    group_member = group_member == true

    -- Bot Details
    local bot_details_obj_id = props["Bot Details"]
    if not bot_details_obj_id or bot_details_obj_id == "" then
        print("[ezbuttons] OW Button missing Bot Details reference, skipping", object.id)
        return
    end

    local bot_details_obj = Net.get_object_by_id(area_id, tostring(bot_details_obj_id))
    if not bot_details_obj then
        print("[ezbuttons] OW Button Bot Details object not found in area", area_id, "for button", object.id)
        return
    end

    local details_props = bot_details_obj.custom_properties or {}
    local asset_name = details_props["Asset Name"]
    local direction = details_props["Direction"]
    if not asset_name or not direction then
        print("[ezbuttons] OW Button Bot Details missing Asset Name or Direction, skipping button", object.id)
        return
    end

    local animation_name = details_props["Animation Name"]
    local mug_animation_name = details_props["Mug Animation Name"]
    local active_anim = details_props["Active Animation"] or "ACTIVE"
    local inactive_anim = details_props["Inactive Animation"] or "INACTIVE"
    local activation_anim = details_props["Activated Animation"] or nil
    local deactivation_anim = details_props["Deactivated Animation"] or nil
    local activation_duration = tonumber(details_props["Activation Animation Duration"]) or 0.5
    local deactivation_duration = tonumber(details_props["Deactivation Animation Duration"]) or 0.5

    local bot_name = object.name

    -- Behavior properties
    local behavior = props["Button Behavior"] or "One-Time"
    local script_path = props["Script Path"] or nil
    local activated_time = tonumber(props["Activated Time"]) or 1

    -- ====== Unlock Behavior (activation) ======
    local unlock_checkpoint_obj = nil
    local unlock_permanently = true
    local unlock_area_wide = false
    local behavior_obj_id = props["Button Activated Behavior"]
    if behavior_obj_id and behavior_obj_id ~= "" then
        local behavior_obj = Net.get_object_by_id(area_id, tostring(behavior_obj_id))
        if behavior_obj then
            local beh_props = behavior_obj.custom_properties or {}
            unlock_checkpoint_obj = beh_props["Unlock This"]
            if beh_props["Unlock Permanently"] ~= nil then
                local val = beh_props["Unlock Permanently"]
                if type(val) == "boolean" then
                    unlock_permanently = val
                elseif type(val) == "string" then
                    unlock_permanently = (val:lower() == "true")
                end
            end
            -- Area Wide flag
            if beh_props["Area Wide"] ~= nil then
                local val = beh_props["Area Wide"]
                if type(val) == "boolean" then
                    unlock_area_wide = val
                elseif type(val) == "string" then
                    unlock_area_wide = (val:lower() == "true")
                end
            end
            print(string.format("   [DEBUG] Button %s: Unlock Behavior -> checkpoint=%s, permanent=%s, area_wide=%s",
                  tostring(object.id), tostring(unlock_checkpoint_obj), tostring(unlock_permanently), tostring(unlock_area_wide)))
        else
            print("[ezbuttons] Warning: Unlock Behavior object", behavior_obj_id, "not found in area", area_id)
        end
    end

    -- ====== Relock Behavior (deactivation) ======
    local relock_target = nil
    local relock_area_wide = false
    local deactivated_behavior_id = props["Button Deactivated Behavior"]
    if deactivated_behavior_id and deactivated_behavior_id ~= "" then
        local relock_obj = Net.get_object_by_id(area_id, tostring(deactivated_behavior_id))
        if relock_obj then
            local relock_props = relock_obj.custom_properties or {}
            relock_target = relock_props["Relock This"]
            -- Area Wide flag
            if relock_props["Area Wide"] ~= nil then
                local val = relock_props["Area Wide"]
                if type(val) == "boolean" then
                    relock_area_wide = val
                elseif type(val) == "string" then
                    relock_area_wide = (val:lower() == "true")
                end
            end
            if relock_target and relock_target ~= "" then
                print("[ezbuttons] Button " .. tostring(object.id) .. " will relock checkpoint " .. relock_target .. " on deactivation (area_wide=" .. tostring(relock_area_wide) .. ")")
            else
                print("[ezbuttons] Warning: Relock Behavior object " .. deactivated_behavior_id .. " does not have a valid Relock This property")
                relock_target = nil
            end
        else
            print("[ezbuttons] Warning: Relock Behavior object", deactivated_behavior_id, "not found in area", area_id)
        end
    end

    -- Bot creation
    local bot_x, bot_y, bot_z = object_to_tile_pos(object)
    local bot_id = create_button_bot(area_id, asset_name, bot_x, bot_y,
                                     bot_z, direction, bot_name,
                                     animation_name, mug_animation_name,
                                     inactive_anim)
    if not bot_id then return end

    -- Restore saved active state
    local was_active = is_button_active(area_id, object.id)
    if was_active then
        set_button_animation(bot_id, active_anim, true)
    else
        set_button_animation(bot_id, inactive_anim, true)
    end

    -- Store placeholder info
    if not button_placeholders[area_id] then
        button_placeholders[area_id] = {}
    end

    -- Determine trigger source
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

    -- Build info table (including relock_target, relock_area_wide, last_activator)
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

    -- Hide original object
    for _, player_id in ipairs(Net.list_players(area_id) or {}) do
        hide_button_placeholder_for_player(player_id, area_id, object.id)
    end

    -- Create trigger
    local trigger_id = "button_" .. area_id .. "_" .. tostring(object.id)
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
        print("[ezbuttons] ❌ CRITICAL: Trigger creation failed for button", object.id)
        return
    end

    -- Custom script handlers
    local custom_handlers = nil
    if behavior == "Custom" then
        local mod, err = load_custom_script(script_path)
        if not mod then
            print("[ezbuttons] Custom script error for button", object.id, ":", err, "- falling back to One-Time")
            behavior = "One-Time"
        else
            custom_handlers = mod
        end
    end

    info.behavior = behavior
    info.custom_handlers = custom_handlers

    -- Enter handler
    emitter:on("entered", function(event)
        if type(event) ~= "table" or not event.object
            or tostring(event.object.id) ~= tostring(trigger_source_obj.id) then
            print("[ezbuttons] Ignoring enter event for mismatched trigger on button", tostring(object.id))
            return
        end
        local player_id = event.player_id
        if player_id == nil then return end
        info.trigger_players[player_id] = true
        print("[ezbuttons] 🟢 TRIGGER ENTERED: button=", tostring(object.id), " player=", tostring(player_id), " behavior=", behavior)

        if behavior == "Pressure Plate" then
            if not is_button_active(area_id, object.id) then
                activate_button(area_id, object.id, player_id)
            elseif info.is_animating then
                -- A deactivation may already be in progress. The latest
                -- occupancy requires the button to end in the active state.
                info.pending_state = true
                info.pending_player_id = player_id
            end
        elseif behavior == "One-Time" then
            if not is_button_active(area_id, object.id) then
                activate_button(area_id, object.id, player_id)
            end
        elseif behavior == "Toggle" then
            if info.is_animating then
                local current_target = info.pending_state
                if current_target == nil then
                    current_target = is_button_active(area_id, object.id)
                end
                info.pending_state = not current_target
                info.pending_player_id = info.pending_state and player_id or nil
                print("[ezbuttons] Toggle requested during animation; queued state:", tostring(info.pending_state))
            elseif is_button_active(area_id, object.id) then
                deactivate_button(area_id, object.id)
            else
                activate_button(area_id, object.id, player_id)
            end
        elseif behavior == "Timed" then
            if not is_button_active(area_id, object.id) then
                if activate_button(area_id, object.id, player_id) then
                    start_timed_deactivation(area_id, object.id, info)
                end
            end
        elseif behavior == "Custom" and custom_handlers and custom_handlers.on_enter then
            custom_handlers.on_enter(player_id, info)
        end
    end)

    -- Depart handler
    emitter:on("departed", function(event)
        if type(event) ~= "table" or not event.object
            or tostring(event.object.id) ~= tostring(trigger_source_obj.id) then
            print("[ezbuttons] Ignoring depart event for mismatched trigger on button", tostring(object.id))
            return
        end
        local player_id = event.player_id
        if player_id == nil then return end
        info.trigger_players[player_id] = nil
        print("[ezbuttons] 🔴 TRIGGER DEPARTED: button=", tostring(object.id), " player=", tostring(player_id), " behavior=", behavior)

        if behavior == "Pressure Plate" then
            local someone_inside = next(info.trigger_players) ~= nil
            if not someone_inside and is_button_active(area_id, object.id) then
                deactivate_button(area_id, object.id)
            elseif not someone_inside and info.is_animating then
                -- Queue the inactive state even if activation has not committed yet.
                info.pending_state = false
                info.pending_player_id = nil
            end
        elseif behavior == "One-Time" then
            -- do nothing
        elseif behavior == "Toggle" then
            -- do nothing (deactivation happens on next enter via toggle)
        elseif behavior == "Timed" then
            -- Timer handles deactivation, do nothing on depart
        elseif behavior == "Custom" and custom_handlers and custom_handlers.on_exit then
            custom_handlers.on_exit(player_id, info)
        end
    end)

    info.trigger_info = emitter
    print("[ezbuttons] ✅ OW Button fully initialized:", object.id, "behavior=", behavior, "trigger size=", trigger_width_px, "x", trigger_height_px)

    if not group_member and unlock_checkpoint_obj and unlock_checkpoint_obj ~= "" then
        print("[ezbuttons] Button", object.id, "will unlock checkpoint", unlock_checkpoint_obj,
              "when activated (area_wide=" .. tostring(unlock_area_wide) .. ")")
    elseif group_member then
        print("[ezbuttons] OW Button Group Member initialized:", tostring(object.id), "(checkpoint actions are group-owned)")
    end

    if try_configure_pending_groups then
        try_configure_pending_groups(area_id)
    end
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

-- Define a logical group. button_ids are Tiled object IDs within area_id.
-- mode is "all_active", "any_active", or "combination". For a combination,
-- all button_ids must be active and options.forbidden_ids must all be inactive.
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

-- Set or replace a callback. It runs only when the group's satisfied state changes,
-- after the first observed baseline has been recorded.
function ezbuttons.on_group_change(area_id, group_id, callback)
    if type(callback) ~= "function" then error("on_group_change: callback must be a function") end
    local group = button_groups[tostring(area_id)] and button_groups[tostring(area_id)][tostring(group_id)]
    if not group then return false end
    group.callback = callback
    return true
end

-- A button effect runs when the source changes state. event is "activated" or "deactivated".
-- action is "activate", "deactivate", "toggle", or "reset". Target must be in same area.
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

-- Run an action when a group changes to "completed" or "incomplete".
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

-- Recalculate group states after definitions are added or after saved button states are restored.
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

local function property_ids(props, prefix, first, last)
    local ids = {}
    for i = first, last do
        local value = props[prefix .. tostring(i)]
        if value ~= nil and value ~= "" then
            ids[#ids + 1] = tostring(value)
        end
    end
    return ids
end

local function read_bool(value, default)
    if value == nil then return default end
    if type(value) == "boolean" then return value end
    if type(value) == "number" then return value ~= 0 end
    if type(value) == "string" then return value:lower() == "true" or value == "1" end
    return default
end

local function apply_group_checkpoint_action(area_id, player_id, checkpoint_id, area_wide, unlock, permanent)
    if checkpoint_id == nil or checkpoint_id == "" then return end
    checkpoint_id = tostring(checkpoint_id)

    if area_wide then
        local players = Net.list_players(area_id) or {}
        for _, target_player_id in ipairs(players) do
            local ok, err
            if unlock then
                ok, err = pcall(ezcheckpoints.force_unlock_checkpoint, target_player_id, area_id, checkpoint_id, permanent)
            else
                ok, err = pcall(ezcheckpoints.relock_checkpoint, target_player_id, area_id, checkpoint_id)
            end
            if not ok then
                print("[ezbuttons] Group checkpoint action failed:", tostring(err))
            end
        end
    elseif player_id then
        local ok, err
        if unlock then
            ok, err = pcall(ezcheckpoints.force_unlock_checkpoint, player_id, area_id, checkpoint_id, permanent)
        else
            ok, err = pcall(ezcheckpoints.relock_checkpoint, player_id, area_id, checkpoint_id)
        end
        if not ok then
            print("[ezbuttons] Group checkpoint action failed:", tostring(err))
        end
    else
        print("[ezbuttons] Group checkpoint action skipped: no player ID and Area Wide is false")
    end
end

local function configure_group_object(area_id, object)
    local props = object.custom_properties or {}
    local required_ids = property_ids(props, "Button ", 1, 10)
    local forbidden_ids = property_ids(props, "Forbidden Button ", 1, 10)
    if #required_ids == 0 then
        print("[ezbuttons] Button Group has no required members:", tostring(object.id))
        return false
    end

    -- Tiled object load order is not guaranteed. Wait until all required and forbidden
    -- references resolve to registered OW Button Group Member objects.
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
    local unlock_checkpoint = props["Unlock Checkpoint"]
    local unlock_permanently = read_bool(props["Unlock Permanently"], true)
    local unlock_area_wide = read_bool(props["Unlock Area Wide"], false)
    local relock_checkpoint = props["Relock Checkpoint"]
    local relock_area_wide = read_bool(props["Relock Area Wide"], false)

    local ok, err = pcall(ezbuttons.define_group, area_id, group_id, required_ids, mode, {
        forbidden_ids = forbidden_ids,
        on_change = function(changed_area_id, changed_group_id, satisfied, player_id)
            if satisfied then
                apply_group_checkpoint_action(changed_area_id, player_id, unlock_checkpoint, unlock_area_wide, true, unlock_permanently)
            elseif relock_checkpoint and relock_checkpoint ~= "" then
                apply_group_checkpoint_action(changed_area_id, player_id, relock_checkpoint, relock_area_wide, false, false)
            end
        end
    })
    if not ok then
        print("[ezbuttons] Failed to configure Button Group", tostring(object.id), tostring(err))
        return false
    end

    group_object_ids[area_id] = group_object_ids[area_id] or {}
    group_object_ids[area_id][tostring(object.id)] = group_id
    print("[ezbuttons] Configured Button Group:", tostring(object.id), "group_id=", group_id, "mode=", tostring(mode), "members=", #required_ids)

    -- Register group effects that may have appeared earlier in the Tiled object list.
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
                    if not effect_ok then print("[ezbuttons] Invalid Button Group Effect:", tostring(effect_err)) end
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
    pending_group_objects[area_id] = pending_group_objects[area_id] or {}
    pending_group_objects[area_id][#pending_group_objects[area_id] + 1] = object
    try_configure_pending_groups(area_id)
end)

object_registry.register_handler("Button Effect", function(area_id, object)
    local props = object.custom_properties or {}
    local source_id = props["Source Button"]
    local target_id = props["Target Button"]
    if source_id == nil or source_id == "" or target_id == nil or target_id == "" then
        print("[ezbuttons] Button Effect missing Source Button or Target Button:", tostring(object.id))
        return
    end
    local ok, err = pcall(ezbuttons.add_button_effect, area_id, tostring(source_id),
        props["Event"] or "activated", tostring(target_id), props["Action"] or "activate")
    if not ok then print("[ezbuttons] Invalid Button Effect:", tostring(err)) end
end)

object_registry.register_handler("Button Group Effect", function(area_id, object)
    local props = object.custom_properties or {}
    local group_object_id = props["Button Group"]
    local target_id = props["Target Button"]
    if group_object_id == nil or group_object_id == "" or target_id == nil or target_id == "" then
        print("[ezbuttons] Button Group Effect missing Button Group or Target Button:", tostring(object.id))
        return
    end
    local group_id = group_object_ids[area_id] and group_object_ids[area_id][tostring(group_object_id)]
    if group_id then
        local ok, err = pcall(ezbuttons.add_group_effect, area_id, group_id,
            props["Event"] or "completed", tostring(target_id), props["Action"] or "activate")
        if not ok then print("[ezbuttons] Invalid Button Group Effect:", tostring(err)) end
    else
        pending_group_effect_objects[area_id] = pending_group_effect_objects[area_id] or {}
        table.insert(pending_group_effect_objects[area_id], object)
    end
end)

print("[ezbuttons] Loaded (individual OW Buttons, group-only OW Button Group Members, Tiled group checkpoint actions, button/group effects)")
return ezbuttons
