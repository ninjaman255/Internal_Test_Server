-- enumset.lua
-- A container that holds multiple enums and returns a fresh copy
-- of an enum when accessed by key.
-- Requires enum.lua

local Enum = require("scripts/enum/enum")

local EnumSet = {}

-- Create a new EnumSet from a table of enums.
-- The input `definitions` is a table mapping string keys to enum objects
-- created by Enum.new().
-- Accessing a key in the returned set returns a fresh copy of that enum.
function EnumSet.new(definitions)
    assert(type(definitions) == "table", "EnumSet.new expects a table of enums")
    local set = {}
    local internalEnums = {}  -- store original enums for copy generation

    -- validate input: all values must be enum tables (have a copy method)
    for key, enum in pairs(definitions) do
        assert(type(key) == "string", "EnumSet keys must be strings")
        assert(type(enum) == "table" and enum.copy, "EnumSet values must be enums")
        internalEnums[key] = enum
    end

    -- Container methods
    local methods = {
        -- Returns a list of all keys in the set
        keys = function(self)
            local result = {}
            for key in pairs(internalEnums) do
                result[#result + 1] = key
            end
            table.sort(result)
            return result
        end,

        -- Returns the original enum (without copying) – use with caution
        getOriginal = function(self, key)
            return internalEnums[key]
        end,

        -- Returns a copy of the enum for the given key (same as set[key])
        get = function(self, key)
            local enum = internalEnums[key]
            if enum then
                return enum:copy()
            end
            return nil
        end,
    }

    setmetatable(set, {
        __index = function(tbl, key)
            -- First check if the key corresponds to an enum definition
            local enum = internalEnums[key]
            if enum then
                return enum:copy()
            end
            -- Otherwise, check container methods
            return methods[key]
        end,
        -- Prevent modification of the set's enum definitions via assignment
        __newindex = function(tbl, key, value)
            error("Cannot modify an EnumSet directly. Use methods or create a new set.")
        end,
    })

    return set
end

return EnumSet