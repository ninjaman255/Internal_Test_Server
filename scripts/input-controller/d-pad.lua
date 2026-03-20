local Utility = require("scripts/utils/utility")
local DPad = {}

local Emitter = Utility.EventEmitter.new()
DPad.Emitter = Emitter

function DPad.EmitButtonPressed(button, player_id)
    Emitter:emit("button_pressed", {button = button, player_id = player_id})
end

-- Direction definitions
DPad.Directions = {
    Left   = { "Move Left", "UI Left" },
    Right  = { "Move Right", "UI Right" },
    Up     = { "Move Up", "UI Up" },
    Down   = { "Move Down", "UI Down" },
}

-- Combos defined as sets of direction names (simpler)
DPad.ComboDirections = {
    DownLeft  = { "Down", "Left" },
    UpLeft    = { "Up", "Left" },
    UpRight   = { "Up", "Right" },
    DownRight = { "Down", "Right" }
}

-- Reverse lookup: raw button name -> direction name
local buttonToDirection = {}
for dirName, buttons in pairs(DPad.Directions) do
    for _, btn in ipairs(buttons) do
        buttonToDirection[btn] = dirName
    end
end

-- State tracking per player
DPad.PlayerState = {}

-- Helper: get set of currently pressed direction names
local function getPressedDirectionSet(pressedButtons)
    local dirSet = {}
    for _, btnInfo in ipairs(pressedButtons) do
        local dir = buttonToDirection[btnInfo.name]
        if dir then
            dirSet[dir] = true
        end
    end
    return dirSet
end

-- Helper: get array of pressed direction names
local function getPressedDirections(pressedButtons)
    local dirs = {}
    local seen = {}
    for _, btnInfo in ipairs(pressedButtons) do
        local dir = buttonToDirection[btnInfo.name]
        if dir and not seen[dir] then
            seen[dir] = true
            table.insert(dirs, dir)
        end
    end
    return dirs
end

-- Main stateful direction detection
function DPad.getActiveDirectionWithMemory(pressedButtons, player_id)
    player_id = player_id or 1

    local pressedDirs = getPressedDirections(pressedButtons)
    local pressedSet = getPressedDirectionSet(pressedButtons)
    local pressedCount = #pressedDirs

    -- Initialize player state
    if not DPad.PlayerState[player_id] then
        DPad.PlayerState[player_id] = {
            lastCombo = nil,
            lastComboDirs = {},   -- direction names that formed the last combo
            wasInCombo = false
        }
    end
    local state = DPad.PlayerState[player_id]

    -- If exactly one direction pressed, it's a clear single direction
    if pressedCount == 1 then
        state.wasInCombo = false
        state.lastCombo = nil
        state.lastComboDirs = {}
        return pressedDirs[1]
    end

    -- Check for a valid combo among currently pressed directions
    local currentCombo = nil
    for comboName, requiredDirs in pairs(DPad.ComboDirections) do
        local ok = true
        for _, reqDir in ipairs(requiredDirs) do
            if not pressedSet[reqDir] then
                ok = false
                break
            end
        end
        if ok then
            currentCombo = comboName
            break
        end
    end

    if currentCombo then
        -- Valid combo detected
        state.lastCombo = currentCombo
        state.lastComboDirs = {}
        for _, dir in ipairs(DPad.ComboDirections[currentCombo]) do
            state.lastComboDirs[dir] = true
        end
        state.wasInCombo = true
        return currentCombo
    end

    -- Not in a valid combo now, but we might have been in one last frame
    if state.wasInCombo and state.lastCombo then
        -- Count how many of the previous combo's directions are still pressed
        local stillPressedCount = 0
        for dir, _ in pairs(state.lastComboDirs) do
            if pressedSet[dir] then
                stillPressedCount = stillPressedCount + 1
            end
        end

        -- If at least 2 of the original combo directions remain and total pressed >=2,
        -- we try to see if any new combo has formed. If not, we preserve the old combo.
        if stillPressedCount >= 2 and pressedCount >= 2 then
            -- Check again for any valid combo (might be different)
            for comboName, requiredDirs in pairs(DPad.ComboDirections) do
                local ok = true
                for _, reqDir in ipairs(requiredDirs) do
                    if not pressedSet[reqDir] then
                        ok = false
                        break
                    end
                end
                if ok then
                    -- New combo found – switch to it
                    state.lastCombo = comboName
                    state.lastComboDirs = {}
                    for _, dir in ipairs(requiredDirs) do
                        state.lastComboDirs[dir] = true
                    end
                    return comboName
                end
            end
            -- No new combo, but still enough directions held → keep old combo
            return state.lastCombo
        else
            -- Combo is broken
            state.wasInCombo = false
            state.lastCombo = nil
            state.lastComboDirs = {}
        end
    end

    -- Fallback: if any single direction is pressed, return the first one
    for _, dir in ipairs(pressedDirs) do
        return dir
    end

    return nil
end

-- Public alias
DPad.getActiveDirection = DPad.getActiveDirectionWithMemory

-- Reset player state
function DPad.resetPlayerState(player_id)
    if player_id then
        DPad.PlayerState[player_id] = nil
    else
        DPad.PlayerState = {}
    end
end

-- Get all raw direction button names (for filtering in InputController)
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