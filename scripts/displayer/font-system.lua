--[[
font-system.lua – Unified font rendering with per‑player sprite asset management.
Uses boom to load animation data.
Each font has its own texture and animation file.
]]

local FontSystem = {}
FontSystem.__index = FontSystem

-- Load boom for parsing .animation files
local boom = require("scripts/boom/main")

-- --------------------------------------------------------------------
-- Global font definitions (paths and prefixes)
-- texture_path: absolute (with /server/) for client asset provisioning
-- anim_path:    relative (no leading slash) for server-side boom.load
-- --------------------------------------------------------------------
---@type table<string, {texture_path:string, anim_path:string, prefix:string}>
local FONTS = {
    -- Light variants (compressed sheet)
    THICK = {
        texture_path = "/server/assets/net-games/fonts/fonts_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_thick.animation",
        prefix = "THICK"
    },
    THIN = {
        texture_path = "/server/assets/net-games/fonts/fonts_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_thin.animation",
        prefix = "THIN"
    },
    WIDE = {
        texture_path = "/server/assets/net-games/fonts/fonts_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_wide.animation",
        prefix = "WIDE"
    },
    TINY = {
        texture_path = "/server/assets/net-games/fonts/fonts_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_tiny.animation",
        prefix = "TINY"
    },
    BATTLE = {
        texture_path = "/server/assets/net-games/fonts/fonts_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_battle.animation",
        prefix = "BATTLE"
    },
    GRADIENT = {
        texture_path = "/server/assets/net-games/fonts/fonts_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_gradient.animation",
        prefix = "GRADIENT"
    },
    GRADIENT_GOLD = {
        texture_path = "/server/assets/net-games/fonts/fonts_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_gradient.animation",
        prefix = "GRADIENT_GOLD"
    },
    GRADIENT_ORANGE = {
        texture_path = "/server/assets/net-games/fonts/fonts_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_gradient.animation",
        prefix = "GRADIENT_ORANGE"
    },
    GRADIENT_GREEN = {
        texture_path = "/server/assets/net-games/fonts/fonts_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_gradient.animation",
        prefix = "GRADIENT_GREEN"
    },
    GRADIENT_TALL = {
        texture_path = "/server/assets/net-games/fonts/fonts_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_gradient.animation",
        prefix = "GRADIENT_TALL"
    },

    -- Dark variants (dark sheet)
    THICK_BLACK = {
        texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_thick.animation",
        prefix = "THICK"
    },
    THIN_BLACK = {
        texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_thin.animation",
        prefix = "THIN"
    },
    WIDE_BLACK = {
        texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_wide.animation",
        prefix = "WIDE"
    },
    TINY_BLACK = {
        texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_tiny.animation",
        prefix = "TINY"
    },
    BATTLE_BLACK = {
        texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_battle.animation",
        prefix = "BATTLE"
    },
    GRADIENT_BLACK = {
        texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_gradient.animation",
        prefix = "GRADIENT"
    },
    GRADIENT_GOLD_BLACK = {
        texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_gradient.animation",
        prefix = "GRADIENT_GOLD"
    },
    GRADIENT_ORANGE_BLACK = {
        texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_gradient.animation",
        prefix = "GRADIENT_ORANGE"
    },
    GRADIENT_GREEN_BLACK = {
        texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_gradient.animation",
        prefix = "GRADIENT_GREEN"
    },
    GRADIENT_TALL_BLACK = {
        texture_path = "/server/assets/net-games/fonts/fonts_dark_compressed.png",
        anim_path    = "assets/net-games/fonts/fonts_gradient.animation",
        prefix = "GRADIENT_TALL"
    },
}

-- Global glyph metrics and available states loaded from animation files
---@type table<string, table<string, {w:number, h:number, ox:number, oy:number}>>
local GLYPH_METRICS = {}          -- font_name -> state -> { w, h, ox, oy }

---@type table<string, table<string, boolean>>
local AVAILABLE_STATES = {}       -- font_name -> set of state names

-- --------------------------------------------------------------------
-- Helper: load animation data using boom
-- --------------------------------------------------------------------
---@param anim_path string
---@return table<string, {w:number, h:number, ox:number, oy:number}> metrics
---@return table<string, boolean> states
local function load_animation_metrics(anim_path)
    local anim_data = boom.load(anim_path)
    if not anim_data then
        print("ERROR: Could not load animation: " .. tostring(anim_path))
        return {}, {}
    end

    if type(anim_data.states) ~= "table" then
        print("ERROR: Animation data for " .. anim_path .. " has no 'states' table (got " .. type(anim_data.states) .. ")")
        return {}, {}
    end

    local metrics = {}
    local states = {}
    for state_name, state_data in pairs(anim_data.states) do
        states[state_name] = true
        local frame = state_data.framelist and state_data.framelist[1]
        if frame then
            metrics[state_name] = {
                w  = frame.w or 0,
                h  = frame.h or 0,
                ox = frame.originx or 0,
                oy = frame.originy or 0,
            }
        else
            -- No frame data, use fallback dimensions (silent)
            metrics[state_name] = { w = 6, h = 12, ox = 0, oy = 0 }
        end
    end
    return metrics, states
end

-- --------------------------------------------------------------------
-- Initialize global font data (call once on server start)
-- --------------------------------------------------------------------
function FontSystem:loadAllFonts()
    for font_name, font_def in pairs(FONTS) do
        local metrics, states = load_animation_metrics(font_def.anim_path)
        GLYPH_METRICS[font_name] = metrics
        AVAILABLE_STATES[font_name] = states
    end

    -- For each font, build a mapping from character to animation state
    self.font_char_map = {}   -- font_name -> { [char] = state_name }
end

-- --------------------------------------------------------------------
-- Determine the correct animation state for a given font and character
-- --------------------------------------------------------------------
---@param font_name string
---@param char string
---@return string|nil   -- animation state name, or nil if no glyph
function FontSystem:getGlyphState(font_name, char)
    if char == " " then return nil end

    local font_def = FONTS[font_name]
    if not font_def then
        print("WARNING: Unknown font '" .. tostring(font_name) .. "'")
        return nil
    end

    local prefix = font_def.prefix
    local available = AVAILABLE_STATES[font_name]

    -- Build character‑to‑state map for this font if not already cached
    if not self.font_char_map[font_name] then
        self.font_char_map[font_name] = {}
    end
    local map = self.font_char_map[font_name]

    -- Return cached if available
    if map[char] ~= nil then
        return map[char]
    end

    -- Try exact state name: e.g. "THICK_A" or "THICK_a"
    local exact = prefix .. "_" .. char
    if available[exact] then
        map[char] = exact
        return exact
    end

    -- If lowercase, try LOWER_ variant (e.g., "THIN_LOWER_A")
    if char:match("%l") then
        local lower_state = prefix .. "_LOWER_" .. char:upper()
        if available[lower_state] then
            map[char] = lower_state
            return lower_state
        end
    end

    -- Special handling for double quote
    if char == '"' then
        local quote_state = prefix .. "_QUOTE"
        if available[quote_state] then
            map[char] = quote_state
            return quote_state
        end
    end

    -- Fallback: uppercase for letters
    if char:match("%a") then
        local upper = char:upper()
        local upper_state = prefix .. "_" .. upper
        if available[upper_state] then
            map[char] = upper_state
            return upper_state
        end
    end

    -- Last resort: '?' state
    local fallback = prefix .. "_?"
    if available[fallback] then
        map[char] = fallback
        return fallback
    end

    -- No glyph at all
    map[char] = false
    return nil
end

-- --------------------------------------------------------------------
-- Get glyph dimensions (after scale) for spacing calculations
-- --------------------------------------------------------------------
---@param font_name string
---@param char string
---@return number width, number height
function FontSystem:getGlyphDimensions(font_name, char)
    local state = self:getGlyphState(font_name, char)
    if not state then
        return 6, 12
    end
    local metrics = GLYPH_METRICS[font_name][state]
    if metrics then
        -- Optional debug print
        -- print(string.format("Glyph dims: font=%s, char=%s, state=%s, w=%d, h=%d", font_name, char, state, metrics.w, metrics.h))
        return metrics.w, metrics.h
    end
    return 6, 12
end

-- --------------------------------------------------------------------
-- Per‑player asset management
-- --------------------------------------------------------------------
---@param player_id string
function FontSystem:setupPlayer(player_id)
    self.player_assets = self.player_assets or {}      -- player_id -> { font_name = sprite_id }
    self.player_instances = self.player_instances or {} -- player_id -> { instance_id = { font, char, props } }
    self.next_instance_id = self.next_instance_id or {} -- player_id -> counter

    self.player_assets[player_id] = {}
    self.player_instances[player_id] = {}
    self.next_instance_id[player_id] = 1
end

---@param player_id string
function FontSystem:cleanupPlayer(player_id)
    if not self.player_instances or not self.player_instances[player_id] then return end

    for instance_id, _ in pairs(self.player_instances[player_id]) do
        Net.player_erase_sprite(player_id, instance_id)
    end
    self.player_instances[player_id] = nil

    if self.player_assets and self.player_assets[player_id] then
        for font_name, sprite_id in pairs(self.player_assets[player_id]) do
            Net.player_dealloc_sprite(player_id, sprite_id)
        end
        self.player_assets[player_id] = nil
    end

    if self.next_instance_id then
        self.next_instance_id[player_id] = nil
    end
end

-- Ensure the sprite asset for a given font is allocated for the player
---@param player_id string
---@param font_name string
---@return string sprite_id
function FontSystem:ensureAssetAllocated(player_id, font_name)
    if not self.player_assets then self.player_assets = {} end
    if not self.player_assets[player_id] then
        self:setupPlayer(player_id)
    end

    if self.player_assets[player_id][font_name] then
        return self.player_assets[player_id][font_name]
    end

    local font_def = FONTS[font_name]
    if not font_def then
        error("Unknown font: " .. tostring(font_name))
    end

    Net.provide_asset_for_player(player_id, font_def.texture_path)
    -- Client needs /server/ prefix for animation path
    Net.provide_asset_for_player(player_id, "/server/" .. font_def.anim_path)

    local sprite_id = "font_" .. font_name .. "_" .. player_id
    Net.player_alloc_sprite(player_id, sprite_id, {
        texture_path = font_def.texture_path,
        anim_path    = "/server/" .. font_def.anim_path,
        anim_state   = "IDLE"   -- some default state
    })

    self.player_assets[player_id][font_name] = sprite_id
    return sprite_id
end

-- Generate a unique instance ID for a player
---@param player_id string
---@param prefix string
---@return string
function FontSystem:nextInstanceId(player_id, prefix)
    if not self.next_instance_id then self.next_instance_id = {} end
    if not self.next_instance_id[player_id] then
        self.next_instance_id[player_id] = 1
    end
    local n = self.next_instance_id[player_id]
    self.next_instance_id[player_id] = n + 1
    return prefix .. "_" .. player_id .. "_" .. n
end

---@class GlyphOptions
---@field scale? number
---@field z? number
---@field r? integer
---@field g? integer
---@field b? integer
---@field opacity? integer
---@field a? integer
---@field ro? number
---@field ox? integer
---@field oy? integer
---@field color_mode? integer
---@field instance_id? string
---@field char? string   -- new character to change to (used in updates)

-- Draw a single glyph.
---@param player_id string
---@param font_name string
---@param char string
---@param x number
---@param y number
---@param options? GlyphOptions
---@return string|nil instance_id
function FontSystem:drawGlyph(player_id, font_name, char, x, y, options)
    options = options or {}
    local scale = options.scale or 2.0
    local z = options.z or 100

    local state = self:getGlyphState(font_name, char)
    if not state then
        return nil
    end

    local sprite_id = self:ensureAssetAllocated(player_id, font_name)
    local instance_id = options.instance_id or self:nextInstanceId(player_id, "glyph")

    -- Build draw table with explicit defaults
    local draw = {
        id = instance_id,
        x = x,
        y = y,
        z = z,
        sx = scale,
        sy = scale,
        anim_state = state,
        r = options.r or 255,
        g = options.g or 255,
        b = options.b or 255,
        opacity = options.opacity or 255,
        a = options.a or 255,
        ro = options.ro or 0,
        color_mode = options.color_mode or 0,
    }
    if options.ox then draw.ox = options.ox end
    if options.oy then draw.oy = options.oy end

    Net.player_draw_sprite(player_id, sprite_id, draw)

    -- Store all properties for later updates
    if not self.player_instances then self.player_instances = {} end
    if not self.player_instances[player_id] then
        self.player_instances[player_id] = {}
    end
    self.player_instances[player_id][instance_id] = {
        font = font_name,
        char = char,
        props = {
            x = x, y = y, z = z,
            scale = scale,
            state = state,
            r = draw.r,
            g = draw.g,
            b = draw.b,
            opacity = draw.opacity,
            a = draw.a,
            ro = draw.ro,
            color_mode = draw.color_mode,
            ox = draw.ox,
            oy = draw.oy,
        }
    }

    return instance_id
end

-- Update an existing glyph.
---@param player_id string
---@param instance_id string
---@param updates GlyphOptions   -- can include 'char' to change the character
function FontSystem:updateGlyph(player_id, instance_id, updates)
    if not self.player_instances or not self.player_instances[player_id] then
        return
    end
    local inst = self.player_instances[player_id][instance_id]
    if not inst then
        return
    end

    -- If char update requested, compute new state and update stored char
    if updates.char then
        local new_char = updates.char
        if new_char ~= inst.char then
            local new_state = self:getGlyphState(inst.font, new_char)
            if new_state then
                inst.char = new_char
                inst.props.state = new_state
            end
        end
        updates.char = nil -- remove so it doesn't get stored as a prop
    end

    -- Apply other updates to stored props
    for k, v in pairs(updates) do
        inst.props[k] = v
    end

    local font_def = FONTS[inst.font]
    local sprite_id = self.player_assets[player_id][inst.font]
    if not sprite_id then
        return
    end

    -- Rebuild draw table from stored props
    local draw = {
        id = instance_id,
        x = inst.props.x,
        y = inst.props.y,
        z = inst.props.z,
        sx = inst.props.scale,
        sy = inst.props.scale,
        anim_state = inst.props.state,
        r = inst.props.r or 255,
        g = inst.props.g or 255,
        b = inst.props.b or 255,
        opacity = inst.props.opacity or 255,
        a = inst.props.a or 255,
        ro = inst.props.ro or 0,
        color_mode = inst.props.color_mode or 0,
    }
    if inst.props.ox then draw.ox = inst.props.ox end
    if inst.props.oy then draw.oy = inst.props.oy end

    Net.player_draw_sprite(player_id, sprite_id, draw)
end

-- Erase a glyph instance.
---@param player_id string
---@param instance_id string
function FontSystem:eraseGlyph(player_id, instance_id)
    Net.player_erase_sprite(player_id, instance_id)
    if self.player_instances and self.player_instances[player_id] then
        self.player_instances[player_id][instance_id] = nil
    end
end

-- Erase all glyphs with a given prefix.
---@param player_id string
---@param prefix string
function FontSystem:eraseGlyphsByPrefix(player_id, prefix)
    if not self.player_instances or not self.player_instances[player_id] then return end
    for instance_id, _ in pairs(self.player_instances[player_id]) do
        if instance_id:find(prefix, 1, true) == 1 then
            self:eraseGlyph(player_id, instance_id)
        end
    end
end

-- --------------------------------------------------------------------
-- Initialization and event hooks
-- --------------------------------------------------------------------
function FontSystem:init()
    self:loadAllFonts()

    Net:on("player_request", function(event)
        local ok, err = pcall(function()
            self:setupPlayer(event.player_id)
        end)
        if not ok then
            print("Error in player_request handler:", err)
        end
    end)

    Net:on("player_disconnect", function(event)
        local ok, err = pcall(function()
            self:cleanupPlayer(event.player_id)
        end)
        if not ok then
            print("Error in player_disconnect handler:", err)
        end
    end)

    return self
end

-- Singleton instance
local fontSystem = setmetatable({}, FontSystem)
fontSystem:init()
return fontSystem