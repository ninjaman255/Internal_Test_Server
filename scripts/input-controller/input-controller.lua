-- input_controller.lua
local Utility = require("scripts/utils/utility")   -- adjust path as needed
local DPad = require("scripts/input-controller/d-pad")        -- adjust path as needed

local InputController = {}
InputController.__index = InputController

--[[
  button_mappings: table with structure:
    {
      action_name = {
        names = { "raw1", "raw2", ... },
        require_release = boolean  -- optional, defaults to true
      },
      ...
    }
  For simple lists (like from buttons.lua) we'll convert them internally.
]]
function InputController.new(player_id, button_mappings, direction_raw_names)
    local self = setmetatable({}, InputController)
    self.player_id = player_id
    self.direction_raw_names = direction_raw_names or {}  -- set of raw direction names
    self.emitter = Utility.EventEmitter.new()

    -- Normalise button mappings: ensure each action has .names and .require_release
    self.actions = {}
    self.raw_to_actions = {}  -- raw name -> list of action names
    for action, cfg in pairs(button_mappings) do
        local names
        local require_release = true  -- default
        if type(cfg) == "table" and cfg.names then
            names = cfg.names
            if cfg.require_release ~= nil then
                require_release = cfg.require_release
            end
        else
            -- assume cfg is the list of raw names
            names = cfg
        end
        self.actions[action] = {
            names = names,
            require_release = require_release
        }
        for _, raw in ipairs(names) do
            if not self.raw_to_actions[raw] then
                self.raw_to_actions[raw] = {}
            end
            table.insert(self.raw_to_actions[raw], action)
        end
    end

    -- State
    self.raw_states = {}                -- raw name -> current state (1,2,3,4)
    self.logical = {}                   -- action name -> { down = bool, hold_time = number, repeat_phase = 0/1 }
    self.prev_direction = nil           -- last active direction (or nil)
    self.pressed_actions = {}           -- actions that were pressed this frame (for edge detection)
    self.release_required = {}          -- actions that are locked until release

    return self
end

-- Register event handlers
function InputController:on(event, callback)
    self.emitter:on(event, callback)
end

-- Process a batch of raw input events (as received from virtual_input)
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
    -- For each action, determine if any raw button is down (state 1 or 2)
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
            -- Press event
            self:_set_action_down(action, true)
            self.pressed_actions[action] = true
            self.emitter:emit("button_pressed", {
                player_id = self.player_id,
                action = action,
                state = 1
            })
            -- DEBUG: Confirm press detected
            if action == "Confirm" then
                print("DEBUG: Confirm press detected in controller for player", self.player_id)
            end
        elseif not now_down and was_down then
            -- Release event
            self:_set_action_down(action, false)
            self.release_required[action] = nil   -- clear lock
            self.emitter:emit("button_released", {
                player_id = self.player_id,
                action = action,
                state = 3
            })
        end
        -- If state unchanged, nothing to emit (hold repeats handled separately)
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

    local new_dir = DPad.getActiveDirectionWithMemory(pressed, self.player_id)
    local old_dir = self.prev_direction

    if new_dir ~= old_dir then
        -- Release old direction action if any
        if old_dir then
            local action = "dir_" .. old_dir
            self:_set_action_down(action, false)
            self.release_required[action] = nil
            self.emitter:emit("button_released", {
                player_id = self.player_id,
                action = action,
                state = 3
            })
        end
        -- Press new direction action if any
        if new_dir then
            local action = "dir_" .. new_dir
            self:_set_action_down(action, true)
            self.pressed_actions[action] = true
            self.emitter:emit("button_pressed", {
                player_id = self.player_id,
                action = action,
                state = 1
            })
        end
        self.prev_direction = new_dir
    end
    -- If direction unchanged, nothing to emit (hold repeats handled separately)
end

-- Helper to set the down state of a logical action and initialise tracking
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

-- Process hold repeats for all down actions that do not require release
function InputController:_process_holds(delta_time)
    for action, state in pairs(self.logical) do
        if state.down then
            local cfg = self.actions[action]   -- may be nil for direction actions
            local require_release = cfg and cfg.require_release or false   -- directions default to false (allow repeats)

            if not require_release then
                state.hold_time = state.hold_time + delta_time

                if state.repeat_phase == 0 and state.hold_time >= 0.3 then
                    -- First repeat
                    self.emitter:emit("button_repeat", {
                        player_id = self.player_id,
                        action = action,
                        state = 4
                    })
                    state.hold_time = 0
                    state.repeat_phase = 1
                elseif state.repeat_phase == 1 and state.hold_time >= 0.1 then
                    -- Subsequent repeats
                    self.emitter:emit("button_repeat", {
                        player_id = self.player_id,
                        action = action,
                        state = 4
                    })
                    state.hold_time = 0
                    -- stay in phase 1
                end
            end
        end
    end
end

-- Polling API for net-games

function InputController:is_action_down(action)
    local state = self.logical[action]
    return state and state.down or false
end

function InputController:is_action_pressed(action)
    if self.release_required and self.release_required[action] then
        -- action is locked until release
        return false
    end
    if self.pressed_actions and self.pressed_actions[action] then
        self.pressed_actions[action] = nil
        return true
    end
    return false
end

function InputController:require_release(action)
    if not self.release_required then
        self.release_required = {}
    end
    self.release_required[action] = true
end

function InputController:consume()
    self.pressed_actions = {}
    -- release_required are not cleared automatically; they stay until the action is released.
end

-- Optional: reset player state (e.g., on disconnect)
function InputController:destroy()
    DPad.resetPlayerState(self.player_id)
    -- any other cleanup
end

return InputController