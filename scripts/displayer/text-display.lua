--[[
text-display.lua – High‑level text rendering with static, marquee, and text box modes.
Uses FontSystem for glyph management and follows sprite API caching patterns.
]]

---@class TextDisplay
local TextDisplay = {}
TextDisplay.__index = TextDisplay

local fontSystem = require("scripts/displayer/font-system")

-- --------------------------------------------------------------------
-- Helper: word wrapping using pixel widths
-- --------------------------------------------------------------------
---@param text string
---@param font_name string
---@param scale number
---@param max_width number
---@return string[] lines
local function wrapText(text, font_name, scale, max_width)
    local lines = {}
    local words = {}
    for word in text:gmatch("%S+") do
        table.insert(words, word)
    end

    local current_line = ""
    local current_width = 0
    local space_width = fontSystem:getGlyphDimensions(font_name, " ") * scale or 6 * scale

    for _, word in ipairs(words) do
        local word_width = 0
        for i = 1, #word do
            local ch = word:sub(i,i)
            local w, _ = fontSystem:getGlyphDimensions(font_name, ch)
            word_width = word_width + w * scale
            if i < #word then word_width = word_width + 1 * scale end
        end

        if current_width + word_width <= max_width then
            if current_line ~= "" then
                current_line = current_line .. " "
                current_width = current_width + space_width
            end
            current_line = current_line .. word
            current_width = current_width + word_width
        else
            if current_line ~= "" then
                table.insert(lines, current_line)
            end
            current_line = word
            current_width = word_width
        end
    end
    if current_line ~= "" then
        table.insert(lines, current_line)
    end
    return lines
end

-- --------------------------------------------------------------------
-- Text box state machine
-- --------------------------------------------------------------------
---@class TextBox
---@field box_id string
---@field player_id string
---@field text string
---@field x number
---@field y number
---@field width number
---@field height number
---@field font string
---@field scale number
---@field z number
---@field speed number
---@field char_delay number
---@field type_sound string|nil
---@field type_sound_min_dt number
---@field global_props table
---@field per_char_cb function|nil
---@field pages string[][]
---@field current_page integer
---@field current_line integer
---@field current_char integer
---@field timer number
---@field state "printing"|"waiting"|"completed"|"closing"
---@field printed_glyphs string[]
local TextBox = {}
TextBox.__index = TextBox

---@class TextBoxOptions
---@field font? string
---@field scale? number
---@field z? number
---@field speed? number
---@field type_sound? string
---@field type_sound_min_dt? number
---@field r? integer
---@field g? integer
---@field b? integer
---@field opacity? integer
---@field ro? number
---@field color_mode? integer
---@field perChar? fun(page:integer, line:integer, charIndex:integer, char:string):table|nil

---@param box_id string
---@param player_id string
---@param text string
---@param x number
---@param y number
---@param width number
---@param height number
---@param options TextBoxOptions|nil
---@return TextBox
function TextBox.new(box_id, player_id, text, x, y, width, height, options)
    if type(options) ~= "table" then
        options = {}
    end

    local self = setmetatable({}, TextBox)
    self.box_id = box_id
    self.player_id = player_id
    self.text = text
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.font = options.font or "THICK"
    self.scale = options.scale or 2.0
    self.z = options.z or 100
    self.speed = options.speed or 30
    self.char_delay = 1.0 / self.speed
    self.type_sound = options.type_sound
    self.type_sound_min_dt = options.type_sound_min_dt or 0.1
    self.per_char_cb = options.perChar

    self.global_props = {
        r = options.r or 255,
        g = options.g or 255,
        b = options.b or 255,
        opacity = options.opacity or 255,
        ro = options.ro or 0,
        color_mode = options.color_mode or 0,
    }

    self.pages = {}
    local lines = wrapText(text, self.font, self.scale, self.width)
    self.pages[1] = lines

    self.current_page = 1
    self.current_line = 1
    self.current_char = 0
    self.timer = 0
    self.state = "printing"
    self.printed_glyphs = {}

    return self
end

-- Print the next character in the sequence
---@return boolean continue
function TextBox:printNextChar()
    local page = self.pages[self.current_page]
    if not page then return false end

    local line = page[self.current_line]
    if not line then
        self.state = "waiting"
        return false
    end

    self.current_char = self.current_char + 1
    if self.current_char > #line then
        self.current_line = self.current_line + 1
        self.current_char = 0
        if self.current_line > #page then
            self.state = "waiting"
        end
        return false
    end

    local ch = line:sub(self.current_char, self.current_char)
    if ch == " " then
        return true
    end

    local line_height = 12 * self.scale
    local line_y = self.y + (self.current_line - 1) * line_height
    local x_offset = 0
    for i = 1, self.current_char - 1 do
        local c = line:sub(i,i)
        if c ~= " " then
            local w, _ = fontSystem:getGlyphDimensions(self.font, c)
            x_offset = x_offset + w * self.scale + 1 * self.scale
        else
            x_offset = x_offset + 6 * self.scale + 1 * self.scale
        end
    end
    local char_x = self.x + x_offset

    local opts = {
        scale = self.scale,
        z = self.z,
        r = self.global_props.r,
        g = self.global_props.g,
        b = self.global_props.b,
        opacity = self.global_props.opacity,
        ro = self.global_props.ro,
        color_mode = self.global_props.color_mode,
    }

    if self.per_char_cb then
        local overrides = self.per_char_cb(self.current_page, self.current_line, self.current_char, ch)
        if overrides and type(overrides) == "table" then
            for k, v in pairs(overrides) do
                opts[k] = v
            end
        end
    end

    local instance_id = fontSystem:drawGlyph(self.player_id, self.font, ch, char_x, line_y, opts)
    if instance_id then
        table.insert(self.printed_glyphs, instance_id)
    end

    if self.type_sound then
        local now = os.clock()
        if not self._last_sound or now - self._last_sound >= self.type_sound_min_dt then
            Net.play_sound_for_player(self.player_id, self.type_sound)
            self._last_sound = now
        end
    end

    return true
end

-- Update the text box (called every tick)
---@param delta number
function TextBox:update(delta)
    if self.state == "printing" then
        self.timer = self.timer + delta
        while self.timer >= self.char_delay do
            self.timer = self.timer - self.char_delay
            local cont = self:printNextChar()
            if not cont then break end
        end
    end
end

-- Advance to next page immediately (skip printing)
function TextBox:advance()
    for _, id in ipairs(self.printed_glyphs) do
        fontSystem:eraseGlyph(self.player_id, id)
    end
    self.printed_glyphs = {}

    self.current_page = self.current_page + 1
    if self.current_page > #self.pages then
        self.state = "completed"
    else
        self.current_line = 1
        self.current_char = 0
        self.state = "printing"
    end
end

-- Close the text box (erase all glyphs)
function TextBox:close()
    self.state = "closing"
    for _, id in ipairs(self.printed_glyphs) do
        fontSystem:eraseGlyph(self.player_id, id)
    end
    self.printed_glyphs = {}
    self.state = "completed"
end

-- --------------------------------------------------------------------
-- TextDisplay main API
-- --------------------------------------------------------------------
function TextDisplay:init()
    self.font_system = fontSystem
    self.player_boxes = {}   -- player_id -> { box_id = TextBox }
    self.player_static = {}  -- player_id -> { text_id = { instance_ids } }
    self.player_marquees = {} -- player_id -> { marquee_id = MarqueeData }

    Net:on("tick", function(event)
        local ok, err = pcall(function()
            self:updateAll(event.delta_time)
        end)
        if not ok then
            print("Error in tick:", err)
        end
    end)

    return self
end

---@param delta number
function TextDisplay:updateAll(delta)
    for player_id, boxes in pairs(self.player_boxes) do
        for box_id, box in pairs(boxes) do
            box:update(delta)
            if box.state == "completed" then
                boxes[box_id] = nil
            end
        end
    end

    for player_id, marquees in pairs(self.player_marquees) do
        for marquee_id, data in pairs(marquees) do
            data.current_x = data.current_x - data.speed * delta
            if data.current_x + data.total_width < 0 then
                data.current_x = data.start_x
                if data.loops and data.loops > 1 then
                    data.loops = data.loops - 1
                elseif data.loops == 1 then
                    self:removeMarquee(player_id, marquee_id)
                    goto continue
                end
            end
            for i, inst_id in ipairs(data.glyph_ids) do
                local x = data.current_x + data.offsets[i]
                fontSystem:updateGlyph(player_id, inst_id, { x = x })
            end
            ::continue::
        end
    end
end

-- --------------------------------------------------------------------
-- Static text
-- --------------------------------------------------------------------
---@class StaticTextOptions
---@field font? string
---@field scale? number
---@field z? number
---@field r? integer
---@field g? integer
---@field b? integer
---@field opacity? integer
---@field ro? number
---@field color_mode? integer
---@field perChar? fun(charIndex:integer, char:string):table|nil

---@param player_id string
---@param text_id string
---@param text string
---@param x number
---@param y number
---@param options? StaticTextOptions|number
---@return string text_id
function TextDisplay:drawStatic(player_id, text_id, text, x, y, options)
    if type(options) ~= "table" then
        options = {}
    end

    local font = options.font or "THICK"
    local scale = options.scale or 2.0
    local z = options.z or 100

    if self.player_static[player_id] and self.player_static[player_id][text_id] then
        for _, inst_id in ipairs(self.player_static[player_id][text_id]) do
            fontSystem:eraseGlyph(player_id, inst_id)
        end
    end

    self.player_static[player_id] = self.player_static[player_id] or {}
    local instance_ids = {}

    local current_x = x
    for i = 1, #text do
        local ch = text:sub(i,i)
        if ch ~= " " then
            local opts = {
                scale = scale,
                z = z,
                r = options.r, g = options.g, b = options.b,
                opacity = options.opacity,
                ro = options.ro,
                color_mode = options.color_mode,
            }
            if options.perChar then
                local overrides = options.perChar(i, ch)
                if overrides and type(overrides) == "table" then
                    for k, v in pairs(overrides) do
                        opts[k] = v
                    end
                end
            end

            local inst_id = fontSystem:drawGlyph(player_id, font, ch, current_x, y, opts)
            if inst_id then
                table.insert(instance_ids, inst_id)
            end
        end
        local w, _ = fontSystem:getGlyphDimensions(font, ch)
        current_x = current_x + w * scale + 1 * scale
    end

    self.player_static[player_id][text_id] = instance_ids
    return text_id
end

---@param player_id string
---@param text_id string
function TextDisplay:removeStatic(player_id, text_id)
    if self.player_static[player_id] and self.player_static[player_id][text_id] then
        for _, inst_id in ipairs(self.player_static[player_id][text_id]) do
            fontSystem:eraseGlyph(player_id, inst_id)
        end
        self.player_static[player_id][text_id] = nil
    end
end

-- --------------------------------------------------------------------
-- Marquee
-- --------------------------------------------------------------------
---@class MarqueeOptions
---@field font? string
---@field scale? number
---@field z? number
---@field speed? number
---@field loops? integer|nil
---@field r? integer
---@field g? integer
---@field b? integer
---@field opacity? integer
---@field ro? number
---@field color_mode? integer

---@param player_id string
---@param marquee_id string
---@param text string
---@param y number
---@param options? MarqueeOptions|number
---@return string marquee_id
function TextDisplay:drawMarquee(player_id, marquee_id, text, y, options)
    if type(options) ~= "table" then
        options = {}
    end

    local font = options.font or "THICK"
    local scale = options.scale or 2.0
    local z = options.z or 100
    local speed = options.speed or 60
    local loops = options.loops or nil

    local total_width = 0
    local char_widths = {}
    for i = 1, #text do
        local ch = text:sub(i,i)
        local w, _ = fontSystem:getGlyphDimensions(font, ch)
        table.insert(char_widths, w * scale)
        total_width = total_width + w * scale
        if i < #text then total_width = total_width + 1 * scale end
    end

    local start_x = 480
    local glyph_ids = {}
    local offsets = {}
    local current_x = start_x
    for i = 1, #text do
        local ch = text:sub(i,i)
        if ch ~= " " then
            local inst_id = fontSystem:drawGlyph(player_id, font, ch, current_x, y, {
                scale = scale,
                z = z,
                r = options.r, g = options.g, b = options.b,
                opacity = options.opacity,
                ro = options.ro,
                color_mode = options.color_mode,
            })
            if inst_id then
                table.insert(glyph_ids, inst_id)
                table.insert(offsets, current_x - start_x)
            end
        end
        current_x = current_x + char_widths[i] + 1 * scale
    end

    self.player_marquees[player_id] = self.player_marquees[player_id] or {}
    self.player_marquees[player_id][marquee_id] = {
        glyph_ids = glyph_ids,
        offsets = offsets,
        current_x = start_x,
        start_x = start_x,
        total_width = total_width,
        speed = speed,
        loops = loops,
    }

    return marquee_id
end

---@param player_id string
---@param marquee_id string
function TextDisplay:removeMarquee(player_id, marquee_id)
    local data = self.player_marquees[player_id] and self.player_marquees[player_id][marquee_id]
    if data then
        for _, inst_id in ipairs(data.glyph_ids) do
            fontSystem:eraseGlyph(player_id, inst_id)
        end
        self.player_marquees[player_id][marquee_id] = nil
    end
end

-- --------------------------------------------------------------------
-- Text boxes
-- --------------------------------------------------------------------
---@param player_id string
---@param box_id string
---@param text string
---@param x number
---@param y number
---@param width number
---@param height number
---@param options? TextBoxOptions|number
---@return string box_id
function TextDisplay:createTextBox(player_id, box_id, text, x, y, width, height, options)
    if type(options) ~= "table" then
        options = {}
    end

    self.player_boxes[player_id] = self.player_boxes[player_id] or {}
    if self.player_boxes[player_id][box_id] then
        self:removeTextBox(player_id, box_id)
    end

    local box = TextBox.new(box_id, player_id, text, x, y, width, height, options)
    self.player_boxes[player_id][box_id] = box
    return box_id
end

---@param player_id string
---@param box_id string
function TextDisplay:advanceTextBox(player_id, box_id)
    local box = self.player_boxes[player_id] and self.player_boxes[player_id][box_id]
    if box then
        box:advance()
    end
end

---@param player_id string
---@param box_id string
function TextDisplay:closeTextBox(player_id, box_id)
    local box = self.player_boxes[player_id] and self.player_boxes[player_id][box_id]
    if box then
        box:close()
        self.player_boxes[player_id][box_id] = nil
    end
end

---@param player_id string
---@param box_id string
function TextDisplay:removeTextBox(player_id, box_id)
    self:closeTextBox(player_id, box_id)
end

---@param player_id string
---@param box_id string
---@return string "printing"|"waiting"|"completed"|"closing"
function TextDisplay:getTextBoxState(player_id, box_id)
    local box = self.player_boxes[player_id] and self.player_boxes[player_id][box_id]
    return box and box.state or "completed"
end

---@param player_id string
---@param box_id string
---@return table|nil
function TextDisplay:getTextBoxData(player_id, box_id)
    local player_data = self.player_boxes[player_id]
    if not player_data then return nil end
    return player_data[box_id]
end

-- Initialize singleton
local textDisplay = setmetatable({}, TextDisplay)
textDisplay:init()
return textDisplay