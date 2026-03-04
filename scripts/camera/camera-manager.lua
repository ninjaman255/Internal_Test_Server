-- CameraManager.lua
local CameraManager = {}

local PlayerControllers = {}
CameraManager.PlayerControllers = PlayerControllers

local CameraController = require("scripts/camera/camera-controller")

function CameraManager:init(handle_on_join, tile_interaction, setup_inputs)
    -- Set up event listeners
    self:setup_event_listeners(handle_on_join, tile_interaction, setup_inputs)
end

function CameraManager:setup_event_listeners(handle_on_join, tile_interaction, setup_inputs)
    pcall(handle_on_join)
    pcall(tile_interaction)
    pcall(setup_inputs)
end

-- Public API to get controller for a player
function CameraManager:get_controller(player_id)
    if not player_id then
        print("ERROR: get_controller called without player_id")
        return nil
    end
    return PlayerControllers[player_id]
end

-- Public API to activate camera for a player
-- Now accepts an optional third parameter `lock_input` (default true)
function CameraManager:activate_camera(player_id, is_player_controlled, lock_input)
    if not player_id then
        print("ERROR: activate_camera called without player_id")
        return false
    end

    local controller = PlayerControllers[player_id]
    if not controller then
        print("ERROR: No camera controller found for player " .. player_id)
        return false
    end

    -- Pass lock_input to the controller (default true if nil)
    controller:activate(is_player_controlled, lock_input)

    print("Camera activated for player " .. player_id)
    return true
end

-- Public API to deactivate camera for a player
function CameraManager:deactivate_camera(player_id, keep_camera_position)
    if not player_id then
        print("ERROR: deactivate_camera called without player_id")
        return false
    end

    local controller = self:get_controller(player_id)
    if not controller then
        print("ERROR: No camera controller found for player " .. player_id)
        return false
    end

    controller:deactivate(keep_camera_position)
    print("Camera deactivated for player " .. player_id)
    return true
end

-- Check if player's camera is active
function CameraManager:is_camera_active(player_id)
    if not player_id then
        print("ERROR: is_camera_active called without player_id")
        return false
    end
    local controller = PlayerControllers[player_id]
    return controller and controller.player_in_control or false
end

-- Check if player's camera has a pending move
function CameraManager:has_pending_move(player_id)
    if not player_id then
        print("ERROR: has_pending_move called without player_id")
        return false
    end
    local controller = PlayerControllers[player_id]
    return controller and controller:hasPendingMove() or false
end

-- API method to move camera programmatically
function CameraManager:move_camera(player_id, x, y, z)
    if not player_id then
        print("ERROR: move_camera called without player_id")
        return false
    end
    local controller = PlayerControllers[player_id]
    if not controller then
        print("ERROR: No camera controller found for player " .. player_id)
        return false
    end
    controller:moveTo(x, y, z)
    return true
end

-- API method to pan camera programmatically
function CameraManager:pan_camera(player_id, dx, dy, dz)
    if not player_id then
        print("ERROR: pan_camera called without player_id")
        return false
    end
    local controller = PlayerControllers[player_id]
    if not controller then
        print("ERROR: No camera controller found for player " .. player_id)
        return false
    end
    controller:pan(dx, dy, dz)
    return true
end

-- API method to get camera position
function CameraManager:get_camera_position(player_id)
    if not player_id then
        print("ERROR: get_camera_position called without player_id")
        return nil
    end
    local controller = PlayerControllers[player_id]
    if not controller then
        print("ERROR: No camera controller found for player " .. player_id)
        return nil
    end
    return controller:getPosition()
end

-- API method to get pending camera position
function CameraManager:get_pending_camera_position(player_id)
    if not player_id then
        print("ERROR: get_pending_camera_position called without player_id")
        return nil
    end
    local controller = PlayerControllers[player_id]
    if not controller then
        print("ERROR: No camera controller found for player " .. player_id)
        return nil
    end
    return controller:getPendingPosition()
end

return CameraManager