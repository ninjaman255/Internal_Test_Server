local logger = require('scripts/ezlibs-scripts/ezlogger').get('ezencounters')
local ezwarps = require('scripts/ezlibs-scripts/ezwarps/main')
local ezmemory = require('scripts/ezlibs-scripts/ezmemory')
local helpers = require('scripts/ezlibs-scripts/helpers')
local eztriggers = require('scripts/ezlibs-scripts/eztriggers/eztriggers')
local object_registry = require('scripts/ezlibs-scripts/object_registry')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local ezconfig = require('scripts/ezlibs-scripts/ezconfig')

local ezencounters = {}
local players_in_encounters = {}
local player_last_position = {}
local player_steps_since_encounter = {}
local named_encounters = {}
local provided_encounter_assets = {}
local encounter_finished_callbacks = {}

-- Ensure encounters directory exists
helpers.ensure_directory(ezconfig.ENCOUNTERS_PATH)

local load_encounters_for_areas = function ()
    local areas = Net.list_areas()
    local area_encounter_tables = {}
    for i, area_id in ipairs(areas) do
        local encounter_table_path = ezconfig.ENCOUNTERS_PATH .. area_id
        local status, err = pcall(function () require(encounter_table_path) end)
        if status == true then
            area_encounter_tables[area_id] = require(encounter_table_path)
            -- Only .encounters participates in random selection. Optional
            -- .bosses and .special_encounters are registered for explicit
            -- named starts, but must never enter the random encounter pool.
            local encounter_sections = {
                "encounters",
                "bosses",
                "special_encounters",
            }
            provided_encounter_assets[area_id] = provided_encounter_assets[area_id] or {}
            for _, section_name in ipairs(encounter_sections) do
                local section = area_encounter_tables[area_id][section_name]
                if type(section) == "table" then
                    for index, encounter_info in ipairs(section) do
                        if encounter_info.path and not provided_encounter_assets[area_id][encounter_info.path] then
                            logger:info('[ezencounters] providing mob package '..encounter_info.path..' to '..tostring(area_id))
                            Net.provide_asset(area_id, encounter_info.path)
                            provided_encounter_assets[area_id][encounter_info.path] = true
                        end
                        if encounter_info.name then
                            logger:info('[ezencounters] loaded named encounter '..encounter_info.name..' ('..section_name..')')
                            named_encounters[encounter_info.name] = encounter_info
                        end
                    end
                end
            end
            logger:info('[ezencounters] loaded encounter table for '..area_id)
        end
    end
    return area_encounter_tables
end

local area_encounter_tables = load_encounters_for_areas()

-- Public lookup for systems that need the canonical encounter definition but
-- must retain their own battle/session wrapper (for example, NebuLibs terrain
-- and health handling). The returned table is the registered definition itself.
ezencounters.get_encounter_by_name = function(encounter_name)
    if encounter_name == nil then return nil end
    return named_encounters[tostring(encounter_name)]
end

-- Resolve a name or a direct encounter package path into the shape used by
-- Net.initiate_encounter. Named definitions always win over treating a string
-- as a raw path; callers may pass additional battle data to merge separately.
ezencounters.resolve_encounter = function(encounter_reference)
    if encounter_reference == nil then return nil end
    local reference = tostring(encounter_reference)
    local definition = named_encounters[reference]
    if definition then return definition end
    if reference ~= "" then return { path = reference } end
    return nil
end

local function should_record_step(player_id)
    local player_area = Net.get_player_area(player_id)
    if not player_last_position[player_id] then
        return false
    end
    if Net.is_player_battling(player_id) then
        return false
    end
    if ezwarps.player_is_in_animation(player_id) then
        return false
    end
    local last_pos = player_last_position[player_id]
    local last_tile = Net.get_tile(player_area, last_pos.x, last_pos.y, last_pos.z) -- { gid, flipped_horizontally, flipped_vertically, rotated }
    local tile_tileset_info =  Net.get_tileset_for_tile(player_area, last_tile.gid) -- { path, first_gid }?
    if not tile_tileset_info then
        return false
    end
    if string.find(tile_tileset_info.path,'conveyer') then
        return false
    end
    return true
end

ezencounters.increment_steps_since_encounter = function (player_id)
    if not should_record_step(player_id) then
        return
    end
    local player_area = Net.get_player_area(player_id)
    local encounter_table = area_encounter_tables[player_area]
    if not player_steps_since_encounter[player_id] then
        player_steps_since_encounter[player_id] = 1
    else
        player_steps_since_encounter[player_id] = player_steps_since_encounter[player_id] + 1
    end
    if encounter_table then
        if player_steps_since_encounter[player_id] >= encounter_table.minimum_steps_before_encounter then
            ezencounters.try_random_encounter(player_id,encounter_table)
        end
    end
end

ezencounters.handle_player_move = function(player_id, x, y, z)
    local floor = math.floor
    local rounded_pos_x = floor(x)
    local rounded_pos_y = floor(y)
    local rounded_pos_z = floor(z)
    local last_tile = player_last_position[player_id]
    if last_tile then
        if last_tile.x ~= rounded_pos_x or last_tile.y ~= rounded_pos_y or last_tile.z ~= rounded_pos_z then
            --player has moved to a different tile
            player_last_position[player_id] = {x=rounded_pos_x,y=rounded_pos_y,z=rounded_pos_z}
        end
    else
        player_last_position[player_id] = {x=rounded_pos_x,y=rounded_pos_y,z=rounded_pos_z}
    end
    ezencounters.increment_steps_since_encounter(player_id)
end

ezencounters.pick_encounter_from_table = function (encounter_table)
    local options = type(encounter_table) == "table" and encounter_table.encounters or nil
    if type(options) ~= "table" or #options == 0 then
        return nil
    end

    local total_weight = 0
    for _, option in ipairs(options) do
        total_weight = total_weight + (tonumber(option.weight) or 0)
    end
    if total_weight <= 0 then
        return options[math.random(#options)]
    end

    local crawler = math.random() * total_weight
    for i, option in ipairs(options) do
        crawler = crawler - (tonumber(option.weight) or 0)
        if crawler <= 0 then
            return options[i]
        end
    end
    return options[1]
end

ezencounters.try_random_encounter = function (player_id,encounter_table)
    -- Bosses and special_encounters are deliberately never part of random
    -- selection. An area containing only explicit encounters simply has no
    -- random encounter roll.
    if type(encounter_table.encounters) ~= "table" or #encounter_table.encounters == 0 then
        return
    end
    if math.random() <= (tonumber(encounter_table.encounter_chance_per_step) or 0) then
        local encounter_info = ezencounters.pick_encounter_from_table(encounter_table)
        if encounter_info then
            ezencounters.begin_encounter(player_id, encounter_info)
        end
    end
end

-- FIXED: Now returns the stats
ezencounters.begin_encounter_by_name = function(player_id,encounter_name,trigger_object)
    return async(function ()
        local encounter_info = named_encounters[encounter_name]
        if encounter_info then
            local stats = await(ezencounters.begin_encounter(player_id,encounter_info,trigger_object))
            return stats
        else
            logger:info('[ezencounters] no encounter with name ',encounter_name,' has been added to any encounter tables!')
            return nil
        end
    end)
end

ezencounters.begin_encounter = function (player_id,encounter_info,trigger_object)
    return async(function ()
        --print('[ezencounters] beginning encounter for',player_id)
        players_in_encounters[player_id] = {encounter_info=encounter_info}
        ezencounters.clear_tiles_since_encounter(player_id)
        ezbus:emit("encounter_started", {
            player_id = player_id,
            encounter_info = encounter_info,
            trigger_object = trigger_object
        })
        local stats = await(Async.initiate_encounter(player_id,encounter_info.path,encounter_info))
        return stats
    end)
end

ezencounters.clear_tiles_since_encounter = function (player_id)
    player_steps_since_encounter[player_id] = nil
end

ezencounters.clear_last_position = function (player_id)
    logger:info('[ezencounters] clearing last position')
    player_last_position[player_id] = nil
    ezencounters.clear_tiles_since_encounter(player_id)
    players_in_encounters[player_id] = nil
end

Net:on("battle_results", function(event)
    local player_id = event.player_id
    if players_in_encounters[player_id] then
        local player_encounter = players_in_encounters[player_id]
        if encounter_finished_callbacks[player_id] then
            encounter_finished_callbacks[player_id](event)
            encounter_finished_callbacks[player_id] = nil
        end
        if player_encounter.encounter_info.results_callback then
            player_encounter.encounter_info.results_callback(player_id,player_encounter.encounter_info,event)
        end
        players_in_encounters[player_id] = nil
    end
    -- stats = { health: number, score: number, time: number, ran: bool, emotion: number, turns: number, npcs: { id: String, health: number }[] }
    ezbus:emit("encounter_finished", {
        player_id = player_id,
        stats = {
            health = event.health,
            time = event.time,
            ran = event.ran,
            emotion = event.emotion,
            turns = event.turns,
            enemies = event.enemies,
            score = event.score
        }
    })
end)

ezencounters.handle_player_transfer = ezencounters.clear_last_position

ezencounters.handle_player_disconnect = function (player_id)
    encounter_finished_callbacks[player_id] = nil
    ezencounters.clear_last_position(player_id)
end

local function on_radius_encounter_triggered(event)
    return async(function ()
        logger:info('[ezencounters] radius encounter triggered ',event.object.custom_properties)
        local player_area = Net.get_player_area(event.player_id)
        local is_hidden_already = ezmemory.object_is_hidden_from_player(event.player_id,player_area,event.object.id)
        if is_hidden_already then
            return
        end
        local encounter_name = event.object.custom_properties["Name"]
        local stats = false
        if encounter_name then
            stats = await(ezencounters.begin_encounter_by_name(event.player_id,encounter_name,event.object))
        else
            local encounter_info = {path=event.object.custom_properties["Path"]}
            stats = await(ezencounters.begin_encounter(event.player_id,encounter_info,event.object))
        end
        if stats then
            if stats.ran or stats.health == 0 then
                return stats -- dont hide the encounter if the player ran or lost
            end
            local player_area = Net.get_player_area(event.player_id)
            if event.object.custom_properties["Once"] == "true" then
                ezmemory.hide_object_from_player(event.player_id,player_area,event.object.id)
            end
        end
        ezmemory.hide_object_from_player_till_disconnect(event.player_id,player_area,event.object.id)
    end)
end

-- Register handler for Radius Encounter objects
object_registry.register_handler("Radius Encounter", function(area_id, object)
    local radius = tonumber(object.custom_properties["Radius"] or 1)
    local emitter = eztriggers.add_radius_trigger(area_id, object, radius, radius, 0, 0)
    emitter:on('entered', function(event)
        return on_radius_encounter_triggered(event)
    end)
end)

return ezencounters