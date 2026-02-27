-- main.lua (Entry Point)
local CameraManager = require("scripts/camera/camera-manager")
local cancel = { "Cancel", "Shoot", "Run" }
-- Initialize the camera system
CameraManager:init(cancel)

-- That's it! The system now:
-- 1. Automatically creates camera controllers for each player on join
-- 2. Automatically activates camera control for players on L press.
-- 3. Handles input for camera movement
-- 4. Manages camera position updates

-- Optional: You can still use the CameraManager API if needed
return CameraManager
