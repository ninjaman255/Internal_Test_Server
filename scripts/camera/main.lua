-- main.lua (Entry Point)
local CameraManager = require("scripts/camera/camera-manager")
local CameraController = require("scripts/camera/camera-controller")
local PredefinedEnums = require("scripts/enum/predefined-enums")
local CameraMode = PredefinedEnums.CameraMode

local DBG = true
local function dbg(...)
    if DBG then print("[CAMMAIN]", ...) end
end

-- Camera-specific input cadence. Tune these to change how fast the camera
-- moves while held. These apply only while the camera is active and are
-- reverted when it deactivates.
local CAMERA_FIRST_REPEAT_DELAY = 0.05
local CAMERA_REPEAT_DELAY = 0.03

local setupPlayerJoin = function()
    Net:on("player_join", function(event)
        dbg("player_join: player=", tostring(event.player_id),
            "existing_controller=", tostring(CameraManager.PlayerControllers[event.player_id] ~= nil))

        if not event.player_id then
            print("ERROR: player_join event missing player_id")
            return
        end

        if CameraManager.PlayerControllers[event.player_id] then
            dbg("player_join: controller already exists for player, skipping create")
            return
        end

        local keep_input_locked = false
        print("Player joined: " .. tostring(event.player_id))

        CameraManager.PlayerControllers[event.player_id] = CameraController:new(event.player_id, {
            mode = CameraMode.Custom,
            keep_player_input_locked = keep_input_locked,
            first_repeat_delay = CAMERA_FIRST_REPEAT_DELAY,
            repeat_delay = CAMERA_REPEAT_DELAY,
        })
    end)
end

local setupTileInteraction = function()
    Net:on("tile_interaction", function (event)
        dbg("tile_interaction: player=", tostring(event.player_id),
            "button=", tostring(event.button),
            "controller=", tostring(CameraManager.PlayerControllers[event.player_id] ~= nil),
            "is_active=", tostring(CameraManager.PlayerControllers[event.player_id]
                                   and CameraManager.PlayerControllers[event.player_id].is_active))

        if event.button ~= 1 then
            dbg("tile_interaction: ignoring non-left button")
            return
        end

        local player_camera = CameraManager:get_controller(event.player_id)
        if player_camera and not player_camera.is_active then
            dbg("tile_interaction: activating camera for player", tostring(event.player_id))
            CameraManager:activate_camera(event.player_id, CameraMode.Custom, true)
        else
            dbg("tile_interaction: skipped activation (active=",
                tostring(player_camera and player_camera.is_active), ")")
        end
    end)
end

CameraManager:init(setupPlayerJoin, setupTileInteraction)

return CameraManager