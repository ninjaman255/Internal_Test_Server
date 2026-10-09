-- ezutil.lua
-- Small, dependency-free helpers for Lua 5.2.
-- This module does not depend on ezlibs host APIs.

local ezutil = {}

function ezutil.clamp(value, minimum, maximum)
    assert(type(value) == "number", "value must be a number")
    assert(type(minimum) == "number", "minimum must be a number")
    assert(type(maximum) == "number", "maximum must be a number")
    assert(minimum <= maximum, "minimum must be <= maximum")

    if value < minimum then return minimum end
    if value > maximum then return maximum end
    return value
end

function ezutil.table_contains(list, value)
    assert(type(list) == "table", "list must be a table")
    for _, item in ipairs(list) do
        if item == value then return true end
    end
    return false
end

function ezutil.table_remove_value(list, value, remove_all)
    assert(type(list) == "table", "list must be a table")
    local removed = 0
    local index = 1

    while index <= #list do
        if list[index] == value then
            table.remove(list, index)
            removed = removed + 1
            if not remove_all then break end
        else
            index = index + 1
        end
    end

    return removed
end

function ezutil.table_count(value)
    assert(type(value) == "table", "value must be a table")
    local count = 0
    for _ in pairs(value) do
        count = count + 1
    end
    return count
end

function ezutil.table_is_empty(value)
    assert(type(value) == "table", "value must be a table")
    return next(value) == nil
end

function ezutil.shallow_copy(source)
    assert(type(source) == "table", "source must be a table")
    local copy = {}
    for key, value in pairs(source) do
        copy[key] = value
    end
    return copy
end

-- Copies table keys and values recursively. Handles cycles and shared references.
function ezutil.deep_copy(source, seen)
    if type(source) ~= "table" then return source end

    seen = seen or {}
    if seen[source] then return seen[source] end

    local copy = {}
    seen[source] = copy

    for key, value in pairs(source) do
        copy[ezutil.deep_copy(key, seen)] = ezutil.deep_copy(value, seen)
    end

    return setmetatable(copy, getmetatable(source))
end

-- Copies keys from source into target. Existing target keys are overwritten.
function ezutil.table_merge(target, source)
    assert(type(target) == "table", "target must be a table")
    assert(type(source) == "table", "source must be a table")

    for key, value in pairs(source) do
        target[key] = value
    end

    return target
end

return ezutil
