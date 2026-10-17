--[[
    @author TheMaverickProgrammer
    @github https://github.com/TheMaverickProgrammer/boomsheetslua
    @module boom
    @date 1/23/2021
    @description Lua parser and playback helpers for boomsheet *.animation files.

    Safe access examples:
        local anim, err = boom.load(path)
        local state, err = anim:get_state("ATTACK_PUNCH")
        local duration, err = anim:get_duration("ATTACK_PUNCH")
        local frame, err = anim:get_frame("ATTACK_PUNCH", 1)
        local point, err = anim:get_point("ATTACK_PUNCH", 1, "Muzzle")

    Missing values are reported with a [boom] message and return nil plus an
    error string. Points are optional; frames without points are valid.
--]]

local boom = {}

local function warn(message)
    local full_message = "[boom] " .. tostring(message)
    if type(print) == "function" then
        print(full_message)
    end
    return nil, full_message
end

local function cleanstr(str)
    if type(str) ~= "string" then
        return str
    end
    return (str:gsub('"', ''))
end

local function parse_attributes(tokens, first_index, convert_numbers)
    local result = {}
    for i = first_index, #tokens do
        local token = tokens[i]
        local equals = token:find("=", 1, true)
        if equals then
            local key = cleanstr(token:sub(1, equals - 1))
            local raw_value = cleanstr(token:sub(equals + 1))
            local value = raw_value
            if convert_numbers then
                local number = tonumber(raw_value)
                if number ~= nil then
                    value = number
                end
            end
            if key ~= "" then
                result[key] = value
            end
        end
    end
    return result
end

local function valid_state(animation, state_name, operation)
    if type(animation) ~= "table" then
        return warn((operation or "Access") .. " failed: animation object is missing or invalid")
    end
    if type(state_name) ~= "string" or state_name == "" then
        return warn((operation or "Access") .. " failed: state name must be a non-empty string")
    end

    local state = animation.states and animation.states[state_name]
    if type(state) ~= "table" then
        return warn((operation or "Access") .. " failed: animation state '" .. state_name .. "' does not exist")
    end
    if type(state.framelist) ~= "table" then
        return warn((operation or "Access") .. " failed: animation state '" .. state_name .. "' has no valid frame list")
    end
    if #state.framelist == 0 then
        return warn((operation or "Access") .. " failed: animation state '" .. state_name .. "' has no frames")
    end
    return state
end

local function make_animation()
    local animation = {
        states = {},
        elapsed = 0,
        imagePath = "",
        currFrame = {}
    }

    -- Return a state or nil and a useful diagnostic.
    function animation.get_state(self, state_name)
        if type(self) ~= "table" then
            return warn("get_state failed: animation object is missing or invalid")
        end
        if type(state_name) ~= "string" or state_name == "" then
            return warn("get_state failed: state name must be a non-empty string")
        end
        local state = self.states and self.states[state_name]
        if type(state) ~= "table" then
            return warn("get_state failed: animation state '" .. state_name .. "' does not exist")
        end
        return state
    end

    -- Return the frame at a 1-based index or nil and a useful diagnostic.
    function animation.get_frame(self, state_name, frame_index)
        local state, err = valid_state(self, state_name, "get_frame")
        if not state then
            return nil, err
        end
        if type(frame_index) ~= "number" or frame_index ~= math.floor(frame_index) then
            return warn("get_frame failed: frame index for state '" .. state_name .. "' must be an integer")
        end
        if frame_index < 1 or frame_index > #state.framelist then
            return warn("get_frame failed: frame " .. tostring(frame_index) .. " does not exist in state '" .. state_name .. "' (valid range: 1-" .. tostring(#state.framelist) .. ")")
        end
        local frame = state.framelist[frame_index]
        if type(frame) ~= "table" then
            return warn("get_frame failed: frame " .. tostring(frame_index) .. " in state '" .. state_name .. "' is invalid")
        end
        return frame
    end

    -- Return a point from a frame. Points are optional on all frames.
    function animation.get_point(self, state_name, frame_index, point_label)
        local frame, err = self:get_frame(state_name, frame_index)
        if not frame then
            return nil, err
        end
        if type(point_label) ~= "string" or point_label == "" then
            return warn("get_point failed: point label must be a non-empty string")
        end
        if type(frame.points) ~= "table" then
            return warn("get_point failed: frame " .. tostring(frame_index) .. " in state '" .. state_name .. "' has no points (requested '" .. point_label .. "')")
        end
        local point = frame.points[point_label]
        if type(point) ~= "table" then
            return warn("get_point failed: point '" .. point_label .. "' does not exist on frame " .. tostring(frame_index) .. " of state '" .. state_name .. "'")
        end
        return point
    end

    -- Return the total duration of a state, or nil if the state is invalid.
    function animation.duration(self, state_name)
        local state, err = valid_state(self, state_name, "duration")
        if not state then
            return nil, err
        end

        local total = 0
        for index, frame in ipairs(state.framelist) do
            if type(frame) ~= "table" then
                return warn("duration failed: frame " .. tostring(index) .. " in state '" .. state_name .. "' is invalid")
            end
            if type(frame.duration) ~= "number" or frame.duration < 0 then
                return warn("duration failed: frame " .. tostring(index) .. " in state '" .. state_name .. "' has a missing or invalid duration")
            end
            total = total + frame.duration
        end
        return total
    end

    -- Alias with an explicit getter name.
    function animation.get_duration(self, state_name)
        return self:duration(state_name)
    end

    -- Reset playback and apply the first frame.
    function animation.refresh(self, state_name)
        local state, err = valid_state(self, state_name, "refresh")
        if not state then
            return nil, err
        end
        self.elapsed = 0
        return self:update(state_name, 0)
    end

    -- Advance playback by seconds. Invalid states/times safely return nil.
    function animation.update(self, state_name, seconds)
        local state, err = valid_state(self, state_name, "update")
        if not state then
            return nil, err
        end
        if type(seconds) ~= "number" or seconds ~= seconds or seconds < 0 or seconds == math.huge then
            return warn("update failed: elapsed seconds must be a finite, non-negative number")
        end

        local duration, duration_err = self:duration(state_name)
        if duration == nil then
            return nil, duration_err
        end

        if type(self.elapsed) ~= "number" or self.elapsed < 0 or self.elapsed ~= self.elapsed then
            self.elapsed = 0
        end
        self.elapsed = self.elapsed + seconds

        if duration <= 0 then
            self.elapsed = 0
        elseif state.loop then
            self.elapsed = self.elapsed % duration
        elseif self.elapsed > duration then
            self.elapsed = duration
        end

        local elapsed = self.elapsed
        local selected_frame = state.framelist[#state.framelist]
        for _, frame in ipairs(state.framelist) do
            local frame_duration = frame.duration
            if elapsed < frame_duration then
                selected_frame = frame
                break
            end
            elapsed = elapsed - frame_duration
        end

        if type(selected_frame) ~= "table" then
            return warn("update failed: no valid frame found for state '" .. state_name .. "'")
        end

        -- Keep currFrame table identity for callers that retain this reference,
        -- but clear old keys so values don't leak from the previously selected frame.
        for key in pairs(self.currFrame) do
            self.currFrame[key] = nil
        end
        for key, value in pairs(selected_frame) do
            self.currFrame[key] = value
        end
        return self.currFrame
    end

    return animation
end

-- Load and parse an animation file. Returns animation, or nil and an error.
function boom.load(path)
    if type(path) ~= "string" or path == "" then
        return warn("load failed: path must be a non-empty string")
    end

    local file, open_error = io.open(path, "rb")
    if not file then
        return warn("load failed: could not open '" .. path .. "': " .. tostring(open_error))
    end
    file:close()

    local animation = make_animation()
    local curr_state_name = nil
    local last_frame = nil
    local line_number = 0

    local ok, parse_error = pcall(function()
        for line in io.lines(path) do
            line_number = line_number + 1
            local tokens = {}
            for token in line:gmatch("([^%s]+)%s*") do
                table.insert(tokens, token)
            end

            local key = tokens[1]
            if not key or key:sub(1, 1) == "#" then
                -- Blank lines and full-line comments are ignored.
            elseif key:sub(1, 9) == "imagePath" then
                animation.imagePath = cleanstr(key:sub(11))
            elseif key == "animation" then
                local attrs = parse_attributes(tokens, 2, false)
                local state_name = attrs.name or attrs.state
                if not state_name then
                    -- Support the original animation=name form.
                    local raw = tokens[2]
                    if raw then
                        local equals = raw:find("=", 1, true)
                        if equals then
                            state_name = cleanstr(raw:sub(equals + 1))
                        end
                    end
                end
                if type(state_name) ~= "string" or state_name == "" then
                    error("line " .. tostring(line_number) .. ": malformed animation declaration (expected animation=name)")
                end
                curr_state_name = state_name
                animation.states[curr_state_name] = {framelist = {}, loop = false}
                last_frame = nil
            elseif key == "frame" then
                if not curr_state_name or not animation.states[curr_state_name] then
                    error("line " .. tostring(line_number) .. ": frame declared before an animation state")
                end
                local frame = parse_attributes(tokens, 2, true)
                if type(frame.duration) ~= "number" or frame.duration < 0 then
                    error("line " .. tostring(line_number) .. ": frame has a missing or invalid duration")
                end
                table.insert(animation.states[curr_state_name].framelist, frame)
                last_frame = frame
            elseif key == "point" then
                if not last_frame then
                    -- A point without a preceding frame is ignored safely.
                else
                    local point = parse_attributes(tokens, 2, true)
                    local label = point.label
                    if label ~= nil and tostring(label) ~= "" then
                        point.label = nil
                        last_frame.points = last_frame.points or {}
                        last_frame.points[tostring(label)] = point
                    else
                        -- Ignore malformed unlabeled point lines without aborting load.
                    end
                end
            end
        end
    end)

    if not ok then
        return warn("load failed for '" .. path .. "' at line " .. tostring(line_number) .. ": " .. tostring(parse_error))
    end

    if next(animation.states) == nil then
        return warn("load failed for '" .. path .. "': no animation states were found")
    end

    return animation
end

return boom
