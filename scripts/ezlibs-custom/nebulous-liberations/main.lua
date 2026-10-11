-- main.lua
-- Nebulous Liberations ezlibs custom plugin entry point.
--
-- This module follows scripts/ezlibs-scripts/main.lua's plugin contract:
-- it returns a table of handle_* functions and does not register its own Net
-- event listeners. The ezlibs dispatcher passes event fields to these methods.

math.randomseed(os.time())

local LibPlugin = {}

local Player = require("scripts/ezlibs-custom/nebulous-liberations/player")
local Instance = require("scripts/ezlibs-custom/nebulous-liberations/liberations/instance")
local Parties = require("scripts/ezlibs-custom/nebulous-liberations/utils/parties")
local Constants = require("scripts/ezlibs-custom/nebulous-liberations/liberations/constants")
local Validation = require("scripts/ezlibs-custom/nebulous-liberations/liberations/validation")
local PanelRegistry = require("scripts/ezlibs-custom/nebulous-liberations/liberations/panel_registry")

local waiting_area_map = {}
local respawn_table = {}
local gate_to_area_map = {}
local instances = {}
local players = {}

local function find_available_instance_id(start_id)
    local number = 1
    local instance_id = start_id
    while instances[instance_id] do
        number = number + 1
        instance_id = start_id .. tostring(number)
    end
    return instance_id
end

local function transfer_players_to_new_instance(base_area, player_ids)
    if type(base_area) ~= "string" or base_area == "" then
        print("[nebulous-liberations] Cannot start mission: missing liberation area name.")
        return
    end
    if type(player_ids) ~= "table" or #player_ids == 0 then
        return
    end

    local instance_id = find_available_instance_id(tostring(player_ids[1]))
    local instance_players = {}
    for _, player_id in ipairs(player_ids) do
        local player = players[player_id]
        if player and not player.disconnected then
            instance_players[#instance_players + 1] = player
        end
    end
    if #instance_players == 0 then
        return
    end

    local instance = Instance:new(base_area, instance_id, instance_players)
    local spawn = instance:get_spawn_position()
    if not spawn then
        print("[nebulous-liberations] Cannot start mission in " .. tostring(base_area) .. ": no spawn position was found.")
        instance:clean_up()
        return
    end

    instances[instance_id] = instance
    for _, player in ipairs(instance_players) do
        Net.transfer_player(player.id, instance_id, true, spawn.x, spawn.y, spawn.z)
        local next_spawn = instance:get_next_spawn_from_object(spawn.id)
        if next_spawn then
            spawn = next_spawn
        end
        player.activity = instance
    end
    instance:begin()
end

function LibPlugin.start_game_for_player(player_id, liberation_id)
    local player = players[player_id]
    if not player then
        print("[nebulous-liberations] Cannot start mission: player is not initialized.")
        return
    end

    local party = Parties.find(player_id)
    if party == nil then
        transfer_players_to_new_instance(liberation_id, { player_id })
    else
        transfer_players_to_new_instance(liberation_id, party.members)
    end
end

local function detect_door_interaction(player_id, object_id, button)
    if button ~= 0 then return end
    local mission_area = gate_to_area_map[object_id]
    local player = players[player_id]
    if mission_area ~= nil and player then
        player:question_with_mug("Start mission?").and_then(function(response)
            if response == 1 and players[player_id] == player and not player.disconnected then
                LibPlugin.start_game_for_player(player_id, mission_area)
            end
        end)
    end
end

local function leave_party(player)
    if not player then return end
    local party = Parties.find(player.id)
    if not party then return end

    Parties.leave(player.id)
    local name = Net.get_player_name(player.id) or "A player"
    for _, member_id in ipairs(party.members) do
        local member = players[member_id]
        if member then
            member:message(name .. " has left your party.")
        end
    end
    if #party.members == 1 then
        local last_member = players[party.members[1]]
        if last_member then
            last_member:message("Party disbanded!")
        end
    end
end

local function remove_instance(area_id)
    local instance = instances[area_id]
    if not instance then return end

    local area_name = Net.get_area_name(area_id)
    local respawn_area = respawn_table[area_name]
    local spawn
    if respawn_area ~= nil then
        spawn = Net.get_object_by_name(respawn_area, "Liberation Respawn")
    else
        respawn_area = "default"
        spawn = Net.get_spawn_position("default")
    end

    if not spawn then
        print("[nebulous-liberations] No respawn point found for instance " .. tostring(area_id) .. ".")
        for _, player in ipairs(instance:get_players()) do
            if player then player.activity = nil end
        end
    else
        for _, player in ipairs(instance:get_players()) do
            if player then
                Net.transfer_player(player.id, respawn_area, true, spawn.x, spawn.y, spawn.z)
                player.activity = nil
            end
        end
    end

    instance:clean_up().and_then(function()
        instances[area_id] = nil
    end)
end

-- ezlibs plugin hooks. The root ezlibs main.lua owns Net:on subscriptions and
-- invokes these functions through its plugin fan-out.

function LibPlugin.on_tick(delta_time)
    local elapsed = tonumber(delta_time) or 0
    Parties.on_tick(elapsed)

    local dead_instances = {}
    for area_id, instance in pairs(instances) do
        instance:on_tick(elapsed)
        if #instance:get_players() == 0 and not instance:cleaning_up() then
            dead_instances[#dead_instances + 1] = area_id
        end
    end
    for _, area_id in ipairs(dead_instances) do
        remove_instance(area_id)
    end
    for _, player in pairs(players) do
        player.moved = false
    end
end

function LibPlugin.handle_tile_interaction(player_id, x, y, z, button)
    local area_id = Net.get_player_area(player_id)
    if waiting_area_map[area_id] ~= nil and button == 0 then
        local player = players[player_id]
        if player then
            player:quiz("Leave party", "Close").and_then(function(response)
                if response == 0 and players[player_id] == player then
                    leave_party(player)
                end
            end)
        end
    elseif instances[area_id] ~= nil then
        instances[area_id]:handle_tile_interaction(player_id, x, y, z, button)
    end
end

function LibPlugin.handle_object_interaction(player_id, object_id, button)
    local area_id = Net.get_player_area(player_id)
    if waiting_area_map[area_id] ~= nil then
        detect_door_interaction(player_id, object_id, button)
    elseif instances[area_id] ~= nil then
        instances[area_id]:handle_object_interaction(player_id, object_id, button)
    end
end

function LibPlugin.handle_actor_interaction(player_id, actor_id, button)
    local area_id = Net.get_player_area(player_id)
    if waiting_area_map[area_id] == nil or button ~= 0 then return end
    if Net.is_bot(actor_id) then return end

    local player = players[player_id]
    if not player then return end
    local name = Net.get_player_name(actor_id) or "that player"

    if Parties.is_in_same_party(player_id, actor_id) then
        player:message_with_mug(name .. " is already in our party.")
        return
    end
    if Parties.has_request(player_id, actor_id) then
        player:question_with_mug("Join " .. name .. "'s party?").and_then(function(response)
            if response == 1 and players[player_id] == player and players[actor_id] then
                Parties.accept(player_id, actor_id)
            end
        end)
        return
    end
    if Parties.has_request(actor_id, player_id) then
        player:message_with_mug("We already asked " .. name .. " to join our party.")
        return
    end
    player:question_with_mug("Recruit " .. name .. "?").and_then(function(response)
        if response == 1 and players[player_id] == player and players[actor_id] then
            Parties.request(player_id, actor_id)
        end
    end)
end

function LibPlugin.handle_textbox_response(player_id, response)
    local player = players[player_id]
    if player then
        player:handle_textbox_response(response)
    end
end

function LibPlugin.handle_battle_results(player_id, stats)
    local player = players[player_id]
    if player then
        player:handle_battle_results(stats)
    end
end

function LibPlugin.handle_player_avatar_change(player_id, details)
    local player = players[player_id]
    if not player then return end
    player.avatar_details = details
    if player.activity then
        player.activity:handle_player_avatar_change(player_id)
    end
end

function LibPlugin.handle_player_transfer(player_id)
    local player = players[player_id]
    if not player then return end

    local player_pos = Net.get_player_position(player_id)
    if player_pos then
        player.x = player_pos.x
        player.y = player_pos.y
        player.z = player_pos.z
    end
    if player.activity then
        player.activity:handle_player_transfer(player_id)
    end
end

function LibPlugin.handle_player_request(player_id, data)
    if not players[player_id] then
        players[player_id] = Player:new(player_id)
    end
end

function LibPlugin.handle_player_disconnect(player_id)
    local player = players[player_id]
    if not player then return end

    player:handle_disconnect()
    leave_party(player)
    players[player_id] = nil
end

function LibPlugin.handle_player_move(player_id, x, y, z)
    local player = players[player_id]
    if not player then return end
    player.moved = true
    player.x = x
    player.y = y
    player.z = z
end

-- Initialize panel registry and map metadata on module load.
local areas = Net.list_areas()
for _, area_id in ipairs(areas) do
    local custom_parameters = Net.get_area_custom_properties(area_id) or {}
    if custom_parameters[Constants.CustomProperties.RespawnArea] then
        respawn_table[Net.get_area_name(area_id)] = custom_parameters[Constants.CustomProperties.RespawnArea]
        local waiting_area = custom_parameters[Constants.CustomProperties.WaitingArea]
            or custom_parameters[Constants.CustomProperties.RespawnArea]
        waiting_area_map[waiting_area] = custom_parameters[Constants.CustomProperties.RespawnArea]
    end

    -- Register panel object GIDs first so specific panel types take precedence.
    local objects = Net.list_objects(area_id) or {}
    for _, obj_id in ipairs(objects) do
        local obj = Net.get_object_by_id(area_id, obj_id)
        if obj and obj.data and obj.data.gid and obj.type then
            local panel_type = obj.type
            if panel_type == Constants.PanelTypes.ItemPanel or
               panel_type == Constants.PanelTypes.DarkHole or
               panel_type == Constants.PanelTypes.IndestructiblePanel or
               panel_type == Constants.PanelTypes.BonusPanel or
               panel_type == Constants.PanelTypes.TrapPanel or
               panel_type == Constants.PanelTypes.PanelGate or
               panel_type == Constants.PanelTypes.DarkPanel then
                PanelRegistry.register(panel_type, { gids = { obj.data.gid } })
            end
        end
    end

    -- Unclassified GIDs in the configured liberation tileset default to Dark Panel.
    local tileset_path = custom_parameters[Constants.CustomProperties.LiberationTileset]
    if tileset_path then
        local tileset = Net.get_tileset(area_id, tileset_path)
        if tileset and tileset.first_gid and tileset.tilecount then
            for gid = tileset.first_gid, tileset.first_gid + tileset.tilecount - 1 do
                if PanelRegistry.get_type_by_gid(gid) == nil then
                    PanelRegistry.register(Constants.PanelTypes.DarkPanel, { gids = { gid } })
                end
            end
        end
        Validation.report(area_id)
    end

    -- The object ID identifies a mission gate and its destination map/area name.
    for _, obj_id in ipairs(objects) do
        local obj = Net.get_object_by_id(area_id, obj_id)
        if obj and obj.custom_properties and obj.custom_properties[Constants.CustomProperties.LiberationMapFileName] then
            gate_to_area_map[obj_id] = obj.custom_properties[Constants.CustomProperties.LiberationMapFileName]
        end
    end
end

return LibPlugin
