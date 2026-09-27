-- camera-controller.lua
-- Unified camera controller with mode-based input handling.
-- Subscribes to the shared per-player InputController's emitter.
--
-- The camera applies its own repeat cadence to the shared InputController
-- while it is active, and restores the controller's configured defaults on
-- deactivate. This lets camera movement feel snappier without affecting any
-- other consumer of the same InputController.

local InputSystem = require("scripts/input-controller/main")
local PredefinedEnums = require("scripts/enum/predefined-enums")
local CameraMode = PredefinedEnums.CameraMode

local CameraController = {}
CameraController.DEBUG = true   -- set false once diagnosed

-- Movement constants
local X_CAMERA_ADJUST = 0.15
local Y_CAMERA_ADJUST = 0.15

-- Default repeat cadence the camera installs while active. Override per
-- controller via `opts.first_repeat_delay` / `opts.repeat_delay` on new().
local DEFAULT_CAMERA_FIRST_REPEAT_DELAY = 0.03
local DEFAULT_CAMERA_REPEAT_DELAY = 0.03

-- Canonical direction action names emitted by InputController.
local CAMERA_DIRECTIONS = {
    "Left", "Right", "Up", "Down",
    "UpLeft", "UpRight", "DownLeft", "DownRight",
}

local function dbg(...)
    if CameraController.DEBUG then
        print("[CAM]", ...)
    end
end

-- --------------------------------------------------------------------------
-- Default direction-driven movement.
-- --------------------------------------------------------------------------
local function handle_player_controlled_movement(self)
    if not self.input then
        dbg("movement: no input controller bound")
        return
    end

    local d = self.input:get_active_direction()
    dbg("movement: dir=", tostring(d),
        "release_required=", tostring(self.input.release_required[d]))

    if not d then return end
    if self.input.release_required[d] then
        dbg("movement: gated by require_release, skipping")
        return
    end

    local new_x = self.current_position.x
    local new_y = self.current_position.y
    local moved = false

    if d == "UpLeft" then
        new_x = self.current_position.x - X_CAMERA_ADJUST
        new_y = self.current_position.y
        moved = true
    elseif d == "DownLeft" then
        new_x = self.current_position.x
        new_y = self.current_position.y + Y_CAMERA_ADJUST
        moved = true
    elseif d == "DownRight" then
        new_x = self.current_position.x + X_CAMERA_ADJUST
        new_y = self.current_position.y
        moved = true
    elseif d == "UpRight" then
        new_x = self.current_position.x
        new_y = self.current_position.y - Y_CAMERA_ADJUST
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

    if moved then
        dbg("movement: moveTo", new_x, new_y, self.current_position.z)
        self:moveTo(new_x, new_y, self.current_position.z)
    else
        dbg("movement: unknown direction", tostring(d))
    end
end

local function emitter_off(emitter, event, cb)
    if type(emitter.off) == "function" then
        emitter:off(event, cb)
    elseif type(emitter.removeListener) == "function" then
        emitter:removeListener(event, cb)
    elseif type(emitter.remove) == "function" then
        emitter:remove(event, cb)
    else
        dbg("emitter_off: no removal method on emitter for", event)
    end
end

-- --------------------------------------------------------------------------
-- Constructor
-- --------------------------------------------------------------------------
function CameraController:new(player_id, opts)
    opts = opts or {}
    local mode = opts.mode or CameraMode.PlayerControlled
    assert(CameraMode:isValid(mode), "Invalid CameraMode for controller")

    local input = opts.input
        or InputSystem.get_controller(player_id)
        or InputSystem.create_controller(player_id)

    -- Per-camera repeat cadence. Independent from the shared controller's
    -- configured defaults; applied on activate and restored on deactivate.
    local cam_first = tonumber(opts.first_repeat_delay) or DEFAULT_CAMERA_FIRST_REPEAT_DELAY
    local cam_repeat = tonumber(opts.repeat_delay) or DEFAULT_CAMERA_REPEAT_DELAY
    if cam_first < 0 then cam_first = 0 end
    if cam_repeat < 0 then cam_repeat = 0 end

    dbg("new: player=", tostring(player_id),
        "mode=", tostring(CameraMode:getName(mode)),
        "input_ctrl=", tostring(input ~= nil),
        "first_repeat=", cam_first,
        "repeat=", cam_repeat)

    local controller = {
        player_id = player_id,
        input = input,
        mode = mode,
        custom_handlers = opts.custom_handlers or nil,
        is_active = false,
        input_locked = false,
        keep_player_input_locked = opts.keep_player_input_locked or false,
        current_position = { x = 0, y = 0, z = 100 },
        pending_position = nil,
        camera_color = { r = 255, g = 255, b = 255, a = 0 },
        camera_first_repeat_delay = cam_first,
        camera_repeat_delay = cam_repeat,
        _input_bound = false,
        _activating = false,
        _handler_pressed  = nil,
        _handler_released = nil,
        _handler_repeat   = nil,
    }

    setmetatable(controller, self)
    self.__index = self
    return controller
end

-- --------------------------------------------------------------------------
-- Input binding
-- --------------------------------------------------------------------------
function CameraController:_bind_input()
    if self._input_bound or not self.input then
        dbg("_bind_input: skip (bound=", tostring(self._input_bound),
            "input=", tostring(self.input ~= nil), ")")
        return
    end
    self._input_bound = true
    dbg("_bind_input: binding to InputController for player", tostring(self.player_id))

    local function make_handler(kind)
        return function(ev)
            if ev and ev.player_id and ev.player_id ~= self.player_id then
                return
            end
            self:_on_input_event(kind, ev or {})
        end
    end

    self._handler_pressed  = make_handler("pressed")
    self._handler_released = make_handler("released")
    self._handler_repeat   = make_handler("repeat")

    self.input:on("button_pressed",  self._handler_pressed)
    self.input:on("button_released", self._handler_released)
    self.input:on("button_repeat",   self._handler_repeat)
end

function CameraController:_unbind_input()
    if not self._input_bound or not self.input then return end
    self._input_bound = false
    dbg("_unbind_input: player", tostring(self.player_id))

    emitter_off(self.input, "button_pressed",  self._handler_pressed)
    emitter_off(self.input, "button_released", self._handler_released)
    emitter_off(self.input, "button_repeat",   self._handler_repeat)

    self._handler_pressed  = nil
    self._handler_released = nil
    self._handler_repeat   = nil
end

-- --------------------------------------------------------------------------
-- Repeat cadence override
-- --------------------------------------------------------------------------
function CameraController:_apply_repeat_delays()
    if not self.input or type(self.input.set_repeat_delays) ~= "function" then
        dbg("_apply_repeat_delays: input controller has no set_repeat_delays")
        return
    end
    dbg("_apply_repeat_delays: first=", self.camera_first_repeat_delay,
        "repeat=", self.camera_repeat_delay)
    self.input:set_repeat_delays(self.camera_first_repeat_delay, self.camera_repeat_delay)
end

function CameraController:_restore_repeat_delays()
    if not self.input or type(self.input.restore_repeat_delays) ~= "function" then
        dbg("_restore_repeat_delays: input controller has no restore_repeat_delays")
        return
    end
    dbg("_restore_repeat_delays")
    self.input:restore_repeat_delays()
end

-- Optional API: change the camera's cadence at runtime. If the camera is
-- currently active, the change takes effect immediately.
function CameraController:set_camera_repeat_delays(first_repeat_delay, repeat_delay)
    if first_repeat_delay ~= nil then
        local n = tonumber(first_repeat_delay)
        if n and n >= 0 then self.camera_first_repeat_delay = n end
    end
    if repeat_delay ~= nil then
        local n = tonumber(repeat_delay)
        if n and n >= 0 then self.camera_repeat_delay = n end
    end
    if self.is_active then
        self:_apply_repeat_delays()
    end
end

-- --------------------------------------------------------------------------
-- Input event handling
-- --------------------------------------------------------------------------
function CameraController:_on_input_event(kind, ev)
    dbg("_on_input_event: kind=", kind,
        "action=", tostring(ev.action),
        "is_active=", tostring(self.is_active),
        "mode=", tostring(CameraMode:getName(self.mode)),
        "pending=", tostring(self:hasPendingMove()))

    if ev.action == "Cancel" and kind == "pressed" then
        dbg("_on_input_event: Cancel pressed -> deactivate")
        self:deactivate()
        return
    end

    if not self.is_active then
        dbg("_on_input_event: not active, ignoring")
        return
    end
    if self:hasPendingMove() then
        dbg("_on_input_event: pending move, ignoring")
        return
    end

    -- Custom mode with a handler: dispatch to the handler and let it decide.
    if self.mode == CameraMode.Custom and self.custom_handlers and self.custom_handlers.onInput then
        self.custom_handlers.onInput(self)
        return
    end

    if self.mode == CameraMode.MiniMap or self.mode == CameraMode.ServerControlled then
        return
    end

    -- PlayerControlled (and Custom without a handler) use direction-driven
    -- movement with two filters:
    --   1. Skip "released" events — during a transition, prev_direction is
    --      already the new direction when the release is emitted, so handling
    --      the release would double-move.
    --   2. Only respond when ev.action matches the currently active direction,
    --      so non-direction buttons (ShoulderL, Confirm, ...) don't trigger
    --      movement in whatever direction happens to be held.
    if kind == "released" then
        dbg("_on_input_event: skipping movement for released event")
        return
    end
    local active = self.input and self.input:get_active_direction()
    if not active then
        dbg("_on_input_event: no active direction, skipping")
        return
    end
    if ev.action ~= active then
        dbg("_on_input_event: action", tostring(ev.action),
            "does not match active direction", tostring(active), "- skipping")
        return
    end

    handle_player_controlled_movement(self)
end

-- Legacy entry point.
function CameraController:handle_input()
    if not self.is_active then return end
    if self:hasPendingMove() then return end

    if self.mode == CameraMode.PlayerControlled then
        handle_player_controlled_movement(self)
    elseif self.mode == CameraMode.Custom then
        if self.custom_handlers and self.custom_handlers.onInput then
            self.custom_handlers.onInput(self)
        else
            handle_player_controlled_movement(self)
        end
    elseif self.mode == CameraMode.MiniMap or self.mode == CameraMode.ServerControlled then
        -- no-op
    else
        error("Unknown camera mode: " .. tostring(self.mode))
    end
end

-- --------------------------------------------------------------------------
-- Activation / Deactivation
-- --------------------------------------------------------------------------
function CameraController:activate(mode, lock_player_input)
    dbg("activate: ENTER player=", tostring(self.player_id),
        "arg_mode=", tostring(mode),
        "self.mode=", tostring(self.mode),
        "is_active=", tostring(self.is_active),
        "_activating=", tostring(self._activating))

    if self._activating then
        dbg("activate: REENTRANT call detected, bailing")
        return
    end
    if self.is_active then
        dbg("activate: already active, bailing")
        return
    end
    self._activating = true

    local new_mode = mode or self.mode
    assert(CameraMode:isValid(new_mode), "Invalid CameraMode for activation")
    self.mode = new_mode

    local should_lock = (lock_player_input == nil) and true or lock_player_input
    self.input_locked = should_lock
    dbg("activate: locking input =", tostring(should_lock))
    if should_lock then
        Net.lock_player_input(self.player_id)
    else
        Net.unlock_player_input(self.player_id)
    end

    dbg("activate: unlock_player_camera")
    Net.unlock_player_camera(self.player_id)

    dbg("activate: bind_input")
    self:_bind_input()

    if self.input then
        dbg("activate: require_release for CAMERA_DIRECTIONS")
        self.input:require_release(CAMERA_DIRECTIONS)
    end

    -- Install the camera's repeat cadence on the shared controller.
    self:_apply_repeat_delays()

    dbg("activate: get_player_position")
    local player_pos = Net.get_player_position(self.player_id)
    self.current_position = { x = player_pos.x, y = player_pos.y, z = player_pos.z }

    self.is_active = true
    self.pending_position = nil

    if self.mode == CameraMode.Custom and self.custom_handlers and self.custom_handlers.onActivate then
        self.custom_handlers.onActivate(self)
    end

    dbg("activate: EXIT player=", tostring(self.player_id),
        "mode=", tostring(CameraMode:getName(self.mode)))

    self._activating = false
end

function CameraController:deactivate(keep_camera_position)
    dbg("deactivate: ENTER player=", tostring(self.player_id),
        "is_active=", tostring(self.is_active))
    if not self.is_active then
        dbg("deactivate: not active, bailing")
        return
    end

    self.is_active = false
    self.pending_position = nil

    if keep_camera_position ~= true then
        Net.unlock_player_camera(self.player_id)
        Net.track_with_player_camera(self.player_id)
    end

    if not self.keep_player_input_locked then
        Net.unlock_player_input(self.player_id)
        self.input_locked = false
    end

    -- Restore whatever cadence the shared controller had configured.
    self:_restore_repeat_delays()

    if self.mode == CameraMode.Custom and self.custom_handlers and self.custom_handlers.onDeactivate then
        self.custom_handlers.onDeactivate(self)
    end

    dbg("deactivate: EXIT player=", tostring(self.player_id))
    return true
end

function CameraController:destroy()
    dbg("destroy: player=", tostring(self.player_id))
    self:deactivate(true)
    self:_unbind_input()
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
-- Mode switching
-- --------------------------------------------------------------------------
function CameraController:setMode(new_mode, custom_handlers)
    assert(CameraMode:isValid(new_mode), "Invalid CameraMode")
    dbg("setMode: ", tostring(self.mode), " -> ", tostring(new_mode))
    self.mode = new_mode
    if custom_handlers then
        self.custom_handlers = custom_handlers
    end
    if self.input then
        self.input:require_release(CAMERA_DIRECTIONS)
    end
    if self.is_active then
        self:_apply_repeat_delays()
    end
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

function CameraController:pan(dx, dy, dz) self:relativeMoveTo(dx, dy, dz) end

function CameraController:setPosition(new_x, new_y, new_z)
    self.current_position.x = new_x or self.current_position.x
    self.current_position.y = new_y or self.current_position.y
    self.current_position.z = new_z or self.current_position.z
    self.pending_position = nil
end

function CameraController:getPosition()
    return { x = self.current_position.x, y = self.current_position.y, z = self.current_position.z }
end

function CameraController:getPendingPosition()
    if self.pending_position then
        return { x = self.pending_position.x, y = self.pending_position.y, z = self.pending_position.z }
    end
    return nil
end

function CameraController:hasPendingMove() return self.pending_position ~= nil end

function CameraController:fadePlayerCamera(color, durationInSeconds)
    local col = color or self.camera_color
    Net.fade_player_camera(self.player_id, col, durationInSeconds)
end

function CameraController:shakePlayerCamera(strength, durationInSeconds)
    Net.shake_player_camera(self.player_id, strength, durationInSeconds)
end

return CameraController