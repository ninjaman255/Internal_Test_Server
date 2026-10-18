-- Convert animation-frame points into offsets from a bot's rendered origin.
-- Animation points are pixel offsets in screen space; Net bot positions use
-- isometric map coordinates (tile units), so use to_map_offset before moving a bot.
local AnimationPoints = {}

local function is_flipped(value)
    return tonumber(value) == 1 or value == true or value == "1"
end

function AnimationPoints.offset(frame, point)
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

    -- Mirror BOTH the point and pivot within the frame bounds. This preserves
    -- their relative offset and correctly handles points away from the center.
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
        frame_width = width, frame_height = height,
        origin_x = origin_x, origin_y = origin_y,
        point_x = point_x, point_y = point_y,
        flipped_x = flip_x, flipped_y = flip_y,
    }
end

-- OpenNetBattle's default isometric projection is:
--   screen_x = (map_x - map_y) * tile_width / 2
--   screen_y = (map_x + map_y) * tile_height / 2
-- Invert it so a pixel-space animation point does not get mistaken for a
-- map-space distance (which can move a bot many tiles away).
function AnimationPoints.to_map_offset(screen_offset, tile_width, tile_height)
    if type(screen_offset) ~= "table" then
        return nil, "screen offset is missing"
    end
    local sx, sy = tonumber(screen_offset.x), tonumber(screen_offset.y)
    tile_width, tile_height = tonumber(tile_width), tonumber(tile_height)
    if sx == nil or sy == nil then
        return nil, "screen offset has non-numeric x/y"
    end
    if not tile_width or tile_width <= 0 or not tile_height or tile_height <= 0 then
        return nil, "invalid map tile dimensions"
    end

    return {
        x = sx / tile_width + sy / tile_height,
        y = -sx / tile_width + sy / tile_height,
    }
end

return AnimationPoints
