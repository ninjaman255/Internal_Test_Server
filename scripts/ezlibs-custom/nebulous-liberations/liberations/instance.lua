-- instance.lua
local Direction = require("scripts/libs/direction")
local PlayerSession = require("scripts/ezlibs-custom/nebulous-liberations/liberations/player_session")
local Enemy = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy")
local EnemyHelpers = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers")
local PanelEncounters = require("scripts/ezlibs-custom/nebulous-liberations/liberations/panel_encounters")
local Loot = require("scripts/ezlibs-custom/nebulous-liberations/liberations/loot")
local Preloader = require("scripts/ezlibs-custom/nebulous-liberations/liberations/preloader")
local Constants = require("scripts/ezlibs-custom/nebulous-liberations/liberations/constants")
local PanelRegistry = require("scripts/ezlibs-custom/nebulous-liberations/liberations/panel_registry")
local CameraSequence = require("scripts/ezlibs-custom/nebulous-liberations/liberations/camera_sequence") -- new file
local Emotes = require("scripts/libs/emotes")
local ezmemory = require("scripts/ezlibs-scripts/ezmemory")
local helpers = require('scripts/ezlibs-scripts/helpers')
-- local compression = helpers.safe_require('scripts/ezlibs-custom/compression')

local function includes(table, value)
    for _, v in ipairs(table) do
        if value == v then
            return true
        end
    end
    return false
end

local debug = false

-- Helper: check if object is a panel
local function is_panel(self, object)
    return PanelRegistry.get_type_by_gid(object.data.gid) ~= nil
end

-- Helper: check adjacency
local function is_adjacent(position_a, position_b)
    if position_a.z ~= position_b.z then
        return false
    end
    local x_diff = math.abs(math.floor(position_a.x) - math.floor(position_b.x))
    local y_diff = math.abs(math.floor(position_a.y) - math.floor(position_b.y))
    return x_diff + y_diff == 1
end

-- Boot player out of mission
local function boot_player(player, isVictory, mapName)
    Net.set_player_emote(player.id, Emotes.BLANK)
    Net.unlock_player_input(player.id)
    -- if compression and compression.decompress then
    --     compression.decompress(player.id)
    -- end
    player:boot_to_lobby(isVictory, mapName)
end

-- Liberate the whole area
local function liberate(self)
    -- compression.colliders[self.area_id] = nil
    for _, layer in pairs(self.panels) do
        for _, row in pairs(layer) do
            for _, panel in pairs(row) do
                if panel then
                    self:remove_panel(panel)
                end
            end
        end
    end
    self.panels = {}
    for _, enemy in ipairs(self.enemies) do
        Net.remove_bot(enemy.id, false)
    end
    self.enemies = {}

    Net.set_background(
        self.area_id,
        Net.get_area_custom_properties(self.area_id)[Constants.CustomProperties.BackgroundTexture],
        Net.get_area_custom_properties(self.area_id)[Constants.CustomProperties.BackgroundAnimation],
        Net.get_area_custom_properties(self.area_id)[Constants.CustomProperties.BackgroundVelX],
        Net.get_area_custom_properties(self.area_id)[Constants.CustomProperties.BackgroundVelY]
    )
    Net.set_song(self.area_id, Net.get_area_custom_properties(self.area_id)[Constants.CustomProperties.Song])

    local victory_message = self.area_name .. " Liberated\nTarget: " .. self.target_phase .. "\nActual: " .. self.phase
    for _, player in ipairs(self.players) do
        player:message(victory_message).and_then(function()
            boot_player(player, true, self.area_name)
        end)
    end
end

-- Convert indestructible panels after all Dark Holes are gone
local function convert_indestructible_panels(self)
    local slide_time = .5
    local hold_time = 2

    -- notify players
    for _, player_session in pairs(self.player_sessions) do
        if Net.get_area_custom_properties(self.area_id)[Constants.CustomProperties.VictoryLapSong] then
            Net.set_song(self.area_id, Net.get_area_custom_properties(self.area_id)[Constants.CustomProperties.VictoryLapSong])
        end
        player_session.player:message("No more DarkHoles! Nothing will save the Darkloids now!")
        local player = player_session.player
        Net.lock_player_input(player.id)
        Net.slide_player_camera(player.id, self.boss.x, self.boss.y, self.boss.z, slide_time)
        Net.move_player_camera(player.id, self.boss.x, self.boss.y, self.boss.z, hold_time)
        Net.slide_player_camera(player.id, player.x, player.y, player.z, slide_time)
        Net.unlock_player_camera(player.id)
    end

    Async.await(Async.sleep(slide_time + hold_time / 2))

    -- convert panels
    for _, panel in ipairs(self.indestructible_panels) do
        local actual_panel = Net.get_object_by_id(self.area_id, panel.visual_object_id)
        actual_panel.data.gid = self.BASIC_PANEL_GID_LIST[#self.BASIC_PANEL_GID_LIST]
        actual_panel.type = Constants.PanelTypes.DarkPanel
        panel.type = Constants.PanelTypes.DarkPanel
        panel.visual_gid = self.BASIC_PANEL_GID_LIST[#self.BASIC_PANEL_GID_LIST]
        Net.set_object_data(self.area_id, actual_panel.id, actual_panel.data)
        Net.set_object_data(self.area_id, panel.id, panel.data)
    end
    self.indestructible_panels = nil

    Async.await(Async.sleep(hold_time / 2 + slide_time))

    -- return control
    for _, player_session in pairs(self.player_sessions) do
        if not player_session.completed_turn then
            Net.unlock_player_input(player_session.player.id)
        end
    end
end

-- Liberate a single panel (core action)
local function liberate_panel(self, player_session)
    local player = player_session.player
    local selection = player_session.selection
    local panel = selection.root_panel

    local co = coroutine.create(function()
        if panel.type == Constants.PanelTypes.BonusPanel then
            if panel.custom_properties[Constants.CustomProperties.Message] then
                Async.await(player:message_with_mug(panel.custom_properties[Constants.CustomProperties.Message]))
            else
                Async.await(player:message_with_mug("A BonusPanel! What's it hiding?"))
            end
            self:remove_panel(panel)
            selection:clear()
            Async.await(Loot.loot_bonus_panel(self, player_session, panel))
            Net.unlock_player_input(player.id)
        elseif panel.type == Constants.PanelTypes.DarkHole then
            if panel.custom_properties[Constants.CustomProperties.Message] then
                Async.await(player:message_with_mug(panel.custom_properties[Constants.CustomProperties.Message]))
            else
                Async.await(player:message_with_mug("A Dark Hole! Begin liberation!"))
            end
            local enemy = panel.enemy
            local data = {
                terrain = PanelEncounters.resolve_terrain(self, player),
                health = enemy.max_health
            }
            local results = Async.await(player_session:initiate_encounter(enemy.encounter, data))
            if not results.success then
                player_session:complete_turn()
                return
            end
            selection:set_shape(DARK_HOLE_SHAPE, 0, -1)
            local panels = selection:get_panels()
            Async.await(player_session:liberate_panels(panels, results))
            Async.await(Enemy.destroy(self, panel.enemy))
            Async.await(player_session:loot_panels(panels, false, false))
            if #self.dark_holes == 0 then
                convert_indestructible_panels(self)
            end
            player_session:complete_turn()
        else
            if panel.custom_properties[Constants.CustomProperties.Message] then
                Async.await(player:message_with_mug(panel.custom_properties[Constants.CustomProperties.Message]))
            else
                Async.await(player:message_with_mug("Let's do it! Liberate panels!"))
            end
            local enemy = self:get_enemy_at(panel.x, panel.y, panel.z)
            local data = { terrain = PanelEncounters.resolve_terrain(self, player) }
            local encounter_path = nil
            if enemy then
                encounter_path = enemy.encounter
                data.health = enemy.health
            elseif panel.custom_properties[Constants.CustomProperties.EncounterPath] then
                encounter_path = panel.custom_properties[Constants.CustomProperties.EncounterPath]
            else
                encounter_path = PanelEncounters[self.area_name]
            end
            local results = Async.await(player_session:initiate_encounter(encounter_path, data))
            if not results.success then
                if enemy then
                    EnemyHelpers.sync_health(enemy, results)
                end
                player_session:complete_turn()
                return
            end
            if results.turns >= 1 and not results.ran then
                selection:set_shape(DARK_HOLE_SHAPE, 0, -2)
            end
            if enemy then
                Async.await(Enemy.destroy(self, enemy))
            end
            local panels = player_session.selection:get_panels()
            Async.await(player_session:liberate_and_loot_panels(panels, results, false, false))
            if enemy and enemy.is_boss then
                liberate(self)
            else
                player_session:complete_turn()
            end
        end
    end)
    Async.promisify(co)
end

-- Enemy turn handling (unchanged but uses new constants for checks)
local DARK_HOLE_SHAPE = {
    {1, 1, 1},
    {1, 1, 1},
    {1, 1, 1},
}

local function take_enemy_turn(self)
    local hold_time = .15
    local slide_time = .5

    local co = coroutine.create(function()
        local down_count = 0
        for _, player_session in pairs(self.player_sessions) do
            if player_session.health == 0 then
                down_count = down_count + 1
            end
        end
        if down_count == #self.players then
            for _, player in ipairs(self.players) do
                player:message_with_mug("We're all down?\nRetreat! Retreat!").and_then(function()
                    local bossPointFound = false
                    local point = nil
                    for p = 1, #self.points_of_interest, 1 do
                        point = self.points_of_interest[p]
                        if point.custom_properties[Constants.CustomProperties.isBoss] == "true" then
                            bossPointFound = true
                            break
                        end
                    end
                    if bossPointFound then
                        Net.slide_player_camera(player.id, point.x + .5, point.y + .5, point.z, slide_time)
                        Async.sleep(slide_time).and_then(function()
                            player:message_with_mug("Is this the power of Nebula...?").and_then(function()
                                boot_player(player, false, self.area_name)
                                Net.unlock_player_camera(player.id)
                                Net.unlock_player_input(player.id)
                            end)
                        end)
                    end
                end)
            end
            self.updating = false
            if self.needs_disposal then
                self:clean_up()
            end
            return
        end

        for _, enemy in ipairs(self.enemies) do
            for _, player in ipairs(self.players) do
                Net.slide_player_camera(player.id, enemy.x + .5, enemy.y + .5, enemy.z, slide_time)
            end
            Async.await(Async.sleep(slide_time))
            if enemy.is_boss then
                Async.await(EnemyHelpers.heal(enemy, enemy.max_health / 2))
            end
            Async.await(enemy:take_turn())
            Async.await(Async.sleep(hold_time))
        end

        for _, dark_hole in ipairs(self.dark_holes) do
            if not Enemy.is_alive(dark_hole.enemy) then
                local neighbor_offsets = {
                    {1, -1}, {1, 0}, {1, 1}, {-1, -1}, {-1, 0}, {-1, 1}, {0, 1}, {0, -1}
                }
                local neighbors = {}
                for _, neighbor_offset in ipairs(neighbor_offsets) do
                    local panel = self:get_panel_at(dark_hole.x + neighbor_offset[1], dark_hole.y + neighbor_offset[2], dark_hole.z)
                    if panel and PanelRegistry.is_walkable(panel.visual_gid) then
                        table.insert(neighbors, panel)
                    end
                end
                if #neighbors > 0 then
                    local destination = neighbors[math.random(#neighbors)]
                    for _, player in ipairs(self.players) do
                        Net.slide_player_camera(player.id, dark_hole.x + .5, dark_hole.y + .5, dark_hole.z, slide_time)
                    end
                    Async.await(Async.sleep(slide_time))
                    local name = dark_hole.custom_properties[Constants.CustomProperties.Spawns]
                    local direction = dark_hole.custom_properties[Constants.CustomProperties.Direction]
                    dark_hole.enemy = Enemy.from(self, dark_hole, direction, name)
                    self.enemies[#self.enemies+1] = dark_hole.enemy
                    Async.await(Async.sleep(.5))
                    Async.await(EnemyHelpers.move(self, dark_hole.enemy, destination.x, destination.y, destination.z))
                    Async.await(Async.sleep(.5))
                end
            end
        end

        for _, player in pairs(self.players) do
            Net.slide_player_camera(player.id, player.x, player.y, player.z, slide_time)
            Net.unlock_player_camera(player.id)
        end
        Async.await(Async.sleep(slide_time))

        for _, player_session in pairs(self.player_sessions) do
            player_session:give_turn()
        end

        self.emote_timer = 0
        self.phase = self.phase + 1
        self.updating = false
        if self.needs_disposal then
            self:clean_up()
        end
    end)
    self.updating = true
    Async.promisify(co)
end

-- Public: Mission class
local Mission = {}

function Mission:new(base_area_id, new_area_id, players)
    local FIRST_PANEL_GID = Net.get_tileset(base_area_id, Net.get_area_custom_property(base_area_id, Constants.CustomProperties.LiberationTileset)).first_gid
    local TOTAL_PANEL_GIDS = 1
    local solo_target = tonumber(Net.get_area_custom_property(base_area_id, Constants.CustomProperties.TargetPhaseCount)) or 13
    local desired_players = tonumber(Net.get_area_custom_property(base_area_id, Constants.CustomProperties.TargetPlayerCount)) or 3
    local minimum_phases = tonumber(Net.get_area_custom_property(base_area_id, Constants.CustomProperties.MinimumTargetPhaseCount)) or 1
    local player_difference = #players - desired_players
    local mission = {
        area_id = new_area_id,
        area_name = Net.get_area_name(base_area_id),
        emote_timer = 0,
        target_phase = math.max(minimum_phases, math.ceil(solo_target / math.max(1, player_difference))),
        phase = 1,
        ready_count = 0,
        order_points = 3,
        MAX_ORDER_POINTS = 8,
        points_of_interest = {},
        players = players,
        player_sessions = {},
        boss = nil,
        enemies = {},
        panels = {},
        dark_holes = {},
        indestructible_panels = {},
        panel_gates = {},
        FIRST_PANEL_GID = FIRST_PANEL_GID,
        BASIC_PANEL_GID_LIST = {},
        ITEM_PANEL_GID_LIST = {},
        DARK_HOLE_GID_LIST = {},
        INDESTRUCTIBLE_PANEL_GID_LIST = {},
        BONUS_PANEL_GID_LIST = {},
        TRAP_PANEL_GID_LIST = {},
        PANEL_GATE_GID_LIST = {},
        LAST_PANEL_GID = FIRST_PANEL_GID + TOTAL_PANEL_GIDS - 1,
        updating = false,
        needs_disposal = false,
        disposal_promise = nil,
        honor_hp_mem = Net.get_area_custom_property(base_area_id, Constants.CustomProperties.HonorHPMem) == "true"
    }
    for i = 1, Net.get_layer_count(base_area_id), 1 do
        mission.panels[i] = {}
        for j = 1, Net.get_height(base_area_id), 1 do
            mission.panels[i][j] = {}
        end
    end
    setmetatable(mission, self)
    self.__index = self

    Net.clone_area(base_area_id, new_area_id)

    -- Compression colliders
    -- local area_colliders = {}
    -- compression.colliders[new_area_id] = area_colliders
    -- for _, object_id in ipairs(Net.list_objects(new_area_id)) do
    --     local object = Net.get_object_by_id(new_area_id, object_id)
    --     if object.custom_properties[Constants.CustomProperties.Compress] or object.custom_properties[Constants.CustomProperties.Decompress] then
    --         area_colliders[#area_colliders+1] = object
    --     end
    -- end

    Preloader.update(new_area_id)

    local object_ids = Net.list_objects(mission.area_id)
    for _, object_id in ipairs(object_ids) do
        local object = Net.get_object_by_id(mission.area_id, object_id)
        if object.type == "Point of Interest" then
            mission.points_of_interest[#mission.points_of_interest + 1] = object
            Net.remove_object(mission.area_id, object_id)
        elseif is_panel(mission, object) then
            local panel_type = PanelRegistry.get_type_by_gid(object.data.gid)
            local new_panel = {
                name = "", type = panel_type, visible = true,
                x = object.x, y = object.y, z = object.z, width = object.width, height = object.height,
                data = { type = "tile", gid = Net.get_tileset(base_area_id, "/server/assets/tiles/Liberation Collision.tsx").first_gid },
                custom_properties = object.custom_properties,
                visual_object_id = object.id,
                visual_gid = object.data.gid
            }

            -- Categorize based on type
            if panel_type == Constants.PanelTypes.ItemPanel then
                if not includes(mission.ITEM_PANEL_GID_LIST, object.data.gid) then
                    table.insert(mission.ITEM_PANEL_GID_LIST, object.data.gid)
                    TOTAL_PANEL_GIDS = TOTAL_PANEL_GIDS + 1
                end
                if object.custom_properties[Constants.CustomProperties.SpecificLoot] then
                    local check_loot = object.custom_properties[Constants.CustomProperties.SpecificLoot]
                    for i = 1, #Loot.FULL_POOL do
                        if Loot.FULL_POOL[i].animation == check_loot then
                            new_panel.loot = Loot.FULL_POOL[i]
                            break
                        end
                    end
                else
                    new_panel.loot = Loot.DEFAULT_POOL[math.random(#Loot.DEFAULT_POOL)]
                end
            elseif panel_type == Constants.PanelTypes.DarkHole then
                if not includes(mission.DARK_HOLE_GID_LIST, object.data.gid) then
                    table.insert(mission.DARK_HOLE_GID_LIST, object.data.gid)
                    TOTAL_PANEL_GIDS = TOTAL_PANEL_GIDS + 1
                end
                table.insert(mission.dark_holes, new_panel)
            elseif panel_type == Constants.PanelTypes.IndestructiblePanel then
                if not includes(mission.INDESTRUCTIBLE_PANEL_GID_LIST, object.data.gid) then
                    table.insert(mission.INDESTRUCTIBLE_PANEL_GID_LIST, object.data.gid)
                    TOTAL_PANEL_GIDS = TOTAL_PANEL_GIDS + 1
                end
                mission.indestructible_panels[#mission.indestructible_panels+1] = new_panel
            elseif panel_type == Constants.PanelTypes.DarkPanel then
                if not includes(mission.BASIC_PANEL_GID_LIST, object.data.gid) then
                    table.insert(mission.BASIC_PANEL_GID_LIST, object.data.gid)
                    TOTAL_PANEL_GIDS = TOTAL_PANEL_GIDS + 1
                end
            elseif panel_type == Constants.PanelTypes.BonusPanel then
                if not includes(mission.BONUS_PANEL_GID_LIST, object.data.gid) then
                    table.insert(mission.BONUS_PANEL_GID_LIST, object.data.gid)
                    TOTAL_PANEL_GIDS = TOTAL_PANEL_GIDS + 1
                end
            elseif panel_type == Constants.PanelTypes.TrapPanel then
                if not includes(mission.TRAP_PANEL_GID_LIST, object.data.gid) then
                    table.insert(mission.TRAP_PANEL_GID_LIST, object.data.gid)
                    TOTAL_PANEL_GIDS = TOTAL_PANEL_GIDS + 1
                end
            elseif panel_type == Constants.PanelTypes.PanelGate then
                if not includes(mission.PANEL_GATE_GID_LIST, object.data.gid) then
                    table.insert(mission.PANEL_GATE_GID_LIST, object.data.gid)
                    TOTAL_PANEL_GIDS = TOTAL_PANEL_GIDS + 1
                end
                mission.panel_gates[#mission.panel_gates+1] = new_panel
            end

            new_panel.id = Net.create_object(mission.area_id, new_panel)
            local x = math.floor(object.x) + 1
            local y = math.floor(object.y) + 1
            local z = math.floor(object.z) + 1
            mission.panels[z][y][x] = new_panel

            -- Spawn enemies
            if object.custom_properties[Constants.CustomProperties.Boss] then
                local name = object.custom_properties[Constants.CustomProperties.Boss]
                local direction = object.custom_properties[Constants.CustomProperties.Direction]
                local enemy = Enemy.from(mission, object, direction, name)
                enemy.is_boss = true
                mission.boss = enemy
                table.insert(mission.enemies, 1, enemy)
            end
            if object.custom_properties[Constants.CustomProperties.Spawns] then
                local name = object.custom_properties[Constants.CustomProperties.Spawns]
                local direction = object.custom_properties[Constants.CustomProperties.Direction]
                local position = { x = object.x, y = object.y, z = object.z }
                position = EnemyHelpers.offset_position_with_direction(position, direction)
                local enemy = Enemy.from(mission, position, direction, name)
                new_panel.enemy = enemy
                mission.enemies[#mission.enemies + 1] = enemy
            end
        end
    end

    return mission
end

function Mission:clean_up()
    if not self.disposal_promise then
        self.disposal_promise = Async.create_promise(function(resolve)
            self.resolve_disposal = resolve
        end)
    end
    if self.updating then
        self.needs_disposal = true
        return self.disposal_promise
    end
    for _, id in ipairs(Net.list_bots(self.area_id)) do
        Net.remove_bot(id)
    end
    Net.remove_area(self.area_id)
    self.resolve_disposal()
    return self.disposal_promise
end

function Mission:cleaning_up()
    return self.needs_disposal
end

function Mission:begin()
    local spawn = self:get_spawn_position()
    local hold_time = .7
    local slide_time = .7
    local total_camera_time = 0
    local start_health = 0
    for _, player in ipairs(self.players) do
        self.player_sessions[player.id] = PlayerSession:new(self, player)
        if self.honor_hp_mem then
            local hp = ezmemory.get_player_max_health(player.id)
            ezmemory.set_player_max_health(player.id, hp, self.honor_hp_mem)
            ezmemory.set_player_health(player.id, 99999)
            start_health = ezmemory.get_player_health(player.id)
        else
            local hp = Net.get_player_max_health(player.id)
            Net.set_player_health(player.id, hp)
            start_health = hp
        end
        self.player_sessions[player.id].max_health = start_health
        self.player_sessions[player.id].health = start_health
        if not debug then
            Net.lock_player_input(player.id)
            -- Use camera sequence if available
            if self.points_of_interest and #self.points_of_interest > 0 then
                CameraSequence.play(self, player, spawn)
            else
                -- fallback to old method
                Net.move_player_camera(player.id, spawn.x, spawn.y, spawn.z, hold_time)
                total_camera_time = total_camera_time + hold_time
                for j, point in ipairs(self.points_of_interest) do
                    Net.slide_player_camera(player.id, point.x, point.y, point.z, slide_time)
                    Net.move_player_camera(player.id, point.x, point.y, point.z, hold_time)
                    total_camera_time = total_camera_time + slide_time + hold_time
                end
                Net.slide_player_camera(player.id, spawn.x, spawn.y, spawn.z, slide_time)
                Net.unlock_player_camera(player.id)
                total_camera_time = total_camera_time + slide_time
            end
        end
    end
    if not debug then
        Async.sleep(total_camera_time).and_then(function()
            for _, player in ipairs(self.players) do
                Net.unlock_player_input(player.id)
            end
        end)
    end
end

function Mission:on_tick(elapsed)
    if self.ready_count == #self.players then
        self.ready_count = 0
        take_enemy_turn(self)
    end
    self.emote_timer = self.emote_timer - elapsed
    for _, player_session in pairs(self.player_sessions) do
        if self.emote_timer <= 0 then
            player_session:emote_state()
            self.emote_timer = 1
        end
        if player_session.ability.name == "Shadowstep" then
            if player_session.player.moved then
                for x = -1, 1 do
                    for y = -1, 1 do
                        local panel = self:get_panel_at(player_session.player.x + x, player_session.player.y + y, player_session.player.z)
                        if panel and PanelRegistry.is_shadowstep(panel.visual_gid) and not self:get_enemy_at(panel.x, panel.y, panel.z) then
                            local object_id = panel.id
                            table.insert(player_session.shadowsteps, object_id)
                            Net.exclude_object_for_player(player_session.player.id, object_id)
                        end
                    end
                end
            else
                local panel = self:get_panel_at(player_session.player.x, player_session.player.y, player_session.player.z)
                if not panel then
                    for i = 1, #player_session.shadowsteps do
                        Net.include_object_for_player(player_session.player.id, player_session.shadowsteps[i])
                    end
                    player_session.shadowsteps = {}
                end
            end
        end
    end
end

function Mission:handle_tile_interaction(player_id, x, y, z, button)
    local player_session = self.player_sessions[player_id]
    local panel = self:get_panel_at(player_session.player.x, player_session.player.y, player_session.player.z)
    if panel then return end
    if button == 1 then return end
    if player_session.completed_turn or Net.is_player_in_widget(player_id) then return end
    Net.lock_player_input(player_id)
    local quiz_promise = player_session:quiz_with_points("Pass", "Cancel")
    quiz_promise.and_then(function(response)
        if response == 0 then
            player_session:get_pass_turn_permission()
        elseif response == 1 then
            Net.unlock_player_input(player_id)
        end
    end)
end

function Mission:handle_object_interaction(player_id, object_id, button)
    local player_session = self.player_sessions[player_id]
    local panel_on_player = self:get_panel_at(player_session.player.x, player_session.player.y, player_session.player.z)
    if panel_on_player then return end
    if button == 1 then return end
    if player_session.completed_turn or Net.is_player_in_widget(player_id) then return end
    local object = Net.get_object_by_id(self.area_id, object_id)
    if not object then
        print("no tile exists for some reason")
        return
    end
    if not is_adjacent(player_session.player, object) then
        print("somehow diagonal")
        return
    end
    local panel = self:get_panel_at(object.x, object.y, object.z)
    if not panel then
        print("no panel somehow")
        return
    end
    Net.lock_player_input(player_id)
    local panel_already_selected = false
    for _, ps in pairs(self.player_sessions) do
        if ps.selection.root_panel == panel then
            panel_already_selected = true
            break
        end
    end
    local can_liberate = not panel_already_selected and PanelRegistry.is_liberatable(panel.visual_gid)
    if not can_liberate then
        local quiz_promise = player_session:quiz_with_points("Pass", "Cancel")
        quiz_promise.and_then(function(response)
            if response == 0 then
                player_session:get_pass_turn_permission()
            elseif response == 1 then
                Net.unlock_player_input(player_id)
            end
        end)
        return
    end
    local ability = player_session.ability
    local has_enemy = false
    for _, enemy in ipairs(self.enemies) do
        if math.min(panel.x) == enemy.x and math.min(panel.y) == enemy.y and enemy.z == panel.z then
            has_enemy = true
            break
        end
    end
    local can_use_ability = (ability.question and not has_enemy and self.order_points >= ability.cost and (panel.type == Constants.PanelTypes.DarkPanel or panel.type == Constants.PanelTypes.ItemPanel or panel.type == Constants.PanelTypes.TrapPanel))
    if not can_use_ability then
        player_session.selection:select_panel(panel)
        local quiz_promise = player_session:quiz_with_points("Liberation", "Pass", "Cancel")
        quiz_promise.and_then(function(response)
            if response == 0 then
                liberate_panel(self, player_session)
            elseif response == 1 then
                player_session.selection:clear()
                player_session:get_pass_turn_permission()
            elseif response == 2 then
                player_session.selection:clear()
                Net.unlock_player_input(player_id)
            end
        end)
        return
    end
    player_session.selection:select_panel(panel)
    local quiz_promise = player_session:quiz_with_points("Liberation", ability.name, "Pass")
    quiz_promise.and_then(function(response)
        if response == 0 then
            liberate_panel(self, player_session)
        elseif response == 1 then
            local selection_shape, shape_offset_x, shape_offset_y = ability.generate_shape(self, player_session)
            player_session.selection:set_shape(selection_shape, shape_offset_x, shape_offset_y)
            player_session:get_ability_permission()
        elseif response == 2 then
            player_session.selection:clear()
            player_session:get_pass_turn_permission()
        end
    end)
end

function Mission:handle_player_avatar_change(player_id)
    local player = self.player_sessions[player_id].player
    player:boot_to_lobby(false, self.area_name)
end

function Mission:handle_player_transfer(player_id) end

function Mission:handle_player_disconnect(player_id)
    for i, player in ipairs(self.players) do
        if player_id == player.id then
            table.remove(self.players, i)
            break
        end
    end
    if self and self.player_sessions then
        self.player_sessions[player_id]:handle_disconnect()
        self.player_sessions[player_id] = nil
    end
end

function Mission:get_players()
    return self.players
end

function Mission:get_spawn_position()
    return Net.get_object_by_name(self.area_id, "Spawn")
end

function Mission:get_next_spawn_from_object(object_id)
    local object = Net.get_object_by_id(self.area_id, object_id)
    if object.custom_properties[Constants.CustomProperties.NextSpawn] then
        local next_id = tonumber(object.custom_properties[Constants.CustomProperties.NextSpawn])
        local next_obj = Net.get_object_by_id(self.area_id, next_id)
        if next_obj and next_obj.type == "Spawn Point" then
            return next_obj
        end
    end
    return self:get_spawn_position()
end

function Mission:get_panel_at(x, y, z)
    if not self.panels or #self.panels == 0 then return nil end
    y = math.floor(y) + 1
    z = math.floor(z) + 1
    local row = self.panels[z][y]
    if row == nil then return nil end
    x = math.floor(x) + 1
    return row[x]
end

function Mission:remove_panel(panel)
    local y = math.floor(panel.y) + 1
    local z = math.floor(panel.z) + 1
    local row = self.panels[z][y]
    if row == nil then return end
    local x = math.floor(panel.x) + 1
    if row[x] == nil then return end
    Net.remove_object(self.area_id, panel.visual_object_id)
    Net.remove_object(self.area_id, panel.id)
    row[x] = nil
    if panel.type == Constants.PanelTypes.DarkHole then
        for i, dark_hole in ipairs(self.dark_holes) do
            if panel == dark_hole then
                table.remove(self.dark_holes, i)
                break
            end
        end
    end
end

function Mission:get_enemy_at(x, y, z)
    x = math.floor(x)
    y = math.floor(y)
    for _, enemy in ipairs(self.enemies) do
        if enemy.x == x and enemy.y == y and enemy.z == z then
            return enemy
        end
    end
    return nil
end

return Mission