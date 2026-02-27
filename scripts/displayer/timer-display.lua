--[[
timer-display.lua – Displays timers and countdowns using the font system.
Listens to timer events and updates the displayed text.
]]

---@class TimerDisplay
local TimerDisplay = {}
TimerDisplay.__index = TimerDisplay

local fontSystem = require("scripts/displayer/font-system")
local timerSystem = require("scripts/displayer/timer-system")  -- for player list

function TimerDisplay:init()
    self.font_system = fontSystem
    self.displays = {}   -- player_id -> { display_id = { instance_ids, format, etc. } }
    self.global_displays = {} -- display_id -> { type, x, y, options } (store for new players)

    Net:on("timer_update", function(event)
        local ok, err = pcall(function()
            self:updateTimerDisplay(event.player_id, event.timer_id, event.current)
        end)
        if not ok then
            print("Error in timer_update:", err)
        end
    end)

    Net:on("countdown_update", function(event)
        local ok, err = pcall(function()
            self:updateCountdownDisplay(event.player_id, event.countdown_id, event.current)
        end)
        if not ok then
            print("Error in countdown_update:", err)
        end
    end)

    Net:on("timer_remove", function(event)
        local ok, err = pcall(function()
            self:removeDisplay(event.player_id, event.timer_id)
        end)
        if not ok then
            print("Error in timer_remove:", err)
        end
    end)

    Net:on("countdown_remove", function(event)
        local ok, err = pcall(function()
            self:removeDisplay(event.player_id, event.countdown_id)
        end)
        if not ok then
            print("Error in countdown_remove:", err)
        end
    end)

    -- Global timer updates (per player)
    Net:on("timer_global_update", function(event)
        local ok, err = pcall(function()
            self:updateTimerDisplay(event.player_id, event.timer_id, event.current)
        end)
        if not ok then
            print("Error in timer_global_update:", err)
        end
    end)

    Net:on("countdown_global_update", function(event)
        local ok, err = pcall(function()
            self:updateCountdownDisplay(event.player_id, event.countdown_id, event.current)
        end)
        if not ok then
            print("Error in countdown_global_update:", err)
        end
    end)

    -- Global create events – set initial value for new players
    Net:on("timer_global_create", function(event)
        local ok, err = pcall(function()
            self:updateTimerDisplay(event.player_id, event.timer_id, event.current or 0)
        end)
        if not ok then
            print("Error in timer_global_create:", err)
        end
    end)

    Net:on("countdown_global_create", function(event)
        local ok, err = pcall(function()
            self:updateCountdownDisplay(event.player_id, event.countdown_id, event.current or 0)
        end)
        if not ok then
            print("Error in countdown_global_create:", err)
        end
    end)

    -- Global remove events – remove from all players and delete global definition
    Net:on("timer_global_remove", function(event)
        local ok, err = pcall(function()
            if not event.timer_id then
                print("timer_global_remove event missing timer_id")
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
        local ok, err = pcall(function()
            if not event.countdown_id then
                print("countdown_global_remove event missing countdown_id")
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
            -- Create any global displays for the new player
            for display_id, data in pairs(self.global_displays) do
                self:_createDisplay(event.player_id, display_id, data.x, data.y, data.type, data.options)
            end
        end)
        if not ok then
            print("Error in player_join (timer-display):", err)
        end
    end)

    Net:on("player_disconnect", function(event)
        local ok, err = pcall(function()
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
    -- Store for future players
    self.global_displays[display_id] = { type = "timer", x = x, y = y, options = options }
    -- Create for all currently connected players
    if timerSystem and timerSystem.player_data then
        for player_id, _ in pairs(timerSystem.player_data) do
            self:_createDisplay(player_id, display_id, x, y, "timer", options)
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
    self.global_displays[display_id] = { type = "countdown", x = x, y = y, options = options }
    if timerSystem and timerSystem.player_data then
        for player_id, _ in pairs(timerSystem.player_data) do
            self:_createDisplay(player_id, display_id, x, y, "countdown", options)
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
        ro = options.ro or 0,
        color_mode = options.color_mode or 0,
        instance_ids = {},
        current_text = "",
    }
end

---@param player_id string
---@param display_id string
---@param seconds number
function TimerDisplay:updateTimerDisplay(player_id, display_id, seconds)
    print("Updating display", player_id, display_id, seconds)
    self:_updateDisplay(player_id, display_id, seconds, false)
end

---@param player_id string
---@param display_id string
---@param seconds number
function TimerDisplay:updateCountdownDisplay(player_id, display_id, seconds)
    print("Updating display", player_id, display_id, seconds)
    self:_updateDisplay(player_id, display_id, seconds, true)
end

---@param player_id string
---@param display_id string
---@param seconds number
---@param is_countdown boolean
function TimerDisplay:_updateDisplay(player_id, display_id, seconds, is_countdown)
    print("Updating display", player_id, display_id, seconds)
    local disp = self.displays[player_id] and self.displays[player_id][display_id]
    if not disp then
        return
    end

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

    if text == disp.current_text then return end

    for _, inst_id in ipairs(disp.instance_ids) do
        fontSystem:eraseGlyph(player_id, inst_id)
    end
    disp.instance_ids = {}

    local x = disp.x
    for i = 1, #text do
        local ch = text:sub(i,i)
        if ch ~= " " then
            local inst_id = fontSystem:drawGlyph(player_id, disp.font, ch, x, disp.y, {
                scale = disp.scale,
                z = disp.z,
                r = disp.color.r,
                g = disp.color.g,
                b = disp.color.b,
                opacity = disp.opacity,
                ro = disp.ro,
                color_mode = disp.color_mode,
            })
            if inst_id then
                table.insert(disp.instance_ids, inst_id)
            end
        end
        local w, _ = fontSystem:getGlyphDimensions(disp.font, ch)
        x = x + w * disp.scale + 1 * disp.scale
    end

    disp.current_text = text
end

---@param player_id string
---@param display_id string
function TimerDisplay:removeDisplay(player_id, display_id)
    -- Guard against nil display_id
    if not display_id then return end

    local player_displays = self.displays[player_id]
    if player_displays and player_displays[display_id] then
        local disp = player_displays[display_id]
        for _, inst_id in ipairs(disp.instance_ids) do
            fontSystem:eraseGlyph(player_id, inst_id)
        end
        player_displays[display_id] = nil
    end
    -- Do NOT set self.global_displays[display_id] = nil here
end

---@param player_id string
---@param display_id string
---@param x number
---@param y number
function TimerDisplay:setDisplayPosition(player_id, display_id, x, y)
    local disp = self.displays[player_id] and self.displays[player_id][display_id]
    if disp then
        disp.x = x
        disp.y = y
        for _, inst_id in ipairs(disp.instance_ids) do
            fontSystem:eraseGlyph(player_id, inst_id)
        end
        disp.instance_ids = {}
        disp.current_text = ""
    end
end

local timerDisplay = setmetatable({}, TimerDisplay)
timerDisplay:init()
return timerDisplay