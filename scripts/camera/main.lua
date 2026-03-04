-- main.lua (Entry Point)
local CameraManager = require("scripts/camera/camera-manager")
local Input = require("scripts/input/input")
local CameraController = require("scripts/camera/camera-controller")

-- Attach the global input listener once
Input.attach_virtual_input_listener()

-- Button lists (cancel still works for deactivation)
local cancel = { "Cancel", "Shoot", "Run" }

local setupPlayerJoin = function()
    Net:on("player_join", function(event)
        -- Net.lock_player_input(event.player_id)
        if not event.player_id then
            print("ERROR: player_join event missing player_id")
            return
        end

        local keep_input_locked = false
        print("Player joined: " .. event.player_id)

        -- Create and cache controller for this player
        CameraManager.PlayerControllers[event.player_id] = CameraController:new(event.player_id, keep_input_locked)
    end)
end

local setupTileInteraction = function()
    Net:on("tile_interaction", function (event)
        -- Only react to left mouse button (button 1)
        if event.button ~= 1 then return end

        local player_camera = CameraManager:get_controller(event.player_id)
        if player_camera and not player_camera.active then
            -- Activate camera WITHOUT locking player input (third parameter = false)
            CameraManager:activate_camera(event.player_id, true, true)
        end
    end)
end

local setupInputs = function()
    Net:on("virtual_input", function(event)
        local player_id = event.player_id
        local controller = CameraManager.PlayerControllers[player_id]
        if not controller then
            return
        end

        -- Deactivate camera on Cancel press (edge)
        if controller.active and Input.pop(player_id, "cancel") then
            controller:deactivate()
        end

        -- Only process movement if player is in control
        if not controller.player_in_control then
            return
        end

        -- Skip if a move is already pending
        if controller:hasPendingMove() then
            print("Camera move pending for player " .. player_id .. ", skipping input")
            return
        end

        -- Handle input (uses Input.get_active_direction)
        controller:handle_input()
    end)
end

-- Initialize the camera system
CameraManager:init(setupPlayerJoin, setupTileInteraction, setupInputs)

return CameraManager