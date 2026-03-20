-- main.lua – Unified input API

local Utility = require("scripts/utils/utility")
local DPad = require("scripts/input-controller/d-pad")
local InputController = require("scripts/input-controller/input-controller")
local Buttons = require("scripts/input-controller/buttons")

-- Convert Buttons mappings to the format expected by InputController
-- All actions default to allow_repeat = false (i.e., require release)
local button_mappings = {}
for action, raw_list in pairs(Buttons) do
    button_mappings[action] = {
        names = raw_list,
        allow_repeat = false
    }
end

-- Get all raw direction button names (for filtering)
local direction_raw_names = DPad.getAllDirectionRawNames()

-- Per‑player controller cache
local controllers = {}

-- Internal event handlers
Net:on("player_join", function(event)
    local player_id = event.player_id
    if not controllers[player_id] then
        controllers[player_id] = InputController.new(
            player_id,
            button_mappings,
            direction_raw_names
        )
    end
end)

Net:on("player_disconnect", function(event)
    local player_id = event.player_id
    local ctrl = controllers[player_id]
    if ctrl then
        ctrl:destroy()
        controllers[player_id] = nil
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

-- Public API
local API = {}

API.buttons = Buttons
API.DPad = DPad
API.InputController = InputController

function API.get_controller(player_id)
    return controllers[player_id]
end

function API.create_controller(player_id)
    if not controllers[player_id] then
        controllers[player_id] = InputController.new(
            player_id,
            button_mappings,
            direction_raw_names
        )
    end
    return controllers[player_id]
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