-- enum.lua
-- A reusable Lua 5.2 module for creating enum-like tables.
-- Supports custom key-value definitions, active value validation,
-- and copying for independent instances.
-- No external dependencies.

local Enum = {}

-- Create a new enum.
-- Accepts:
--   1. A list of names (strings) -> values become 1,2,3,...
--      e.g., Enum.new("RED", "GREEN", "BLUE")
--   2. A table of key-value pairs (old format)
--      e.g., Enum.new({ RED = "red", GREEN = "green", BLUE = 0x0000FF })
--   3. A table with 'options' and optional 'active' (new format)
--      e.g., Enum.new({ options = { RED = "red", GREEN = "green" }, active = "green" })
--      If 'active' is not provided, the first option becomes active.
function Enum.new(...)
    local args = {...}
    local optionsTable
    local initialActive = nil

    if #args == 1 and type(args[1]) == "table" then
        local input = args[1]
        -- Detect new format: input.options is a table
        if input.options and type(input.options) == "table" then
            optionsTable = input.options
            if input.active ~= nil then
                initialActive = input.active
            end
        else
            -- Old format: the table itself is the options
            optionsTable = input
        end
    else
        -- List of names
        optionsTable = {}
        for i, name in ipairs(args) do
            assert(type(name) == "string", "Enum names must be strings")
            optionsTable[name] = i
        end
    end

    local keyToValue = {}
    local valueToKey = {}
    local orderedKeys = {}   -- preserve insertion order
    local orderedValues = {} -- preserve insertion order

    -- Populate mappings and validate uniqueness
    for key, value in pairs(optionsTable) do
        assert(type(key) == "string", "Enum keys must be strings")
        assert(keyToValue[key] == nil, "Duplicate enum key: " .. key)
        assert(valueToKey[value] == nil, "Duplicate enum value: " .. tostring(value))

        keyToValue[key] = value
        valueToKey[value] = key
        orderedKeys[#orderedKeys + 1] = key
        orderedValues[#orderedValues + 1] = value
    end

    -- Internal active value
    local activeValue
    if initialActive ~= nil then
        assert(valueToKey[initialActive] ~= nil, "Invalid active value for enum")
        activeValue = initialActive
    else
        activeValue = orderedValues[1]  -- may be nil if empty
    end

    -- Define methods BEFORE they are referenced in the metatable.
    -- They close over the local variables above.
    local methods = {
        -- Return the key for a given value (requires unique values)
        getName = function(self, value)
            return valueToKey[value]
        end,

        -- Return the value for a given key
        getValue = function(self, key)
            return keyToValue[key]
        end,

        -- Check if a value is valid (exists in enum)
        isValid = function(self, value)
            return valueToKey[value] ~= nil
        end,

        -- Return a sorted list of all keys (names)
        names = function(self)
            local result = {}
            for key in pairs(keyToValue) do
                result[#result + 1] = key
            end
            table.sort(result)
            return result
        end,

        -- Return a list of all values in insertion order
        values = function(self)
            local result = {}
            for i, v in ipairs(orderedValues) do
                result[i] = v
            end
            return result
        end,

        -- Get the current active value
        getActive = function(self)
            return activeValue
        end,

        -- Set the active value (validated)
        setActive = function(self, value)
            assert(valueToKey[value] ~= nil, "Invalid active value for enum")
            activeValue = value
            return value
        end,

        -- Return a random valid value
        random = function(self)
            if #orderedValues == 0 then return nil end
            return orderedValues[math.random(#orderedValues)]
        end,

        -- Alias for random
        new = function(self)
            return self:random()
        end,

        -- Returns a new independent enum with the same options
        copy = function(self)
            return Enum.new({ options = keyToValue, active = activeValue })
        end,
    }

    -- The enum table itself will hold the key->value pairs directly
    local enum = {}
    for key, value in pairs(keyToValue) do
        enum[key] = value
    end

    -- Metatable to enforce validation and provide methods
    local mt = {
        __index = function(tbl, key)
            if key == "active" then
                return activeValue
            elseif key == "options" then
                -- Return a copy to prevent accidental modification
                local copy = {}
                for k, v in pairs(keyToValue) do
                    copy[k] = v
                end
                return copy
            else
                return methods[key]
            end
        end,

        __newindex = function(tbl, key, value)
            if key == "active" then
                assert(valueToKey[value] ~= nil, "Invalid active value for enum")
                activeValue = value
            elseif key == "options" then
                error("Cannot modify enum options")
            else
                error("Cannot modify enum – only 'active' can be set")
            end
        end,

        __tostring = function(tbl)
            local parts = {}
            for i, key in ipairs(orderedKeys) do
                parts[#parts + 1] = string.format("%s=%s", key, tostring(keyToValue[key]))
            end
            return "Enum(" .. table.concat(parts, ", ") .. ")"
        end,
    }

    setmetatable(enum, mt)

    return enum
end

return Enum