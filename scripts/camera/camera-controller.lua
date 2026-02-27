local DPad = require("scripts/camera/d-pad")
-- CameraController.lua
local CameraController = {}

local X_CAMERA_ADJUST = 0.05
local Y_CAMERA_ADJUST = 0.05


function CameraController:new(player_id)
    local controller = {
        player_id = player_id,
        player_input_locked = false,
        player_in_control = false,
        current_position = {x = 0, y = 0, z = 100},  -- Current confirmed position
        pending_position = nil,                      -- Position we're trying to move to
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
    self.pending_position = nil  -- Clear any pending position
    self.active = true
    -- Initialize camera at player position
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
    self.pending_position = nil  -- Clear any pending position
    self.active = false
    if keep_camera_position ~= nil or keep_camera_position ~= true then
        Net.unlock_player_camera(self.player_id)
        Net.track_with_player_camera(self.player_id)    
    end
    Net.unlock_player_input(self.player_id)
    -- print("Camera deactivated for player " .. self.player_id)
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

function CameraController:handle_input(event)
    if not self.player_in_control or not self.player_input_locked then
        return
    end

    -- print(event)
    
    local new_x = self.current_position.x
    local new_y = self.current_position.y
    -- local normalized_position = {x = self.current_position.x, y = self.current_position.y}
    local moved = false

    local d = DPad.getActiveDirection(event.events, event.player_id)
    print(d)
    if d == "UpLeft" then
    new_x = self.current_position.x - X_CAMERA_ADJUST
    new_y = self.current_position.y
    -- new_x = self.current_position.x - (X_CAMERA_ADJUST * .5)
    -- new_y = self.current_position.y - (Y_CAMERA_ADJUST * .5)
    moved = true    
    elseif d == "DownLeft" then
    new_x = self.current_position.x
    new_y = self.current_position.y + Y_CAMERA_ADJUST
    -- new_x = self.current_position.x - (X_CAMERA_ADJUST * .5)
    -- new_y = self.current_position.y + Y_CAMERA_ADJUST
    moved = true    
    elseif d == "DownRight" then
    new_x = self.current_position.x + X_CAMERA_ADJUST
    new_y = self.current_position.y 
    -- new_x = self.current_position.x + (X_CAMERA_ADJUST * .5)
    -- new_y = self.current_position.y + (Y_CAMERA_ADJUST * .5)
    moved = true    
    elseif d == "UpRight" then
    new_x = self.current_position.x
    new_y = self.current_position.y - Y_CAMERA_ADJUST
    -- new_x = self.current_position.x + (X_CAMERA_ADJUST * .5)
    -- new_y = self.current_position.y - Y_CAMERA_ADJUST
    moved = true    
    elseif d == "Down" then
    new_x = self.current_position.x + Y_CAMERA_ADJUST
    new_y = self.current_position.y + Y_CAMERA_ADJUST
    moved = true    
    elseif d == "Up" then
    new_x = self.current_position.x - Y_CAMERA_ADJUST
    new_y = self.current_position.y - Y_CAMERA_ADJUST
    moved = true    
    elseif d == "Left" then
    new_x = self.current_position.x - (X_CAMERA_ADJUST / 2)
    new_y = self.current_position.y + (Y_CAMERA_ADJUST / 2)
    moved = true    
    elseif d == "Right" then
    new_x = self.current_position.x + (X_CAMERA_ADJUST / 2)
    new_y = self.current_position.y - (Y_CAMERA_ADJUST / 2)
    moved = true
    end

    --for i = 1, #event.events do
    --    local btn = event.events[i]
    --    -- Handle movement based on button state
    --    if btn.state == 1 or btn.state == 2  then  -- Button pressed/held state
    --        if btn.name == "UI Left" or btn.name == "Move Left" then
    --            -- local normalized = normalizeMovement(X_CAMERA_ADJUST, Y_CAMERA_ADJUST)
    --            -- print(normalized)
    --            -- new_x = self.current_position.x - X_CAMERA_ADJUST
    --            -- normalized_position.x = self.current_position.x + left_adjust.x
    --            -- normalized_position.y = self.current_position.y + left_adjust.y
    --            moved = true
    --        elseif btn.name == "UI Right" or btn.name == "Move Right" then
    --            new_x = self.current_position.x + X_CAMERA_ADJUST
    --            moved = true
    --        elseif btn.name == "UI Up" or btn.name == "Move Up" then
    --            new_y = self.current_position.y - Y_CAMERA_ADJUST
    --            moved = true
    --        elseif btn.name == "UI Down" or btn.name == "Move Down" then
    --            new_y = self.current_position.y + Y_CAMERA_ADJUST
    --            moved = true
    --        end
    --    end
    --end
    
    -- Move camera to new position only if we actually need to move
    if moved then
        print("Current position: ", self.current_position)
        self:moveTo(new_x, new_y, self.current_position.z)
        moved = false
    end
end

function CameraController:moveTo(x, y, z)
    -- Set pending position
    print("MOVE TO RAN")
    self.pending_position = {
        x = x,
        y = y,
        z = z or self.current_position.z or 100
    }
    
    -- Move the player camera
    Net.move_player_camera(self.player_id, x, y, z or self.current_position.z or 100)
    
    -- Update current position to the pending position
    self.current_position = self.pending_position
    self.pending_position = nil  -- Clear pending position
    
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
    self.pending_position = nil  -- Clear any pending position when setting directly
end

function CameraController:getPosition()
    -- Return a copy of the current position
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