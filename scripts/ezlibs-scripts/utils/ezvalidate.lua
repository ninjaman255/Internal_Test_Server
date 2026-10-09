-- ezvalidate.lua
-- Dependency-free validation helpers for Lua 5.2.

local ezvalidate = {}

function ezvalidate.is_type(value, expected_type)
    assert(type(expected_type) == "string", "expected_type must be a string")
    return type(value) == expected_type
end

function ezvalidate.number_range(value, minimum, maximum)
    if type(value) ~= "number" then
        return false, "expected a number"
    end
    if minimum ~= nil and type(minimum) ~= "number" then
        return false, "minimum must be a number or nil"
    end
    if maximum ~= nil and type(maximum) ~= "number" then
        return false, "maximum must be a number or nil"
    end
    if minimum ~= nil and maximum ~= nil and minimum > maximum then
        return false, "minimum must be <= maximum"
    end
    if minimum ~= nil and value < minimum then
        return false, "value is below minimum"
    end
    if maximum ~= nil and value > maximum then
        return false, "value is above maximum"
    end
    return true
end

function ezvalidate.required_fields(value, fields)
    if type(value) ~= "table" then
        return false, "value must be a table"
    end
    if type(fields) ~= "table" then
        return false, "fields must be a table"
    end

    for _, field in ipairs(fields) do
        if value[field] == nil then
            return false, "missing required field: " .. tostring(field)
        end
    end
    return true
end

function ezvalidate.table_field_types(value, expected)
    if type(value) ~= "table" then
        return false, "value must be a table"
    end
    if type(expected) ~= "table" then
        return false, "expected must be a table"
    end

    for field, expected_type in pairs(expected) do
        if type(expected_type) ~= "string" then
            return false, "expected type for field " .. tostring(field) .. " must be a string"
        end
        if type(value[field]) ~= expected_type then
            return false, "field " .. tostring(field) .. " must be " .. expected_type
        end
    end
    return true
end

return ezvalidate
