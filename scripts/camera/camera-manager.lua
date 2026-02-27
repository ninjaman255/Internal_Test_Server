-- CameraManager.lua
local CameraManager = {}
local PlayerControllers = {}

local CameraController = require("scripts/camera/camera-controller")

function CameraManager:init(deactivation_button_names)
    local deactivation_button_names = deactivation_button_names or {}
    -- Set up event listeners
    self:setup_event_listeners(deactivation_button_names)
end

function CameraManager:setupDefaultLMenu()
    Net:on("tile_interaction", function(event)
        if event.button ~= 1 then return end
        if self.active ~= false then
        -- local camera = self:get_controller(event.player_id)
            self:activate_camera(event.player_id, true)        
        end
    end)
end

function CameraManager:setupDefaultInputs(deactivation_button_names)
    -- Listen for virtual input events
    Net:on("virtual_input", function(event)
        if PlayerControllers[event.player_id].active ~= false then
            if deactivation_button_names ~= nil then
                for i = 1, #deactivation_button_names do
                    for j = 1, #event.events do
                        local btn = event.events[j]
                        if btn.state == 1 or btn.state == 2 then
                            if btn.name == deactivation_button_names[i] then
                                PlayerControllers[event.player_id]:deactivate()
                            end
                            break
                        end
                    end
                end
            end

        self:handle_virtual_input(event)
        end
    end)
end

function CameraManager:setup_event_listeners(deactivation_button_names)
    -- Listen for player join events
    Net:on("player_join", function(event)
        self:handle_player_join(event.player_id)
    end)
    
    self:setupDefaultInputs(deactivation_button_names)
    
    self:setupDefaultLMenu()
end

function CameraManager:handle_player_join(player_id)
    if not player_id then
        print("ERROR: player_join event missing player_id")
        return
    end
    
    print("Player joined: " .. player_id)
    
    -- Create and cache controller for this player
    PlayerControllers[player_id] = CameraController:new(player_id)
    
    -- Automatically activate camera for player
    -- self:activate_camera(player_id, true)
end

function CameraManager:handle_virtual_input(event)
    local player_id = event.player_id
    local controller = self:get_controller(player_id)
    
    -- Only process if player has a controller and is in control
    if not controller or not controller.player_in_control then
        return
    end
    
    -- Check if there's already a pending move
    if controller:hasPendingMove() then
        print("Camera move pending for player " .. player_id .. ", skipping input")
        return
    end
    print(controller)
    -- Handle input for this controller
    controller:handle_input(event)
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
function CameraManager:activate_camera(player_id, is_player_controlled)
    if not player_id then
        print("ERROR: activate_camera called without player_id")
        return false
    end
    
    local controller = PlayerControllers[player_id]
    if not controller then
        print("ERROR: No camera controller found for player " .. player_id)
        return false
    end
    
    -- Lock player input and unlock camera
    Net.lock_player_input(player_id)
    Net.unlock_player_camera(player_id)
    
    -- Activate the controller
    controller:activate(is_player_controlled)
    
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
    
    -- Unlock player input and track with player camera
    -- Net.track_with_player_camera(player_id)
    -- Net.unlock_player_input(player_id)
    
    -- Deactivate the controller
    
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