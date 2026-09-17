-- input-controller.lua
-- Unified sticky-state input controller with release/repeat edges and UI handoff guards.
-- Timing is driven only by tick(delta_time); missing packet keys never imply release.

local Utility = require("scripts/utils/utility")
local DPad = require("scripts/input-controller/d-pad")

local InputController = {}
InputController.__index = InputController

local NON_DIR_UP_TIMEOUT = 0.06
local FIRST_REPEAT_DELAY = 0.30
local REPEAT_DELAY = 0.10
local MAX_TICK_DT = 0.25

local function normalize_state(value)
    if value == 1 or value == 2 or value == 3 or value == 4 then return value end
    if type(value) == "string" then
        local s = value:lower()
        if s == "pressed" then return 1 end
        if s == "held" then return 2 end
        if s == "released" then return 3 end
        if s == "scroll" then return 4 end
    end
    return nil
end

local function normalize_events(events)
    local out = {}
    if type(events) ~= "table" then return out end

    -- Array shape: { {name="Confirm", state=1}, ... }
    if events[1] ~= nil then
        for _, ev in ipairs(events) do
            if type(ev) == "table" and ev.name then
                local state = normalize_state(ev.state)
                if state then out[#out + 1] = { name = ev.name, state = state } end
            end
        end
        return out
    end

    -- Map shape: { ["Confirm"] = 1, ["UI Left"] = 2 }
    for name, value in pairs(events) do
        if type(value) == "table" and value.name then
            local state = normalize_state(value.state)
            if state then out[#out + 1] = { name = value.name, state = state } end
        elseif type(name) == "string" then
            local state = normalize_state(value)
            if state then out[#out + 1] = { name = name, state = state } end
        end
    end
    return out
end

function InputController.new(player_id, button_mappings, direction_raw_names)
    local self = setmetatable({}, InputController)
    self.player_id = player_id
    self.direction_raw_names = direction_raw_names or {}
    self.emitter = Utility.EventEmitter.new()
    self.actions = {}
    self.raw_to_actions = {}

    for action, cfg in pairs(button_mappings or {}) do
        local names, allow_repeat
        if type(cfg) == "table" and cfg.names then
            names = cfg.names
            allow_repeat = cfg.allow_repeat == true
        else
            names = cfg or {}
            allow_repeat = false
        end
        self.actions[action] = { names = names, allow_repeat = allow_repeat }
        for _, raw in ipairs(names) do
            self.raw_to_actions[raw] = self.raw_to_actions[raw] or {}
            self.raw_to_actions[raw][#self.raw_to_actions[raw] + 1] = action
        end
    end

    self.raw_states = {}
    self.raw_last_seen = {}
    self.logical = {}
    self.prev_direction = nil
    self.pressed_actions = {}
    self.released_actions = {}
    self.repeat_actions = {}
    self.release_required = {}
    self.time = 0.0
    self.swallow_until = 0.0
    return self
end

function InputController:on(event, callback)
    self.emitter:on(event, callback)
end

function InputController:_swallowing()
    return self.time < self.swallow_until
end

function InputController:_emit_edge(kind, action, state)
    -- A release must always clear a require-release gate, even if its event is
    -- intentionally swallowed during a UI handoff. Otherwise a key released
    -- inside the swallow window could remain locked forever.
    if kind == "released" then self.release_required[action] = nil end
    if self:_swallowing() then return end
    if kind == "pressed" then
        if self.release_required[action] then return end
        self.pressed_actions[action] = true
        self.emitter:emit("button_pressed", { player_id = self.player_id, action = action, state = state or 1 })
    elseif kind == "released" then
        self.released_actions[action] = true
        self.emitter:emit("button_released", { player_id = self.player_id, action = action, state = state or 3 })
    elseif kind == "repeat" then
        if self.release_required[action] then return end
        self.repeat_actions[action] = true
        self.emitter:emit("button_repeat", { player_id = self.player_id, action = action, state = state or 4 })
    end
end

function InputController:handle_raw_input(events)
    local normalized = normalize_events(events)
    for _, ev in ipairs(normalized) do
        local name, state = ev.name, ev.state
        self.raw_states[name] = state
        self.raw_last_seen[name] = self.time

        -- Scroll is an explicit repeat pulse. Keep the key logically down.
        if state == 4 then
            self.raw_states[name] = 2
            for _, action in ipairs(self.raw_to_actions[name] or {}) do
                if self.actions[action] and self.actions[action].allow_repeat then
                    self:_emit_edge("repeat", action, 4)
                end
            end
        end
    end
    self:_update_logical_states()
    self:_update_direction()
end

function InputController:_set_action_down(action, down)
    self.logical[action] = self.logical[action] or { down = false, hold_time = 0, repeat_phase = 0 }
    local state = self.logical[action]
    state.down = down == true
    if down then
        state.hold_time = 0
        state.repeat_phase = 0
    else
        state.hold_time = 0
        state.repeat_phase = 0
    end
end

function InputController:_update_logical_states()
    for action, cfg in pairs(self.actions) do
        local old = self.logical[action] and self.logical[action].down or false
        local down = false
        for _, raw in ipairs(cfg.names) do
            local state = self.raw_states[raw]
            if state == 1 or state == 2 or state == 4 then down = true; break end
        end

        if down and not old then
            self:_set_action_down(action, true)
            self:_emit_edge("pressed", action, 1)
        elseif not down and old then
            self:_set_action_down(action, false)
            self:_emit_edge("released", action, 3)
        end
    end
end

function InputController:_update_direction()
    local pressed = {}
    for raw, state in pairs(self.raw_states) do
        if self.direction_raw_names[raw] and (state == 1 or state == 2 or state == 4) then
            pressed[#pressed + 1] = { name = raw }
        end
    end

    local new_dir = DPad.getActiveDirectionWithMemory(pressed, self.player_id)
    local old_dir = self.prev_direction
    if new_dir == old_dir then return end

    if old_dir then
        self:_set_action_down(old_dir, false)
        self:_emit_edge("released", old_dir, 3)
    end
    if new_dir then
        self:_set_action_down(new_dir, true)
        self:_emit_edge("pressed", new_dir, 1)
    end
    self.prev_direction = new_dir
end

function InputController:_synthesize_non_direction_releases()
    local changed = false
    for raw, state in pairs(self.raw_states) do
        if not self.direction_raw_names[raw] and (state == 1 or state == 2 or state == 4) then
            local last_seen = self.raw_last_seen[raw] or self.time
            if self.time - last_seen >= NON_DIR_UP_TIMEOUT then
                self.raw_states[raw] = 3
                changed = true
            end
        end
    end
    if changed then self:_update_logical_states() end
end

function InputController:_process_holds(dt)
    for action, state in pairs(self.logical) do
        if state.down then
            local cfg = self.actions[action]
            local allow_repeat = cfg and cfg.allow_repeat or (self.prev_direction == action)
            if allow_repeat then
                state.hold_time = state.hold_time + dt
                local threshold = state.repeat_phase == 0 and FIRST_REPEAT_DELAY or REPEAT_DELAY
                if state.hold_time >= threshold then
                    state.hold_time = state.hold_time - threshold
                    state.repeat_phase = 1
                    self:_emit_edge("repeat", action, 4)
                end
            end
        end
    end
end

function InputController:tick(delta_time)
    local dt = tonumber(delta_time) or 0
    if dt < 0 then dt = 0 end
    if dt > MAX_TICK_DT then dt = MAX_TICK_DT end
    self.time = self.time + dt
    self:_synthesize_non_direction_releases()
    self:_update_direction()
    self:_process_holds(dt)
end

function InputController:is_action_down(action)
    local state = self.logical[action]
    return state and state.down or false
end

function InputController:peek_action_pressed(action)
    return (not self.release_required[action]) and (not self:_swallowing()) and self.pressed_actions[action] == true
end

function InputController:peek_action_released(action)
    return (not self:_swallowing()) and self.released_actions[action] == true
end

function InputController:peek_action_repeated(action)
    return (not self.release_required[action]) and (not self:_swallowing()) and self.repeat_actions[action] == true
end

function InputController:is_action_pressed(action)
    if self.release_required[action] or self:_swallowing() then return false end
    if self.pressed_actions[action] then self.pressed_actions[action] = nil; return true end
    return false
end

function InputController:is_action_released(action)
    if self:_swallowing() then return false end
    if self.released_actions[action] then self.released_actions[action] = nil; return true end
    return false
end

function InputController:is_action_repeated(action)
    if self.release_required[action] or self:_swallowing() then return false end
    if self.repeat_actions[action] then self.repeat_actions[action] = nil; return true end
    return false
end

function InputController:get_active_direction()
    return self.prev_direction
end

function InputController:require_release(actions)
    if type(actions) == "string" then actions = { actions } end
    for _, action in ipairs(actions or {}) do
        if self:is_action_down(action) then self.release_required[action] = true end
        self.pressed_actions[action] = nil
        self.repeat_actions[action] = nil
    end
end

function InputController:swallow(seconds)
    self.swallow_until = math.max(self.swallow_until, self.time + math.max(0, tonumber(seconds) or 0))
    self:consume()
end

function InputController:consume()
    self.pressed_actions = {}
    self.released_actions = {}
    self.repeat_actions = {}
end

function InputController:destroy()
    self:consume()
    DPad.resetPlayerState(self.player_id)
end

return InputController
