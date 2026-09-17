-- layout_manager.lua
-- A comprehensive layout system for managing sprites, resources, and animations.
-- Integrates with Net Games framework, AnimationEngine, and sound effects.

local LayoutManager = {}
_G.LayoutManager = LayoutManager

-- Dependencies
local AnimationEngine = require("scripts/animation-engine/animation-engine")
local MathUtils = AnimationEngine.MathUtils
local AnimationSequences = require("scripts/animation-engine/animation-sequences")
local boom = require("scripts/boom/main")
-- =============================================================================
-- Caches
-- =============================================================================

-- Resources: player_id -> resource_id -> { texture_path, anim_path, anim_state,
--           state_dimensions, sprite_width, sprite_height, ... }
local resources = {}

-- Instances: player_id -> instance_id -> { resource_id, layout_id, object_id, properties }
local instances = {}

-- Layouts: player_id -> layout_id -> Layout object
local layouts = {}

-- Dirty flags: player_id -> set of layout_ids that need recomputation
local dirty_layouts = {}

-- For tick handling
local tick_registered = false

-- =============================================================================
-- Helper Functions
-- =============================================================================

-- Validate that a player has a layout with given id
local function get_layout(player_id, layout_id)
    local player_layouts = layouts[player_id]
    if not player_layouts or not player_layouts[layout_id] then
        error("Layout not found: " .. tostring(layout_id) .. " for player " .. tostring(player_id))
    end
    return player_layouts[layout_id]
end

-- Validate that a sprite exists in a layout
local function get_sprite(player_id, layout_id, object_id)
    local layout = get_layout(player_id, layout_id)
    local sprite = layout.sprites[object_id]
    if not sprite then
        error("Sprite not found: " .. tostring(object_id) .. " in layout " .. tostring(layout_id))
    end
    return sprite, layout
end

-- Allocate a sprite resource if not already allocated for the player
local function ensure_resource(player_id, resource_id, texture_path, anim_path, anim_state)
    local player_res = resources[player_id] or {}
    if not player_res[resource_id] then
        -- Provide assets to player
        Net.provide_asset_for_player(player_id, texture_path)
        if anim_path and anim_path ~= "" then
            Net.provide_asset_for_player(player_id, anim_path)
        end

        -- Allocate sprite resource
        Net.player_alloc_sprite(player_id, resource_id, {
            texture_path = texture_path,
            anim_path = anim_path or "",
            anim_state = anim_state or ""
        })

        -- Load animation data and compute dimensions per state
        local state_dimensions = {}
        local sprite_width, sprite_height = 0, 0
        if anim_path and anim_path ~= "" then
            local stripped = anim_path:gsub("/server/", "", 1)
            local animation_data = boom.load(stripped).states
            if animation_data then
                for state_name, state_data in pairs(animation_data) do
                    local frames = state_data.framelist
                    local max_w, max_h = 0, 0
                    for _, frame in ipairs(frames) do
                        if frame.w and frame.w > max_w then max_w = frame.w end
                        if frame.h and frame.h > max_h then max_h = frame.h end
                    end
                    state_dimensions[state_name] = { width = max_w, height = max_h }
                end
                -- Store dimensions for the initial state
                if state_dimensions[anim_state] then
                    sprite_width = state_dimensions[anim_state].width
                    sprite_height = state_dimensions[anim_state].height
                end
            end
        end

        player_res[resource_id] = {
            texture_path = texture_path,
            anim_path = anim_path,
            anim_state = anim_state,
            state_dimensions = state_dimensions,
            sprite_width = sprite_width,
            sprite_height = sprite_height,
        }
        resources[player_id] = player_res
    end
    return resources[player_id][resource_id]
end

-- Create or update a sprite instance
local function update_sprite_instance(player_id, instance_id, resource_id, properties, layout_properties)
    -- Ensure resource exists (should already be allocated)
    local resource = resources[player_id] and resources[player_id][resource_id]
    if not resource then
        error("Resource not allocated: " .. resource_id)
    end

    -- Compute final properties: start with sprite's own properties
    local final = {}
    for k, v in pairs(properties) do
        final[k] = v
    end

    -- Apply layout global properties if provided
    if layout_properties then
        -- Scale: relative vs absolute
        if layout_properties.scale then
            if layout_properties.scale.mode == "relative" then
                final.sx = (final.sx or 1) * layout_properties.scale.value
                final.sy = (final.sy or 1) * layout_properties.scale.value
            else -- absolute
                final.sx = layout_properties.scale.value
                final.sy = layout_properties.scale.value
            end
        end
        -- Rotation
        if layout_properties.rotation then
            if layout_properties.rotation.mode == "relative" then
                final.ro = (final.ro or 0) + layout_properties.rotation.value
            else
                final.ro = layout_properties.rotation.value
            end
        end
        -- Opacity
        if layout_properties.opacity then
            if layout_properties.opacity.mode == "relative" then
                final.opacity = (final.opacity or 255) * (layout_properties.opacity.value / 255)
            else
                final.opacity = layout_properties.opacity.value
            end
            final.opacity = math.max(0, math.min(255, final.opacity))
        end
        -- Color
        if layout_properties.color then
            local color = layout_properties.color
            if color.mode == "relative" then
                final.r = (final.r or 255) * (color.value.r / 255)
                final.g = (final.g or 255) * (color.value.g / 255)
                final.b = (final.b or 255) * (color.value.b / 255)
            else
                final.r = color.value.r
                final.g = color.value.g
                final.b = color.value.b
            end
            -- Clamp colors to 0-255
            final.r = math.max(0, math.min(255, final.r))
            final.g = math.max(0, math.min(255, final.g))
            final.b = math.max(0, math.min(255, final.b))
        end
        -- Z (optional, can be relative or absolute)
        if layout_properties.z then
            if layout_properties.z.mode == "relative" then
                final.z = (final.z or 0) + layout_properties.z.value
            else
                final.z = layout_properties.z.value
            end
        end
    end

    -- Draw the sprite (if instance already exists, this updates it)
    Net.player_draw_sprite(player_id, resource_id, {
        id = instance_id,
        x = final.x or 0,
        y = final.y or 0,
        z = final.z or 0,
        sx = final.sx or 1,
        sy = final.sy or 1,
        ro = final.ro or 0,
        ox = final.ox or 0,
        oy = final.oy or 0,
        a = final.a or 255,
        r = final.r or 255,
        g = final.g or 255,
        b = final.b or 255,
        color_mode = final.color_mode or 0,
        anim_state = final.anim_state or resource.anim_state,
        opacity = final.opacity or 255,
    })
end

-- Remove a sprite instance
local function remove_sprite_instance(player_id, instance_id)
    Net.player_erase_sprite(player_id, instance_id)
end

-- Compute the position of a sprite based on layout mode and index
local function compute_position(layout, index, use_order)
    local mode = layout.mode
    local opts = layout.options
    local pos_x, pos_y = 0, 0
    local row, col

    -- Determine total number of sprites in the order list
    local total = #layout.order

    if mode == "grid" then
        local cols = opts.columns
        local rows = opts.rows
        if not cols and rows then
            cols = math.ceil(total / rows)
        elseif not rows and cols then
            rows = math.ceil(total / cols)
        elseif not rows and not cols then
            cols = total
            rows = 1
        end
        col = (index - 1) % cols
        row = math.floor((index - 1) / cols)
        pos_x = col * (opts.spacing_x or 0)
        pos_y = row * (opts.spacing_y or 0)
    elseif mode == "horizontal" then
        pos_x = (index - 1) * (opts.spacing_x or 0)
        pos_y = 0
    elseif mode == "vertical" then
        pos_x = 0
        pos_y = (index - 1) * (opts.spacing_y or 0)
    elseif mode == "radial" then
        local radius = opts.radius or 100
        local angle_step = (math.pi * 2) / total
        local angle = (index - 1) * angle_step
        pos_x = math.cos(angle) * radius
        pos_y = math.sin(angle) * radius
    elseif mode == "honeycomb" then
        local hex_width = opts.spacing_x or 64
        local hex_height = opts.spacing_y or 32
        local offset_x = opts.offset_x or 0
        local offset_y = opts.offset_y or 0
        col = (index - 1) % opts.columns
        row = math.floor((index - 1) / opts.columns)
        pos_x = col * hex_width + (row % 2 == 0 and 0 or hex_width/2)
        pos_y = row * hex_height
        pos_x = pos_x + offset_x
        pos_y = pos_y + offset_y
    elseif mode == "stacked" then
        local offset_x = opts.offset_x or 0
        local offset_y = opts.offset_y or 0
        pos_x = (index - 1) * offset_x
        pos_y = (index - 1) * offset_y
    else
        error("Unsupported layout mode: " .. tostring(mode))
    end

    -- Apply any base offset from layout
    pos_x = pos_x + (layout.origin_x or 0)
    pos_y = pos_y + (layout.origin_y or 0)

    return pos_x, pos_y
end

-- Recompute positions for all sprites in a layout and update instances
local function recompute_layout(layout)
    local player_id = layout.player_id
    local layout_id = layout.id

    -- If we have a viewport offset, apply it after all calculations
    local viewport_x = layout.options.viewport_offset and layout.options.viewport_offset.x or 0
    local viewport_y = layout.options.viewport_offset and layout.options.viewport_offset.y or 0

    for idx, object_id in ipairs(layout.order) do
        local sprite = layout.sprites[object_id]
        if sprite then
            -- Compute base position
            local base_x, base_y = compute_position(layout, idx)

            -- Apply viewport offset (if scrolling)
            base_x = base_x - viewport_x
            base_y = base_y - viewport_y

            -- Store base position in sprite.properties (for future reference)
            sprite.properties.x = base_x
            sprite.properties.y = base_y

            -- Update instance
            update_sprite_instance(player_id, sprite.instance_id, sprite.resource_id, sprite.properties, layout.global_properties)
        else
            -- Remove stale entry from order list
            table.remove(layout.order, idx)
            idx = idx - 1
        end
    end
end

-- Mark a layout as dirty so it will be recomputed on next tick
local function mark_dirty(player_id, layout_id)
    local player_dirty = dirty_layouts[player_id] or {}
    player_dirty[layout_id] = true
    dirty_layouts[player_id] = player_dirty
end

-- Process all dirty layouts
local function process_dirty_layouts()
    for player_id, player_dirty in pairs(dirty_layouts) do
        for layout_id, _ in pairs(player_dirty) do
            local layout = layouts[player_id] and layouts[player_id][layout_id]
            if layout and not layout.suppress_dirty then
                recompute_layout(layout)
            end
        end
        dirty_layouts[player_id] = nil
    end
end

-- =============================================================================
-- Public API
-- =============================================================================

-- Create a new layout for a player
function LayoutManager.create_layout(player_id, layout_id, options)
    options = options or {}
    local player_layouts = layouts[player_id] or {}
    if player_layouts[layout_id] then
        error("Layout already exists: " .. tostring(layout_id))
    end

    local layout = {
        id = layout_id,
        player_id = player_id,
        mode = options.mode or "grid",
        options = {
            rows = options.rows,
            columns = options.columns,
            spacing_x = options.spacing_x or 0,
            spacing_y = options.spacing_y or 0,
            stagger = options.stagger,
            wrap = options.wrap,
            restrict_to_bounds = options.restrict_to_bounds or false,
            scrollable = options.scrollable or false,
            viewport_offset = options.viewport_offset or { x = 0, y = 0 },
            radius = options.radius,
            offset_x = options.offset_x,
            offset_y = options.offset_y,
        },
        global_properties = {
            scale = { value = options.global_scale or 1, mode = options.global_scale_mode or "relative" },
            rotation = { value = options.global_rotation or 0, mode = options.global_rotation_mode or "relative" },
            opacity = { value = options.global_opacity or 255, mode = options.global_opacity_mode or "relative" },
            color = { value = options.global_color or { r=255, g=255, b=255 }, mode = options.global_color_mode or "relative" },
            z = { value = options.global_z or 0, mode = options.global_z_mode or "relative" },
        },
        sprites = {},
        order = {},
        origin_x = options.origin_x or 0,
        origin_y = options.origin_y or 0,
        suppress_dirty = false, -- when set to true, dirty flag won't cause recompute
    }

    player_layouts[layout_id] = layout
    layouts[player_id] = player_layouts

    mark_dirty(player_id, layout_id)
    return layout
end

-- Add a sprite to a layout
function LayoutManager.add_sprite(player_id, layout_id, resource_id, object_id, properties)
    local layout = get_layout(player_id, layout_id)
    if layout.sprites[object_id] then
        error("Sprite with object_id " .. tostring(object_id) .. " already exists in layout")
    end

    -- Ensure resource is allocated
    local texture_path = properties.texture_path
    local anim_path = properties.anim_path
    local anim_state = properties.anim_state
    if not texture_path then
        error("Missing texture_path for sprite")
    end
    local resource = ensure_resource(player_id, resource_id, texture_path, anim_path, anim_state)

    -- Create instance ID
    local instance_id = resource_id .. "_" .. layout_id .. "_" .. object_id

    -- Determine initial dimensions based on animation state
    local current_state = anim_state or resource.anim_state
    local dims = resource.state_dimensions[current_state]
    local sprite_width = dims and dims.width or 0
    local sprite_height = dims and dims.height or 0

    -- Build sprite properties (defaults)
    local sprite_props = {
        x = properties.x or 0,
        y = properties.y or 0,
        z = properties.z or 0,
        sx = properties.sx or 1,
        sy = properties.sy or 1,
        ro = properties.ro or 0,
        ox = properties.ox or 0,
        oy = properties.oy or 0,
        a = properties.a or 255,
        r = properties.r or 255,
        g = properties.g or 255,
        b = properties.b or 255,
        color_mode = properties.color_mode or 0,
        anim_state = current_state,
        opacity = properties.opacity or 255,
        sprite_width = sprite_width,
        sprite_height = sprite_height,
    }

    -- Store sprite data
    local sprite_data = {
        resource_id = resource_id,
        object_id = object_id,
        instance_id = instance_id,
        properties = sprite_props,
    }
    layout.sprites[object_id] = sprite_data
    table.insert(layout.order, object_id)

    -- Mark layout as dirty so positions are recomputed
    mark_dirty(player_id, layout_id)

    -- Play optional sound on add
    if properties.sound_on_add then
        Net.play_sound_for_player(player_id, properties.sound_on_add)
    end
end

-- Remove a sprite from a layout
function LayoutManager.remove_sprite(player_id, layout_id, object_id, properties)
    local sprite, layout = get_sprite(player_id, layout_id, object_id)
    remove_sprite_instance(player_id, sprite.instance_id)
    layout.sprites[object_id] = nil
    -- Remove from order list
    for i, obj_id in ipairs(layout.order) do
        if obj_id == object_id then
            table.remove(layout.order, i)
            break
        end
    end
    mark_dirty(player_id, layout_id)
    if properties and properties.sound_on_remove then
        Net.play_sound_for_player(player_id, properties.sound_on_remove)
    end
end

-- Remove an entire layout (and all its sprites)
function LayoutManager.remove_layout(player_id, layout_id)
    local layout = get_layout(player_id, layout_id)
    for _, sprite in pairs(layout.sprites) do
        remove_sprite_instance(player_id, sprite.instance_id)
    end
    layouts[player_id][layout_id] = nil
    if dirty_layouts[player_id] then
        dirty_layouts[player_id][layout_id] = nil
    end
end

-- Arrange layout (recompute positions) immediately
function LayoutManager.arrange_layout(player_id, layout_id)
    local layout = get_layout(player_id, layout_id)
    recompute_layout(layout)
end

-- Set a global property on the layout (with optional animation)
function LayoutManager.set_layout_property(player_id, layout_id, property, value, mode, duration, easing, sound)
    local layout = get_layout(player_id, layout_id)
    local prop = layout.global_properties[property]
    if not prop then
        error("Unknown global property: " .. tostring(property))
    end
    local old_value = prop.value
    local old_mode = prop.mode
    prop.value = value
    prop.mode = mode or prop.mode

    if duration and duration > 0 then
        -- Animate the property using AnimationEngine
        local target = { value = value }
        local start = { value = old_value }
        local anim_id = AnimationEngine.animate(start, target, duration, {
            easing = easing or "linear",
            on_update = function(values)
                prop.value = values.value
                mark_dirty(player_id, layout_id)
            end,
            on_complete = function()
                if sound then
                    Net.play_sound_for_player(player_id, sound)
                end
            end
        })
        return anim_id
    else
        mark_dirty(player_id, layout_id)
        if sound then
            Net.play_sound_for_player(player_id, sound)
        end
        return nil
    end
end

-- Set a property on a specific sprite
function LayoutManager.set_sprite_property(player_id, layout_id, object_id, property, value, mode, duration, easing, sound)
    local sprite, layout = get_sprite(player_id, layout_id, object_id)
    local old_value = sprite.properties[property]

    -- If property is anim_state, update dimensions immediately (or after animation)
    if property == "anim_state" then
        local resource = resources[player_id] and resources[player_id][sprite.resource_id]
        if resource and resource.state_dimensions[value] then
            sprite.properties.sprite_width = resource.state_dimensions[value].width
            sprite.properties.sprite_height = resource.state_dimensions[value].height
        end
    end

    sprite.properties[property] = value

    if duration and duration > 0 then
        local start = {}
        start[property] = old_value
        local target = {}
        target[property] = value

        -- Determine if property should be treated as discrete (non‑numeric)
        local discrete = {}
        if type(value) ~= "number" then
            table.insert(discrete, property)
        end

        local anim_id = AnimationEngine.animate(start, target, duration, {
            easing = easing or "linear",
            discrete = discrete,
            on_update = function(values)
                sprite.properties[property] = values[property]
                -- If property is anim_state, dimensions already updated; just ensure they are correct
                if property == "anim_state" then
                    local resource = resources[player_id] and resources[player_id][sprite.resource_id]
                    if resource and resource.state_dimensions[values[property]] then
                        sprite.properties.sprite_width = resource.state_dimensions[values[property]].width
                        sprite.properties.sprite_height = resource.state_dimensions[values[property]].height
                    end
                end
                update_sprite_instance(player_id, sprite.instance_id, sprite.resource_id, sprite.properties, layout.global_properties)
            end,
            on_complete = function()
                if sound then
                    Net.play_sound_for_player(player_id, sound)
                end
            end
        })
        return anim_id
    else
        update_sprite_instance(player_id, sprite.instance_id, sprite.resource_id, sprite.properties, layout.global_properties)
        if sound then
            Net.play_sound_for_player(player_id, sound)
        end
        return nil
    end
end

-- Get a proxy object for a sprite (to be used with AnimationEngine.tween)
function LayoutManager.get_sprite_proxy(player_id, layout_id, object_id)
    local sprite, layout = get_sprite(player_id, layout_id, object_id)
    local proxy = {}

    -- Define getters and setters for common properties
    local properties = { "x", "y", "z", "sx", "sy", "ro", "ox", "oy", "a", "r", "g", "b", "opacity", "anim_state" }
    for _, prop in ipairs(properties) do
        proxy["get" .. prop:sub(1,1):upper() .. prop:sub(2)] = function()
            return sprite.properties[prop]
        end
        proxy["set" .. prop:sub(1,1):upper() .. prop:sub(2)] = function(self, value)
            LayoutManager.set_sprite_property(player_id, layout_id, object_id, prop, value, "absolute", 0)
        end
    end

    -- Also allow direct field access for convenience
    proxy._sprite = sprite
    proxy._layout = layout
    proxy._player_id = player_id
    proxy._layout_id = layout_id
    proxy._object_id = object_id

    return proxy
end

-- Animate a layout property using AnimationEngine.tween (convenience)
function LayoutManager.animate_layout_property(player_id, layout_id, property, target, duration, options)
    local layout = get_layout(player_id, layout_id)
    local prop = layout.global_properties[property]
    if not prop then
        error("Unknown global property: " .. tostring(property))
    end
    local start = { value = prop.value }
    local target_tbl = { value = target }
    return AnimationEngine.animate(start, target_tbl, duration, {
        easing = options and options.easing or "linear",
        tag = options and options.tag,
        on_update = function(values)
            prop.value = values.value
            mark_dirty(player_id, layout_id)
        end,
        on_complete = options and options.on_complete,
    })
end

-- Animate a sprite property using AnimationEngine.tween
function LayoutManager.animate_sprite_property(player_id, layout_id, object_id, property, target, duration, options)
    local sprite, layout = get_sprite(player_id, layout_id, object_id)
    local start = {}
    start[property] = sprite.properties[property]
    local target_tbl = {}
    target_tbl[property] = target

    -- Determine if property should be discrete (non‑numeric)
    local discrete = options and options.discrete or {}
    if type(target) ~= "number" then
        table.insert(discrete, property)
    end

    return AnimationEngine.animate(start, target_tbl, duration, {
        easing = options and options.easing or "linear",
        tag = options and options.tag,
        discrete = discrete,
        on_update = function(values)
            sprite.properties[property] = values[property]
            -- If property is anim_state, update dimensions
            if property == "anim_state" then
                local resource = resources[player_id] and resources[player_id][sprite.resource_id]
                if resource and resource.state_dimensions[values[property]] then
                    sprite.properties.sprite_width = resource.state_dimensions[values[property]].width
                    sprite.properties.sprite_height = resource.state_dimensions[values[property]].height
                end
            end
            update_sprite_instance(player_id, sprite.instance_id, sprite.resource_id, sprite.properties, layout.global_properties)
        end,
        on_complete = options and options.on_complete,
    })
end

-- =============================================================================
-- Reordering and Swapping Methods (non‑animated)
-- =============================================================================

-- Reorder a sprite to a new position (index) in the layout's ordering.
-- The layout's arrangement order is based on the order in which sprites were added.
-- This function changes that order without affecting existing sprite properties.
function LayoutManager.reorder_sprite(player_id, layout_id, object_id, new_index)
    local layout = get_layout(player_id, layout_id)
    local sprite = layout.sprites[object_id]
    if not sprite then
        error("Sprite not found: " .. tostring(object_id))
    end

    -- Find current index
    local current_index = nil
    for i, obj_id in ipairs(layout.order) do
        if obj_id == object_id then
            current_index = i
            break
        end
    end
    if not current_index then
        error("Sprite not in order list")
    end

    -- Validate new_index
    if new_index < 1 or new_index > #layout.order then
        error("Invalid index: " .. tostring(new_index))
    end

    -- Remove and insert
    table.remove(layout.order, current_index)
    table.insert(layout.order, new_index, object_id)

    -- Mark layout dirty to recompute positions
    mark_dirty(player_id, layout_id)
end

-- Swap the positions of two sprites in the layout (by object_id).
-- This swaps their order and optionally swaps their stored properties.
function LayoutManager.swap_sprites(player_id, layout_id, object_id_a, object_id_b, swap_properties)
    local layout = get_layout(player_id, layout_id)
    local sprite_a = layout.sprites[object_id_a]
    local sprite_b = layout.sprites[object_id_b]
    if not sprite_a or not sprite_b then
        error("One or both sprites not found")
    end

    if swap_properties then
        -- Swap the properties tables
        local temp_props = sprite_a.properties
        sprite_a.properties = sprite_b.properties
        sprite_b.properties = temp_props
    end

    -- Swap in order list
    local idx_a, idx_b
    for i, obj_id in ipairs(layout.order) do
        if obj_id == object_id_a then idx_a = i end
        if obj_id == object_id_b then idx_b = i end
    end
    if idx_a and idx_b then
        layout.order[idx_a], layout.order[idx_b] = layout.order[idx_b], layout.order[idx_a]
    end

    mark_dirty(player_id, layout_id)
end

-- Move a sprite to a new position (object_id) within the layout, inserting before another sprite.
function LayoutManager.move_sprite_before(player_id, layout_id, object_id_to_move, reference_object_id)
    local layout = get_layout(player_id, layout_id)
    local sprite_to_move = layout.sprites[object_id_to_move]
    local ref_sprite = layout.sprites[reference_object_id]
    if not sprite_to_move or not ref_sprite then
        error("One or both sprites not found")
    end

    -- Find indices
    local move_idx, ref_idx
    for i, obj_id in ipairs(layout.order) do
        if obj_id == object_id_to_move then move_idx = i end
        if obj_id == reference_object_id then ref_idx = i end
    end
    if not move_idx or not ref_idx then
        error("Indices not found")
    end

    -- Remove moving sprite
    table.remove(layout.order, move_idx)
    -- Adjust ref_idx if needed (if move_idx was before ref_idx, ref_idx shifts left)
    if move_idx < ref_idx then ref_idx = ref_idx - 1 end
    -- Insert before reference
    table.insert(layout.order, ref_idx, object_id_to_move)

    mark_dirty(player_id, layout_id)
end

-- Move a sprite to a new position (object_id) within the layout, inserting after another sprite.
function LayoutManager.move_sprite_after(player_id, layout_id, object_id_to_move, reference_object_id)
    local layout = get_layout(player_id, layout_id)
    local sprite_to_move = layout.sprites[object_id_to_move]
    local ref_sprite = layout.sprites[reference_object_id]
    if not sprite_to_move or not ref_sprite then
        error("One or both sprites not found")
    end

    -- Find indices
    local move_idx, ref_idx
    for i, obj_id in ipairs(layout.order) do
        if obj_id == object_id_to_move then move_idx = i end
        if obj_id == reference_object_id then ref_idx = i end
    end
    if not move_idx or not ref_idx then
        error("Indices not found")
    end

    -- Remove moving sprite
    table.remove(layout.order, move_idx)
    -- Adjust ref_idx if needed (if move_idx was before ref_idx, ref_idx shifts left)
    if move_idx < ref_idx then ref_idx = ref_idx - 1 end
    -- Insert after reference
    table.insert(layout.order, ref_idx + 1, object_id_to_move)

    mark_dirty(player_id, layout_id)
end

-- =============================================================================
-- Animated Operations
-- =============================================================================

-- Helper: capture current positions of sprites in a layout
local function capture_positions(layout)
    local positions = {}
    for obj_id, sprite in pairs(layout.sprites) do
        positions[obj_id] = { x = sprite.properties.x or 0, y = sprite.properties.y or 0 }
    end
    return positions
end

-- Helper: apply positions to sprites (updates properties and redraws)
local function apply_positions(layout, positions)
    for obj_id, pos in pairs(positions) do
        local sprite = layout.sprites[obj_id]
        if sprite then
            sprite.properties.x = pos.x
            sprite.properties.y = pos.y
            update_sprite_instance(layout.player_id, sprite.instance_id, sprite.resource_id, sprite.properties, layout.global_properties)
        end
    end
end

-- Helper: compute final positions after a structural change (without modifying layout)
local function compute_final_positions(layout, new_order)
    local positions = {}
    for idx, obj_id in ipairs(new_order) do
        local base_x, base_y = compute_position(layout, idx)
        positions[obj_id] = { x = base_x, y = base_y }
    end
    return positions
end

-- Helper: animate sprites from old positions to new positions
local function animate_sprites_to_positions(layout, old_positions, new_positions, duration, easing, on_complete)
    if not old_positions or not new_positions then
        if on_complete then on_complete() end
        return
    end
    local remaining = 0
    for obj_id, new_pos in pairs(new_positions) do
        local sprite = layout.sprites[obj_id]
        if sprite then
            local old_pos = old_positions[obj_id]
            if old_pos then
                remaining = remaining + 1
                local proxy = LayoutManager.get_sprite_proxy(layout.player_id, layout.id, obj_id)
                AnimationEngine.tween(proxy, { x = new_pos.x, y = new_pos.y }, duration, {
                    easing = easing or "ease_out_quad",
                    on_complete = function()
                        remaining = remaining - 1
                        if remaining == 0 and on_complete then on_complete() end
                    end
                })
            else
                -- Sprite was added: no old position, set directly
                sprite.properties.x = new_pos.x
                sprite.properties.y = new_pos.y
                update_sprite_instance(layout.player_id, sprite.instance_id, sprite.resource_id, sprite.properties, layout.global_properties)
            end
        end
    end
    -- If no sprites to animate, call on_complete immediately
    if remaining == 0 and on_complete then on_complete() end
end

-- Add a sprite with an entrance animation
function LayoutManager.add_sprite_animated(player_id, layout_id, resource_id, object_id, properties, anim_options)
    local layout = get_layout(player_id, layout_id)
    if layout.sprites[object_id] then
        error("Sprite with object_id " .. tostring(object_id) .. " already exists in layout")
    end

    anim_options = anim_options or {}
    local duration = anim_options.duration or 0.3
    local easing = anim_options.easing or "ease_out_quad"
    local anim_type = anim_options.type or "slide" -- "slide", "fade", "summon", "scale", "bounce"
    local sound = anim_options.sound
    local on_complete = anim_options.on_complete

    -- Temporarily suppress dirty processing to avoid immediate recompute
    layout.suppress_dirty = true

    -- First, add the sprite normally (will be placed at its final position in the order)
    LayoutManager.add_sprite(player_id, layout_id, resource_id, object_id, properties)

    -- Compute the final position of this sprite
    local final_x, final_y = compute_position(layout, #layout.order)

    -- Create a proxy for the sprite
    local proxy = LayoutManager.get_sprite_proxy(player_id, layout_id, object_id)

    -- Determine start position/state based on animation type
    local start_x, start_y, start_scale, start_opacity
    if anim_type == "slide" then
        local direction = anim_options.direction or "from_bottom"
        if direction == "from_top" then
            start_x, start_y = final_x, final_y - 100
        elseif direction == "from_bottom" then
            start_x, start_y = final_x, final_y + 100
        elseif direction == "from_left" then
            start_x, start_y = final_x - 100, final_y
        elseif direction == "from_right" then
            start_x, start_y = final_x + 100, final_y
        else
            start_x, start_y = final_x, final_y - 100 -- default top
        end
        start_scale = proxy.getScale()
        start_opacity = proxy.getOpacity()
    elseif anim_type == "fade" then
        start_x, start_y = final_x, final_y
        start_scale = proxy.getScale()
        start_opacity = 0
    elseif anim_type == "scale" then
        start_x, start_y = final_x, final_y
        start_scale = 0
        start_opacity = proxy.getOpacity()
    elseif anim_type == "summon" then
        -- Use AnimationSequences.summon for more complex effect
        start_x, start_y = final_x, final_y - 100
        start_scale = 0
        start_opacity = 0
    else -- default slide
        start_x, start_y = final_x, final_y - 100
        start_scale = proxy.getScale()
        start_opacity = proxy.getOpacity()
    end

    -- Set initial state (if needed)
    if start_x ~= final_x or start_y ~= final_y then
        proxy.setX(start_x)
        proxy.setY(start_y)
    end
    if start_scale and start_scale ~= proxy.getScale() then
        proxy.setScale(start_scale)
    end
    if start_opacity and start_opacity ~= proxy.getOpacity() then
        proxy.setOpacity(start_opacity)
    end

    -- Play sound if provided
    if sound then
        Net.play_sound_for_player(player_id, sound)
    end

    -- Perform animation
    local anim_id
    if anim_type == "summon" then
        -- Use AnimationSequences.summon
        anim_id = AnimationSequences.summon(proxy, start_x, start_y, start_scale or 1, final_x, final_y, proxy.getScale(), {
            duration = duration,
            easing = easing,
            on_complete = function()
                layout.suppress_dirty = false
                mark_dirty(player_id, layout_id)
                if on_complete then on_complete() end
            end
        })
    else
        -- Generic tween to final values
        local target = {}
        if start_x ~= final_x or start_y ~= final_y then
            target.x = final_x
            target.y = final_y
        end
        if start_scale and start_scale ~= proxy.getScale() then
            target.scale = proxy.getScale()
        end
        if start_opacity and start_opacity ~= proxy.getOpacity() then
            target.opacity = proxy.getOpacity()
        end
        if next(target) then
            anim_id = AnimationEngine.tween(proxy, target, duration, {
                easing = easing,
                on_complete = function()
                    layout.suppress_dirty = false
                    mark_dirty(player_id, layout_id)
                    if on_complete then on_complete() end
                end
            })
        else
            layout.suppress_dirty = false
            mark_dirty(player_id, layout_id)
            if on_complete then on_complete() end
            return nil
        end
    end

    return anim_id
end

-- Remove a sprite with an exit animation
function LayoutManager.remove_sprite_animated(player_id, layout_id, object_id, anim_options)
    local sprite, layout = get_sprite(player_id, layout_id, object_id)
    anim_options = anim_options or {}
    local duration = anim_options.duration or 0.3
    local easing = anim_options.easing or "ease_in_quad"
    local anim_type = anim_options.type or "fade" -- "fade", "slide", "scale", "shrink"
    local sound = anim_options.sound
    local on_complete = anim_options.on_complete

    -- Temporarily suppress dirty processing
    layout.suppress_dirty = true

    local proxy = LayoutManager.get_sprite_proxy(player_id, layout_id, object_id)

    -- Determine exit target based on animation type
    local target_x, target_y, target_scale, target_opacity
    if anim_type == "slide" then
        local direction = anim_options.direction or "to_bottom"
        if direction == "to_top" then
            target_x, target_y = proxy.getX(), proxy.getY() - 100
        elseif direction == "to_bottom" then
            target_x, target_y = proxy.getX(), proxy.getY() + 100
        elseif direction == "to_left" then
            target_x, target_y = proxy.getX() - 100, proxy.getY()
        elseif direction == "to_right" then
            target_x, target_y = proxy.getX() + 100, proxy.getY()
        else
            target_x, target_y = proxy.getX(), proxy.getY() + 100 -- default bottom
        end
        target_scale = proxy.getScale()
        target_opacity = proxy.getOpacity()
    elseif anim_type == "fade" then
        target_x, target_y = proxy.getX(), proxy.getY()
        target_scale = proxy.getScale()
        target_opacity = 0
    elseif anim_type == "scale" or anim_type == "shrink" then
        target_x, target_y = proxy.getX(), proxy.getY()
        target_scale = 0
        target_opacity = proxy.getOpacity()
    else -- default fade
        target_x, target_y = proxy.getX(), proxy.getY()
        target_scale = proxy.getScale()
        target_opacity = 0
    end

    -- Play sound if provided
    if sound then
        Net.play_sound_for_player(player_id, sound)
    end

    -- Animate
    local target = {}
    if target_x ~= proxy.getX() or target_y ~= proxy.getY() then
        target.x = target_x
        target.y = target_y
    end
    if target_scale ~= proxy.getScale() then
        target.scale = target_scale
    end
    if target_opacity ~= proxy.getOpacity() then
        target.opacity = target_opacity
    end

    local anim_id
    if next(target) then
        anim_id = AnimationEngine.tween(proxy, target, duration, {
            easing = easing,
            on_complete = function()
                -- Remove the sprite after animation
                LayoutManager.remove_sprite(player_id, layout_id, object_id)
                layout.suppress_dirty = false
                mark_dirty(player_id, layout_id)
                if on_complete then on_complete() end
            end
        })
    else
        -- No animation needed, just remove
        LayoutManager.remove_sprite(player_id, layout_id, object_id)
        layout.suppress_dirty = false
        mark_dirty(player_id, layout_id)
        if on_complete then on_complete() end
        return nil
    end

    return anim_id
end

-- Swap sprites with animation
function LayoutManager.swap_sprites_animated(player_id, layout_id, object_id_a, object_id_b, swap_properties, anim_options)
    local layout = get_layout(player_id, layout_id)
    local sprite_a = layout.sprites[object_id_a]
    local sprite_b = layout.sprites[object_id_b]
    if not sprite_a or not sprite_b then
        error("One or both sprites not found")
    end

    anim_options = anim_options or {}
    local duration = anim_options.duration or 0.3
    local easing = anim_options.easing or "ease_out_quad"
    local sound = anim_options.sound
    local on_complete = anim_options.on_complete

    -- Capture current positions
    local old_positions = capture_positions(layout)

    -- Perform the swap (non‑animated) – this changes layout.order and optionally properties
    LayoutManager.swap_sprites(player_id, layout_id, object_id_a, object_id_b, swap_properties)

    -- Compute new positions after swap
    local new_positions = compute_final_positions(layout, layout.order)

    -- Temporarily suppress dirty processing
    layout.suppress_dirty = true

    -- Animate sprites from old to new positions
    animate_sprites_to_positions(layout, old_positions, new_positions, duration, easing, function()
        layout.suppress_dirty = false
        mark_dirty(player_id, layout_id)
        if on_complete then on_complete() end
    end)
end

-- Reorder sprite with animation
function LayoutManager.reorder_sprite_animated(player_id, layout_id, object_id, new_index, anim_options)
    local layout = get_layout(player_id, layout_id)
    local sprite = layout.sprites[object_id]
    if not sprite then
        error("Sprite not found: " .. tostring(object_id))
    end

    anim_options = anim_options or {}
    local duration = anim_options.duration or 0.3
    local easing = anim_options.easing or "ease_out_quad"
    local sound = anim_options.sound
    local on_complete = anim_options.on_complete

    -- Capture current positions
    local old_positions = capture_positions(layout)

    -- Perform the reorder (non‑animated)
    LayoutManager.reorder_sprite(player_id, layout_id, object_id, new_index)

    -- Compute new positions after reorder
    local new_positions = compute_final_positions(layout, layout.order)

    -- Temporarily suppress dirty processing
    layout.suppress_dirty = true

    -- Animate sprites from old to new positions
    animate_sprites_to_positions(layout, old_positions, new_positions, duration, easing, function()
        layout.suppress_dirty = false
        mark_dirty(player_id, layout_id)
        if on_complete then on_complete() end
    end)
end

-- Move sprite before another with animation
function LayoutManager.move_sprite_before_animated(player_id, layout_id, object_id_to_move, reference_object_id, anim_options)
    local layout = get_layout(player_id, layout_id)
    local sprite_to_move = layout.sprites[object_id_to_move]
    local ref_sprite = layout.sprites[reference_object_id]
    if not sprite_to_move or not ref_sprite then
        error("One or both sprites not found")
    end

    anim_options = anim_options or {}
    local duration = anim_options.duration or 0.3
    local easing = anim_options.easing or "ease_out_quad"
    local sound = anim_options.sound
    local on_complete = anim_options.on_complete

    -- Capture current positions
    local old_positions = capture_positions(layout)

    -- Perform the move (non‑animated)
    LayoutManager.move_sprite_before(player_id, layout_id, object_id_to_move, reference_object_id)

    -- Compute new positions after move
    local new_positions = compute_final_positions(layout, layout.order)

    -- Temporarily suppress dirty processing
    layout.suppress_dirty = true

    -- Animate sprites from old to new positions
    animate_sprites_to_positions(layout, old_positions, new_positions, duration, easing, function()
        layout.suppress_dirty = false
        mark_dirty(player_id, layout_id)
        if on_complete then on_complete() end
    end)
end

-- Move sprite after another with animation
function LayoutManager.move_sprite_after_animated(player_id, layout_id, object_id_to_move, reference_object_id, anim_options)
    local layout = get_layout(player_id, layout_id)
    local sprite_to_move = layout.sprites[object_id_to_move]
    local ref_sprite = layout.sprites[reference_object_id]
    if not sprite_to_move or not ref_sprite then
        error("One or both sprites not found")
    end

    anim_options = anim_options or {}
    local duration = anim_options.duration or 0.3
    local easing = anim_options.easing or "ease_out_quad"
    local sound = anim_options.sound
    local on_complete = anim_options.on_complete

    -- Capture current positions
    local old_positions = capture_positions(layout)

    -- Perform the move (non‑animated)
    LayoutManager.move_sprite_after(player_id, layout_id, object_id_to_move, reference_object_id)

    -- Compute new positions after move
    local new_positions = compute_final_positions(layout, layout.order)

    -- Temporarily suppress dirty processing
    layout.suppress_dirty = true

    -- Animate sprites from old to new positions
    animate_sprites_to_positions(layout, old_positions, new_positions, duration, easing, function()
        layout.suppress_dirty = false
        mark_dirty(player_id, layout_id)
        if on_complete then on_complete() end
    end)
end

-- =============================================================================
-- Tick handler and cleanup
-- =============================================================================

-- Tick handler to process dirty layouts
function LayoutManager.on_tick(delta_time)
    process_dirty_layouts()
end

-- Register tick handler if not already done
if not tick_registered then
    Net:on("tick", function(event)
        LayoutManager.on_tick(event.delta_time)
    end)
    tick_registered = true
end

-- Clear all data for a player (on disconnect)
function LayoutManager.clear_player(player_id)
    if layouts[player_id] then
        for layout_id, layout in pairs(layouts[player_id]) do
            for _, sprite in pairs(layout.sprites) do
                remove_sprite_instance(player_id, sprite.instance_id)
            end
        end
    end
    resources[player_id] = nil
    instances[player_id] = nil
    layouts[player_id] = nil
    if dirty_layouts[player_id] then
        dirty_layouts[player_id] = nil
    end
end

return LayoutManager