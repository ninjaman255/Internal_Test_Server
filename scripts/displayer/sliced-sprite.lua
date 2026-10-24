-- scripts/displayer/sliced-sprite.lua
--
-- Reusable 3-slice, configurable 5-slice, and 9-slice sprite rendering.
-- Also provides a text panel that combines slices with automatic mixed
-- text + sprite layout (vertical stacking or horizontal row).
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
local TextLayout = require("scripts/displayer/text-layout")
local fontSystem = require("scripts/displayer/font-system")

local SlicedSprite = {}

local animation_cache = {}
local players = {}
local next_asset_id = 0

-- Panel registry: player_id -> { logical_id = panel_object }
local panels = {}

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

    if origin_x ~= 0 or origin_y ~= 0 then
        return nil, "slice animation state must use origin 0,0: "
            .. tostring(anim_state) .. " has origin "
            .. tostring(origin_x) .. "," .. tostring(origin_y)
    end

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

-- =========================================================================
-- Sprite child helpers
-- =========================================================================

local function sprite_native_dimensions(def)
    local w = tonumber(def.width)
    local h = tonumber(def.height)
    if w and h and w > 0 and h > 0 then
        return w, h
    end
    local anim_path = def.anim_path
    local anim_state = def.anim_state
    if anim_path and anim_path ~= "" and anim_state and anim_state ~= "" then
        local metrics = animation_state_metrics(anim_path, anim_state)
        if metrics then
            return metrics.width, metrics.height
        end
    end
    return 16, 16
end

local function sprite_rendered_dimensions(def, sprite_scale)
    local nw, nh = sprite_native_dimensions(def)
    local sx = (tonumber(def.sx) or 1) * (sprite_scale or 1)
    local sy = (tonumber(def.sy) or 1) * (sprite_scale or 1)
    return nw * sx, nh * sy
end

local function draw_sprite_instance(player_id, object_id, def, x, y, sprite_scale, options)
    if type(def.texture_path) ~= "string" or def.texture_path == "" then
        return nil, "sprite has no texture_path"
    end

    local native_w, native_h = sprite_native_dimensions(def)
    if native_w <= 0 or native_h <= 0 then
        return nil, "sprite has invalid native dimensions"
    end

    local anim_path = def.anim_path or ""
    local part = {
        texture_path = def.texture_path,
        anim_path = anim_path,
        anim_state = def.anim_state,
        width = native_w,
        height = native_h,
        asset_key = def.texture_path .. "|" .. anim_path,
    }

    local sprite_id, err = ensure_asset(player_id, part)
    if not sprite_id then
        return nil, err
    end

    local final_sx = (tonumber(def.sx) or 1) * (sprite_scale or 1)
    local final_sy = (tonumber(def.sy) or 1) * (sprite_scale or 1)

    local draw = {
        id = object_id,
        x = round(x),
        y = round(y),
        z = tonumber(options and options.z) or 100,
        sx = final_sx,
        sy = final_sy,
        r = tonumber(def.r) or 255,
        g = tonumber(def.g) or 255,
        b = tonumber(def.b) or 255,
        opacity = tonumber(def.opacity) or 255,
        a = tonumber(def.a) or 255,
        ro = tonumber(def.ro) or 0,
        color_mode = tonumber(def.color_mode) or 0,
    }

    if def.anim_state and def.anim_state ~= "" then
        draw.anim_state = def.anim_state
    else
        draw.ox = 0
        draw.oy = 0
    end

    local ok, draw_err = pcall(Net.player_draw_sprite, player_id, sprite_id, draw)
    if not ok then
        return nil, "could not draw sprite " .. tostring(object_id) .. ": " .. tostring(draw_err)
    end
    return true
end

-- =========================================================================
-- Strip / nine-slice primitives
-- =========================================================================

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

function SlicedSprite.draw3(player_id, logical_id, x, y, width, height, style, options)
    return draw_strip(player_id, logical_id, x, y, width, height, style, options, 3, "3-slice", true)
end

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

    if not same_number(parts.top_left.width, parts.left.width)
        or not same_number(parts.top_left.width, parts.bottom_left.width) then
        return fail("top_left, left, and bottom_left must have the same native width")
    end
    if not same_number(parts.top_right.width, parts.right.width)
        or not same_number(parts.top_right.width, parts.bottom_right.width) then
        return fail("top_right, right, and bottom_right must have the same native width")
    end

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

    if panels[player_id] then
        for panel_id, panel in pairs(panels[player_id]) do
            pcall(function() panel:destroy() end)
        end
        panels[player_id] = nil
    end

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

-- =========================================================================
-- Text Panel (vertical stacking OR horizontal row of mixed text/sprite children)
-- =========================================================================

local TextPanel = {}
TextPanel.__index = TextPanel

function TextPanel:new(player_id, logical_id, x, y, text, style, options)
    local o = setmetatable({}, TextPanel)
    o._player_id = player_id
    o._logical_id = logical_id
    o._x = x
    o._y = y
    o._text = text
    o._style = style
    o._options = options or {}
    o._glyph_ids = {}
    o._sprite_ids = {}
    o._slice_logical_id = logical_id .. "_slice"
    o._panel_width = 0
    o._panel_height = 0
    o._layout = nil
    o._destroyed = false
    o._children = o._options.children

    local pad = o._options.padding or 8
    if type(pad) == "number" then
        pad = { left = pad, right = pad, top = pad, bottom = pad }
    end
    o._padding = pad

    o:_redraw()
    return o
end

function TextPanel:_measure_child(child, inner_max_width)
    if child.kind == "text" then
        local opts = self._options
        local font = child.font or opts.font or "THICK"
        local scale = child.scale or opts.scale or 2.0
        local halign = child.halign or "left"
        local valign = child.valign or "top"
        local line_spacing = child.line_spacing or opts.line_spacing or 0

        -- Panel/sprite coordinates are physical 480x320 pixels, while
        -- TextLayout measures in virtual 240x160 coordinates. Convert the
        -- available width before layout, then convert measured dimensions
        -- back to physical pixels for panel sizing and child alignment.
        local max_w = inner_max_width / 2
        if child.max_width then
            max_w = math.min(max_w, child.max_width / 2)
        end

        -- An auto-sized panel has no wrapping limit. Do not pass math.huge
        -- into TextLayout: its center/right alignment math subtracts the line
        -- width from this value and can produce infinite glyph coordinates.
        -- With no width constraint, layout naturally measures the text and
        -- starts glyphs at virtual x=0; the panel positions the child itself.
        local layout_width = max_w
        if layout_width == math.huge then
            layout_width = nil
        end

        local layout_opts = {
            font = font,
            scale = scale,
            halign = halign,
            valign = valign,
            line_spacing = line_spacing,
            width = layout_width,
            -- Leave height unconstrained. TextLayout uses a finite height to
            -- calculate middle/bottom vertical alignment; math.huge here
            -- makes page_y (and therefore every glyph y) infinite. The panel
            -- performs the child's vertical alignment in physical pixels.
            height = nil,
        }
        local layout = TextLayout.layout(child.text or "", layout_opts)
        return {
            kind = "text",
            width = layout.total_width * 2,
            height = layout.total_height * 2,
            layout = layout,
            layout_opts = layout_opts,
        }
    elseif child.kind == "sprites" then
        local sprites = child.sprites or {}
        if #sprites == 0 then
            return {
                kind = "sprites",
                width = 0, height = 0, sprites = {}, sizes = {},
                columns = 1, rows = 0, cell_w = 0, cell_h = 0,
                col_spacing = 0, row_spacing = 0, sprite_scale = 1.0,
            }
        end

        local sprite_scale = child.sprite_scale or 1.0
        local columns = math.max(1, math.floor(child.columns or 1))
        local col_spacing = child.column_spacing or 5
        local row_spacing = child.row_spacing or 5

        local max_cell_w, max_cell_h = 0, 0
        local sizes = {}
        for i, def in ipairs(sprites) do
            local w, h = sprite_rendered_dimensions(def, sprite_scale)
            sizes[i] = { w = w, h = h }
            if w > max_cell_w then max_cell_w = w end
            if h > max_cell_h then max_cell_h = h end
        end

        local rows = math.ceil(#sprites / columns)
        local total_w = columns * max_cell_w + (columns - 1) * col_spacing
        local total_h = rows * max_cell_h + (rows - 1) * row_spacing

        return {
            kind = "sprites",
            width = total_w, height = total_h,
            sprites = sprites, sizes = sizes,
            columns = columns, rows = rows,
            cell_w = max_cell_w, cell_h = max_cell_h,
            col_spacing = col_spacing, row_spacing = row_spacing,
            sprite_scale = sprite_scale,
        }
    else
        return { kind = "unknown", width = 0, height = 0 }
    end
end

function TextPanel:_draw_text_child(player_id, child, m, base_x, base_y, z, glyph_ids)
    local layout = m.layout
    local layout_opts = m.layout_opts
    local font = layout_opts.font
    local scale = layout_opts.scale

    local color = child.color or self._options.color or { r = 255, g = 255, b = 255, a = 255 }
    local color_mode = child.color_mode or self._options.color_mode or 0

    for _, glyph in ipairs(layout.flat_glyphs) do
        if glyph.char ~= " " then
            -- base_x/base_y are physical pixels, but glyph positions
            -- from TextLayout are virtual pixels. FontSystem accepts virtual
            -- coordinates and doubles them internally, so convert only the
            -- panel origin and leave glyph offsets in virtual space.
            local gx = base_x / 2 + glyph.x
            local gy = base_y / 2 + glyph.y
            local id = fontSystem:drawGlyph(
                player_id,
                font,
                glyph.char,
                gx,
                gy,
                {
                    scale = scale,
                    z = z,
                    r = color.r or 255,
                    g = color.g or 255,
                    b = color.b or 255,
                    a = color.a or 255,
                    color_mode = color_mode,
                }
            )
            if id then table.insert(glyph_ids, id) end
        end
    end
end

function TextPanel:_draw_sprites_child(player_id, child, m, base_x, base_y, z, sprite_ids, child_idx)
    local sprites = m.sprites
    local sprite_scale = m.sprite_scale
    local columns = m.columns
    local cell_w = m.cell_w
    local cell_h = m.cell_h
    local col_spacing = m.col_spacing
    local row_spacing = m.row_spacing
    local sprite_align = child.sprite_align or "center"

    for i, def in ipairs(sprites) do
        local col = (i - 1) % columns
        local row = math.floor((i - 1) / columns)
        local cell_x = base_x + col * (cell_w + col_spacing)
        local cell_y = base_y + row * (cell_h + row_spacing)

        local sprite_w = m.sizes[i].w
        local sprite_h = m.sizes[i].h

        local sprite_x = cell_x
        local sprite_y = cell_y
        if sprite_align == "center" then
            sprite_x = cell_x + (cell_w - sprite_w) / 2
            sprite_y = cell_y + (cell_h - sprite_h) / 2
        elseif sprite_align == "right" then
            sprite_x = cell_x + (cell_w - sprite_w)
        end

        local object_id = self._logical_id .. "_sp_" .. tostring(child_idx) .. "_" .. tostring(i)
        local ok, err = draw_sprite_instance(
            player_id, object_id, def, sprite_x, sprite_y, sprite_scale, { z = z }
        )
        if ok then
            table.insert(sprite_ids, object_id)
        else
            print("TextPanel sprite drawing failed:", err)
        end
    end
end

function TextPanel:_redraw()
    if self._destroyed then return end
    local player_id = self._player_id
    local x, y = self._x, self._y
    local style = self._style
    local options = self._options

    -- 1. Erase existing
    SlicedSprite.erase(player_id, self._slice_logical_id)
    for _, id in ipairs(self._glyph_ids) do
        fontSystem:eraseGlyph(player_id, id)
    end
    self._glyph_ids = {}
    for _, id in ipairs(self._sprite_ids) do
        pcall(Net.player_erase_sprite, player_id, id)
    end
    self._sprite_ids = {}

    -- 2. Children
    local children = self._children
    if not children or #children == 0 then
        children = {
            {
                kind = "text",
                text = self._text or "",
                font = options.font,
                scale = options.scale,
                color = options.color,
                halign = options.halign,
                valign = options.valign,
                line_spacing = options.line_spacing,
            }
        }
    end

    local auto_size = options.auto_size ~= false
    local pad = self._padding
    local max_width = options.max_width
    local max_height = options.max_height
    local layout_mode = options.layout or "vertical"
    local is_horizontal = layout_mode == "horizontal"

    local inner_max_width = math.huge
    if max_width then
        inner_max_width = max_width - pad.left - pad.right
    end
    if not auto_size and options.width then
        inner_max_width = math.min(inner_max_width, options.width - pad.left - pad.right)
    end

    -- 3. Measure
    local measured = {}
    local max_child_width, max_child_height = 0, 0
    local total_child_width, total_child_height = 0, 0

    for i, child in ipairs(children) do
        local m = self:_measure_child(child, inner_max_width)
        m.child = child
        m.index = i
        measured[i] = m
        if m.width > max_child_width then max_child_width = m.width end
        if m.height > max_child_height then max_child_height = m.height end
        total_child_width = total_child_width + m.width
        total_child_height = total_child_height + m.height
        if i > 1 then
            local gap = child.gap_before or 0
            total_child_width = total_child_width + gap
            total_child_height = total_child_height + gap
        end
    end

    -- 4. Panel size
    local panel_width, panel_height
    if auto_size then
        if is_horizontal then
            panel_width = total_child_width + pad.left + pad.right
            panel_height = max_child_height + pad.top + pad.bottom
        else
            panel_width = max_child_width + pad.left + pad.right
            panel_height = total_child_height + pad.top + pad.bottom
        end
        if max_width then panel_width = math.min(panel_width, max_width) end
        if max_height then panel_height = math.min(panel_height, max_height) end
        panel_width = math.max(panel_width, 1)
        panel_height = math.max(panel_height, 1)
    else
        panel_width = options.width
        panel_height = options.height
        if not panel_width or panel_width <= 0 or not panel_height or panel_height <= 0 then
            if is_horizontal then
                panel_width = total_child_width + pad.left + pad.right
                panel_height = max_child_height + pad.top + pad.bottom
            else
                panel_width = max_child_width + pad.left + pad.right
                panel_height = total_child_height + pad.top + pad.bottom
            end
            panel_width = math.max(panel_width, 1)
            panel_height = math.max(panel_height, 1)
        end
    end

    -- 5. Draw slices
    local slice_kind = style.kind or "9"
    local draw_fn = slice_kind == "3" and SlicedSprite.draw3 or
                    slice_kind == "5" and SlicedSprite.draw5 or
                    SlicedSprite.draw9
    local slice_options = {}
    for k, v in pairs(options.slice_options or {}) do slice_options[k] = v end
    slice_options.z = options.z or 100
    if options.slice_scale then slice_options.scale = options.slice_scale end

    local ok, err = draw_fn(
        player_id, self._slice_logical_id, x, y, panel_width, panel_height, style, slice_options
    )
    if not ok then
        print("TextPanel slice drawing failed:", err)
        self._glyph_ids = {}
        self._sprite_ids = {}
        return
    end

    -- 6. Draw children
    local inner_x = x + pad.left
    local inner_y = y + pad.top
    local inner_width = panel_width - pad.left - pad.right
    local inner_height = panel_height - pad.top - pad.bottom

    local cursor_x = inner_x
    local cursor_y = inner_y
    local glyph_ids = {}
    local sprite_ids = {}

    for i, m in ipairs(measured) do
        local child = m.child
        if i > 1 then
            local gap = child.gap_before or 0
            if is_horizontal then
                cursor_x = cursor_x + gap
            else
                cursor_y = cursor_y + gap
            end
        end

        local child_x, child_y
        if is_horizontal then
            child_x = cursor_x
            local child_valign = child.valign or "middle"
            if child_valign == "top" then
                child_y = inner_y
            elseif child_valign == "bottom" then
                child_y = inner_y + inner_height - m.height
            else
                child_y = inner_y + (inner_height - m.height) / 2
            end
        else
            child_y = cursor_y
            local child_align = child.align or "left"
            if child_align == "center" then
                child_x = inner_x + (inner_width - m.width) / 2
            elseif child_align == "right" then
                child_x = inner_x + inner_width - m.width
            else
                child_x = inner_x
            end
        end

        local z = (options.z or 100) + (child.z_offset or 0) + 1

        if child.kind == "text" then
            self:_draw_text_child(player_id, child, m, child_x, child_y, z, glyph_ids)
        elseif child.kind == "sprites" then
            self:_draw_sprites_child(player_id, child, m, child_x, child_y, z, sprite_ids, i)
        end

        if is_horizontal then
            cursor_x = cursor_x + m.width
        else
            cursor_y = cursor_y + m.height
        end
    end

    self._glyph_ids = glyph_ids
    self._sprite_ids = sprite_ids
    self._panel_width = panel_width
    self._panel_height = panel_height
    self._measured = measured

    if not panels[player_id] then panels[player_id] = {} end
    panels[player_id][self._logical_id] = self
end

function TextPanel:getSize()
    return self._panel_width, self._panel_height
end

function TextPanel:setText(new_text)
    if self._destroyed then return end
    self._text = new_text
    self._children = nil
    self:_redraw()
end

function TextPanel:setChildren(children)
    if self._destroyed then return end
    self._children = children
    self:_redraw()
end

function TextPanel:setPosition(x, y)
    if self._destroyed then return end
    self._x = x
    self._y = y
    self:_redraw()
end

function TextPanel:setOptions(new_options)
    if self._destroyed then return end
    for k, v in pairs(new_options) do
        if k == "padding" and type(v) == "number" then
            self._options.padding = { left = v, right = v, top = v, bottom = v }
        elseif k == "color" and type(v) == "table" then
            self._options.color = { r = v.r or 255, g = v.g or 255, b = v.b or 255, a = v.a or 255 }
        else
            self._options[k] = v
        end
    end
    local pad = self._options.padding or 8
    if type(pad) == "number" then
        pad = { left = pad, right = pad, top = pad, bottom = pad }
    end
    self._padding = pad
    self._children = self._options.children
    self:_redraw()
end

function TextPanel:destroy()
    if self._destroyed then return end
    self._destroyed = true
    local player_id = self._player_id
    local logical_id = self._logical_id

    SlicedSprite.erase(player_id, self._slice_logical_id)
    for _, id in ipairs(self._glyph_ids) do
        fontSystem:eraseGlyph(player_id, id)
    end
    self._glyph_ids = {}
    for _, id in ipairs(self._sprite_ids) do
        pcall(Net.player_erase_sprite, player_id, id)
    end
    self._sprite_ids = {}

    if panels[player_id] then
        panels[player_id][logical_id] = nil
    end
end

function SlicedSprite.drawTextPanel(player_id, logical_id, x, y, text, style, options)
    if not player_id or not logical_id then
        return fail("player_id and logical_id required")
    end
    player_state(player_id)
    local panel, err = TextPanel:new(player_id, logical_id, x, y, text, style, options)
    if not panel then
        return fail(err or "failed to create text panel")
    end
    return panel
end

return SlicedSprite