--[[
scrolling-sprite-list.lua – Scrolling grid of sprite instances.
Manages its own sprite assets and updates instance positions each tick.
All sprites are pre‑allocated per player and drawn with unique instance IDs.
]]

local ScrollingSpriteList = {}
ScrollingSpriteList.__index = ScrollingSpriteList

-- Path to a 1x1 white pixel texture used for backdrops
local BACKDROP_TEXTURE = "/server/assets/net-games/displayer/empty_white.png"

function ScrollingSpriteList:init()
    self.player_lists = {}        -- player_id -> { active_lists = { list_id = list_data } }
    self.player_assets = {}       -- player_id -> { [asset_key] = sprite_id } for reusing sprites
    self.player_backdrop_sprite = {} -- player_id -> sprite_id for the backdrop

    self.default_config = {
        z_order = 100,
        scroll_speed = 30,
        entry_spacing = 10,
        entry_delay = 1.0,
        loop = false,
        destroy_when_finished = true,
        destroy_delay = 1.0,
        max_columns = 1,
        column_spacing = 5,
        row_spacing = 5,
        align = "left"
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

function ScrollingSpriteList:setupPlayer(player_id)
    self.player_lists[player_id] = { active_lists = {} }
    self.player_assets[player_id] = {}

    -- Allocate a backdrop sprite for this player
    local backdrop_sprite_id = "backdrop_" .. player_id
    Net.provide_asset_for_player(player_id, BACKDROP_TEXTURE)
    Net.player_alloc_sprite(player_id, backdrop_sprite_id, { texture_path = BACKDROP_TEXTURE })
    self.player_backdrop_sprite[player_id] = backdrop_sprite_id
end

function ScrollingSpriteList:cleanupPlayer(player_id)
    if self.player_lists[player_id] then
        for list_id, list_data in pairs(self.player_lists[player_id].active_lists) do
            self:removeScrollingList(player_id, list_id)
        end
        self.player_lists[player_id] = nil
    end

    if self.player_assets[player_id] then
        for _, sprite_id in pairs(self.player_assets[player_id]) do
            Net.player_dealloc_sprite(player_id, sprite_id)
        end
        self.player_assets[player_id] = nil
    end

    if self.player_backdrop_sprite[player_id] then
        Net.player_dealloc_sprite(player_id, self.player_backdrop_sprite[player_id])
        self.player_backdrop_sprite[player_id] = nil
    end
end

-- Ensure a sprite asset (texture + optional animation) is allocated.
---@param player_id string
---@param sprite_def table   -- with fields texture_path, anim_path (optional)
---@return string sprite_id
function ScrollingSpriteList:ensureSpriteAsset(player_id, sprite_def)
    local asset_key = sprite_def.texture_path .. "|" .. (sprite_def.anim_path or "")
    if self.player_assets[player_id][asset_key] then
        return self.player_assets[player_id][asset_key]
    end

    local sprite_id = "sprite_" .. tostring(#self.player_assets[player_id] + 1) .. "_" .. player_id

    Net.provide_asset_for_player(player_id, sprite_def.texture_path)
    if sprite_def.anim_path then
        Net.provide_asset_for_player(player_id, sprite_def.anim_path)
    end

    Net.player_alloc_sprite(player_id, sprite_id, {
        texture_path = sprite_def.texture_path,
        anim_path = sprite_def.anim_path or "",
    })

    self.player_assets[player_id][asset_key] = sprite_id
    return sprite_id
end

---@class SpriteListConfig
---@field x? number
---@field y? number
---@field width? number
---@field height? number
---@field z_order? number
---@field scroll_speed? number
---@field entry_delay? number
---@field max_columns? integer
---@field column_spacing? number
---@field row_spacing? number
---@field align? "left"|"center"|"right"
---@field backdrop? table
---@field sprites? table[]

---@param player_id string
---@param list_id string
---@param x number
---@param y number
---@param width number
---@param height number
---@param config SpriteListConfig
---@return string|nil list_id
function ScrollingSpriteList:createScrollingList(player_id, list_id, x, y, width, height, config)
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
    list_config.sprites = config.sprites or {}
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

    -- Pre‑allocate all unique sprite assets for this list
    for _, sprite_def in ipairs(list_config.sprites) do
        self:ensureSpriteAsset(player_id, sprite_def)
    end

    self:_initEntryGrid(list_config)

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

    if #list_config.sprites > 0 and list_config.entry_delay <= 0 then
        list_config.entry_states[1].state = "scrolling"
        list_data.state = self.states.scrolling
        self:_drawEntry(player_id, list_id, 1, list_data)
    end

    return list_id
end

-- Compute grid positions for each entry.
function ScrollingSpriteList:_initEntryGrid(list_config)
    local sprites = list_config.sprites
    local max_cols = list_config.max_columns or 1
    local col_spacing = list_config.column_spacing or 5
    local row_spacing = list_config.row_spacing or 5

    local max_w, max_h = 0, 0
    for _, def in ipairs(sprites) do
        local w = (def.width or 16) * (def.sx or def.scale or 1)
        local h = (def.height or 16) * (def.sy or def.scale or 1)
        max_w = math.max(max_w, w)
        max_h = math.max(max_h, h)
    end

    local cell_w = max_w + col_spacing
    local cell_h = max_h + row_spacing
    local cols = math.min(max_cols, math.floor(list_config.bounds_width / cell_w))
    if cols < 1 then cols = 1 end

    local align_offset = 0
    if list_config.align == "center" then
        local total_grid_w = cols * cell_w - col_spacing
        align_offset = (list_config.bounds_width - total_grid_w) / 2
    elseif list_config.align == "right" then
        local total_grid_w = cols * cell_w - col_spacing
        align_offset = list_config.bounds_width - total_grid_w
    end

    list_config.entry_states = {}
    for i, def in ipairs(sprites) do
        local row = math.floor((i - 1) / cols)
        local col = (i - 1) % cols
        local grid_x = list_config.bounds_left + align_offset + col * cell_w
        local grid_y = list_config.bounds_bottom + row * cell_h   -- start below bottom

        list_config.entry_states[i] = {
            def = def,
            y_offset = 0,
            grid_x = grid_x,
            grid_y = grid_y,
            state = "waiting",
            instance_id = nil,
            start_delay = row * (list_config.entry_delay or 0),
            timer = 0,
        }
    end
end

-- Draw a single entry (create or update its sprite instance).
function ScrollingSpriteList:_drawEntry(player_id, list_id, entry_idx, list_data)
    local config = list_data.config
    local entry = config.entry_states[entry_idx]
    if not entry then return end

    local def = entry.def
    local sprite_id = self:ensureSpriteAsset(player_id, def)

    local x = entry.grid_x
    local y = entry.grid_y + entry.y_offset

    local margin = 50
    if y + margin < config.bounds_top or y - margin > config.bounds_bottom then
        if entry.instance_id then
            Net.player_erase_sprite(player_id, entry.instance_id)
            entry.instance_id = nil
        end
        return
    end

    local instance_id = entry.instance_id or (list_id .. "_entry_" .. entry_idx .. "_" .. player_id)

    local draw = {
        id = instance_id,
        x = x,
        y = y,
        z = config.z_order,
        sx = def.sx or def.scale or 1,
        sy = def.sy or def.scale or 1,
        anim_state = def.anim_state,
        r = def.r, g = def.g, b = def.b,
        opacity = def.opacity,
        ro = def.ro,
        color_mode = def.color_mode,
    }

    Net.player_draw_sprite(player_id, sprite_id, draw)
    entry.instance_id = instance_id
end

-- Draw the backdrop using the player's allocated backdrop sprite.
function ScrollingSpriteList:_drawBackdrop(player_id, list_id, config)
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

function ScrollingSpriteList:updateAll(delta)
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

function ScrollingSpriteList:_updateList(player_id, list_id, list_data, delta)
    local config = list_data.config
    local all_finished = true
    local any_scrolling = false

    for i, entry in ipairs(config.entry_states) do
        if entry.state == "waiting" then
            entry.timer = entry.timer + delta
            if entry.timer >= entry.start_delay then
                entry.state = "scrolling"
                list_data.state = self.states.scrolling
                self:_drawEntry(player_id, list_id, i, list_data)
            else
                all_finished = false
            end
        end

        if entry.state == "scrolling" then
            any_scrolling = true
            entry.y_offset = entry.y_offset - (config.scroll_speed * delta)
            self:_drawEntry(player_id, list_id, i, list_data)

            local sprite_h = (entry.def.height or 16) * (entry.def.sy or entry.def.scale or 1)
            if entry.y_offset + config.bounds_bottom + sprite_h < config.bounds_top then
                entry.state = "finished"
                if entry.instance_id then
                    Net.player_erase_sprite(player_id, entry.instance_id)
                    entry.instance_id = nil
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

function ScrollingSpriteList:_updateFinishedList(player_id, list_id, list_data, delta)
    if list_data.config.destroy_when_finished and list_data.all_finished then
        list_data.finished_timer = list_data.finished_timer + delta
        if list_data.finished_timer >= list_data.config.destroy_delay then
            list_data.marked_for_removal = true
        end
    end
end

function ScrollingSpriteList:addSpriteToList(player_id, list_id, sprite_def)
    local player_data = self.player_lists[player_id]
    if not player_data then return false end
    local list_data = player_data.active_lists[list_id]
    if not list_data then return false end

    local config = list_data.config

    if list_data.state == self.states.finished then
        list_data.state = self.states.waiting
        list_data.all_finished = false
        list_data.finished_timer = 0
        list_data.marked_for_removal = false
    end

    self:ensureSpriteAsset(player_id, sprite_def)
    table.insert(config.sprites, sprite_def)
    self:_initEntryGrid(config)

    return true
end

function ScrollingSpriteList:setListSprites(player_id, list_id, sprites)
    local player_data = self.player_lists[player_id]
    if not player_data then return false end
    local list_data = player_data.active_lists[list_id]
    if not list_data then return false end

    for _, entry in ipairs(list_data.config.entry_states) do
        if entry.instance_id then
            Net.player_erase_sprite(player_id, entry.instance_id)
        end
    end

    list_data.config.sprites = sprites or {}
    list_data.config.entry_states = {}
    list_data.state = self.states.waiting
    list_data.all_finished = false
    list_data.finished_timer = 0
    list_data.marked_for_removal = false

    for _, def in ipairs(sprites) do
        self:ensureSpriteAsset(player_id, def)
    end

    self:_initEntryGrid(list_data.config)

    if #sprites > 0 and list_data.config.entry_delay <= 0 then
        list_data.config.entry_states[1].state = "scrolling"
        list_data.state = self.states.scrolling
        self:_drawEntry(player_id, list_id, 1, list_data)
    end

    return true
end

function ScrollingSpriteList:getListState(player_id, list_id)
    local player_data = self.player_lists[player_id]
    if not player_data then return nil end
    local list_data = player_data.active_lists[list_id]
    if not list_data then return nil end

    local active = 0
    for _, e in ipairs(list_data.config.entry_states) do
        if e.state == "scrolling" then active = active + 1 end
    end
    return {
        state = list_data.state,
        all_finished = list_data.all_finished,
        total_entries = #list_data.config.sprites,
        active_entries = active,
        marked_for_removal = list_data.marked_for_removal,
    }
end

function ScrollingSpriteList:pauseList(player_id, list_id) return false end
function ScrollingSpriteList:resumeList(player_id, list_id) return false end

function ScrollingSpriteList:setListSpeed(player_id, list_id, speed)
    local list_data = self.player_lists[player_id] and self.player_lists[player_id].active_lists[list_id]
    if list_data then
        list_data.config.scroll_speed = speed or self.default_config.scroll_speed
        return true
    end
    return false
end

function ScrollingSpriteList:removeScrollingList(player_id, list_id)
    local player_data = self.player_lists[player_id]
    if not player_data then return end
    local list_data = player_data.active_lists[list_id]
    if not list_data then return end

    for _, entry in ipairs(list_data.config.entry_states) do
        if entry.instance_id then
            Net.player_erase_sprite(player_id, entry.instance_id)
        end
    end

    if list_data.backdrop_id then
        Net.player_erase_sprite(player_id, list_data.backdrop_id)
    end

    player_data.active_lists[list_id] = nil
end

function ScrollingSpriteList:setListPosition(player_id, list_id, x, y)
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

    self:_initEntryGrid(config)
    for i, entry in ipairs(config.entry_states) do
        if entry.state == "scrolling" then
            self:_drawEntry(player_id, list_id, i, list_data)
        end
    end

    return true
end

local scrollingSpriteListSystem = setmetatable({}, ScrollingSpriteList)
scrollingSpriteListSystem:init()
return scrollingSpriteListSystem