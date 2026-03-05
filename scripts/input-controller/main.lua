-- main.lua – Unified input API for buttons, D‑pad, and per‑player controllers

local Utility = require("scripts/utils/utility")          -- adjust if needed
local DPad = require("scripts/input-controller/d-pad")
local InputController = require("scripts/input-controller/input-controller")
local Buttons = require("scripts/input-controller/buttons")

-- Normalise button mappings for InputController (all actions default require_release = true)
local button_mappings = {}
for action, raw_list in pairs(Buttons) do
    button_mappings[action] = {
        names = raw_list,
        require_release = true   -- can be overridden per action later if needed
    }
end

-- Get all raw direction button names from DPad (for filtering)
local direction_raw_names = DPad.getAllDirectionRawNames()

-- Per‑player controller cache (internal)
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
        -- You can attach application‑specific handlers here if desired,
        -- e.g. controllers[player_id]:on("button_pressed", function(ev) ... end)
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

-- Raw button definitions (from buttons.lua)
API.buttons = Buttons

-- DPad module (all its functions are exposed)
API.DPad = DPad

-- InputController class (for creating custom controllers if needed)
API.InputController = InputController

-- Get an existing controller for a player (returns nil if not found)
function API.get_controller(player_id)
    return controllers[player_id]
end

-- Explicitly create a controller for a player (normally auto‑created on join)
-- Returns the new or existing controller.
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

-- Destroy a controller manually (normally done on disconnect)
function API.destroy_controller(player_id)
    local ctrl = controllers[player_id]
    if ctrl then
        ctrl:destroy()
        controllers[player_id] = nil
    end
end

-- (Optional) Access the internal controller cache – use with care
API._controllers = controllers

return API