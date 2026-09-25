-- camera-controller.lua
-- Unified camera controller with mode‑based input handling.
-- Uses the CameraMode enum from predefined-enums.

local Input = require("scripts/input/input")
local PredefinedEnums = require("scripts/enum/predefined-enums")
local CameraMode = PredefinedEnums.CameraMode

local CameraController = {}

-- Movement constants (unchanged)
local X_CAMERA_ADJUST = 0.05
local Y_CAMERA_ADJUST = 0.05

-- Directions that require a release before becoming active again
local CAMERA_DIRECTIONS = {
    "left", "right", "up", "down",
    "upleft", "upright", "downleft", "downright"
}

-- --------------------------------------------------------------------------
-- Private helper – the actual player‑controlled movement logic
-- --------------------------------------------------------------------------
local function handle_player_controlled_movement(self)
    local d = Input.get_active_direction(self.player_id)
    if not d then return end

    local new_x = self.current_position.x
    local new_y = self.current_position.y
    local moved = false

    -- Keep the original movement mapping exactly as it was
    if d == "upleft" then
        new_x = self.current_position.x - X_CAMERA_ADJUST
        new_y = self.current_position.y
        moved = true
    elseif d == "downleft" then
        new_x = self.current_position.x
        new_y = self.current_position.y + Y_CAMERA_ADJUST
        moved = true
    elseif d == "downright" then
        new_x = self.current_position.x + X_CAMERA_ADJUST
        new_y = self.current_position.y
        moved = true
    elseif d == "upright" then
        new_x = self.current_position.x
        new_y = self.current_position.y - Y_CAMERA_ADJUST
        moved = true
    elseif d == "down" then
        new_x = self.current_position.x + Y_CAMERA_ADJUST
        new_y = self.current_position.y + Y_CAMERA_ADJUST
        moved = true
    elseif d == "up" then
        new_x = self.current_position.x - Y_CAMERA_ADJUST
        new_y = self.current_position.y - Y_CAMERA_ADJUST
        moved = true
    elseif d == "left" then
        new_x = self.current_position.x - (X_CAMERA_ADJUST / 2)
        new_y = self.current_position.y + (Y_CAMERA_ADJUST / 2)
        moved = true
    elseif d == "right" then
        new_x = self.current_position.x + (X_CAMERA_ADJUST / 2)
        new_y = self.current_position.y - (Y_CAMERA_ADJUST / 2)
        moved = true
    end

    if moved then
        self:moveTo(new_x, new_y, self.current_position.z)
    end
end

-- --------------------------------------------------------------------------
-- Constructor
-- --------------------------------------------------------------------------
function CameraController:new(player_id, opts)
    opts = opts or {}
    local mode = opts.mode or CameraMode.PlayerControlled
    -- Validate that the provided mode is one of the enum values
    assert(CameraMode:isValid(mode), "Invalid CameraMode for controller")

    local controller = {
        player_id = player_id,

        -- Mode and custom handlers
        mode = mode,
        custom_handlers = opts.custom_handlers or nil,  -- { onInput, onActivate, onDeactivate }

        -- State
        is_active = false,
        input_locked = false,          -- whether player movement is locked (via Net)
        keep_player_input_locked = opts.keep_player_input_locked or false,

        -- Position
        current_position = { x = 0, y = 0, z = 100 },
        pending_position = nil,

        -- Misc
        camera_color = { r = 255, g = 255, b = 255, a = 0 },
    }

    setmetatable(controller, self)
    self.__index = self
    return controller
end

-- --------------------------------------------------------------------------
-- Activation / Deactivation
-- --------------------------------------------------------------------------
function CameraController:activate(mode, lock_player_input)
    -- Use provided mode or fall back to current mode
    local new_mode = mode or self.mode
    assert(CameraMode:isValid(new_mode), "Invalid CameraMode for activation")
    self.mode = new_mode

    -- Lock / unlock player input according to the caller
    local should_lock = (lock_player_input == nil) and true or lock_player_input
    self.input_locked = should_lock
    if should_lock then
        Net.lock_player_input(self.player_id)
    else
        Net.unlock_player_input(self.player_id)
    end

    -- Ensure camera is not tracking player by default (we manage its position)
    Net.unlock_player_camera(self.player_id)

    -- Require all directional keys to be released before they can affect the camera
    Input.require_release(self.player_id, CAMERA_DIRECTIONS)

    -- Set initial camera position to player's current position
    local player_pos = Net.get_player_position(self.player_id)
    self.current_position = { x = player_pos.x, y = player_pos.y, z = player_pos.z }

    self.is_active = true
    self.pending_position = nil

    -- Call custom activation handler if present
    if self.mode == CameraMode.Custom and self.custom_handlers and self.custom_handlers.onActivate then
        self.custom_handlers.onActivate(self)
    end

    print("Camera activated for player " .. self.player_id ..
          " (mode: " .. tostring(CameraMode:getName(self.mode)) ..
          ", input locked: " .. tostring(should_lock) .. ")")
end

function CameraController:deactivate(keep_camera_position)
    if not self.is_active then
        return
    end

    self.is_active = false
    self.pending_position = nil

    if keep_camera_position ~= true then
        -- Return camera to follow the player
        Net.unlock_player_camera(self.player_id)
        Net.track_with_player_camera(self.player_id)
    end

    -- Unlock player input unless we are told to keep it locked
    if not self.keep_player_input_locked then
        Net.unlock_player_input(self.player_id)
        self.input_locked = false
    end

    -- Call custom deactivation handler
    if self.mode == CameraMode.Custom and self.custom_handlers and self.custom_handlers.onDeactivate then
        self.custom_handlers.onDeactivate(self)
    end

    print("Camera deactivated for player " .. self.player_id)
    return true
end

function CameraController:returnToPlayer()
    if self.is_active then
        local pos = Net.get_player_position(self.player_id)
        self:moveTo(pos.x, pos.y, pos.z)
    else
        Net.unlock_player_camera(self.player_id)
        Net.track_with_player_camera(self.player_id)
    end
end

-- --------------------------------------------------------------------------
-- Input handling (called every frame from virtual_input listener)
-- --------------------------------------------------------------------------
function CameraController:handle_input()
    if not self.is_active then
        return
    end

    -- Skip if a move is already pending (prevent over‑writing)
    if self:hasPendingMove() then
        return
    end

    if self.mode == CameraMode.PlayerControlled then
        handle_player_controlled_movement(self)
    elseif self.mode == CameraMode.Custom then
        if self.custom_handlers and self.custom_handlers.onInput then
            self.custom_handlers.onInput(self)
        end
    -- MiniMap and ServerControlled do nothing on input
    elseif self.mode == CameraMode.MiniMap or self.mode == CameraMode.ServerControlled then
        -- no‑op
    else
        error("Unknown camera mode: " .. tostring(self.mode))
    end
end

-- --------------------------------------------------------------------------
-- Mode switching
-- --------------------------------------------------------------------------
function CameraController:setMode(new_mode, custom_handlers)
    assert(CameraMode:isValid(new_mode), "Invalid CameraMode")
    self.mode = new_mode
    if custom_handlers then
        self.custom_handlers = custom_handlers
    end
    -- Force a release of current directions to avoid stuck input
    Input.require_release(self.player_id, CAMERA_DIRECTIONS)
end

function CameraController:setCustomHandlers(handlers)
    self.custom_handlers = handlers
end

-- --------------------------------------------------------------------------
-- Camera movement API (unchanged)
-- --------------------------------------------------------------------------
function CameraController:moveTo(x, y, z)
    self.pending_position = {
        x = x,
        y = y,
        z = z or self.current_position.z or 100
    }

    Net.move_player_camera(self.player_id, x, y, z or self.current_position.z or 100)

    self.current_position = self.pending_position
    self.pending_position = nil
end

function CameraController:relativeMoveTo(dx, dy, dz)
    local new_x = self.current_position.x + (dx or 0)
    local new_y = self.current_position.y + (dy or 0)
    local new_z = self.current_position.z + (dz or 0)
    self:moveTo(new_x, new_y, new_z)
end

function CameraController:pan(dx, dy, dz)
    self:relativeMoveTo(dx, dy, dz)
end

function CameraController:setPosition(new_x, new_y, new_z)
    self.current_position.x = new_x or self.current_position.x
    self.current_position.y = new_y or self.current_position.y
    self.current_position.z = new_z or self.current_position.z
    self.pending_position = nil
end

function CameraController:getPosition()
    return {
        x = self.current_position.x,
        y = self.current_position.y,
        z = self.current_position.z
    }
end

function CameraController:getPendingPosition()
    if self.pending_position then
        return {
            x = self.pending_position.x,
            y = self.pending_position.y,
            z = self.pending_position.z
        }
    end
    return nil
end

function CameraController:hasPendingMove()
    return self.pending_position ~= nil
end

-- --------------------------------------------------------------------------
-- Visual effects (unchanged)
-- --------------------------------------------------------------------------
function CameraController:fadePlayerCamera(color, durationInSeconds)
    local col = color or self.camera_color
    Net.fade_player_camera(self.player_id, col, durationInSeconds)
end

function CameraController:shakePlayerCamera(strength, durationInSeconds)
    Net.shake_player_camera(self.player_id, strength, durationInSeconds)
end

return CameraController