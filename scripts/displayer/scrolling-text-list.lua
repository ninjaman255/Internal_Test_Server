--[[
scrolling-text-list.lua – Vertical scrolling list of text entries using the font system.
Each entry is drawn as a separate set of glyphs whose y‑position is updated each tick.
]]

local ScrollingTextList = {}
ScrollingTextList.__index = ScrollingTextList

local fontSystem = require("scripts/displayer/font-system")

-- Path to a 1x1 white pixel texture used for backdrops
local BACKDROP_TEXTURE = "/server/assets/net-games/displayer/empty_white.png"

function ScrollingTextList:init()
    self.player_lists = {}          -- player_id -> { active_lists = { list_id = list_data } }
    self.player_backdrop_sprite = {} -- player_id -> sprite_id for the backdrop

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
    self.player_lists[player_id] = { active_lists = {} }

    -- Allocate a backdrop sprite for this player
    local backdrop_sprite_id = "backdrop_" .. player_id
    Net.provide_asset_for_player(player_id, BACKDROP_TEXTURE)
    Net.player_alloc_sprite(player_id, backdrop_sprite_id, { texture_path = BACKDROP_TEXTURE })
    self.player_backdrop_sprite[player_id] = backdrop_sprite_id
end

function ScrollingTextList:cleanupPlayer(player_id)
    if self.player_lists[player_id] then
        for list_id, list_data in pairs(self.player_lists[player_id].active_lists) do
            self:removeScrollingList(player_id, list_id)
        end
        self.player_lists[player_id] = nil
    end

    -- Deallocate backdrop sprite
    if self.player_backdrop_sprite[player_id] then
        Net.player_dealloc_sprite(player_id, self.player_backdrop_sprite[player_id])
        self.player_backdrop_sprite[player_id] = nil
    end
end

---@class TextListConfig
---@field font? string
---@field scale? number
---@field z_order? number
---@field scroll_speed? number
---@field line_spacing? number
---@field entry_delay? number
---@field loop? boolean
---@field destroy_when_finished? boolean
---@field destroy_delay? number
---@field backdrop? table
---@field texts? string[]

---@param player_id string
---@param list_id string
---@param x number
---@param y number
---@param width number
---@param height number
---@param config TextListConfig
---@return string|nil list_id
function ScrollingTextList:createScrollingList(player_id, list_id, x, y, width, height, config)
    config = config or {}

    if not self.player_lists[player_id] then
        self:setupPlayer(player_id)
    end

    local list_config = {}
    for k, v in pairs(self.default_config) do
        list_config[k] = config[k] ~= nil and config[k] or v
    end

    list_config.x = x or 0
    list_config.y = y or 0
    list_config.width = width or 200
    list_config.height = height or 100
    list_config.backdrop = config.backdrop
    list_config.texts = config.texts or {}
    list_config.entry_states = {}

    if list_config.backdrop then
        local pad_x = list_config.backdrop.padding_x or 8
        local pad_y = list_config.backdrop.padding_y or 6
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

    for i, text in ipairs(list_config.texts) do
        list_config.entry_states[i] = {
            text = text,
            y_offset = 0,
            state = "waiting",
            glyph_data = nil,              -- will hold { {id, x}, ... } when drawn
            start_delay = (i - 1) * list_config.entry_delay,
            timer = 0,
        }
    end

    local list_data = {
        config = list_config,
        backdrop_id = nil,
        state = self.states.waiting,
        start_time = os.clock(),
        all_finished = false,
        finished_timer = 0,
        marked_for_removal = false,
    }

    if list_config.backdrop then
        list_data.backdrop_id = self:_drawBackdrop(player_id, list_id, list_config)
    end

    self.player_lists[player_id].active_lists[list_id] = list_data

    if #list_config.texts > 0 and list_config.entry_delay <= 0 then
        list_config.entry_states[1].state = "scrolling"
        list_data.state = self.states.scrolling
        self:_createEntryGlyphs(player_id, list_id, 1, list_data)
    end

    return list_id
end

-- Create glyphs for an entry (called once when it starts scrolling)
function ScrollingTextList:_createEntryGlyphs(player_id, list_id, entry_idx, list_data)
    local config = list_data.config
    local entry = config.entry_states[entry_idx]
    if not entry then return end

    -- Compute total width of the text to center it
    local total_width = 0
    for i = 1, #entry.text do
        local ch = entry.text:sub(i,i)
        local w, _ = fontSystem:getGlyphDimensions(config.font, ch)
        total_width = total_width + w * config.scale
        if i < #entry.text then total_width = total_width + 1 * config.scale end
    end
    local base_x = config.bounds_left + (config.bounds_width - total_width) / 2
    local base_y = config.bounds_bottom + entry.y_offset

    local glyph_data = {}
    local cx = base_x
    for i = 1, #entry.text do
        local ch = entry.text:sub(i,i)
        if ch ~= " " then
            local inst_id = fontSystem:drawGlyph(player_id, config.font, ch, cx, base_y, {
                scale = config.scale,
                z = config.z_order,
            })
            if inst_id then
                table.insert(glyph_data, {id = inst_id, x = cx})
            end
        end
        local w, _ = fontSystem:getGlyphDimensions(config.font, ch)
        cx = cx + w * config.scale + 1 * config.scale
    end
    entry.glyph_data = glyph_data
end

-- Update the position of a scrolling entry (called every tick)
function ScrollingTextList:_updateEntryPosition(player_id, list_id, entry_idx, list_data)
    local config = list_data.config
    local entry = config.entry_states[entry_idx]
    if not entry or not entry.glyph_data then return end

    local y = config.bounds_bottom + entry.y_offset

    for _, g in ipairs(entry.glyph_data) do
        fontSystem:updateGlyph(player_id, g.id, { y = y })
    end
end

-- Draw the backdrop using the player's allocated backdrop sprite.
function ScrollingTextList:_drawBackdrop(player_id, list_id, config)
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

function ScrollingTextList:updateAll(delta)
    if not delta or delta <= 0 then return end

    for player_id, player_data in pairs(self.player_lists) do
        for list_id, list_data in pairs(player_data.active_lists) do
            if list_data.marked_for_removal then
                self:removeScrollingList(player_id, list_id)
            elseif list_data.state ~= self.states.finished then
                self:_updateList(player_id, list_id, list_data, delta)
            else
                self:_updateFinishedList(player_id, list_id, list_data, delta)
            end
        end
    end
end

function ScrollingTextList:_updateList(player_id, list_id, list_data, delta)
    local config = list_data.config
    local all_finished = true
    local any_scrolling = false

    for i, entry in ipairs(config.entry_states) do
        if entry.state == "waiting" then
            entry.timer = entry.timer + delta
            if entry.timer >= entry.start_delay then
                entry.state = "scrolling"
                list_data.state = self.states.scrolling
                self:_createEntryGlyphs(player_id, list_id, i, list_data)
            else
                all_finished = false
            end
        end

        if entry.state == "scrolling" then
            any_scrolling = true
            entry.y_offset = entry.y_offset - (config.scroll_speed * delta)
            self:_updateEntryPosition(player_id, list_id, i, list_data)

            local line_height = 10 * config.scale
            if entry.y_offset + config.bounds_bottom + line_height < config.bounds_top then
                entry.state = "finished"
                if entry.glyph_data then
                    for _, g in ipairs(entry.glyph_data) do
                        fontSystem:eraseGlyph(player_id, g.id)
                    end
                    entry.glyph_data = nil
                end
            else
                all_finished = false
            end
        end
    end

    if all_finished and #config.entry_states > 0 then
        list_data.state = self.states.finished
        list_data.all_finished = true
        if config.destroy_when_finished then
            list_data.finished_timer = 0
        end
    elseif not any_scrolling and list_data.state == self.states.scrolling then
        list_data.state = self.states.waiting
    end
end

function ScrollingTextList:_updateFinishedList(player_id, list_id, list_data, delta)
    if list_data.config.destroy_when_finished and list_data.all_finished then
        list_data.finished_timer = list_data.finished_timer + delta
        if list_data.finished_timer >= list_data.config.destroy_delay then
            list_data.marked_for_removal = true
        end
    end
end

function ScrollingTextList:addTextToList(player_id, list_id, text)
    local list_data = self.player_lists[player_id] and self.player_lists[player_id].active_lists[list_id]
    if not list_data then return false end

    local config = list_data.config

    if list_data.state == self.states.finished then
        list_data.state = self.states.waiting
        list_data.all_finished = false
        list_data.finished_timer = 0
        list_data.marked_for_removal = false
    end

    local start_delay = 0
    if #config.entry_states > 0 then
        start_delay = config.entry_states[#config.entry_states].start_delay + config.entry_delay
    end

    local new_idx = #config.entry_states + 1
    config.entry_states[new_idx] = {
        text = text,
        y_offset = 0,
        state = "waiting",
        glyph_data = nil,
        start_delay = start_delay,
        timer = 0,
    }
    table.insert(config.texts, text)

    return true
end

function ScrollingTextList:setListTexts(player_id, list_id, texts)
    local list_data = self.player_lists[player_id] and self.player_lists[player_id].active_lists[list_id]
    if not list_data then return false end

    for _, entry in ipairs(list_data.config.entry_states) do
        if entry.glyph_data then
            for _, g in ipairs(entry.glyph_data) do
                fontSystem:eraseGlyph(player_id, g.id)
            end
        end
    end

    list_data.config.texts = texts or {}
    list_data.config.entry_states = {}
    list_data.state = self.states.waiting
    list_data.all_finished = false
    list_data.finished_timer = 0
    list_data.marked_for_removal = false

    for i, text in ipairs(texts) do
        list_data.config.entry_states[i] = {
            text = text,
            y_offset = 0,
            state = "waiting",
            glyph_data = nil,
            start_delay = (i - 1) * list_data.config.entry_delay,
            timer = 0,
        }
    end

    if #texts > 0 and list_data.config.entry_delay <= 0 then
        list_data.config.entry_states[1].state = "scrolling"
        list_data.state = self.states.scrolling
        self:_createEntryGlyphs(player_id, list_id, 1, list_data)
    end

    return true
end

function ScrollingTextList:getListState(player_id, list_id)
    local list_data = self.player_lists[player_id] and self.player_lists[player_id].active_lists[list_id]
    if not list_data then return nil end

    local active = 0
    for _, e in ipairs(list_data.config.entry_states) do
        if e.state == "scrolling" then active = active + 1 end
    end
    return {
        state = list_data.state,
        all_finished = list_data.all_finished,
        total_entries = #list_data.config.texts,
        active_entries = active,
        marked_for_removal = list_data.marked_for_removal,
    }
end

function ScrollingTextList:pauseList(player_id, list_id) return false end
function ScrollingTextList:resumeList(player_id, list_id) return false end

function ScrollingTextList:setListSpeed(player_id, list_id, speed)
    local list_data = self.player_lists[player_id] and self.player_lists[player_id].active_lists[list_id]
    if list_data then
        list_data.config.scroll_speed = speed or self.default_config.scroll_speed
        return true
    end
    return false
end

function ScrollingTextList:removeScrollingList(player_id, list_id)
    local list_data = self.player_lists[player_id] and self.player_lists[player_id].active_lists[list_id]
    if not list_data then return end

    for _, entry in ipairs(list_data.config.entry_states) do
        if entry.glyph_data then
            for _, g in ipairs(entry.glyph_data) do
                fontSystem:eraseGlyph(player_id, g.id)
            end
        end
    end

    if list_data.backdrop_id then
        Net.player_erase_sprite(player_id, list_data.backdrop_id)
    end

    self.player_lists[player_id].active_lists[list_id] = nil
end

function ScrollingTextList:setListPosition(player_id, list_id, x, y)
    local list_data = self.player_lists[player_id] and self.player_lists[player_id].active_lists[list_id]
    if not list_data then return false end

    local config = list_data.config
    config.x = x
    config.y = y

    if config.backdrop then
        config.backdrop.x = x
        config.backdrop.y = y
        if list_data.backdrop_id then
            Net.player_erase_sprite(player_id, list_data.backdrop_id)
        end
        list_data.backdrop_id = self:_drawBackdrop(player_id, list_id, config)
    else
        config.bounds_left = x
        config.bounds_top = y
        config.bounds_right = x + config.width
        config.bounds_bottom = y + config.height
    end

    -- Recreate all scrolling entries with new positions
    for i, entry in ipairs(config.entry_states) do
        if entry.state == "scrolling" then
            if entry.glyph_data then
                for _, g in ipairs(entry.glyph_data) do
                    fontSystem:eraseGlyph(player_id, g.id)
                end
                entry.glyph_data = nil
            end
            self:_createEntryGlyphs(player_id, list_id, i, list_data)
        end
    end

    return true
end

local scrollingTextListSystem = setmetatable({}, ScrollingTextList)
scrollingTextListSystem:init()
return scrollingTextListSystem