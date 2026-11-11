-- Tiled enemy settings resolver. Config object and category defaults are optional.
-- Precedence: local object > referenced Enemy Config > category defaults > template.
-- Empty strings and numeric zero mean "inherit" for optional numeric overrides.
local Logger = require("scripts/ezlibs-custom/nebulous-liberations/liberations/logger")
local log = Logger.config

local Config = {}

local function props(object)
    return object and (object.custom_properties or object) or {}
end

local function trim(value)
    return value ~= nil and tostring(value):match("^%s*(.-)%s*$") or ""
end

local function defined(value)
    return value ~= nil and value ~= "" and value ~= 0 and value ~= "0" and value ~= "Auto"
end

local function number(value, allow_zero)
    local n = tonumber(value)
    if n and n == n and n < math.huge and n > -math.huge
        and (n > 0 or (allow_zero and n == 0)) then
        return n
    end
    return nil
end

local function get_object(area_id, reference, expected_type)
    if not defined(reference) then return nil end
    local id = tonumber(reference)
    if not id or id <= 0 then return nil end
    local ok, object = pcall(Net.get_object_by_id, area_id, id)
    if ok and type(object) == "table" and object.type == expected_type then
        return object
    end
    log:warn_data("Invalid config object reference", {object_id = id, expected_type = expected_type, area_id = area_id})
    return nil
end

local function area_defaults(area_id, category)
    -- Scan the cloned area to keep configuration local to each mission.
    -- "All" applies to every enemy; a matching category takes precedence.
    local ok, ids = pcall(Net.list_objects, area_id)
    if not ok or type(ids) ~= "table" then return {}, {} end
    local all, specific = {}, {}
    table.sort(ids, function(a, b) return (tonumber(a) or 0) < (tonumber(b) or 0) end)
    for _, id in ipairs(ids) do
        local good, obj = pcall(Net.get_object_by_id, area_id, id)
        if good and obj and obj.type == "Liberation Enemy Defaults" then
            local values = props(obj)
            local group = trim(values["Category"])
            if group == "All" or group == "" then
                all = values
            elseif group == category then
                specific = values
            end
        end
    end
    return specific, all
end

function Config.resolve(area_id, source, legacy_health_property, category)
    local own = props(source)
    category = category or "Dark Hole"
    local config = get_object(area_id, own["Enemy Config"], "Liberation Enemy Config")
    local shared = props(config)
    local defaults, global = area_defaults(area_id, category)
    local function get(key)
        for _, layer in ipairs({own, shared, defaults, global}) do
            if defined(layer[key]) then return layer[key] end
        end
        return nil
    end
    local function positive(key) return number(get(key), false) end
    local function text(key)
        local v = trim(get(key))
        return v ~= "" and v or nil
    end
    -- Precedence within HP/scale: local modern > local legacy > inherited
    -- modern. Tiled's historical scale=1 default should not defeat a shared
    -- OW Scale; use explicit OW Scale=1 to request an intentional local 1x.
    local legacy_hp = number(own[legacy_health_property], false)
    local max_hp = number(own["Max HP"], false)
        or legacy_hp or positive("Max HP")
    local starting_hp = positive("Starting HP")
    local legacy_scale = number(own.scale, false)
    local ow_scale = number(own["OW Scale"], false)
        or (legacy_scale ~= 1 and legacy_scale or nil)
        or positive("OW Scale") or legacy_scale or number(shared.scale, false)
    -- An unset / zero Battle Scale inherits the effective overworld scale.
    -- Preserve an explicitly configured Battle Scale when it is positive.
    local explicit_battle_scale = positive("Battle Scale")
    local battle_scale = explicit_battle_scale or ow_scale
    local scope = text("Battle Scale Scope")
    if scope ~= "All" then scope = "Matching" end
    local template_name = text("Spawns") or text("Enemy Template")
    log:debug_data("Resolved enemy configuration", {
        area_id = area_id, source_object_id = source and source.id, category = category,
        template_name = template_name, max_hp = max_hp, starting_hp = starting_hp,
        ow_scale = ow_scale, battle_scale = battle_scale,
        battle_scale_scope = scope,
        battle_scale_source = explicit_battle_scale and "override" or "overworld",
        encounter_mode = text("Encounter Mode") or "Auto",
    })
    return {
        template_name = template_name,
        max_hp = max_hp, starting_hp = starting_hp,
        ow_scale = ow_scale, battle_scale = battle_scale,
        battle_scale_explicit = explicit_battle_scale ~= nil,
        battle_scale_scope = scope,
        ow_attack_damage = positive("OW Attack Damage"),
        ow_damage_multiplier = positive("OW Damage Multiplier"),
        ow_defense_multiplier = positive("OW Defense Multiplier"),
        battle_attack_multiplier = positive("Battle Attack Multiplier"),
        battle_defense_multiplier = positive("Battle Defense Multiplier"),
        ai_type = (function()
            local value = text("AI Type")
            return value ~= "Auto" and value or nil
        end)(),
        encounter_name = text("OW Bot Encounter") or text("Boss Encounter"),
        encounter_mode = text("Encounter Mode") or "Auto",
        encounter_pool = get("OW Encounter Pool"),
        encounter_category = text("Encounter Category"),
    }
end

function Config.apply(enemy, cfg)
    if not enemy or not cfg then return end
    if cfg.max_hp then
        enemy.max_health = cfg.max_hp
        enemy.health = cfg.max_hp
    end
    if cfg.starting_hp then
        enemy.health = math.min(cfg.starting_hp, enemy.max_health or cfg.starting_hp)
    end
    -- A single OW scale is enough to configure the corresponding battle scale.
    -- An explicit Battle Scale may differ. If neither is configured, defer to
    -- the enemy template's own battle scale, then its resolved OW scale.
    enemy.battle_scale = cfg.battle_scale or enemy.battle_scale or enemy.scale
    enemy.battle_scale_explicit = cfg.battle_scale_explicit == true
    enemy.battle_scale_scope = cfg.battle_scale_scope or "Matching"
    if cfg.ow_attack_damage then enemy.attack_damage = cfg.ow_attack_damage end
    if cfg.ow_damage_multiplier then enemy.ow_damage_multiplier = cfg.ow_damage_multiplier end
    if cfg.ow_defense_multiplier then enemy.ow_defense_multiplier = cfg.ow_defense_multiplier end
    if cfg.battle_attack_multiplier then enemy.battle_attack_multiplier = cfg.battle_attack_multiplier end
    if cfg.battle_defense_multiplier then enemy.battle_defense_multiplier = cfg.battle_defense_multiplier end
    if cfg.ai_type then enemy.ai_type = cfg.ai_type end
    enemy.encounter_mode = cfg.encounter_mode
    enemy.encounter_pool = cfg.encounter_pool
    enemy.encounter_category = cfg.encounter_category
    if cfg.encounter_name then enemy.ow_bot_encounter_name = cfg.encounter_name end
end

return Config
