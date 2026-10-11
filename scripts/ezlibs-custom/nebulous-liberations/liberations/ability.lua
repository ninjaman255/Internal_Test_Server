-- ability.lua
local PanelEncounters = require("scripts/ezlibs-custom/nebulous-liberations/liberations/panel_encounters")
local helpers = require('scripts/ezlibs-scripts/helpers')
local ezmemory = require('scripts/ezlibs-scripts/ezmemory')
local Constants = require("scripts/ezlibs-custom/nebulous-liberations/liberations/constants")

local function static_shape_generator(offset_x, offset_y, shape)
    return function() return shape, offset_x, offset_y end
end

local function liberate_and_loot(instance, player_session, results, remove_traps, destroy_items)
    local panels = player_session.selection:get_panels()
    player_session:liberate_and_loot_panels(panels, results, remove_traps, destroy_items).and_then(function()
        player_session:complete_turn()
    end)
end

local function panel_search(instance, player_session, results, remove_traps, destroy_items)
    local panels = player_session.selection:get_panels()
    player_session:loot_panels(panels, remove_traps, destroy_items).and_then(function()
        player_session:complete_turn()
    end)
end

local function initiate_encounter(instance, player_session)
    local data = { terrain = PanelEncounters.resolve_terrain(instance, player_session.player) }
    local encounter_path = PanelEncounters[instance.area_name]
    return player_session:initiate_encounter(encounter_path, data)
end

local function battle_to_liberate_and_loot(instance, player_session, r, remove_traps, destroy_items)
    initiate_encounter(instance, player_session).and_then(function(results)
        if results.success then
            liberate_and_loot(instance, player_session, results, remove_traps, destroy_items)
        else
            player_session:complete_turn()
        end
    end)
end

local Ability = {
    Guard = { name = "Guard" },
    Shadowstep = { name = "Shadowstep" },
    LongSwrd = {
        name = "LongSwrd",
        question = "Use LongSwrd?",
        cost = 1,
        remove_traps = false,
        destroy_items = false,
        generate_shape = static_shape_generator(0, 0, { {1}, {1} }),
        activate = battle_to_liberate_and_loot
    },
    WideSwrd = {
        name = "WideSwrd",
        question = "Use WideSwrd?",
        cost = 1,
        remove_traps = false,
        destroy_items = false,
        generate_shape = static_shape_generator(0, 0, { {1, 1, 1} }),
        activate = battle_to_liberate_and_loot
    },
    GutsWave = {
        name = "GutsWave",
        question = "Destroy with GutsWave?",
        cost = 1,
        remove_traps = false,
        destroy_items = true,
        generate_shape = static_shape_generator(0, 0, { {1}, {1}, {1}, {1}, {1} }),
        activate = liberate_and_loot
    },
    ScrenDiv = {
        name = "ScrenDiv",
        question = "Use ScrenDiv to liberate?",
        cost = 3,
        remove_traps = false,
        destroy_items = false,
        generate_shape = static_shape_generator(0, 0, {
            {1,1,1,1,1},
            {0,1,0,0,0},
            {0,0,1,0,0},
            {0,0,0,1,0},
            {1,1,1,1,1},
        }),
        activate = battle_to_liberate_and_loot
    },
    PanelSearch = {
        name = "PanelSearch",
        question = "Search in this area?",
        cost = 1,
        remove_traps = true,
        destroy_items = false,
        generate_shape = static_shape_generator(0, 0, { {1}, {1}, {1} }),
        activate = function(instance, player_session)
            -- placeholder
        end
    },
    NumberSearch = {
        name = "NumberSearch",
        question = "Remove traps & get items?",
        cost = 1,
        remove_traps = true,
        destroy_items = false,
        generate_shape = static_shape_generator(0, 0, { {1,1,1}, {1,1,1} }),
        activate = panel_search
    },
    HexSickle = {
        name = "HexSickle",
        question = "Should I cut panels with HexSickle?",
        cost = 1,
        remove_traps = true,
        destroy_items = false,
        generate_shape = static_shape_generator(0, 1, { {1, 1, 1} }),
        activate = battle_to_liberate_and_loot
    },
}

local navi_ability_map = {
    [Constants.AbilityIDs.LongSwrd] = Ability.LongSwrd,
    [Constants.AbilityIDs.WideSwrd] = Ability.WideSwrd,
    [Constants.AbilityIDs.OldSaber] = Ability.ScrenDiv,
    [Constants.AbilityIDs.HevyShld] = Ability.Guard,
    [Constants.AbilityIDs.HexScyth] = Ability.HexSickle,
    [Constants.AbilityIDs.NumGadgt] = Ability.NumberSearch,
    [Constants.AbilityIDs.GutsHamr] = Ability.GutsWave,
    [Constants.AbilityIDs.ShdwShoe] = Ability.Shadowstep,
}

function Ability.resolve_for_player(player)
    local ability = Ability.LongSwrd
    for key,value in pairs(navi_ability_map) do
        if ezmemory.count_player_item(player.id, key) > 0 then
            ability = navi_ability_map[key]
            break
        end
    end
    return ability
end

return Ability