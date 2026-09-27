-- main.lua – Unified input API

local Utility = require("scripts/utils/utility")
local DPad = require("scripts/input-controller/d-pad")
local InputController = require("scripts/input-controller/input-controller")
local Buttons = require("scripts/input-controller/buttons")

-- Convert Buttons mappings to the format expected by InputController.
local button_mappings = {}
for action, raw_list in pairs(Buttons) do
    button_mappings[action] = {
        names = raw_list,
        allow_repeat = false
    }
end

-- Get all raw direction button names (for filtering)
local direction_raw_names = DPad.getAllDirectionRawNames()

-- Per‑player controller registry (keyed by player_id)
local controllers = {}

-- Swappable class used when constructing registered controllers.
local controller_class = InputController

local function make_controller(player_id, opts)
    opts = opts or {}
    local mappings = opts.button_mappings or button_mappings
    local dirs = opts.direction_raw_names or direction_raw_names
    -- opts is passed straight through to new() as the config table, so
    -- per-controller options such as first_repeat_delay and repeat_delay
    -- flow into the controller here.
    return controller_class.new(player_id, mappings, dirs, opts)
end

-- Internal event handlers
Net:on("player_join", function(event)
    if not controllers[event.player_id] then
        controllers[event.player_id] = make_controller(event.player_id)
    end
end)

Net:on("player_disconnect", function(event)
    local ctrl = controllers[event.player_id]
    if ctrl then
        ctrl:destroy()
        controllers[event.player_id] = nil
    end
end)

Net:on("virtual_input", function(event)
    local ctrl = controllers[event.player_id]
    if ctrl then
        ctrl:handle_raw_input(event.events)
    end
end)

Net:on("tick", function(event)
    for _, ctrl in pairs(controllers) do
        ctrl:tick(event.delta_time)
    end
end)

-- ---------------------------------------------------------------------------
-- Public API
-- ---------------------------------------------------------------------------

local API = {}

API.buttons = Buttons
API.DPad = DPad
API.InputController = InputController

-- Defaults (exposed so callers can pass them back into reload/spawn/etc).
API.default_button_mappings = button_mappings
API.default_direction_raw_names = direction_raw_names

-- Class override -------------------------------------------------------------

function API.set_controller_class(class)
    controller_class = class or InputController
end

function API.get_controller_class()
    return controller_class
end

-- Registry -------------------------------------------------------------------

function API.get_controller(player_id)
    return controllers[player_id]
end

-- Create + register a controller for a player_id (idempotent).
-- `opts` may include:
--   auto_activate        (boolean, default true)
--   button_mappings      (table)   override the default mapping
--   direction_raw_names  (table)   override the default direction raw names
--   first_repeat_delay   (number)  seconds before first repeat after press
--   repeat_delay         (number)  seconds between subsequent repeats
function API.create_controller(player_id, opts)
    if not controllers[player_id] then
        controllers[player_id] = make_controller(player_id, opts)
    end
    return controllers[player_id]
end

-- Build a controller without adding it to the registry.
function API.spawn_controller(player_id, opts)
    return make_controller(player_id, opts)
end

-- Swap in fresh mappings on an existing controller without a full destroy/
-- recreate cycle. If no controller is registered, one is created.
--
-- `opts` may include:
--   button_mappings      (table)   new mapping table; omitted = keep current
--   direction_raw_names  (table)   new direction raw-name set; omitted = keep current
function API.reload_controller(player_id, opts)
    opts = opts or {}
    local ctrl = controllers[player_id]
    if not ctrl then
        controllers[player_id] = make_controller(player_id, opts)
        return controllers[player_id]
    end
    ctrl:reload(opts.button_mappings, opts.direction_raw_names)
    return ctrl
end

-- Runtime repeat-cadence control (convenience wrappers around the per-
-- controller methods).
function API.set_repeat_delays(player_id, first_repeat_delay, repeat_delay)
    local ctrl = controllers[player_id]
    if ctrl then
        ctrl:set_repeat_delays(first_repeat_delay, repeat_delay)
    end
    return ctrl
end

function API.restore_repeat_delays(player_id)
    local ctrl = controllers[player_id]
    if ctrl then
        ctrl:restore_repeat_delays()
    end
    return ctrl
end

function API.activate_controller(player_id)
    local ctrl = controllers[player_id]
    if ctrl then ctrl:activate() end
    return ctrl
end

function API.deactivate_controller(player_id)
    local ctrl = controllers[player_id]
    if ctrl then ctrl:deactivate() end
    return ctrl
end

function API.destroy_controller(player_id)
    local ctrl = controllers[player_id]
    if ctrl then
        ctrl:destroy()
        controllers[player_id] = nil
    end
end

API._controllers = controllers

return API