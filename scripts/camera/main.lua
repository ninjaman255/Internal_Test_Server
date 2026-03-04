-- main.lua (Entry Point)

-- 1. Set up the new input module (listener must be attached before CameraManager's listener)
local Input = require("scripts/input/input")
Input.attach_virtual_input_listener()   -- uses default bindings (includes directions)

-- 2. Initialise the camera system
local CameraManager = require("scripts/camera/camera-manager")
local cancel = { "Cancel", "Shoot", "Run" }
CameraManager:init(cancel)

-- The system now:
-- - Uses Input for robust direction detection (including combos and memory)
-- - Activates camera on L press only if not already active
-- - Deactivates correctly with the keep_camera_position flag

return CameraManager