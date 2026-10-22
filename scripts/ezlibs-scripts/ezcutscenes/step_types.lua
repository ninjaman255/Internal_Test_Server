-- ezcutscenes/step_types.lua
-- Step implementations. Each handler is `function(context, props) -> async<result>`.
-- The runner awaits the returned promise, inspects `result`, and chooses the
-- next step from the step's `Next Step` / `Next N` / `Fail Next` properties.
--
-- All handlers are read-only with respect to `context` except:
--   * `context.variables.prompt_input` is set by Prompt Player so later
--     steps could interpolate it if a future version of the runner adds that.
--
-- Handlers must be robust to missing/invalid actor or target refs: a bad
-- ref logs and returns `false`/`0`, which the runner treats as a step
-- failure only for branch steps. Non-branch failures just fall through to
-- `Next Step`.

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
        return nil
    end
    return eznpcs.resolve_bot(context.area_id, actor_ref, context.player_id)
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

local function resolve_target(context, props)
    local point = resolve_point(context, props["Target"])
    if point then return point end
    local has_explicit =
        props["Target X"] ~= nil or props["Target Y"] ~= nil or props["Target Z"] ~= nil
    if not has_explicit then return nil end
    return {
        x = tu.get_number_from(props, "Target X", 0),
        y = tu.get_number_from(props, "Target Y", 0),
        z = tu.get_number_from(props, "Target Z", 0),
    }
end

-- Resolve the mugshot to display for a message/quiz/prompt speaker.
-- `Speaker` may be an NPC object ref; if blank, the trigger NPC is used.
-- `Mugshot Override` follows the same convention as Dialogue's `Mugshot`:
-- "player" for the current player's mug, or any other string as a mug name.
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

function StepTypes.move_actor(context, props)
    return async(function()
        local bot_id = resolve_actor_bot(context, props["Actor"])
        if not bot_id then
            logger:for_player(context.player_id):warn(
                "[ezcutscenes] Move Actor has no resolvable Actor")
            return false
        end
        local target = resolve_target(context, props)
        if not target then
            logger:for_player(context.player_id):warn(
                "[ezcutscenes] Move Actor has no Target (point ref or X/Y/Z)")
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

-- Ask Quiz. `Async.quiz_player` returns a 0-based option index. The runner
-- uses `Next 1`, `Next 2`, `Next 3` for each choice and `Next Step` as
-- fallback.
function StepTypes.ask_quiz(context, props)
    return async(function()
        local question = tu.get_string_from(props, "Question", "")
        if question == "" then return 0 end
        local tex, anim = resolve_speaker_mugshot(context, props)
        local option1 = tu.get_string_from(props, "Option 1", "Yes")
        local option2 = tu.get_string_from(props, "Option 2", "No")
        local option3 = tu.get_string_from(props, "Option 3", nil)
        local opt3_arg = (option3 ~= nil and option3 ~= "") and option3 or nil
        local choice = await(Async.quiz_player(
            context.player_id, question, option1, option2, opt3_arg, tex, anim))
        return tonumber(choice) or 0
    end)
end

-- Prompt Player. `Expected` empty accepts any input. `Expected` set routes
-- through the successful (Next Step) or failed (Fail Next) branch. The raw
-- input is stored on `context.variables` for potential later use.
function StepTypes.prompt_player(context, props)
    return async(function()
        local message = tu.get_string_from(props, "Message", "")
        local tex, anim = resolve_speaker_mugshot(context, props)
        if message ~= "" then
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

function StepTypes.move_camera(context, props)
    return async(function()
        local target = resolve_target(context, props)
        if not target then
            logger:for_player(context.player_id):warn(
                "[ezcutscenes] Move Camera has no Target (point ref or X/Y/Z)")
            return false
        end
        local duration = tu.get_number_from(props, "Duration", 0)
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