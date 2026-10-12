-- main.lua (Entry Point)
local CameraManager = require("scripts/camera/camera-manager")
local CameraController = require("scripts/camera/camera-controller")
local PredefinedEnums = require("scripts/enum/predefined-enums")
local InputAPI = require("scripts/input-controller/main")
local CameraMode = PredefinedEnums.CameraMode

local DBG = false
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
    Net:on("tile_interaction", function(event)
        local player_id = event.player_id
        local player_camera = CameraManager:get_controller(player_id)
        local input = InputAPI.get_controller(player_id)
        local input_owner = input and type(input.get_input_owner) == "function"
            and input:get_input_owner() or nil

        local area_id = nil
        if player_id and type(Net.get_player_area) == "function" then
            local ok, value = pcall(Net.get_player_area, player_id)
            if ok then area_id = value end
        end

        dbg("tile_interaction: player=", tostring(player_id),
            "area=", tostring(area_id),
            "button=", tostring(event.button),
            "camera_controller=", tostring(player_camera),
            "input_controller=", tostring(input),
            "controller=", tostring(player_camera ~= nil),
            "is_active=", tostring(player_camera and player_camera.is_active),
            "input_owner=", tostring(input_owner))

        if event.button ~= 1 then
            dbg("tile_interaction: ignoring non-left button")
            return
        end

        -- FootBomb deliberately moves the real player actor off-map and uses
        -- a separate bot-follow camera. Do not activate the free camera from
        -- tile interactions anywhere inside a FootBomb match area, even if
        -- the input controller has not yet been claimed when this event fires.
        -- This context guard is intentionally stronger than the ownership
        -- guard below because the logs showed owner=nil at interaction time.
        if type(area_id) == "string" and area_id:match("^footbomb[_%-]") then
            dbg("tile_interaction: skipping camera activation inside FootBomb area", tostring(area_id))
            return
        end

        -- In other areas, do not let the camera steal input from a different
        -- active owner.
        if input_owner ~= nil and input_owner ~= player_camera then
            dbg("tile_interaction: skipping camera activation; input owned by another system")
            return
        end

        if player_camera and not player_camera.is_active then
            dbg("tile_interaction: activating camera for player", tostring(player_id))
            local activated = CameraManager:activate_camera(player_id, CameraMode.Custom, true)
            dbg("tile_interaction: activation result=", tostring(activated))
        else
            dbg("tile_interaction: skipped activation (active=",
                tostring(player_camera and player_camera.is_active), ")")
        end
    end)
end

CameraManager:init(setupPlayerJoin, setupTileInteraction)

return CameraManager
