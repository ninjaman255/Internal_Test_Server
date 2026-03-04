local Input = require("scripts/input/input")
-- CameraController.lua
local CameraController = {}

local X_CAMERA_ADJUST = 0.05
local Y_CAMERA_ADJUST = 0.05

function CameraController.getPlayerInputStatus(player_id)
    return Net.is_player_input_locked(player_id)
end

-- activate now accepts an optional lock_input parameter (default true)
function CameraController:activate(is_player_controlled, lock_input)
    -- lock_input defaults to true if not provided
    local should_lock = (lock_input == nil) and true or lock_input

    if is_player_controlled ~= nil then
        self.player_in_control = is_player_controlled
    end

    self.player_input_locked = should_lock   -- store whether input is supposed to be locked
    self.player_in_control = true
    self.pending_position = nil
    self.active = true

    -- Lock/unlock according to should_lock
    if should_lock then
        Net.lock_player_input(self.player_id)
        Net.unlock_player_camera(self.player_id)
    else
        -- If we don't lock input, we still need to unlock the camera so it can move independently
        Net.unlock_player_camera(self.player_id)
        -- Player input remains free (no lock)
    end

    -- Initialize camera at player position
    local player_pos = Net.get_player_position(self.player_id)
    self.current_position = { x = player_pos.x, y = player_pos.y, z = player_pos.z }
    print("Camera activated for player " .. self.player_id .. " (input locked: " .. tostring(should_lock) .. ")")
end

function CameraController:returnToPlayer()
    if self.active == true then
        local position = Net.get_player_position(self.player_id)
        CameraController:moveTo(position.x, position.y, position.z)
    else
        Net.unlock_player_camera(self.player_id)
        Net.track_with_player_camera(self.player_id)
    end
end

function CameraController:fadePlayerCamera(color, durationInSeconds)
    local color = {
        r = color.r or self.camera_color.r,
        g = color.g or self.camera_color.g,
        b = color.b or self.camera_color.b,
        a = color.a or self.camera_color.a,
    }
    Net.fade_player_camera(self.player_id, color, durationInSeconds)
end

function CameraController:shakePlayerCamera(strength, durationInSeconds)
    Net.shake_player_camera(self.player_id, strength, durationInSeconds)
end

function CameraController:deactivate(keep_camera_position)
    self.player_input_locked = false
    self.player_in_control = false
    self.pending_position = nil
    self.active = false

    if keep_camera_position ~= nil or keep_camera_position ~= true then
        Net.unlock_player_camera(self.player_id)
        Net.track_with_player_camera(self.player_id)
    end

    if self.keep_player_input_locked ~= true then
        Net.unlock_player_input(self.player_id)
    end

    print("Camera deactivated for player " .. self.player_id)
    return true
end

function CameraController:handle_input()
    -- Note: player_input_locked now only affects whether we process camera movement.
    -- If it's false, we still process movement (the camera can be moved even if player input is free).
    -- This allows a "free camera" mode where the player can walk and move the camera independently.
    if not self.player_in_control then
        return
    end

    local new_x = self.current_position.x
    local new_y = self.current_position.y
    local moved = false

    local d = Input.get_active_direction(self.player_id)
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
        moved = false
    end
end

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

function CameraController:new(player_id, keep_player_input_locked)
    local keep_player_input_locked = keep_player_input_locked or false
    local status = self.getPlayerInputStatus(player_id)
    local controller = {
        player_id = player_id,
        player_input_locked = status,  -- actual lock state from Net
        player_in_control = false,
        current_position = { x = 0, y = 0, z = 100 },
        pending_position = nil,
        move_speed = 2.0,
        camera_color = { 255, 255, 255, 0 },
        active = false,
        keep_player_input_locked = keep_player_input_locked
    }

    setmetatable(controller, self)
    self.__index = self
    return controller
end

return CameraController