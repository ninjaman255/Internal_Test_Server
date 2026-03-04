-- CameraController.lua
local Input = require("scripts/input/input")   -- <-- new input module

local CameraController = {}

local X_CAMERA_ADJUST = 0.05
local Y_CAMERA_ADJUST = 0.05

function CameraController:new(player_id)
    local controller = {
        player_id = player_id,
        player_input_locked = false,
        player_in_control = false,
        current_position = {x = 0, y = 0, z = 100},
        pending_position = nil,
        move_speed = 2.0,
        active = false,
    }
    setmetatable(controller, self)
    self.__index = self
    return controller
end

function CameraController:activate(is_player_controlled)
    if is_player_controlled ~= nil then
        self.player_in_control = is_player_controlled
    end
    self.player_input_locked = true
    self.player_in_control = true
    self.pending_position = nil
    self.active = true
    local player_pos = Net.get_player_position(self.player_id)
    self.current_position = {x = player_pos.x, y = player_pos.y, z = player_pos.z}
    print("Camera activated for player " .. self.player_id)
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

function CameraController:deactivate(keep_camera_position)
    self.player_input_locked = false
    self.player_in_control = false
    self.pending_position = nil
    self.active = false
    -- Fixed condition: return to player only if keep_camera_position is not true
    if not keep_camera_position then
        Net.unlock_player_camera(self.player_id)
        Net.track_with_player_camera(self.player_id)
    end
    Net.unlock_player_input(self.player_id)
    return true
end

function table.contains(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

local function normalizeMovement(x, y)
    local dirX = x or 0
    local dirY = y or 0
    local magnitude = math.sqrt(dirX * dirX + dirY * dirY)
    if magnitude == 0 then
        return 0, 0
    end
    return dirX / magnitude, dirY / magnitude
end

function CameraController:handle_input(event)   -- event param kept for compatibility, but no longer used
    if not self.player_in_control or not self.player_input_locked then
        return
    end

    local new_x = self.current_position.x
    local new_y = self.current_position.y
    local moved = false

    -- Get active direction from Input module (returns lowercase strings)
    local direction = Input.get_active_direction(self.player_id)
    print("Direction:", direction)

    if direction == "upleft" then
        new_x = self.current_position.x - X_CAMERA_ADJUST
        new_y = self.current_position.y
        moved = true
    elseif direction == "downleft" then
        new_x = self.current_position.x
        new_y = self.current_position.y + Y_CAMERA_ADJUST
        moved = true
    elseif direction == "downright" then
        new_x = self.current_position.x + X_CAMERA_ADJUST
        new_y = self.current_position.y
        moved = true
    elseif direction == "upright" then
        new_x = self.current_position.x
        new_y = self.current_position.y - Y_CAMERA_ADJUST
        moved = true
    elseif direction == "down" then
        new_x = self.current_position.x + Y_CAMERA_ADJUST
        new_y = self.current_position.y + Y_CAMERA_ADJUST
        moved = true
    elseif direction == "up" then
        new_x = self.current_position.x - Y_CAMERA_ADJUST
        new_y = self.current_position.y - Y_CAMERA_ADJUST
        moved = true
    elseif direction == "left" then
        new_x = self.current_position.x - (X_CAMERA_ADJUST / 2)
        new_y = self.current_position.y + (Y_CAMERA_ADJUST / 2)
        moved = true
    elseif direction == "right" then
        new_x = self.current_position.x + (X_CAMERA_ADJUST / 2)
        new_y = self.current_position.y - (Y_CAMERA_ADJUST / 2)
        moved = true
    end

    if moved then
        print("Current position: ", self.current_position)
        self:moveTo(new_x, new_y, self.current_position.z)
    end
end

function CameraController:moveTo(x, y, z)
    print("MOVE TO RAN")
    self.pending_position = {
        x = x,
        y = y,
        z = z or self.current_position.z or 100
    }
    Net.move_player_camera(self.player_id, x, y, z or self.current_position.z or 100)
    self.current_position = self.pending_position
    self.pending_position = nil
    print("Camera moved to: ", self.current_position)
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

return CameraController