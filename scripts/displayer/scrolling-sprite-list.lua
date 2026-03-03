--[[
scrolling-sprite-list.lua – Scrolling grid of sprite instances.
Uses AnimationEngine for entry delays and scrolling tweens.
]]

local ScrollingSpriteList = {}
ScrollingSpriteList.__index = ScrollingSpriteList

local AnimationEngine = _G.AnimationEngine
local BACKDROP_TEXTURE = "/server/assets/net-games/displayer/empty_white.png"

-- --------------------------------------------------------------------
-- SpriteEntry class
-- --------------------------------------------------------------------
local SpriteEntry = {}
SpriteEntry.__index = SpriteEntry

function SpriteEntry:new(list_obj, player_id, list_id, index, def)
    local o = setmetatable({}, SpriteEntry)
    o.list = list_obj
    o.player_id = player_id
    o.list_id = list_id
    o.index = index
    o.def = def
    o.props = {
        x = 0, y = 0,
        r = def.r or 255,
        g = def.g or 255,
        b = def.b or 255,
        a = def.a or 255,
        opacity = def.opacity or 255,
        sx = def.sx or 1,
        sy = def.sy or 1,
        ro = def.ro or 0,
        color_mode = def.color_mode or 0,
        anim_state = def.anim_state,
    }
    o.instance_id = nil
    o.sprite_asset_id = list_obj.parent:ensureSpriteAsset(player_id, def)
    o.grid_x = 0
    o.grid_y = 0
    o.state = "waiting"
    o.anim_id = nil
    o.delay_id = nil
    o.destroying = false
    return o
end

function SpriteEntry:setPosition(x, y)
    self.props.x = x
    self.props.y = y
    self:redraw()
end

function SpriteEntry:setColor(r, g, b, a)
    self.props.r = r or self.props.r
    self.props.g = g or self.props.g
    self.props.b = b or self.props.b
    self.props.a = a or self.props.a
    self:redraw()
end

function SpriteEntry:setScale(sx, sy)
    self.props.sx = sx or self.props.sx
    self.props.sy = sy or self.props.sy
    self:redraw()
end

function SpriteEntry:setAnimationState(state)
    self.props.anim_state = state
    self:redraw()
end

function SpriteEntry:redraw()
    if not self.sprite_asset_id then return end
    if not self.list or not self.list.config then return end
    local draw = {
        id = self.instance_id or (self.list_id .. "_entry_" .. self.index),
        x = self.props.x,
        y = self.props.y,
        z = self.list.config.z_order,
        sx = self.props.sx,
        sy = self.props.sy,
        anim_state = self.props.anim_state,
        r = self.props.r,
        g = self.props.g,
        b = self.props.b,
        opacity = self.props.opacity,
        a = self.props.a,
        ro = self.props.ro,
        color_mode = self.props.color_mode,
        ox = 0,
        oy = 0,
    }
    if not self.instance_id then
        self.instance_id = draw.id
    end
    Net.player_draw_sprite(self.player_id, self.sprite_asset_id, draw)
end

function SpriteEntry:destroy()
    if self.destroying then return end
    self.destroying = true

    if self.anim_id then
        AnimationEngine.stop_animation(self.anim_id)
        self.anim_id = nil
    end
    -- delay_id cannot be cancelled, ignore
    if self.instance_id then
        Net.player_erase_sprite(self.player_id, self.instance_id)
    end
end

function SpriteEntry:startScroll(delay, distance, speed)
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

function SpriteEntry:_beginScroll(distance, speed)
    if self.state ~= "waiting" then return end
    print("Beginning scroll for sprite entry", self.index)
    self.state = "scrolling"
    local duration = distance / speed
    local start_y = self.grid_y
    local target_y = self.grid_y - distance

    self:setPosition(self.grid_x, start_y)   -- draw at start

    self.anim_id = AnimationEngine.animate(
        { y = start_y },
        { y = target_y },
        duration,
        {
            easing = "linear",
            on_update = function(values)
                self:setPosition(self.grid_x, values.y)
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
-- ScrollingSpriteList main class
-- --------------------------------------------------------------------
function ScrollingSpriteList:init()
    self.player_lists = {}
    self.player_assets = {}
    self.player_backdrop_sprite = {}

    self.default_config = {
        z_order = 100,
        scroll_speed = 30,
        entry_delay = 1.0,
        loop = false,
        destroy_when_finished = true,
        destroy_delay = 1.0,
        max_columns = 1,
        column_spacing = 5,
        row_spacing = 5,
        align = "left"
    }

    Net:on("player_join", function(event)
        pcall(function() self:setupPlayer(event.player_id) end)
    end)

    Net:on("player_disconnect", function(event)
        pcall(function() self:cleanupPlayer(event.player_id) end)
    end)

    Net:on("tick", function(event)
        pcall(function() self:updateAll(event.delta_time) end)
    end)

    return self
end

function ScrollingSpriteList:setupPlayer(player_id)
    if not self.player_lists then self.player_lists = {} end
    self.player_lists[player_id] = self.player_lists[player_id] or { active_lists = {} }
    self.player_assets[player_id] = self.player_assets[player_id] or {}

    if not self.player_backdrop_sprite[player_id] then
        local backdrop_sprite_id = "backdrop_" .. player_id
        Net.provide_asset_for_player(player_id, BACKDROP_TEXTURE)
        Net.player_alloc_sprite(player_id, backdrop_sprite_id, { texture_path = BACKDROP_TEXTURE })
        self.player_backdrop_sprite[player_id] = backdrop_sprite_id
    end
end

function ScrollingSpriteList:cleanupPlayer(player_id)
    if self.player_lists and self.player_lists[player_id] then
        for list_id, list_object in pairs(self.player_lists[player_id].active_lists) do
            if list_object and list_object.destroy then list_object:destroy() end
        end
        self.player_lists[player_id] = nil
    end
    if self.player_assets and self.player_assets[player_id] then
        for _, sprite_id in pairs(self.player_assets[player_id]) do
            Net.player_dealloc_sprite(player_id, sprite_id)
        end
        self.player_assets[player_id] = nil
    end
    if self.player_backdrop_sprite and self.player_backdrop_sprite[player_id] then
        Net.player_dealloc_sprite(player_id, self.player_backdrop_sprite[player_id])
        self.player_backdrop_sprite[player_id] = nil
    end
end

function ScrollingSpriteList:ensureSpriteAsset(player_id, sprite_def)
    if not self.player_assets then self.player_assets = {} end
    if not self.player_assets[player_id] then self:setupPlayer(player_id) end
    local anim_path = sprite_def.anim_path
    local asset_key = sprite_def.texture_path .. "|" .. (anim_path or "")
    if self.player_assets[player_id][asset_key] then
        return self.player_assets[player_id][asset_key]
    end

    local sprite_id = "sprite_" .. tostring(#self.player_assets[player_id] + 1) .. "_" .. player_id

    Net.provide_asset_for_player(player_id, sprite_def.texture_path)
    if anim_path then Net.provide_asset_for_player(player_id, anim_path) end

    Net.player_alloc_sprite(player_id, sprite_id, {
        texture_path = sprite_def.texture_path,
        anim_path = anim_path or "",
    })

    self.player_assets[player_id][asset_key] = sprite_id
    return sprite_id
end

function ScrollingSpriteList:_computeGridPositions(config)
    local sprites = config.sprites
    local max_cols = config.max_columns or 1
    local col_spacing = (config.column_spacing or 5) * 2
    local row_spacing = (config.row_spacing or 5) * 2

    local max_w, max_h = 0, 0
    for _, def in ipairs(sprites) do
        local w = (def.width or 16) * (def.sx or def.scale or 1)
        local h = (def.height or 16) * (def.sy or def.scale or 1)
        max_w = math.max(max_w, w)
        max_h = math.max(max_h, h)
    end

    local cell_w = max_w + col_spacing
    local cell_h = max_h + row_spacing
    local cols = math.min(max_cols, math.floor(config.bounds_width / cell_w))
    if cols < 1 then cols = 1 end

    local align_offset = 0
    if config.align == "center" then
        local total_grid_w = cols * cell_w - col_spacing
        align_offset = (config.bounds_width - total_grid_w) / 2
    elseif config.align == "right" then
        local total_grid_w = cols * cell_w - col_spacing
        align_offset = config.bounds_width - total_grid_w
    end

    local positions = {}
    for i, def in ipairs(sprites) do
        local row = math.floor((i - 1) / cols)
        local col = (i - 1) % cols
        local grid_x = config.bounds_left + align_offset + col * cell_w
        local grid_y = config.bounds_bottom + row * cell_h
        local start_delay = row * (config.entry_delay or 0)
        positions[i] = { grid_x = grid_x, grid_y = grid_y, start_delay = start_delay }
    end
    return positions
end

function ScrollingSpriteList:_drawBackdrop(player_id, list_id, config)
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
            r = config.backdrop.r or 0,
            g = config.backdrop.g or 0,
            b = config.backdrop.b or 0,
            opacity = config.backdrop.opacity or 200,
            a = config.backdrop.a or 255,
            color_mode = 0,
        }
    )
    return backdrop_id
end

function ScrollingSpriteList:createScrollingList(player_id, list_id, x, y, width, height, config)
    config = config or {}
    if not self.player_lists then self.player_lists = {} end
    if not self.player_lists[player_id] then self:setupPlayer(player_id) end

    local list_config = {}
    for k, v in pairs(self.default_config) do
        list_config[k] = config[k] ~= nil and config[k] or v
    end

    list_config.x = (x or 0) * 2
    list_config.y = (y or 0) * 2
    list_config.width = (width or 240) * 2
    list_config.height = (height or 160) * 2

    list_config.backdrop = config.backdrop
    if list_config.backdrop then
        list_config.backdrop.x = (list_config.backdrop.x or 0) * 2
        list_config.backdrop.y = (list_config.backdrop.y or 0) * 2
        list_config.backdrop.width = (list_config.backdrop.width or 240) * 2
        list_config.backdrop.height = (list_config.backdrop.height or 160) * 2
        if list_config.backdrop.padding_x then list_config.backdrop.padding_x = list_config.backdrop.padding_x * 2 end
        if list_config.backdrop.padding_y then list_config.backdrop.padding_y = list_config.backdrop.padding_y * 2 end
    end

    list_config.sprites = config.sprites or {}

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

    -- Pre‑allocate assets
    for _, sprite_def in ipairs(list_config.sprites) do
        self:ensureSpriteAsset(player_id, sprite_def)
    end

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
        active_count = 0,
        finished = false,
        remove_delay_id = nil,
    }

    -- Create entry objects
    for i, def in ipairs(list_config.sprites) do
        local entry = SpriteEntry:new(list_object, player_id, list_id, i, def)
        entry.grid_x = grid_positions[i].grid_x
        entry.grid_y = grid_positions[i].grid_y
        entry.start_delay = grid_positions[i].start_delay
        list_object.entries[i] = entry
        list_object.active_count = list_object.active_count + 1

        -- Scroll distance: from grid_y to off‑screen above bounds_top
        local sprite_h = (def.height or 16) * (def.sy or def.scale or 1)
        local distance = (entry.grid_y - list_config.bounds_top) + sprite_h
        entry:startScroll(entry.start_delay, distance, list_config.scroll_speed)
    end

    -- Define methods
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

    function list_object:addSprite(sprite_def)
        print("addSprite called with", sprite_def)  -- Debug
        self.parent:ensureSpriteAsset(self.player_id, sprite_def)
        table.insert(self.config.sprites, sprite_def)
        self:_recreateEntries()
    end

    function list_object:setSprites(sprites)
        self.config.sprites = sprites or {}
        self:_recreateEntries()
    end

    function list_object:setSpeed(speed)
        self.config.scroll_speed = speed or self.parent.default_config.scroll_speed
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
        if self.remove_delay_id then end
        if self.entries then
            for _, entry in ipairs(self.entries) do
                if entry and entry.destroy then entry:destroy() end
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
        if self.entries then
            for _, entry in ipairs(self.entries) do
                if entry and entry.destroy then entry:destroy() end
            end
        end
        self.config.grid_positions = self.parent:_computeGridPositions(self.config)
        self.entries = {}
        self.active_count = 0
        for i, def in ipairs(self.config.sprites) do
            local entry = SpriteEntry:new(self, self.player_id, self.list_id, i, def)
            entry.grid_x = self.config.grid_positions[i].grid_x
            entry.grid_y = self.config.grid_positions[i].grid_y
            entry.start_delay = self.config.grid_positions[i].start_delay
            self.entries[i] = entry
            self.active_count = self.active_count + 1

            local sprite_h = (def.height or 16) * (def.sy or def.scale or 1)
            local distance = (entry.grid_y - self.config.bounds_top) + sprite_h
            entry:startScroll(entry.start_delay, distance, self.config.scroll_speed)
        end
        self.finished = false
    end

    -- Debug: confirm methods are attached
    print("List object created, addSprite type:", type(list_object.addSprite))

    self.player_lists[player_id].active_lists[list_id] = list_object
    return list_object
end

function ScrollingSpriteList:updateAll(delta) end

-- Legacy API wrappers (unchanged)
function ScrollingSpriteList:getList(player_id, list_id)
    if not self.player_lists or not self.player_lists[player_id] then return nil end
    return self.player_lists[player_id].active_lists[list_id]
end

function ScrollingSpriteList:removeScrollingList(player_id, list_id)
    local list_object = self:getList(player_id, list_id)
    if list_object then list_object:destroy() end
end

function ScrollingSpriteList:setListPosition(player_id, list_id, x, y)
    local list_object = self:getList(player_id, list_id)
    if list_object then list_object:setPosition(x, y); return true end
    return false
end

function ScrollingSpriteList:setListSpeed(player_id, list_id, speed)
    local list_object = self:getList(player_id, list_id)
    if list_object then list_object:setSpeed(speed); return true end
    return false
end

function ScrollingSpriteList:addSpriteToList(player_id, list_id, sprite_def)
    local list_object = self:getList(player_id, list_id)
    if list_object then list_object:addSprite(sprite_def); return true end
    return false
end

function ScrollingSpriteList:setListSprites(player_id, list_id, sprites)
    local list_object = self:getList(player_id, list_id)
    if list_object then list_object:setSprites(sprites); return true end
    return false
end

function ScrollingSpriteList:getListState(player_id, list_id)
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

local scrollingSpriteListSystem = setmetatable({}, ScrollingSpriteList)
scrollingSpriteListSystem:init()
return scrollingSpriteListSystem