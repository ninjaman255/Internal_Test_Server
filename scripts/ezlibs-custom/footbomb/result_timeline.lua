-- Pure timing helpers for FootBomb's result sequence.
-- This module deliberately does not animate actors or wait on async tasks;
-- it calculates timing boundaries from authored animation data and gameplay
-- travel estimates so callers can coordinate their own event-driven tracks.
local ResultTimeline = {}

function ResultTimeline.state_timing(state)
    local frames = state and state.framelist
    if type(frames) ~= "table" or #frames < 2 then
        return nil, "state needs at least two frames (movement plus landing hold)"
    end

    local total_duration = 0
    local movement_duration = 0
    for index, frame in ipairs(frames) do
        local frame_duration = math.max(0, tonumber(frame.duration) or 0)
        total_duration = total_duration + frame_duration
        if index < #frames then
            movement_duration = movement_duration + frame_duration
        end
    end

    if movement_duration <= 0 then
        return nil, "movement frames have no positive duration"
    end
    if total_duration <= 0 then
        return nil, "animation state has no positive duration"
    end

    return {
        frame_count = #frames,
        total_duration = total_duration,
        movement_duration = movement_duration,
        final_frame_duration = math.max(0, tonumber(frames[#frames].duration) or 0),
        final_frame_start = movement_duration,
    }
end

function ResultTimeline.shared_response_duration(options)
    options = options or {}
    -- The response waits for the authored jump animation to finish, while
    -- the defender's movement ends at the movement-frame boundary.
    local jump_duration = math.max(0, tonumber(options.jump_animation_duration)
        or tonumber(options.jump_movement_duration) or 0)
    local defender_duration = math.max(0, tonumber(options.defender_travel_duration) or 0)
    local bomb_duration = math.max(0, tonumber(options.bomb_travel_duration) or 0)
    local matching_jump = options.matching_jump == true
    local center_catch = options.center_catch == true
    local minimum = math.max(0, tonumber(options.minimum_duration) or 0.12)

    -- In catch cases, bomb travel is fitted to the shared timeline later using
    -- the exact attachment point. For ordinary throws, it constrains duration.
    local effective_bomb_duration = (matching_jump or center_catch) and 0 or bomb_duration
    return math.max(minimum, jump_duration, defender_duration, effective_bomb_duration)
end

return ResultTimeline
