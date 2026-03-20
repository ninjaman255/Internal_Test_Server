-- input_controller.lua
local Utility = require("scripts/utils/utility")
local DPad = require("scripts/input-controller/d-pad")

local InputController = {}
InputController.__index = InputController

--[[
  button_mappings: table with structure:
    {
      action_name = {
        names = { "raw1", "raw2", ... },
        allow_repeat = boolean  -- optional, defaults to false (i.e., require release)
      },
      ...
    }
]]
function InputController.new(player_id, button_mappings, direction_raw_names)
    local self = setmetatable({}, InputController)
    self.player_id = player_id
    self.direction_raw_names = direction_raw_names or {}  -- set of raw direction names
    self.emitter = Utility.EventEmitter.new()

    -- Normalise button mappings
    self.actions = {}
    for action, cfg in pairs(button_mappings) do
        local names
        local allow_repeat = false   -- default: require release (no repeats)
        if type(cfg) == "table" and cfg.names then
            names = cfg.names
            if cfg.allow_repeat ~= nil then
                allow_repeat = cfg.allow_repeat
            end
        else
            names = cfg   -- assume it's just the list
        end
        self.actions[action] = {
            names = names,
            allow_repeat = allow_repeat
        }
    end

    -- State
    self.raw_states = {}                -- raw name -> current state (1,2,3,4)
    self.logical = {}                   -- action name -> { down = bool, hold_time = number, repeat_phase = 0/1 }
    self.prev_direction = nil           -- last active direction (plain name, e.g., "Left")
    self.pressed_actions = {}           -- actions that were pressed this frame (for edge detection)
    self.release_required = {}          -- actions that are locked until release

    return self
end

-- Register event handlers
function InputController:on(event, callback)
    self.emitter:on(event, callback)
end

-- Process a batch of raw input events
function InputController:handle_raw_input(events)
    for _, ev in ipairs(events) do
        self.raw_states[ev.name] = ev.state
    end
    self:_update_logical_states()
end

-- Called every tick with delta_time
function InputController:tick(delta_time)
    self:_update_direction()
    self:_process_holds(delta_time)
end

-- Recompute logical action states based on current raw states
function InputController:_update_logical_states()
    for action, cfg in pairs(self.actions) do
        local was_down = self.logical[action] and self.logical[action].down or false
        local now_down = false
        for _, raw in ipairs(cfg.names) do
            local st = self.raw_states[raw]
            if st == 1 or st == 2 then   -- pressed or held
                now_down = true
                break
            end
        end

        if now_down and not was_down then
            self:_set_action_down(action, true)
            self.pressed_actions[action] = true
            self.emitter:emit("button_pressed", {
                player_id = self.player_id,
                action = action,
                state = 1
            })
        elseif not now_down and was_down then
            self:_set_action_down(action, false)
            self.release_required[action] = nil   -- clear lock
            self.emitter:emit("button_released", {
                player_id = self.player_id,
                action = action,
                state = 3
            })
        end
    end
end

-- Update direction state based on DPad
function InputController:_update_direction()
    -- Build list of pressed raw direction buttons (state 1 or 2)
    local pressed = {}
    for raw, st in pairs(self.raw_states) do
        if (st == 1 or st == 2) and self.direction_raw_names[raw] then
            table.insert(pressed, { name = raw })
        end
    end

    local new_dir = DPad.getActiveDirectionWithMemory(pressed, self.player_id)  -- returns plain name
    local old_dir = self.prev_direction

    if new_dir ~= old_dir then
        -- Release old direction action if any
        if old_dir then
            self:_set_action_down(old_dir, false)
            self.release_required[old_dir] = nil
            self.emitter:emit("button_released", {
                player_id = self.player_id,
                action = old_dir,
                state = 3
            })
        end
        -- Press new direction action if any
        if new_dir then
            self:_set_action_down(new_dir, true)
            self.pressed_actions[new_dir] = true
            self.emitter:emit("button_pressed", {
                player_id = self.player_id,
                action = new_dir,
                state = 1
            })
        end
        self.prev_direction = new_dir
    end
end

-- Helper to set the down state of a logical action
function InputController:_set_action_down(action, down)
    if not self.logical[action] then
        self.logical[action] = { down = false, hold_time = 0, repeat_phase = 0 }
    end
    self.logical[action].down = down
    if down then
        self.logical[action].hold_time = 0
        self.logical[action].repeat_phase = 0
    end
end

-- Process hold repeats for actions that allow repeats
function InputController:_process_holds(delta_time)
    for action, state in pairs(self.logical) do
        if state.down then
            local cfg = self.actions[action]   -- nil for direction actions
            local allow_repeat = cfg and cfg.allow_repeat or true   -- directions repeat by default

            if allow_repeat then
                state.hold_time = state.hold_time + delta_time

                if state.repeat_phase == 0 and state.hold_time >= 0.3 then
                    self.emitter:emit("button_repeat", {
                        player_id = self.player_id,
                        action = action,
                        state = 4
                    })
                    state.hold_time = 0
                    state.repeat_phase = 1
                elseif state.repeat_phase == 1 and state.hold_time >= 0.1 then
                    self.emitter:emit("button_repeat", {
                        player_id = self.player_id,
                        action = action,
                        state = 4
                    })
                    state.hold_time = 0
                end
            end
        end
    end
end

-- Polling API
function InputController:is_action_down(action)
    local state = self.logical[action]
    return state and state.down or false
end

function InputController:is_action_pressed(action)
    if self.release_required[action] then
        return false
    end
    if self.pressed_actions[action] then
        self.pressed_actions[action] = nil
        return true
    end
    return false
end

function InputController:require_release(action)
    self.release_required[action] = true
end

function InputController:consume()
    self.pressed_actions = {}
end

function InputController:destroy()
    DPad.resetPlayerState(self.player_id)
end

return InputController