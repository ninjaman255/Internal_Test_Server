-- enum.lua
-- A reusable Lua 5.2 module for creating enum-like tables.
-- Supports custom key-value definitions, active value validation,
-- and copying for independent instances.
-- No external dependencies.

local Enum = {}

-- Create a new enum.
-- Accepts either:
--   1. A list of names (strings) -> values become 1,2,3,...
--      e.g., Enum.new("RED", "GREEN", "BLUE")
--   2. A table of key-value pairs where keys are strings and values can be anything.
--      e.g., Enum.new({RED = "red", GREEN = "green", BLUE = 0x0000FF})
function Enum.new(...)
    local args = {...}
    local inputTable
    if #args == 1 and type(args[1]) == "table" then
        inputTable = args[1]
    else
        -- convert list of names to a table {name = index}
        inputTable = {}
        for i, name in ipairs(args) do
            assert(type(name) == "string", "Enum names must be strings")
            inputTable[name] = i
        end
    end

    local enum = {}
    local keyToValue = {}
    local valueToKey = {}
    local orderedKeys = {}   -- preserve insertion order
    local orderedValues = {} -- preserve insertion order

    -- Populate mappings and validate uniqueness
    for key, value in pairs(inputTable) do
        assert(type(key) == "string", "Enum keys must be strings")
        assert(keyToValue[key] == nil, "Duplicate enum key: " .. key)
        assert(valueToKey[value] == nil, "Duplicate enum value: " .. tostring(value))

        keyToValue[key] = value
        valueToKey[value] = key
        orderedKeys[#orderedKeys + 1] = key
        orderedValues[#orderedValues + 1] = value
        enum[key] = value   -- expose key -> value directly in enum table
    end

    -- Set default active value (first value, or nil if enum is empty)
    local activeValue = orderedValues[1]

    -- Metatable to enforce validation of 'active' and provide methods
    local mt = {
        __index = {
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

            -- Return a copy of the complete options table (key-value pairs)
            options = function(self)
                local result = {}
                for key, value in pairs(keyToValue) do
                    result[key] = value
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

            -- Alias for random (kept from previous version)
            new = function(self)
                return self:random()
            end,

            -- Returns a new independent enum with the same options
            -- Note: The initial active value may not be deterministic due to
            -- unordered iteration in options(). If needed, set it explicitly.
            copy = function(self)
                return Enum.new(self:options())
            end,

            -- String representation
            __tostring = function(self)
                local parts = {}
                for i, key in ipairs(orderedKeys) do
                    parts[#parts + 1] = string.format("%s=%s", key, tostring(keyToValue[key]))
                end
                return "Enum(" .. table.concat(parts, ", ") .. ")"
            end,
        },

        -- Intercept assignments to 'active' to enforce validity
        __newindex = function(self, key, value)
            if key == "active" then
                assert(valueToKey[value] ~= nil, "Invalid active value for enum")
                rawset(self, key, value)  -- store the actual value in the table
                activeValue = value       -- update our internal reference
            else
                rawset(self, key, value)  -- allow other fields normally
            end
        end,
    }

    setmetatable(enum, mt)

    -- Set the initial active value
    if activeValue ~= nil then
        enum.active = activeValue
    end

    return enum
end

return Enum