-- scripts/displayer/sliced-sprite.lua
--
-- Reusable 3-slice, configurable 5-slice, and 9-slice sprite rendering.
--
-- This module only relies on sprite fields already used/documented in this
-- server source and on scripts/boom/main for reading .animation files.
--
-- IMPORTANT:
--   Net.player_draw_sprite has no source-rectangle / UV / crop fields here.
--   A slice therefore has to be either:
--     1) its own texture, with explicit width/height metadata, or
--     2) an animation state whose frame selects the rectangle from an atlas.
--
-- Coordinates and target sizes in this module are raw Net screen pixels
-- (the same coordinate space passed directly to Net.player_draw_sprite).

local boom = require("scripts/boom/main")

local SlicedSprite = {}

local animation_cache = {}
local players = {}
local next_asset_id = 0

local NINE_ORDER = {
    "top_left", "top", "top_right",
    "left", "center", "right",
    "bottom_left", "bottom", "bottom_right",
}

local function round(value)
    value = tonumber(value) or 0
    if value >= 0 then
        return math.floor(value + 0.5)
    end
    return math.ceil(value - 0.5)
end

local function fail(message)
    return nil, "[SlicedSprite] " .. tostring(message)
end

local function player_state(player_id)
    local state = players[player_id]
    if not state then
        state = {
            assets = {},
            instances = {},
        }
        players[player_id] = state
    end
    return state
end

local function load_animation(anim_path)
    local cached = animation_cache[anim_path]
    if cached ~= nil then
        if cached == false then
            return nil, "animation previously failed to load: " .. tostring(anim_path)
        end
        return cached
    end

    local boom_path = tostring(anim_path):gsub("^/server/", "")
    local ok, data = pcall(boom.load, boom_path)
    if not ok or not data then
        animation_cache[anim_path] = false
        return nil, "could not load animation: " .. tostring(anim_path)
    end

    animation_cache[anim_path] = data
    return data
end

local function animation_state_metrics(anim_path, anim_state)
    local data, err = load_animation(anim_path)
    if not data then
        return nil, err
    end
    if type(data.states) ~= "table" then
        return nil, "animation has no states table: " .. tostring(anim_path)
    end

    local state = data.states[anim_state]
    if type(state) ~= "table" then
        return nil, "animation state not found: " .. tostring(anim_state)
            .. " in " .. tostring(anim_path)
    end

    local frames = state.framelist
    if type(frames) ~= "table" or #frames == 0 then
        return nil, "animation state has no frames: " .. tostring(anim_state)
    end

    local first = frames[1]
    local width = tonumber(first.w)
    local height = tonumber(first.h)
    local origin_x = tonumber(first.originx) or 0
    local origin_y = tonumber(first.originy) or 0

    if not width or width <= 0 or not height or height <= 0 then
        return nil, "invalid frame dimensions for state: " .. tostring(anim_state)
    end

    -- The repository API notes say animation data overrides draw-time ox/oy.
    -- Requiring a zero origin makes x/y unambiguous for sliced layout math.
    if origin_x ~= 0 or origin_y ~= 0 then
        return nil, "slice animation state must use origin 0,0: "
            .. tostring(anim_state) .. " has origin "
            .. tostring(origin_x) .. "," .. tostring(origin_y)
    end

    -- A looping animation is allowed only when every frame keeps identical
    -- geometry. Otherwise the panel layout could visibly jump between frames.
    for i = 2, #frames do
        local frame = frames[i]
        local frame_width = tonumber(frame.w)
        local frame_height = tonumber(frame.h)
        local frame_origin_x = tonumber(frame.originx) or 0
        local frame_origin_y = tonumber(frame.originy) or 0
        if frame_width ~= width
            or frame_height ~= height
            or frame_origin_x ~= 0
            or frame_origin_y ~= 0 then
            return nil, "all frames in a slice state must share width, height, and origin 0,0: "
                .. tostring(anim_state)
        end
    end

    return {
        width = width,
        height = height,
    }
end

local function copy_part(raw)
    local out = {}
    if type(raw) == "table" then
        for key, value in pairs(raw) do
            out[key] = value
        end
    end
    return out
end

local function resolve_part(style, raw, label)
    if type(raw) == "string" then
        raw = { anim_state = raw }
    elseif type(raw) ~= "table" then
        return nil, "missing or invalid slice part: " .. tostring(label)
    end

    local part = copy_part(raw)
    part.texture_path = part.texture_path or style.texture_path
    part.anim_path = part.anim_path or style.anim_path
    part.anim_state = part.anim_state or part.state

    if type(part.texture_path) ~= "string" or part.texture_path == "" then
        return nil, "slice part has no texture_path: " .. tostring(label)
    end

    if part.anim_path and part.anim_path ~= "" then
        if type(part.anim_state) ~= "string" or part.anim_state == "" then
            return nil, "animation-backed slice part needs anim_state: " .. tostring(label)
        end

        local metrics, err = animation_state_metrics(part.anim_path, part.anim_state)
        if not metrics then
            return nil, err
        end
        part.width = metrics.width
        part.height = metrics.height
    else
        part.anim_path = ""
        part.anim_state = nil
        part.width = tonumber(part.width)
        part.height = tonumber(part.height)
        if not part.width or part.width <= 0 or not part.height or part.height <= 0 then
            return nil, "texture-only slice part needs positive width and height: " .. tostring(label)
        end
    end

    part.asset_key = part.texture_path .. "|" .. part.anim_path
    return part
end

local function ensure_asset(player_id, part)
    local state = player_state(player_id)
    local sprite_id = state.assets[part.asset_key]
    if sprite_id then
        return sprite_id
    end

    local ok, err = pcall(Net.provide_asset_for_player, player_id, part.texture_path)
    if not ok then
        return nil, "could not provide texture " .. tostring(part.texture_path) .. ": " .. tostring(err)
    end

    if part.anim_path ~= "" then
        ok, err = pcall(Net.provide_asset_for_player, player_id, part.anim_path)
        if not ok then
            return nil, "could not provide animation " .. tostring(part.anim_path) .. ": " .. tostring(err)
        end
    end

    next_asset_id = next_asset_id + 1
    sprite_id = "sliced_asset_" .. tostring(player_id) .. "_" .. tostring(next_asset_id)

    local alloc = {
        texture_path = part.texture_path,
    }
    if part.anim_path ~= "" then
        alloc.anim_path = part.anim_path
        alloc.anim_state = part.anim_state
    end

    ok, err = pcall(Net.player_alloc_sprite, player_id, sprite_id, alloc)
    if not ok then
        return nil, "could not allocate sprite for " .. tostring(part.texture_path) .. ": " .. tostring(err)
    end

    state.assets[part.asset_key] = sprite_id
    return sprite_id
end

local function erase_object_ids(player_id, object_ids)
    for _, object_id in ipairs(object_ids or {}) do
        pcall(Net.player_erase_sprite, player_id, object_id)
    end
end

local function begin_instance(player_id, logical_id, signature, suffixes)
    local state = player_state(player_id)
    logical_id = tostring(logical_id)
    local old = state.instances[logical_id]

    if old and old.signature ~= signature then
        erase_object_ids(player_id, old.object_ids)
        old = nil
        state.instances[logical_id] = nil
    end

    if old then
        return old
    end

    local object_ids = {}
    for i, suffix in ipairs(suffixes) do
        object_ids[i] = "sliced_" .. logical_id .. "_" .. tostring(suffix)
    end

    local instance = {
        signature = signature,
        object_ids = object_ids,
    }
    state.instances[logical_id] = instance
    return instance
end

local function draw_piece(player_id, object_id, part, x, y, width, height, options)
    if width <= 0 or height <= 0 then
        return nil, "target slice dimensions must be positive"
    end

    local sprite_id, err = ensure_asset(player_id, part)
    if not sprite_id then
        return nil, err
    end

    local draw = {
        id = object_id,
        x = round(x),
        y = round(y),
        z = tonumber(options.z) or 100,
        sx = width / part.width,
        sy = height / part.height,
        r = tonumber(part.r or options.r) or 255,
        g = tonumber(part.g or options.g) or 255,
        b = tonumber(part.b or options.b) or 255,
        opacity = tonumber(part.opacity or options.opacity) or 255,
        a = tonumber(part.a or options.a) or 255,
        color_mode = tonumber(part.color_mode or options.color_mode) or 0,
    }

    if part.anim_state then
        draw.anim_state = part.anim_state
    else
        draw.ox = 0
        draw.oy = 0
    end

    local ok, draw_err = pcall(Net.player_draw_sprite, player_id, sprite_id, draw)
    if not ok then
        return nil, "could not draw slice object " .. tostring(object_id) .. ": " .. tostring(draw_err)
    end

    return true
end

local function resolve_strip_parts(style, count, default_middle_stretch)
    if type(style) ~= "table" or type(style.parts) ~= "table" then
        return nil, "style.parts must be a table"
    end

    local parts = {}
    for i = 1, count do
        local part, err = resolve_part(style, style.parts[i], i)
        if not part then
            return nil, err
        end

        if default_middle_stretch then
            if part.stretch == nil then
                part.stretch = (i == 2)
            else
                part.stretch = part.stretch == true
            end
        else
            part.stretch = part.stretch == true
        end

        parts[i] = part
    end

    return parts
end

local function strip_signature(kind, orientation, parts)
    local fields = { kind, orientation }
    for i, part in ipairs(parts) do
        fields[#fields + 1] = tostring(i)
        fields[#fields + 1] = part.asset_key
        fields[#fields + 1] = tostring(part.anim_state or "")
        fields[#fields + 1] = tostring(part.width)
        fields[#fields + 1] = tostring(part.height)
        fields[#fields + 1] = part.stretch and "1" or "0"
        fields[#fields + 1] = tostring(part.weight or "")
    end
    return table.concat(fields, "|")
end

local function draw_strip(player_id, logical_id, x, y, width, height, style, options, count, kind, default_middle_stretch)
    options = options or {}
    x = tonumber(x)
    y = tonumber(y)
    width = tonumber(width)
    height = tonumber(height)
    if not x or not y or not width or width <= 0 or not height or height <= 0 then
        return fail("x, y, width, and height must be valid numbers; width/height must be positive")
    end

    local orientation = tostring((style and style.orientation) or options.orientation or "horizontal")
    if orientation ~= "horizontal" and orientation ~= "vertical" then
        return fail("orientation must be 'horizontal' or 'vertical'")
    end

    local parts, err = resolve_strip_parts(style, count, default_middle_stretch)
    if not parts then
        return fail(err)
    end

    local cross_key = orientation == "horizontal" and "height" or "width"
    local primary_key = orientation == "horizontal" and "width" or "height"
    local target_cross = orientation == "horizontal" and height or width
    local target_primary = orientation == "horizontal" and width or height
    local native_cross = parts[1][cross_key]

    for i = 2, #parts do
        if parts[i][cross_key] ~= native_cross then
            return fail("all strip parts must have the same native " .. cross_key)
        end
    end

    local cross_scale = target_cross / native_cross
    local fixed_total = 0
    local stretch_weight_total = 0
    local stretch_count = 0

    for _, part in ipairs(parts) do
        if part.stretch then
            stretch_count = stretch_count + 1
            local weight = tonumber(part.weight) or part[primary_key]
            if weight <= 0 then
                return fail("stretch weights must be positive")
            end
            part._stretch_weight = weight
            stretch_weight_total = stretch_weight_total + weight
        else
            fixed_total = fixed_total + part[primary_key] * cross_scale
        end
    end

    if stretch_count == 0 then
        return fail(kind .. " needs at least one stretchable part")
    end

    local remaining = target_primary - fixed_total
    if remaining <= 0 then
        return fail("target size is too small for the fixed slice parts")
    end

    local signature = strip_signature(kind, orientation, parts)
    local suffixes = {}
    for i = 1, count do suffixes[i] = tostring(i) end
    local instance = begin_instance(player_id, logical_id, signature, suffixes)

    local cursor = orientation == "horizontal" and x or y
    for i, part in ipairs(parts) do
        local primary_size
        if part.stretch then
            primary_size = remaining * (part._stretch_weight / stretch_weight_total)
        else
            primary_size = part[primary_key] * cross_scale
        end

        local piece_x = orientation == "horizontal" and cursor or x
        local piece_y = orientation == "horizontal" and y or cursor
        local piece_width = orientation == "horizontal" and primary_size or width
        local piece_height = orientation == "horizontal" and height or primary_size

        local ok, draw_err = draw_piece(
            player_id,
            instance.object_ids[i],
            part,
            piece_x,
            piece_y,
            piece_width,
            piece_height,
            options
        )
        if not ok then
            erase_object_ids(player_id, instance.object_ids)
            player_state(player_id).instances[tostring(logical_id)] = nil
            return fail(draw_err)
        end

        cursor = cursor + primary_size
    end

    return true
end

--- Draw a conventional 3-slice strip.
--- The second part defaults to stretchable; parts 1 and 3 default to fixed.
--- style.orientation: "horizontal" or "vertical" (default horizontal)
--- style.parts: { part1, part2, part3 }
function SlicedSprite.draw3(player_id, logical_id, x, y, width, height, style, options)
    return draw_strip(player_id, logical_id, x, y, width, height, style, options, 3, "3-slice", true)
end

--- Draw a configurable five-piece strip.
--- No five-piece topology exists in the inspected server source, so callers
--- explicitly mark one or more parts with stretch=true.
--- Optional part.weight controls how leftover length is shared by stretch parts.
function SlicedSprite.draw5(player_id, logical_id, x, y, width, height, style, options)
    return draw_strip(player_id, logical_id, x, y, width, height, style, options, 5, "5-slice", false)
end

local function resolve_nine(style)
    if type(style) ~= "table" or type(style.parts) ~= "table" then
        return nil, "style.parts must be a table"
    end

    local parts = {}
    for _, name in ipairs(NINE_ORDER) do
        local part, err = resolve_part(style, style.parts[name], name)
        if not part then
            return nil, err
        end
        parts[name] = part
    end
    return parts
end

local function nine_signature(parts)
    local fields = { "9-slice" }
    for _, name in ipairs(NINE_ORDER) do
        local part = parts[name]
        fields[#fields + 1] = name
        fields[#fields + 1] = part.asset_key
        fields[#fields + 1] = tostring(part.anim_state or "")
        fields[#fields + 1] = tostring(part.width)
        fields[#fields + 1] = tostring(part.height)
    end
    return table.concat(fields, "|")
end

local function same_number(a, b)
    return tonumber(a) == tonumber(b)
end

--- Draw a 9-slice panel.
--- options.scale controls the fixed border/corner scale (default 1).
function SlicedSprite.draw9(player_id, logical_id, x, y, width, height, style, options)
    options = options or {}
    x = tonumber(x)
    y = tonumber(y)
    width = tonumber(width)
    height = tonumber(height)
    if not x or not y or not width or width <= 0 or not height or height <= 0 then
        return fail("x, y, width, and height must be valid numbers; width/height must be positive")
    end

    local parts, err = resolve_nine(style)
    if not parts then
        return fail(err)
    end

    -- Column widths must agree where they meet fixed corners/edges.
    if not same_number(parts.top_left.width, parts.left.width)
        or not same_number(parts.top_left.width, parts.bottom_left.width) then
        return fail("top_left, left, and bottom_left must have the same native width")
    end
    if not same_number(parts.top_right.width, parts.right.width)
        or not same_number(parts.top_right.width, parts.bottom_right.width) then
        return fail("top_right, right, and bottom_right must have the same native width")
    end

    -- Row heights must agree where they meet fixed corners/edges.
    if not same_number(parts.top_left.height, parts.top.height)
        or not same_number(parts.top_left.height, parts.top_right.height) then
        return fail("top_left, top, and top_right must have the same native height")
    end
    if not same_number(parts.bottom_left.height, parts.bottom.height)
        or not same_number(parts.bottom_left.height, parts.bottom_right.height) then
        return fail("bottom_left, bottom, and bottom_right must have the same native height")
    end

    local border_scale = tonumber(options.scale) or 1
    if border_scale <= 0 then
        return fail("options.scale must be positive")
    end

    local left_width = parts.top_left.width * border_scale
    local right_width = parts.top_right.width * border_scale
    local top_height = parts.top_left.height * border_scale
    local bottom_height = parts.bottom_left.height * border_scale
    local inner_width = width - left_width - right_width
    local inner_height = height - top_height - bottom_height

    if inner_width <= 0 or inner_height <= 0 then
        return fail("target width/height is too small for the fixed 9-slice borders")
    end

    local signature = nine_signature(parts)
    local instance = begin_instance(player_id, logical_id, signature, NINE_ORDER)

    local x0 = x
    local x1 = x + left_width
    local x2 = x + width - right_width
    local y0 = y
    local y1 = y + top_height
    local y2 = y + height - bottom_height

    local rectangles = {
        top_left     = { x0, y0, left_width, top_height },
        top          = { x1, y0, inner_width, top_height },
        top_right    = { x2, y0, right_width, top_height },
        left         = { x0, y1, left_width, inner_height },
        center       = { x1, y1, inner_width, inner_height },
        right        = { x2, y1, right_width, inner_height },
        bottom_left  = { x0, y2, left_width, bottom_height },
        bottom       = { x1, y2, inner_width, bottom_height },
        bottom_right = { x2, y2, right_width, bottom_height },
    }

    for i, name in ipairs(NINE_ORDER) do
        local rect = rectangles[name]
        local ok, draw_err = draw_piece(
            player_id,
            instance.object_ids[i],
            parts[name],
            rect[1], rect[2], rect[3], rect[4],
            options
        )
        if not ok then
            erase_object_ids(player_id, instance.object_ids)
            player_state(player_id).instances[tostring(logical_id)] = nil
            return fail(draw_err)
        end
    end

    return true
end

function SlicedSprite.erase(player_id, logical_id)
    local state = players[player_id]
    if not state then return false end

    logical_id = tostring(logical_id)
    local instance = state.instances[logical_id]
    if not instance then return false end

    erase_object_ids(player_id, instance.object_ids)
    state.instances[logical_id] = nil
    return true
end

function SlicedSprite.cleanupPlayer(player_id)
    local state = players[player_id]
    if not state then return end

    -- API_CHANGES.md states deallocating a sprite erases all objects using it.
    for _, sprite_id in pairs(state.assets) do
        pcall(Net.player_dealloc_sprite, player_id, sprite_id)
    end

    players[player_id] = nil
end

Net:on("player_disconnect", function(event)
    if event and event.player_id then
        SlicedSprite.cleanupPlayer(event.player_id)
    end
end)

return SlicedSprite
