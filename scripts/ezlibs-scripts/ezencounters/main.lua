local logger = require('scripts/logger/logger').register('ezencounters'):register_subsystem("main")
local ezwarps = require('scripts/ezlibs-scripts/ezwarps/main')
local ezmemory = require('scripts/ezlibs-scripts/ezmemory')
local helpers = require('scripts/ezlibs-scripts/helpers')
local eztriggers = require('scripts/ezlibs-scripts/eztriggers/eztriggers')
local object_registry = require('scripts/ezlibs-scripts/object_registry')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local ezconfig = require('scripts/ezlibs-scripts/ezconfig')
local RewardProcessor = require('scripts/ezlibs-scripts/ezencounters/rewards')

local ezencounters = {}
local players_in_encounters = {}
local player_last_position = {}
local player_steps_since_encounter = {}
-- Keep names isolated per area. Names like Encounter1 occur in many area
-- tables; the legacy global lookup is allowed only for unique names.
local named_encounters = {}
local named_encounters_by_area = {}
local ambiguous_named_encounters = {}
local provided_encounter_assets = {}
local encounter_finished_callbacks = {}
local external_battles = {}
local encounter_areas = setmetatable({}, { __mode = "k" })

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
            local area_named = {}
            local area_ambiguous = {}
            named_encounters_by_area[tostring(area_id)] = area_named
            for _, section_name in ipairs(encounter_sections) do
                local section = area_encounter_tables[area_id][section_name]
                if type(section) == "table" then
                    for index, encounter_info in ipairs(section) do
                        encounter_areas[encounter_info] = area_id
                        if encounter_info.path and not provided_encounter_assets[area_id][encounter_info.path] then
                            logger:info('[ezencounters] providing mob package '..encounter_info.path..' to '..tostring(area_id))
                            Net.provide_asset(area_id, encounter_info.path)
                            provided_encounter_assets[area_id][encounter_info.path] = true
                        end
                        if encounter_info.name then
                            logger:info('[ezencounters] loaded named encounter '..encounter_info.name..' ('..section_name..')')
                            if area_named[encounter_info.name] or area_ambiguous[encounter_info.name] then
                                area_ambiguous[encounter_info.name] = true
                                area_named[encounter_info.name] = nil
                                logger:info('[ezencounters] duplicate name within area: '..tostring(area_id)..' / '..encounter_info.name)
                            else
                                area_named[encounter_info.name] = encounter_info
                            end
                            if named_encounters[encounter_info.name]
                                and named_encounters[encounter_info.name] ~= encounter_info then
                                ambiguous_named_encounters[encounter_info.name] = true
                                named_encounters[encounter_info.name] = nil
                            elseif not ambiguous_named_encounters[encounter_info.name] then
                                named_encounters[encounter_info.name] = encounter_info
                            end
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
ezencounters.get_encounter_by_name = function(encounter_name, area_id)
    if encounter_name == nil then return nil end
    local name = tostring(encounter_name)
    if area_id ~= nil then
        local area_named = named_encounters_by_area[tostring(area_id)]
        return area_named and area_named[name] or nil
    end
    if ambiguous_named_encounters[name] then
        logger:info('[ezencounters] ambiguous encounter name; provide area_id: '..name)
        return nil
    end
    return named_encounters[name]
end


-- Opt-in bridge for other external game modes that WANT battle rewards.
-- Nebulous Liberations deliberately does not register its battles here:
-- liberation victories yield panel/mission loot, never battle-result drops.
-- A token avoids clearing a newer context after an older promise completes.
local next_external_token = 0
ezencounters.register_external_battle = function(player_id, encounter_data, options)
    options = options or {}
    next_external_token = next_external_token + 1
    local token = next_external_token
    external_battles[player_id] = {
        token = token,
        encounter_info = encounter_data,
        encounter_data = encounter_data,
        area_id = options.area_id,
        options = options,
        external = true,
    }
    return token
end

ezencounters.clear_external_battle = function(player_id, token)
    local context = external_battles[player_id]
    if context and (token == nil or context.token == token) then
        external_battles[player_id] = nil
        return true
    end
    return false
end

-- Named definitions resolve within their explicit area. Direct package paths
-- remain valid overrides; an unknown name must not resolve into another area.
ezencounters.resolve_encounter = function(encounter_reference, area_id)
    if encounter_reference == nil then return nil end
    local reference = tostring(encounter_reference):match('^%s*(.-)%s*$')
    if reference == '' then return nil end
    local definition = ezencounters.get_encounter_by_name(reference, area_id)
    if definition then return definition end
    -- Only actual package paths fall back to a direct path definition.
    if reference:find('/') or reference:find('\\') or reference:match('%.zip$') then
        return { path = reference }
    end
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
        local minimum_steps = tonumber(encounter_table.minimum_steps_before_encounter) or 0
        if player_steps_since_encounter[player_id] >= minimum_steps then
            ezencounters.try_random_encounter(player_id, encounter_table)
        end
    end
end

ezencounters.handle_player_move = function(player_id, x, y, z)
    local floor = math.floor
    local rounded_pos_x = floor(x)
    local rounded_pos_y = floor(y)
    local rounded_pos_z = floor(z)
    local last_tile = player_last_position[player_id]
    if not last_tile then
        -- Initial position is an anchor, not a walked step.
        player_last_position[player_id] = {x=rounded_pos_x,y=rounded_pos_y,z=rounded_pos_z}
        return
    end
    if last_tile.x == rounded_pos_x and last_tile.y == rounded_pos_y
        and last_tile.z == rounded_pos_z then
        return
    end
    -- Check the tile being LEFT (not the destination) for conveyors before
    -- updating the stored position. A movement packet within one tile should
    -- never increase the encounter counter.
    ezencounters.increment_steps_since_encounter(player_id)
    player_last_position[player_id] = {x=rounded_pos_x,y=rounded_pos_y,z=rounded_pos_z}
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
ezencounters.begin_encounter_by_name = function(player_id,encounter_name,trigger_object,runtime_data)
    return async(function ()
        local area_id = Net.get_player_area(player_id)
        local encounter_info = ezencounters.get_encounter_by_name(encounter_name, area_id)
        -- Cloned areas may not have their own encounter table. A globally
        -- unique name is safe there; an ambiguous name is not.
        if not encounter_info and not named_encounters_by_area[tostring(area_id)] then
            encounter_info = ezencounters.get_encounter_by_name(encounter_name)
        end
        if encounter_info then
            local stats = await(ezencounters.begin_encounter(player_id,encounter_info,trigger_object,runtime_data))
            return stats
        else
            logger:info('[ezencounters] no encounter with name ',encounter_name,' has been added to any encounter tables!')
            return nil
        end
    end)
end

ezencounters.begin_encounter = function (player_id,encounter_info,trigger_object,runtime_data)
    return async(function ()
        --print('[ezencounters] beginning encounter for',player_id)
        players_in_encounters[player_id] = {
            encounter_info = encounter_info,
            area_id = (runtime_data and runtime_data._base_area_id)
                or encounter_areas[encounter_info] or Net.get_player_area(player_id),
        }
        ezencounters.clear_tiles_since_encounter(player_id)

        -- Runtime-only encounter context (such as terrain) is merged into a
        -- fresh payload. It is not written back to the cached area definition.
        local encounter_data = {}
        for key, value in pairs(encounter_info or {}) do
            encounter_data[key] = value
        end
        for key, value in pairs(runtime_data or {}) do
            encounter_data[key] = value
        end

        players_in_encounters[player_id].encounter_data = encounter_data

        -- Preserve the full server-side encounter context above for events,
        -- callbacks, results, and reward processing. Only the network-bound
        -- battle payload is filtered here. Liberation missions initiate their
        -- own battles directly and never pass through this filter.
        -- Functions and bookkeeping fields are not client battle settings.
        local battle_data = {}
        for key, value in pairs(encounter_data) do
            if key ~= "results_callback" and key ~= "_base_area_id"
                and type(value) ~= "function" then
                battle_data[key] = value
            end
        end

        ezbus:emit("encounter_started", {
            player_id = player_id,
            encounter_info = encounter_info,
            encounter_data = encounter_data,
            trigger_object = trigger_object
        })
        local stats = await(Async.initiate_encounter(player_id,encounter_info.path,battle_data))
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
    local context = players_in_encounters[player_id] or external_battles[player_id]
    local packets, totals, reward_source = nil, nil, nil
    if context then
        -- Remove context first: even an unexpected duplicate event/callback
        -- cannot grant these rewards twice.
        players_in_encounters[player_id] = nil
        external_battles[player_id] = nil

        if encounter_finished_callbacks[player_id] then
            local handler = encounter_finished_callbacks[player_id]
            encounter_finished_callbacks[player_id] = nil
            local ok, err = pcall(handler, event)
            if not ok then
                print('[ezencounters] encounter_finished callback error: '..tostring(err))
            end
        end

        local encounter_info = context.encounter_info or {}
        local encounter_data = context.encounter_data or encounter_info
        local area_id = context.area_id or encounter_areas[encounter_info]
        local area_table = area_id and area_encounter_tables[tostring(area_id)] or nil
        local options = context.options or {}
        local no_results = encounter_data.no_results == true
            or encounter_info.no_results == true

        -- External battle health remains owned by its calling game mode.
        -- Regular encounters only allow persistent HP rewards when explicitly
        -- opted in via persistent_health=true.
        local persistent_health = not context.external
            and (encounter_data.persistent_health == true
                or encounter_info.persistent_health == true
                or (area_table and area_table.persistent_health == true))
        local reward_options = {
            disable_rewards = no_results or options.disable_rewards == true,
            disable_health_rewards = options.disable_health_rewards == true
                or not persistent_health,
            persistent_health = persistent_health,
        }
        local callbacks, seen = {}, {}
        local function append_callback(callback, info)
            if type(callback) == 'function' and not seen[callback] then
                seen[callback] = true
                callbacks[#callbacks + 1] = {fn = callback, info = info}
            end
        end
        append_callback(encounter_info.results_callback, encounter_info)
        append_callback(encounter_data.results_callback, encounter_data)
        if area_table then append_callback(area_table.results_callback, encounter_info) end

        local ok, result1, result2, result3 = pcall(
            RewardProcessor.finish, player_id, area_table, encounter_info,
            encounter_data, event, reward_options, callbacks)
        if ok then
            packets, totals, reward_source = result1, result2, result3
        else
            print('[ezencounters] WARNING: battle reward processing failed: '
                .. tostring(result1))
        end
    end

    -- Keep the existing event fields; additional metadata is optional and
    -- only populated for battles registered with ezencounters.
    ezbus:emit("encounter_finished", {
        player_id = player_id,
        managed = context ~= nil,
        area_id = context and context.area_id,
        encounter_info = context and context.encounter_info,
        rewards = packets,
        reward_totals = totals,
        reward_source = reward_source,
        stats = {
            health = event.health,
            reason = event.reason,
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
    external_battles[player_id] = nil
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