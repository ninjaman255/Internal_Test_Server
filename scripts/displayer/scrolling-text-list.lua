--[[
scrolling-text-list.lua – Vertical scrolling list of text entries.
Uses AnimationEngine for entry delays and scrolling tweens.
]]

local ScrollingTextList = {}
ScrollingTextList.__index = ScrollingTextList

local fontSystem = require("scripts/displayer/font-system")
local AnimationEngine = require("scripts/animation-engine/animation-engine")

local BACKDROP_TEXTURE = "/server/assets/net-games/displayer/empty_white.png"

local function getFontHeight(font_name, scale)
    local _, h = fontSystem:getGlyphDimensions(font_name, 'A')
    if h == 0 then h = 12 end
    return h * scale
end

-- --------------------------------------------------------------------
-- TextEntry class
-- --------------------------------------------------------------------
local TextEntry = {}
TextEntry.__index = TextEntry

function TextEntry:new(list_obj, player_id, list_id, index, text, config)
    local o = setmetatable({}, TextEntry)
    o.list = list_obj
    o.player_id = player_id
    o.list_id = list_id
    o.index = index
    o.text = text
    o.font = config.font or "THICK"
    o.scale = config.scale or 1.0
    o.z = config.z_order or 100
    o.props = { r = 255, g = 255, b = 255, a = 255, ro = 0, color_mode = 0 }
    o.glyph_data = nil
    o.grid_x = 0
    o.grid_y = 0
    o.state = "waiting"   -- waiting, scrolling, finished
    o.anim_id = nil
    o.delay_id = nil
    o.destroying = false
    return o
end

-- Create glyphs at current position (grid_x, grid_y + y_offset)
function TextEntry:_createGlyphs(y_offset)
    if not self.list or not self.list.config then return end
    if self.glyph_data then
        for _, g in ipairs(self.glyph_data) do
            fontSystem:eraseGlyph(self.player_id, g.id)
        end
    end

    local bounds_left = self.list.config.bounds_left
    local bounds_width = self.list.config.bounds_width
    if not bounds_left or not bounds_width then
        print("WARNING: bounds_left or bounds_width is nil for entry", self.index, bounds_left, bounds_width)
        return
    end
    print("Creating glyphs for entry", self.index, "bounds_left:", bounds_left, "bounds_width:", bounds_width)

    local total_width = 0
    for i = 1, #self.text do
        local ch = self.text:sub(i,i)
        local w, _ = fontSystem:getGlyphDimensions(self.font, ch)
        total_width = total_width + w * self.scale
        if i < #self.text then
            local spacing = fontSystem:isBattleFont(self.font) and 0 or 1
            total_width = total_width + spacing * self.scale
        end
    end
    local base_x = bounds_left + (bounds_width - total_width) / 2
    local base_y = self.grid_y + (y_offset or 0)

    local glyph_data = {}
    local cx = base_x
    for i = 1, #self.text do
        local ch = self.text:sub(i,i)
        if ch ~= " " then
            local virtual_x = cx / 2
            local virtual_y = base_y / 2
            local opts = {
                scale = self.scale,
                z = self.z,
                r = self.props.r,
                g = self.props.g,
                b = self.props.b,
                a = self.props.a,
                ro = self.props.ro,
                color_mode = self.props.color_mode,
            }
            local inst_id = fontSystem:drawGlyph(self.player_id, self.font, ch, virtual_x, virtual_y, opts)
            if inst_id then
                table.insert(glyph_data, { id = inst_id, x = cx })
            end
        end
        local w, _ = fontSystem:getGlyphDimensions(self.font, ch)
        local spacing = fontSystem:isBattleFont(self.font) and 0 or 1
        cx = cx + w * self.scale + spacing * self.scale
    end
    self.glyph_data = glyph_data
end

-- Update glyph positions (used during scrolling)
function TextEntry:_updatePositions(y_offset)
    if not self.glyph_data then return end
    local base_y = self.grid_y + y_offset
    for _, g in ipairs(self.glyph_data) do
        fontSystem:updateGlyph(self.player_id, g.id, { y = base_y / 2 })
    end
end

function TextEntry:setPosition(x, y)
    self.grid_x = x
    self.grid_y = y
    if self.state == "scrolling" then
        self:_createGlyphs(0)   -- recreate at new base, offset will be handled by animation
    end
end

function TextEntry:setColor(r, g, b, a)
    self.props.r = r or self.props.r
    self.props.g = g or self.props.g
    self.props.b = b or self.props.b
    self.props.a = a or self.props.a
    if self.glyph_data then
        for _, g in ipairs(self.glyph_data) do
            fontSystem:updateGlyph(self.player_id, g.id, {
                r = self.props.r,
                g = self.props.g,
                b = self.props.b,
                a = self.props.a,
            })
        end
    end
end

function TextEntry:setScale(scale)
    self.scale = scale
    if self.state == "scrolling" then
        self:_createGlyphs(0)
    end
end

function TextEntry:destroy()
    if self.destroying then return end
    self.destroying = true

    if self.anim_id then
        AnimationEngine.stop_animation(self.anim_id)
        self.anim_id = nil
    end
    -- delay_id cannot be cancelled, ignore
    if self.glyph_data then
        for _, g in ipairs(self.glyph_data) do
            fontSystem:eraseGlyph(self.player_id, g.id)
        end
        self.glyph_data = nil
    end
end

-- Start scrolling: after delay, animate y_offset from 0 to -distance
function TextEntry:startScroll(delay, distance, speed)
    self.state = "waiting"
    if delay > 0 then
        self.delay_id = AnimationEngine.delay(delay, function()
            self.delay_id = nil
            if self.state == "waiting" then
                self:_beginScroll(distance, speed)
            end
        end)
    else
        self:_beginScroll(distance, speed)
    end
end

function TextEntry:_beginScroll(distance, speed)
    if self.state ~= "waiting" then return end
    print("Beginning scroll for entry", self.index)
    self.state = "scrolling"
    local duration = distance / speed
    self:_createGlyphs(0)   -- draw at starting position

    self.anim_id = AnimationEngine.animate(
        { y_offset = 0 },
        { y_offset = -distance },
        duration,
        {
            easing = "linear",
            on_update = function(values)
                self:_updatePositions(values.y_offset)
            end,
            on_complete = function()
                self.state = "finished"
                if not self.destroying then
                    self:destroy()
                end
                if self.list then
                    self.list:onEntryFinished()
                end
            end,
        }
    )
end

-- --------------------------------------------------------------------
-- ScrollingTextList main class
-- --------------------------------------------------------------------
function ScrollingTextList:init()
    self.player_lists = {}
    self.player_backdrop_sprite = {}

    self.default_config = {
        font = "THICK",
        scale = 1.0,
        z_order = 100,
        scroll_speed = 30,
        line_spacing = 15,
        entry_delay = 1.0,
        loop = false,
        destroy_when_finished = true,
        destroy_delay = 1.0,
    }

    self.states = { waiting = "waiting", scrolling = "scrolling", finished = "finished" }

    Net:on("player_join", function(event)
        pcall(function() self:setupPlayer(event.player_id) end)
    end)

    Net:on("player_disconnect", function(event)
        pcall(function() self:cleanupPlayer(event.player_id) end)
    end)

    -- No update loop needed; animations drive everything.
    -- But we keep updateAll for compatibility (empty).
    Net:on("tick", function(event)
        pcall(function() self:updateAll(event.delta_time) end)
    end)

    return self
end

function ScrollingTextList:setupPlayer(player_id)
    if not self.player_lists then self.player_lists = {} end
    self.player_lists[player_id] = self.player_lists[player_id] or { active_lists = {} }

    if not self.player_backdrop_sprite[player_id] then
        local backdrop_sprite_id = "backdrop_" .. player_id
        Net.provide_asset_for_player(player_id, BACKDROP_TEXTURE)
        Net.player_alloc_sprite(player_id, backdrop_sprite_id, { texture_path = BACKDROP_TEXTURE })
        self.player_backdrop_sprite[player_id] = backdrop_sprite_id
    end
end

function ScrollingTextList:cleanupPlayer(player_id)
    if self.player_lists and self.player_lists[player_id] then
        for list_id, list_object in pairs(self.player_lists[player_id].active_lists) do
            if list_object and list_object.destroy then
                list_object:destroy()
            end
        end
        self.player_lists[player_id] = nil
    end
    if self.player_backdrop_sprite and self.player_backdrop_sprite[player_id] then
        Net.player_dealloc_sprite(player_id, self.player_backdrop_sprite[player_id])
        self.player_backdrop_sprite[player_id] = nil
    end
end

function ScrollingTextList:_drawBackdrop(player_id, list_id, config)
    if not config or not config.backdrop then return nil end
    local backdrop_id = list_id .. "_backdrop"
    local backdrop_sprite_id = self.player_backdrop_sprite[player_id]
    if not backdrop_sprite_id then return nil end

    Net.player_draw_sprite(
        player_id,
        backdrop_sprite_id,
        {
            id = backdrop_id,
            x = config.backdrop.x,
            y = config.backdrop.y,
            z = config.z_order - 1,
            sx = config.backdrop.width,
            sy = config.backdrop.height,
            r = config.backdrop.r, g = config.backdrop.g, b = config.backdrop.b,
            opacity = config.backdrop.opacity,
        }
    )
    return backdrop_id
end

function ScrollingTextList:_computeGridPositions(config)
    local positions = {}
    local line_height = getFontHeight(config.font, config.scale)
    local line_spacing = (config.line_spacing or 15) * 2

    for i, text in ipairs(config.texts) do
        local grid_x = config.bounds_left
        local grid_y = config.bounds_bottom + (i - 1) * (line_height + line_spacing)
        local start_delay = (i - 1) * config.entry_delay
        positions[i] = { grid_x = grid_x, grid_y = grid_y, start_delay = start_delay }
    end
    return positions
end

function ScrollingTextList:createScrollingList(player_id, list_id, x, y, width, height, config)
    config = config or {}
    if not self.player_lists then self.player_lists = {} end
    if not self.player_lists[player_id] then self:setupPlayer(player_id) end

    local list_config = {}
    for k, v in pairs(self.default_config) do
        list_config[k] = config[k] ~= nil and config[k] or v
    end

    -- Scale coordinates
    list_config.x = (x or 0) * 2
    list_config.y = (y or 0) * 2
    list_config.width = (width or 200) * 2
    list_config.height = (height or 100) * 2

    list_config.backdrop = config.backdrop
    if list_config.backdrop then
        list_config.backdrop.x = (list_config.backdrop.x or 0) * 2
        list_config.backdrop.y = (list_config.backdrop.y or 0) * 2
        list_config.backdrop.width = (list_config.backdrop.width or 200) * 2
        list_config.backdrop.height = (list_config.backdrop.height or 100) * 2
        if list_config.backdrop.padding_x then list_config.backdrop.padding_x = list_config.backdrop.padding_x * 2 end
        if list_config.backdrop.padding_y then list_config.backdrop.padding_y = list_config.backdrop.padding_y * 2 end
    end

    list_config.texts = config.texts or {}

    if list_config.backdrop then
        local pad_x = list_config.backdrop.padding_x or 16
        local pad_y = list_config.backdrop.padding_y or 12
        list_config.bounds_left   = list_config.backdrop.x + pad_x
        list_config.bounds_right  = list_config.backdrop.x + list_config.backdrop.width - pad_x
        list_config.bounds_top    = list_config.backdrop.y + pad_y
        list_config.bounds_bottom = list_config.backdrop.y + list_config.backdrop.height - pad_y
    else
        list_config.bounds_left   = list_config.x
        list_config.bounds_right  = list_config.x + list_config.width
        list_config.bounds_top    = list_config.y
        list_config.bounds_bottom = list_config.y + list_config.height
    end
    list_config.bounds_width  = list_config.bounds_right - list_config.bounds_left
    list_config.bounds_height = list_config.bounds_bottom - list_config.bounds_top

    local grid_positions = self:_computeGridPositions(list_config)
    list_config.grid_positions = grid_positions

    local backdrop_id = nil
    if list_config.backdrop then
        backdrop_id = self:_drawBackdrop(player_id, list_id, list_config)
    end

    -- Create list object
    local list_object = {
        parent = self,
        player_id = player_id,
        list_id = list_id,
        config = list_config,
        backdrop_id = backdrop_id,
        entries = {},
        active_count = 0,          -- number of entries not finished
        finished = false,
        remove_delay_id = nil,
    }

    -- Create entry objects
    for i, text in ipairs(list_config.texts) do
        local entry = TextEntry:new(list_object, player_id, list_id, i, text, list_config)
        entry.grid_x = grid_positions[i].grid_x
        entry.grid_y = grid_positions[i].grid_y
        entry.start_delay = grid_positions[i].start_delay
        list_object.entries[i] = entry
        list_object.active_count = list_object.active_count + 1

        -- Compute scroll distance: from grid_y to off‑screen above bounds_top
        local line_height = getFontHeight(list_config.font, list_config.scale)
        local distance = (entry.grid_y - list_config.bounds_top) + line_height
        entry:startScroll(entry.start_delay, distance, list_config.scroll_speed)
    end

    -- Method to handle entry finished
    function list_object:onEntryFinished()
        self.active_count = self.active_count - 1
        if self.active_count <= 0 then
            self.finished = true
            if self.config.destroy_when_finished then
                self.remove_delay_id = AnimationEngine.delay(self.config.destroy_delay, function()
                    self:destroy()
                end)
            end
        end
    end

    function list_object:getEntry(index)
        return self.entries and self.entries[index]
    end

    function list_object:addText(text)
        if not self.config then return end
        table.insert(self.config.texts, text)
        self:_recreateEntries()
    end

    function list_object:setTexts(texts)
        self.config.texts = texts or {}
        self:_recreateEntries()
    end

    function list_object:setSpeed(speed)
        self.config.scroll_speed = speed or self.parent.default_config.scroll_speed
        -- Note: changing speed mid‑scroll not handled; would need to restart animations.
    end

    function list_object:setPosition(x, y)
        local screen_x = x * 2
        local screen_y = y * 2
        self.config.x = screen_x
        self.config.y = screen_y

        if self.config.backdrop then
            self.config.backdrop.x = screen_x
            self.config.backdrop.y = screen_y
            if self.backdrop_id then
                Net.player_erase_sprite(self.player_id, self.backdrop_id)
            end
            self.backdrop_id = self.parent:_drawBackdrop(self.player_id, self.list_id, self.config)
        else
            self.config.bounds_left = screen_x
            self.config.bounds_top = screen_y
            self.config.bounds_right = screen_x + self.config.width
            self.config.bounds_bottom = screen_y + self.config.height
        end

        self:_recreateEntries()
    end

    function list_object:destroy()
        if self.remove_delay_id then
            -- can't cancel, ignore
        end
        if self.entries then
            for _, entry in ipairs(self.entries) do
                if entry and entry.destroy then
                    entry:destroy()
                end
            end
            self.entries = nil
        end
        if self.backdrop_id then
            Net.player_erase_sprite(self.player_id, self.backdrop_id)
        end
        if self.parent.player_lists and self.parent.player_lists[self.player_id] then
            self.parent.player_lists[self.player_id].active_lists[self.list_id] = nil
        end
    end

    function list_object:_recreateEntries()
        -- Destroy current entries
        if self.entries then
            for _, entry in ipairs(self.entries) do
                if entry and entry.destroy then
                    entry:destroy()
                end
            end
        end
        -- Recompute grid
        self.config.grid_positions = self.parent:_computeGridPositions(self.config)
        -- Create new entries
        self.entries = {}
        self.active_count = 0
        for i, text in ipairs(self.config.texts) do
            local entry = TextEntry:new(self, self.player_id, self.list_id, i, text, self.config)
            entry.grid_x = self.config.grid_positions[i].grid_x
            entry.grid_y = self.config.grid_positions[i].grid_y
            entry.start_delay = self.config.grid_positions[i].start_delay
            self.entries[i] = entry
            self.active_count = self.active_count + 1

            local line_height = getFontHeight(self.config.font, self.config.scale)
            local distance = (entry.grid_y - self.config.bounds_top) + line_height
            entry:startScroll(entry.start_delay, distance, self.config.scroll_speed)
        end
        self.finished = false
    end

    self.player_lists[player_id].active_lists[list_id] = list_object
    return list_object
end

-- updateAll is now a no‑op (kept for compatibility)
function ScrollingTextList:updateAll(delta) end

-- Legacy API wrappers (unchanged, but now use list_object methods)
function ScrollingTextList:getList(player_id, list_id)
    if not self.player_lists or not self.player_lists[player_id] then return nil end
    return self.player_lists[player_id].active_lists[list_id]
end

function ScrollingTextList:removeScrollingList(player_id, list_id)
    local list_object = self:getList(player_id, list_id)
    if list_object then list_object:destroy() end
end

function ScrollingTextList:setListPosition(player_id, list_id, x, y)
    local list_object = self:getList(player_id, list_id)
    if list_object then list_object:setPosition(x, y); return true end
    return false
end

function ScrollingTextList:setListSpeed(player_id, list_id, speed)
    local list_object = self:getList(player_id, list_id)
    if list_object then list_object:setSpeed(speed); return true end
    return false
end

function ScrollingTextList:addTextToList(player_id, list_id, text)
    local list_object = self:getList(player_id, list_id)
    if list_object then list_object:addText(text); return true end
    return false
end

function ScrollingTextList:setListTexts(player_id, list_id, texts)
    local list_object = self:getList(player_id, list_id)
    if list_object then list_object:setTexts(texts); return true end
    return false
end

function ScrollingTextList:getListState(player_id, list_id)
    local list_object = self:getList(player_id, list_id)
    if not list_object then return nil end
    local active = 0
    if list_object.entries then
        for _, e in ipairs(list_object.entries) do
            if e.state == "scrolling" then active = active + 1 end
        end
    end
    return {
        state = list_object.finished and "finished" or "active",
        all_finished = list_object.finished,
        total_entries = list_object.entries and #list_object.entries or 0,
        active_entries = active,
        marked_for_removal = list_object.finished and list_object.config.destroy_when_finished,
    }
end

local scrollingTextListSystem = setmetatable({}, ScrollingTextList)
scrollingTextListSystem:init()
return scrollingTextListSystem