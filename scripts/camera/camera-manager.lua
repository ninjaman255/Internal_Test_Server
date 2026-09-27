-- CameraManager.lua
local CameraManager = {}
CameraManager.DEBUG = true   -- set false once diagnosed

local PlayerControllers = {}
CameraManager.PlayerControllers = PlayerControllers

local CameraController = require("scripts/camera/camera-controller")
local PredefinedEnums = require("scripts/enum/predefined-enums")
local CameraMode = PredefinedEnums.CameraMode

local function dbg(...)
    if CameraManager.DEBUG then
        print("[CAMMGR]", ...)
    end
end

function CameraManager:init(handle_on_join, tile_interaction, setup_inputs)
    self:setup_event_listeners(handle_on_join, tile_interaction, setup_inputs)
end

function CameraManager:setup_event_listeners(handle_on_join, tile_interaction, setup_inputs)
    if handle_on_join then pcall(handle_on_join) end
    if tile_interaction then pcall(tile_interaction) end
    if setup_inputs then pcall(setup_inputs) end
end

function CameraManager:get_controller(player_id)
    if not player_id then
        print("ERROR: get_controller called without player_id")
        return nil
    end
    return PlayerControllers[player_id]
end

function CameraManager:activate_camera(player_id, mode, lock_input)
    dbg("activate_camera: ENTER player=", tostring(player_id),
        "mode=", tostring(mode),
        "lock_input=", tostring(lock_input))

    if not player_id then
        print("ERROR: activate_camera called without player_id")
        return false
    end

    local controller = PlayerControllers[player_id]
    if not controller then
        print("ERROR: No camera controller found for player " .. tostring(player_id))
        return false
    end

    dbg("activate_camera: found controller, is_active=", tostring(controller.is_active))

    controller:activate(mode, lock_input)
    dbg("activate_camera: EXIT player=", tostring(player_id),
        "is_active now=", tostring(controller.is_active))
    return true
end

function CameraManager:deactivate_camera(player_id, keep_camera_position)
    if not player_id then
        print("ERROR: deactivate_camera called without player_id")
        return false
    end
    local controller = self:get_controller(player_id)
    if not controller then
        print("ERROR: No camera controller found for player " .. tostring(player_id))
        return false
    end
    controller:deactivate(keep_camera_position)
    print("Camera deactivated for player " .. tostring(player_id))
    return true
end

function CameraManager:is_camera_active(player_id)
    if not player_id then
        print("ERROR: is_camera_active called without player_id")
        return false
    end
    local controller = PlayerControllers[player_id]
    return controller and controller.is_active or false
end

function CameraManager:has_pending_move(player_id)
    if not player_id then
        print("ERROR: has_pending_move called without player_id")
        return false
    end
    local controller = PlayerControllers[player_id]
    return controller and controller:hasPendingMove() or false
end

function CameraManager:move_camera(player_id, x, y, z)
    if not player_id then
        print("ERROR: move_camera called without player_id")
        return false
    end
    local controller = PlayerControllers[player_id]
    if not controller then
        print("ERROR: No camera controller found for player " .. tostring(player_id))
        return false
    end
    controller:moveTo(x, y, z)
    return true
end

function CameraManager:pan_camera(player_id, dx, dy, dz)
    if not player_id then
        print("ERROR: pan_camera called without player_id")
        return false
    end
    local controller = PlayerControllers[player_id]
    if not controller then
        print("ERROR: No camera controller found for player " .. tostring(player_id))
        return false
    end
    controller:pan(dx, dy, dz)
    return true
end

function CameraManager:get_camera_position(player_id)
    if not player_id then
        print("ERROR: get_camera_position called without player_id")
        return nil
    end
    local controller = PlayerControllers[player_id]
    if not controller then
        print("ERROR: No camera controller found for player " .. tostring(player_id))
        return nil
    end
    return controller:getPosition()
end

function CameraManager:get_pending_camera_position(player_id)
    if not player_id then
        print("ERROR: get_pending_camera_position called without player_id")
        return nil
    end
    local controller = PlayerControllers[player_id]
    if not controller then
        print("ERROR: No camera controller found for player " .. tostring(player_id))
        return nil
    end
    return controller:getPendingPosition()
end

return CameraManager