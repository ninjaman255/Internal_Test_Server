-- validation.lua
local Constants = require("scripts/ezlibs-custom/nebulous-liberations/liberations/constants")

local Validation = {}

-- Log a warning or error (replace with proper logging)
local function log(level, message)
    print(string.format("[%s] %s", level, message))
end

-- Validate a single object
local function validate_object(area_id, object)
    local type = object.type
    if not type then return end

    -- Required objects
    if type == "Spawn Point" then
        if not object.custom_properties[Constants.CustomProperties.NextSpawn] then
            log("WARN", "Spawn Point at ("..object.x..","..object.y..") has no 'Next Spawn' property; will use default spawn order")
        end
    end

    -- Dark Hole validation
    if type == Constants.PanelTypes.DarkHole then
        if not object.custom_properties[Constants.CustomProperties.Spawns] then
            log("ERROR", "Dark Hole at ("..object.x..","..object.y..") missing 'Spawns' property")
            return false
        end
        if not object.custom_properties[Constants.CustomProperties.Direction] then
            log("ERROR", "Dark Hole at ("..object.x..","..object.y..") missing 'Direction' property")
            return false
        end
    end

    -- Boss validation
    if object.custom_properties[Constants.CustomProperties.Boss] then
        if not object.custom_properties[Constants.CustomProperties.Direction] then
            log("ERROR", "Boss at ("..object.x..","..object.y..") missing 'Direction' property")
            return false
        end
    end

    -- Panel gates
    if type == Constants.PanelTypes.PanelGate then
        if not object.custom_properties[Constants.CustomProperties.GateKey] then
            log("ERROR", "Panel Gate at ("..object.x..","..object.y..") missing 'Gate Key' property")
            return false
        end
    end

    -- Points of Interest
    if type == "Point of Interest" then
        if object.custom_properties[Constants.CustomProperties.GateID] and not object.custom_properties[Constants.CustomProperties.isBoss] then
            -- Gate ID is used for cutscenes, but not mandatory
        end
    end

    return true
end

-- Validate a whole area
function Validation.validate_area(area_id)
    local errors = 0
    local objects = Net.list_objects(area_id)
    local spawn_found = false

    for _, obj_id in ipairs(objects) do
        local obj = Net.get_object_by_id(area_id, obj_id)
        if not obj then goto continue end

        if obj.type == "Spawn Point" then
            spawn_found = true
        end

        if not validate_object(area_id, obj) then
            errors = errors + 1
        end

        ::continue::
    end

    if not spawn_found then
        log("ERROR", "No Spawn Point found in area " .. Net.get_area_name(area_id))
        errors = errors + 1
    end

    return errors == 0
end

-- Print validation results to console
function Validation.report(area_id)
    print("Validating area: " .. Net.get_area_name(area_id))
    local ok = Validation.validate_area(area_id)
    if ok then
        print("Validation passed.")
    else
        print("Validation failed. Check logs above.")
    end
    return ok
end

return Validation