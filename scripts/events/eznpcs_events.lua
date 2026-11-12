-- Golden Prog Liberation events extracted from cyan_server.zip.
-- Minimal loader for scripts/ezlibs-scripts/eznpcs/eznpcs.lua.
-- Keeps event names, Lua APIs, return behavior and original ability semantics.
-- Do NOT overwrite an existing customized eznpcs_events.lua without merging.
local eznpcs = require("scripts/ezlibs-scripts/eznpcs/eznpcs")
local ezmemory = require("scripts/ezlibs-scripts/ezmemory")
local helpers = require("scripts/ezlibs-scripts/helpers")
local LibPlugin = require("scripts/ezlibs-custom/nebulous-liberations/main")

local liberation_item_list = {
    {n="HeroSwrd", d="A Hero Sword Chip. Use it in Liberations!"},
    {n="WideSwrd", d="A Wide Sword Chip. Use it in Liberations!"},
    {n="OldSaber", d="A Saber projection hilt, scarred with age. Use it in Liberations!"},
    {n="Guard", d="A  Guards you and your teammates!"},
    {n="HexSickle", d="A wicked scythe which cleaves most anything. Use it in Liberations!"},
    {n="NumGadgt", d="A gadget that's constantly calculating outcomes. Use it in Liberations!"},
    {n="GutsHamr", d="A hammer that takes guts to wield. Use it in Liberations!"},
    {n="ShdwShoe", d="Delicate shoes that let you walk on air. Wear them in Liberations!"},
    {n="CrosBmb", d="A hefty bomb to blow up panels in a plus shape. use it in Liberations!"},
    {n="Burner", d="A powerful fire blast to burn up what stands in your way. use it in Liberations!"},
    {n="Blaster", d="A well rounded buster that fires in a T shape. use it in Liberations!"},
    {n="Bazooka", d="A  destructive and powerful weapon. use it in Liberations!"},
}

local RematchProgEvent = {
    name = "Refight Liberation",
    action = function(npc, player_id, dialogue, relay_object)
        return async(function()
            return LibPlugin.start_game_for_player(player_id, dialogue.custom_properties["Liberation Map"])
        end)
    end,
}

local GrantLiberationAbility = {
    name = "Grant Liberation Mission Ability",
    action = function(npc, player_id, dialogue, relay_object)
        return async(function()
            for i = 1, #liberation_item_list do
                local entry = liberation_item_list[i]
                ezmemory.create_or_update_item(entry.n, entry.d, true)
                local item_count = ezmemory.count_player_item(player_id, entry.n)
                if item_count > 0 then
                    ezmemory.remove_player_item(player_id, entry.n, item_count)
                end
            end
            if dialogue.custom_properties["Ability Item"] ~= nil then
                ezmemory.give_player_item(player_id, dialogue.custom_properties["Ability Item"], 1)
            end
        end)
    end,
}

eznpcs.add_event(RematchProgEvent)
eznpcs.add_event(GrantLiberationAbility)

-- The source server also has scripts/events/eznpcs_onceitem.lua. Loading it
-- from this hook preserves that extension when it is installed.
helpers.safe_require("scripts/events/eznpcs_onceitem")

return { RematchProgEvent = RematchProgEvent, GrantLiberationAbility = GrantLiberationAbility }
