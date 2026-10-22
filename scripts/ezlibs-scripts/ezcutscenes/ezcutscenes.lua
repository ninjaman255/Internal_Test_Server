-- ezcutscenes.lua
-- Tiled-authored cutscene system.
--
-- A Cutscene object names a chain of Cutscene Step objects. Each step
-- performs one action (move an actor, show a message, ask a quiz, etc.).
-- Steps chain via `Next Step` refs; branching steps use `Next 1/2/3` and
-- `Fail Next`.
--
-- Interactive vs non-interactive:
--   Show Message / Ask Quiz / Prompt Player are interactive. They run
--   through Async.message_player / quiz_player / prompt_player, which are
--   modal dialogs. Net.lock_player_input only blocks world interaction and
--   movement; those dialog APIs run their own input path, so the cutscene
--   works while input is locked.
--
--   Wait / Set Pose / Move Actor / Play Sound / Fade Camera / Move Camera /
--   Emit Event are non-interactive. They animate actors, play audio, or
--   emit bus events without touching player input.
--
-- Player input is locked at cutscene start and unconditionally unlocked
-- before the cutscene promise resolves. The chain runner is wrapped in
-- pcall so an unexpected error mid-cutscene still reaches the unlock.
--
-- Movement targets:
--   Move Actor / Move Camera resolve their destination in this order:
--     1. `Target` (point object reference)
--     2. `Target X/Y/Z` (explicit numbers)
--     3. The Cutscene Step object's own (x, y, z) in Tiled
--   The third option means map makers can place the step node at the
--   destination and skip the separate target point.

local logger = require('scripts/ezlibs-scripts/ezlogger').get('ezcutscenes')
local object_registry = require('scripts/ezlibs-scripts/object_registry')
local ezcache = require('scripts/ezlibs-scripts/ezcache')
local eznpcs = require('scripts/ezlibs-scripts/eznpcs/eznpcs')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local eztriggers = require('scripts/ezlibs-scripts/eztriggers/eztriggers')
local tu = require('scripts/ezlibs-scripts/utils/eztiledutils')
local StepTypes = require('scripts/ezlibs-scripts/ezcutscenes/step_types')

local ezcutscenes = {}

local registered_cutscenes = {}
local active_cutscenes = {}
local once_state = {}

local MAX_STEPS_PER_RUN = 250

local function get_props(object)
    return object and object.custom_properties or {}
end

local function resolve_object_cached(area_id, object_id)
    if object_id == nil then return nil end
    local id = tonumber(object_id) or object_id
    local ok, object = pcall(ezcache.get_object_by_id_cached, area_id, id)
    if ok and object then return object end
    if type(Net.get_object_by_id) == "function" then
        local ok2, object2 = pcall(Net.get_object_by_id, area_id, id)
        if ok2 then return object2 end
    end
    return nil
end

local function choose_next_step_ref(step_props, step_type_name, result)
    if step_type_name == "Ask Quiz" then
        local choice = tonumber(result)
        if choice then
            local specific = step_props["Next " .. tostring(choice + 1)]
            if specific ~= nil and specific ~= "" then return specific end
        end
        return step_props["Next Step"]
    end
    if step_type_name == "Prompt Player" then
        if type(result) == "table" and result.success == false then
            local fail_next = step_props["Fail Next"]
            if fail_next ~= nil and fail_next ~= "" then return fail_next end
            return nil
        end
        return step_props["Next Step"]
    end
    return step_props["Next Step"]
end

-- Step handlers receive (context, props, step_object). The third argument
-- lets movement / camera steps fall back to the step node's own Tiled
-- placement when no explicit target is configured.
local function run_step_chain(context, first_step_ref)
    local current_ref = first_step_ref
    local count = 0

    while current_ref ~= nil and current_ref ~= "" and not context.cancelled do
        count = count + 1
        if count > MAX_STEPS_PER_RUN then
            logger:for_player(context.player_id):warn(
                "[ezcutscenes] step limit exceeded ("
                .. tostring(MAX_STEPS_PER_RUN) .. "), aborting: "
                .. tostring(context.cutscene_name))
            return
        end

        local step_object = resolve_object_cached(context.area_id, current_ref)
        if not step_object then
            logger:for_player(context.player_id):warn(
                "[ezcutscenes] cannot resolve step ref: " .. tostring(current_ref))
            return
        end

        local props = get_props(step_object)
        local step_type = tu.get_string_from(props, "Type", "")
        local handler = StepTypes.DISPATCH[step_type]
        if not handler then
            logger:for_player(context.player_id):warn(
                "[ezcutscenes] unknown step type: " .. tostring(step_type))
            return
        end

        local ok, result = pcall(function()
            return Async.await(handler(context, props, step_object))
        end)
        if not ok then
            logger:for_player(context.player_id):warn(
                "[ezcutscenes] step handler failed (" .. tostring(step_type)
                .. "): " .. tostring(result))
            return
        end

        current_ref = choose_next_step_ref(props, step_type, result)
    end
end

local function run_cutscene(player_id, area_id, cutscene_object, trigger_context)
    local props = get_props(cutscene_object)
    local cutscene_name = tu.get_string_from(props, "Name", "")
    local start_step = props["Start Step"]

    if not start_step or start_step == "" then
        logger:for_player(player_id):warn(
            "[ezcutscenes] cutscene has no Start Step: " .. tostring(cutscene_name))
        return nil
    end

    local context = {
        player_id        = player_id,
        area_id          = area_id,
        cutscene_name    = cutscene_name,
        cutscene_object  = cutscene_object,
        trigger_object_id = trigger_context and trigger_context.trigger_object_id or nil,
        trigger_bot_id    = trigger_context and trigger_context.trigger_bot_id or nil,
        resolve_object    = function(id) return resolve_object_cached(area_id, id) end,
        variables         = {},
        cancelled         = false,
    }
    active_cutscenes[player_id] = context

    local cleanup_bot_ids = {}
    if trigger_context and trigger_context.trigger_object_id then
        local bid = eznpcs.resolve_bot(area_id, trigger_context.trigger_object_id, player_id)
        if bid then cleanup_bot_ids[#cleanup_bot_ids + 1] = bid end
    end

    local promise = async(function()
        pcall(Net.lock_player_input, player_id)
        pcall(ezbus.emit, ezbus, "cutscene_started", {
            player_id = player_id,
            area_id = area_id,
            cutscene_name = cutscene_name,
        })

        -- Guard the chain runner: an unexpected error inside the loop should
        -- still reach the input unlock and cleanup below, not leave the
        -- player permanently locked out of movement.
        local ok_chain, err_chain = pcall(run_step_chain, context, start_step)
        if not ok_chain then
            logger:for_player(player_id):warn(
                "[ezcutscenes] step chain crashed: " .. tostring(err_chain))
        end

        for _, bot_id in ipairs(cleanup_bot_ids) do
            eznpcs.cancel_bot_hold(bot_id)
        end

        pcall(Net.unlock_player_input, player_id)

        if active_cutscenes[player_id] == context then
            active_cutscenes[player_id] = nil
        end

        if tu.get_boolean_from(props, "Once", false) then
            once_state[player_id] = once_state[player_id] or {}
            once_state[player_id][cutscene_name] = true
        end

        pcall(ezbus.emit, ezbus, "cutscene_completed", {
            player_id = player_id,
            area_id = area_id,
            cutscene_name = cutscene_name,
            cancelled = context.cancelled,
        })
    end)

    return promise
end

function ezcutscenes.start(player_id, area_id, cutscene_ref, trigger_context)
    if not Net.is_player(player_id) then return nil end
    if active_cutscenes[player_id] then
        logger:for_player(player_id):info(
            "[ezcutscenes] ignoring start; player already in a cutscene")
        return nil
    end

    local cutscene_object
    if type(cutscene_ref) == "table" then
        cutscene_object = cutscene_ref
    elseif type(cutscene_ref) == "string" then
        local entry = registered_cutscenes[area_id]
            and registered_cutscenes[area_id][cutscene_ref]
        if entry then cutscene_object = entry.object end
    end
    if not cutscene_object then
        logger:for_player(player_id):warn(
            "[ezcutscenes] cannot find cutscene: " .. tostring(cutscene_ref))
        return nil
    end

    local props = get_props(cutscene_object)
    if tu.get_boolean_from(props, "Once", false) then
        local cutscene_name = tu.get_string_from(props, "Name", "")
        if cutscene_name ~= ""
            and once_state[player_id]
            and once_state[player_id][cutscene_name] then
            return nil
        end
    end

    return run_cutscene(player_id, area_id, cutscene_object, trigger_context)
end

function ezcutscenes.cancel(player_id)
    local context = active_cutscenes[player_id]
    if context then context.cancelled = true end
end

function ezcutscenes.is_active(player_id)
    return active_cutscenes[player_id] ~= nil
end

function ezcutscenes.get_cutscene(area_id, name)
    local entry = registered_cutscenes[area_id] and registered_cutscenes[area_id][name]
    return entry and entry.object or nil
end

object_registry.register_handler("Cutscene", function(area_id, object)
    local props = get_props(object)
    local name = tu.get_string_from(props, "Name", "")
    if name == "" then
        logger:for_area(area_id):warn(
            "[ezcutscenes] Cutscene missing Name: " .. tostring(object.id))
        return
    end
    registered_cutscenes[area_id] = registered_cutscenes[area_id] or {}
    registered_cutscenes[area_id][name] = { object = object }
    logger:for_area(area_id):info(
        "[ezcutscenes] Registered cutscene '" .. name
        .. "' in " .. tostring(area_id))

    local width = tonumber(object.width) or 0
    local height = tonumber(object.height) or 0
    local radius = tu.get_number_from(props, "Trigger Radius", 0)
    local trigger_id = "ezcutscene_trigger_"
        .. tostring(area_id) .. "_" .. tostring(object.id)

    local emitter = nil
    if width > 0 and height > 0 then
        emitter = eztriggers.add_rectangle_trigger(
            area_id, object, width, height, trigger_id)
        if emitter then
            logger:for_area(area_id):info(string.format(
                "[ezcutscenes] Rectangle trigger registered for '%s' bounds=%dx%d origin=(%s,%s)",
                name, width, height, tostring(object.x), tostring(object.y)))
        else
            logger:for_area(area_id):warn(
                "[ezcutscenes] Rectangle trigger registration failed for '"
                .. name .. "'")
        end
    elseif radius > 0 then
        emitter = eztriggers.add_radius_trigger(
            area_id, object, radius * 2, radius * 2, 0, 0, trigger_id)
        if emitter then
            logger:for_area(area_id):info(
                "[ezcutscenes] Radius trigger registered for '"
                .. name .. "' radius=" .. tostring(radius) .. " px")
        else
            logger:for_area(area_id):warn(
                "[ezcutscenes] Radius trigger registration failed for '"
                .. name .. "'")
        end
    else
        logger:for_area(area_id):info(
            "[ezcutscenes] Cutscene '" .. name
            .. "' has no auto-trigger (point with Trigger Radius = 0). "
            .. "Start it via NPC interaction or script.")
    end

    if emitter then
        emitter:on("entered", function(event)
            if event.player_id and Net.is_player(event.player_id) then
                ezcutscenes.start(event.player_id, area_id, name, {
                    trigger_object_id = object.id,
                })
            end
        end)
    end
end)

object_registry.register_handler("Cutscene Step", function(area_id, object)
    -- no-op; steps are data-only
end)

Net:on("player_disconnect", function(event)
    local player_id = (type(event) == "table") and event.player_id or event
    if not player_id then return end
    local context = active_cutscenes[player_id]
    if context then context.cancelled = true end
    active_cutscenes[player_id] = nil
    once_state[player_id] = nil
end)

function ezcutscenes.handle_player_disconnect(player_id)
    if not player_id then return end
    local context = active_cutscenes[player_id]
    if context then context.cancelled = true end
    active_cutscenes[player_id] = nil
    once_state[player_id] = nil
end

function ezcutscenes.handle_player_transfer(player_id)
    if not player_id then return end
    local context = active_cutscenes[player_id]
    if context then
        context.cancelled = true
        active_cutscenes[player_id] = nil
        pcall(Net.unlock_player_input, player_id)
    end
end

logger:info("[ezcutscenes] Loaded")
return ezcutscenes