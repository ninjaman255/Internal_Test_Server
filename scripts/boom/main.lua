--[[@module boom
Safe parser/helpers for boomsheet animation formats 2.0 and 2.5.
Version 2.0: `animation state="NAME"`, `frame duration="0.1"`.
Version 2.5: `!frame_rate 60`, `!image_path "..."`, `anim NAME`, `frame dur=6f`.
The public animation object API remains compatible: get_state/get_frame/get_point/get_duration,
refresh/update/duration, states, imagePath, currFrame, elapsed.
]]
local boom = {}

local function warn(message)
    local full_message = "[boom] " .. tostring(message)
    if type(print) == "function" then print(full_message) end
    return nil, full_message
end

local function cleanstr(value)
    if type(value) ~= "string" then return value end
    if value:sub(1, 1) == '"' and value:sub(-1) == '"' then
        value = value:sub(2, -2)
    end
    return value
end

-- Parse key=value attributes while preserving quoted values containing spaces.
local function parse_attributes(line, convert_numbers, frame_rate)
    local result = {}
    local index = 1
    while index <= #line do
        local s, e, key = line:find('([%w_]+)%s*=%s*', index)
        if not s then break end
        local value_start = e + 1
        local value, finish
        if line:sub(value_start, value_start) == '"' then
            local close = line:find('"', value_start + 1, true)
            if close then value, finish = line:sub(value_start + 1, close - 1), close
            else value, finish = line:sub(value_start + 1), #line end
        else
            local stop = line:find('%s', value_start)
            if stop then value, finish = line:sub(value_start, stop - 1), stop - 1
            else value, finish = line:sub(value_start), #line end
        end
        if key and value ~= nil then
            local number = tonumber(value)
            if convert_numbers and number ~= nil then
                result[key] = number
            elseif convert_numbers and key == "dur" then
                local frames = value:match('^([%+%-]?[%d%.]+)f$')
                if frames then
                    local n = tonumber(frames)
                    if n and frame_rate and frame_rate > 0 then result.duration = n / frame_rate end
                end
            else
                result[key] = value
            end
        end
        index = math.max(finish + 1, e + 1)
    end
    if result.dur ~= nil and result.duration == nil then
        local frames = tostring(result.dur):match('^([%+%-]?[%d%.]+)f$')
        if frames then
            local n = tonumber(frames)
            if n and frame_rate and frame_rate > 0 then result.duration = n / frame_rate end
        elseif tonumber(result.dur) then
            result.duration = tonumber(result.dur)
        end
    end
    result.dur = nil
    return result
end

local function valid_state(animation, state_name, operation)
    if type(animation) ~= "table" then return warn((operation or "Access") .. " failed: animation object is missing or invalid") end
    if type(state_name) ~= "string" or state_name == "" then return warn((operation or "Access") .. " failed: state name must be a non-empty string") end
    local state = animation.states and animation.states[state_name]
    if type(state) ~= "table" then return warn((operation or "Access") .. " failed: animation state '" .. state_name .. "' does not exist") end
    if type(state.framelist) ~= "table" then return warn((operation or "Access") .. " failed: animation state '" .. state_name .. "' has no valid frame list") end
    if #state.framelist == 0 then return warn((operation or "Access") .. " failed: animation state '" .. state_name .. "' has no frames") end
    return state
end

local function make_animation(version)
    local animation = {states = {}, elapsed = 0, imagePath = "", currFrame = {}, version = version, format_version = version, frame_rate = 60}
    function animation.get_state(self, name)
        if type(self) ~= "table" or type(name) ~= "string" or name == "" then return warn("get_state failed: invalid animation or state name") end
        local state = self.states and self.states[name]
        if type(state) ~= "table" then return warn("get_state failed: animation state '" .. name .. "' does not exist") end
        return state
    end
    function animation.get_frame(self, name, frame_index)
        local state, err = valid_state(self, name, "get_frame")
        if not state then return nil, err end
        if type(frame_index) ~= "number" or frame_index ~= math.floor(frame_index) or frame_index < 1 or frame_index > #state.framelist then
            return warn("get_frame failed: invalid frame " .. tostring(frame_index) .. " for state '" .. name .. "' (valid range: 1-" .. #state.framelist .. ")")
        end
        return state.framelist[frame_index]
    end
    function animation.get_point(self, name, frame_index, label)
        local frame, err = self:get_frame(name, frame_index)
        if not frame then return nil, err end
        if type(label) ~= "string" or label == "" then return warn("get_point failed: point label must be a non-empty string") end
        local point = frame.points and frame.points[label]
        if type(point) ~= "table" then return warn("get_point failed: point '" .. label .. "' does not exist on frame " .. tostring(frame_index) .. " of state '" .. name .. "'") end
        return point
    end
    function animation.duration(self, name)
        local state, err = valid_state(self, name, "duration")
        if not state then return nil, err end
        local total = 0
        for i, frame in ipairs(state.framelist) do
            if type(frame.duration) ~= "number" or frame.duration < 0 then return warn("duration failed: frame " .. i .. " in state '" .. name .. "' has a missing or invalid duration") end
            total = total + frame.duration
        end
        return total
    end
    function animation.get_duration(self, name) return self:duration(name) end
    function animation.refresh(self, name)
        local state, err = valid_state(self, name, "refresh")
        if not state then return nil, err end
        self.elapsed = 0
        return self:update(name, 0)
    end
    function animation.update(self, name, seconds)
        local state, err = valid_state(self, name, "update")
        if not state then return nil, err end
        if type(seconds) ~= "number" or seconds ~= seconds or seconds < 0 or seconds == math.huge then return warn("update failed: elapsed seconds must be finite and non-negative") end
        local duration, duration_err = self:duration(name)
        if duration == nil then return nil, duration_err end
        if type(self.elapsed) ~= "number" or self.elapsed < 0 or self.elapsed ~= self.elapsed then self.elapsed = 0 end
        self.elapsed = self.elapsed + seconds
        if duration <= 0 then self.elapsed = 0 elseif state.loop then self.elapsed = self.elapsed % duration elseif self.elapsed > duration then self.elapsed = duration end
        local elapsed, selected = self.elapsed, state.framelist[#state.framelist]
        for _, frame in ipairs(state.framelist) do
            if elapsed < frame.duration then selected = frame; break end
            elapsed = elapsed - frame.duration
        end
        for key in pairs(self.currFrame) do self.currFrame[key] = nil end
        for key, value in pairs(selected) do self.currFrame[key] = value end
        return self.currFrame
    end
    return animation
end

local function read_lines(path)
    local file, err = io.open(path, "rb")
    -- Net asset APIs use /server/assets/... identifiers, while Lua's filesystem
    -- is rooted at the server project and exposes the same files as assets/...
    -- Try the project-relative equivalent before reporting a missing file.
    if not file and type(path) == "string" then
        local relative = path:gsub("^/server/", "")
        if relative ~= path then
            file, err = io.open(relative, "rb")
        end
    end
    if not file then return nil, err end
    local lines = {}
    for line in file:lines() do lines[#lines + 1] = line end
    file:close()
    return lines
end

local function parse_v20(lines, path)
    local animation, current, last_frame = make_animation("2.0"), nil, nil
    for line_no, line in ipairs(lines) do
        local trimmed = line:match('^%s*(.-)%s*$')
        if trimmed ~= "" and trimmed:sub(1, 1) ~= "#" then
            local key = trimmed:match('^(%S+)')
            if key == "imagePath" then
                animation.imagePath = cleanstr(trimmed:match('^imagePath%s*=%s*(.-)%s*$') or trimmed:sub(11))
            elseif key == "animation" then
                local attrs = parse_attributes(trimmed, false, animation.frame_rate)
                -- Empty state names are valid in some existing font atlases
                -- (for example, the glyph used for a space character).
                current = attrs.name
                if current == nil then current = attrs.state end
                if current == nil then return nil, "line " .. line_no .. ": malformed v2.0 animation declaration" end
                animation.states[current] = {framelist = {}, loop = false}
                last_frame = nil
            elseif key == "frame" then
                if not current then return nil, "line " .. line_no .. ": frame before animation state" end
                local frame = parse_attributes(trimmed, true, animation.frame_rate)
                if type(frame.duration) ~= "number" or frame.duration < 0 then return nil, "line " .. line_no .. ": frame duration missing/invalid" end
                animation.states[current].framelist[#animation.states[current].framelist + 1] = frame
                last_frame = frame
            elseif key == "point" and last_frame then
                local point = parse_attributes(trimmed, true, animation.frame_rate)
                local label = point.label
                point.label = nil
                if label and label ~= "" then last_frame.points = last_frame.points or {}; last_frame.points[tostring(label)] = point end
            end
        end
    end
    if not next(animation.states) then return nil, "no v2.0 animation states found in '" .. path .. "'" end
    return animation
end

local function parse_v25(lines, path)
    local animation, current, last_frame = make_animation("2.5"), nil, nil
    for line_no, line in ipairs(lines) do
        local trimmed = line:match('^%s*(.-)%s*$')
        if trimmed ~= "" and trimmed:sub(1, 1) ~= "#" then
            local directive, rest = trimmed:match('^!(%S+)%s*(.-)%s*$')
            if directive == "frame_rate" then
                local rate = tonumber(rest)
                if not rate or rate <= 0 then return nil, "line " .. line_no .. ": invalid !frame_rate" end
                animation.frame_rate = rate
            elseif directive == "image_path" then
                animation.imagePath = cleanstr(rest)
            else
                local key, tail = trimmed:match('^(%S+)%s*(.-)%s*$')
                if key == "anim" then
                    current = tail:match('^([^%s]+)')
                    if not current or current == "" then return nil, "line " .. line_no .. ": missing v2.5 animation name" end
                    animation.states[current] = {framelist = {}, loop = false}
                    last_frame = nil
                elseif key == "frame" then
                    if not current then return nil, "line " .. line_no .. ": frame before anim declaration" end
                    local frame = parse_attributes(tail, true, animation.frame_rate)
                    if type(frame.duration) ~= "number" or frame.duration < 0 then return nil, "line " .. line_no .. ": invalid/missing frame dur (expected dur=11f or dur=0.1)" end
                    animation.states[current].framelist[#animation.states[current].framelist + 1] = frame
                    last_frame = frame
                elseif key == "point" and last_frame then
                    local point = parse_attributes(tail, true, animation.frame_rate)
                    local label = point.label
                    point.label = nil
                    if label and label ~= "" then last_frame.points = last_frame.points or {}; last_frame.points[tostring(label)] = point end
                elseif key == "loop" and current then
                    animation.states[current].loop = tail ~= "false" and tail ~= "0"
                end
            end
        end
    end
    if not next(animation.states) then return nil, "no v2.5 animation states found in '" .. path .. "'" end
    return animation
end

function boom.load(path)
    if type(path) ~= "string" or path == "" then return warn("load failed: path must be a non-empty string") end
    local lines, open_error = read_lines(path)
    if not lines then return warn("load failed: could not open '" .. path .. "': " .. tostring(open_error)) end
    local version = "2.5"
    for _, line in ipairs(lines) do
        if line:match('^%s*animation%s+state%s*=') or line:match('^%s*animation%s+name%s*=') then version = "2.0"; break end
        if line:match('^%s*anim%s+') or line:match('^%s*!frame_rate') or line:match('^%s*!image_path') then version = "2.5"; break end
    end
    local animation, err
    if version == "2.0" then animation, err = parse_v20(lines, path) else animation, err = parse_v25(lines, path) end
    if not animation then return warn("load failed for '" .. path .. "' (detected v" .. version .. "): " .. tostring(err)) end
    animation.source_path = path
    return animation
end

return boom
