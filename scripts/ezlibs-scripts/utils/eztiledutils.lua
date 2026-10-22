-- tiled_utils.lua
-- Shared helpers for Tiled property access.
--
-- Replaces local helpers in:
--   * eznpcs.lua / eznpcs/dialogue_types.lua  (is_property_true)
--   * FootBomb                                  (as_string / as_number)
--   * ezpushback.lua                            (truthy / number_property)
--
-- Runtime properties live at object.custom_properties (the shape used
-- throughout ezlibs). For forward compatibility, object.properties is also
-- accepted in both map form (name -> value) and array form
-- (name/type/value entries).
--
-- This module requires nothing, so it is safe to require from leaf files such
-- as dialogue_types.lua without creating circular dependencies.

local M = {}

--------------------------------------------------------------------------
-- Primitive coercions (value-level, no object lookup)
--------------------------------------------------------------------------

-- Canonical boolean normalizer.
--
--   true / "true" / "1" / "yes" / "on" / non-zero number -> true
--   false / "false" / "0" / "no" / "off" / "" / 0        -> false
--   nil                                                  -> default (false if omitted)
--
-- After validate_properties() succeeds against a class schema, booleans are
-- guaranteed to be real booleans or the string forms above, so the liberal
-- handling here is a safety net for optional properties and for call sites
-- that bypass validation.
function M.is_true(value, default)
    if value == nil then
        return default == true
    end
    if value == true  then return true  end
    if value == false then return false end
    if type(value) == "number" then
        return value ~= 0
    end
    if type(value) == "string" then
        local v = value:lower()
        return v == "true" or v == "1" or v == "yes" or v == "on"
    end
    return false
end

-- Strict number parsing. Matches FootBomb as_number and ezpushback
-- number_property: returns default on non-numbers and unparseable strings.
function M.to_number(value, default)
    if type(value) == "number" then
        if value ~= value then return default end -- NaN
        return value
    end
    if type(value) == "string" then
        local n = tonumber(value)
        if n ~= nil then return n end
    end
    return default
end

-- String normalization. Numbers and booleans become their string form;
-- tables and nil return default.
function M.to_string(value, default)
    local t = type(value)
    if t == "string"  then return value end
    if t == "number"  then return tostring(value) end
    if t == "boolean" then return tostring(value) end
    return default
end

--------------------------------------------------------------------------
-- Raw lookup: object -> property value (not entry)
--------------------------------------------------------------------------

-- Return the runtime value for `name` on `obj`, or nil.
-- custom_properties wins when it has the field; otherwise falls through to
-- the older .properties shape (array-of-entries or map-of-{value=,type=}).
local function raw_lookup(obj, name)
    if type(obj) ~= "table" then return nil end

    local cp = obj.custom_properties
    if type(cp) == "table" and cp[name] ~= nil then
        return cp[name]
    end

    local props = obj.properties
    if type(props) ~= "table" then return nil end

    local direct = props[name]
    if direct ~= nil then
        if type(direct) == "table"
            and direct.name == nil
            and (direct.value ~= nil or direct.type ~= nil) then
            return direct.value
        end
        return direct
    end

    for i = 1, #props do
        local p = props[i]
        if type(p) == "table" and p.name == name then
            return p.value
        end
    end

    for k, v in pairs(props) do
        if type(k) == "number" and type(v) == "table" and v.name == name then
            return v.value
        end
    end

    return nil
end

--------------------------------------------------------------------------
-- Object-level accessors
--------------------------------------------------------------------------

function M.get_property(obj, name, default)
    local v = raw_lookup(obj, name)
    if v == nil then return default end
    return v
end

function M.get_string(obj, name, default)
    return M.to_string(raw_lookup(obj, name), default)
end

function M.get_number(obj, name, default)
    return M.to_number(raw_lookup(obj, name), default)
end

function M.get_boolean(obj, name, default)
    return M.is_true(raw_lookup(obj, name), default)
end

-- Resolve an object reference stored as an ID.
--
--   resolver: function(id) -> object|nil  (typically
--             function(id) return ezcache.get_object_by_id_cached(area_id, id) end)
--
-- Returns (resolved_object, true) on success.
-- Returns (default, false) if the property is nil or "" (Tiled convention for
--   "no reference" — matches prop("X", "object", "") in the generator).
-- Returns (raw_id, false) if a resolver was not given or the resolver missed.
function M.get_object_reference(obj, name, resolver, default)
    local v = raw_lookup(obj, name)
    if v == nil or v == "" then return default, false end
    if type(v) == "table" then return v, true end
    if resolver ~= nil then
        local resolved = resolver(v)
        if resolved ~= nil then return resolved, true end
    end
    return v, false
end

-- Tiled 1.9+ uses .class; older Tiled data and various loaders use .type.
function M.get_class_or_type(obj)
    if type(obj) ~= "table" then return nil end
    local c = obj.class
    if type(c) == "string" and c ~= "" then return c end
    local t = obj.type
    if type(t) == "string" and t ~= "" then return t end
    return nil
end

--------------------------------------------------------------------------
-- Props-table accessors
-- For call sites that already hold object.custom_properties.
--------------------------------------------------------------------------

function M.get_string_from(props, name, default)
    if type(props) ~= "table" then return default end
    return M.to_string(props[name], default)
end

function M.get_number_from(props, name, default)
    if type(props) ~= "table" then return default end
    return M.to_number(props[name], default)
end

function M.get_boolean_from(props, name, default)
    if type(props) ~= "table" then return default == true end
    return M.is_true(props[name], default)
end

--------------------------------------------------------------------------
-- Debug helpers
--------------------------------------------------------------------------

-- Normalize an object's properties into a flat name -> value map.
function M.normalize_properties(obj)
    local out = {}
    if type(obj) ~= "table" then return out end

    local cp = obj.custom_properties
    if type(cp) == "table" then
        for k, v in pairs(cp) do
            if type(k) == "string" then out[k] = v end
        end
    end

    local props = obj.properties
    if type(props) == "table" then
        for k, v in pairs(props) do
            if type(k) == "string" then
                if type(v) == "table"
                    and v.name == nil
                    and (v.value ~= nil or v.type ~= nil) then
                    out[k] = v.value
                else
                    out[k] = v
                end
            elseif type(k) == "number" and type(v) == "table" and v.name then
                out[v.name] = v.value
            end
        end
    end

    return out
end

--------------------------------------------------------------------------
-- Validation
--------------------------------------------------------------------------

-- Validate an object against an array of schema property definitions
-- (the .members array from ezlibs-tiled-schema.lua).
--
-- schema_props: { {name=, type=, value=, propertyType=, required=, ...}, ... }
-- enums:        optional { [name] = { values = {...} } }
--
-- Returns (ok, report). report = {
--     errors  = { {name, issue, expected, got}, ... },
--     values  = { name -> coerced value },   -- includes defaults
--     missing = { name, ... },
-- }
function M.validate_properties(obj, schema_props, enums)
    local report = { errors = {}, values = {}, missing = {} }
    if type(obj) ~= "table" then
        report.errors[#report.errors+1] = { name = nil, issue = "object_nil" }
        return false, report
    end

    for i = 1, #schema_props do
        local field = schema_props[i]
        local name  = field.name
        local raw   = raw_lookup(obj, name)

        if raw == nil then
            if field.required == true then
                report.missing[#report.missing+1] = name
                report.errors[#report.errors+1] = {
                    name = name, issue = "missing", expected = field.type,
                }
            else
                report.values[name] = field.value
            end
        else
            local coerced, ok = nil, true
            local typ = field.type
            if typ == "number" or typ == "int" or typ == "float" then
                coerced = M.to_number(raw, nil)
                ok = coerced ~= nil
            elseif typ == "bool" or typ == "boolean" then
                local t = type(raw)
                if t == "boolean" or t == "number" or t == "string" then
                    coerced = M.is_true(raw, false)
                else
                    ok = false
                end
            elseif typ == "object" or typ == "class" then
                if raw == "" then
                    coerced = field.value
                else
                    coerced = raw
                end
            else -- string / file / color / any
                coerced = M.to_string(raw, nil)
                ok = coerced ~= nil
            end

            if not ok then
                report.errors[#report.errors+1] = {
                    name = name, issue = "invalid_type",
                    expected = typ, got = type(raw),
                }
            else
                local enum_name = field.propertyType or field.enum
                if enum_name and enums and enums[enum_name] then
                    local allowed = enums[enum_name].values or {}
                    local valid = false
                    for _, x in ipairs(allowed) do
                        if x == coerced then valid = true; break end
                    end
                    if not valid then
                        report.errors[#report.errors+1] = {
                            name = name, issue = "invalid_enum",
                            expected = enum_name, got = tostring(coerced),
                        }
                    else
                        report.values[name] = coerced
                    end
                else
                    report.values[name] = coerced
                end
            end
        end
    end

    return #report.errors == 0, report
end

return M