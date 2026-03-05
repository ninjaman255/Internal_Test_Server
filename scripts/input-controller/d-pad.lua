local Utility = require("scripts/utils/utility")
local DPad = {}

local Emitter = Utility.EventEmitter.new()

DPad.Emitter = Emitter

function DPad.EmitButtonPressed(button, player_id)
    Emitter:emit("button_pressed", {button = button, player_id = player_id})
end

Emitter:on("button_pressed", function(event)
    local button = event.button
    local player_id = event.player_id
    print(button)
    print(player_id)
end)

-- Can have combinations of these buttons
DPad.Directions = {
    Left = { "Move Left", "UI Left" },
    Right = { "Move Right", "UI Right" },
    Up = { "Move Up", "UI Up" },
    Down = { "Move Down", "UI Down" },
}

-- Combination of the above buttons, Only one Combo should be active at a time.
DPad.ComboDirections = {
    DownLeft = { DownButtons = DPad.Directions.Down, LeftButtons = DPad.Directions.Left }, 
    UpLeft = { UpButtons = DPad.Directions.Up, LeftButtons = DPad.Directions.Left }, 
    UpRight = { UpButtons = DPad.Directions.Up, RightButtons = DPad.Directions.Right }, 
    DownRight = { DownButtons = DPad.Directions.Down, RightButtons = DPad.Directions.Right }
}

-- State tracking for each player
DPad.PlayerState = {}

-- Helper function to extract only direction button names from the pressed buttons table
function DPad.extractDirectionButtons(pressedButtons)
    local directionButtons = {}
    
    for _, buttonInfo in ipairs(pressedButtons) do
        local buttonName = buttonInfo["name"]
        
        -- Check if this button is a direction button
        for _, directionButtonList in pairs(DPad.Directions) do
            for _, directionButton in ipairs(directionButtonList) do
                if buttonName == directionButton then
                    table.insert(directionButtons, buttonName)
                    break
                end
            end
        end
    end
    
    return directionButtons
end

-- Helper function to create a set from pressed buttons for quick lookup
function DPad.createButtonSet(pressedButtons)
    local buttonSet = {}
    
    -- Extract direction buttons first
    local directionButtons = DPad.extractDirectionButtons(pressedButtons)
    
    for _, button in ipairs(directionButtons) do
        buttonSet[button] = true
    end
    
    return buttonSet
end

-- Function to check if all buttons in a direction are pressed
function DPad.isDirectionPressed(directionButtons, buttonSet)
    for _, button in ipairs(directionButtons) do
        if not buttonSet[button] then
            return false
        end
    end
    return true
end

-- Main function to get the active direction/combo from the new format
function DPad.getActiveDirectionFromTable(pressedButtons)
    local buttonSet = DPad.createButtonSet(pressedButtons)
    
    -- First, check for combo directions (diagonals)
    for comboName, combo in pairs(DPad.ComboDirections) do
        local allPressed = true
        
        -- Check each required direction in the combo
        for _, requiredDirection in pairs(combo) do
            local directionPressed = false
            
            -- Check if any button in this direction is pressed
            for _, button in ipairs(requiredDirection) do
                if buttonSet[button] then
                    directionPressed = true
                    break
                end
            end
            
            if not directionPressed then
                allPressed = false
                break
            end
        end
        
        if allPressed then
            return comboName
        end
    end
    
    -- If no combo found, check for single directions
    for directionName, directionButtons in pairs(DPad.Directions) do
        for _, button in ipairs(directionButtons) do
            if buttonSet[button] then
                return directionName
            end
        end
    end
    
    return nil  -- No direction found
end

-- More efficient version using button-to-direction mapping
function DPad.getActiveDirectionOptimizedFromTable(pressedButtons)
    -- Build reverse lookup table from button name to direction name
    local buttonToDirection = {}
    for dirName, buttons in pairs(DPad.Directions) do
        for _, button in ipairs(buttons) do
            buttonToDirection[button] = dirName
        end
    end
    
    -- Extract pressed directions from the input table
    local pressedDirections = {}
    for _, buttonInfo in ipairs(pressedButtons) do
        local buttonName = buttonInfo["name"]
        local direction = buttonToDirection[buttonName]
        if direction then
            pressedDirections[direction] = true
        end
    end
    
    -- Convert pressed directions to an array
    local pressedDirArray = {}
    for dir, _ in pairs(pressedDirections) do
        table.insert(pressedDirArray, dir)
    end
    
    -- Check for combos first
    for comboName, combo in pairs(DPad.ComboDirections) do
        local requiredDirections = {}
        
        -- Extract required direction names from the combo
        for _, directionButtons in pairs(combo) do
            -- Get direction name from the first button in the direction list
            local direction = buttonToDirection[directionButtons[1]]
            if direction then
                requiredDirections[direction] = true
            end
        end
        
        -- Check if all required directions are pressed
        local allPressed = true
        for direction, _ in pairs(requiredDirections) do
            if not pressedDirections[direction] then
                allPressed = false
                break
            end
        end
        
        if allPressed then
            -- Count number of pressed directions to ensure we don't have extra directions
            local pressedCount = 0
            for _ in pairs(pressedDirections) do pressedCount = pressedCount + 1 end
            
            local requiredCount = 0
            for _ in pairs(requiredDirections) do requiredCount = requiredCount + 1 end
            
            if pressedCount == requiredCount then
                return comboName
            end
        end
    end
    
    -- If only one direction pressed, return it
    if #pressedDirArray == 1 then
        return pressedDirArray[1]
    end
    
    -- If multiple single directions but no combo, return the first one
    for dirName, _ in pairs(DPad.Directions) do
        if pressedDirections[dirName] then
            return dirName
        end
    end
    
    return nil
end

-- Function to get all pressed directions (for debugging or other uses)
function DPad.getPressedDirections(pressedButtons)
    local directions = {}
    
    -- Build reverse lookup table from button name to direction name
    local buttonToDirection = {}
    for dirName, buttons in pairs(DPad.Directions) do
        for _, button in ipairs(buttons) do
            buttonToDirection[button] = dirName
        end
    end
    
    -- Extract directions
    for _, buttonInfo in ipairs(pressedButtons) do
        local buttonName = buttonInfo["name"]
        local direction = buttonToDirection[buttonName]
        if direction and not directions[direction] then
            directions[direction] = true
        end
    end
    
    -- Convert to array
    local result = {}
    for dir, _ in pairs(directions) do
        table.insert(result, dir)
    end
    
    return result
end

-- New stateful function to track combos and handle 3-button scenarios
function DPad.getActiveDirectionWithMemory(pressedButtons, player_id)
    player_id = player_id or 1  -- Default to player 1 if not specified
    
    -- Get current pressed directions
    local currentDirectionsSet = {}
    local currentDirectionsArray = DPad.getPressedDirections(pressedButtons)
    for _, dir in ipairs(currentDirectionsArray) do
        currentDirectionsSet[dir] = true
    end
    
    -- Initialize player state if not exists
    if not DPad.PlayerState[player_id] then
        DPad.PlayerState[player_id] = {
            lastCombo = nil,
            lastComboButtons = {},
            wasInCombo = false
        }
    end
    
    local state = DPad.PlayerState[player_id]
    local buttonSet = DPad.createButtonSet(pressedButtons)
    
    -- First, check if we're currently in a valid single direction (exact match)
    local currentSingleDirection = nil
    local pressedDirectionCount = 0
    for directionName, directionButtons in pairs(DPad.Directions) do
        local isDirectionActive = false
        for _, button in ipairs(directionButtons) do
            if buttonSet[button] then
                isDirectionActive = true
                break
            end
        end
        
        if isDirectionActive then
            pressedDirectionCount = pressedDirectionCount + 1
            currentSingleDirection = directionName
        end
    end
    
    -- If we have exactly one direction pressed, it's a clear single direction
    if pressedDirectionCount == 1 then
        -- We're now in a single direction, clear combo state
        state.wasInCombo = false
        state.lastCombo = nil
        state.lastComboButtons = {}
        return currentSingleDirection
    end
    
    -- Check if we're currently in a valid combo
    local currentCombo = nil
    for comboName, combo in pairs(DPad.ComboDirections) do
        local allPressed = true
        
        for _, requiredDirection in pairs(combo) do
            local directionPressed = false
            for _, button in ipairs(requiredDirection) do
                if buttonSet[button] then
                    directionPressed = true
                    break
                end
            end
            
            if not directionPressed then
                allPressed = false
                break
            end
        end
        
        if allPressed then
            currentCombo = comboName
            break
        end
    end
    
    -- Logic for handling combo persistence
    if currentCombo then
        -- We're in a valid combo now
        state.lastCombo = currentCombo
        state.wasInCombo = true
        
        -- Store which specific buttons make up this combo
        state.lastComboButtons = {}
        for _, requiredDirection in pairs(DPad.ComboDirections[currentCombo]) do
            for _, button in ipairs(requiredDirection) do
                if buttonSet[button] then
                    table.insert(state.lastComboButtons, button)
                end
            end
        end
        
        return currentCombo
    elseif state.wasInCombo and state.lastCombo then
        -- We were in a combo before, check if we're transitioning out
        -- Count how many combo buttons are still pressed
        local stillPressedCount = 0
        for _, button in ipairs(state.lastComboButtons) do
            if buttonSet[button] then
                stillPressedCount = stillPressedCount + 1
            end
        end
        
        -- Also count how many directions are currently pressed
        local currentDirectionCount = 0
        for _ in pairs(currentDirectionsSet) do
            currentDirectionCount = currentDirectionCount + 1
        end
        
        -- If at least 2 buttons from the combo are still pressed 
        -- AND we have at least 2 directions pressed, keep the combo
        if stillPressedCount >= 2 and currentDirectionCount >= 2 then
            -- Check if we have a new valid combo
            local newCombo = nil
            for comboName, combo in pairs(DPad.ComboDirections) do
                local allPressed = true
                for _, requiredDirection in pairs(combo) do
                    local directionPressed = false
                    for _, button in ipairs(requiredDirection) do
                        if buttonSet[button] then
                            directionPressed = true
                            break
                        end
                    end
                    if not directionPressed then
                        allPressed = false
                        break
                    end
                end
                if allPressed then
                    newCombo = comboName
                    break
                end
            end
            
            -- Only return the old combo if we don't have a new valid combo
            if not newCombo then
                return state.lastCombo
            end
        else
            -- Combo is broken
            state.wasInCombo = false
            state.lastCombo = nil
            state.lastComboButtons = {}
        end
    end
    
    -- If we get here, no combo is active or we need to find a new direction
    state.wasInCombo = false
    state.lastCombo = nil
    
    -- Check for single directions (should only reach here if multiple directions but no valid combo)
    for directionName, directionButtons in pairs(DPad.Directions) do
        for _, button in ipairs(directionButtons) do
            if buttonSet[button] then
                return directionName
            end
        end
    end
    
    return nil
end

-- Alias the optimized version as the main function
function DPad.getActiveDirection(pressedButtons, player_id)
    -- Use the stateful version by default
    return DPad.getActiveDirectionWithMemory(pressedButtons, player_id)
    
    -- Uncomment the line below to use the non-stateful version instead
    -- return DPad.getActiveDirectionOptimizedFromTable(pressedButtons)
end

-- Function to reset player state (useful on level restart, etc.)
function DPad.resetPlayerState(player_id)
    if player_id then
        DPad.PlayerState[player_id] = nil
    else
        DPad.PlayerState = {}
    end
end

-- Function to get the current state for debugging
function DPad.getPlayerState(player_id)
    player_id = player_id or 1
    return DPad.PlayerState[player_id]
end

function DPad.getAllDirectionRawNames()
    local names = {}
    for _, buttons in pairs(DPad.Directions) do
        for _, btn in ipairs(buttons) do
            names[btn] = true
        end
    end
    return names
end

return DPad