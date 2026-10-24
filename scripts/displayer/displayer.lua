--[[
displayer.lua – Unified API for all text, timer, and sprite‑based display systems.
Sub‑APIs:
  .Font / .Text / .TimerDisplay / .Nameplate / .ScrollingText / .ScrollingSprite
  .Timer / .TextPanel (= .SlicedPanel) / .SlicedSprite / .Builder
Path convention: All texture and animation paths MUST include the "/server/" prefix.
]]

local Displayer = {}
Displayer.__index = Displayer

local fontSystem
local textDisplay
local timerDisplay
local nameplateInstance
local scrollingTextList
local scrollingSpriteList
local timerSystem
local slicedSprite

function Displayer:init()
    self.Font            = {}
    self.Text            = {}
    self.TimerDisplay    = {}
    self.Nameplate       = {}
    self.ScrollingText   = {}
    self.ScrollingSprite = {}
    self.Timer           = {}
    self.TextPanel       = {}
    self.SlicedPanel     = {}
    self.SlicedSprite    = {}
    self.Builder         = {}

    fontSystem           = require("scripts/displayer/font-system")
    textDisplay          = require("scripts/displayer/text-display")
    timerDisplay         = require("scripts/displayer/timer-display")
    local NameplateClass = require("scripts/displayer/nameplate")
    nameplateInstance    = NameplateClass:new(fontSystem)
    scrollingTextList    = require("scripts/displayer/scrolling-text-list")
    scrollingSpriteList  = require("scripts/displayer/scrolling-sprite-list")
    timerSystem          = require("scripts/displayer/timer-system")
    slicedSprite         = require("scripts/displayer/sliced-sprite")

    self:_setupFontAPI()
    self:_setupTextAPI()
    self:_setupTimerDisplayAPI()
    if nameplateInstance then
        nameplateInstance:setTextAPI(self.Text)
    end
    self:_setupNameplateAPI()
    self:_setupScrollingTextAPI()
    self:_setupScrollingSpriteAPI()
    self:_setupTimerAPI()
    self:_setupTextPanelAPI()
    self:_setupSlicedSpriteAPI()
    self:_setupBuilderAPI()
    self.SlicedPanel = self.TextPanel

    Net:on("player_join", function(event)
        fontSystem:allocateAllFontsForPlayer(event.player_id)
    end)
    return self
end

-- ---------------------------------------------------------------------------
-- Builder API
-- ---------------------------------------------------------------------------
function Displayer:_setupBuilderAPI()
    local api = self.Builder
    local boom = require("scripts/boom/main")
    local anim_cache = {}

    function api.glyph(overrides)
        local opts = { scale = 2.0, z = 100, r = 255, g = 255, b = 255,
                       opacity = 255, a = 255, ro = 0, color_mode = 0 }
        if overrides then for k, v in pairs(overrides) do opts[k] = v end end
        return opts
    end

    function api.staticText(overrides)
        local opts = { font = "THICK", scale = 2.0, z = 100, r = 255, g = 255, b = 255,
                       opacity = 255, a = 255, ro = 0, color_mode = 0 }
        if overrides then for k, v in pairs(overrides) do opts[k] = v end end
        return opts
    end

    function api.marquee(overrides)
        local opts = { font = "THICK", scale = 2.0, z = 100, speed = 60, loops = nil,
                       r = 255, g = 255, b = 255, opacity = 255, a = 255, ro = 0,
                       color_mode = 0, updateChar = nil }
        if overrides then for k, v in pairs(overrides) do opts[k] = v end end
        return opts
    end

    function api.textBox(overrides)
        local opts = { font = "THICK", scale = 2.0, z = 100, speed = 30,
                       type_sound = nil, type_sound_min_dt = 0.1,
                       r = 255, g = 255, b = 255, opacity = 255, a = 255,
                       ro = 0, color_mode = 0 }
        if overrides then for k, v in pairs(overrides) do opts[k] = v end end
        return opts
    end

    function api.timerDisplay(overrides)
        local opts = { font = "THICK", scale = 2.0, z = 100,
                       color = { r = 255, g = 255, b = 255 },
                       opacity = 255, a = 255, ro = 0, color_mode = 0 }
        if overrides then
            for k, v in pairs(overrides) do
                if k == "color" and type(v) == "table" then
                    opts.color = { r = v.r or 255, g = v.g or 255, b = v.b or 255 }
                else opts[k] = v end
            end
        end
        return opts
    end

    function api.textList(overrides)
        local opts = { font = "THICK", scale = 1.0, z_order = 100, scroll_speed = 30,
                       line_spacing = 15, entry_delay = 1.0, loop = false,
                       destroy_when_finished = true, destroy_delay = 1.0,
                       backdrop = nil, texts = {} }
        if overrides then for k, v in pairs(overrides) do opts[k] = v end end
        return opts
    end

    function api.spriteList(overrides)
        local opts = { x = 0, y = 0, width = 200, height = 100, z_order = 100,
                       scroll_speed = 30, entry_delay = 1.0, max_columns = 1,
                       column_spacing = 5, row_spacing = 5, align = "left",
                       backdrop = nil, sprites = {} }
        if overrides then for k, v in pairs(overrides) do opts[k] = v end end
        return opts
    end

    function api.backdrop(x, y, width, height, padding_x, padding_y, r, g, b, opacity, a)
        return { x = x, y = y, width = width, height = height,
                 padding_x = padding_x or 8, padding_y = padding_y or 6,
                 r = r or 0, g = g or 0, b = b or 0,
                 opacity = opacity or 200, a = a or 255 }
    end

    function api.spriteDef(texture_path, anim_path, anim_state, overrides)
        if type(anim_path) == "table" then
            overrides = anim_path; anim_path = nil; anim_state = nil
        elseif type(anim_state) == "table" then
            overrides = anim_state; anim_state = nil
        end
        overrides = overrides or {}
        local def = {
            texture_path = texture_path, anim_path = anim_path or "",
            anim_state = anim_state or "", ox = 0, oy = 0, sx = 2, sy = 2,
            width = 16, height = 16,
            r = 255, g = 255, b = 255, opacity = 255, a = 255,
            ro = 0, color_mode = 0,
        }
        if anim_path and anim_path ~= "" then
            local boom_path = anim_path:gsub("^/server/", "")
            local anim_data = anim_cache[anim_path]
            if not anim_data then
                anim_data = boom.load(boom_path)
                if anim_data then anim_cache[anim_path] = anim_data
                else print("ERROR: Could not load animation: " .. tostring(anim_path)) end
            end
            if anim_data and anim_data.states then
                local first_state = nil
                for state_name in pairs(anim_data.states) do
                    if not first_state then first_state = state_name end
                    if state_name == def.anim_state then
                        first_state = state_name; break
                    end
                end
                if first_state then
                    if def.anim_state == "" then def.anim_state = first_state end
                    local state_data = anim_data.states[first_state]
                    if state_data and state_data.framelist and #state_data.framelist > 0 then
                        local frame = state_data.framelist[1]
                        if frame then def.width = frame.w or 16; def.height = frame.h or 16 end
                    end
                end
            end
        end
        for k, v in pairs(overrides) do def[k] = v end
        return def
    end

    function api.sliceStyle9(texture_path, anim_path, overrides)
        overrides = overrides or {}
        local default_states = {
            top_left = "CORNER_UL", top = "EDGE_UC", top_right = "CORNER_UR",
            left = "EDGE_CL", center = "CENTER", right = "EDGE_RC",
            bottom_left = "CORNER_LL", bottom = "EDGE_LC", bottom_right = "CORNER_LR",
        }
        local parts = {}
        for name, default_state in pairs(default_states) do
            parts[name] = { anim_state = overrides[name] or default_state }
        end
        return { kind = "9", orientation = "horizontal",
                 texture_path = texture_path, anim_path = anim_path, parts = parts }
    end

    function api.sliceStyle3(texture_path, anim_path, states, orientation)
        orientation = orientation or "horizontal"
        states = states or {}
        local defaults = orientation == "horizontal"
            and { "LEFT", "CENTER", "RIGHT" }
            or  { "TOP", "CENTER", "BOTTOM" }
        return {
            kind = "3", orientation = orientation,
            texture_path = texture_path, anim_path = anim_path,
            parts = {
                { anim_state = states[1] or defaults[1] },
                { anim_state = states[2] or defaults[2] },
                { anim_state = states[3] or defaults[3] },
            },
        }
    end

    function api.sliceStyle5(texture_path, anim_path, states, orientation)
        orientation = orientation or "horizontal"
        states = states or {}
        local defaults = orientation == "horizontal"
            and { "LEFT", "EDGE_1", "CENTER", "EDGE_2", "RIGHT" }
            or  { "TOP", "EDGE_1", "CENTER", "EDGE_2", "BOTTOM" }
        return {
            kind = "5", orientation = orientation,
            texture_path = texture_path, anim_path = anim_path,
            parts = {
                { anim_state = states[1] or defaults[1] },
                { anim_state = states[2] or defaults[2], stretch = true },
                { anim_state = states[3] or defaults[3] },
                { anim_state = states[4] or defaults[4], stretch = true },
                { anim_state = states[5] or defaults[5] },
            },
        }
    end

    function api.text(mode, overrides)
        local base = {
            mode = mode, font = "THICK", scale = 2.0, z = 100,
            r = 255, g = 255, b = 255, opacity = 255, a = 255,
            ro = 0, color_mode = 0, halign = "left", valign = "top",
            width = nil, height = nil, perChar = nil,
        }
        if overrides then for k, v in pairs(overrides) do base[k] = v end end
        if mode == "marquee" then
            base.marquee = base.marquee or { speed = 60, loops = nil }
        elseif mode == "typewriter" then
            base.typewriter = base.typewriter or { speed = 30, sound = nil, sound_min_dt = 0.1 }
        end
        return base
    end

    function api.textPanelStyle(kind, parts, orientation)
        return { kind = kind or "9", orientation = orientation or "horizontal", parts = parts }
    end

    -- Normalize panel/child padding into the edge shape consumed by
    -- sliced-sprite.lua. Accepts a uniform number or an edge table such as
    -- { horizontal = 6, vertical = 8 } / { left=6, right=6, top=8, bottom=8 }.
    local function panelPadding(value, vertical)
        if type(value) == "number" then
            local h = value
            local v = tonumber(vertical) or h
            return { left = h, right = h, top = v, bottom = v }
        end
        if type(value) == "table" then
            local all = tonumber(value.all)
            local horizontal = tonumber(value.horizontal) or all or 0
            local vertical_value = tonumber(value.vertical) or all or 0
            return {
                left = tonumber(value.left) or horizontal,
                right = tonumber(value.right) or horizontal,
                top = tonumber(value.top) or vertical_value,
                bottom = tonumber(value.bottom) or vertical_value,
            }
        end
        local h = 0
        local v = tonumber(vertical) or h
        return { left = h, right = h, top = v, bottom = v }
    end

    function api.panelPadding(value, vertical)
        return panelPadding(value, vertical)
    end

    function api.panelChildPadding(value, vertical)
        return panelPadding(value, vertical)
    end

    --- Build options for text/sliced panels. `layout` accepts vertical/column,
    --- horizontal/row, or grid. Spacing and padding are included in auto-size.
    --- `children` is an array of descriptors from panelTextChild/panelSpritesChild.
    function api.textPanelOptions(overrides)
        local opts = {
            font = "THICK", scale = 2.0,
            color = { r = 255, g = 255, b = 255, a = 255 },
            halign = "left", valign = "top", line_spacing = 0,
            padding = 8, child_padding = 0, auto_size = true,
            width = nil, height = nil, max_width = nil, max_height = nil,
            z = 100, slice_scale = 1.0, slice_options = {},
            overflow = "wrap",
            layout = "vertical", spacing = 0,
            main_axis_spacing = nil, cross_axis_spacing = 0,
            main_axis_alignment = "start", cross_axis_alignment = "center",
            columns = 2, column_spacing = nil, row_spacing = nil,
            horizontal_alignment = "start", vertical_alignment = "start",
            children = nil,
        }
        if overrides then
            for k, v in pairs(overrides) do
                if k == "color" and type(v) == "table" then
                    opts.color = { r = v.r or 255, g = v.g or 255, b = v.b or 255, a = v.a or 255 }
                else
                    opts[k] = v
                end
            end
        end
        opts.padding = panelPadding(opts.padding)
        opts.child_padding = panelPadding(opts.child_padding)
        local layout = tostring(opts.layout or "vertical"):lower()
        if layout == "row" then layout = "horizontal"
        elseif layout == "column" then layout = "vertical" end
        opts.layout = layout
        return opts
    end

    function api.rowPanelOptions(overrides)
        overrides = overrides or {}
        local opts = {}
        for k, v in pairs(overrides) do opts[k] = v end
        opts.layout = "row"
        return api.textPanelOptions(opts)
    end

    function api.columnPanelOptions(overrides)
        overrides = overrides or {}
        local opts = {}
        for k, v in pairs(overrides) do opts[k] = v end
        opts.layout = "column"
        return api.textPanelOptions(opts)
    end

    function api.gridPanelOptions(columns, overrides)
        overrides = overrides or {}
        local opts = {}
        for k, v in pairs(overrides) do opts[k] = v end
        opts.layout = "grid"
        if columns ~= nil then opts.columns = columns end
        return api.textPanelOptions(opts)
    end

    function api.textPanel(text, style, options)
        return { text = text, style = style, options = options or {} }
    end

    function api.panelTextChild(text, overrides)
        local child = { kind = "text", text = text }
        if overrides then for k, v in pairs(overrides) do child[k] = v end end
        if child.padding ~= nil then child.padding = panelPadding(child.padding) end
        return child
    end

    function api.panelSpritesChild(sprites, overrides)
        local child = {
            kind = "sprites", sprites = sprites or {},
            sprite_scale = 1.0, columns = 1,
            column_spacing = 5, row_spacing = 5, sprite_align = "center",
        }
        if overrides then for k, v in pairs(overrides) do child[k] = v end end
        if child.padding ~= nil then child.padding = panelPadding(child.padding) end
        return child
    end
end

-- ---------------------------------------------------------------------------
-- Font API
-- ---------------------------------------------------------------------------
function Displayer:_setupFontAPI()
    local api = self.Font
    api.drawGlyph = function(player_id, font_name, char, x, y, options)
        return fontSystem:drawGlyph(player_id, font_name, char, x, y, options)
    end
    api.updateGlyph = function(player_id, instance_id, updates)
        fontSystem:updateGlyph(player_id, instance_id, updates)
    end
    api.eraseGlyph = function(player_id, instance_id)
        fontSystem:eraseGlyph(player_id, instance_id)
    end
    api.getGlyphDimensions = function(font_name, char)
        return fontSystem:getGlyphDimensions(font_name, char)
    end
    api.allocateAllFontsForPlayer = function(player_id)
        return fontSystem:allocateAllFontsForPlayer(player_id)
    end
end

-- ---------------------------------------------------------------------------
-- Text API
-- ---------------------------------------------------------------------------
function Displayer:_setupTextAPI()
    local api = self.Text
    api.draw            = function(pid, tid, text, x, y, o) return textDisplay:draw(pid, tid, text, x, y, o) end
    api.drawStatic      = function(pid, tid, text, x, y, o) return textDisplay:drawStatic(pid, tid, text, x, y, o) end
    api.removeStatic    = function(pid, tid) textDisplay:removeStatic(pid, tid) end
    api.drawMarquee     = function(pid, mid, text, y, o) return textDisplay:drawMarquee(pid, mid, text, y, o) end
    api.removeMarquee   = function(pid, mid) textDisplay:removeMarquee(pid, mid) end
    api.createTextBox   = function(pid, bid, text, x, y, w, h, o) return textDisplay:createTextBox(pid, bid, text, x, y, w, h, o) end
    api.advanceTextBox  = function(pid, bid) textDisplay:advanceTextBox(pid, bid) end
    api.closeTextBox    = function(pid, bid) textDisplay:closeTextBox(pid, bid) end
    api.getTextBoxState = function(pid, bid) return textDisplay:getTextBoxState(pid, bid) end
    api.getTextBoxData  = function(pid, bid) return textDisplay:getTextBoxData(pid, bid) end
    api.setKeepAlive    = function(pid, bid, keep) textDisplay:setKeepAlive(pid, bid, keep) end
end

-- ---------------------------------------------------------------------------
-- Timer Display API
-- ---------------------------------------------------------------------------
function Displayer:_setupTimerDisplayAPI()
    local api = self.TimerDisplay
    api.createPlayerTimer     = function(pid, did, x, y, o) timerDisplay:createPlayerTimerDisplay(pid, did, x, y, o) end
    api.createPlayerCountdown = function(pid, did, x, y, o) timerDisplay:createPlayerCountdownDisplay(pid, did, x, y, o) end
    api.createGlobalTimer     = function(did, x, y, o) timerDisplay:createGlobalTimerDisplay(did, x, y, o) end
    api.createGlobalCountdown = function(did, x, y, o) timerDisplay:createGlobalCountdownDisplay(did, x, y, o) end
    api.remove                = function(pid, did) timerDisplay:removeDisplay(pid, did) end
    api.setPosition           = function(pid, did, x, y) timerDisplay:setDisplayPosition(pid, did, x, y) end
end

-- ---------------------------------------------------------------------------
-- Nameplate API
-- ---------------------------------------------------------------------------
function Displayer:_setupNameplateAPI()
    local api = self.Nameplate
    api.attach      = function(pid, pd, bid, bd, cfg) nameplateInstance:attach(pid, pd, bid, bd, cfg) end
    api.erase       = function(pid, pd, bd) nameplateInstance:erase(pid, pd, bd) end
    api.begin_close = function(pid, pd, bd, cfg) nameplateInstance:begin_close(pid, pd, bd, cfg) end
end

-- ---------------------------------------------------------------------------
-- Scrolling Text List API
-- ---------------------------------------------------------------------------
function Displayer:_setupScrollingTextAPI()
    local api = self.ScrollingText
    api.createList  = function(pid, lid, x, y, w, h, cfg) return scrollingTextList:createScrollingList(pid, lid, x, y, w, h, cfg) end
    api.addText     = function(pid, lid, text) return scrollingTextList:addTextToList(pid, lid, text) end
    api.setTexts    = function(pid, lid, texts) return scrollingTextList:setListTexts(pid, lid, texts) end
    api.getState    = function(pid, lid) return scrollingTextList:getListState(pid, lid) end
    api.setSpeed    = function(pid, lid, s) return scrollingTextList:setListSpeed(pid, lid, s) end
    api.removeList  = function(pid, lid) scrollingTextList:removeScrollingList(pid, lid) end
    api.setPosition = function(pid, lid, x, y) return scrollingTextList:setListPosition(pid, lid, x, y) end
end

-- ---------------------------------------------------------------------------
-- Scrolling Sprite List API
-- ---------------------------------------------------------------------------
function Displayer:_setupScrollingSpriteAPI()
    local api = self.ScrollingSprite
    api.createList  = function(pid, lid, x, y, w, h, cfg) return scrollingSpriteList:createScrollingList(pid, lid, x, y, w, h, cfg) end
    api.addSprite   = function(pid, lid, d) return scrollingSpriteList:addSpriteToList(pid, lid, d) end
    api.setSprites  = function(pid, lid, s) return scrollingSpriteList:setListSprites(pid, lid, s) end
    api.getState    = function(pid, lid) return scrollingSpriteList:getListState(pid, lid) end
    api.setSpeed    = function(pid, lid, s) return scrollingSpriteList:setListSpeed(pid, lid, s) end
    api.removeList  = function(pid, lid) scrollingSpriteList:removeScrollingList(pid, lid) end
    api.setPosition = function(pid, lid, x, y) return scrollingSpriteList:setListPosition(pid, lid, x, y) end
end

-- ---------------------------------------------------------------------------
-- Timer System API
-- ---------------------------------------------------------------------------
function Displayer:_setupTimerAPI()
    local api = self.Timer
    api.createPlayerTimer     = function(p, t, d, cb, l) return timerSystem:createPlayerTimer(p, t, d, cb, l) end
    api.createPlayerCountdown = function(p, c, d, cb, l) return timerSystem:createPlayerCountdown(p, c, d, cb, l) end
    api.pausePlayerTimer      = function(p, t) return timerSystem:pausePlayerTimer(p, t) end
    api.resumePlayerTimer     = function(p, t) return timerSystem:resumePlayerTimer(p, t) end
    api.pausePlayerCountdown  = function(p, c) return timerSystem:pausePlayerCountdown(p, c) end
    api.resumePlayerCountdown = function(p, c) return timerSystem:resumePlayerCountdown(p, c) end
    api.removePlayerTimer     = function(p, t) return timerSystem:removePlayerTimer(p, t) end
    api.removePlayerCountdown = function(p, c) return timerSystem:removePlayerCountdown(p, c) end
    api.getPlayerTimer        = function(p, t) return timerSystem:getPlayerTimer(p, t) end
    api.getPlayerCountdown    = function(p, c) return timerSystem:getPlayerCountdown(p, c) end
    api.createGlobalTimer     = function(t, d, cb, l) return timerSystem:createGlobalTimer(t, d, cb, l) end
    api.createGlobalCountdown = function(c, d, cb, l) return timerSystem:createGlobalCountdown(c, d, cb, l) end
    api.pauseGlobalTimer      = function(t) return timerSystem:pauseGlobalTimer(t) end
    api.resumeGlobalTimer     = function(t) return timerSystem:resumeGlobalTimer(t) end
    api.pauseGlobalCountdown  = function(c) return timerSystem:pauseGlobalCountdown(c) end
    api.resumeGlobalCountdown = function(c) return timerSystem:resumeGlobalCountdown(c) end
    api.removeGlobalTimer     = function(t) return timerSystem:removeGlobalTimer(t) end
    api.removeGlobalCountdown = function(c) return timerSystem:removeGlobalCountdown(c) end
    api.getGlobalTimer        = function(t) return timerSystem:getGlobalTimer(t) end
    api.getGlobalCountdown    = function(c) return timerSystem:getGlobalCountdown(c) end
    api.getAllGlobalTimers    = function() return timerSystem:getAllGlobalTimers() end
    api.getAllGlobalCountdowns = function() return timerSystem:getAllGlobalCountdowns() end
    api.clearAllGlobalTimers  = function() return timerSystem:clearAllGlobalTimers() end
    api.clearAllGlobalCountdowns = function() return timerSystem:clearAllGlobalCountdowns() end
end

-- ---------------------------------------------------------------------------
-- Text Panel API
-- ---------------------------------------------------------------------------
function Displayer:_setupTextPanelAPI()
    local api = self.TextPanel
    self._text_panels = self._text_panels or {}

    api.create = function(player_id, panel_id, text, x, y, style, options)
        if not self._text_panels[player_id] then self._text_panels[player_id] = {} end
        if self._text_panels[player_id][panel_id] then
            self._text_panels[player_id][panel_id]:destroy()
        end
        local panel, err = slicedSprite.drawTextPanel(player_id, panel_id, x, y, text, style, options)
        if panel then self._text_panels[player_id][panel_id] = panel end
        return panel, err
    end

    api.createWithChildren = function(player_id, panel_id, x, y, style, options)
        if not self._text_panels[player_id] then self._text_panels[player_id] = {} end
        if self._text_panels[player_id][panel_id] then
            self._text_panels[player_id][panel_id]:destroy()
        end
        local panel, err = slicedSprite.drawTextPanel(player_id, panel_id, x, y, nil, style, options)
        if panel then self._text_panels[player_id][panel_id] = panel end
        return panel, err
    end

    api.updateText = function(player_id, panel_id, newText)
        local panel = self._text_panels[player_id] and self._text_panels[player_id][panel_id]
        if not panel then return false end
        panel:setText(newText)
        return true
    end

    api.setChildren = function(player_id, panel_id, children)
        local panel = self._text_panels[player_id] and self._text_panels[player_id][panel_id]
        if not panel then return false end
        panel:setChildren(children)
        return true
    end

    api.setPosition = function(player_id, panel_id, x, y)
        local panel = self._text_panels[player_id] and self._text_panels[player_id][panel_id]
        if not panel then return false end
        panel:setPosition(x, y)
        return true
    end

    api.setOptions = function(player_id, panel_id, newOptions)
        local panel = self._text_panels[player_id] and self._text_panels[player_id][panel_id]
        if not panel then return false end
        panel:setOptions(newOptions)
        return true
    end

    api.getSize = function(player_id, panel_id)
        local panel = self._text_panels[player_id] and self._text_panels[player_id][panel_id]
        if not panel then return nil, nil end
        return panel:getSize()
    end

    api.remove = function(player_id, panel_id)
        local panel = self._text_panels[player_id] and self._text_panels[player_id][panel_id]
        if panel then
            panel:destroy()
            self._text_panels[player_id][panel_id] = nil
        end
    end

    api.get = function(player_id, panel_id)
        return self._text_panels[player_id] and self._text_panels[player_id][panel_id]
    end

    Net:on("player_disconnect", function(event)
        local player_id = event.player_id
        if self._text_panels and self._text_panels[player_id] then
            for _, panel in pairs(self._text_panels[player_id]) do
                panel:destroy()
            end
            self._text_panels[player_id] = nil
        end
    end)
end

-- ---------------------------------------------------------------------------
-- Sliced Sprite API
-- ---------------------------------------------------------------------------
function Displayer:_setupSlicedSpriteAPI()
    local api = self.SlicedSprite
    api.draw3 = function(pid, lid, x, y, w, h, style, o) return slicedSprite.draw3(pid, lid, x, y, w, h, style, o) end
    api.draw5 = function(pid, lid, x, y, w, h, style, o) return slicedSprite.draw5(pid, lid, x, y, w, h, style, o) end
    api.draw9 = function(pid, lid, x, y, w, h, style, o) return slicedSprite.draw9(pid, lid, x, y, w, h, style, o) end
    api.erase = function(pid, lid) return slicedSprite.erase(pid, lid) end
    api.drawTextPanel = function(pid, lid, x, y, text, style, options) return slicedSprite.drawTextPanel(pid, lid, x, y, text, style, options) end
end

-- ---------------------------------------------------------------------------
-- Utility
-- ---------------------------------------------------------------------------
function Displayer:formatTime(seconds, is_countdown)
    if is_countdown then
        return string.format("%02d:%02d", math.floor(seconds / 60), math.floor(seconds % 60))
    end
    return string.format("%02d:%02d:%02d",
        math.floor(seconds / 3600),
        math.floor((seconds % 3600) / 60),
        math.floor(seconds % 60))
end

function Displayer:getScreenDimensions()
    return 480, 320
end

local displayer = setmetatable({}, Displayer)
displayer:init()
return displayer