-- Shared world-attachment coordinate helpers for NetGames and FootBomb.
--
-- This module intentionally contains only coordinate math. It does not create
-- bots, move actors, subscribe to events, or animate properties.
--
-- Projection modes:
--   "isometric"  - invert the standard screen/map projection used by FootBomb.
--   "net_games"  - reproduce NetGames' legacy convertOffsets convention.
--
-- Z correction:
--   The Z correction shifts BOTH map x and map y by the SAME amount so the
--   resulting screen displacement is purely vertical. The engine already
--   handles a bot's absolute Z; the correction here only compensates for a
--   *delta* above the parent (typically `RESULT_BALL_Z_LIFT`).
--
--   Scale derivation (per-map, dynamic):
--     1. If `z_correction.scale` is explicitly provided, use it.
--     2. Otherwise derive from `tile_height / tile_width`
--        (0.5 for the standard 64x32 isometric map).
--     3. If `z_correction.scale_multiplier` is provided, multiply the base
--        scale. `point_to_map_offset` computes this for sprite actors from
--        the frame's originy/h so a top-anchored sprite gets zero correction
--        and a bottom-anchored sprite gets full correction.
--
--   Actor kinds:
--     "bot"    (default) - uses map-derived scale directly.
--     "sprite" - computes scale_multiplier from frame.originy / frame.h.

local WorldAttachment = {}

local DEFAULT_TILE_WIDTH = 64
local DEFAULT_TILE_HEIGHT = 32

local function number_or_nil(value)
    if value == nil then return nil end
    return tonumber(value)
end

local function is_flipped(value)
    return tonumber(value) == 1 or value == true or value == "1"
end

local function round_fraction(value, denominator)
    local int_part = math.floor(value)
    local decimal = value - int_part
    local n = math.floor(decimal * denominator + 0.5)
    return int_part, n / denominator
end

-- ---------------------------------------------------------------------------
-- quantize_map_offset(offset, options)
-- ---------------------------------------------------------------------------
-- Snap the fractional parts of a map-space delta onto a fixed grid so that
-- slow-moving attachments do not shimmer on the isometric grid.
--
-- Math:
--   * Split x and y into integer + fractional parts.
--   * Round each fraction to the nearest 1/denominator (default 32).
--   * Compute |x_frac - y_frac|; snap that separation to the nearest
--     1/difference_steps (default 16) to keep the parallel-edges offset
--     stable across quantized frames.
--
-- Operates on: map delta {x, y} (typically the output of pixel_offset_to_map
-- before it is applied to a parent position).
--
-- When to use: slow or static attachments (resting items, poses). Do NOT use
-- for fast tracks (ball mid-flight) — the 1/32 snapping is visible as a
-- stair-step under fast motion.
function WorldAttachment.quantize_map_offset(offset, options)
    if type(offset) ~= "table" then
        return nil, "map offset is missing"
    end

    local x, y = tonumber(offset.x), tonumber(offset.y)
    if x == nil or y == nil then
        return nil, "map offset has non-numeric x/y"
    end

    options = options or {}
    local denominator = tonumber(options.denominator) or 32
    local difference_steps = tonumber(options.difference_steps) or 16
    if denominator <= 0 or difference_steps <= 0 then
        return nil, "quantization steps must be positive"
    end

    local x_int, x_dec = round_fraction(x, denominator)
    local y_int, y_dec = round_fraction(y, denominator)

    local diff = math.abs(x_dec - y_dec)
    if diff < 1 then
        local diff_adj = math.floor(diff * difference_steps + 0.5) / difference_steps
        if x_dec >= y_dec then
            y_dec = x_dec - diff_adj
        else
            y_dec = x_dec + diff_adj
        end

        if y_dec < 0 then y_dec = 0 end
        if y_dec >= 1 then y_dec = 1 - (1 / denominator) end
    end

    return { x = x_int + x_dec, y = y_int + y_dec }
end

-- ---------------------------------------------------------------------------
-- point_to_pixel_offset(frame, point)
-- ---------------------------------------------------------------------------
-- Convert a labeled point inside an animation frame into a pixel offset from
-- the frame's pivot, with flips handled correctly.
--
-- Math:
--   * Mirror point and pivot around the frame center for flipx/flipy so their
--     relative distance is preserved.
--   * Return point - pivot.
--
-- Operates on: frame rect from a parsed Boom animation + a labeled point.
--
-- Output: pixel offset (relative to the sprite's anchor). NOT absolute
-- screen coordinates — the sprite's own screen position supplies the origin.
function WorldAttachment.point_to_pixel_offset(frame, point)
    if type(frame) ~= "table" or type(point) ~= "table" then
        return nil, "frame or point is missing"
    end

    local point_x, point_y = tonumber(point.x), tonumber(point.y)
    if point_x == nil or point_y == nil then
        return nil, "point has no numeric x/y"
    end

    local width, height = tonumber(frame.w), tonumber(frame.h)
    local origin_x = tonumber(frame.originx) or 0
    local origin_y = tonumber(frame.originy) or 0
    local flip_x, flip_y = is_flipped(frame.flipx), is_flipped(frame.flipy)

    if flip_x then
        if width and width > 0 then
            point_x = width - point_x
            origin_x = width - origin_x
        else
            point_x = -point_x
            origin_x = -origin_x
        end
    end
    if flip_y then
        if height and height > 0 then
            point_y = height - point_y
            origin_y = height - origin_y
        else
            point_y = -point_y
            origin_y = -origin_y
        end
    end

    return { x = point_x - origin_x, y = point_y - origin_y }, nil, {
        frame_width = width,
        frame_height = height,
        origin_x = origin_x,
        origin_y = origin_y,
        point_x = point_x,
        point_y = point_y,
        flipped_x = flip_x,
        flipped_y = flip_y,
    }
end

-- ---------------------------------------------------------------------------
-- pixel_offset_to_map(screen_offset, options)
-- ---------------------------------------------------------------------------
-- Convert a pixel offset (from point_to_pixel_offset or equivalent) into a
-- map-space delta, using the current world projection. Optionally applies a
-- dynamic Z correction and anti-jitter.
--
-- Base projection:
--   isometric  : map_x =  sx/tile_w + sy/tile_h
--                map_y = -sx/tile_w + sy/tile_h
--   net_games  : map_x = (2*sy - sx) / 64
--                map_y = (2*sy + sx) / 64
--                (tile_w/tile_h intentionally ignored; legacy fixed 64)
--
-- Z correction (added to BOTH map_x and map_y):
--   scale = z_correction.scale            (explicit, if provided)
--         | tile_height / tile_width      (derived from map dims by default)
--   if z_correction.scale_multiplier then
--       scale = scale * scale_multiplier
--   correction = child_z * scale
--   map_x += correction; map_y += correction
--
--   Screen effect: screen_dx = 0, screen_dy = correction * tile_h.
--   i.e., a pure vertical screen displacement of (child_z * scale * tile_h)
--   pixels downward, with zero horizontal shift.
--
--   `child_z` is the DELTA above the parent, not the parent's absolute Z.
--   The engine already renders the parent at its own Z; we only add the
--   delta needed to lift the child above the parent.
--
-- Operates on: pixel offset {x, y} + options.
--
-- Output: map delta {x, y}. NOT an absolute position — add it to the parent
-- via target_position to get the child's final position.
--
-- Returns (map_delta, error, meta) where meta exposes `tile_width`,
-- `tile_height`, and (when z correction ran) `scale`, `child_z`,
-- `child_z_correction` for diagnostics.
function WorldAttachment.pixel_offset_to_map(screen_offset, options)
    if type(screen_offset) ~= "table" then
        return nil, "screen offset is missing"
    end

    local sx, sy = tonumber(screen_offset.x), tonumber(screen_offset.y)
    if sx == nil or sy == nil then
        return nil, "screen offset has non-numeric x/y"
    end

    options = options or {}
    local projection = options.projection or "isometric"

    -- Hoisted so Z-scale derivation can use them regardless of projection.
    local tile_width = tonumber(options.tile_width) or DEFAULT_TILE_WIDTH
    local tile_height = tonumber(options.tile_height) or DEFAULT_TILE_HEIGHT

    local map_offset

    if projection == "isometric" then
        if tile_width <= 0 or tile_height <= 0 then
            return nil, "invalid map tile dimensions"
        end
        map_offset = {
            x = sx / tile_width + sy / tile_height,
            y = -sx / tile_width + sy / tile_height,
        }
    elseif projection == "net_games" then
        map_offset = {
            x = (2 * sy - sx) / 64,
            y = (2 * sy + sx) / 64,
        }
    else
        return nil, "unknown projection mode: " .. tostring(projection)
    end

    local meta = {
        tile_width = tile_width,
        tile_height = tile_height,
    }

    local z_options = options.z_correction
    if z_options == true then z_options = { enabled = true } end
    if type(z_options) == "table" and z_options.enabled ~= false then
        local child_z = number_or_nil(z_options.child_z)
        if child_z == nil then
            local parent_z = tonumber(z_options.parent_z) or 0
            local z_offset = tonumber(z_options.z_offset) or 0
            child_z = parent_z + z_offset
        end

        -- Dynamic, per-map scale derivation.
        -- Priority: explicit scale > tile_h / tile_w.
        -- Then optionally multiplied by scale_multiplier (e.g. sprite factor).
        local scale = tonumber(z_options.scale)
        if not scale then
            if tile_width > 0 then
                scale = tile_height / tile_width
            else
                scale = 0.5
            end
        end
        local scale_multiplier = tonumber(z_options.scale_multiplier)
        if scale_multiplier then
            scale = scale * scale_multiplier
        end

        local correction = child_z * scale
        map_offset.x = map_offset.x + correction
        map_offset.y = map_offset.y + correction

        meta.scale = scale
        meta.child_z = child_z
        meta.child_z_correction = correction
    end

    local anti_jitter = options.anti_jitter
    if anti_jitter then
        local quantized, quantize_error = WorldAttachment.quantize_map_offset(
            map_offset,
            type(anti_jitter) == "table" and anti_jitter or nil
        )
        if not quantized then return nil, quantize_error end
        map_offset = quantized
        meta.anti_jitter_applied = true
    end

    return map_offset, nil, meta
end

-- ---------------------------------------------------------------------------
-- point_to_map_offset(frame, point, options)
-- ---------------------------------------------------------------------------
-- Convenience: point_to_pixel_offset → pixel_offset_to_map.
--
-- Sprite support:
--   If `options.z_correction.actor_kind == "sprite"`, this function computes
--   `scale_multiplier = frame.originy / frame.h` and passes it through, so a
--   bottom-anchored sprite (originy ≈ h) gets full correction and a
--   top-anchored sprite (originy ≈ 0) gets none. Bots use "bot" (default)
--   which relies on the map-derived scale directly.
--
-- Operates on: frame + point + options.
-- Output: map delta {x, y} (and merged metadata).
function WorldAttachment.point_to_map_offset(frame, point, options)
    local pixel_offset, point_error, meta =
        WorldAttachment.point_to_pixel_offset(frame, point)
    if not pixel_offset then return nil, point_error end

    options = options or {}
    local z_options = options.z_correction

    if type(z_options) == "table"
        and z_options.enabled ~= false
        and z_options.actor_kind == "sprite"
        and not z_options.scale_multiplier
    then
        -- Derive sprite scale_multiplier from the frame's pivot.
        local frame_height = tonumber(frame and frame.h) or 0
        local frame_origin_y = tonumber(frame and frame.originy) or 0
        local multiplier = 0
        if frame_height > 0 then
            multiplier = frame_origin_y / frame_height
        end

        local local_options = {}
        for key, value in pairs(options) do local_options[key] = value end
        local local_z = {}
        for key, value in pairs(z_options) do local_z[key] = value end
        local_z.scale_multiplier = multiplier
        local_options.z_correction = local_z
        options = local_options
    end

    local map_offset, map_error, map_meta =
        WorldAttachment.pixel_offset_to_map(pixel_offset, options)
    if not map_offset then return nil, map_error end

    meta = meta or {}
    meta.screen_offset_x, meta.screen_offset_y = pixel_offset.x, pixel_offset.y
    if map_meta then
        for key, value in pairs(map_meta) do meta[key] = value end
    end
    return map_offset, nil, meta
end

-- ---------------------------------------------------------------------------
-- target_position(parent_position, map_offset, options)
-- ---------------------------------------------------------------------------
-- Compose the child's final map position from the parent's position + the
-- map delta.
--
-- Math:
--   target.x = parent.x + offset.x
--   target.y = parent.y + offset.y
--   target.z = parent.z + (options.z_offset or 0)
--
-- Operates on: parent map pos + map delta + z_offset.
-- Output: child map pos {x, y, z}.
--
-- IMPORTANT: `options.z_offset` here is the child's ACTUAL z separation
-- above the parent. It is NOT the z_correction.z_offset used inside
-- pixel_offset_to_map (that one only controls x/y compensation). Passing the
-- same lift to both keeps the ball visually attached to the ball point while
-- rendered `lift` units higher than the defender.
function WorldAttachment.target_position(parent_position, map_offset, options)
    if type(parent_position) ~= "table" or type(map_offset) ~= "table" then
        return nil, "parent position or map offset is missing"
    end

    local px, py = tonumber(parent_position.x), tonumber(parent_position.y)
    local pz = tonumber(parent_position.z) or 0
    local ox, oy = tonumber(map_offset.x), tonumber(map_offset.y)
    if px == nil or py == nil or ox == nil or oy == nil then
        return nil, "parent position or map offset has non-numeric coordinates"
    end

    options = options or {}
    local z_offset = tonumber(options.z_offset) or 0
    return { x = px + ox, y = py + oy, z = pz + z_offset }
end

-- ---------------------------------------------------------------------------
-- follow_position(parent_position, screen_offset, options)
-- ---------------------------------------------------------------------------
-- Recompute the attachment position as the parent moves, so the z correction
-- tracks the parent's elevation changes rather than freezing at creation.
--
-- The caller supplies `screen_offset` directly (rather than frame + point)
-- because continuous attachment usually samples the animation at multiple
-- elapsed times in a loop.
--
-- Bot-friendly: the map-derived scale is used automatically. For sprite
-- actors use point_to_map_offset (which can compute the frame-based
-- scale_multiplier); follow_position does not carry frame data.
function WorldAttachment.follow_position(parent_position, screen_offset, options)
    if type(parent_position) ~= "table" then
        return nil, "parent position is missing"
    end
    options = options or {}

    local local_options = {}
    for key, value in pairs(options) do local_options[key] = value end
    local z_options = options.z_correction
    if z_options == true then z_options = { enabled = true } end
    if type(z_options) == "table" and z_options.enabled ~= false then
        local local_z = {}
        for key, value in pairs(z_options) do local_z[key] = value end
        local parent_z = tonumber(parent_position.z) or 0
        local z_offset = tonumber(options.z_offset)
            or tonumber(local_z.z_offset) or 0
        local_z.parent_z = parent_z
        local_z.z_offset = z_offset
        local_z.child_z = parent_z + z_offset
        local_options.z_correction = local_z
    end

    local map_offset, map_error = WorldAttachment.pixel_offset_to_map(
        screen_offset, local_options
    )
    if not map_offset then return nil, map_error end
    return WorldAttachment.target_position(parent_position, map_offset, options)
end

return WorldAttachment