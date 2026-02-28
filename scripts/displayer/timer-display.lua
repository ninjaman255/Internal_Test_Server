--[[
timer-display.lua – Displays timers and countdowns using the font system.
Listens to timer events and updates the displayed text.
Now updates individual glyphs without erasing and redrawing all.
When a global display is created, it immediately shows the current timer value.
]]

---@class TimerDisplay
local TimerDisplay = {}
TimerDisplay.__index = TimerDisplay

local fontSystem = require("scripts/displayer/font-system")
local timerSystem = require("scripts/displayer/timer-system")  -- for player list and current values

-- Helper to dump a table for logging
local function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v) .. ', '
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function TimerDisplay:init()
    self.font_system = fontSystem
    self.displays = {}   -- player_id -> { display_id = { type, x, y, options, glyph_data = { {instance_id, char, x}, ... }, current_text = "" } }
    self.global_displays = {} -- display_id -> { type, x, y, options } (store for new players)

    -- Player-specific updates
    Net:on("timer_update", function(event)
        local ok, err = pcall(function()
            if event and event.player_id and event.timer_id then
                self:updateTimerDisplay(event.player_id, event.timer_id, event.current)
            end
        end)
        if not ok then
            print("Error in timer_update:", err)
        end
    end)

    Net:on("countdown_update", function(event)
        local ok, err = pcall(function()
            if event and event.player_id and event.countdown_id then
                self:updateCountdownDisplay(event.player_id, event.countdown_id, event.current)
            end
        end)
        if not ok then
            print("Error in countdown_update:", err)
        end
    end)

    Net:on("timer_remove", function(event)
        local ok, err = pcall(function()
            if event and event.player_id and event.timer_id then
                self:removeDisplay(event.player_id, event.timer_id)
            end
        end)
        if not ok then
            print("Error in timer_remove:", err)
        end
    end)

    Net:on("countdown_remove", function(event)
        local ok, err = pcall(function()
            if event and event.player_id and event.countdown_id then
                self:removeDisplay(event.player_id, event.countdown_id)
            end
        end)
        if not ok then
            print("Error in countdown_remove:", err)
        end
    end)

    -- Global timer updates (update all players that have this display)
    Net:on("timer_global_update", function(event)
        print("timer_global_update handler triggered, event =", dump(event))
        local ok, err = pcall(function()
            if event and event.timer_id then
                print("timer_global_update received for", event.timer_id, "value:", event.current)
                for player_id, displays in pairs(self.displays) do
                    if displays[event.timer_id] then
                        self:updateTimerDisplay(player_id, event.timer_id, event.current)
                    end
                end
            else
                print("timer_global_update missing timer_id, event =", dump(event))
            end
        end)
        if not ok then
            print("Error in timer_global_update:", err)
        end
    end)

    Net:on("countdown_global_update", function(event)
        print("countdown_global_update handler triggered, event =", dump(event))
        local ok, err = pcall(function()
            if event and event.countdown_id then
                print("countdown_global_update received for", event.countdown_id, "value:", event.current)
                for player_id, displays in pairs(self.displays) do
                    if displays[event.countdown_id] then
                        self:updateCountdownDisplay(player_id, event.countdown_id, event.current)
                    end
                end
            else
                print("countdown_global_update missing countdown_id, event =", dump(event))
            end
        end)
        if not ok then
            print("Error in countdown_global_update:", err)
        end
    end)

    -- Global create events – set initial value for all players that have this display
    Net:on("timer_global_create", function(event)
        print("timer_global_create handler triggered, event =", dump(event))
        local ok, err = pcall(function()
            if event and event.timer_id then
                print("timer_global_create received for", event.timer_id)
                for player_id, displays in pairs(self.displays) do
                    if displays[event.timer_id] then
                        self:updateTimerDisplay(player_id, event.timer_id, event.current or 0)
                    end
                end
            else
                print("timer_global_create missing timer_id, event =", dump(event))
            end
        end)
        if not ok then
            print("Error in timer_global_create:", err)
        end
    end)

    Net:on("countdown_global_create", function(event)
        print("countdown_global_create handler triggered, event =", dump(event))
        local ok, err = pcall(function()
            if event and event.countdown_id then
                print("countdown_global_create received for", event.countdown_id)
                for player_id, displays in pairs(self.displays) do
                    if displays[event.countdown_id] then
                        self:updateCountdownDisplay(player_id, event.countdown_id, event.current or 0)
                    end
                end
            else
                print("countdown_global_create missing countdown_id, event =", dump(event))
            end
        end)
        if not ok then
            print("Error in countdown_global_create:", err)
        end
    end)

    -- Global remove events – remove from all players and delete global definition
    Net:on("timer_global_remove", function(event)
        print("timer_global_remove handler triggered, event =", dump(event))
        local ok, err = pcall(function()
            if not event or not event.timer_id then
                return
            end
            for player_id, _ in pairs(self.displays) do
                self:removeDisplay(player_id, event.timer_id)
            end
            self.global_displays[event.timer_id] = nil
        end)
        if not ok then
            print("Error in timer_global_remove:", err)
        end
    end)

    Net:on("countdown_global_remove", function(event)
        print("countdown_global_remove handler triggered, event =", dump(event))
        local ok, err = pcall(function()
            if not event or not event.countdown_id then
                return
            end
            for player_id, _ in pairs(self.displays) do
                self:removeDisplay(player_id, event.countdown_id)
            end
            self.global_displays[event.countdown_id] = nil
        end)
        if not ok then
            print("Error in countdown_global_remove:", err)
        end
    end)

    Net:on("player_join", function(event)
        local ok, err = pcall(function()
            if not event or not event.player_id then return end
            print("player_join in timer-display:", event.player_id)
            -- Create any global displays for the new player and set their current value
            for display_id, data in pairs(self.global_displays) do
                print("Creating global display for new player:", display_id)
                self:_createDisplay(event.player_id, display_id, data.x, data.y, data.type, data.options)
                -- Immediately set the current value from the timer system
                if data.type == "timer" then
                    local current = timerSystem:getGlobalTimer(display_id)
                    self:_updateDisplay(event.player_id, display_id, current, false)
                elseif data.type == "countdown" then
                    local current = timerSystem:getGlobalCountdown(display_id)
                    self:_updateDisplay(event.player_id, display_id, current, true)
                end
            end
        end)
        if not ok then
            print("Error in player_join (timer-display):", err)
        end
    end)

    Net:on("player_disconnect", function(event)
        local ok, err = pcall(function()
            if not event or not event.player_id then return end
            if self.displays[event.player_id] then
                for display_id, _ in pairs(self.displays[event.player_id]) do
                    self:removeDisplay(event.player_id, display_id)
                end
                self.displays[event.player_id] = nil
            end
        end)
        if not ok then
            print("Error in player_disconnect:", err)
        end
    end)

    return self
end

---@class TimerDisplayOptions
---@field font? string
---@field scale? number
---@field z? number
---@field color? {r:integer, g:integer, b:integer}
---@field opacity? integer
---@field a? integer
---@field ro? number
---@field color_mode? integer

---@param player_id string
---@param display_id string
---@param x number
---@param y number
---@param options? TimerDisplayOptions
function TimerDisplay:createPlayerTimerDisplay(player_id, display_id, x, y, options)
    options = options or {}
    self:_createDisplay(player_id, display_id, x, y, "timer", options)
end

---@param player_id string
---@param display_id string
---@param x number
---@param y number
---@param options? TimerDisplayOptions
function TimerDisplay:createPlayerCountdownDisplay(player_id, display_id, x, y, options)
    options = options or {}
    self:_createDisplay(player_id, display_id, x, y, "countdown", options)
end

---@param display_id string
---@param x number
---@param y number
---@param options? TimerDisplayOptions
function TimerDisplay:createGlobalTimerDisplay(display_id, x, y, options)
    options = options or {}
    print("createGlobalTimerDisplay:", display_id, x, y)
    -- Store for future players
    self.global_displays[display_id] = { type = "timer", x = x, y = y, options = options }
    -- Create for all currently connected players and set initial value
    if timerSystem and timerSystem.player_data then
        for player_id, _ in pairs(timerSystem.player_data) do
            print("Creating global timer display for existing player:", player_id)
            self:_createDisplay(player_id, display_id, x, y, "timer", options)
            local current = timerSystem:getGlobalTimer(display_id)
            self:_updateDisplay(player_id, display_id, current, false)
        end
    else
        print("Warning: timerSystem.player_data not available when creating global timer display")
    end
end

---@param display_id string
---@param x number
---@param y number
---@param options? TimerDisplayOptions
function TimerDisplay:createGlobalCountdownDisplay(display_id, x, y, options)
    options = options or {}
    print("createGlobalCountdownDisplay:", display_id, x, y)
    self.global_displays[display_id] = { type = "countdown", x = x, y = y, options = options }
    if timerSystem and timerSystem.player_data then
        for player_id, _ in pairs(timerSystem.player_data) do
            print("Creating global countdown display for existing player:", player_id)
            self:_createDisplay(player_id, display_id, x, y, "countdown", options)
            local current = timerSystem:getGlobalCountdown(display_id)
            self:_updateDisplay(player_id, display_id, current, true)
        end
    else
        print("Warning: timerSystem.player_data not available when creating global countdown display")
    end
end

---@param player_id string
---@param display_id string
---@param x number
---@param y number
---@param type string
---@param options TimerDisplayOptions
function TimerDisplay:_createDisplay(player_id, display_id, x, y, type, options)
    print("_createDisplay:", player_id, display_id, x, y, type)
    self.displays[player_id] = self.displays[player_id] or {}
    if self.displays[player_id][display_id] then
        self:removeDisplay(player_id, display_id)
    end

    self.displays[player_id][display_id] = {
        type = type,
        x = x,
        y = y,
        font = options.font or "THICK",
        scale = options.scale or 2.0,
        z = options.z or 100,
        color = options.color or { r=255, g=255, b=255 },
        opacity = options.opacity or 255,
        a = options.a or 255,
        ro = options.ro or 0,
        color_mode = options.color_mode or 0,
        glyph_data = {},   -- array of {instance_id, char, x}
        current_text = "",
    }
end

---@param player_id string
---@param display_id string
---@param seconds number
function TimerDisplay:updateTimerDisplay(player_id, display_id, seconds)
    self:_updateDisplay(player_id, display_id, seconds, false)
end

---@param player_id string
---@param display_id string
---@param seconds number
function TimerDisplay:updateCountdownDisplay(player_id, display_id, seconds)
    self:_updateDisplay(player_id, display_id, seconds, true)
end

---@param player_id string
---@param display_id string
---@param seconds number
---@param is_countdown boolean
function TimerDisplay:_updateDisplay(player_id, display_id, seconds, is_countdown)
    print("_updateDisplay called:", player_id, display_id, seconds, is_countdown)
    local disp = self.displays[player_id] and self.displays[player_id][display_id]
    if not disp then
        print("_updateDisplay: display not found for player", player_id, "id", display_id)
        return
    end

    -- Format the time string
    local text
    if is_countdown then
        local mins = math.floor(seconds / 60)
        local secs = math.floor(seconds % 60)
        text = string.format("%02d:%02d", mins, secs)
    else
        local hours = math.floor(seconds / 3600)
        local mins = math.floor((seconds % 3600) / 60)
        local secs = math.floor(seconds % 60)
        text = string.format("%02d:%02d:%02d", hours, mins, secs)
    end

    print("_updateDisplay: new text =", text, "old text =", disp.current_text)

    -- If the text hasn't changed, do nothing
    if text == disp.current_text then
        print("_updateDisplay: text unchanged, skipping")
        return
    end

    -- Prepare base options for drawing/updating glyphs
    local base_opts = {
        scale = disp.scale,
        z = disp.z,
        r = disp.color.r,
        g = disp.color.g,
        b = disp.color.b,
        opacity = disp.opacity,
        a = disp.a,
        ro = disp.ro,
        color_mode = disp.color_mode,
    }

    local old_data = disp.glyph_data or {}
    local new_data = {}
    local x = disp.x

    -- Iterate through each character in the new text
    for i = 1, #text do
        local ch = text:sub(i, i)
        local w, _ = fontSystem:getGlyphDimensions(disp.font, ch)

        if i <= #old_data and old_data[i] then
            -- Existing glyph slot
            local old = old_data[i]
            if old.char ~= ch then
                print("Updating glyph", old.instance_id, "from", old.char, "to", ch)
                -- Character changed: update it
                fontSystem:updateGlyph(player_id, old.instance_id, {
                    char = ch,
                    x = x,
                    y = disp.y,
                    scale = disp.scale,
                    z = disp.z,
                    r = disp.color.r,
                    g = disp.color.g,
                    b = disp.color.b,
                    opacity = disp.opacity,
                    a = disp.a,
                    ro = disp.ro,
                    color_mode = disp.color_mode,
                })
                -- Update stored char
                old.char = ch
            else
                -- Character unchanged, but position might have shifted if display was moved
                if old.x ~= x then
                    print("Updating glyph position", old.instance_id, "x from", old.x, "to", x)
                    fontSystem:updateGlyph(player_id, old.instance_id, { x = x })
                end
            end
            -- Keep reference
            table.insert(new_data, old)
        else
            -- Need a new glyph
            print("Drawing new glyph for char", ch, "at x", x)
            local instance_id = fontSystem:drawGlyph(player_id, disp.font, ch, x, disp.y, base_opts)
            if instance_id then
                table.insert(new_data, {
                    instance_id = instance_id,
                    char = ch,
                    x = x,
                })
            end
        end

        x = x + w * disp.scale + 1 * disp.scale
    end

    -- If old data had more glyphs than new text, erase the extras
    for i = #text + 1, #old_data do
        local old = old_data[i]
        if old and old.instance_id then
            print("Erasing extra glyph", old.instance_id)
            fontSystem:eraseGlyph(player_id, old.instance_id)
        end
    end

    -- Update display state
    disp.glyph_data = new_data
    disp.current_text = text
end

---@param player_id string
---@param display_id string
function TimerDisplay:removeDisplay(player_id, display_id)
    if not display_id then return end

    local player_displays = self.displays[player_id]
    if player_displays and player_displays[display_id] then
        local disp = player_displays[display_id]
        if disp.glyph_data then
            for _, glyph in ipairs(disp.glyph_data) do
                fontSystem:eraseGlyph(player_id, glyph.instance_id)
            end
        end
        player_displays[display_id] = nil
    end
end

---@param player_id string
---@param display_id string
---@param x number
---@param y number
function TimerDisplay:setDisplayPosition(player_id, display_id, x, y)
    local disp = self.displays[player_id] and self.displays[player_id][display_id]
    if not disp then return end

    -- Update stored position
    disp.x = x
    disp.y = y

    -- Update each glyph's position
    if disp.glyph_data then
        -- We need to recompute x positions because the whole line may shift
        local current_x = x
        for i, glyph in ipairs(disp.glyph_data) do
            -- Get char to compute width
            local ch = glyph.char
            local w, _ = fontSystem:getGlyphDimensions(disp.font, ch)
            fontSystem:updateGlyph(player_id, glyph.instance_id, { x = current_x, y = y })
            glyph.x = current_x
            current_x = current_x + w * disp.scale + 1 * disp.scale
        end
    end
end

local timerDisplay = setmetatable({}, TimerDisplay)
timerDisplay:init()
return timerDisplay