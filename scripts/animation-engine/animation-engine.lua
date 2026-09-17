-- Reusable animation and interpolation engine.
-- Hardened for server UI use: all timing is driven by Net tick delta_time.
-- No visible animation timing depends on os.clock().

local AnimationEngine = {}
_G.AnimationEngine = AnimationEngine
AnimationEngine.__index = AnimationEngine

AnimationEngine.AnimEnums = require("scripts/animation-engine/animation-enums")
local MathUtils = require("scripts/animation-engine/math-utils")
AnimationEngine.MathUtils = MathUtils

local cfg = {
    default_interp_speed = 10,
    default_ro_speed = 180,
    default_color_speed = 5,
    default_scale_speed = 2,
    easing_functions = MathUtils.easing_functions,
    debug = false,
    log_prefix = "[AnimationEngine] ",
    max_tick_dt = 0.25,
}

local animations = {}
local sequences = {}
local callbacks = {}
local tagged_animations = {}
local tagged_sequences = {}
local animation_id_counter = 0
local sequence_id_counter = 0
local engine_time = 0.0

local function now()
    return engine_time
end

local function copy_table(src)
    local out = {}
    for k, v in pairs(src or {}) do out[k] = v end
    return out
end

local function log(message)
    if cfg.debug and message then
        print(cfg.log_prefix .. tostring(message))
    end
end

local function generate_animation_id()
    animation_id_counter = animation_id_counter + 1
    return "anim_" .. animation_id_counter .. "_" .. math.random(1000, 9999)
end

local function generate_sequence_id()
    sequence_id_counter = sequence_id_counter + 1
    return "seq_" .. sequence_id_counter .. "_" .. math.random(1000, 9999)
end

local function remove_from_tag_sets(collection, id)
    for _, set in pairs(collection) do set[id] = nil end
end

function AnimationEngine.get_time()
    return engine_time
end

function AnimationEngine.interpolate(start, target, t, easing, discrete)
    local ease_func = cfg.easing_functions[easing] or cfg.easing_functions.linear
    local eased_t = ease_func(t)
    if easing == "instant" and t > 0 then eased_t = 1 end

    local discrete_set = {}
    for _, key in ipairs(discrete or {}) do discrete_set[key] = true end

    if type(start) == "number" and type(target) == "number" then
        return MathUtils.lerp(start, target, eased_t)
    end

    if type(start) == "table" and type(target) == "table" then
        local result = {}
        for key, start_value in pairs(start) do
            local target_value = target[key]
            if discrete_set[key] then
                result[key] = (t > 0 and target_value ~= nil) and target_value or start_value
            elseif type(start_value) == "number" and type(target_value) == "number" then
                result[key] = MathUtils.lerp(start_value, target_value, eased_t)
            else
                result[key] = target_value ~= nil and target_value or start_value
            end
        end
        for key, target_value in pairs(target) do
            if start[key] == nil then
                if not discrete_set[key] or t > 0 then result[key] = target_value end
            end
        end
        return result
    end

    return target ~= nil and target or start
end

local function normalized_loop(loop_value)
    if loop_value == true then return true, nil end
    if type(loop_value) == "number" and loop_value > 0 then
        return true, math.max(1, math.floor(loop_value))
    end
    return false, nil
end

function AnimationEngine.animate(start_values, target_values, duration, options)
    options = options or {}
    local easing = options.easing or "linear"
    local looping, max_cycles = normalized_loop(options.loop)
    if options.max_cycles and tonumber(options.max_cycles) then
        looping = true
        max_cycles = math.max(1, math.floor(tonumber(options.max_cycles)))
    end

    local id = options.id or generate_animation_id()
    local actual_duration = math.max(0, tonumber(duration) or 0)
    local tag = options.tag

    animations[id] = {
        id = id,
        start_time = now(),
        duration = actual_duration,
        easing = easing,
        easing_back = options.easing_back or easing,
        start_values = copy_table(start_values),
        target_values = copy_table(target_values),
        original_start_values = copy_table(start_values),
        original_target_values = copy_table(target_values),
        discrete = options.discrete or {},
        on_update = options.on_update,
        on_complete = options.on_complete,
        loop = looping,
        ping_pong = options.ping_pong == true,
        max_cycles = max_cycles,
        current_cycle = 0,
        phase = 1,
        current_values = copy_table(start_values),
    }

    if tag then
        tagged_animations[tag] = tagged_animations[tag] or {}
        tagged_animations[tag][id] = true
    end

    -- Preserve the old "instant" behavior without waiting for a later tick.
    if easing == "instant" or actual_duration <= 0 then
        local anim = animations[id]
        anim.current_values = copy_table(anim.target_values)
        if anim.on_update then anim.on_update(anim.current_values, 1.0, 1) end
        if not anim.loop then
            if anim.on_complete then anim.on_complete(anim.current_values, false) end
            remove_from_tag_sets(tagged_animations, id)
            animations[id] = nil
        else
            -- A zero-duration infinite loop would spin forever. Advance at most once per tick.
            anim.duration = 0
            anim.start_time = now()
        end
    end

    log("Started animation: " .. id)
    return id
end

local function complete_animation(id, anim, interrupted)
    if anim.on_complete then
        local ok, err = pcall(anim.on_complete, anim.current_values, interrupted == true)
        if not ok then log("on_complete error for " .. tostring(id) .. ": " .. tostring(err)) end
    end
    remove_from_tag_sets(tagged_animations, id)
    animations[id] = nil
end

function AnimationEngine.update(_dt)
    local current_time = now()
    local ids = {}
    for id in pairs(animations) do ids[#ids + 1] = id end

    for _, id in ipairs(ids) do
        local anim = animations[id]
        if anim then
            local duration = anim.duration
            local t
            if duration <= 0 then
                t = 1
            else
                t = MathUtils.clamp01((current_time - anim.start_time) / duration)
            end

            local start_values = anim.phase == 1 and anim.start_values or anim.target_values
            local target_values = anim.phase == 1 and anim.target_values or anim.start_values
            local easing = anim.phase == 1 and anim.easing or anim.easing_back
            anim.current_values = AnimationEngine.interpolate(start_values, target_values, t, easing, anim.discrete)

            if anim.on_update then
                local ok, err = pcall(anim.on_update, anim.current_values, t, anim.phase)
                if not ok then
                    log("on_update error for " .. tostring(id) .. ": " .. tostring(err))
                    AnimationEngine.stop_animation(id)
                    goto continue
                end
            end

            if t >= 1 then
                if anim.ping_pong and anim.phase == 1 then
                    anim.phase = 2
                    anim.start_time = current_time
                else
                    local completed_cycle = true
                    if anim.ping_pong and anim.phase == 2 then anim.phase = 1 end

                    if completed_cycle then anim.current_cycle = anim.current_cycle + 1 end
                    local hit_limit = anim.max_cycles and anim.current_cycle >= anim.max_cycles

                    if anim.loop and not hit_limit then
                        anim.start_time = current_time
                    else
                        complete_animation(id, anim, false)
                    end
                end
            end
        end
        ::continue::
    end
end

function AnimationEngine.stop_animation(id)
    local anim = animations[id]
    if not anim then return false end
    complete_animation(id, anim, true)
    log("Stopped animation: " .. tostring(id))
    return true
end

function AnimationEngine.stop_animations_by_tag(tag)
    local set = tagged_animations[tag]
    if not set then return false end
    local ids = {}
    for id in pairs(set) do ids[#ids + 1] = id end
    for _, id in ipairs(ids) do AnimationEngine.stop_animation(id) end
    tagged_animations[tag] = nil
    return true
end

function AnimationEngine.tween(object, target_props, duration, options)
    options = options or {}

    local function read_prop(key)
        local getter = object["get" .. key:sub(1, 1):upper() .. key:sub(2)]
        if type(getter) == "function" then return getter(object) end
        return object[key]
    end

    local function apply_prop(key, value)
        local setter = object["set" .. key:sub(1, 1):upper() .. key:sub(2)]
        if type(setter) == "function" then setter(object, value) else object[key] = value end
    end

    local start_props = {}
    for key, target in pairs(target_props or {}) do
        local value = read_prop(key)
        start_props[key] = value ~= nil and value or target
    end

    return AnimationEngine.animate(start_props, target_props, duration, {
        easing = options.easing,
        easing_back = options.easing_back,
        discrete = options.discrete,
        loop = options.loop,
        ping_pong = options.ping_pong,
        tag = options.tag,
        max_cycles = options.max_cycles,
        on_update = function(values, t, phase)
            for key, value in pairs(values) do apply_prop(key, value) end
            if options.on_update then options.on_update(values, t, phase) end
        end,
        on_complete = function(_, interrupted)
            if options.on_complete then options.on_complete(interrupted) end
        end,
    })
end

local function resolve_sequence_value(seq, step_index, value)
    if type(value) ~= "string" then return value end
    local step_data = seq.step_data[step_index] or {}
    if value == "current" then return 0 end
    if value == "original" then return 0 end
    local offset = value:match("^current%+(.+)$")
    if offset then return (step_data.current or 0) + (tonumber(offset) or 0) end
    return tonumber(value) or value
end

function AnimationEngine.create_sequence(steps, options)
    options = options or {}
    local id = options.id or generate_sequence_id()
    sequences[id] = {
        id = id,
        steps = steps or {},
        current_step = 1,
        start_time = now(),
        loop = options.loop == true,
        on_complete = options.on_complete,
        active_animation = nil,
        active_sequence = nil,
        step_data = {},
        original_values = options.original_values,
        next_step_time = nil,
    }
    if options.tag then
        tagged_sequences[options.tag] = tagged_sequences[options.tag] or {}
        tagged_sequences[options.tag][id] = true
    end
    return id
end

function AnimationEngine.start_sequence(id)
    local seq = sequences[id]
    if not seq then return false end
    seq.start_time = now()
    seq.current_step = 1
    seq.active_animation = nil
    seq.active_sequence = nil
    seq.next_step_time = nil
    AnimationEngine._execute_sequence_step(id)
    return true
end

local function resolve_step_table(seq, step_index, source)
    local out = {}
    local data = seq.step_data[step_index] or {}
    for key, value in pairs(source or {}) do
        if type(value) == "string" then
            local offset = value:match("^current%+(.+)$")
            if offset then
                out[key] = (data[key] or 0) + (tonumber(offset) or 0)
            elseif value == "current" then
                out[key] = data[key] or 0
            elseif value == "original" then
                out[key] = (seq.original_values and seq.original_values[key]) or 0
            else
                out[key] = tonumber(value) or value
            end
        else
            out[key] = value
        end
    end
    return out
end

function AnimationEngine._execute_sequence_step(seq_id)
    local seq = sequences[seq_id]
    if not seq or seq.current_step > #seq.steps then return false end

    local index = seq.current_step
    local step = seq.steps[index]
    seq.step_data[index] = seq.step_data[index] or {}

    if step.type == "delay" then
        seq.next_step_time = now() + math.max(0, tonumber(step.duration) or 0)
        seq.active_animation = nil
    elseif step.type == "animate" then
        local start_values = resolve_step_table(seq, index, step.start)
        local target_values = resolve_step_table(seq, index, step.target)
        for key, value in pairs(start_values) do seq.step_data[index][key] = value end

        seq.active_animation = AnimationEngine.animate(start_values, target_values, step.duration or 0, {
            easing = step.easing,
            easing_back = step.easing_back,
            discrete = step.discrete,
            on_update = step.on_update,
            on_complete = function(values, interrupted)
                if interrupted then return end
                local live = sequences[seq_id]
                if not live then return end
                for key, value in pairs(values or {}) do live.step_data[index][key] = value end
                if step.on_complete then pcall(step.on_complete, values, false) end
                AnimationEngine._sequence_step_complete(seq_id)
            end,
        })
    elseif step.type == "run" then
        local done_called = false
        local function done()
            if done_called then return end
            done_called = true
            if sequences[seq_id] then AnimationEngine._sequence_step_complete(seq_id) end
        end
        local ok, child_id = pcall(step.run or done, done)
        if not ok then
            log("Run step error: " .. tostring(child_id))
            done()
        elseif type(child_id) == "string" then
            if animations[child_id] then seq.active_animation = child_id
            elseif sequences[child_id] and child_id ~= seq_id then seq.active_sequence = child_id end
        end
    elseif step.type == "callback" then
        if step.callback then pcall(step.callback) end
        AnimationEngine._sequence_step_complete(seq_id)
    else
        -- Unknown or empty step: fail open rather than deadlocking the sequence.
        AnimationEngine._sequence_step_complete(seq_id)
    end
    return true
end

function AnimationEngine._sequence_step_complete(seq_id)
    local seq = sequences[seq_id]
    if not seq then return end
    seq.current_step = seq.current_step + 1
    seq.active_animation = nil
    seq.active_sequence = nil
    seq.next_step_time = nil

    if seq.current_step > #seq.steps then
        if seq.loop then
            seq.current_step = 1
            AnimationEngine._execute_sequence_step(seq_id)
        else
            if seq.on_complete then pcall(seq.on_complete) end
            remove_from_tag_sets(tagged_sequences, seq_id)
            sequences[seq_id] = nil
        end
    else
        AnimationEngine._execute_sequence_step(seq_id)
    end
end

function AnimationEngine.update_sequences(_dt)
    local current_time = now()
    local ready = {}
    for id, seq in pairs(sequences) do
        if seq.next_step_time and current_time >= seq.next_step_time then ready[#ready + 1] = id end
    end
    for _, id in ipairs(ready) do
        local seq = sequences[id]
        if seq then
            seq.next_step_time = nil
            AnimationEngine._sequence_step_complete(id)
        end
    end
end

function AnimationEngine.stop_sequence(id)
    local seq = sequences[id]
    if not seq then return false end
    if seq.active_animation then AnimationEngine.stop_animation(seq.active_animation) end
    if seq.active_sequence and seq.active_sequence ~= id then AnimationEngine.stop_sequence(seq.active_sequence) end
    remove_from_tag_sets(tagged_sequences, id)
    sequences[id] = nil
    return true
end

function AnimationEngine.stop_sequences_by_tag(tag)
    local set = tagged_sequences[tag]
    if not set then return false end
    local ids = {}
    for id in pairs(set) do ids[#ids + 1] = id end
    for _, id in ipairs(ids) do AnimationEngine.stop_sequence(id) end
    tagged_sequences[tag] = nil
    return true
end

function AnimationEngine.animate_discrete_first(start_values, target_values, duration, options)
    options = options or {}
    local discrete = options.discrete or {}
    local discrete_set = false
    return AnimationEngine.animate(start_values, target_values, duration, {
        easing = options.easing or "linear",
        easing_back = options.easing_back,
        loop = options.loop,
        ping_pong = options.ping_pong,
        max_cycles = options.max_cycles,
        discrete = discrete,
        tag = options.tag,
        on_update = function(values, t, phase)
            if not discrete_set and t > 0 then
                discrete_set = true
                local copy = copy_table(values)
                for _, key in ipairs(discrete) do
                    if target_values[key] ~= nil then copy[key] = target_values[key] end
                end
                if options.on_update then options.on_update(copy, t, phase) end
            elseif options.on_update then
                options.on_update(values, t, phase)
            end
        end,
        on_complete = options.on_complete,
    })
end

function AnimationEngine.set_to(object, values)
    if not object then return end
    for key, value in pairs(values or {}) do
        if key == "x" or key == "y" then
            if object.setPosition then
                object:setPosition(values.x ~= nil and values.x or object.x, values.y ~= nil and values.y or object.y)
            else
                if values.x ~= nil then object.x = values.x end
                if values.y ~= nil then object.y = values.y end
            end
        elseif key == "scale" and object.setScale then
            object:setScale(value)
        elseif key == "angle" and object.setRotation then
            object:setRotation(value)
        elseif key == "alpha" and object.setAlpha then
            object:setAlpha(value)
        elseif (key == "r" or key == "g" or key == "b") and object.setColor then
            object:setColor(values.r or object.r, values.g or object.g, values.b or object.b)
        else
            object[key] = value
        end
    end
end

function AnimationEngine.delay(duration, callback)
    local id = "delay_" .. generate_animation_id()
    callbacks[id] = {
        trigger_time = now() + math.max(0, tonumber(duration) or 0),
        callback = callback,
    }
    return id
end

function AnimationEngine.cancel_delay(id)
    if callbacks[id] then callbacks[id] = nil; return true end
    return false
end

function AnimationEngine.update_callbacks()
    local current_time = now()
    local ready = {}
    for id, cb in pairs(callbacks) do
        if current_time >= cb.trigger_time then ready[#ready + 1] = id end
    end
    for _, id in ipairs(ready) do
        local cb = callbacks[id]
        callbacks[id] = nil
        if cb and cb.callback then
            local ok, err = pcall(cb.callback)
            if not ok then log("delay callback error: " .. tostring(err)) end
        end
    end
end

function AnimationEngine.get_active_count()
    local count = 0
    for _ in pairs(animations) do count = count + 1 end
    return count
end

function AnimationEngine.get_sequence_count()
    local count = 0
    for _ in pairs(sequences) do count = count + 1 end
    return count
end

function AnimationEngine.clear_all()
    local anim_ids = {}
    for id in pairs(animations) do anim_ids[#anim_ids + 1] = id end
    for _, id in ipairs(anim_ids) do AnimationEngine.stop_animation(id) end

    local seq_ids = {}
    for id in pairs(sequences) do seq_ids[#seq_ids + 1] = id end
    for _, id in ipairs(seq_ids) do AnimationEngine.stop_sequence(id) end

    callbacks = {}
    tagged_animations = {}
    tagged_sequences = {}
end

function AnimationEngine.tick(dt)
    dt = tonumber(dt) or 0
    if dt < 0 then dt = 0 end
    if cfg.max_tick_dt and dt > cfg.max_tick_dt then dt = cfg.max_tick_dt end
    engine_time = engine_time + dt
    AnimationEngine.update(dt)
    AnimationEngine.update_sequences(dt)
    AnimationEngine.update_callbacks()
end

function AnimationEngine.set_debug(enabled)
    cfg.debug = enabled == true
end

function AnimationEngine.set_max_tick_dt(seconds)
    if seconds == nil then cfg.max_tick_dt = nil; return end
    cfg.max_tick_dt = math.max(0, tonumber(seconds) or 0)
end

function AnimationEngine.set_interpolation_speeds(position, ro, color, scale)
    if position then cfg.default_interp_speed = position end
    if ro then cfg.default_ro_speed = ro end
    if color then cfg.default_color_speed = color end
    if scale then cfg.default_scale_speed = scale end
end

function AnimationEngine.add_easing_function(name, func)
    if type(func) == "function" then cfg.easing_functions[name] = func end
end

-- Attach exactly one engine tick listener when loaded.
Net:on("tick", function(event)
    AnimationEngine.tick(event and event.delta_time or 0)
end)

local AnimationSequences = require("scripts/animation-engine/animation-sequences")
AnimationEngine.Sequences = AnimationSequences

return AnimationEngine
