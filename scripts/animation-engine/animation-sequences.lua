-- animation-sequences.lua
-- General purpose animation sequences that mimic duels.lua behaviors
-- Works with any sprite_id and object properties

local AnimationSequences = {}
_G.AnimationSequences = AnimationSequences

-- Use the already‑loaded AnimationEngine from global
local AnimationEngine = _G.AnimationEngine
if not AnimationEngine then
    error("AnimationEngine not found – make sure animation-engine.lua is loaded first")
end

-- Use its utilities
local MathUtils = AnimationEngine.MathUtils
local AnimationEnums = AnimationEngine.AnimEnums

-- ---------------------------------------------------------------------------
-- Configuration
-- ---------------------------------------------------------------------------
AnimationSequences.config = {
    -- Default animation parameters
    default_duration = 0.25,
    default_easing = "ease_in_out",
    
    -- Summon animation defaults
    summon = {
        arc_height = 24,
        peak_scale_mul = 1.35,
        wobble_ro_deg = 5,
        duration = 0.25,
        z_offset = 10
    },
    
    -- Position change animation defaults
    position_change = {
        duration = 0.18,
        peak_scale_mul = 1.15,
        flip_min = 0.06,
        swap_t = 0.5
    },
    
    -- Attack animation defaults
    attack = {
        duration = 0.22,
        recoil_distance = 5,
        lunge_distance = 15,
        t1 = 0.25,  -- end recoil
        t2 = 0.60,  -- end lunge
        z_offset = 12
    },
    
    -- Slide animation defaults
    slide = {
        duration = 0.15,
        easing = "ease_out"
    },
    
    -- Bob animation defaults (for idle/menu animations)
    bob = {
        duration = 1.0,
        distance = 3,
        easing = "smoothstep",
        loop = true,
        ping_pong = true
    },
    
    -- Pulse animation defaults (for highlighting)
    pulse = {
        duration = 0.8,
        scale_from = 1.0,
        scale_to = 1.1,
        alpha_from = 255,
        alpha_to = 200,
        easing = "elastic_out",
        loop = true,
        ping_pong = true
    },
    
    -- Shake animation defaults (for hit/recoil)
    shake = {
        duration = 0.15,
        intensity = 3,
        frequency = 15,
        easing = "elastic_out"
    },
    
    -- Fade animation defaults
    fade = {
        duration = 0.3,
        easing = "ease_in_out"
    },
    
    -- Color pulse animation defaults
    color_pulse = {
        duration = 0.8,
        easing = "ease_in_out",
        loop = true,
        ping_pong = true
    },
    
    -- Marquee animation defaults
    marquee = {
        duration = 2.0,
        distance = 100,
        easing = "linear",
        loop = true,
        ping_pong = true
    },
    
    -- Typewriter animation defaults
    typewriter = {
        char_delay = 0.1,
        appear_duration = 0.15,
        easing = "ease_out"
    }
}

-- ---------------------------------------------------------------------------
-- Core Animation Sequences
-- ---------------------------------------------------------------------------

-- Create a summon animation (card flies from start to end with arc)
function AnimationSequences.summon(object, start_x, start_y, start_scale, 
                                 end_x, end_y, end_scale, options)
    options = options or {}
    
    local cfg = AnimationSequences.config.summon
    local duration = options.duration or cfg.duration
    local arc_height = options.arc_height or cfg.arc_height
    local peak_scale_mul = options.peak_scale_mul or cfg.peak_scale_mul
    local wobble_deg = options.wobble_deg or cfg.wobble_ro_deg
    local easing = options.easing or AnimationSequences.config.default_easing
    local tag = options.tag
    local on_complete = options.on_complete
    local on_update = options.on_update
    
    -- Calculate control point for arc
    local control_x = (start_x + end_x) * 0.5
    local control_y = (start_y + end_y) * 0.5 - arc_height
    
    -- Create animation sequence
    local sequence_id = AnimationEngine.create_sequence({
        {
            type = "animate",
            duration = duration,
            easing = easing,
            on_update = function(values, t, phase)
                -- Calculate bezier position
                local x, y = MathUtils.quadratic_bezier(
                    {x = start_x, y = start_y},
                    {x = control_x, y = control_y},
                    {x = end_x, y = end_y},
                    t
                )
                
                -- Calculate scale with pulse
                local base_scale = MathUtils.lerp(start_scale, end_scale, t)
                local pulse = 1.0 + ((peak_scale_mul - 1.0) * math.sin(math.pi * t))
                local current_scale = base_scale * pulse
                
                -- Calculate rotation with wobble
                local base_rotation = MathUtils.lerp(0, 0, t) -- No base rotation
                local wobble = wobble_deg ~= 0 and math.sin(math.pi * 2 * t) * wobble_deg or 0
                local current_rotation = base_rotation + wobble
                
                -- Apply to object
                object.x = x
                object.y = y
                object.scale = current_scale
                object.rotation = current_rotation
                
                -- Call custom update if provided
                if on_update then
                    on_update({
                        x = x,
                        y = y,
                        scale = current_scale,
                        rotation = current_rotation,
                        progress = t
                    }, t, phase)
                end
            end,
            on_complete = on_complete
        }
    }, { tag = tag })
    
    AnimationEngine.start_sequence(sequence_id)
    return sequence_id
end

-- Create a set animation (similar to summon but with flip and rotation)
function AnimationSequences.set(object, start_x, start_y, start_scale, start_rotation,
                              end_x, end_y, end_scale, end_rotation, options)
    options = options or {}
    
    local cfg = AnimationSequences.config.position_change
    local duration = options.duration or cfg.duration
    local peak_scale_mul = options.peak_scale_mul or cfg.peak_scale_mul
    local flip_min = options.flip_min or cfg.flip_min
    local swap_t = options.swap_t or cfg.swap_t
    local easing = options.easing or AnimationSequences.config.default_easing
    local tag = options.tag
    local on_complete = options.on_complete
    local on_update = options.on_update
    
    local sequence_id = AnimationEngine.create_sequence({
        {
            type = "animate",
            duration = duration,
            easing = easing,
            on_update = function(values, t, phase)
                -- Linear interpolation for position
                local x = MathUtils.lerp(start_x, end_x, t)
                local y = MathUtils.lerp(start_y, end_y, t)
                
                -- Linear interpolation for rotation
                local rotation = MathUtils.lerp(start_rotation, end_rotation, t)
                
                -- Calculate scale with midpoint pulse
                local base_scale = MathUtils.lerp(start_scale, end_scale, t)
                local pulse = 1.0 + ((peak_scale_mul - 1.0) * math.sin(math.pi * t))
                local current_scale = base_scale * pulse
                
                -- Flip effect: width shrinks at midpoint
                local edge = math.abs(2 * t - 1) -- 1 at ends, 0 at mid
                local width_scale = flip_min + (1 - flip_min) * edge
                
                -- Apply to object (with flip effect on X scale)
                object.x = x
                object.y = y
                object.rotation = rotation
                object.scaleX = current_scale * width_scale
                object.scaleY = current_scale
                
                -- Call custom update if provided
                if on_update then
                    on_update({
                        x = x,
                        y = y,
                        scaleX = current_scale * width_scale,
                        scaleY = current_scale,
                        rotation = rotation,
                        progress = t
                    }, t, phase)
                end
            end,
            on_complete = on_complete
        }
    }, { tag = tag })
    
    AnimationEngine.start_sequence(sequence_id)
    return sequence_id
end

-- Create a position change animation (rotate and reveal)
function AnimationSequences.positionChange(object, start_rotation, end_rotation, 
                                         options)
    options = options or {}
    
    local cfg = AnimationSequences.config.position_change
    local duration = options.duration or cfg.duration
    local peak_scale_mul = options.peak_scale_mul or cfg.peak_scale_mul
    local easing = options.easing or AnimationSequences.config.default_easing
    local tag = options.tag
    local on_complete = options.on_complete
    local on_update = options.on_update
    
    -- Store initial values
    local start_scale = object.scale or 1
    local start_x = object.x or 0
    local start_y = object.y or 0
    
    local sequence_id = AnimationEngine.create_sequence({
        {
            type = "animate",
            duration = duration,
            easing = easing,
            on_update = function(values, t, phase)
                -- Interpolate rotation
                local rotation = MathUtils.lerp(start_rotation, end_rotation, t)
                
                -- Scale pulse at midpoint
                local pulse = 1.0 + ((peak_scale_mul - 1.0) * math.sin(math.pi * t))
                local current_scale = start_scale * pulse
                
                -- Apply to object
                object.rotation = rotation
                object.scale = current_scale
                
                -- Call custom update if provided
                if on_update then
                    on_update({
                        rotation = rotation,
                        scale = current_scale,
                        x = start_x,
                        y = start_y,
                        progress = t
                    }, t, phase)
                end
            end,
            on_complete = on_complete
        }
    }, { tag = tag })
    
    AnimationEngine.start_sequence(sequence_id)
    return sequence_id
end

-- Create an attack animation (recoil then lunge)
function AnimationSequences.attack(object, recoil_offset, lunge_offset, options)
    options = options or {}
    
    local cfg = AnimationSequences.config.attack
    local duration = options.duration or cfg.duration
    local t1 = options.t1 or cfg.t1
    local t2 = options.t2 or cfg.t2
    local easing = options.easing or AnimationSequences.config.default_easing
    local tag = options.tag
    local on_complete = options.on_complete
    local on_update = options.on_update
    
    -- Store initial position
    local start_x = object.x or 0
    local start_y = object.y or 0
    
    local sequence_id = AnimationEngine.create_sequence({
        {
            type = "animate",
            duration = duration,
            easing = easing,
            on_update = function(values, t, phase)
                local offset_y = 0
                
                -- Three-phase movement: recoil -> lunge -> return
                if t < t1 then
                    -- Recoil phase
                    local u = MathUtils.easing_functions.smoothstep(t / t1)
                    offset_y = MathUtils.lerp(0, recoil_offset, u)
                elseif t < t2 then
                    -- Lunge phase
                    local u = MathUtils.easing_functions.smoothstep((t - t1) / (t2 - t1))
                    offset_y = MathUtils.lerp(recoil_offset, lunge_offset, u)
                else
                    -- Return phase
                    local u = MathUtils.easing_functions.smoothstep((t - t2) / (1 - t2))
                    offset_y = MathUtils.lerp(lunge_offset, 0, u)
                end
                
                -- Apply movement
                object.y = start_y + offset_y
                
                -- Add slight scale change for impact
                local impact_scale = 1.0 + 0.1 * math.sin(math.pi * t)
                object.scale = impact_scale
                
                -- Call custom update if provided
                if on_update then
                    on_update({
                        x = start_x,
                        y = start_y + offset_y,
                        scale = impact_scale,
                        offset = offset_y,
                        progress = t
                    }, t, phase)
                end
            end,
            on_complete = on_complete
        }
    }, { tag = tag })
    
    AnimationEngine.start_sequence(sequence_id)
    return sequence_id
end

-- Create a slide animation (move from offscreen to position)
function AnimationSequences.slideIn(object, start_x, start_y, end_x, end_y, options)
    options = options or {}
    
    local cfg = AnimationSequences.config.slide
    local duration = options.duration or cfg.duration
    local easing = options.easing or cfg.easing
    local tag = options.tag
    local on_complete = options.on_complete
    local on_update = options.on_update
    
    local sequence_id = AnimationEngine.create_sequence({
        {
            type = "animate",
            start = {x = start_x, y = start_y},
            target = {x = end_x, y = end_y},
            duration = duration,
            easing = easing,
            on_update = function(values)
                object.x = values.x
                object.y = values.y
                
                if on_update then
                    on_update(values)
                end
            end,
            on_complete = on_complete
        }
    }, { tag = tag })
    
    AnimationEngine.start_sequence(sequence_id)
    return sequence_id
end

-- Create a bob animation (up and down movement)
function AnimationSequences.bob(object, options)
    options = options or {}
    
    local cfg = AnimationSequences.config.bob
    local duration = options.duration or cfg.duration
    local distance = options.distance or cfg.distance
    local easing = options.easing or cfg.easing
    local loop = options.loop ~= nil and options.loop or cfg.loop
    local ping_pong = options.ping_pong ~= nil and options.ping_pong or cfg.ping_pong
    local tag = options.tag
    local on_update = options.on_update
    local on_complete = options.on_complete
    
    -- Store initial position
    local start_y = object.y or 0
    
    return AnimationEngine.animate(
        {y = start_y},
        {y = start_y - distance},
        duration,
        {
            easing = easing,
            loop = loop,
            ping_pong = ping_pong,
            tag = tag,
            on_update = function(values)
                object.y = values.y
                if on_update then
                    on_update(values)
                end
            end,
            on_complete = on_complete
        }
    )
end

-- Create a pulse animation (scale and alpha pulsing)
function AnimationSequences.pulse(object, options)
    options = options or {}
    
    local cfg = AnimationSequences.config.pulse
    local duration = options.duration or cfg.duration
    local scale_from = options.scale_from or cfg.scale_from
    local scale_to = options.scale_to or cfg.scale_to
    local alpha_from = options.alpha_from or cfg.alpha_from
    local alpha_to = options.alpha_to or cfg.alpha_to
    local easing = options.easing or cfg.easing
    local loop = options.loop ~= nil and options.loop or cfg.loop
    local ping_pong = options.ping_pong ~= nil and options.ping_pong or cfg.ping_pong
    local tag = options.tag
    local on_update = options.on_update
    local on_complete = options.on_complete
    
    -- Use current values if not provided
    if scale_from == cfg.scale_from then
        scale_from = object.scale or scale_from
    end
    if alpha_from == cfg.alpha_from then
        alpha_from = object.alpha or alpha_from
    end
    
    return AnimationEngine.animate(
        {scale = scale_from, alpha = alpha_from},
        {scale = scale_to, alpha = alpha_to},
        duration,
        {
            easing = easing,
            loop = loop,
            ping_pong = ping_pong,
            tag = tag,
            on_update = function(values)
                object.scale = values.scale
                object.alpha = values.alpha
                if on_update then
                    on_update(values)
                end
            end,
            on_complete = on_complete
        }
    )
end

-- Create a color pulse animation (transition between two color sets)
function AnimationSequences.color_pulse(object, start_color, target_color, options)
    options = options or {}
    
    local cfg = AnimationSequences.config.color_pulse
    local duration = options.duration or cfg.duration
    local easing = options.easing or cfg.easing
    local loop = options.loop ~= nil and options.loop or cfg.loop
    local ping_pong = options.ping_pong ~= nil and options.ping_pong or cfg.ping_pong
    local tag = options.tag
    local on_complete = options.on_complete
    local on_update = options.on_update
    
    -- Ensure colors have alpha values
    local start_r = start_color.r or start_color[1] or 255
    local start_g = start_color.g or start_color[2] or 255
    local start_b = start_color.b or start_color[3] or 255
    local start_a = start_color.a or start_color[4] or (object.alpha or 255)
    
    local target_r = target_color.r or target_color[1] or 255
    local target_g = target_color.g or target_color[2] or 255
    local target_b = target_color.b or target_color[3] or 255
    local target_a = target_color.a or target_color[4] or start_a
    
    -- Use the AnimationEngine to create a ping-pong animation between the two colors
    return AnimationEngine.animate(
        {r = start_r, g = start_g, b = start_b, a = start_a},
        {r = target_r, g = target_g, b = target_b, a = target_a},
        duration,
        {
            easing = easing,
            loop = loop,
            ping_pong = ping_pong,
            tag = tag,
            on_update = function(values)
                -- Apply color and alpha to object
                if object.setColor then
                    object:setColor(values.r, values.g, values.b)
                else
                    object.r = values.r
                    object.g = values.g
                    object.b = values.b
                end
                
                if object.setAlpha then
                    object:setAlpha(values.a)
                else
                    object.alpha = values.a
                end
                
                -- Call custom update if provided
                if on_update then
                    on_update(values)
                end
            end,
            on_complete = on_complete,
            easing_back = options.easing_back or easing
        }
    )
end

-- Alternative version that uses the object's current color as starting point
function AnimationSequences.color_pulse_from_current(object, target_color, options)
    options = options or {}
    
    -- Get current color from object
    local current_color = {
        r = object.r or 255,
        g = object.g or 255,
        b = object.b or 255,
        a = object.alpha or 255
    }
    
    return AnimationSequences.color_pulse(object, current_color, target_color, options)
end

-- Create a shake animation (screen shake effect)
function AnimationSequences.shake(object, options)
    options = options or {}
    
    local cfg = AnimationSequences.config.shake
    local duration = options.duration or cfg.duration
    local intensity = options.intensity or cfg.intensity
    local frequency = options.frequency or cfg.frequency
    local easing = options.easing or cfg.easing
    local tag = options.tag
    local on_complete = options.on_complete
    local on_update = options.on_update
    
    -- Store initial position
    local start_x = object.x or 0
    local start_y = object.y or 0
    
    local sequence_id = AnimationEngine.create_sequence({
        {
            type = "animate",
            duration = duration,
            easing = easing,
            on_update = function(values, t, phase)
                -- Calculate shake intensity (decays over time)
                local current_intensity = intensity * (1 - t)
                
                -- Calculate shake offset using sine waves
                local shake_x = math.sin(t * frequency * math.pi * 2) * current_intensity
                local shake_y = math.cos(t * frequency * math.pi * 2) * current_intensity * 0.7
                
                -- Apply shake
                object.x = start_x + shake_x
                object.y = start_y + shake_y
                
                -- Add rotation shake
                object.rotation = math.sin(t * frequency * math.pi * 3) * current_intensity * 0.5
                
                -- Call custom update if provided
                if on_update then
                    on_update({
                        x = start_x + shake_x,
                        y = start_y + shake_y,
                        rotation = object.rotation,
                        intensity = current_intensity,
                        progress = t
                    }, t, phase)
                end
            end,
            on_complete = on_complete
        }
    }, { tag = tag })
    
    AnimationEngine.start_sequence(sequence_id)
    return sequence_id
end

-- Create a fade animation (fade in/out)
function AnimationSequences.fade(object, target_alpha, options)
    options = options or {}
    
    local cfg = AnimationSequences.config.fade
    local duration = options.duration or cfg.duration
    local easing = options.easing or cfg.easing
    local tag = options.tag
    local on_complete = options.on_complete
    local discrete = options.discrete
    
    return AnimationEngine.animate(
        {alpha = object.alpha or 255},
        {alpha = target_alpha},
        duration,
        {
            easing = easing,
            discrete = discrete,
            tag = tag,
            on_update = function(values)
                if object.setAlpha then
                    object:setAlpha(values.alpha)
                else
                    object.alpha = values.alpha
                end
                if options.on_update then
                    options.on_update(values)
                end
            end,
            on_complete = on_complete,
            loop = options.loop,
            ping_pong = options.ping_pong,
            easing_back = options.easing_back
        }
    )
end

-- Create a color tint animation
function AnimationSequences.tint(object, target_r, target_g, target_b, options)
    options = options or {}
    
    local duration = options.duration or AnimationSequences.config.default_duration
    local easing = options.easing or AnimationSequences.config.default_easing
    local tag = options.tag
    local on_complete = options.on_complete
    local discrete = options.discrete
    
    return AnimationEngine.animate(
        {r = object.r or 255, g = object.g or 255, b = object.b or 255},
        {r = target_r, g = target_g, b = target_b},
        duration,
        {
            easing = easing,
            discrete = discrete,
            tag = tag,
            on_update = function(values)
                if object.setColor then
                    object:setColor(values.r, values.g, values.b)
                else
                    object.r = values.r
                    object.g = values.g
                    object.b = values.b
                end
                if options.on_update then
                    options.on_update(values)
                end
            end,
            on_complete = on_complete,
            loop = options.loop,
            ping_pong = options.ping_pong,
            easing_back = options.easing_back
        }
    )
end

-- Create a complex sequence that mimics duels.lua summon with all effects
function AnimationSequences.complexSummon(object, start_x, start_y, start_scale,
                                        end_x, end_y, end_scale, options)
    options = options or {}
    
    local sequence_steps = {}
    local tag = options.tag
    
    -- Step 1: Arc movement with scale pulse
    table.insert(sequence_steps, {
        type = "animate",
        duration = options.arc_duration or 0.25,
        easing = options.easing or "ease_in_out",
        on_update = function(values, t, phase)
            -- Arc calculation
            local control_x = (start_x + end_x) * 0.5
            local control_y = (start_y + end_y) * 0.5 - (options.arc_height or 24)
            
            local x, y = MathUtils.quadratic_bezier(
                {x = start_x, y = start_y},
                {x = control_x, y = control_y},
                {x = end_x, y = end_y},
                t
            )
            
            -- Scale with pulse
            local base_scale = MathUtils.lerp(start_scale, end_scale, t)
            local pulse = 1.0 + ((options.peak_scale_mul or 1.35) - 1.0) * math.sin(math.pi * t)
            local current_scale = base_scale * pulse
            
            -- Apply
            object.x = x
            object.y = y
            object.scale = current_scale
            
            if options.on_update_step1 then
                options.on_update_step1({x = x, y = y, scale = current_scale, progress = t})
            end
        end
    })
    
    -- Step 2: Rotation wobble
    if options.wobble_deg and options.wobble_deg > 0 then
        table.insert(sequence_steps, {
            type = "animate",
            duration = options.wobble_duration or 0.1,
            easing = "elastic_out",
            on_update = function(values, t, phase)
                local wobble = math.sin(t * math.pi * 4) * options.wobble_deg * (1 - t)
                object.rotation = wobble
                
                if options.on_update_step2 then
                    options.on_update_step2({rotation = wobble, progress = t})
                end
            end
        })
    end
    
    -- Step 3: Final settle
    table.insert(sequence_steps, {
        type = "animate",
        duration = options.settle_duration or 0.05,
        easing = "bounce_out",
        on_update = function(values, t, phase)
            object.scale = end_scale * (1 - 0.05 * (1 - t))
            
            if options.on_update_step3 then
                options.on_update_step3({scale = object.scale, progress = t})
            end
        end,
        on_complete = options.on_complete
    })
    
    local sequence_id = AnimationEngine.create_sequence(sequence_steps, { tag = tag })
    AnimationEngine.start_sequence(sequence_id)
    return sequence_id
end

-- Create a menu cursor animation (bob + pulse)
function AnimationSequences.menuCursor(object, options)
    options = options or {}
    
    local bob_distance = options.bob_distance or 2
    local pulse_scale = options.pulse_scale or 1.1
    local duration = options.duration or 0.8
    local tag = options.tag
    
    -- Start both animations with same tag
    local bob_id = AnimationSequences.bob(object, {
        distance = bob_distance,
        duration = duration,
        loop = true,
        ping_pong = true,
        tag = tag
    })
    
    local pulse_id = AnimationSequences.pulse(object, {
        scale_from = 1.0,
        scale_to = pulse_scale,
        duration = duration * 1.5,
        loop = true,
        ping_pong = true,
        tag = tag
    })
    
    return {bob = bob_id, pulse = pulse_id}
end

-- Create a card highlight animation (lift + glow)
function AnimationSequences.highlightCard(object, options)
    options = options or {}
    
    local lift_amount = options.lift_amount or 5
    local glow_alpha = options.glow_alpha or 100
    local duration = options.duration or 0.15
    local tag = options.tag
    
    local start_y = object.y or 0
    local start_alpha = object.alpha or 255
    
    return AnimationEngine.animate(
        {y = start_y, alpha = start_alpha},
        {y = start_y - lift_amount, alpha = glow_alpha},
        duration,
        {
            easing = "ease_out",
            tag = tag,
            on_update = function(values)
                object.y = values.y
                object.alpha = values.alpha
            end,
            on_complete = options.on_complete
        }
    )
end

-- ---------------------------------------------------------------------------
-- Tween: Simple property animation for any object
-- ---------------------------------------------------------------------------
function AnimationSequences.tween(object, target_props, duration, options)
    return AnimationEngine.tween(object, target_props, duration, options)
end

-- ---------------------------------------------------------------------------
-- Pre-built Animation Effects (using tween)
-- ---------------------------------------------------------------------------

-- Simple move animation with looping support
function AnimationSequences.move_to(object, target_x, target_y, duration, options)
    options = options or {}
    duration = duration or AnimationSequences.config.default_duration
    options.easing = options.easing or AnimationSequences.config.default_easing
    return AnimationEngine.tween(object, {x = target_x, y = target_y}, duration, options)
end

-- Scale animation with looping support
function AnimationSequences.scale_to(object, target_scale, duration, options)
    options = options or {}
    duration = duration or AnimationSequences.config.default_duration
    options.easing = options.easing or AnimationSequences.config.default_easing
    return AnimationEngine.tween(object, {scale = target_scale}, duration, options)
end

-- Rotation animation with looping support
function AnimationSequences.rotate_to(object, target_angle, duration, options)
    options = options or {}
    duration = duration or AnimationSequences.config.default_duration
    options.easing = options.easing or AnimationSequences.config.default_easing
    return AnimationEngine.tween(object, {angle = target_angle}, duration, options)
end

-- Fade animation with looping support
function AnimationSequences.fade_to(object, target_alpha, duration, options)
    options = options or {}
    duration = duration or AnimationSequences.config.default_duration
    options.easing = options.easing or AnimationSequences.config.default_easing
    return AnimationEngine.tween(object, {alpha = target_alpha}, duration, options)
end

-- Color tint animation with looping support
function AnimationSequences.tint_to(object, target_r, target_g, target_b, duration, options)
    options = options or {}
    duration = duration or AnimationSequences.config.default_duration
    options.easing = options.easing or AnimationSequences.config.default_easing
    return AnimationEngine.tween(object, {r = target_r, g = target_g, b = target_b}, duration, options)
end

-- Color pulse animation with looping support (convenience wrapper)
function AnimationSequences.color_pulse_to(object, target_r, target_g, target_b, target_a, duration, easing, on_complete, loop, ping_pong, easing_back, discrete, tag)
    local options = {
        duration = duration or 0.8,
        easing = easing or "ease_in_out",
        loop = loop ~= nil and loop or true,
        ping_pong = ping_pong ~= nil and ping_pong or true,
        easing_back = easing_back,
        discrete = discrete,
        tag = tag,
        on_complete = on_complete
    }
    
    -- Get current color from object
    local current_color = {
        r = object.r or 255,
        g = object.g or 255,
        b = object.b or 255,
        a = object.alpha or 255
    }
    
    local target_color = {
        r = target_r,
        g = target_g,
        b = target_b,
        a = target_a or current_color.a
    }
    
    return AnimationSequences.color_pulse(object, current_color, target_color, options)
end

-- Discrete-first move animation
function AnimationSequences.move_to_discrete_first(object, target_x, target_y, duration, options)
    options = options or {}
    duration = duration or AnimationSequences.config.default_duration
    options.easing = options.easing or AnimationSequences.config.default_easing
    return AnimationEngine.animate_discrete_first(
        {x = object.x or 0, y = object.y or 0},
        {x = target_x, y = target_y},
        duration,
        {
            easing = options.easing,
            easing_back = options.easing_back,
            discrete = options.discrete,
            tag = options.tag,
            on_update = function(values)
                if object.setPosition then
                    object:setPosition(values.x, values.y)
                else
                    object.x = values.x
                    object.y = values.y
                end
                if options.on_update then
                    options.on_update(values)
                end
            end,
            on_complete = options.on_complete,
            loop = options.loop,
            ping_pong = options.ping_pong
        }
    )
end

-- ---------------------------------------------------------------------------
-- Utility Functions
-- ---------------------------------------------------------------------------

-- Apply an animation to many objects in series (one after another).
function AnimationSequences.series(objects, animator, options)
    options = options or {}

    if type(objects) ~= "table" then
        error("AnimationSequences.series: objects must be an array/table")
    end

    -- Resolve animator by name (optional convenience)
    if type(animator) == "string" then
        animator = AnimationSequences[animator]
    end
    if type(animator) ~= "function" then
        error("AnimationSequences.series: animator must be a function or name of an AnimationSequences function")
    end

    local delay_between = options.delay_between or options.delay or 0
    local loop = options.loop or false
    local on_complete = options.on_complete
    local tag = options.tag

    local base_anim_opts = options.anim_options or {}
    local per_obj_opts = options.per_object_options

    -- Build list (skip nil entries unless skip_nil == false)
    local list = {}
    for _, obj in ipairs(objects) do
        if obj ~= nil or options.skip_nil == false then
            table.insert(list, obj)
        end
    end

    if #list == 0 then
        if on_complete then on_complete() end
        return nil
    end

    local total = #list
    local steps = {}

    for i, obj in ipairs(list) do
        local this_obj = obj
        local this_i = i

        table.insert(steps, {
            type = "run",
            run = function(done)
                local done_called = false
                local function safe_done()
                    if done_called then return end
                    done_called = true
                    done()
                end

                local anim_opts = MathUtils.deep_copy(base_anim_opts)

                if type(per_obj_opts) == "function" then
                    local extra = per_obj_opts(this_obj, this_i, total)
                    if type(extra) == "table" then
                        anim_opts = MathUtils.merge_tables(anim_opts, extra)
                    end
                elseif type(per_obj_opts) == "table" then
                    anim_opts = MathUtils.merge_tables(anim_opts, per_obj_opts)
                end

                -- Pass tag down to each animation
                if tag then
                    anim_opts.tag = tag .. ":" .. i
                end

                -- Wrap on_complete to advance the series
                local user_on_complete = anim_opts.on_complete
                anim_opts.on_complete = function(...)
                    if user_on_complete then user_on_complete(...) end
                    safe_done()
                end

                -- Optional fallback timer (ONLY if provided)
                if options.fallback_duration and options.fallback_duration > 0 then
                    AnimationEngine.delay(options.fallback_duration, safe_done)
                end

                -- Try options-based signature first, then done-based signature.
                local ok, child_id = pcall(animator, this_obj, anim_opts)
                if ok then
                    return child_id
                end

                local ok2, child_id2 = pcall(animator, this_obj, safe_done, this_i, total, anim_opts)
                if ok2 then
                    return child_id2
                end

                print("[AnimationSequences.series] animator error: " .. tostring(child_id))
                safe_done()
                return nil
            end
        })

        if delay_between and delay_between > 0 and (this_i < total or options.delay_after_last) then
            table.insert(steps, { type = "delay", duration = delay_between })
        end
    end

    local sequence_id = AnimationEngine.create_sequence(steps, {
        loop = loop,
        on_complete = on_complete,
        tag = tag
    })

    AnimationEngine.start_sequence(sequence_id)
    return sequence_id
end


-- ---------------------------------------------------------------------------
-- Marquee / Slide Animation
-- ---------------------------------------------------------------------------

--- Move an object horizontally, optionally looping (ping‑pong).
function AnimationSequences.marquee(object, distance, duration, options)
    options = options or {}
    local cfg = AnimationSequences.config.marquee
    local start_x = object.x or 0
    local target_x = start_x + (distance or cfg.distance)
    local easing = options.easing or cfg.easing
    local loop = options.loop
    local on_start_sound = options.on_start_sound
    local on_end_sound = options.on_end_sound
    local on_update = options.on_update
    local on_complete = options.on_complete
    local anim_duration = duration or cfg.duration
    local tag = options.tag

    -- Play start sound if provided
    if on_start_sound then
        Net.play_sound_for_player(object.player_id or object._player_id, on_start_sound)
    end

    -- Create the animation
    local anim_id = AnimationEngine.animate(
        { x = start_x },
        { x = target_x },
        anim_duration,
        {
            easing = easing,
            loop = loop,
            ping_pong = (loop and true) or false,
            tag = tag,
            on_update = function(values, t, phase)
                object.x = values.x
                if on_update then
                    on_update(values, t, phase)
                end
            end,
            on_complete = function(values, interrupted)
                if on_end_sound and not interrupted then
                    Net.play_sound_for_player(object.player_id or object._player_id, on_end_sound)
                end
                if on_complete then
                    on_complete(interrupted)
                end
            end
        }
    )
    return anim_id
end

-- ---------------------------------------------------------------------------
-- Typewriter Animation (reveal sprites one by one)
-- ---------------------------------------------------------------------------

--- Reveal a list of sprite objects in sequence (like a typewriter).
function AnimationSequences.typewriter(sprites, options)
    options = options or {}
    local cfg = AnimationSequences.config.typewriter
    local char_delay = options.char_delay or cfg.char_delay
    local appear_duration = options.appear_duration or cfg.appear_duration
    local appear_easing = options.easing or cfg.easing
    local char_sound = options.char_sound
    local loop = options.loop or false
    local on_start_sound = options.on_start_sound
    local on_end_sound = options.on_end_sound
    local on_complete = options.on_complete
    local tag = options.tag

    -- Default appear function: fade in (alpha 0 → 255) and scale up (0 → 1)
    local appear_func = options.appear_func or function(sprite, idx)
        -- Ensure sprite starts invisible
        sprite.alpha = 0
        sprite.scale = 0
        -- Return an animation that fades in and scales up
        return AnimationEngine.animate(
            { alpha = 0, scale = 0 },
            { alpha = 255, scale = 1 },
            appear_duration,
            {
                easing = appear_easing,
                tag = tag and (tag .. ":char" .. idx),
                on_update = function(v)
                    sprite.alpha = v.alpha
                    sprite.scale = v.scale
                end
            }
        )
    end

    -- Build steps: for each sprite, run its appear animation, then delay
    local steps = {}
    for i, sprite in ipairs(sprites) do
        -- Step to reveal this sprite
        table.insert(steps, {
            type = "run",
            run = function(done)
                -- Play sound if provided
                if char_sound then
                    Net.play_sound_for_player(sprite.player_id or sprite._player_id, char_sound)
                end
                -- Start the appearance animation
                local anim_id = appear_func(sprite, i)
                -- When that animation completes, call done()
                if anim_id then
                    -- We need to know when the animation finishes. Since we have the animation id,
                    -- we could poll or set a timer, but it's simpler to use a delay equal to appear_duration.
                    -- This is a compromise; a more precise approach would require the animation to call a callback.
                    -- We'll use a delay for now.
                    AnimationEngine.delay(appear_duration, done)
                else
                    done()
                end
                return anim_id
            end
        })
        -- Add delay after each reveal (except last)
        if i < #sprites and char_delay > 0 then
            table.insert(steps, { type = "delay", duration = char_delay })
        end
    end

    -- Play start sound
    if on_start_sound and #sprites > 0 then
        local player_id = sprites[1].player_id or sprites[1]._player_id
        Net.play_sound_for_player(player_id, on_start_sound)
    end

    -- Create the sequence
    local seq_id = AnimationEngine.create_sequence(steps, {
        loop = loop,
        tag = tag,
        on_complete = function()
            if on_end_sound and #sprites > 0 then
                local player_id = sprites[1].player_id or sprites[1]._player_id
                Net.play_sound_for_player(player_id, on_end_sound)
            end
            if on_complete then on_complete() end
        end
    })

    AnimationEngine.start_sequence(seq_id)
    return seq_id
end

-- Stop all animations for an object (by tag)
function AnimationSequences.stopAll(tag)
    if tag then
        AnimationEngine.stop_animations_by_tag(tag)
        AnimationEngine.stop_sequences_by_tag(tag)
    else
        AnimationEngine.clear_all()
    end
end

-- Check if any animations are running for a tag
function AnimationSequences.isAnimating(tag)
    -- Placeholder implementation – could check AnimationEngine internal state
    return false
end

-- Reset object to its initial state
function AnimationSequences.reset(object, initial_values)
    initial_values = initial_values or {}
    
    AnimationEngine.set_to(object, {
        x = initial_values.x or object.x,
        y = initial_values.y or object.y,
        scale = initial_values.scale or 1,
        rotation = initial_values.rotation or 0,
        alpha = initial_values.alpha or 255
    })
end

-- ---------------------------------------------------------------------------
-- Export
-- ---------------------------------------------------------------------------
return AnimationSequences