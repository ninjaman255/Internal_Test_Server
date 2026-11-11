-- validation.lua
local Constants = require("scripts/ezlibs-custom/nebulous-liberations/liberations/constants")
local EnemyConfig = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_config")
local validation_log = require("scripts/ezlibs-custom/nebulous-liberations/liberations/logger").validation

local Validation = {}

-- Separate mission validation output from generic server console logging.
local function log(level, message)
    local details = {message = message}
    if level == "ERROR" then
        validation_log:error_data("Liberation validation error", details)
    else
        validation_log:warn_data("Liberation validation warning", details)
    end
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
    if type == Constants.PanelTypes.DarkHole or type == Constants.PanelTypes.DarkHoleBuffedVirus then
        local properties = object.custom_properties or {}
        local category = object.type == Constants.PanelTypes.DarkHoleBuffedVirus
            and "Buffed Virus" or "Dark Hole"
        local resolved = EnemyConfig.resolve(area_id, object,
            Constants.CustomProperties.MinionHealthOverride, category)
        if not resolved.template_name then
            log("ERROR", "Dark Hole object " .. tostring(object.id)
                .. " at (" .. tostring(object.x) .. "," .. tostring(object.y)
                .. ") has no OW template (Spawns or shared Enemy Config)")
            return false
        end
        -- Direction defaults to Down if not explicitly configured; the
        -- spawning code applies the same fallback to initial and respawns.
        if not properties[Constants.CustomProperties.Direction]
            or properties[Constants.CustomProperties.Direction] == "" then
            log("WARN", "Dark Hole object " .. tostring(object.id)
                .. " has no Direction; using Down")
        end
        for _, field in ipairs({"Max HP", "Starting HP", "OW Scale", "Battle Scale",
                "OW Attack Damage", "OW Damage Multiplier",
                "Battle Attack Multiplier", "Battle Defense Multiplier"}) do
            local raw = properties[field]
            if raw ~= nil and raw ~= "" then
                local value = tonumber(raw)
                if not value or value < 0 or value ~= value or value == math.huge then
                    log("ERROR", "Dark Hole object " .. tostring(object.id)
                        .. " has invalid " .. field .. " value: " .. tostring(raw))
                    return false
                end
            end
        end
        local liberation_ref = object.custom_properties[Constants.CustomProperties.DarkHoleLiberationEncounters]
        if liberation_ref ~= nil and tostring(liberation_ref) ~= "" and tostring(liberation_ref) ~= "0" then
            local list_object = Net.get_object_by_id(area_id, tonumber(liberation_ref) or liberation_ref)
            if not list_object or list_object.type ~= "Dark Hole Encounter List" then
                log("ERROR", "Dark Hole at ("..object.x..","..object.y
                    ..") has a 'Liberation Encounters' reference that is not a Dark Hole Encounter List")
                return false
            end
        end
        local minion_health_override = tonumber(
            object.custom_properties[Constants.CustomProperties.MinionHealthOverride])
        if minion_health_override and minion_health_override < 0 then
            log("ERROR", "Dark Hole at ("..object.x..","..object.y..") has a negative 'Minion Health Override'")
            return false
        end
        if type == Constants.PanelTypes.DarkHoleBuffedVirus then
            local scale = tonumber(object.custom_properties[Constants.CustomProperties.Scale])
            if scale ~= nil and (scale <= 0 or scale ~= scale or scale == math.huge) then
                log("ERROR", "Dark Hole Buffed Virus at ("..object.x..","..object.y..") has an invalid 'scale' value")
                return false
            end
        end
    end

    -- Boss Dark Panel validation (also accepts legacy objects carrying Boss).
    if object.custom_properties[Constants.CustomProperties.Boss] then
        local boss_name = object.custom_properties[Constants.CustomProperties.Boss]
        if boss_name == "" then
            log("ERROR", "Boss Dark Panel at ("..object.x..","..object.y..") has an empty 'Boss' property")
            return false
        end
        local spawn_mode = object.custom_properties[Constants.CustomProperties.SpawnMode] or "Immediate"
        local valid_modes = {
            ["Immediate"] = true,
            ["On Dark Hole Cleared"] = true,
            ["Manual"] = true,
            ["After Boss Defeated"] = true,
        }
        if not valid_modes[spawn_mode] then
            log("ERROR", "Boss Dark Panel at ("..object.x..","..object.y..") has invalid 'Spawn Mode': "..tostring(spawn_mode))
            return false
        end
        if spawn_mode == "After Boss Defeated"
            and not object.custom_properties[Constants.CustomProperties.TriggerBoss] then
            log("ERROR", "Boss Dark Panel at ("..object.x..","..object.y..") uses 'After Boss Defeated' but has no 'Trigger Boss' reference")
            return false
        end
        local health_override = tonumber(object.custom_properties[Constants.CustomProperties.BossHealthOverride])
        if health_override and health_override < 0 then
            log("ERROR", "Boss Dark Panel at ("..object.x..","..object.y..") has a negative 'Boss Health Override'")
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
    local boss_object_ids = {}
    local boss_ids = {}
    local boss_trigger_refs = {}
    local panel_boss_refs = {}

    for _, obj_id in ipairs(objects) do
        local obj = Net.get_object_by_id(area_id, obj_id)
        if not obj then goto continue end

        if obj.type == "Spawn Point" then
            spawn_found = true
        end

        local boss_name = obj.custom_properties
            and obj.custom_properties[Constants.CustomProperties.Boss]
        if boss_name and boss_name ~= "" then
            boss_object_ids[tostring(obj.id)] = true
            local boss_id = obj.custom_properties[Constants.CustomProperties.BossID]
            if boss_id and boss_id ~= "" then
                boss_id = tostring(boss_id)
                if boss_ids[boss_id] then
                    log("ERROR", "Duplicate Boss ID '"..boss_id.."' in area "..tostring(area_id))
                    errors = errors + 1
                else
                    boss_ids[boss_id] = true
                end
            end
            local trigger_ref = obj.custom_properties[Constants.CustomProperties.TriggerBoss]
            if trigger_ref and trigger_ref ~= "" then
                boss_trigger_refs[#boss_trigger_refs + 1] = {
                    boss_id = boss_id or tostring(obj.id),
                    source_object_id = tostring(obj.id),
                    trigger_ref = tostring(trigger_ref),
                }
            end
        end

        if obj.custom_properties then
            local properties = obj.custom_properties
            local is_boss_association_object = obj.type == Constants.PanelTypes.DarkHole
                or obj.type == Constants.PanelTypes.DarkHoleBuffedVirus
                or obj.type == Constants.PanelTypes.IndestructiblePanel

            if is_boss_association_object then
                for _, property_name in ipairs({
                    Constants.CustomProperties.BossID1,
                    Constants.CustomProperties.BossID2,
                }) do
                    local panel_boss_id = properties[property_name]
                    if panel_boss_id and panel_boss_id ~= "" then
                        panel_boss_refs[#panel_boss_refs + 1] = {
                            object_id = tostring(obj.id),
                            boss_ref = tostring(panel_boss_id),
                        }
                    end
                end
            end

            if obj.type == Constants.PanelTypes.IndestructiblePanel then
                local requirement_type = properties[Constants.CustomProperties.Type]
                if requirement_type and requirement_type ~= "" and requirement_type ~= "All"
                    and requirement_type ~= "Any" then
                    log("ERROR", "Indestructible Panel object "..tostring(obj.id)
                        .." has invalid Type '"..tostring(requirement_type).."' (expected All or Any)")
                    errors = errors + 1
                end
            end
        end

        if not validate_object(area_id, obj) then
            errors = errors + 1
        end

        ::continue::
    end

    for _, dependency in ipairs(boss_trigger_refs) do
        if dependency.trigger_ref == dependency.source_object_id then
            log("ERROR", "Boss '"..dependency.boss_id.."' cannot use itself as Trigger Boss")
            errors = errors + 1
        elseif not boss_object_ids[dependency.trigger_ref] then
            log("ERROR", "Boss '"..dependency.boss_id.."' references missing Trigger Boss object ID "..dependency.trigger_ref)
            errors = errors + 1
        end
    end

    for _, association in ipairs(panel_boss_refs) do
        if not boss_ids[association.boss_ref] and not boss_object_ids[association.boss_ref] then
            log("ERROR", "Panel object "..association.object_id
                .." references unknown Boss ID "..association.boss_ref)
            errors = errors + 1
        end
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