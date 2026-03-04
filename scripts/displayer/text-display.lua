--[[
text-display.lua – Unified text rendering with static, marquee, and typewriter modes.
Uses AnimationEngine for marquee looping and typewriter delays.
]]

local TextDisplay = {}
TextDisplay.__index = TextDisplay

local fontSystem = require("scripts/displayer/font-system")
local AnimationEngine = require("scripts/animation-engine/animation-engine")

-- Helper: normalize loops option
local function _normalize_loops(v)
    if v == nil or v == true then return nil end
    if v == false or v == "once" then return 1 end
    local n = tonumber(v)
    if n then
        n = math.floor(n)
        if n < 1 then return 1 end
        return n
    end
    return nil
end

-- Word wrapping utility (screen pixels)
local function wrapText(text, font_name, scale, max_width)
    if not max_width then return { text } end
    local lines = {}
    local words = {}
    for word in text:gmatch("%S+") do table.insert(words, word) end

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
    if current_line ~= "" then table.insert(lines, current_line) end
    return lines
end

-- Layout: compute per‑glyph positions (screen pixels)
local function layoutText(text, font, scale, box_x, box_y, box_width, box_height, halign, valign)
    local lines = wrapText(text, font, scale, box_width)
    local line_height = 12 * scale

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

    local glyph_grid = {}
    local flat_glyphs = {}
    for line_idx, line in ipairs(lines) do
        glyph_grid[line_idx] = {}
        local x = start_x
        local y = start_y + (line_idx - 1) * line_height
        for col = 1, #line do
            local ch = line:sub(col, col)
            if ch ~= " " then
                local glyph = { char = ch, x = x, y = y, line = line_idx, col = col }
                glyph_grid[line_idx][col] = glyph
                table.insert(flat_glyphs, glyph)
            else
                glyph_grid[line_idx][col] = nil
            end
            local w, _ = fontSystem:getGlyphDimensions(font, ch)
            x = x + w * scale + 1 * scale
        end
    end

    return lines, flat_glyphs, glyph_grid, total_width, total_height
end

-- --------------------------------------------------------------------
-- TextDisplayInstance (unified)
-- --------------------------------------------------------------------
local TextDisplayInstance = {}
TextDisplayInstance.__index = TextDisplayInstance

function TextDisplayInstance:new(player_id, text_id, text, x, y, options)
    local o = setmetatable({}, TextDisplayInstance)
    o.player_id = player_id
    o.text_id = text_id
    o.text = text

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
    o.perChar = options.perChar

    o.mode = options.mode or "static"
    o.state = "active"
    o.anim_id = nil          -- for marquee animation
    o.next_char_delay = nil   -- for typewriter scheduling

    -- Flag to prevent auto-removal while nameplate is attached
    o.keep_alive = false

    -- Mode‑specific setup
    if o.mode == "marquee" then
        local loops_raw = (options.marquee and options.marquee.loops) or options.loops
        o.loops = _normalize_loops(loops_raw)
        o.speed = (options.marquee and options.marquee.speed) or options.speed or 60
    elseif o.mode == "typewriter" then
        local tw = options.typewriter or {}
        o.speed = tw.speed or options.speed or 30
        o.char_delay = 1.0 / o.speed
        o.sound = tw.sound or options.type_sound
        o.sound_min_dt = tw.sound_min_dt or options.type_sound_min_dt or 0.1
        o.current_page = 1
        o.current_line = 1
        o.current_char = 0
        o.printed_glyphs = {}
        o._last_sound = 0
    end

    o:relayout()

    -- Start appropriate animation
    if o.mode == "marquee" then
        o:_startMarquee()
    elseif o.mode == "typewriter" then
        o:_scheduleNextChar(0)   -- print first character immediately
    else
        o:_drawAllGlyphs()       -- static mode
    end

    return o
end

function TextDisplayInstance:relayout()
    self.lines, self.flat_glyphs, self.glyph_grid, self.total_width, self.total_height =
        layoutText(self.text, self.font, self.scale,
                   self.x, self.y, self.width, self.height,
                   self.halign, self.valign)
end

-- Draw all glyphs with optional overrides (used by marquee)
function TextDisplayInstance:_drawAllGlyphs(overrides)
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
        if self.perChar then
            local over = self.perChar(i, glyph.char, { elapsed = overrides.elapsed })
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
            local update_opts = {}
            for k, v in pairs(opts) do update_opts[k] = v end
            update_opts.x = opts.x / 2
            update_opts.y = opts.y / 2
            fontSystem:updateGlyph(self.player_id, inst_id, update_opts)
        end
    end
end

-- Marquee: start a looping animation of a progress variable
function TextDisplayInstance:_startMarquee()
    local distance = 2 * self.total_width   -- from off right to off left
    local duration = distance / self.speed

    self.anim_id = AnimationEngine.animate(
        { progress = 0 },
        { progress = 1 },
        duration,
        {
            easing = "linear",
            loop = self.loops,   -- nil = infinite
            on_update = function(values)
                local scroll_x = self.x + self.total_width - values.progress * distance
                self:_drawAllGlyphs({ x_offset = scroll_x, elapsed = values.progress * duration })
            end,
            on_complete = function()
                self.state = "completed"
            end,
        }
    )
end

-- Typewriter: print next character, schedule next if any
function TextDisplayInstance:_printNextChar()
    if self.state ~= "active" then return false end

    local line = self.lines[self.current_line]
    if not line then
        self.state = "completed"
        return false
    end

    self.current_char = self.current_char + 1
    if self.current_char > #line then
        self.current_line = self.current_line + 1
        self.current_char = 0
        if self.current_line > #self.lines then
            self.state = "completed"
            return false
        end
        -- Move to next line, next char will be printed after delay
        self:_scheduleNextChar(self.char_delay)
        return true
    end

    local ch = line:sub(self.current_char, self.current_char)
    if ch == " " then
        -- Space: no glyph, but still count as a character for timing
        self:_scheduleNextChar(self.char_delay)
        return true
    end

    -- Get glyph data
    local glyph = self.glyph_grid[self.current_line][self.current_char]
    if not glyph then
        -- Should not happen
        self:_scheduleNextChar(self.char_delay)
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
        local flat_idx = nil
        for idx, g in ipairs(self.flat_glyphs) do
            if g == glyph then flat_idx = idx; break end
        end
        local over = self.perChar(flat_idx or 0, ch, { page = 1, line = self.current_line, isNew = true })
        if over then
            for k, v in pairs(over) do opts[k] = v end
        end
    end

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

    -- Schedule next character
    self:_scheduleNextChar(self.char_delay)
    return true
end

function TextDisplayInstance:_scheduleNextChar(delay)
    if self.next_char_delay then
        -- Cancel previously scheduled (should not happen, but safety)
        -- AnimationEngine doesn't provide cancellation of delays easily, so we rely on state check.
    end
    if self.state ~= "active" then return end
    self.next_char_delay = AnimationEngine.delay(delay, function()
        self.next_char_delay = nil
        if self.state == "active" then
            self:_printNextChar()
        end
    end)
end

-- Advance typewriter (skip to end of page)
function TextDisplayInstance:advance()
    if self.mode ~= "typewriter" then return end
    -- Cancel any pending delay
    if self.next_char_delay then
        -- AnimationEngine doesn't expose cancel; we rely on state to ignore.
        self.next_char_delay = nil
    end
    -- Erase all printed glyphs
    for _, id in ipairs(self.printed_glyphs) do
        fontSystem:eraseGlyph(self.player_id, id)
    end
    self.printed_glyphs = {}
    -- Move to next page (just one page for now)
    self.current_page = self.current_page + 1
    if self.current_page > 1 then
        self.state = "completed"
    else
        self.current_line = 1
        self.current_char = 0
        self:_scheduleNextChar(0)   -- start printing again
    end
end

-- Close/remove all glyphs
function TextDisplayInstance:close()
    -- Stop animations
    if self.anim_id then
        AnimationEngine.stop_animation(self.anim_id)
        self.anim_id = nil
    end
    -- Cancel pending delay
    self.next_char_delay = nil   -- cannot cancel, but state will prevent further prints

    -- Erase all glyphs
    for _, glyph in ipairs(self.flat_glyphs) do
        if glyph.instance_id then
            fontSystem:eraseGlyph(self.player_id, glyph.instance_id)
            glyph.instance_id = nil
        end
    end
    for line_idx, line in ipairs(self.glyph_grid or {}) do
        for col, glyph in pairs(line) do
            glyph.instance_id = nil
        end
    end
    self.printed_glyphs = {}
    self.state = "completed"
end

-- No per‑frame update needed; animations drive everything.
function TextDisplayInstance:update(dt)
    -- kept for compatibility, but does nothing
end

-- --------------------------------------------------------------------
-- TextDisplay main API
-- --------------------------------------------------------------------
function TextDisplay:init()
    self.font_system = fontSystem
    self.player_texts = {}

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
            -- Only auto-remove completed displays that do not have keep_alive flag
            if display.state == "completed" and not display.keep_alive then
                print("Auto-removing completed display", text_id)
                display:close()
                displays[text_id] = nil
            end
        end
    end
end

-- Unified draw
function TextDisplay:draw(player_id, text_id, text, x, y, options)
    options = options or {}
    self.player_texts[player_id] = self.player_texts[player_id] or {}

    if self.player_texts[player_id][text_id] then
        self.player_texts[player_id][text_id]:close()
    end

    local display = TextDisplayInstance:new(player_id, text_id, text, x, y, options)
    self.player_texts[player_id][text_id] = display
    return text_id
end

-- Legacy wrappers
function TextDisplay:drawStatic(player_id, text_id, text, x, y, options)
    if type(options) ~= "table" then options = {} end
    options.mode = "static"
    return self:draw(player_id, text_id, text, x, y, options)
end

function TextDisplay:drawMarquee(player_id, marquee_id, text, y, options)
    if type(options) ~= "table" then options = {} end
    options.mode = "marquee"
    return self:draw(player_id, marquee_id, text, 0, y, options)
end

function TextDisplay:createTextBox(player_id, box_id, text, x, y, width, height, options)
    if type(options) ~= "table" then options = {} end
    options.mode = "typewriter"
    options.width = width
    options.height = height
    return self:draw(player_id, box_id, text, x, y, options)
end

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
        return "completed"
    end
end

function TextDisplay:getTextBoxData(player_id, box_id)
    local display = self.player_texts[player_id] and self.player_texts[player_id][box_id]
    if not display then
        print("getTextBoxData: no display for box_id", box_id)
        return nil
    end
    print("getTextBoxData returning for box_id", box_id, "_box_id =", box_id)
    return {
        x = display.x,
        y = display.y,
        width = display.width,
        height = display.height,
        scale = display.scale,
        z_order = display.z,
        nameplate = display.nameplate,
        backdrop = nil,
        _box_id = box_id,
    }
end

-- New methods for nameplate integration
function TextDisplay:setKeepAlive(player_id, box_id, keep)
    local display = self.player_texts[player_id] and self.player_texts[player_id][box_id]
    if display then
        display.keep_alive = keep
        print("setKeepAlive for box", box_id, "to", keep)
    end
end

local textDisplay = setmetatable({}, TextDisplay)
textDisplay:init()
return textDisplay