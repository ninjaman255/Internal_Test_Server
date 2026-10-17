-- Startup diagnostics for FootBomb's active v2.0 Navi animations and their
-- optional v2.5 .ani counterparts. This module is read-only: it never changes
-- the animation state used by Net.animate_bot.
local Boom = require("scripts/boom/main")

local Diagnostics = {}

local function emit(log, message)
    log("ANIM_DIAGNOSTICS: " .. tostring(message))
end

local function sorted_state_names(states)
    local names = {}
    for name in pairs(states or {}) do names[#names + 1] = name end
    table.sort(names)
    return names
end

local function inspect_file(option, path, expected_state, log)
    emit(log, "BEGIN navi=" .. tostring(option.name) .. " path=" .. tostring(path) .. " texture=" .. tostring(option.texture))
    local animation, err = Boom.load(path)
    if not animation then
        emit(log, "LOAD_FAILED navi=" .. tostring(option.name) .. " path=" .. tostring(path) .. " error=" .. tostring(err))
        return false
    end

    local state_names = sorted_state_names(animation.states)
    local total_frames, total_points = 0, 0
    emit(log, "LOADED navi=" .. tostring(option.name)
        .. " version=" .. tostring(animation.version)
        .. " frame_rate=" .. tostring(animation.frame_rate)
        .. " imagePath=" .. tostring(animation.imagePath)
        .. " states=" .. tostring(#state_names))

    for _, state_name in ipairs(state_names) do
        local state = animation.states[state_name]
        local state_frames, duration = #state.framelist, 0
        for _, frame in ipairs(state.framelist) do
            duration = duration + (tonumber(frame.duration) or 0)
        end
        total_frames = total_frames + state_frames
        emit(log, "STATE navi=" .. tostring(option.name) .. " version=" .. animation.version
            .. " name=" .. state_name .. " frames=" .. state_frames
            .. " duration_seconds=" .. string.format("%.6f", duration)
            .. " loop=" .. tostring(state.loop == true))
        for index, frame in ipairs(state.framelist) do
            local point_names = {}
            for point_name, point in pairs(frame.points or {}) do
                point_names[#point_names + 1] = point_name
                total_points = total_points + 1
                emit(log, "POINT navi=" .. tostring(option.name) .. " version=" .. animation.version
                    .. " state=" .. state_name .. " frame=" .. index .. " label=" .. point_name
                    .. " values=" .. (function()
                        local keys, parts = {}, {}
                        for k in pairs(point) do keys[#keys + 1] = k end
                        table.sort(keys)
                        for _, k in ipairs(keys) do parts[#parts + 1] = tostring(k) .. "=" .. tostring(point[k]) end
                        return table.concat(parts, ",")
                    end)())
            end
            table.sort(point_names)
            local rect = "x=" .. tostring(frame.x) .. ",y=" .. tostring(frame.y)
                .. ",w=" .. tostring(frame.w) .. ",h=" .. tostring(frame.h)
            emit(log, "FRAME navi=" .. tostring(option.name) .. " version=" .. animation.version
                .. " state=" .. state_name .. " index=" .. index
                .. " duration_seconds=" .. tostring(frame.duration) .. " " .. rect
                .. " originx=" .. tostring(frame.originx) .. " originy=" .. tostring(frame.originy)
                .. " flipx=" .. tostring(frame.flipx) .. " flipy=" .. tostring(frame.flipy)
                .. " points=" .. table.concat(point_names, ","))
        end
    end

    local expected = animation.states[expected_state]
    emit(log, "SUMMARY navi=" .. tostring(option.name) .. " version=" .. animation.version
        .. " states=" .. #state_names .. " frames=" .. total_frames .. " point_entries=" .. total_points
        .. " configured_state=" .. tostring(expected_state)
        .. " configured_state_exists=" .. tostring(expected ~= nil)
        .. " configured_state_frames=" .. tostring(expected and #expected.framelist or 0))
    return expected ~= nil
end

function Diagnostics.run(options, log)
    log = type(log) == "function" and log or print
    emit(log, "START roster_entries=" .. tostring(#(options or {})) .. " target_version=2.0 alternate_version=2.5")
    local active_ok, alternate_ok, active_count, alternate_count = 0, 0, 0, 0
    for _, option in ipairs(options or {}) do
        active_count = active_count + 1
        if inspect_file(option, option.animation, option.animation_state, log) then active_ok = active_ok + 1 end
        local alternate_path = type(option.animation) == "string" and option.animation:gsub("%.animation$", ".ani") or nil
        if alternate_path and alternate_path ~= option.animation then
            alternate_count = alternate_count + 1
            if inspect_file(option, alternate_path, option.animation_state, log) then alternate_ok = alternate_ok + 1 end
        end
    end
    emit(log, "END active_v2_0_state_checks=" .. active_ok .. "/" .. active_count
        .. " alternate_v2_5_state_checks=" .. alternate_ok .. "/" .. alternate_count)
end

return Diagnostics
