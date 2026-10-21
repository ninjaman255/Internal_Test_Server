-- Backwards-compatible FootBomb animation-point helpers.
-- Coordinate conversion is implemented centrally by world-attachment.lua so
-- FootBomb and Net Games cannot drift into separate flip/projection math.
local WorldAttachment = require("scripts/world-attachment")
local AnimationPoints = {}

function AnimationPoints.offset(frame, point)
    return WorldAttachment.point_to_pixel_offset(frame, point)
end

function AnimationPoints.to_map_offset(screen_offset, tile_width, tile_height)
    return WorldAttachment.pixel_offset_to_map(screen_offset, {
        projection = "isometric",
        tile_width = tile_width or 64,
        tile_height = tile_height or 32,
        anti_jitter = false,
    })
end

return AnimationPoints
