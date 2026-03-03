--[[
text-display.lua – Unified text rendering with static, marquee, and typewriter modes.
Uses FontSystem for glyph management. Supports bounding boxes, alignment, and per‑character callbacks.

COORDINATES: All x, y, width, height passed to public functions are in virtual 240×160 space.
They are automatically multiplied by 2 before internal layout and drawing.
]]

local TextDisplay = {}
TextDisplay.__index = TextDisplay

local fontSystem = require("scripts/displayer/font-system")

-- --------------------------------------------------------------------
-- Helper: normalize loops option
--   nil or true → infinite (nil)
--   false or "once" → 1
--   number ≥1 → that many passes
-- --------------------------------------------------------------------
local function _normalize_loops(v)
    if v == nil or v == true then return nil end
    if v == false or v == "once" then return 1 end
    local n = tonumber(v)
    if n then
        n = math.floor(n)
        if n < 1 then return 1 end
        return n
    end
    return nil  -- fallback to infinite
end

-- --------------------------------------------------------------------
-- Word wrapping utility (operates in screen pixels after scaling)
-- --------------------------------------------------------------------
local function wrapText(text, font_name, scale, max_width)
    if not max_width then
        -- No wrapping: return a single line
        return { text }
    end

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
-- Layout: compute per‑glyph positions (relative to bounding box top‑left)
-- Returns:
--   lines: array of strings
--   flat_glyphs: array of { char, x, y, line, col } (flat list for bulk operations)
--   glyph_grid: 2D table [line][col] = { char, x, y } or nil for spaces
--   total_width, total_height
-- All coordinates are in screen pixels (480×320) after scaling.
-- --------------------------------------------------------------------
local function layoutText(text, font, scale, box_x, box_y, box_width, box_height, halign, valign)
    local lines = wrapText(text, font, scale, box_width)
    local line_height = 12 * scale  -- approximate; could be improved with actual max glyph height

    -- Determine total content width and height
    local total_width = 0
    for _, line in ipairs(lines) do
        local line_width = 0
        for i = 1, #line do
            local ch = line:sub(i,i)
            local w, _ = fontSystem:getGlyphDimensions(font, ch)
            line_width = line_width + w * scale
            if i < #line then line_width = line_width + 1 * scale end
        end
        if line_width > total_width then total_width = line_width end
    end
    local total_height = #lines * line_height

    -- Compute starting offsets within bounding box (or at box_x, box_y if no box)
    local start_x = box_x
    local start_y = box_y

    if box_width and box_height then
        if halign == "center" then
            start_x = box_x + (box_width - total_width) / 2
        elseif halign == "right" then
            start_x = box_x + box_width - total_width
        end
        if valign == "middle" then
            start_y = box_y + (box_height - total_height) / 2
        elseif valign == "bottom" then
            start_y = box_y + box_height - total_height
        end
    end

    -- Build glyph grid and flat list
    local glyph_grid = {}
    local flat_glyphs = {}
    for line_idx, line in ipairs(lines) do
        glyph_grid[line_idx] = {}
        local x = start_x
        local y = start_y + (line_idx - 1) * line_height
        for col = 1, #line do
            local ch = line:sub(col, col)
            if ch ~= " " then
                local glyph = {
                    char = ch,
                    x = x,
                    y = y,
                    line = line_idx,
                    col = col,
                }
                glyph_grid[line_idx][col] = glyph
                table.insert(flat_glyphs, glyph)
            else
                glyph_grid[line_idx][col] = nil  -- space, no glyph
            end
            local w, _ = fontSystem:getGlyphDimensions(font, ch)
            x = x + w * scale + 1 * scale
        end
    end

    return lines, flat_glyphs, glyph_grid, total_width, total_height
end

-- --------------------------------------------------------------------
-- TextDisplay class (unified)
-- --------------------------------------------------------------------
local TextDisplayInstance = {}
TextDisplayInstance.__index = TextDisplayInstance

function TextDisplayInstance:new(player_id, text_id, text, x, y, options)
    local o = setmetatable({}, TextDisplayInstance)
    o.player_id = player_id
    o.text_id = text_id
    o.text = text

    -- Scale virtual coordinates/dimensions to screen pixels
    o.x = x * 2
    o.y = y * 2
    o.width = options.width and (options.width * 2) or nil
    o.height = options.height and (options.height * 2) or nil

    o.font = options.font or "THICK"
    o.scale = options.scale or 2.0
    o.z = options.z or 100
    o.global = {
        r = options.r or 255,
        g = options.g or 255,
        b = options.b or 255,
        opacity = options.opacity or 255,
        a = options.a or 255,
        ro = options.ro or 0,
        color_mode = options.color_mode or 0,
    }
    o.halign = options.halign or "left"
    o.valign = options.valign or "top"
    o.perChar = options.perChar      -- function(index, char, context) -> overrides

    o.mode = options.mode or "static"
    -- Mode‑specific options
    if o.mode == "marquee" then
        local loops_raw = (options.marquee and options.marquee.loops) or options.loops
        o.loops = _normalize_loops(loops_raw)   -- nil = infinite, number = finite passes
        o.speed = (options.marquee and options.marquee.speed) or options.speed or 60
        o.scroll_x = nil   -- will be set after layout
    elseif o.mode == "typewriter" then
        local tw = options.typewriter or {}
        o.speed = tw.speed or options.speed or 30   -- chars per second
        o.char_delay = 1.0 / o.speed
        o.sound = tw.sound or options.type_sound
        o.sound_min_dt = tw.sound_min_dt or options.type_sound_min_dt or 0.1
        o.current_page = 1
        o.current_line = 1
        o.current_char = 0
        o.timer = 0
        o.state = "printing"
        o.printed_glyphs = {}   -- instance ids of printed glyphs (for easy cleanup)
        o._last_sound = 0
    end

    -- Layout data
    o.lines = nil
    o.flat_glyphs = nil          -- flat list of all glyphs (non‑space)
    o.glyph_grid = nil           -- 2D grid [line][col] = glyph data (includes instance_id when drawn)
    o.total_width = 0
    o.total_height = 0

    o:relayout()

    return o
end

function TextDisplayInstance:relayout()
    self.lines, self.flat_glyphs, self.glyph_grid, self.total_width, self.total_height =
        layoutText(self.text, self.font, self.scale,
                   self.x, self.y, self.width, self.height,
                   self.halign, self.valign)

    -- For marquee, set initial scroll position
    if self.mode == "marquee" then
        self.scroll_x = self.x + self.total_width   -- start off‑screen to the right
    end
end

-- Draw or update all glyphs based on current mode and state
function TextDisplayInstance:redraw()
    if self.mode == "static" then
        self:_drawAllGlyphs()
    elseif self.mode == "marquee" then
        self:_drawMarqueeGlyphs()
    elseif self.mode == "typewriter" then
        self:_drawTypewriterGlyphs()
    end
end

function TextDisplayInstance:_drawAllGlyphs(overrides)
    -- overrides is an optional table of global overrides (e.g., for marquee offset)
    overrides = overrides or {}
    for i, glyph in ipairs(self.flat_glyphs) do
        local opts = {
            scale = self.scale,
            z = self.z,
            r = self.global.r,
            g = self.global.g,
            b = self.global.b,
            opacity = self.global.opacity,
            a = self.global.a,
            ro = self.global.ro,
            color_mode = self.global.color_mode,
            x = (overrides.x_offset and glyph.x + overrides.x_offset) or glyph.x,
            y = glyph.y,
        }
        -- Apply per‑character callback if present
        if self.perChar then
            local context = {}
            if self.mode == "marquee" then
                context.elapsed = overrides.elapsed
            end
            local over = self.perChar(i, glyph.char, context)
            if over then
                for k, v in pairs(over) do opts[k] = v end
            end
        end
        local inst_id = glyph.instance_id
        if not inst_id then
            local virtual_x = opts.x / 2
            local virtual_y = opts.y / 2
            inst_id = fontSystem:drawGlyph(self.player_id, self.font, glyph.char, virtual_x, virtual_y, opts)
            glyph.instance_id = inst_id
        else
            -- Convert screen coordinates to virtual before update
            local update_opts = {}
            for k, v in pairs(opts) do
                update_opts[k] = v
            end
            update_opts.x = opts.x / 2
            update_opts.y = opts.y / 2
            fontSystem:updateGlyph(self.player_id, inst_id, update_opts)
        end
    end
end

function TextDisplayInstance:_drawMarqueeGlyphs()
    -- Draw all glyphs with an x offset = scroll_x
    self:_drawAllGlyphs({ x_offset = self.scroll_x, elapsed = self.elapsed })
end

function TextDisplayInstance:_drawTypewriterGlyphs()
    -- Nothing to do here; glyphs are drawn incrementally in update/printNextChar
end

-- Typewriter: print next character
function TextDisplayInstance:printNextChar()
    if self.state ~= "printing" then return false end

    local line = self.lines[self.current_line]
    if not line then
        self.state = "waiting"
        return false
    end

    self.current_char = self.current_char + 1
    if self.current_char > #line then
        self.current_line = self.current_line + 1
        self.current_char = 0
        if self.current_line > #self.lines then
            self.state = "waiting"
        end
        return false
    end

    local ch = line:sub(self.current_char, self.current_char)
    if ch == " " then return true end

    -- Get the glyph from the grid using current line and char position
    local glyph = self.glyph_grid[self.current_line][self.current_char]
    if not glyph then
        -- Should not happen if character is not a space
        return true
    end

    local opts = {
        scale = self.scale,
        z = self.z,
        r = self.global.r,
        g = self.global.g,
        b = self.global.b,
        opacity = self.global.opacity,
        a = self.global.a,
        ro = self.global.ro,
        color_mode = self.global.color_mode,
        x = glyph.x,
        y = glyph.y,
    }
    if self.perChar then
        local context = { page = 1, line = self.current_line, isNew = true }
        local flat_idx = nil
        for idx, g in ipairs(self.flat_glyphs) do
            if g == glyph then
                flat_idx = idx
                break
            end
        end
        local over = self.perChar(flat_idx or 0, ch, context)
        if over then
            for k, v in pairs(over) do opts[k] = v end
        end
    end

    -- Convert screen coordinates to virtual before calling fontSystem
    local virtual_x = opts.x / 2
    local virtual_y = opts.y / 2
    local inst_id = fontSystem:drawGlyph(self.player_id, self.font, ch, virtual_x, virtual_y, opts)
    if inst_id then
        glyph.instance_id = inst_id
        table.insert(self.printed_glyphs, inst_id)
    end

    if self.sound then
        local now = os.clock()
        if now - self._last_sound >= self.sound_min_dt then
            Net.play_sound_for_player(self.player_id, self.sound)
            self._last_sound = now
        end
    end

    return true
end

function TextDisplayInstance:update(dt)
    if self.mode == "marquee" then
        self.elapsed = (self.elapsed or 0) + dt
        self.scroll_x = self.scroll_x - self.speed * dt
        if self.scroll_x + self.total_width < self.x then
            self.scroll_x = self.x + self.total_width
            if self.loops then
                if self.loops > 1 then
                    self.loops = self.loops - 1
                elseif self.loops == 1 then
                    self.state = "completed"   -- finished after last loop
                end
            end
        end
        self:_drawMarqueeGlyphs()

    elseif self.mode == "typewriter" and self.state == "printing" then
        self.timer = self.timer + dt
        while self.timer >= self.char_delay do
            self.timer = self.timer - self.char_delay
            local cont = self:printNextChar()
            if not cont then break end
        end
    end
end

-- Advance typewriter to next page (skip remaining characters)
function TextDisplayInstance:advance()
    if self.mode ~= "typewriter" then return end
    for _, id in ipairs(self.printed_glyphs) do
        fontSystem:eraseGlyph(self.player_id, id)
    end
    self.printed_glyphs = {}
    self.current_page = self.current_page + 1
    if self.current_page > 1 then   -- we only have one page currently
        self.state = "completed"
    else
        self.current_line = 1
        self.current_char = 0
        self.state = "printing"
    end
end

-- Close/remove all glyphs
function TextDisplayInstance:close()
    -- Erase all glyphs from flat list
    for _, glyph in ipairs(self.flat_glyphs) do
        if glyph.instance_id then
            fontSystem:eraseGlyph(self.player_id, glyph.instance_id)
            glyph.instance_id = nil
        end
    end
    -- Also clear grid references (optional)
    for line_idx, line in ipairs(self.glyph_grid or {}) do
        for col, glyph in pairs(line) do
            glyph.instance_id = nil
        end
    end
    self.printed_glyphs = {}
    self.state = "completed"
end

-- --------------------------------------------------------------------
-- TextDisplay main API
-- --------------------------------------------------------------------
function TextDisplay:init()
    self.font_system = fontSystem
    self.player_texts = {}   -- player_id -> { text_id = TextDisplayInstance }

    Net:on("tick", function(event)
        local ok, err = pcall(function()
            self:updateAll(event.delta_time)
        end)
        if not ok then
            print("Error in tick:", err)
        end
    end)

    Net:on("player_disconnect", function(event)
        local ok, err = pcall(function()
            self:cleanupPlayer(event.player_id)
        end)
        if not ok then
            print("Error in player_disconnect:", err)
        end
    end)

    return self
end

function TextDisplay:cleanupPlayer(player_id)
    if not self.player_texts[player_id] then return end
    for _, display in pairs(self.player_texts[player_id]) do
        display:close()
    end
    self.player_texts[player_id] = nil
end

function TextDisplay:updateAll(dt)
    for player_id, displays in pairs(self.player_texts) do
        for text_id, display in pairs(displays) do
            display:update(dt)
            if display.state == "completed" then
                display:close()               -- erase glyphs before removal
                displays[text_id] = nil
            end
        end
    end
end

-- --------------------------------------------------------------------
-- Unified draw function
-- --------------------------------------------------------------------
---@param player_id string
---@param text_id string
---@param text string
---@param x number        # virtual 240×160 coordinate
---@param y number        # virtual 240×160 coordinate
---@param options table   (see documentation)
---@return string text_id
function TextDisplay:draw(player_id, text_id, text, x, y, options)
    options = options or {}
    self.player_texts[player_id] = self.player_texts[player_id] or {}

    -- If text_id already exists, remove it first
    if self.player_texts[player_id][text_id] then
        self.player_texts[player_id][text_id]:close()
    end

    local display = TextDisplayInstance:new(player_id, text_id, text, x, y, options)
    display:redraw()   -- initial draw (static/marquee only; typewriter does nothing)
    self.player_texts[player_id][text_id] = display
    return text_id
end

-- --------------------------------------------------------------------
-- Backward compatibility wrappers
-- --------------------------------------------------------------------
function TextDisplay:drawStatic(player_id, text_id, text, x, y, options)
    if type(options) ~= "table" then options = {} end
    options.mode = "static"
    return self:draw(player_id, text_id, text, x, y, options)
end

function TextDisplay:drawMarquee(player_id, marquee_id, text, y, options)
    if type(options) ~= "table" then options = {} end
    options.mode = "marquee"
    -- x = 0 in virtual space (left edge)
    return self:draw(player_id, marquee_id, text, 0, y, options)
end

function TextDisplay:createTextBox(player_id, box_id, text, x, y, width, height, options)
    if type(options) ~= "table" then options = {} end
    options.mode = "typewriter"
    options.width = width
    options.height = height
    return self:draw(player_id, box_id, text, x, y, options)
end

-- Additional helper functions (unchanged except they now look up in player_texts)
function TextDisplay:removeStatic(player_id, text_id)
    local displays = self.player_texts[player_id]
    if displays and displays[text_id] then
        displays[text_id]:close()
        displays[text_id] = nil
    end
end

function TextDisplay:removeMarquee(player_id, marquee_id)
    self:removeStatic(player_id, marquee_id)
end

function TextDisplay:closeTextBox(player_id, box_id)
    self:removeStatic(player_id, box_id)
end

function TextDisplay:advanceTextBox(player_id, box_id)
    local display = self.player_texts[player_id] and self.player_texts[player_id][box_id]
    if display and display.mode == "typewriter" then
        display:advance()
    end
end

function TextDisplay:getTextBoxState(player_id, box_id)
    local display = self.player_texts[player_id] and self.player_texts[player_id][box_id]
    if not display then return "completed" end
    if display.mode == "typewriter" then
        return display.state
    else
        return "completed"   -- for other modes
    end
end

function TextDisplay:getTextBoxData(player_id, box_id)
    local display = self.player_texts[player_id] and self.player_texts[player_id][box_id]
    if not display then return nil end
    -- Return a table compatible with old nameplate expectations
    return {
        x = display.x / 2,   -- convert back to virtual for external use? The nameplate expects virtual? 
        -- Actually nameplate uses box_data.x and y to position itself, and those should be in screen pixels because nameplate does its own layout in screen pixels.
        -- But the nameplate attach function receives box_data.x etc. from this table. In nameplate.lua, we used box_data.x as screen pixels.
        -- So we should return the scaled values (screen pixels) for nameplate to use.
        -- However, nameplate also multiplies by scale and adds gaps based on scale. That's fine.
        -- To keep consistent, we'll return the stored screen pixels (which are the scaled values).
        -- x = display.x,
        y = display.y,
        width = display.width,
        height = display.height,
        scale = display.scale,
        z_order = display.z,
        nameplate = display.nameplate,   -- nameplate may attach this later
        backdrop = nil,
    }
end

-- Initialize singleton
local textDisplay = setmetatable({}, TextDisplay)
textDisplay:init()
return textDisplay