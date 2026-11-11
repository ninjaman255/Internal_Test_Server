local PlayerControl = require("scripts/player-control/main")
local CameraFocus = require("scripts/player-control/camera-focus")
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
CameraController.DEBUG = false

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

    if not self:has_input_control() then return end
    local d = self.input:get_active_direction(self.input_session.state.owner)
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
        "input_instance=", tostring(input),
        "input_owner=", tostring(input and input:get_input_owner()),
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
        input_session = nil,
        keep_player_input_locked = opts.keep_player_input_locked or false,
        current_position = { x = 0, y = 0, z = 100 },
        pending_position = nil,
        pending_seconds = 0,
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

    -- Logical input focus is coordinated by PlayerControl rather than a
    -- second direct claim on the InputController.
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
    if self.input_session then
        return self.input_session:set_repeat_delays(
            self.camera_first_repeat_delay, self.camera_repeat_delay)
    end
    return false
end

function CameraController:_restore_repeat_delays()
    -- The session releases its owner-scoped cadence automatically. Restoring
    -- defaults here would overwrite the new menu/minigame's policy.
    return true
end

function CameraController:set_camera_repeat_delays(first_repeat_delay, repeat_delay)
    if first_repeat_delay ~= nil then
        local n=tonumber(first_repeat_delay)
        if n and n>=0 then self.camera_first_repeat_delay=n end
    end
    if repeat_delay ~= nil then
        local n=tonumber(repeat_delay)
        if n and n>=0 then self.camera_repeat_delay=n end
    end
    if self.is_active then self:_apply_repeat_delays() end
end

function CameraController:has_input_control()
    return self.input_session ~= nil and self.input_session:is_current()
end

-- --------------------------------------------------------------------------
-- Input event handling
-- --------------------------------------------------------------------------
function CameraController:_on_input_event(kind, ev)
    -- Check both activity and ownership before handling *any* action. In the
    -- previous ordering, Cancel deactivated the camera even while it was
    -- inactive and another system owned the shared input controller.
    if not self.is_active or not self.input or not self:has_input_control() then
        return
    end

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
    local active = self.input and self.input:get_active_direction(self.input_session.state.owner)
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
    if not self.is_active or not self.input or not self:has_input_control() then return end
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
    if self._activating or self.is_active then return false end
    local new_mode=mode or self.mode
    if not CameraMode:isValid(new_mode) then return false, "invalid camera mode" end
    self._activating=true
    local capture=(lock_player_input ~= false)
    -- Acquire resources before changing the engine camera. PlayerControl
    -- rolls back partial capture/HUD/camera failures on session begin.
    local session,err=PlayerControl.begin(self.player_id,{
        owner="free_camera", profile="free_camera", camera="exclusive",
        capture=capture, first_repeat_delay=self.camera_first_repeat_delay,
        repeat_delay=self.camera_repeat_delay,
    })
    if not session then
        self._activating=false
        return false,err
    end
    self.input_session=session
    session:on_close(function()
        if self.input_session==session then
            local was_active=self.is_active
            self.input_session=nil
            self.is_active=false
            self.pending_position=nil
            self.pending_seconds=0
            self.input_locked=false
            if was_active and self.mode==CameraMode.Custom and self.custom_handlers
                and self.custom_handlers.onDeactivate then
                local ok,err=pcall(self.custom_handlers.onDeactivate,self)
                if not ok then print("[CameraController] onDeactivate: "..tostring(err)) end
            end
        end
    end)
    self.mode=new_mode
    self.input_locked=capture
    local actions={"Left","Right","Up","Down","UpLeft","UpRight",
                   "DownLeft","DownRight","Confirm","Cancel","ShoulderL","ShoulderR"}
    local ok,why=pcall(function()
        for _,action in ipairs(actions) do
            session:on_pressed(action,function(ev) self:_on_input_event("pressed",ev) end)
            session:on_released(action,function(ev) self:_on_input_event("released",ev) end)
            session:on_repeat(action,function(ev) self:_on_input_event("repeat",ev) end)
        end
        session:on_suspend(function()
            -- Forced ownership changes are abnormal but must never restore
            -- camera position or repeat policy over the new owner.
            if self.is_active then self:deactivate(true) end
        end)
        local pos=Net.get_player_position(self.player_id)
        assert(pos and pos.x and pos.y and pos.z,"player position unavailable")
        assert(type(Net.unlock_player_camera)=="function","camera API unavailable")
        Net.unlock_player_camera(self.player_id)
        self.current_position={x=pos.x,y=pos.y,z=pos.z}
        self.pending_position=nil
        self.pending_seconds=0
        self.is_active=true
        if self.mode==CameraMode.Custom and self.custom_handlers and self.custom_handlers.onActivate then
            self.custom_handlers.onActivate(self)
        end
    end)
    self._activating=false
    if not ok then
        self.is_active=false
        self.input_session=nil
        if session.camera_handle then session.camera_handle.restore_on_release=false end
        local closed,cerr=session:close()
        if not closed then dbg("activation rollback pending",tostring(cerr)) end
        return false,why
    end
    return true
end

function CameraController:deactivate(keep_camera_position)
    if not self.is_active and not self.input_session then return false end
    self.is_active=false
    self.pending_position=nil
    self.pending_seconds=0
    local session=self.input_session
    self.input_session=nil
    if session then
        if session.camera_handle and keep_camera_position==true then
            session.camera_handle.restore_on_release=false
        end
        session:close()
    end
    self.input_locked=false
    if self.mode==CameraMode.Custom and self.custom_handlers and self.custom_handlers.onDeactivate then
        local ok,err=pcall(self.custom_handlers.onDeactivate,self)
        if not ok then print("[CameraController] onDeactivate: "..tostring(err)) end
    end
    return true
end

function CameraController:destroy()
    self:deactivate(true)
    self:_unbind_input()
    if self.input and self._handler_owner_changed then
        emitter_off(self.input,"input_owner_changed",self._handler_owner_changed)
    end
    self._handler_owner_changed=nil
end

function CameraController:returnToPlayer()
    if self.is_active then
        local pos=Net.get_player_position(self.player_id)
        self:moveTo(pos.x,pos.y,pos.z)
    else
        -- Do not restore over a camera owned by another feature.
        if CameraFocus.get_current(self.player_id) then return false end
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
    if self.is_active and self.input_session then
        local _,owner=self.input_session:input()
        if owner then self.input:require_release(CAMERA_DIRECTIONS,owner) end
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
    local current=CameraFocus.get_current(self.player_id)
    if (current and (not self.input_session or
        not CameraFocus.is_current(self.input_session.camera_handle))) or
        (self.is_active and not self.input_session) then
        return false, "camera focus lost"
    end
    self.pending_position = {
        x = x,
        y = y,
        z = z or self.current_position.z or 100
    }
    local ok,err=pcall(Net.move_player_camera,self.player_id,x,y,z or self.current_position.z or 100)
    if not ok then self.pending_position=nil; return false,err end
    self.current_position = self.pending_position
    self.pending_position = nil
    self.pending_seconds = 0
    return true
end

function CameraController:relativeMoveTo(dx, dy, dz)
    local new_x = self.current_position.x + (dx or 0)
    local new_y = self.current_position.y + (dy or 0)
    local new_z = self.current_position.z + (dz or 0)
    return self:moveTo(new_x, new_y, new_z)
end

function CameraController:pan(dx, dy, dz) self:relativeMoveTo(dx, dy, dz) end

function CameraController:setPosition(new_x, new_y, new_z)
    self.current_position.x = new_x or self.current_position.x
    self.current_position.y = new_y or self.current_position.y
    self.current_position.z = new_z or self.current_position.z
    self.pending_position = nil
    self.pending_seconds = 0
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

-- A duration-scoped camera slide. Pending state represents the requested
-- duration, NOT an engine-render-completion acknowledgement (the supplied
-- Net API does not expose a completion callback).
function CameraController:slideTo(x, y, z, duration)
    local current=CameraFocus.get_current(self.player_id)
    if current and (not self.input_session or
        not CameraFocus.is_current(self.input_session.camera_handle)) then
        return false, "camera focus lost"
    end
    local target={x=x,y=y,z=z or self.current_position.z or 100}
    local seconds=math.max(0,tonumber(duration) or 0)
    local ok,err=pcall(Net.slide_player_camera,self.player_id,target.x,target.y,target.z,seconds)
    if not ok then return false,err end
    self.pending_position=seconds>0 and target or nil
    self.pending_seconds=seconds
    if seconds==0 then self.current_position=target end
    return true
end

function CameraController:tick(delta_time)
    if not self.pending_position then return end
    self.pending_seconds=math.max(0,(self.pending_seconds or 0)-math.max(0,tonumber(delta_time) or 0))
    if self.pending_seconds==0 then
        self.current_position=self.pending_position
        self.pending_position=nil
    end
end

function CameraController:fadePlayerCamera(color, durationInSeconds)
    local col = color or self.camera_color
    Net.fade_player_camera(self.player_id, col, durationInSeconds)
end

function CameraController:shakePlayerCamera(strength, durationInSeconds)
    Net.shake_player_camera(self.player_id, strength, durationInSeconds)
end

return CameraController