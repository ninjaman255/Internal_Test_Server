-- input-controller.lua
-- Unified sticky-state input controller with release/repeat edges and UI handoff guards.
-- Timing is driven only by tick(delta_time); missing packet keys never imply release.
--
-- Lifecycle:
--   local ctrl = InputController.new(player_id, button_mappings, dir_names, config)
--   ctrl:activate()     -- begin processing (default unless config.auto_activate == false)
--   ctrl:deactivate()   -- stop processing, clear transient state (no events emitted)
--   ctrl:reset()        -- clear transient state, keep active flag as-is
--   ctrl:reload(m, d)   -- swap in new mappings/dir-names and reset transient state
--   ctrl:destroy()      -- permanent teardown
--
-- Repeat cadence:
--   Per-instance. `config.first_repeat_delay` and `config.repeat_delay`
--   override the module defaults at construction. `:set_repeat_delays(first,
--   repeat)` changes them at runtime; `:restore_repeat_delays()` reverts to
--   the values used at construction.
--
-- Extension:
--   local MyController = InputController.extend({
--       _init = function(self, ...) InputController._init(self, ...); ... end,
--       some_method = function(self) ... end,
--   })
--
-- Cloning (same mappings, new instance):
--   local copy = ctrl:clone(other_player_id_or_nil)

local Utility = require("scripts/utils/utility")
local DPad = require("scripts/input-controller/d-pad")

local InputController = {}
InputController.__index = InputController
InputController.DEBUG = false   -- set true for verbose direction logging

-- Module-level defaults. Individual controllers may override these via
-- construction options or :set_repeat_delays().
local NON_DIR_UP_TIMEOUT = 0.06
local FIRST_REPEAT_DELAY = 0.30
local REPEAT_DELAY = 0.10
local MAX_TICK_DT = 0.25

-- Exposed so external code can reference the defaults if needed.
InputController.DEFAULT_FIRST_REPEAT_DELAY = FIRST_REPEAT_DELAY
InputController.DEFAULT_REPEAT_DELAY = REPEAT_DELAY

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

-- ---------------------------------------------------------------------------
-- Internal helpers
-- ---------------------------------------------------------------------------

-- Rebuild self.actions and self.raw_to_actions from self.button_mappings.
local function rebuild_action_tables(self)
    self.actions = {}
    self.raw_to_actions = {}

    for action, cfg in pairs(self.button_mappings) do
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
end

local function sanitize_delay(value, fallback)
    local n = tonumber(value)
    if not n or n < 0 then return fallback end
    return n
end

-- ---------------------------------------------------------------------------
-- Construction
-- ---------------------------------------------------------------------------

function InputController.new(player_id, button_mappings, direction_raw_names, config)
    local self = setmetatable({}, InputController)
    self:_init(player_id, button_mappings, direction_raw_names, config)
    return self
end

function InputController:_init(player_id, button_mappings, direction_raw_names, config)
    config = config or {}
    self.player_id = player_id
    self.button_mappings = button_mappings or {}
    self.direction_raw_names = direction_raw_names or {}
    self.emitter = Utility.EventEmitter.new()

    rebuild_action_tables(self)

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

    -- Per-instance repeat cadence. Construction-time defaults can be
    -- overridden via config; _default_* remembers them so restore_repeat_delays
    -- can revert to them after a runtime override.
    self.first_repeat_delay = sanitize_delay(config.first_repeat_delay, FIRST_REPEAT_DELAY)
    self.repeat_delay       = sanitize_delay(config.repeat_delay, REPEAT_DELAY)
    self._default_first_repeat_delay = self.first_repeat_delay
    self._default_repeat_delay       = self.repeat_delay

    -- Default: a freshly constructed controller is live, matching previous
    -- behaviour. Pass { auto_activate = false } to construct it dormant.
    self.active = config.auto_activate ~= false
    self.destroyed = false
end

-- Create a subclass.
function InputController.extend(overrides)
    overrides = overrides or {}
    local subclass = setmetatable({}, { __index = InputController })
    subclass.__index = subclass
    for k, v in pairs(overrides) do
        subclass[k] = v
    end
    if rawget(overrides, "new") == nil then
        function subclass.new(player_id, button_mappings, direction_raw_names, config)
            local self = setmetatable({}, subclass)
            self:_init(player_id, button_mappings, direction_raw_names, config)
            return self
        end
    end
    return subclass
end

-- Clone produces a new controller that inherits the source controller's
-- current repeat cadence (not the class defaults).
function InputController:clone(player_id)
    local class = getmetatable(self) or InputController
    return class.new(
        player_id or self.player_id,
        self.button_mappings,
        self.direction_raw_names,
        {
            auto_activate = self.active,
            first_repeat_delay = self.first_repeat_delay,
            repeat_delay = self.repeat_delay,
        }
    )
end

-- ---------------------------------------------------------------------------
-- Lifecycle
-- ---------------------------------------------------------------------------

function InputController:is_active()
    return self.active == true and self.destroyed ~= true
end

function InputController:activate()
    if self.destroyed then return end
    self.active = true
end

function InputController:deactivate()
    self.active = false
    self:_clear_transient_state()
end

function InputController:reset()
    self:_clear_transient_state()
    DPad.resetPlayerState(self.player_id)
end

function InputController:reload(button_mappings, direction_raw_names)
    if self.destroyed then return end
    if button_mappings ~= nil then
        self.button_mappings = button_mappings
    end
    if direction_raw_names ~= nil then
        self.direction_raw_names = direction_raw_names
    end
    rebuild_action_tables(self)
    self:_clear_transient_state()
    DPad.resetPlayerState(self.player_id)
end

function InputController:_clear_transient_state()
    self.raw_states = {}
    self.raw_last_seen = {}
    self.logical = {}
    self.prev_direction = nil
    self.pressed_actions = {}
    self.released_actions = {}
    self.repeat_actions = {}
    self.release_required = {}
    self.swallow_until = 0.0
end

function InputController:destroy()
    self.active = false
    self.destroyed = true
    self:_clear_transient_state()
    DPad.resetPlayerState(self.player_id)
end

-- ---------------------------------------------------------------------------
-- Repeat cadence
-- ---------------------------------------------------------------------------

-- Change the repeat cadence at runtime. Passing nil for either argument
-- keeps the current value for that field.
function InputController:set_repeat_delays(first_repeat_delay, repeat_delay)
    if first_repeat_delay ~= nil then
        self.first_repeat_delay = sanitize_delay(first_repeat_delay, self.first_repeat_delay)
    end
    if repeat_delay ~= nil then
        self.repeat_delay = sanitize_delay(repeat_delay, self.repeat_delay)
    end
    if InputController.DEBUG then
        print("[ICTRL] player=" .. tostring(self.player_id) ..
              " set_repeat_delays first=" .. tostring(self.first_repeat_delay) ..
              " repeat=" .. tostring(self.repeat_delay))
    end
end

-- Revert to the cadence configured at construction time.
function InputController:restore_repeat_delays()
    self.first_repeat_delay = self._default_first_repeat_delay
    self.repeat_delay       = self._default_repeat_delay
    if InputController.DEBUG then
        print("[ICTRL] player=" .. tostring(self.player_id) ..
              " restore_repeat_delays first=" .. tostring(self.first_repeat_delay) ..
              " repeat=" .. tostring(self.repeat_delay))
    end
end

function InputController:get_repeat_delays()
    return self.first_repeat_delay, self.repeat_delay
end

-- ---------------------------------------------------------------------------
-- Events
-- ---------------------------------------------------------------------------

function InputController:on(event, callback)
    self.emitter:on(event, callback)
end

function InputController:_swallowing()
    return self.time < self.swallow_until
end

function InputController:_emit_edge(kind, action, state)
    if kind == "released" then self.release_required[action] = nil end
    if not self:is_active() then return end
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

-- ---------------------------------------------------------------------------
-- Input handling
-- ---------------------------------------------------------------------------

function InputController:handle_raw_input(events)
    if not self:is_active() then return end
    local normalized = normalize_events(events)
    for _, ev in ipairs(normalized) do
        local name, state = ev.name, ev.state
        self.raw_states[name] = state
        self.raw_last_seen[name] = self.time

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

    self.prev_direction = new_dir

    if self.DEBUG then
        print("[ICTRL] player=" .. tostring(self.player_id) ..
              " dir " .. tostring(old_dir) .. " -> " .. tostring(new_dir))
    end

    if old_dir then
        self:_set_action_down(old_dir, false)
        self:_emit_edge("released", old_dir, 3)
    end
    if new_dir then
        self:_set_action_down(new_dir, true)
        self:_emit_edge("pressed", new_dir, 1)
    end
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
                local threshold = state.repeat_phase == 0
                    and self.first_repeat_delay
                    or self.repeat_delay
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
    if not self:is_active() then return end
    local dt = tonumber(delta_time) or 0
    if dt < 0 then dt = 0 end
    if dt > MAX_TICK_DT then dt = MAX_TICK_DT end
    self.time = self.time + dt
    self:_synthesize_non_direction_releases()
    self:_update_direction()
    self:_process_holds(dt)
end

-- ---------------------------------------------------------------------------
-- Queries
-- ---------------------------------------------------------------------------

function InputController:is_action_down(action)
    if not self:is_active() then return false end
    local state = self.logical[action]
    return state and state.down or false
end

function InputController:peek_action_pressed(action)
    if not self:is_active() then return false end
    return (not self.release_required[action]) and (not self:_swallowing()) and self.pressed_actions[action] == true
end

function InputController:peek_action_released(action)
    if not self:is_active() then return false end
    return (not self:_swallowing()) and self.released_actions[action] == true
end

function InputController:peek_action_repeated(action)
    if not self:is_active() then return false end
    return (not self.release_required[action]) and (not self:_swallowing()) and self.repeat_actions[action] == true
end

function InputController:is_action_pressed(action)
    if not self:is_active() then return false end
    if self.release_required[action] or self:_swallowing() then return false end
    if self.pressed_actions[action] then self.pressed_actions[action] = nil; return true end
    return false
end

function InputController:is_action_released(action)
    if not self:is_active() then return false end
    if self:_swallowing() then return false end
    if self.released_actions[action] then self.released_actions[action] = nil; return true end
    return false
end

function InputController:is_action_repeated(action)
    if not self:is_active() then return false end
    if self.release_required[action] or self:_swallowing() then return false end
    if self.repeat_actions[action] then self.repeat_actions[action] = nil; return true end
    return false
end

function InputController:get_active_direction()
    if not self:is_active() then return nil end
    return self.prev_direction
end

-- ---------------------------------------------------------------------------
-- Control
-- ---------------------------------------------------------------------------

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

return InputController