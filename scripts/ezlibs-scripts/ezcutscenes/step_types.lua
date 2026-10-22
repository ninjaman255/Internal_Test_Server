-- ezcutscenes/step_types.lua
-- Step implementations. Each handler is
--     function(context, props, step_object) -> async<result>
-- where step_object is the resolved Cutscene Step object in Tiled. The
-- runner awaits the returned promise, inspects `result`, and chooses the
-- next step from the step's `Next Step` / `Next N` / `Fail Next` properties.
--
-- Engine bug workaround: Async.quiz_player, Async.question_player, and
-- Async.prompt_player corrupt their choices when a message/option text is
-- passed inline. Every interactive dialog step here therefore:
--   1. Sends the prompt text via Async.message_player first (modal, awaits
--      the player closing it).
--   2. Invokes the dialog API with an EMPTY message and only the options.
-- Long option texts trigger the same engine bug, so map makers should keep
-- individual option strings short (one or two words).

local logger = require('scripts/ezlibs-scripts/ezlogger').get('ezcutscenes')
local eznpcs = require('scripts/ezlibs-scripts/eznpcs/eznpcs')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local tu = require('scripts/ezlibs-scripts/utils/eztiledutils')

local StepTypes = {}

-- --------------------------------------------------------------------------
-- Shared helpers
-- --------------------------------------------------------------------------

local function resolve_actor_bot(context, actor_ref)
    if actor_ref == nil or actor_ref == "" then return nil end

    if type(actor_ref) == "string" then
        if actor_ref == "player" then return context.player_id end
        if actor_ref == "trigger_npc" then return context.trigger_bot_id end
        local numeric = tonumber(actor_ref)
        if numeric then
            return eznpcs.resolve_bot(context.area_id, numeric, context.player_id)
        end
        return nil
    end

    if type(actor_ref) == "number" then
        return eznpcs.resolve_bot(context.area_id, actor_ref, context.player_id)
    end

    if type(actor_ref) == "table" and actor_ref.id ~= nil then
        return eznpcs.resolve_bot(context.area_id, actor_ref.id, context.player_id)
    end

    return nil
end

local function resolve_point(context, target_ref)
    if target_ref == nil or target_ref == "" then return nil end
    local id = tonumber(target_ref) or target_ref
    local object = context.resolve_object(id)
    if not object then return nil end
    return {
        x = tonumber(object.x) or 0,
        y = tonumber(object.y) or 0,
        z = tonumber(object.z) or 0,
    }
end

local function resolve_target(context, props, step_object)
    local point = resolve_point(context, props["Target"])
    if point then return point, "Target" end

    local has_explicit =
        props["Target X"] ~= nil or props["Target Y"] ~= nil or props["Target Z"] ~= nil
    if has_explicit then
        return {
            x = tu.get_number_from(props, "Target X", 0),
            y = tu.get_number_from(props, "Target Y", 0),
            z = tu.get_number_from(props, "Target Z", 0),
        }, "Target X/Y/Z"
    end

    if step_object and step_object.x ~= nil and step_object.y ~= nil then
        return {
            x = tonumber(step_object.x) or 0,
            y = tonumber(step_object.y) or 0,
            z = tonumber(step_object.z) or 0,
        }, "step_node"
    end

    return nil, nil
end

local function resolve_speaker_mugshot(context, props)
    local speaker_ref = props["Speaker"]
    if speaker_ref == nil or speaker_ref == "" then
        speaker_ref = context.trigger_object_id
    end
    if speaker_ref == nil or speaker_ref == "" then return nil, nil end
    local bot_id = eznpcs.resolve_bot(context.area_id, speaker_ref, context.player_id)
    if not bot_id then return nil, nil end
    local npc = eznpcs.get_bot_record(bot_id)
    if not npc then return nil, nil end
    local override = tu.get_string_from(props, "Mugshot Override", nil)
    local fake_dialogue = { custom_properties = { ["Mugshot"] = override } }
    local mug = eznpcs.get_dialogue_mugshot(npc, context.player_id, fake_dialogue)
    if not mug then return nil, nil end
    return mug.texture_path, mug.animation_path
end

-- --------------------------------------------------------------------------
-- Step handlers
-- --------------------------------------------------------------------------

function StepTypes.wait(context, props)
    return async(function()
        local seconds = tu.get_number_from(props, "Wait Seconds", 1)
        if seconds > 0 then
            await(Async.sleep(seconds))
        end
        return true
    end)
end

function StepTypes.move_actor(context, props, step_object)
    return async(function()
        local bot_id = resolve_actor_bot(context, props["Actor"])
        if not bot_id then
            logger:for_player(context.player_id):warn(
                "[ezcutscenes] Move Actor has no resolvable Actor")
            return false
        end
        local target, source = resolve_target(context, props, step_object)
        if not target then
            logger:for_player(context.player_id):warn(
                "[ezcutscenes] Move Actor has no target (no Target, Target X/Y/Z, "
                .. "and no step node position)")
            return false
        end
        local options = {
            animation       = tu.get_string_from(props, "Move Animation", nil),
            direction       = tu.get_string_from(props, "Move Direction", nil),
            speed           = tu.get_number_from(props, "Move Speed", 3),
            hold_animation  = tu.get_string_from(props, "End Animation", nil),
            hold_direction  = tu.get_string_from(props, "End Direction", nil),
            hold_seconds    = tu.get_number_from(props, "End Hold Seconds", 0),
            hold_loop       = tu.get_boolean_from(props, "End Loop", true),
            hold_reassert   = true,
        }
        logger:for_player(context.player_id):info(string.format(
            "[ezcutscenes] Move Actor target_source=%s target=(%s,%s,%s)",
            tostring(source), tostring(target.x), tostring(target.y),
            tostring(target.z)))
        local ok = await(eznpcs.move_bot_to_spot(bot_id, target, options))
        return ok == true
    end)
end

function StepTypes.set_pose(context, props)
    return async(function()
        local bot_id = resolve_actor_bot(context, props["Actor"])
        if not bot_id then
            logger:for_player(context.player_id):warn(
                "[ezcutscenes] Set Pose has no resolvable Actor")
            return false
        end
        local animation = tu.get_string_from(props, "Animation", nil)
        if not animation then
            logger:for_player(context.player_id):warn(
                "[ezcutscenes] Set Pose has no Animation")
            return false
        end
        local options = {
            animation     = animation,
            direction     = tu.get_string_from(props, "Direction", nil),
            loop          = tu.get_boolean_from(props, "Loop", true),
            hold          = true,
            hold_seconds  = tu.get_number_from(props, "Hold Seconds", 0),
        }
        local ok = await(eznpcs.set_bot_pose(bot_id, options))
        return ok == true
    end)
end

function StepTypes.show_message(context, props)
    return async(function()
        local text = tu.get_string_from(props, "Text", "")
        if text == "" then return true end
        local tex, anim = resolve_speaker_mugshot(context, props)
        await(Async.message_player(context.player_id, text, tex, anim))
        return true
    end)
end

-- Ask Quiz: three-option dialog.
--
-- Engine bug workaround: quiz_player corrupts the option list when a
-- non-empty question string or long option text is passed inline. Send
-- the question via message_player first (awaited until the player closes
-- it), then invoke quiz_player with an empty question string so only the
-- options render.
function StepTypes.ask_quiz(context, props)
    return async(function()
        local question = tu.get_string_from(props, "Question", "")
        local tex, anim = resolve_speaker_mugshot(context, props)

        if question ~= "" then
            logger:for_player(context.player_id):info(
                "[ezcutscenes] Ask Quiz: sending Question via message_player, "
                .. "then quiz_player with empty question and options only")
            await(Async.message_player(context.player_id, question, tex, anim))
        end

        local option1 = tu.get_string_from(props, "Option 1", "Yes")
        local option2 = tu.get_string_from(props, "Option 2", "No")
        local option3 = tu.get_string_from(props, "Option 3", nil)
        local opt3_arg = (option3 ~= nil and option3 ~= "") and option3 or nil

        local choice = await(Async.quiz_player(
            context.player_id, "", option1, option2, opt3_arg))
        return tonumber(choice) or 0
    end)
end

-- Prompt Player: free-text input.
--
-- Already uses the split pattern: Message via message_player first, then
-- prompt_player with no message argument. Kept as-is; documented so a
-- future change doesn't accidentally re-inline the message.
function StepTypes.prompt_player(context, props)
    return async(function()
        local message = tu.get_string_from(props, "Message", "")
        local tex, anim = resolve_speaker_mugshot(context, props)

        if message ~= "" then
            logger:for_player(context.player_id):info(
                "[ezcutscenes] Prompt Player: sending Message via message_player, "
                .. "then prompt_player with no message")
            await(Async.message_player(context.player_id, message, tex, anim))
        end

        local input = await(Async.prompt_player(context.player_id))
        context.variables = context.variables or {}
        context.variables.prompt_input = input
        local expected = tu.get_string_from(props, "Expected", "")
        if expected == "" then
            return { success = true, input = input }
        end
        return { success = (input == expected), input = input }
    end)
end

function StepTypes.play_sound(context, props)
    return async(function()
        local path = tu.get_string_from(props, "Sound Path", "")
        if path == "" then return true end
        pcall(Net.play_sound_for_player, context.player_id, path)
        return true
    end)
end

function StepTypes.fade_camera(context, props)
    return async(function()
        local r = tu.get_number_from(props, "Color R", 0)
        local g = tu.get_number_from(props, "Color G", 0)
        local b = tu.get_number_from(props, "Color B", 0)
        local a = tu.get_number_from(props, "Color A", 255)
        local duration = tu.get_number_from(props, "Duration", 0.8)
        pcall(Net.fade_player_camera, context.player_id,
            { r = r, g = g, b = b, a = a }, duration)
        if duration > 0 then
            await(Async.sleep(duration))
        end
        return true
    end)
end

function StepTypes.move_camera(context, props, step_object)
    return async(function()
        local target, source = resolve_target(context, props, step_object)
        if not target then
            logger:for_player(context.player_id):warn(
                "[ezcutscenes] Move Camera has no target (no Target, Target X/Y/Z, "
                .. "and no step node position)")
            return false
        end
        local duration = tu.get_number_from(props, "Duration", 0)
        logger:for_player(context.player_id):info(string.format(
            "[ezcutscenes] Move Camera target_source=%s target=(%s,%s,%s)",
            tostring(source), tostring(target.x), tostring(target.y),
            tostring(target.z)))
        pcall(Net.move_player_camera,
            context.player_id, target.x, target.y, target.z, duration)
        if duration > 0 then
            await(Async.sleep(duration))
        end
        return true
    end)
end

function StepTypes.emit_event(context, props)
    return async(function()
        local event_name = tu.get_string_from(props, "Event Name", "")
        if event_name == "" then return true end
        ezbus:emit(event_name, {
            player_id = context.player_id,
            area_id = context.area_id,
            cutscene_name = context.cutscene_name,
        })
        return true
    end)
end

StepTypes.DISPATCH = {
    ["Wait"]          = StepTypes.wait,
    ["Move Actor"]    = StepTypes.move_actor,
    ["Set Pose"]      = StepTypes.set_pose,
    ["Show Message"]  = StepTypes.show_message,
    ["Ask Quiz"]      = StepTypes.ask_quiz,
    ["Prompt Player"] = StepTypes.prompt_player,
    ["Play Sound"]    = StepTypes.play_sound,
    ["Fade Camera"]   = StepTypes.fade_camera,
    ["Move Camera"]   = StepTypes.move_camera,
    ["Emit Event"]    = StepTypes.emit_event,
}

return StepTypes