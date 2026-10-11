-- camera_sequence.lua
local CameraSequence = {}

-- Play a camera sequence for a player, using points of interest as waypoints.
-- If a point has custom properties "CameraDuration" and "CameraEase", they will be used.
function CameraSequence.play(instance, player, start_point)
    local points = instance.points_of_interest
    if not points or #points == 0 then
        -- fallback: just show start point
        Net.move_player_camera(player.id, start_point.x, start_point.y, start_point.z, 0.7)
        return 0.7
    end

    local total_time = 0
    local slide_time = 0.5
    local hold_time = 0.7

    -- Move to start point first
    Net.move_player_camera(player.id, start_point.x, start_point.y, start_point.z, hold_time)
    total_time = total_time + hold_time

    for _, point in ipairs(points) do
        local duration = tonumber(point.custom_properties["CameraDuration"]) or slide_time
        Net.slide_player_camera(player.id, point.x, point.y, point.z, duration)
        Net.move_player_camera(player.id, point.x, point.y, point.z, hold_time)
        total_time = total_time + duration + hold_time
    end

    -- Return to start
    Net.slide_player_camera(player.id, start_point.x, start_point.y, start_point.z, slide_time)
    Net.unlock_player_camera(player.id)
    total_time = total_time + slide_time

    return total_time
end

return CameraSequence