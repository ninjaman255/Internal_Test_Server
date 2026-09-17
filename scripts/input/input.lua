-- scripts/input/input.lua
-- Compatibility facade backed by the canonical delta-time InputController.
-- Existing net-games callers can keep using lowercase keys while new code can use InputController directly.

local InputSystem = require("scripts/input-controller/main")

local Input = {}
Input.DEBUG = false

local KEY_MAP = {
    confirm = "Confirm", cancel = "Cancel",
    shoulderl = "ShoulderL", shoulderr = "ShoulderR",
    start = "Start", minimap = "Minimap", options = "Options", custommenu = "CustomMenu",
    left = "Left", right = "Right", up = "Up", down = "Down",
    upleft = "UpLeft", upright = "UpRight", downleft = "DownLeft", downright = "DownRight",
}

local REVERSE_DIR = {
    Left = "left", Right = "right", Up = "up", Down = "down",
    UpLeft = "upleft", UpRight = "upright", DownLeft = "downleft", DownRight = "downright",
}

local function ctrl(player_id)
    return InputSystem.get_controller(player_id) or InputSystem.create_controller(player_id)
end

local function action(key)
    return KEY_MAP[tostring(key or ""):lower()] or key
end

function Input.attach_virtual_input_listener()
    -- InputController.main already owns the one global virtual_input listener.
    return true
end

function Input.consume(player_id)
    ctrl(player_id):consume()
end

function Input.pop(player_id, key)
    return ctrl(player_id):is_action_pressed(action(key))
end

function Input.pressed(player_id, key)
    return ctrl(player_id):peek_action_pressed(action(key))
end

function Input.released(player_id, key)
    return ctrl(player_id):peek_action_released(action(key))
end

function Input.pop_released(player_id, key)
    return ctrl(player_id):is_action_released(action(key))
end

function Input.repeated(player_id, key)
    return ctrl(player_id):peek_action_repeated(action(key))
end

function Input.pop_repeated(player_id, key)
    return ctrl(player_id):is_action_repeated(action(key))
end

function Input.is_down(player_id, key)
    return ctrl(player_id):is_action_down(action(key))
end

function Input.swallow(player_id, seconds)
    ctrl(player_id):swallow(seconds)
end

function Input.require_release(player_id, keys)
    local mapped = {}
    for _, key in ipairs(keys or {}) do mapped[#mapped + 1] = action(key) end
    ctrl(player_id):require_release(mapped)
end

function Input.clear_require_release(player_id, keys)
    local c = ctrl(player_id)
    for _, key in ipairs(keys or {}) do c.release_required[action(key)] = nil end
end

function Input.get_active_direction(player_id)
    local c = ctrl(player_id)
    local direction = c:get_active_direction()

    -- Respect UI/controller handoff guards.
    -- A direction that was already held when require_release() was called
    -- should not become active again until the controller sees it released.
    if direction and c.release_required[direction] then
        return nil
    end

    return REVERSE_DIR[direction]
end

function Input.reset_direction_state(player_id)
    local c = ctrl(player_id)
    c.prev_direction = nil
    InputSystem.DPad.resetPlayerState(player_id)
end

function Input.get_emitter(player_id)
    return ctrl(player_id).emitter
end

function Input.on(player_id, event, callback)
    ctrl(player_id):on(event, callback)
end

function Input.update(_delta_time)
    -- The canonical controller is already ticked by input-controller/main.lua.
end

function Input.debug_dump_last_packet(player_id)
    local c = ctrl(player_id)
    print("[InputDBG] player=" .. tostring(player_id) .. " direction=" .. tostring(c:get_active_direction()))
end

return Input
