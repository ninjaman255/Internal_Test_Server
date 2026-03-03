--[[
scrolling-text-list.lua – Vertical scrolling list of text entries using the font system.
Each entry is represented by a TextEntry object that can be modified individually.
The list returns an object with methods to manage entries.

COORDINATES: All x, y, width, height passed to public functions are in virtual 240×160 space.
They are automatically multiplied by 2 before internal layout and drawing.
]]

local ScrollingTextList = {}
ScrollingTextList.__index = ScrollingTextList

local fontSystem = require("scripts/displayer/font-system")

-- Path to a 1x1 white pixel texture used for backdrops
local BACKDROP_TEXTURE = "/server/assets/net-games/displayer/empty_white.png"

-- Helper to get the maximum glyph height for a font at given scale (screen pixels)
local function getFontHeight(font_name, scale)
    -- Use a tall character, e.g., 'A' or 'g', to approximate line height
    local _, h = fontSystem:getGlyphDimensions(font_name, 'A')
    if h == 0 then h = 12 end  -- fallback
    return h * scale
end

-- --------------------------------------------------------------------
-- TextEntry class – represents a single text line in the list
-- --------------------------------------------------------------------
local TextEntry = {}
TextEntry.__index = TextEntry

function TextEntry:new(list_obj, player_id, list_id, index, text, config)
    local o = setmetatable({}, TextEntry)
    o.list = list_obj               -- reference to the parent list object (has .config)
    o.player_id = player_id
    o.list_id = list_id
    o.index = index
    o.text = text
    o.font = config.font or "THICK"
    o.scale = config.scale or 1.0
    o.z = config.z_order or 100
    -- Modifiable properties (applied to all glyphs)
    o.props = {
        r = 255,
        g = 255,
        b = 255,
        a = 255,
        ro = 0,
        color_mode = 0,
    }
    o.glyph_data = nil        -- { {id, x}, ... }
    o.y_offset = 0
    o.state = "waiting"
    o.timer = 0
    o.start_delay = 0
    o.grid_x = 0
    o.grid_y = 0
    return o
end

-- (Re)create glyphs for this entry (call when position or text changes)
function TextEntry:_createGlyphs()
    if not self.list or not self.list.config then return end
    -- Erase existing glyphs first
    if self.glyph_data then
        for _, g in ipairs(self.glyph_data) do
            fontSystem:eraseGlyph(self.player_id, g.id)
        end
    end

    -- Compute total width to center within bounds
    local bounds_left = self.list.config.bounds_left
    local bounds_width = self.list.config.bounds_width
    if not bounds_left or not bounds_width then return end

    local total_width = 0
    for i = 1, #self.text do
        local ch = self.text:sub(i,i)
        local w, _ = fontSystem:getGlyphDimensions(self.font, ch)
        total_width = total_width + w * self.scale
        if i < #self.text then total_width = total_width + 1 * self.scale end
    end
    local base_x = bounds_left + (bounds_width - total_width) / 2
    local base_y = self.grid_y + self.y_offset

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
                table.insert(glyph_data, {id = inst_id, x = cx})
            end
        end
        local w, _ = fontSystem:getGlyphDimensions(self.font, ch)
        cx = cx + w * self.scale + 1 * self.scale
    end
    self.glyph_data = glyph_data
end

-- Update glyph positions (called each frame during scrolling)
function TextEntry:_updatePositions()
    if not self.list or not self.list.config then return end
    if not self.glyph_data then return end
    local base_y = self.grid_y + self.y_offset
    for _, g in ipairs(self.glyph_data) do
        fontSystem:updateGlyph(self.player_id, g.id, { y = base_y / 2 })
    end
end

function TextEntry:setPosition(x, y)
    self.grid_x = x
    self.grid_y = y
    self:_createGlyphs()
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
    self:_createGlyphs()
end

function TextEntry:destroy()
    if self.glyph_data then
        for _, g in ipairs(self.glyph_data) do
            fontSystem:eraseGlyph(self.player_id, g.id)
        end
        self.glyph_data = nil
    end
end

-- --------------------------------------------------------------------
-- ScrollingTextList main class
-- --------------------------------------------------------------------
function ScrollingTextList:init()
    self.player_lists = self.player_lists or {}          -- player_id -> { active_lists = { list_id = list_object } }
    self.player_backdrop_sprite = self.player_backdrop_sprite or {} -- player_id -> sprite_id for the backdrop

    self.default_config = {
        font = "THICK",
        scale = 1.0,
        z_order = 100,
        scroll_speed = 30,
        line_spacing = 15,       -- virtual pixels
        entry_delay = 1.0,
        loop = false,
        destroy_when_finished = true,
        destroy_delay = 1.0,
    }

    self.states = {
        waiting = "waiting",
        scrolling = "scrolling",
        finished = "finished"
    }

    Net:on("player_join", function(event)
        local ok, err = pcall(function()
            self:setupPlayer(event.player_id)
        end)
        if not ok then
            print("Error in player_join:", err)
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

function ScrollingTextList:setupPlayer(player_id)
    if not self.player_lists then self.player_lists = {} end
    self.player_lists[player_id] = self.player_lists[player_id] or { active_lists = {} }

    -- Allocate a backdrop sprite for this player
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

-- Draw the backdrop using the player's allocated backdrop sprite.
function ScrollingTextList:_drawBackdrop(player_id, list_id, config)
    if not config or not config.backdrop then return nil end
    local backdrop_id = list_id .. "_backdrop"
    local backdrop_sprite_id = self.player_backdrop_sprite[player_id]
    if not backdrop_sprite_id then
        print("ERROR: No backdrop sprite allocated for player", player_id)
        return nil
    end

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

-- Compute grid positions (one per text entry, stacked vertically)
function ScrollingTextList:_computeGridPositions(config)
    local positions = {}
    -- Compute line height based on actual font height (screen pixels)
    local line_height = getFontHeight(config.font, config.scale)
    -- Convert virtual line spacing to screen pixels
    local line_spacing = (config.line_spacing or 15) * 2

    for i, text in ipairs(config.texts) do
        local grid_x = config.bounds_left
        local grid_y = config.bounds_bottom + (i - 1) * (line_height + line_spacing)
        local start_delay = (i - 1) * config.entry_delay
        positions[i] = {
            grid_x = grid_x,
            grid_y = grid_y,
            start_delay = start_delay,
        }
    end
    return positions
end

---@param player_id string
---@param list_id string
---@param x number        # virtual 240×160 coordinate
---@param y number        # virtual 240×160 coordinate
---@param width number    # virtual width
---@param height number   # virtual height
---@param config TextListConfig
---@return table|nil list_object
function ScrollingTextList:createScrollingList(player_id, list_id, x, y, width, height, config)
    config = config or {}

    if not self.player_lists then self.player_lists = {} end
    if not self.player_lists[player_id] then
        self:setupPlayer(player_id)
    end

    local list_config = {}
    for k, v in pairs(self.default_config) do
        list_config[k] = config[k] ~= nil and config[k] or v
    end

    -- Scale virtual coordinates/dimensions to screen pixels
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
        -- Scale padding as well
        if list_config.backdrop.padding_x then
            list_config.backdrop.padding_x = list_config.backdrop.padding_x * 2
        end
        if list_config.backdrop.padding_y then
            list_config.backdrop.padding_y = list_config.backdrop.padding_y * 2
        end
    end

    list_config.texts = config.texts or {}

    if list_config.backdrop then
        local pad_x = list_config.backdrop.padding_x or 16   -- 8 virtual * 2
        local pad_y = list_config.backdrop.padding_y or 12   -- 6 virtual * 2
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

    -- Compute grid positions
    local grid_positions = self:_computeGridPositions(list_config)
    list_config.grid_positions = grid_positions

    -- Create backdrop
    local backdrop_id = nil
    if list_config.backdrop then
        backdrop_id = self:_drawBackdrop(player_id, list_id, list_config)
    end

    -- Create list object (without entries yet)
    local list_object = {
        parent = self,               -- reference to the system (for later use)
        player_id = player_id,
        list_id = list_id,
        config = list_config,
        backdrop_id = backdrop_id,
        state = self.states.waiting,
        all_finished = false,
        finished_timer = 0,
        marked_for_removal = false,
    }

    -- Create entry objects, giving them a reference to the list object
    local entries = {}
    for i, text in ipairs(list_config.texts) do
        local entry = TextEntry:new(list_object, player_id, list_id, i, text, list_config)
        entry.grid_x = grid_positions[i].grid_x
        entry.grid_y = grid_positions[i].grid_y
        entry.start_delay = grid_positions[i].start_delay
        entries[i] = entry
    end
    list_object.config.entries = entries

    -- Add methods to list_object
    function list_object:getEntry(index)
        return self.config and self.config.entries and self.config.entries[index]
    end

    function list_object:addText(text)
        if not self.config then return end
        table.insert(self.config.texts, text)
        self:_recreateEntries()
    end

    function list_object:setTexts(texts)
        if not self.config then return end
        self.config.texts = texts or {}
        self:_recreateEntries()
    end

    function list_object:setSpeed(speed)
        if self.config then
            self.config.scroll_speed = speed or self.parent.default_config.scroll_speed
        end
    end

    function list_object:setPosition(x, y)
        if not self.config then return end
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
        if self.config and self.config.entries then
            for _, entry in ipairs(self.config.entries) do
                if entry and entry.destroy then
                    entry:destroy()
                end
            end
        end
        if self.backdrop_id then
            Net.player_erase_sprite(self.player_id, self.backdrop_id)
        end
        if self.parent.player_lists and self.parent.player_lists[self.player_id] then
            self.parent.player_lists[self.player_id].active_lists[self.list_id] = nil
        end
    end

    function list_object:_recreateEntries()
        if not self.config then return end
        -- Erase old entries
        if self.config.entries then
            for _, entry in ipairs(self.config.entries) do
                if entry and entry.destroy then
                    entry:destroy()
                end
            end
        end
        -- Recompute grid positions
        self.config.grid_positions = self.parent:_computeGridPositions(self.config)
        -- Create new entries
        local new_entries = {}
        for i, text in ipairs(self.config.texts) do
            local entry = TextEntry:new(self, self.player_id, self.list_id, i, text, self.config)
            entry.grid_x = self.config.grid_positions[i].grid_x
            entry.grid_y = self.config.grid_positions[i].grid_y
            entry.start_delay = self.config.grid_positions[i].start_delay
            new_entries[i] = entry
        end
        self.config.entries = new_entries
        -- Reset state
        self.state = self.parent.states.waiting
        self.all_finished = false
        self.finished_timer = 0
        self.marked_for_removal = false
    end

    -- Store in player_lists
    self.player_lists[player_id].active_lists[list_id] = list_object

    -- If no delay, start first entry immediately
    if #list_config.entries > 0 and list_config.entry_delay <= 0 then
        list_object.state = self.states.scrolling
        if list_config.entries[1] then
            list_config.entries[1].state = "scrolling"
            list_config.entries[1]:_createGlyphs()
        end
    end

    return list_object
end

function ScrollingTextList:updateAll(delta)
    if not delta or delta <= 0 then return end
    if not self.player_lists then return end

    for player_id, player_data in pairs(self.player_lists) do
        if player_data and player_data.active_lists then
            for list_id, list_object in pairs(player_data.active_lists) do
                if list_object and list_object.marked_for_removal then
                    self:removeScrollingList(player_id, list_id)
                elseif list_object and list_object.state ~= self.states.finished then
                    self:_updateList(list_object, delta)
                elseif list_object then
                    self:_updateFinishedList(list_object, delta)
                end
            end
        end
    end
end

function ScrollingTextList:_updateList(list_object, delta)
    if not list_object or not list_object.config then return end
    local config = list_object.config
    local all_finished = true
    local any_scrolling = false

    local line_height = getFontHeight(config.font, config.scale)

    for i, entry in ipairs(config.entries) do
        if entry.state == "waiting" then
            entry.timer = entry.timer + delta
            if entry.timer >= entry.start_delay then
                entry.state = "scrolling"
                list_object.state = self.states.scrolling
                entry:_createGlyphs()
            else
                all_finished = false
            end
        end

        if entry.state == "scrolling" then
            any_scrolling = true
            entry.y_offset = (entry.y_offset or 0) - (config.scroll_speed * delta)
            entry:_updatePositions()

            -- Correct finish condition: when the bottom of the text line passes the top of the visible area
            if entry.grid_y + entry.y_offset + line_height < config.bounds_top then
                entry.state = "finished"
                entry:destroy()
            else
                all_finished = false
            end
        end
    end

    if all_finished and #config.entries > 0 then
        list_object.state = self.states.finished
        list_object.all_finished = true
        if config.destroy_when_finished then
            list_object.finished_timer = 0
        end
    elseif not any_scrolling and list_object.state == self.states.scrolling then
        list_object.state = self.states.waiting
    end
end

function ScrollingTextList:_updateFinishedList(list_object, delta)
    if not list_object or not list_object.config then return end
    if list_object.config.destroy_when_finished and list_object.all_finished then
        list_object.finished_timer = (list_object.finished_timer or 0) + delta
        if list_object.finished_timer >= list_object.config.destroy_delay then
            list_object.marked_for_removal = true
        end
    end
end

-- Legacy API wrappers
function ScrollingTextList:getList(player_id, list_id)
    if not self.player_lists or not self.player_lists[player_id] then return nil end
    return self.player_lists[player_id].active_lists[list_id]
end

function ScrollingTextList:removeScrollingList(player_id, list_id)
    local list_object = self:getList(player_id, list_id)
    if list_object then
        list_object:destroy()
    end
end

function ScrollingTextList:setListPosition(player_id, list_id, x, y)
    local list_object = self:getList(player_id, list_id)
    if list_object then
        list_object:setPosition(x, y)
        return true
    end
    return false
end

function ScrollingTextList:setListSpeed(player_id, list_id, speed)
    local list_object = self:getList(player_id, list_id)
    if list_object then
        list_object:setSpeed(speed)
        return true
    end
    return false
end

function ScrollingTextList:addTextToList(player_id, list_id, text)
    local list_object = self:getList(player_id, list_id)
    if list_object then
        list_object:addText(text)
        return true
    end
    return false
end

function ScrollingTextList:setListTexts(player_id, list_id, texts)
    local list_object = self:getList(player_id, list_id)
    if list_object then
        list_object:setTexts(texts)
        return true
    end
    return false
end

function ScrollingTextList:getListState(player_id, list_id)
    local list_object = self:getList(player_id, list_id)
    if not list_object or not list_object.config then return nil end
    local active = 0
    if list_object.config.entries then
        for _, e in ipairs(list_object.config.entries) do
            if e.state == "scrolling" then active = active + 1 end
        end
    end
    return {
        state = list_object.state,
        all_finished = list_object.all_finished,
        total_entries = list_object.config.entries and #list_object.config.entries or 0,
        active_entries = active,
        marked_for_removal = list_object.marked_for_removal,
    }
end

local scrollingTextListSystem = setmetatable({}, ScrollingTextList)
scrollingTextListSystem:init()
return scrollingTextListSystem