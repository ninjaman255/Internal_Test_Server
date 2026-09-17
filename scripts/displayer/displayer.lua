--[[
displayer.lua – Unified API for all text, timer, and sprite‑based display systems.
Provides a clean interface with consistent options for sprite properties.
Also includes builder functions for constructing option tables.

Sub‑APIs:
  .Font          – Low‑level glyph drawing.
  .Text          – Static text, marquees, text boxes.
  .TimerDisplay  – Timer/countdown displays (visual).
  .Nameplate     – BN‑style nameplates for text boxes.
  .ScrollingText – Vertical scrolling text lists.
  .ScrollingSprite – Grid‑based scrolling sprite lists.
  .Timer         – Timer system (creation, pausing, etc.) – directly from timer‑system.
  .TextPanel     – Sliced‑sprite based panels with automatic text layout.
  .Builder       – Helper functions to create option tables.

Path convention: All texture and animation paths MUST include the "/server/" prefix.
This prefix is stripped only when loading animation data via boom.load.
]]

-- --------------------------------------------------------------------
-- Option table type definitions (for hover documentation)
-- --------------------------------------------------------------------

---@class GlyphOptions
---@field scale? number               # Scale factor (default 2.0)
---@field z? number                   # Z‑order (default 100)
---@field r? integer                  # Red tint 0‑255 (default 255)
---@field g? integer                  # Green tint 0‑255 (default 255)
---@field b? integer                  # Blue tint 0‑255 (default 255)
---@field opacity? integer            # Overall sprite opacity 0‑255 (default 255)
---@field a? integer                  # Alpha for color tint (used with color_mode) 0‑255 (default 255)
---@field ro? number                  # Rotation in degrees
---@field ox? integer                 # Origin X offset (overrides animation origin)
---@field oy? integer                 # Origin Y offset (overrides animation origin)
---@field color_mode? integer         # 0=multiply, 1=additive, 2=colorize
---@field instance_id? string         # If provided, updates that instance instead of creating new

---@class StaticTextOptions
---@field font? string                 # Font name (default "THICK")
---@field scale? number                 # Scale factor (default 2.0)
---@field z? number                     # Z‑order (default 100)
---@field r? integer                    # Global red tint 0‑255
---@field g? integer                    # Global green tint 0‑255
---@field b? integer                    # Global blue tint 0‑255
---@field opacity? integer               # Global overall opacity 0‑255
---@field a? integer                     # Global alpha for color tint 0‑255
---@field ro? number                     # Global rotation in degrees
---@field color_mode? integer             # Global color mode
---@field perChar? fun(charIndex:integer, char:string):table|nil  # Per‑character override callback returning a table with any GlyphOptions fields

---@class MarqueeOptions
---@field font? string                 # Font name (default "THICK")
---@field scale? number                 # Scale factor (default 2.0)
---@field z? number                     # Z‑order (default 100)
---@field speed? number                 # Pixels per second (default 60)
---@field loops? integer|nil             # Number of loops (nil = infinite)
---@field r? integer                    # Red tint 0‑255
---@field g? integer                    # Green tint 0‑255
---@field b? integer                    # Blue tint 0‑255
---@field opacity? integer               # Overall opacity 0‑255
---@field a? integer                     # Alpha for color tint 0‑255
---@field ro? number                     # Rotation in degrees
---@field color_mode? integer             # Color mode
---@field updateChar? fun(text_index:integer, char:string, elapsed:number):table|nil  # Called each frame to get per‑character property updates

---@class TextBoxOptions
---@field font? string                 # Font name (default "THICK")
---@field scale? number                 # Scale factor (default 2.0)
---@field z? number                     # Z‑order (default 100)
---@field speed? number                 # Characters per second (default 30)
---@field type_sound? string             # Path to sound played on each character
---@field type_sound_min_dt? number      # Minimum seconds between sounds (default 0.1)
---@field r? integer                    # Global red tint 0‑255
---@field g? integer                    # Global green tint 0‑255
---@field b? integer                    # Global blue tint 0‑255
---@field opacity? integer               # Global overall opacity 0‑255
---@field a? integer                     # Global alpha for color tint 0‑255
---@field ro? number                     # Global rotation in degrees
---@field color_mode? integer             # Global color mode
---@field perChar? fun(page:integer, line:integer, charIndex:integer, char:string):table|nil  # Per‑character override callback

---@class TimerDisplayOptions
---@field font? string      # Font name (default "THICK")
---@field scale? number      # Scale factor (default 2.0)
---@field z? number          # Z‑order (default 100)
---@field color? {r:integer, g:integer, b:integer}  # Tint color (default white)
---@field opacity? integer   # Overall opacity 0‑255 (default 255)
---@field a? integer         # Alpha for color tint 0‑255 (default 255)
---@field ro? number         # Rotation in degrees
---@field color_mode? integer # Color mode (0=multiply, 1=additive, 2=colorize)

---@class TextListConfig
---@field font? string                   # Font name (default "THICK")
---@field scale? number                   # Scale factor (default 1.0)
---@field z_order? number                 # Z‑order (default 100)
---@field scroll_speed? number             # Pixels per second (default 30)
---@field line_spacing? number             # Pixels between lines (default 15)
---@field entry_delay? number              # Seconds between entries starting (default 1.0)
---@field loop? boolean                    # Whether to loop (default false)
---@field destroy_when_finished? boolean   # Auto‑remove after all entries finish (default true)
---@field destroy_delay? number            # Seconds to wait before auto‑removal (default 1.0)
---@field backdrop? table                  # Optional backdrop definition (x, y, width, height, padding_x, padding_y, etc.)
---@field texts? string[]                  # Initial texts

---@class SpriteListConfig
---@field x? number
---@field y? number
---@field width? number
---@field height? number
---@field z_order? number                  # Z‑order (default 100)
---@field scroll_speed? number              # Pixels per second (default 30)
---@field entry_delay? number               # Seconds between entries starting (default 1.0)
---@field max_columns? integer              # Maximum columns in grid (default 1)
---@field column_spacing? number            # Horizontal spacing between columns (default 5)
---@field row_spacing? number               # Vertical spacing between rows (default 5)
---@field align? "left"|"center"|"right"    # Horizontal alignment (default "left")
---@field backdrop? table                    # Optional backdrop definition
---@field sprites? table[]                    # Array of sprite definitions (each with texture_path, anim_path?, sx?, sy?, anim_state?, r?, g?, b?, opacity?, a?, ro?, color_mode?)

-- --------------------------------------------------------------------
-- Displayer main module
-- --------------------------------------------------------------------
local Displayer = {}
Displayer.__index = Displayer

-- Subsystems (lazily required)
local fontSystem
local textDisplay
local timerDisplay
local nameplateInstance
local scrollingTextList
local scrollingSpriteList
local timerSystem
local slicedSprite

function Displayer:init()
    -- Initialize sub‑API tables
    self.Font            = {}
    self.Text            = {}
    self.TimerDisplay    = {}
    self.Nameplate       = {}
    self.ScrollingText   = {}
    self.ScrollingSprite = {}
    self.Timer           = {}
    self.TextPanel       = {}
    self.Builder         = {} -- will be populated after subsystems are loaded

    -- Load all subsystems
    fontSystem           = require("scripts/displayer/font-system")
    textDisplay          = require("scripts/displayer/text-display")
    timerDisplay         = require("scripts/displayer/timer-display")
    local NameplateClass = require("scripts/displayer/nameplate")
    nameplateInstance    = NameplateClass:new(fontSystem)
    scrollingTextList    = require("scripts/displayer/scrolling-text-list")
    scrollingSpriteList  = require("scripts/displayer/scrolling-sprite-list")
    timerSystem          = require("scripts/displayer/timer-system")
    slicedSprite         = require("scripts/displayer/sliced-sprite")

    -- Set up sub‑APIs
    self:_setupFontAPI()
    self:_setupTextAPI()               -- Text API is now complete
    self:_setupTimerDisplayAPI()

    -- Inject the Text API into the nameplate instance
    if nameplateInstance then
        nameplateInstance:setTextAPI(self.Text)
    end

    self:_setupNameplateAPI()
    self:_setupScrollingTextAPI()
    self:_setupScrollingSpriteAPI()
    self:_setupTimerAPI()
    self:_setupTextPanelAPI()
    self:_setupBuilderAPI()

    Net:on("player_join", function(event)
        local player_id = event.player_id
        fontSystem:allocateAllFontsForPlayer(player_id)
    end)

    return self
end

-- --------------------------------------------------------------------
-- Builder API
-- --------------------------------------------------------------------
function Displayer:_setupBuilderAPI()
    local api = self.Builder
    local boom = require("scripts/boom/main")
    local anim_cache = {}   -- cache loaded animation data

    --- Create GlyphOptions with defaults.
    ---@param overrides? GlyphOptions
    ---@return GlyphOptions
    function api.glyph(overrides)
        local opts = {
            scale = 2.0,
            z = 100,
            r = 255,
            g = 255,
            b = 255,
            opacity = 255,
            a = 255,
            ro = 0,
            color_mode = 0,
        }
        if overrides then
            for k, v in pairs(overrides) do opts[k] = v end
        end
        return opts
    end

    --- Create StaticTextOptions with defaults.
    ---@param overrides? StaticTextOptions
    ---@return StaticTextOptions
    function api.staticText(overrides)
        local opts = {
            font = "THICK",
            scale = 2.0,
            z = 100,
            r = 255,
            g = 255,
            b = 255,
            opacity = 255,
            a = 255,
            ro = 0,
            color_mode = 0,
        }
        if overrides then
            for k, v in pairs(overrides) do opts[k] = v end
        end
        return opts
    end

    --- Create MarqueeOptions with defaults.
    ---@param overrides? MarqueeOptions
    ---@return MarqueeOptions
    function api.marquee(overrides)
        local opts = {
            font = "THICK",
            scale = 2.0,
            z = 100,
            speed = 60,
            loops = nil, -- infinite
            r = 255,
            g = 255,
            b = 255,
            opacity = 255,
            a = 255,
            ro = 0,
            color_mode = 0,
            updateChar = nil,   -- per‑character animation callback
        }
        if overrides then
            for k, v in pairs(overrides) do opts[k] = v end
        end
        return opts
    end

    --- Create TextBoxOptions with defaults.
    ---@param overrides? TextBoxOptions
    ---@return TextBoxOptions
    function api.textBox(overrides)
        local opts = {
            font = "THICK",
            scale = 2.0,
            z = 100,
            speed = 30,
            type_sound = nil,
            type_sound_min_dt = 0.1,
            r = 255,
            g = 255,
            b = 255,
            opacity = 255,
            a = 255,
            ro = 0,
            color_mode = 0,
        }
        if overrides then
            for k, v in pairs(overrides) do opts[k] = v end
        end
        return opts
    end

    --- Create TimerDisplayOptions with defaults.
    ---@param overrides? TimerDisplayOptions
    ---@return TimerDisplayOptions
    function api.timerDisplay(overrides)
        local opts = {
            font = "THICK",
            scale = 2.0,
            z = 100,
            color = { r = 255, g = 255, b = 255 },
            opacity = 255,
            a = 255,
            ro = 0,
            color_mode = 0,
        }
        if overrides then
            for k, v in pairs(overrides) do
                if k == "color" and type(v) == "table" then
                    opts.color = { r = v.r or 255, g = v.g or 255, b = v.b or 255 }
                else
                    opts[k] = v
                end
            end
        end
        return opts
    end

    --- Create TextListConfig with defaults.
    ---@param overrides? TextListConfig
    ---@return TextListConfig
    function api.textList(overrides)
        local opts = {
            font = "THICK",
            scale = 1.0,
            z_order = 100,
            scroll_speed = 30,
            line_spacing = 15,
            entry_delay = 1.0,
            loop = false,
            destroy_when_finished = true,
            destroy_delay = 1.0,
            backdrop = nil,
            texts = {},
        }
        if overrides then
            for k, v in pairs(overrides) do opts[k] = v end
        end
        return opts
    end

    --- Create SpriteListConfig with defaults.
    ---@param overrides? SpriteListConfig
    ---@return SpriteListConfig
    function api.spriteList(overrides)
        local opts = {
            x = 0,
            y = 0,
            width = 200,
            height = 100,
            z_order = 100,
            scroll_speed = 30,
            entry_delay = 1.0,
            max_columns = 1,
            column_spacing = 5,
            row_spacing = 5,
            align = "left",
            backdrop = nil,
            sprites = {},
        }
        if overrides then
            for k, v in pairs(overrides) do opts[k] = v end
        end
        return opts
    end

    --- Create a backdrop table for lists.
    ---@param x number
    ---@param y number
    ---@param width number
    ---@param height number
    ---@param padding_x? number
    ---@param padding_y? number
    ---@param r? integer
    ---@param g? integer
    ---@param b? integer
    ---@param opacity? integer
    ---@param a? integer
    ---@return table
    function api.backdrop(x, y, width, height, padding_x, padding_y, r, g, b, opacity, a)
        return {
            x = x,
            y = y,
            width = width,
            height = height,
            padding_x = padding_x or 8,
            padding_y = padding_y or 6,
            r = r or 0,
            g = g or 0,
            b = b or 0,
            opacity = opacity or 200,
            a = a or 255,
        }
    end

    --- Create a sprite definition for scrolling sprite lists.
    ---@param texture_path string   # Full path with "/server/" prefix
    ---@param anim_path? string     # Full path with "/server/" prefix (optional)
    ---@param anim_state? string    # Initial animation state (optional, auto‑detected if anim_path provided)
    ---@param overrides? table       # optional fields:
    ---   - sx, sy: number (scale factors, default 2)
    ---   - width, height: number (base dimensions, auto‑detected from animation if anim_path provided)
    ---   - r, g, b: integer (tint, default 255)
    ---   - opacity: integer (overall opacity, default 255)
    ---   - a: integer (alpha for color_mode, default 255)
    ---   - ro: number (rotation degrees, default 0)
    ---   - color_mode: integer (0=multiply,1=additive,2=colorize)
    ---@return table
    function api.spriteDef(texture_path, anim_path, anim_state, overrides)
        -- Normalize arguments: allow anim_path to be optional
        if type(anim_path) == "table" then
            overrides = anim_path
            anim_path = nil
            anim_state = nil
        elseif type(anim_state) == "table" then
            overrides = anim_state
            anim_state = nil
        end
        overrides = overrides or {}

        local def = {
            texture_path = texture_path,
            anim_path = anim_path or "",
            anim_state = anim_state or "",
            ox = 0,
            oy = 0,
            sx = 2,
            sy = 2,
            width = 16,
            height = 16,
            r = 255,
            g = 255,
            b = 255,
            opacity = 255,
            a = 255,
            ro = 0,
            color_mode = 0,
        }

        -- If animation path provided, load it to extract dimensions and first state
        if anim_path and anim_path ~= "" then
            -- Strip "/server/" prefix for boom.load
            local boom_path = anim_path:gsub("^/server/", "")
            local anim_data = anim_cache[anim_path]
            if not anim_data then
                anim_data = boom.load(boom_path)
                if anim_data then
                    anim_cache[anim_path] = anim_data
                else
                    print("ERROR: Could not load animation: " .. tostring(anim_path))
                end
            end

            if anim_data and anim_data.states then
                -- Find a valid state to use as default for dimensions
                local first_state = nil
                for state_name, state_data in pairs(anim_data.states) do
                    if not first_state then first_state = state_name end
                    if state_name == def.anim_state then
                        -- Exact match, use it
                        first_state = state_name
                        break
                    end
                end
                if first_state then
                    if def.anim_state == "" then
                        def.anim_state = first_state
                    end
                    -- Get dimensions from the first frame of that state
                    local state_data = anim_data.states[first_state]
                    if state_data and state_data.framelist and #state_data.framelist > 0 then
                        local frame = state_data.framelist[1]
                        if frame then
                            def.width = frame.w or 16
                            def.height = frame.h or 16
                        end
                    end
                end
            end
        end

        -- Apply overrides (they will overwrite any extracted values)
        for k, v in pairs(overrides) do
            def[k] = v
        end

        return def
    end

    --- Create options for unified text drawing.
    ---@param mode "static"|"marquee"|"typewriter"
    ---@param overrides? table   # Overrides for the chosen mode
    ---@return table
    function api.text(mode, overrides)
        local base = {
            mode = mode,
            font = "THICK",
            scale = 2.0,
            z = 100,
            r = 255, g = 255, b = 255,
            opacity = 255, a = 255,
            ro = 0, color_mode = 0,
            halign = "left", valign = "top",
            width = nil, height = nil,
            perChar = nil,
        }
        if overrides then
            for k, v in pairs(overrides) do base[k] = v end
        end
        -- Mode‑specific defaults
        if mode == "marquee" then
            base.marquee = base.marquee or { speed = 60, loops = nil }
        elseif mode == "typewriter" then
            base.typewriter = base.typewriter or { speed = 30, sound = nil, sound_min_dt = 0.1 }
        end
        return base
    end

    --- Build a style table for text panels (3/5/9‑slice).
    ---@param kind "3"|"5"|"9"
    ---@param parts table   # slice parts definition
    ---@param orientation? "horizontal"|"vertical"  # default "horizontal"
    ---@return table
    function api.textPanelStyle(kind, parts, orientation)
        return {
            kind = kind or "9",
            orientation = orientation or "horizontal",
            parts = parts,
        }
    end

    --- Build options for text panels.
    ---@param overrides? table  # see TextPanel options
    ---@return table
    function api.textPanelOptions(overrides)
        local opts = {
            font = "THICK",
            scale = 2.0,
            color = { r = 255, g = 255, b = 255, a = 255 },
            halign = "left",
            valign = "top",
            line_spacing = 0,
            padding = 8,
            auto_size = true,
            width = nil,
            height = nil,
            max_width = nil,
            max_height = nil,
            z = 100,
            slice_scale = 1.0,
            slice_options = {},
            overflow = "wrap",  -- "wrap", "clip", "ellipsis"
        }
        if overrides then
            for k, v in pairs(overrides) do
                if k == "padding" and type(v) == "number" then
                    opts.padding = { left = v, right = v, top = v, bottom = v }
                elseif k == "color" and type(v) == "table" then
                    opts.color = { r = v.r or 255, g = v.g or 255, b = v.b or 255, a = v.a or 255 }
                else
                    opts[k] = v
                end
            end
        end
        -- Ensure padding is a table
        if type(opts.padding) == "number" then
            opts.padding = { left = opts.padding, right = opts.padding, top = opts.padding, bottom = opts.padding }
        end
        return opts
    end

    --- Combine text, style, and options into a single config for TextPanel.create.
    ---@param text string|string[]
    ---@param style table   # from textPanelStyle
    ---@param options table # from textPanelOptions
    ---@return table
    function api.textPanel(text, style, options)
        return {
            text = text,
            style = style,
            options = options or {},
        }
    end
end

-- --------------------------------------------------------------------
-- Font API
-- --------------------------------------------------------------------
function Displayer:_setupFontAPI()
    local api = self.Font

    --- Draw a single glyph.
    ---@param player_id string
    ---@param font_name string
    ---@param char string
    ---@param x number
    ---@param y number
    ---@param options? GlyphOptions
    ---@return string|nil instance_id
    api.drawGlyph = function(player_id, font_name, char, x, y, options)
        return fontSystem:drawGlyph(player_id, font_name, char, x, y, options)
    end

    --- Update an existing glyph's properties.
    ---@param player_id string
    ---@param instance_id string
    ---@param updates GlyphOptions
    api.updateGlyph = function(player_id, instance_id, updates)
        fontSystem:updateGlyph(player_id, instance_id, updates)
    end

    --- Erase a glyph instance.
    ---@param player_id string
    ---@param instance_id string
    api.eraseGlyph = function(player_id, instance_id)
        fontSystem:eraseGlyph(player_id, instance_id)
    end

    --- Get glyph dimensions (width, height) at scale 1.
    ---@param font_name string
    ---@param char string
    ---@return number width, number height
    api.getGlyphDimensions = function(font_name, char)
        return fontSystem:getGlyphDimensions(font_name, char)
    end

    api.allocateAllFontsForPlayer = function (player_id)
        return fontSystem:allocateAllFontsForPlayer(player_id);
    end
end

-- --------------------------------------------------------------------
-- Text API (unified)
-- --------------------------------------------------------------------
function Displayer:_setupTextAPI()
    local api = self.Text

    --- Unified text drawing with modes.
    ---@param player_id string
    ---@param text_id string
    ---@param text string
    ---@param x number
    ---@param y number
    ---@param options? table   # See documentation for modes and options
    ---@return string text_id
    api.draw = function(player_id, text_id, text, x, y, options)
        return textDisplay:draw(player_id, text_id, text, x, y, options)
    end

    --- Draw static text (all characters appear immediately). (Legacy wrapper)
    api.drawStatic = function(player_id, text_id, text, x, y, options)
        return textDisplay:drawStatic(player_id, text_id, text, x, y, options)
    end

    --- Remove static text. (Legacy wrapper)
    api.removeStatic = function(player_id, text_id)
        textDisplay:removeStatic(player_id, text_id)
    end

    --- Draw a marquee (scrolling text). (Legacy wrapper)
    api.drawMarquee = function(player_id, marquee_id, text, y, options)
        return textDisplay:drawMarquee(player_id, marquee_id, text, y, options)
    end

    --- Remove a marquee. (Legacy wrapper)
    api.removeMarquee = function(player_id, marquee_id)
        textDisplay:removeMarquee(player_id, marquee_id)
    end

    --- Create a text box with character‑by‑character reveal. (Legacy wrapper)
    api.createTextBox = function(player_id, box_id, text, x, y, width, height, options)
        return textDisplay:createTextBox(player_id, box_id, text, x, y, width, height, options)
    end

    --- Advance to the next page immediately (skip remaining characters). (Legacy wrapper)
    api.advanceTextBox = function(player_id, box_id)
        textDisplay:advanceTextBox(player_id, box_id)
    end

    --- Close a text box (erase all glyphs). (Legacy wrapper)
    api.closeTextBox = function(player_id, box_id)
        textDisplay:closeTextBox(player_id, box_id)
    end

    --- Get the current state of a text box. (Legacy wrapper)
    api.getTextBoxState = function(player_id, box_id)
        return textDisplay:getTextBoxState(player_id, box_id)
    end

    --- Get the internal data table of a text box (for advanced manipulation). (Legacy wrapper)
    api.getTextBoxData = function(player_id, box_id)
        return textDisplay:getTextBoxData(player_id, box_id)
    end

    --- Set whether a text box should stay alive (prevent auto‑removal). Used by nameplates.
    ---@param player_id string
    ---@param box_id string
    ---@param keep boolean
    api.setKeepAlive = function(player_id, box_id, keep)
        textDisplay:setKeepAlive(player_id, box_id, keep)
    end
end

-- --------------------------------------------------------------------
-- Timer Display API
-- --------------------------------------------------------------------
function Displayer:_setupTimerDisplayAPI()
    local api = self.TimerDisplay

    --- Create a display for a player‑specific timer.
    ---@param player_id string
    ---@param display_id string
    ---@param x number
    ---@param y number
    ---@param options? TimerDisplayOptions
    api.createPlayerTimer = function(player_id, display_id, x, y, options)
        timerDisplay:createPlayerTimerDisplay(player_id, display_id, x, y, options)
    end

    --- Create a display for a player‑specific countdown.
    ---@param player_id string
    ---@param display_id string
    ---@param x number
    ---@param y number
    ---@param options? TimerDisplayOptions
    api.createPlayerCountdown = function(player_id, display_id, x, y, options)
        timerDisplay:createPlayerCountdownDisplay(player_id, display_id, x, y, options)
    end

    --- Create a global timer display (shown to all players).
    ---@param display_id string
    ---@param x number
    ---@param y number
    ---@param options? TimerDisplayOptions
    api.createGlobalTimer = function(display_id, x, y, options)
        timerDisplay:createGlobalTimerDisplay(display_id, x, y, options)
    end

    --- Create a global countdown display.
    ---@param display_id string
    ---@param x number
    ---@param y number
    ---@param options? TimerDisplayOptions
    api.createGlobalCountdown = function(display_id, x, y, options)
        timerDisplay:createGlobalCountdownDisplay(display_id, x, y, options)
    end

    --- Remove a timer/countdown display.
    ---@param player_id string
    ---@param display_id string
    api.remove = function(player_id, display_id)
        timerDisplay:removeDisplay(player_id, display_id)
    end

    --- Set the position of an existing display.
    ---@param player_id string
    ---@param display_id string
    ---@param x number
    ---@param y number
    api.setPosition = function(player_id, display_id, x, y)
        timerDisplay:setDisplayPosition(player_id, display_id, x, y)
    end
end

-- --------------------------------------------------------------------
-- Nameplate API (attached to text boxes)
-- --------------------------------------------------------------------
function Displayer:_setupNameplateAPI()
    local api = self.Nameplate

    --- Attach a nameplate to a text box.
    ---@param player_id string
    ---@param player_data table   # (unused, kept for compatibility)
    ---@param box_id string
    ---@param box_data table      # The text box data (from createTextBox)
    ---@param cfg string|table    # Either the name string, or a table with fields
    api.attach = function(player_id, player_data, box_id, box_data, cfg)
        nameplateInstance:attach(player_id, player_data, box_id, box_data, cfg)
    end

    --- Erase a nameplate (remove all its sprite instances).
    ---@param player_id string
    ---@param player_data table
    ---@param box_data table
    api.erase = function(player_id, player_data, box_data)
        nameplateInstance:erase(player_id, player_data, box_data)
    end

    --- Begin the closing animation (reverse unfold).
    ---@param player_id string
    ---@param player_data table
    ---@param box_data table
    ---@param cfg? table   # Optional overrides (close_dur)
    api.begin_close = function(player_id, player_data, box_data, cfg)
        nameplateInstance:begin_close(player_id, player_data, box_data, cfg)
    end
end

-- --------------------------------------------------------------------
-- Scrolling Text List API
-- --------------------------------------------------------------------
function Displayer:_setupScrollingTextAPI()
    local api = self.ScrollingText

    --- Create a new scrolling text list.
    ---@param player_id string
    ---@param list_id string
    ---@param x number
    ---@param y number
    ---@param width number
    ---@param height number
    ---@param config? TextListConfig
    ---@return table|nil list_object   # Returns a list object with methods
    api.createList = function(player_id, list_id, x, y, width, height, config)
        return scrollingTextList:createScrollingList(player_id, list_id, x, y, width, height, config)
    end

    --- Add a text entry to an existing list.
    ---@param player_id string
    ---@param list_id string
    ---@param text string
    ---@return boolean
    api.addText = function(player_id, list_id, text)
        return scrollingTextList:addTextToList(player_id, list_id, text)
    end

    --- Replace all texts in the list.
    ---@param player_id string
    ---@param list_id string
    ---@param texts string[]
    ---@return boolean
    api.setTexts = function(player_id, list_id, texts)
        return scrollingTextList:setListTexts(player_id, list_id, texts)
    end

    --- Get the current state of a scrolling text list.
    ---@param player_id string
    ---@param list_id string
    ---@return table|nil
    api.getState = function(player_id, list_id)
        return scrollingTextList:getListState(player_id, list_id)
    end

    --- Set the scroll speed of a list.
    ---@param player_id string
    ---@param list_id string
    ---@param speed number
    ---@return boolean
    api.setSpeed = function(player_id, list_id, speed)
        return scrollingTextList:setListSpeed(player_id, list_id, speed)
    end

    --- Remove a scrolling text list.
    ---@param player_id string
    ---@param list_id string
    api.removeList = function(player_id, list_id)
        scrollingTextList:removeScrollingList(player_id, list_id)
    end

    --- Set the position of an existing list.
    ---@param player_id string
    ---@param list_id string
    ---@param x number
    ---@param y number
    ---@return boolean
    api.setPosition = function(player_id, list_id, x, y)
        return scrollingTextList:setListPosition(player_id, list_id, x, y)
    end
end

-- --------------------------------------------------------------------
-- Scrolling Sprite List API
-- --------------------------------------------------------------------
function Displayer:_setupScrollingSpriteAPI()
    local api = self.ScrollingSprite

    --- Create a new scrolling sprite list.
    ---@param player_id string
    ---@param list_id string
    ---@param x number
    ---@param y number
    ---@param width number
    ---@param height number
    ---@param config? SpriteListConfig
    ---@return table|nil list_object   # Returns a list object with methods
    api.createList = function(player_id, list_id, x, y, width, height, config)
        return scrollingSpriteList:createScrollingList(player_id, list_id, x, y, width, height, config)
    end

    --- Add a sprite definition to an existing list.
    ---@param player_id string
    ---@param list_id string
    ---@param sprite_def table
    ---@return boolean
    api.addSprite = function(player_id, list_id, sprite_def)
        return scrollingSpriteList:addSpriteToList(player_id, list_id, sprite_def)
    end

    --- Replace all sprites in the list.
    ---@param player_id string
    ---@param list_id string
    ---@param sprites table[]
    ---@return boolean
    api.setSprites = function(player_id, list_id, sprites)
        return scrollingSpriteList:setListSprites(player_id, list_id, sprites)
    end

    --- Get the current state of a scrolling sprite list.
    ---@param player_id string
    ---@param list_id string
    ---@return table|nil
    api.getState = function(player_id, list_id)
        return scrollingSpriteList:getListState(player_id, list_id)
    end

    --- Set the scroll speed of a list.
    ---@param player_id string
    ---@param list_id string
    ---@param speed number
    ---@return boolean
    api.setSpeed = function(player_id, list_id, speed)
        return scrollingSpriteList:setListSpeed(player_id, list_id, speed)
    end

    --- Remove a scrolling sprite list.
    ---@param player_id string
    ---@param list_id string
    api.removeList = function(player_id, list_id)
        scrollingSpriteList:removeScrollingList(player_id, list_id)
    end

    --- Set the position of an existing list.
    ---@param player_id string
    ---@param list_id string
    ---@param x number
    ---@param y number
    ---@return boolean
    api.setPosition = function(player_id, list_id, x, y)
        return scrollingSpriteList:setListPosition(player_id, list_id, x, y)
    end
end

-- --------------------------------------------------------------------
-- Timer System API (direct passthrough from timer-system.lua)
-- --------------------------------------------------------------------
function Displayer:_setupTimerAPI()
    local api = self.Timer

    -- Player timers
    api.createPlayerTimer = function(player_id, timer_id, duration, callback, loop)
        return timerSystem:createPlayerTimer(player_id, timer_id, duration, callback, loop)
    end
    api.createPlayerCountdown = function(player_id, countdown_id, duration, callback, loop)
        return timerSystem:createPlayerCountdown(player_id, countdown_id, duration, callback, loop)
    end
    api.pausePlayerTimer = function(player_id, timer_id)
        return timerSystem:pausePlayerTimer(player_id, timer_id)
    end
    api.resumePlayerTimer = function(player_id, timer_id)
        return timerSystem:resumePlayerTimer(player_id, timer_id)
    end
    api.pausePlayerCountdown = function(player_id, countdown_id)
        return timerSystem:pausePlayerCountdown(player_id, countdown_id)
    end
    api.resumePlayerCountdown = function(player_id, countdown_id)
        return timerSystem:resumePlayerCountdown(player_id, countdown_id)
    end
    api.removePlayerTimer = function(player_id, timer_id)
        return timerSystem:removePlayerTimer(player_id, timer_id)
    end
    api.removePlayerCountdown = function(player_id, countdown_id)
        return timerSystem:removePlayerCountdown(player_id, countdown_id)
    end
    api.getPlayerTimer = function(player_id, timer_id)
        return timerSystem:getPlayerTimer(player_id, timer_id)
    end
    api.getPlayerCountdown = function(player_id, countdown_id)
        return timerSystem:getPlayerCountdown(player_id, countdown_id)
    end

    -- Global timers
    api.createGlobalTimer = function(timer_id, duration, callback, loop)
        return timerSystem:createGlobalTimer(timer_id, duration, callback, loop)
    end
    api.createGlobalCountdown = function(countdown_id, duration, callback, loop)
        return timerSystem:createGlobalCountdown(countdown_id, duration, callback, loop)
    end
    api.pauseGlobalTimer = function(timer_id)
        return timerSystem:pauseGlobalTimer(timer_id)
    end
    api.resumeGlobalTimer = function(timer_id)
        return timerSystem:resumeGlobalTimer(timer_id)
    end
    api.pauseGlobalCountdown = function(countdown_id)
        return timerSystem:pauseGlobalCountdown(countdown_id)
    end
    api.resumeGlobalCountdown = function(countdown_id)
        return timerSystem:resumeGlobalCountdown(countdown_id)
    end
    api.removeGlobalTimer = function(timer_id)
        return timerSystem:removeGlobalTimer(timer_id)
    end
    api.removeGlobalCountdown = function(countdown_id)
        return timerSystem:removeGlobalCountdown(countdown_id)
    end
    api.getGlobalTimer = function(timer_id)
        return timerSystem:getGlobalTimer(timer_id)
    end
    api.getGlobalCountdown = function(countdown_id)
        return timerSystem:getGlobalCountdown(countdown_id)
    end
    api.getAllGlobalTimers = function()
        return timerSystem:getAllGlobalTimers()
    end
    api.getAllGlobalCountdowns = function()
        return timerSystem:getAllGlobalCountdowns()
    end
    api.clearAllGlobalTimers = function()
        return timerSystem:clearAllGlobalTimers()
    end
    api.clearAllGlobalCountdowns = function()
        return timerSystem:clearAllGlobalCountdowns()
    end
end

-- --------------------------------------------------------------------
-- Text Panel API (sliced sprite + text)
-- --------------------------------------------------------------------
function Displayer:_setupTextPanelAPI()
    local api = self.TextPanel
    -- Store panels for management
    self._text_panels = self._text_panels or {}  -- player_id -> { panel_id = panel_object }

    --- Create a text panel.
    ---@param player_id string
    ---@param panel_id string
    ---@param text string|string[]
    ---@param x number
    ---@param y number
    ---@param style table   # from Builder.textPanelStyle
    ---@param options table # from Builder.textPanelOptions
    ---@return table|nil panel_object, string|nil error
    api.create = function(player_id, panel_id, text, x, y, style, options)
        if not self._text_panels[player_id] then
            self._text_panels[player_id] = {}
        end
        -- If panel with same ID exists, destroy it first
        if self._text_panels[player_id][panel_id] then
            self._text_panels[player_id][panel_id]:destroy()
        end
        local panel, err = slicedSprite.drawTextPanel(player_id, panel_id, x, y, text, style, options)
        if panel then
            self._text_panels[player_id][panel_id] = panel
        end
        return panel, err
    end

    --- Update the text of an existing panel.
    ---@param player_id string
    ---@param panel_id string
    ---@param newText string|string[]
    ---@return boolean success
    api.updateText = function(player_id, panel_id, newText)
        local panel = self._text_panels[player_id] and self._text_panels[player_id][panel_id]
        if not panel then return false end
        panel:setText(newText)
        return true
    end

    --- Move a panel.
    ---@param player_id string
    ---@param panel_id string
    ---@param x number
    ---@param y number
    ---@return boolean
    api.setPosition = function(player_id, panel_id, x, y)
        local panel = self._text_panels[player_id] and self._text_panels[player_id][panel_id]
        if not panel then return false end
        panel:setPosition(x, y)
        return true
    end

    --- Update panel options (style and/or options).
    ---@param player_id string
    ---@param panel_id string
    ---@param newOptions table
    ---@return boolean
    api.setOptions = function(player_id, panel_id, newOptions)
        local panel = self._text_panels[player_id] and self._text_panels[player_id][panel_id]
        if not panel then return false end
        panel:setOptions(newOptions)
        return true
    end

    --- Remove/destroy a panel.
    ---@param player_id string
    ---@param panel_id string
    api.remove = function(player_id, panel_id)
        local panel = self._text_panels[player_id] and self._text_panels[player_id][panel_id]
        if panel then
            panel:destroy()
            self._text_panels[player_id][panel_id] = nil
        end
    end

    --- Get a panel object (advanced use).
    ---@param player_id string
    ---@param panel_id string
    ---@return table|nil
    api.get = function(player_id, panel_id)
        return self._text_panels[player_id] and self._text_panels[player_id][panel_id]
    end

    -- Cleanup on player disconnect
    Net:on("player_disconnect", function(event)
        local player_id = event.player_id
        if self._text_panels and self._text_panels[player_id] then
            for panel_id, panel in pairs(self._text_panels[player_id]) do
                panel:destroy()
            end
            self._text_panels[player_id] = nil
        end
    end)
end

-- --------------------------------------------------------------------
-- Utility
-- --------------------------------------------------------------------
--- Format seconds into a time string.
---@param seconds number
---@param is_countdown boolean
---@return string
function Displayer:formatTime(seconds, is_countdown)
    if is_countdown then
        local mins = math.floor(seconds / 60)
        local secs = math.floor(seconds % 60)
        return string.format("%02d:%02d", mins, secs)
    else
        local hours = math.floor(seconds / 3600)
        local mins = math.floor((seconds % 3600) / 60)
        local secs = math.floor(seconds % 60)
        return string.format("%02d:%02d:%02d", hours, mins, secs)
    end
end

--- Get the screen dimensions used by the Net API (480×320).
---@return number width, number height
function Displayer:getScreenDimensions()
    return 480, 320
end

-- Singleton instance
local displayer = setmetatable({}, Displayer)
displayer:init()
return displayer