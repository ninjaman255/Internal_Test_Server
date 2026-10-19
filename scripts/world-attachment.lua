-- Shared world-attachment coordinate helpers for NetGames and FootBomb.
--
-- This module intentionally contains only coordinate math. It does not create
-- bots, move actors, subscribe to events, or animate properties.
--
-- Projection modes:
--   "isometric"  - invert the standard screen/map projection used by FootBomb.
--   "net_games"  - reproduce NetGames' legacy convertOffsets convention.
--
-- Optional Z correction follows NetGames' convention: add child_z * scale to
-- BOTH map X and map Y. NetGames uses scale=0.5. This is project-specific and
-- should be enabled explicitly; it is not a universal isometric projection.

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

-- NetGames-inspired anti-jitter correction. Quantizes each fractional part to
-- 1/32, then adjusts the fractional separation to a 1/16 step while preserving
-- the integer portions. Keep this optional for callers that need raw precision.
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

-- Calculate a point relative to the rendered frame origin, including flips.
-- frame: {w, h, originx, originy, flipx, flipy}
-- point: {x, y}
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

    -- Mirror both the point and pivot so their relative distance is preserved.
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

-- Convert screen-pixel offsets into map-coordinate offsets.
-- options = {
--   projection = "isometric" | "net_games", -- default "isometric"
--   tile_width = 64, tile_height = 32,
--   z_correction = { enabled=true, child_z=3, scale=0.5 },
--   anti_jitter = true | { denominator=32, difference_steps=16 }
-- }
--
-- isometric: sx/tile_width + sy/tile_height, -sx/tile_width + sy/tile_height
-- net_games: (2*sy - sx)/64, (2*sy + sx)/64 before Z correction.
-- For the NetGames mode, tile_width/tile_height are intentionally not used,
-- matching the existing convertOffsets() implementation's fixed divisor 64.
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
    local map_offset

    if projection == "isometric" then
        local tile_width = tonumber(options.tile_width) or DEFAULT_TILE_WIDTH
        local tile_height = tonumber(options.tile_height) or DEFAULT_TILE_HEIGHT
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

    local z_options = options.z_correction
    if z_options == true then z_options = { enabled = true } end
    if type(z_options) == "table" and z_options.enabled ~= false then
        local child_z = number_or_nil(z_options.child_z)
        if child_z == nil then
            -- Convenience: calculate the child's absolute Z from the parent's
            -- Z plus the intended vertical separation when child_z isn't given.
            local parent_z = tonumber(z_options.parent_z) or 0
            local z_offset = tonumber(z_options.z_offset) or 0
            child_z = parent_z + z_offset
        end
        local scale = tonumber(z_options.scale) or 0.5
        local correction = child_z * scale
        map_offset.x = map_offset.x + correction
        map_offset.y = map_offset.y + correction
    end

    local anti_jitter = options.anti_jitter
    if anti_jitter then
        local quantized, quantize_error = WorldAttachment.quantize_map_offset(
            map_offset,
            type(anti_jitter) == "table" and anti_jitter or nil
        )
        if not quantized then return nil, quantize_error end
        map_offset = quantized
    end

    return map_offset
end

function WorldAttachment.point_to_map_offset(frame, point, options)
    local pixel_offset, point_error, meta = WorldAttachment.point_to_pixel_offset(frame, point)
    if not pixel_offset then return nil, point_error end

    local map_offset, map_error = WorldAttachment.pixel_offset_to_map(pixel_offset, options)
    if not map_offset then return nil, map_error end

    meta = meta or {}
    meta.screen_offset_x, meta.screen_offset_y = pixel_offset.x, pixel_offset.y
    return map_offset, nil, meta
end

-- Add a map offset to a parent's position. `z_offset` controls the child's
-- actual vertical separation; it is deliberately separate from z_correction,
-- which only compensates X/Y to match NetGames' convention.
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

-- Convenience for a moving attachment. Re-run this on each parent movement so
-- Z correction follows elevation changes instead of being cached at creation.
-- The z_correction.child_z is recalculated from parent_position.z + z_offset.
function WorldAttachment.follow_position(parent_position, screen_offset, options)
    if type(parent_position) ~= "table" then
        return nil, "parent position is missing"
    end
    options = options or {}

    -- Copy options to avoid mutating the caller's nested configuration.
    local local_options = {}
    for key, value in pairs(options) do local_options[key] = value end
    local z_options = options.z_correction
    if z_options == true then z_options = { enabled = true } end
    if type(z_options) == "table" and z_options.enabled ~= false then
        local local_z = {}
        for key, value in pairs(z_options) do local_z[key] = value end
        local parent_z = tonumber(parent_position.z) or 0
        local z_offset = tonumber(options.z_offset) or tonumber(local_z.z_offset) or 0
        local_z.parent_z = parent_z
        local_z.z_offset = z_offset
        local_z.child_z = parent_z + z_offset
        local_options.z_correction = local_z
    end

    local map_offset, map_error = WorldAttachment.pixel_offset_to_map(screen_offset, local_options)
    if not map_offset then return nil, map_error end
    return WorldAttachment.target_position(parent_position, map_offset, options)
end

return WorldAttachment
