-- Can have combinations of these buttons
local Directions = {
    Left = { "Move Left", "UI Left" },
    Right = { "Move Right", "UI Right" },
    Up = { "Move Up", "UI Up" },
    Down = { "Move Down", "UI Down" },
}

-- Combination of the above buttons, Only one Combo should be active at a time.
local ComboDirections = {
    DownLeft = { DownButtons = Directions.Down, LeftButtons = Directions.Left }, 
    UpLeft = { DownButtons = Directions.Up, LeftButtons = Directions.Left }, 
    UpRight = { DownButtons = Directions.Down, RightButton = Directions.Right }, 
    DownRight = { DownButtons = Directions.Down, RightButtons = Directions.Right }
}

function Directions.checkIfDirection(buttons)
    local buttons = {}
    for i = 1, #buttons do
        local button = buttons[i]
        if button.name:find("") then
        end
    end
end


local Buttons = {
    ShoulderButtons = {
        ShoulderL = "Shoulder L", 
        ShoulderR = "Shoulder R"
    },

    Start = {"Pause"},
    Minimap = {"Minimap"},
    Confirm = { "Confirm", "A" },
    Cancel = { "Cancel", "Shoot", "Run" }
}

function Buttons.parseForComboDirections(events)
    local buttons = {}

    for i = 1, #events do
        local btn = events[i]
        
    end
end


return Buttons