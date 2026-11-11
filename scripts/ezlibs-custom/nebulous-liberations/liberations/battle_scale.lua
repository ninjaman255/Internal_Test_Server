-- battle_scale.lua
-- Battle rendering policy is independent of persistent overworld HP.
-- Resolve one configured scale for a battle, then apply it to selected
-- encounter enemy entries WITHOUT mutating the cached encounter definition.
--
-- Target policy:
--   Matching: all entries matching the OW template/display alias; if a
--             single enemy is present, that one entry is an unambiguous fallback.
--             Multi-enemy encounters with no matching name are left untouched.
--   All:      every enemy in the encounter (explicit map-author opt-in).
--
-- Authored entry scales remain in control when the OW scale is the default 1
-- and there is no explicit Battle Scale setting. Non-default or explicitly
-- configured Battle Scale takes precedence for the selected entries.
local Logger = require('scripts/ezlibs-custom/nebulous-liberations/liberations/logger')
local log = Logger.encounters
local BattleScale = {}

local function positive(value)
    local n = tonumber(value)
    if n and n > 0 and n == n and n < math.huge then return n end
    return nil
end

local function normalized(name)
    if name == nil then return nil end
    return tostring(name):lower():gsub('%s*:%s*%-?%d+%s*$', ''):match('^%s*(.-)%s*$')
end

local function scope_for(source, options)
    local scope = options and options.scope
        or source and source.battle_scale_scope
        or 'Matching'
    if scope == 'All' then return 'All' end
    return 'Matching'
end

function BattleScale.apply(data, source, options)
    options = options or {}
    local enemies = data and data.enemies
    local result = {
        count = 0, scale = nil, target = nil, scope = scope_for(source, options),
        matched_name = nil, reason = nil,
    }
    if type(enemies) ~= 'table' or #enemies == 0 then
        result.reason = 'no_enemy_entries'
        return result
    end
    if not source then
        result.reason = 'no_scale_source'
        return result
    end

    local requested = positive(source.battle_scale)
        or positive(source.ow_scale)
        or positive(source.scale)
    if not requested then
        result.reason = 'no_configured_scale'
        return result
    end
    result.scale = requested

    local alias = normalized(source.template_name)
    local display = normalized(source.battle_name or source.name)
    local targets = {}

    if result.scope == 'All' then
        for index, entry in ipairs(enemies) do
            if type(entry) == 'table' then targets[#targets + 1] = index end
        end
        result.target = 'all'
    else
        for index, entry in ipairs(enemies) do
            if type(entry) == 'table' then
                local entry_alias = normalized(entry.name)
                if (alias and entry_alias == alias)
                    or (display and entry_alias == display) then
                    targets[#targets + 1] = index
                end
            end
        end
        if #targets > 0 then
            result.target = 'alias'
        elseif #enemies == 1 and type(enemies[1]) == 'table' then
            targets[1] = 1
            result.target = 'single_entry_fallback'
        else
            result.target = 'none'
            result.reason = 'no_matching_enemy_in_multi_enemy_encounter'
        end
    end

    -- If this was inherited from a normal-size bot, preserve an explicit
    -- encounter-editor scale, e.g. a 1.25-scale boss in a default-size area.
    local force = source.battle_scale_explicit == true or requested ~= 1
        or result.scope == 'All'
    for _, index in ipairs(targets) do
        local entry = enemies[index]
        local authored = positive(entry.scale)
        if force or not authored then
            entry.scale = requested
            result.count = result.count + 1
        end
        result.matched_name = entry.name
    end

    local summary = {}
    for index, entry in ipairs(enemies) do
        if type(entry) == 'table' then
            summary[#summary + 1] = {
                index = index, name = entry.name, scale = positive(entry.scale) or 1,
                health = entry.health, max_hp = entry.max_hp,
            }
        end
    end
    local fields = {
        base_area_id = options.base_area_id,
        source_object_id = options.source_object_id,
        encounter_name = options.encounter_name,
        encounter_source = options.encounter_source,
        source_enemy_template = source.template_name,
        requested_scale = requested,
        ow_scale = source.ow_scale or source.scale,
        battle_scale = source.battle_scale,
        explicit_battle_scale = source.battle_scale_explicit == true,
        scope = result.scope, target = result.target,
        updated_count = result.count, reason = result.reason,
        final_enemies = summary,
    }
    if result.reason and (requested ~= 1 or source.battle_scale_explicit == true) then
        log:warn_data('Battle Scale could not target enemy entries', fields)
    else
        log:info_data('Battle Scale payload finalized', fields)
    end
    return result
end

return BattleScale
