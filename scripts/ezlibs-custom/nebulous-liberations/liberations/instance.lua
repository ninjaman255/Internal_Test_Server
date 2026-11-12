local PlayerControl = require("scripts/player-control/main")
-- instance.lua
local SharedLogger = require("scripts/logger/logger")
local log = SharedLogger.register("nebulous-liberations"):register_subsystem("instance")

local Direction = require("scripts/libs/direction")
local PlayerSession = require("scripts/ezlibs-custom/nebulous-liberations/liberations/player_session")
local Enemy = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy")
local EnemyHelpers = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers")
local PanelEncounters = require("scripts/ezlibs-custom/nebulous-liberations/liberations/panel_encounters")
local Loot = require("scripts/ezlibs-custom/nebulous-liberations/liberations/loot")
local Preloader = require("scripts/ezlibs-custom/nebulous-liberations/liberations/preloader")
local Constants = require("scripts/ezlibs-custom/nebulous-liberations/liberations/constants")
local EnemyConfig = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_config")
local BattleScale = require("scripts/ezlibs-custom/nebulous-liberations/liberations/battle_scale")
local EnemyTemplates = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_templates")
local SubsystemLogger = require("scripts/ezlibs-custom/nebulous-liberations/liberations/logger")
local spawn_log = SubsystemLogger.spawning
local encounter_log = SubsystemLogger.encounters
local PanelRegistry = require("scripts/ezlibs-custom/nebulous-liberations/liberations/panel_registry")
local CameraSequence = require("scripts/ezlibs-custom/nebulous-liberations/liberations/camera_sequence")
local PointsGauge = require("scripts/ezlibs-custom/nebulous-liberations/liberations/points_gauge")
local HPIndicators = require("scripts/ezlibs-custom/nebulous-liberations/liberations/hp_indicators")
local Emotes = require("scripts/libs/emotes")
local ezmemory = require("scripts/ezlibs-scripts/ezmemory")
local helpers = require('scripts/ezlibs-scripts/helpers')

local function includes(table, value)
    for _, v in ipairs(table) do
        if value == v then
            return true
        end
    end
    return false
end

-- Build a per-battle copy of an encounter definition. Enemy entries are copied
-- individually because persistent liberation enemies may override `health`;
-- mutating the cached area encounter definition would leak that HP into later
-- encounters that use the same definition.
local function normalize_enemy_name(value)
    if value == nil then return nil end
    return string.lower(tostring(value):gsub("%s*:%s*%-?%d+%s*$", ""))
end

-- A Dark Hole's Minion Health Override controls the battle HP of the enemy
-- spawned by that Dark Hole (for example, its BigBrute). It intentionally
-- does not change the other entries in the shared encounter definition.
-- Apply a Dark Hole's Minion Health Override to its own persistent world bot.
-- EnemyHelpers.update_name also refreshes the viewer-specific HP indicators,
-- so the map bot, its displayed name, and its associated encounter stay aligned.
local function apply_panel_enemy_config(panel, enemy)
    if not panel or not enemy then return end
    local cfg = panel.enemy_config
    if cfg then
        EnemyConfig.apply(enemy, cfg)
        enemy.configured_max_hp = cfg.max_hp ~= nil
        EnemyHelpers.update_name(enemy)
    end
end

local function apply_dark_hole_minion_health_to_bot(dark_hole, enemy)
    if not dark_hole or not enemy then return 0 end

    local properties = dark_hole.custom_properties or {}
    local health_override = tonumber(
        properties[Constants.CustomProperties.MinionHealthOverride]) or 0
    if health_override <= 0 or enemy.configured_max_hp then return 0 end

    enemy.health = health_override
    enemy.max_health = health_override
    EnemyHelpers.update_name(enemy)

    log:info_data("Dark Hole Minion Health Override applied to world bot", {
        dark_hole_x = dark_hole.x,
        dark_hole_y = dark_hole.y,
        enemy_id = enemy.id,
        enemy_template = enemy.template_name,
        enemy_name = enemy.battle_name or enemy.name,
        health = enemy.health,
        max_health = enemy.max_health,
    })

    return health_override
end

-- A Dark Hole's bot has its own named encounter, independent of the set
-- offered when liberating its source panel. Keep the name attached to the
-- persistent bot so moving and respawning it do not lose that association.
local function assign_dark_hole_bot_encounter(dark_hole, enemy)
    if not dark_hole or not enemy then return end
    local cfg = dark_hole.enemy_config or {}
    local props = dark_hole.custom_properties or {}
    enemy.ow_bot_encounter_name = cfg.encounter_name
        or (props[Constants.CustomProperties.OWBotEncounter] ~= "" and props[Constants.CustomProperties.OWBotEncounter])
        or (props[Constants.CustomProperties.LegacyBossEncounter] ~= "" and props[Constants.CustomProperties.LegacyBossEncounter])
        or enemy.ow_bot_encounter_name or enemy.default_ow_bot_encounter_name
end

local function apply_dark_hole_minion_health_override(encounter_data, dark_hole, enemy)
    local properties = dark_hole and dark_hole.custom_properties or {}
    local health_override = tonumber(
        properties[Constants.CustomProperties.MinionHealthOverride]) or 0
    if health_override <= 0 or (enemy and enemy.configured_max_hp) then
        return 0, nil
    end

    -- Legacy custom encounter packages (for example, the NebuLibs BigBrute
    -- package) consume a top-level data.health value rather than
    -- data.enemies[].health. Keep both payload shapes synchronized.
    if type(encounter_data) == "table" then
        encounter_data.health = health_override
    end

    local expected_alias = enemy and normalize_enemy_name(enemy.template_name)
    local expected_display_name = enemy
        and normalize_enemy_name(enemy.battle_name or enemy.name)

    for _, enemy_info in ipairs(encounter_data and encounter_data.enemies or {}) do
        if type(enemy_info) == "table" then
            local encounter_alias = normalize_enemy_name(enemy_info.name)
            if (expected_alias and encounter_alias == expected_alias)
                or (expected_display_name and encounter_alias == expected_display_name) then
                enemy_info.health = health_override
                enemy_info.max_hp = health_override
                return 1, enemy_info.name
            end
        end
    end

    -- A one-entry encounter has only one possible enemy. This also supports
    -- encounter aliases that intentionally differ from the world-bot template.
    local entries = encounter_data and encounter_data.enemies
    if type(entries) == "table" and #entries == 1 and type(entries[1]) == "table" then
        entries[1].health = health_override
        entries[1].max_hp = health_override
        return 1, entries[1].name
    end

    return 0, nil
end


local function copy_music_definition(music)
    if type(music) ~= "table" then return nil end
    return {
        path = type(music.path) == "string" and music.path or "",
        loop_start = tonumber(music.loop_start) or 0,
        loop_end = tonumber(music.loop_end) or 0,
    }
end

local function build_encounter_data(encounter_definition, overrides, persistent_enemy)
    local data = {}

    for key, value in pairs(encounter_definition or {}) do
        if key ~= "path" and key ~= "weight" then
            if key == "enemies" and type(value) == "table" then
                data.enemies = {}
                for index, enemy_info in ipairs(value) do
                    local enemy_copy = {}
                    for enemy_key, enemy_value in pairs(enemy_info) do
                        enemy_copy[enemy_key] = enemy_value
                    end
                    data.enemies[index] = enemy_copy
                end
            elseif key == "freedom_mission" and type(value) == "table" then
                data.freedom_mission = {}
                for mission_key, mission_value in pairs(value) do
                    data.freedom_mission[mission_key] = mission_value
                end
            elseif key == "music" then
                data.music = copy_music_definition(value)
            else
                data[key] = value
            end
        end
    end

    for key, value in pairs(overrides or {}) do
        if key == "music" then
            data.music = copy_music_definition(value)
        elseif key == "freedom_mission" and type(value) == "table" then
            local mission = {}
            for mission_key, mission_value in pairs(data.freedom_mission or {}) do
                mission[mission_key] = mission_value
            end
            for mission_key, mission_value in pairs(value) do
                mission[mission_key] = mission_value
            end
            data.freedom_mission = mission
        elseif key ~= "enemies" then
            data[key] = value
        end
    end

    -- Liberation missions award loot through panels, never battle result drops.
    -- Do not mutate the cached encounter definition or regular EZEncounters.
    data.no_battle_rewards = true

    -- Liberation flipping belongs to the WORLD formation, never to an
    -- encounter's authored flip flag. The editor can carry these same
    -- encounter definitions to regular ezencounters / the Endless Runner,
    -- but those games should keep their own flip behavior.
    -- `terrain` is resolved by PanelEncounters.resolve_terrain() before
    -- build_encounter_data is called for each liberation battle.
    if type(data.freedom_mission) == "table" then
        data.freedom_mission.player_can_flip = (data.terrain == "surrounded")
    end

    local health_applied = false
    local matched_enemy_alias = nil

    -- Legacy custom encounter packages receive their associated enemy's
    -- current HP through the top-level `health` field. The shared ezencounters
    -- package receives the same value on the matching data.enemies entry below.
    if persistent_enemy and persistent_enemy.health ~= nil then
        data.health = persistent_enemy.health
    end

    local expected_alias = persistent_enemy
        and normalize_enemy_name(persistent_enemy.template_name)
    local expected_display_name = persistent_enemy
        and normalize_enemy_name(persistent_enemy.battle_name or persistent_enemy.name)

    if persistent_enemy and persistent_enemy.health ~= nil and type(data.enemies) == "table" then
        -- ezencounters resolves data.enemies[index].name through its
        -- enemy_packages table. Prefer the exact template registry key, which
        -- is that package alias; only fall back to the display name for older
        -- enemy objects that do not carry template_name.
        for _, enemy_info in ipairs(data.enemies) do
            if type(enemy_info) == "table" then
                local encounter_alias = normalize_enemy_name(enemy_info.name)
                local alias_matches = expected_alias and encounter_alias == expected_alias
                local display_name_matches = expected_display_name
                    and encounter_alias == expected_display_name
                if alias_matches or display_name_matches then
                    enemy_info.health = persistent_enemy.health
                    -- A separate max_hp request lets ezencounters choose a
                    -- compatible character package whose first set_health()
                    -- call establishes this maximum. A mutator cannot raise
                    -- an already initialized character's maximum HP.
                    local maximum = tonumber(persistent_enemy.max_health)
                    if maximum and maximum > 0 then
                        enemy_info.max_hp = maximum
                    end
                    health_applied = true
                    matched_enemy_alias = enemy_info.name
                    break
                end
            end
        end
    end

    -- A single-entry encounter has only one possible target. This fallback
    -- handles package aliases that intentionally differ from the world-bot
    -- template without risking HP being assigned to an unrelated enemy in a
    -- multi-enemy encounter.
    if persistent_enemy and not health_applied
        and type(data.enemies) == "table"
        and #data.enemies == 1
        and type(data.enemies[1]) == "table" then
        data.enemies[1].health = persistent_enemy.health
        local maximum = tonumber(persistent_enemy.max_health)
        if maximum and maximum > 0 then
            data.enemies[1].max_hp = maximum
        end
        health_applied = true
        matched_enemy_alias = data.enemies[1].name
    end

    local entry_summary = {}
    for index, enemy_info in ipairs(data.enemies or {}) do
        if type(enemy_info) == "table" then
            entry_summary[#entry_summary + 1] = string.format(
                "%d:%s health=%s max_hp=%s starting_hp=%s rank=%s scale=%s",
                index,
                tostring(enemy_info.name),
                tostring(enemy_info.health),
                tostring(enemy_info.max_hp),
                tostring(enemy_info.starting_hp),
                tostring(enemy_info.rank),
                tostring(enemy_info.scale)
            )
        end
    end

    -- Battle scaling is applied after this builder by BattleScale.apply().
    -- HP synchronization and visual scale must remain independent because
    -- Dark Hole liberation-list battles do not inherit the source bot's HP.

    -- Battle modifiers are metadata for compatible encounter/character packages.
    -- These are intentionally not applied as unverified global damage hooks.
    if persistent_enemy and type(data.enemies) == "table" then
        for _, entry in ipairs(data.enemies) do
            local alias = normalize_enemy_name(entry.name)
            if (expected_alias and alias == expected_alias) or
                (expected_display_name and alias == expected_display_name) or #data.enemies == 1 then
                entry.attack_multiplier = persistent_enemy.battle_attack_multiplier or 1
                entry.defense_multiplier = persistent_enemy.battle_defense_multiplier or 1
                break
            end
        end
    end

    if persistent_enemy and not health_applied then
        log:warn_data("Persistent enemy did not match an ezencounters enemy entry", {
            template_name = tostring(persistent_enemy.template_name),
            battle_name = tostring(persistent_enemy.battle_name or persistent_enemy.name),
            persistent_health = persistent_enemy.health,
            expected_alias = tostring(expected_alias),
            expected_display_name = tostring(expected_display_name),
            encounter_entries = table.concat(entry_summary, " | "),
        })
    end

    return data, health_applied, matched_enemy_alias
end

-- Preserve HP independence: list encounters build without a persistent bot,
-- but may still inherit visual scale from the Dark Hole's Tiled configuration.
local function apply_battle_visuals(data, source, mission, panel, encounter_definition, encounter_source)
    return BattleScale.apply(data, source, {
        base_area_id = mission.base_area_id,
        source_object_id = panel and panel.visual_object_id,
        encounter_name = encounter_definition and encounter_definition.name,
        encounter_source = encounter_source,
        scope = source and source.battle_scale_scope
            or panel and panel.enemy_config and panel.enemy_config.battle_scale_scope,
    })
end

local debug = false

-- Tiled object classes are authoritative when they identify a known panel.
-- GID lookup remains the fallback for tile-based panel objects and legacy maps.
local function resolve_panel_type(object)
    if type(object) ~= "table" then
        return nil
    end

    local object_type = object.type
    local panel_types = Constants.PanelTypes

    if object_type == panel_types.DarkPanel
        or object_type == panel_types.DarkHole
        or object_type == panel_types.IndestructiblePanel
        or object_type == panel_types.ItemPanel
        or object_type == panel_types.PanelGate
        or object_type == panel_types.BonusPanel
        or object_type == panel_types.TrapPanel then
        return object_type
    end

    if object_type == panel_types.DarkHoleBuffedVirus then
        return panel_types.DarkHole
    end

    local gid = object.data and object.data.gid
    if gid ~= nil then
        return PanelRegistry.get_type_by_gid(gid)
    end

    return nil
end

local function is_panel(self, object)
    return resolve_panel_type(object) ~= nil
end

local function is_adjacent(position_a, position_b)
    if position_a.z ~= position_b.z then
        return false
    end
    local x_diff = math.abs(math.floor(position_a.x) - math.floor(position_b.x))
    local y_diff = math.abs(math.floor(position_a.y) - math.floor(position_b.y))
    return x_diff + y_diff == 1
end

local function boot_player(player, isVictory, mapName)
    Net.set_player_emote(player.id, Emotes.BLANK)
    PlayerControl.release_capture(player.id, "liberation:turn")
    player:boot_to_lobby(isVictory, mapName)
end

local function liberate(self)
    HPIndicators.destroy(self)
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

    log:info_data("Liberation victory", {
        base_area_id = self.base_area_id,
        instance_area_id = self.area_id,
        area_name = self.area_name,
        target_phase = self.target_phase,
        actual_phase = self.phase,
    })

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

local function normalized_reference(value)
    if value == nil or value == "" then return nil end
    return tostring(value)
end

local function boss_group_ids_from_properties(properties)
    local ids = {}
    local seen = {}
    properties = properties or {}

    for _, property_name in ipairs({
        Constants.CustomProperties.BossID1,
        Constants.CustomProperties.BossID2,
    }) do
        local boss_id = normalized_reference(properties[property_name])
        if boss_id and not seen[boss_id] then
            seen[boss_id] = true
            ids[#ids + 1] = boss_id
        end
    end

    return ids
end

local function object_is_associated_with_boss(properties, boss_group_id)
    for _, boss_id in ipairs(boss_group_ids_from_properties(properties)) do
        if boss_id == tostring(boss_group_id) then
            return true
        end
    end
    return false
end

local function count_dark_holes_for_boss(self, boss_definition)
    local count = 0
    for _, dark_hole in ipairs(self.dark_holes or {}) do
        if object_is_associated_with_boss(dark_hole.custom_properties, boss_definition.group_id) then
            count = count + 1
        end
    end
    return count
end

local function convert_indestructible_panels(self)
    local slide_time = .5
    local hold_time = 2
    local converting = {}
    local remaining = {}
    local camera_bosses = {}
    local camera_boss_seen = {}

    local function add_camera_focus(definition)
        if definition and not camera_boss_seen[definition.group_id] then
            camera_boss_seen[definition.group_id] = true
            -- Camera focuses on this group's Boss Dark Panel, even if its
            -- overworld bot has not spawned or another boss spawned afterward.
            camera_bosses[#camera_bosses + 1] = definition
        end
    end

    for _, panel in ipairs(self.indestructible_panels or {}) do
        local properties = panel.custom_properties or {}
        local shared = properties[Constants.CustomProperties.Shared] == true
            or properties[Constants.CustomProperties.Shared] == "true"
        local panel_boss_ids = boss_group_ids_from_properties(properties)
        local should_convert = false
        local satisfied_bosses = {}
        if shared then
            should_convert = #self.dark_holes == 0
        elseif #panel_boss_ids > 0 then
            local requirement_type = properties[Constants.CustomProperties.Type] or "All"
            if requirement_type ~= "Any" then requirement_type = "All" end
            local cleared_count = 0
            for _, panel_boss_id in ipairs(panel_boss_ids) do
                for _, definition in ipairs(self.boss_definitions or {}) do
                    if definition.group_id == panel_boss_id then
                        if count_dark_holes_for_boss(self, definition) == 0 then
                            cleared_count = cleared_count + 1
                            satisfied_bosses[#satisfied_bosses + 1] = definition
                        end
                        break
                    end
                end
            end
            if requirement_type == "Any" then
                should_convert = cleared_count > 0
            else
                should_convert = cleared_count == #panel_boss_ids
            end
        else
            -- Unassociated panels retain mission-wide behavior.
            should_convert = #self.dark_holes == 0
        end
        if should_convert then
            converting[#converting + 1] = panel
            if shared then
                -- A shared panel may also name a specific boss group. Prefer
                -- that group over the last spawned boss or unrelated bosses.
                for _, definition in ipairs(self.boss_definitions or {}) do
                    if count_dark_holes_for_boss(self, definition) == 0 then
                        if #panel_boss_ids == 0
                            or object_is_associated_with_boss(properties, definition.group_id) then
                            add_camera_focus(definition)
                        end
                    end
                end
            else
                for _, definition in ipairs(satisfied_bosses) do
                    add_camera_focus(definition)
                end
            end
        else
            remaining[#remaining + 1] = panel
        end
    end

    if #converting == 0 then return end

    local sessions = {}
    for _, session in pairs(self.player_sessions) do
        sessions[#sessions + 1] = session
        if Net.get_area_custom_properties(self.area_id)[Constants.CustomProperties.VictoryLapSong] then
            Net.set_song(self.area_id, Net.get_area_custom_properties(self.area_id)[Constants.CustomProperties.VictoryLapSong])
        end
        PlayerControl.acquire_capture(session.player.id, "liberation:turn")
    end

    -- Visit every distinct associated boss once. With multiple boss groups,
    -- using `self.boss` points to whichever one spawned last, which can be
    -- unrelated to the panels just converted.
    for _, definition in ipairs(camera_bosses) do
        local x, y, z = definition.x + .5, definition.y + .5, definition.z
        for _, session in ipairs(sessions) do
            Net.slide_player_camera(session.player.id, x, y, z, slide_time)
            Net.move_player_camera(session.player.id, x, y, z, hold_time)
        end
        Async.await(Async.sleep(slide_time + hold_time))
    end

    log:info_data("Converting indestructible panels", {
        base_area_id = self.base_area_id,
        instance_area_id = self.area_id,
        panel_count = #converting,
        remaining_count = #remaining,
        boss_camera_focus_count = #camera_bosses,
    })

    for _, panel in ipairs(converting) do
        local actual_panel = Net.get_object_by_id(self.area_id, panel.visual_object_id)
        if actual_panel then
            actual_panel.data.gid = self.BASIC_PANEL_GID_LIST[#self.BASIC_PANEL_GID_LIST]
            actual_panel.type = Constants.PanelTypes.DarkPanel
            panel.type = Constants.PanelTypes.DarkPanel
            panel.visual_gid = self.BASIC_PANEL_GID_LIST[#self.BASIC_PANEL_GID_LIST]
            Net.set_object_data(self.area_id, actual_panel.id, actual_panel.data)
            Net.set_object_data(self.area_id, panel.id, panel.data)
        end
    end
    self.indestructible_panels = remaining

    -- Hold on the associated boss long enough to display the unlock.
    if #camera_bosses > 0 then
        for _, session in ipairs(sessions) do
            local definition = camera_bosses[#camera_bosses]
            Net.move_player_camera(session.player.id,
                definition.x + .5, definition.y + .5, definition.z, .5)
        end
        Async.await(Async.sleep(.5))
    end

    for _, session in ipairs(sessions) do
        local player = session.player
        Net.slide_player_camera(player.id, player.x, player.y, player.z, slide_time)
    end
    Async.await(Async.sleep(slide_time))
    for _, session in ipairs(sessions) do
        local player = session.player
        Net.unlock_player_camera(player.id)
        if not session.completed_turn then
            PlayerControl.release_capture(player.id, "liberation:turn")
        end
        player:say("Indestructible Panels have been unlocked!")
    end
end

local DARK_HOLE_SHAPE = {
    {1, 1, 1},
    {1, 1, 1},
    {1, 1, 1},
}

local function liberate_panel(self, player_session)
    local player = player_session.player
    local selection = player_session.selection
    local panel = selection.root_panel

    local co = coroutine.create(function()
        log:info_data("Player liberating panel", {
            base_area_id = self.base_area_id,
            instance_area_id = self.area_id,
            player_id = player.id,
            panel_type = panel.type,
            panel_x = panel.x,
            panel_y = panel.y,
            panel_z = panel.z,
            ability = player_session.ability and player_session.ability.name,
            order_points = self.order_points,
            phase = self.phase,
        })

        if panel.type == Constants.PanelTypes.BonusPanel then
            if panel.custom_properties[Constants.CustomProperties.Message] then
                Async.await(player:message_with_mug(panel.custom_properties[Constants.CustomProperties.Message]))
            else
                Async.await(player:message_with_mug("A BonusPanel! What's it hiding?"))
            end
            self:remove_panel(panel)
            selection:clear()
            Async.await(Loot.loot_bonus_panel(self, player_session, panel))
            PlayerControl.release_capture(player.id, "liberation:turn")
        elseif panel.type == Constants.PanelTypes.DarkHole then
            if panel.custom_properties[Constants.CustomProperties.Message] then
                Async.await(player:message_with_mug(panel.custom_properties[Constants.CustomProperties.Message]))
            else
                Async.await(player:message_with_mug("A Dark Hole! Begin liberation!"))
            end
            local enemy = panel.enemy
            -- Initialize the transient Dark Hole battle from its associated
            -- persistent world bot. Battle results are deliberately not written
            -- back to that bot after this encounter.
            local data = {
                terrain = PanelEncounters.resolve_terrain(self, player)
            }
            local encounter_category = enemy and enemy.is_boss and "bosses"
                or enemy and enemy.is_special_encounter and "special_encounters"
                or "encounters"
            local properties = panel.custom_properties or {}
            local liberation_candidates = PanelEncounters.resolve_dark_hole_liberation_encounters(
                self.base_area_id, properties[Constants.CustomProperties.DarkHoleLiberationEncounters])
            -- An empty/disabled/invalid weighted list falls back to the OW
            -- encounter instead of leaving the liberation action unplayable.
            local encounter_definition = PanelEncounters.pick_weighted(liberation_candidates)
            local uses_liberation_list = encounter_definition ~= nil
            if not uses_liberation_list then
                encounter_definition = PanelEncounters.resolve_enemy_encounter(
                    self.base_area_id, encounter_category, enemy, properties, panel.enemy_config)
            end
            log:info_data("Initiating dark hole encounter", {
                encounter_source = uses_liberation_list and "liberation_list" or "bot_encounter",
                liberation_candidate_count = #liberation_candidates,
                selected_encounter_name = encounter_definition and encounter_definition.name,
                ow_bot_encounter_name = enemy and enemy.ow_bot_encounter_name
                    or properties[Constants.CustomProperties.OWBotEncounter]
                    or properties[Constants.CustomProperties.LegacyBossEncounter],
                base_area_id = self.base_area_id,
                instance_area_id = self.area_id,
                area_name = self.area_name,
                player_id = player.id,
                enemy_name = enemy and enemy.battle_name,
                enemy_health = enemy and enemy.health,
                encounter_path = encounter_definition and encounter_definition.path,
                terrain = data.terrain,
                phase = self.phase,
            })
            if not encounter_definition or not encounter_definition.path then
                log:error_data("Missing encounter definition for dark hole", {
                    base_area_id = self.base_area_id,
                    player_id = player.id,
                })
                player_session:complete_turn()
                return
            end
            if self.encounter_music then
                data.music = self.encounter_music
            end
            -- The dedicated liberation list is a separate battle; its
            -- enemies must retain their authored HP rather than inherit HP
            -- from the Dark Hole's persistent overworld bot.
            local battle_bot = nil
            if not uses_liberation_list then
                battle_bot = enemy
            end
            local encounter_data, persistent_health_applied, persistent_health_alias =
                build_encounter_data(encounter_definition, data, battle_bot)
            local scale_result = apply_battle_visuals(encounter_data,
                enemy or panel.enemy_config, self, panel, encounter_definition,
                uses_liberation_list and "liberation_list" or "bot_encounter")
            local minion_health_applied_count, minion_health_matched_alias = 0, nil
            if battle_bot then
                minion_health_applied_count, minion_health_matched_alias =
                    apply_dark_hole_minion_health_override(encounter_data, panel, battle_bot)
            end
            local minion_health_override = tonumber(
                (panel.custom_properties or {})[Constants.CustomProperties.MinionHealthOverride]) or 0
            log:info_data("Prepared dark hole encounter data", {
                encounter_name = encounter_definition.name,
                persistent_enemy = enemy and (enemy.battle_name or enemy.name),
                persistent_health = enemy and enemy.health,
                persistent_scale = enemy and enemy.scale,
                resolved_battle_scale = scale_result.scale,
                battle_scale_scope = scale_result.scope,
                battle_scale_target = scale_result.target,
                battle_scale_updated_count = scale_result.count,
                persistent_health_applied = persistent_health_applied,
                persistent_health_matched_alias = persistent_health_alias,
                minion_health_override = minion_health_override,
                minion_health_applied_count = minion_health_applied_count,
                minion_health_matched_alias = minion_health_matched_alias,
                encounter_enemy_entries = (function()
                    local entries = {}
                    for index, enemy_info in ipairs(encounter_data.enemies or {}) do
                        if type(enemy_info) == "table" then
                            entries[#entries + 1] = {
                                index = index,
                                name = enemy_info.name,
                                health = enemy_info.health,
                                max_hp = enemy_info.max_hp,
                                starting_hp = enemy_info.starting_hp,
                                rank = enemy_info.rank,
                                scale = enemy_info.scale,
                            }
                        end
                    end
                    return entries
                end)(),
                freedom_mission = encounter_data.freedom_mission ~= nil,
                resolved_terrain = encounter_data.terrain,
                player_can_flip = encounter_data.freedom_mission
                    and encounter_data.freedom_mission.player_can_flip or false,
            })
            if battle_bot and minion_health_override > 0 and minion_health_applied_count == 0 then
                log:warn_data("Dark Hole Minion Health Override did not match an encounter enemy", {
                    dark_hole_x = panel.x,
                    dark_hole_y = panel.y,
                    spawned_enemy_template = enemy and enemy.template_name,
                    spawned_enemy_name = enemy and (enemy.battle_name or enemy.name),
                    encounter_name = encounter_definition.name,
                    minion_health_override = minion_health_override,
                })
            end
            -- Always check the chosen package on the actual cloned area. This
            -- also handles Encounter Path overrides not in the base table.
            if not PanelEncounters.ensure_encounter_asset(self.area_id, encounter_definition.path) then
                log:error_data("Liberation encounter aborted: battle package unavailable", {
                    base_area_id = self.base_area_id,
                    instance_area_id = self.area_id,
                    encounter_name = encounter_definition.name,
                    package_path = encounter_definition.path,
                    player_id = player.id,
                })
                player_session:complete_turn()
                return
            end
            local encounter_valid, encounter_problem =
                PanelEncounters.validate_encounter_data(encounter_data, encounter_definition.path)
            if not encounter_valid then
                log:error_data("Blocked invalid Liberation battle payload", {
                    base_area_id = self.base_area_id,
                    instance_area_id = self.area_id,
                    encounter_name = encounter_definition.name,
                    problem = encounter_problem,
                })
                player_session:complete_turn()
                return
            end
            log:info_data("Dispatching liberation encounter to client", {
                base_area_id = self.base_area_id,
                instance_area_id = self.area_id,
                encounter_name = encounter_definition.name,
                package_path = encounter_definition.path,
                enemy_count = type(encounter_data.enemies) == "table" and #encounter_data.enemies or 0,
                has_positions = type(encounter_data.positions) == "table",
                has_player_positions = type(encounter_data.player_positions) == "table",
                terrain = encounter_data.terrain,
                player_id = player.id,
            })
            local results = Async.await(player_session:initiate_encounter(encounter_definition.path, encounter_data))
            -- Deliberately do not synchronize Dark Hole battle results to the
            -- persistent bot. Only a battle started directly on an active bot
            -- panel may change that bot's saved HP.
            log:info_data("Dark hole encounter results", {
                base_area_id = self.base_area_id,
                instance_area_id = self.area_id,
                player_id = player.id,
                success = results.success,
                turns = results.turns,
                ran = tostring(results.ran),
                reason = tostring(results.reason),
                escape = tostring(results.escape),
                fled = tostring(results.fled),
                health = results.health,
                enemy_count = #(results.enemies or results.Enemies or {}),
                persistent_health_synced = false,
                retained_enemy_health = enemy and enemy.health,
            })
            if not results.success then
                player_session:complete_turn()
                return
            end
            -- On a successful Dark Hole battle, liberate every adjacent
            -- liberatable panel, except panels occupied by any bot. The
            -- selection filter is broadened only for this operation.
            selection:set_include_all_liberatable_panels(true)
            selection:set_shape(DARK_HOLE_SHAPE, 0, -1)
            local panels = selection:get_panels()
            selection:set_include_all_liberatable_panels(false)
            Async.await(player_session:liberate_panels(panels, results))
            Async.await(Enemy.destroy(self, panel.enemy))
            Async.await(player_session:loot_panels(panels, false, false))
            self:spawn_bosses_for_cleared_dark_holes()
            -- Evaluate every Indestructible Panel against its configured Boss
            -- ID 1/2 requirements after each successful Dark Hole liberation.
            convert_indestructible_panels(self)
            player_session:complete_turn()
        else
            if panel.custom_properties[Constants.CustomProperties.Message] then
                Async.await(player:message_with_mug(panel.custom_properties[Constants.CustomProperties.Message]))
            else
                Async.await(player:message_with_mug("Let's do it! Liberate panels!"))
            end
            local enemy = self:get_enemy_at(panel.x, panel.y, panel.z)
            local data = { terrain = PanelEncounters.resolve_terrain(self, player) }
            local encounter_definition
            if panel.custom_properties[Constants.CustomProperties.EncounterPath] then
                encounter_definition = PanelEncounters.resolve_encounter_value(
                    panel.custom_properties[Constants.CustomProperties.EncounterPath], self.base_area_id)
            else
                local encounter_category = enemy and enemy.is_boss and "bosses"
                    or enemy and enemy.is_special_encounter and "special_encounters"
                    or "encounters"
                encounter_definition = PanelEncounters.resolve_enemy_encounter(
                    self.base_area_id, encounter_category, enemy, panel.custom_properties, panel.enemy_config)
            end
            if enemy then
                data.health = enemy.health
            end
            log:info_data("Initiating panel encounter", {
                base_area_id = self.base_area_id,
                instance_area_id = self.area_id,
                area_name = self.area_name,
                player_id = player.id,
                panel_type = panel.type,
                panel_x = panel.x,
                panel_y = panel.y,
                panel_z = panel.z,
                enemy_name = enemy and enemy.battle_name,
                enemy_health = enemy and enemy.health,
                source = enemy and "enemy_on_panel" or "panel",
                encounter_path = encounter_definition and encounter_definition.path,
                terrain = data.terrain,
                phase = self.phase,
            })
            if not encounter_definition or not encounter_definition.path then
                log:error_data("Missing encounter definition for panel", {
                    base_area_id = self.base_area_id,
                    player_id = player.id,
                    panel_x = panel.x,
                    panel_y = panel.y,
                })
                player_session:complete_turn()
                return
            end
            if self.encounter_music then
                data.music = self.encounter_music
            end
            local encounter_data, encounter_health_applied, matched_enemy_alias = build_encounter_data(
                encounter_definition, data, enemy)
            -- A normal panel has no Dark Hole scale source unless it holds a
            -- configured enemy. Avoid leaking Dark Hole category defaults to
            -- unrelated generic panel encounters.
            local scale_result = apply_battle_visuals(encounter_data,
                enemy, self, panel, encounter_definition, "panel")
            local encounter_enemy_entries = {}
            for index, enemy_info in ipairs(encounter_data.enemies or {}) do
                if type(enemy_info) == "table" then
                    encounter_enemy_entries[#encounter_enemy_entries + 1] = {
                        index = index,
                        name = enemy_info.name,
                        health = enemy_info.health,
                        max_hp = enemy_info.max_hp,
                        starting_hp = enemy_info.starting_hp,
                        rank = enemy_info.rank,
                        scale = enemy_info.scale,
                    }
                end
            end
            log:info_data("Prepared panel encounter data", {
                encounter_name = encounter_definition.name,
                persistent_enemy = enemy and (enemy.battle_name or enemy.name),
                persistent_enemy_template = enemy and enemy.template_name,
                persistent_health = enemy and enemy.health,
                matched_enemy_alias = matched_enemy_alias,
                enemy_entry_health_applied = encounter_health_applied,
                resolved_battle_scale = scale_result.scale,
                battle_scale_scope = scale_result.scope,
                battle_scale_target = scale_result.target,
                battle_scale_updated_count = scale_result.count,
                encounter_enemy_entries = encounter_enemy_entries,
                freedom_mission = encounter_data.freedom_mission ~= nil,
                resolved_terrain = encounter_data.terrain,
                player_can_flip = encounter_data.freedom_mission
                    and encounter_data.freedom_mission.player_can_flip or false,
            })
            -- Always check the chosen package on the actual cloned area. This
            -- also handles Encounter Path overrides not in the base table.
            if not PanelEncounters.ensure_encounter_asset(self.area_id, encounter_definition.path) then
                log:error_data("Liberation encounter aborted: battle package unavailable", {
                    base_area_id = self.base_area_id,
                    instance_area_id = self.area_id,
                    encounter_name = encounter_definition.name,
                    package_path = encounter_definition.path,
                    player_id = player.id,
                })
                player_session:complete_turn()
                return
            end
            local encounter_valid, encounter_problem =
                PanelEncounters.validate_encounter_data(encounter_data, encounter_definition.path)
            if not encounter_valid then
                log:error_data("Blocked invalid Liberation battle payload", {
                    base_area_id = self.base_area_id,
                    instance_area_id = self.area_id,
                    encounter_name = encounter_definition.name,
                    problem = encounter_problem,
                })
                player_session:complete_turn()
                return
            end
            log:info_data("Dispatching liberation encounter to client", {
                base_area_id = self.base_area_id,
                instance_area_id = self.area_id,
                encounter_name = encounter_definition.name,
                package_path = encounter_definition.path,
                enemy_count = type(encounter_data.enemies) == "table" and #encounter_data.enemies or 0,
                has_positions = type(encounter_data.positions) == "table",
                has_player_positions = type(encounter_data.player_positions) == "table",
                terrain = encounter_data.terrain,
                player_id = player.id,
            })
            local results = Async.await(player_session:initiate_encounter(encounter_definition.path, encounter_data))
            -- Synchronize before branching: survivors retain their health on
            -- both wins and losses whenever the battle engine reports them.
            local enemy_health_synced = false
            if enemy then
                enemy_health_synced = EnemyHelpers.sync_health(enemy, results, encounter_data)
            end
            log:info_data("Panel encounter results", {
                base_area_id = self.base_area_id,
                instance_area_id = self.area_id,
                player_id = player.id,
                panel_type = panel.type,
                success = results.success,
                turns = results.turns,
                ran = tostring(results.ran),
                reason = tostring(results.reason),
                escape = tostring(results.escape),
                fled = tostring(results.fled),
                health = results.health,
                enemy_count = #(results.enemies or results.Enemies or {}),
                enemy_health_synced = enemy_health_synced,
                retained_enemy_health = enemy and enemy.health,
            })
            if not results.success then
                player_session:complete_turn()
                return
            end

            -- The 3x3 one-turn pattern is only earned by an actual one-turn
            -- victory. For multi-turn wins, the original single-panel shape
            -- remains in place.
            if results.success
                and tonumber(results.reason) == 1
                and tonumber(results.turns) == 1
                and not results.ran then
                log:debug_data("liberate_panel: set_shape enter", {
                    base_area_id = self.base_area_id,
                    instance_area_id = self.area_id,
                    player_id = player.id,
                })
                local ok_set, err_set = pcall(selection.set_shape, selection, DARK_HOLE_SHAPE, 0, -2)
                if not ok_set then
                    log:error_data("liberate_panel: set_shape failed", {
                        base_area_id = self.base_area_id,
                        instance_area_id = self.area_id,
                        player_id = player.id,
                        error = tostring(err_set),
                    })
                else
                    log:debug_data("liberate_panel: set_shape OK", {
                        base_area_id = self.base_area_id,
                        instance_area_id = self.area_id,
                        player_id = player.id,
                    })
                end
            end
            if enemy then
                log:debug_data("Preparing enemy destroy", {
                    base_area_id = self.base_area_id,
                    instance_area_id = self.area_id,
                    player_id = player.id,
                    enemy_name = enemy.battle_name,
                    enemy_id = tostring(enemy.id),
                    enemy_x = enemy.x,
                    enemy_y = enemy.y,
                })
                Async.await(Enemy.destroy(self, enemy))
                log:debug_data("Enemy destroy complete", {
                    base_area_id = self.base_area_id,
                    instance_area_id = self.area_id,
                    player_id = player.id,
                })
            end
            log:debug_data("liberate_panel: get_panels enter", {
                base_area_id = self.base_area_id,
                instance_area_id = self.area_id,
                player_id = player.id,
            })
            local panels = {}
            local ok_gp, err_gp = pcall(function()
                panels = player_session.selection:get_panels()
            end)
            if not ok_gp then
                log:error_data("liberate_panel: get_panels failed", {
                    base_area_id = self.base_area_id,
                    instance_area_id = self.area_id,
                    player_id = player.id,
                    error = tostring(err_gp),
                })
                panels = {}
            end
            local panel_summary = {}
            for _, p in ipairs(panels) do
                if p then
                    panel_summary[#panel_summary + 1] = string.format("%s@(%s,%s,%s)",
                        tostring(p.type), tostring(p.x), tostring(p.y), tostring(p.z))
                end
            end
            log:info_data("Liberating panels post-battle", {
                base_area_id = self.base_area_id,
                instance_area_id = self.area_id,
                player_id = player.id,
                panel_count = #panels,
                panels = panel_summary,
            })
            if #panels > 0 then
                Async.await(player_session:liberate_and_loot_panels(panels, results, false, false))
                log:info_data("liberate_and_loot_panels returned", {
                    base_area_id = self.base_area_id,
                    instance_area_id = self.area_id,
                    player_id = player.id,
                })
            else
                log:warn_data("No panels after battle; skipping liberation", {
                    base_area_id = self.base_area_id,
                    instance_area_id = self.area_id,
                    player_id = player.id,
                })
            end
            if enemy and enemy.is_boss then
                local mission_complete = self:handle_boss_defeated(enemy)
                if not mission_complete then
                    player_session:complete_turn()
                end
            else
                player_session:complete_turn()
            end
        end
    end)
    Async.promisify(co)
end

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

        log:info_data("Enemy turn start", {
            base_area_id = self.base_area_id,
            instance_area_id = self.area_id,
            area_name = self.area_name,
            phase = self.phase,
            enemy_count = #self.enemies,
            dark_hole_count = #self.dark_holes,
            player_count = #self.players,
            down_players = down_count,
            order_points = self.order_points,
        })

        if down_count == #self.players then
            log:info_data("All players down, retreating", {
                base_area_id = self.base_area_id,
                instance_area_id = self.area_id,
                phase = self.phase,
            })
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
                                PlayerControl.release_capture(player.id, "liberation:turn")
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
                Async.await(EnemyHelpers.heal(enemy, enemy.max_health * .10))
            end
            log:debug_data("Enemy taking turn", {
                base_area_id = self.base_area_id,
                instance_area_id = self.area_id,
                enemy_name = enemy and enemy.battle_name,
                enemy_health = enemy and enemy.health,
                enemy_x = enemy and enemy.x,
                enemy_y = enemy and enemy.y,
                enemy_z = enemy.z,
                is_boss = enemy.is_boss,
            })
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
                    if panel and EnemyHelpers.can_spawn_on(self, panel.x, panel.y, panel.z) then
                        table.insert(neighbors, panel)
                    end
                end
                if #neighbors > 0 then
                    local destination = neighbors[math.random(#neighbors)]
                    for _, player in ipairs(self.players) do
                        Net.slide_player_camera(player.id, dark_hole.x + .5, dark_hole.y + .5, dark_hole.z, slide_time)
                    end
                    Async.await(Async.sleep(slide_time))
                    local name = (dark_hole.enemy_config and dark_hole.enemy_config.template_name)
                        or (dark_hole.custom_properties or {})[Constants.CustomProperties.Spawns]
                    local direction = (dark_hole.custom_properties or {})[Constants.CustomProperties.Direction] or "Down"
                    if not EnemyTemplates.has(name) then
                        spawn_log:warn_data("Dark Hole respawn skipped: missing/unknown OW template", {
                            area_id = self.area_id, source_object_id = dark_hole.visual_object_id,
                            panel_type = dark_hole.source_type, spawns = tostring(name),
                            encounter_mode = dark_hole.enemy_config and dark_hole.enemy_config.encounter_mode,
                            x = dark_hole.x, y = dark_hole.y,
                            remediation = "Set Spawns to a registered overworld enemy template; encounters and pools select battles only",
                        })
                    else
                        spawn_log:info_data("Dark Hole respawn requested", {
                            area_id = self.area_id, source_object_id = dark_hole.visual_object_id,
                            template_name = name, destination_x = destination.x, destination_y = destination.y,
                        })
                        local enemy = Enemy.from(self, dark_hole, direction, name, {
                            scale = dark_hole.scale,
                            source_panel_type = dark_hole.source_type or dark_hole.type,
                        })
                        if enemy then
                            dark_hole.enemy = enemy
                            apply_panel_enemy_config(dark_hole, enemy)
                            assign_dark_hole_bot_encounter(dark_hole, enemy)
                            apply_dark_hole_minion_health_to_bot(dark_hole, enemy)
                            self.enemies[#self.enemies+1] = enemy
                            Async.await(Async.sleep(.5))
                            Async.await(EnemyHelpers.move(self, enemy, destination.x, destination.y, destination.z))
                            Async.await(Async.sleep(.5))
                            spawn_log:info_data("Dark Hole respawn completed", {
                                area_id = self.area_id, source_object_id = dark_hole.visual_object_id,
                                template_name = name, enemy_id = enemy.id,
                            })
                        end
                    end
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

        log:info_data("Enemy turn end", {
            base_area_id = self.base_area_id,
            instance_area_id = self.area_id,
            phase_completed = self.phase - 1,
            next_phase = self.phase,
            enemy_count = #self.enemies,
            dark_hole_count = #self.dark_holes,
        })

        if self.needs_disposal then
            self:clean_up()
        end
    end)
    self.updating = true
    Async.promisify(co)
end


local Mission = {}

function Mission:new(base_area_id, new_area_id, players, max_order_points)
    -- Liberation Tileset is configured on the Tiled "Liberation Config"
    -- object, not in the map/area custom properties.
    local liberation_tileset_path
    local configured_max_order_points
    local configured_encounter_music
    local config_object_found = false
    local object_ids = Net.list_objects(base_area_id) or {}

    for _, object_id in ipairs(object_ids) do
        local object = Net.get_object_by_id(base_area_id, object_id)
        if object and object.type == "Liberation Config" then
            config_object_found = true
            local properties = object.custom_properties or {}
            local object_max_order_points = tonumber(properties[Constants.CustomProperties.MaxOrderPoints])
            if object_max_order_points then
                configured_max_order_points = object_max_order_points
            end
            local configured_path = properties[Constants.CustomProperties.LiberationTileset]
            local music_object_id = properties[Constants.CustomProperties.EncounterMusic]
            if music_object_id ~= nil and tostring(music_object_id) ~= "" then
                local music_object = Net.get_object_by_id(base_area_id, tonumber(music_object_id) or music_object_id)
                if music_object and music_object.type == "Music Definition" then
                    local music_properties = music_object.custom_properties or {}
                    configured_encounter_music = {
                        path = type(music_properties[Constants.CustomProperties.MusicPath]) == "string"
                            and music_properties[Constants.CustomProperties.MusicPath] or "",
                        loop_start = tonumber(music_properties[Constants.CustomProperties.MusicLoopStart]) or 0,
                        loop_end = tonumber(music_properties[Constants.CustomProperties.MusicLoopEnd]) or 0,
                    }
                else
                    log:warn_data("Liberation Config Encounter Music reference is not a Music Definition", {
                        base_area_id = base_area_id,
                        object_id = music_object_id,
                        resolved_type = music_object and music_object.type,
                    })
                end
            end
            if type(configured_path) == "string" and configured_path ~= "" then
                liberation_tileset_path = configured_path
            end
        end
    end

    if type(liberation_tileset_path) ~= "string" or liberation_tileset_path == "" then
        log:error_data("Cannot create liberation mission: Liberation Tileset missing from Liberation Config", {
            base_area_id = tostring(base_area_id),
            base_area_name = tostring(Net.get_area_name(base_area_id)),
            config_object_found = config_object_found,
            property_name = Constants.CustomProperties.LiberationTileset,
        })
        error(
            "Liberation mission area '" .. tostring(base_area_id) ..
            "' has no valid Liberation Tileset property on its Liberation Config object."
        )
    end

    local tileset_lookup_ok, liberation_tileset = pcall(function()
        return Net.get_tileset(base_area_id, liberation_tileset_path)
    end)

    if not tileset_lookup_ok then
        log:error_data("Cannot create liberation mission: tileset lookup raised an error", {
            base_area_id = tostring(base_area_id),
            base_area_name = tostring(Net.get_area_name(base_area_id)),
            tileset_path = liberation_tileset_path,
            error = tostring(liberation_tileset),
        })
        error("Failed to look up Liberation Tileset '" .. liberation_tileset_path ..
            "' for area '" .. tostring(base_area_id) .. "': " .. tostring(liberation_tileset))
    end

    if type(liberation_tileset) ~= "table" or liberation_tileset.first_gid == nil then
        log:error_data("Cannot create liberation mission: tileset lookup returned no first_gid", {
            base_area_id = tostring(base_area_id),
            base_area_name = tostring(Net.get_area_name(base_area_id)),
            tileset_path = liberation_tileset_path,
            result_type = type(liberation_tileset),
        })
        error("Liberation Tileset '" .. liberation_tileset_path ..
            "' was not found or has no first_gid in area '" .. tostring(base_area_id) .. "'.")
    end

    local FIRST_PANEL_GID = liberation_tileset.first_gid
    local TOTAL_PANEL_GIDS = 1
    local solo_target = tonumber(Net.get_area_custom_property(base_area_id, Constants.CustomProperties.TargetPhaseCount)) or 13
    local desired_players = tonumber(Net.get_area_custom_property(base_area_id, Constants.CustomProperties.TargetPlayerCount)) or 3
    local minimum_phases = tonumber(Net.get_area_custom_property(base_area_id, Constants.CustomProperties.MinimumTargetPhaseCount)) or 1
    local player_difference = #players - desired_players
    -- The Liberation Config object is the source of truth when Max Order Points
    -- is set. The caller-provided value and shared default are fallbacks for
    -- older maps/config objects that do not contain the property.
    local MAX_ORDER_POINTS = math.max(1, math.floor(
        configured_max_order_points
        or tonumber(max_order_points)
        or Constants.Defaults.MaxOrderPoints
        or 9
    ))
    local mission = {
        area_id = new_area_id,
        base_area_id = base_area_id,
        area_name = Net.get_area_name(base_area_id),
        encounter_music = configured_encounter_music,
        emote_timer = 0,
        target_phase = math.max(minimum_phases, math.ceil(solo_target / math.max(1, player_difference))),
        phase = 1,
        ready_count = 0,
        order_points = 3,
        MAX_ORDER_POINTS = MAX_ORDER_POINTS,
        points_gauges = {},
        points_of_interest = {},
        players = players,
        player_sessions = {},
        -- Mission startup is deferred until every requested player transfer
        -- has completed and the player_transfer events confirm the new area.
        pending_transfer_players = {},
        begin_started = false,
        boss = nil,
        bosses = {},
        boss_definitions = {},
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

    -- Structured diagnostics: these should appear in the same shared logger output
    -- as the rest of the liberation logs, unlike a bare print() call.
    log:info_data("Collision tileset diagnostic: before clone", {
        base_area_id = tostring(base_area_id),
        mission_area_id = tostring(new_area_id),
        diagnostic = "collision_tileset_preload_v2",
    })

    local clone_ok, clone_error = pcall(function()
        Net.clone_area(base_area_id, new_area_id)
    end)
    if not clone_ok then
        log:error_data("Collision tileset diagnostic: clone failed", {
            base_area_id = tostring(base_area_id),
            mission_area_id = tostring(new_area_id),
            error = tostring(clone_error),
        })
        error(clone_error)
    end
    log:info_data("Collision tileset diagnostic: clone complete", {
        base_area_id = tostring(base_area_id),
        mission_area_id = tostring(new_area_id),
    })

    local preload_ok, preload_error = pcall(function()
        Preloader.update(new_area_id)
    end)
    if not preload_ok then
        log:error_data("Collision tileset diagnostic: preload failed", {
            mission_area_id = tostring(new_area_id),
            error = tostring(preload_error),
        })
        error(preload_error)
    end
    log:info_data("Collision tileset diagnostic: preload complete", {
        mission_area_id = tostring(new_area_id),
        collision_tileset_path = "/server/assets/ezlibs-custom/nebulous-liberations/tiles/Liberation Collision.tsx",
    })

    -- Cloned mission areas do not go through ezencounters' base-area package
    -- provisioning. Supply registered battle ZIPs now, before transferring
    -- players into this instance. The launch path still provisions any
    -- per-panel override that was not in the base encounter table.
    local package_ok, package_count, package_failures =
        PanelEncounters.provide_mission_encounter_assets(base_area_id, new_area_id)
    if not package_ok then
        log:warn_data("Liberation mission encounter asset preflight reported failures", {
            base_area_id = base_area_id,
            mission_area_id = new_area_id,
            distinct_packages = package_count,
            failed_packages = package_failures,
        })
    end

    -- Diagnostic only: verify the new collision tileset can be retrieved from
    -- the cloned/provisioned mission area. Keep the old panel GID lookup below
    -- unchanged until this result is confirmed in a live server session.
    local collision_tileset_path = "/server/assets/ezlibs-custom/nebulous-liberations/tiles/Liberation Collision.tsx"
    local collision_tileset_ok, collision_tileset = pcall(function()
        return Net.get_tileset(mission.area_id, collision_tileset_path)
    end)
    if collision_tileset_ok and type(collision_tileset) == "table" and collision_tileset.first_gid ~= nil then
        log:info_data("Collision tileset lookup OK", {
            area_id = tostring(mission.area_id),
            path = collision_tileset_path,
            first_gid = tostring(collision_tileset.first_gid),
        })
    else
        log:error_data("Collision tileset lookup FAILED", {
            area_id = tostring(mission.area_id),
            path = collision_tileset_path,
            lookup_succeeded = collision_tileset_ok,
            result_type = type(collision_tileset),
            result = tostring(collision_tileset),
            error = collision_tileset_ok and nil or tostring(collision_tileset),
        })
    end

    -- Enemy spawns are deferred until every panel has been registered in
    -- mission.panels. Dark Hole spawn offsets can point at panels whose Tiled
    -- objects appear later in Net.list_objects(), so spawning during this
    -- indexing pass makes the result depend on object iteration order.
    local pending_enemy_spawns = {}
    local object_ids = Net.list_objects(mission.area_id)
    for _, object_id in ipairs(object_ids) do
        local object = Net.get_object_by_id(mission.area_id, object_id)
        if object.type == "Point of Interest" then
            mission.points_of_interest[#mission.points_of_interest + 1] = object
            Net.remove_object(mission.area_id, object_id)
        elseif is_panel(mission, object) then
            local object_type = object.type
            -- Explicit Tiled panel classes take precedence over visual GIDs.
            -- This is important when Item Panels and other panel classes use
            -- artwork whose GID has not been registered (or is shared).
            -- Tile-based/legacy objects still resolve through PanelRegistry.
            local is_buffed_virus = object_type == Constants.PanelTypes.DarkHoleBuffedVirus
            local properties = object.custom_properties or {}
            local requested_panel_scale = tonumber(properties[Constants.CustomProperties.Scale])
            if requested_panel_scale and (requested_panel_scale <= 0
                or requested_panel_scale ~= requested_panel_scale
                or requested_panel_scale == math.huge) then
                log:warn_data("Ignoring invalid panel scale", {
                    object_id = object.id,
                    requested_scale = tostring(properties[Constants.CustomProperties.Scale]),
                })
                requested_panel_scale = nil
            end
            local panel_type = resolve_panel_type(object)
            local new_panel = {
                name = "", type = panel_type, source_type = object_type,
                scale = requested_panel_scale or (is_buffed_virus and 1 or nil),
                enemy_config = EnemyConfig.resolve(mission.area_id, object,
                    Constants.CustomProperties.MinionHealthOverride,
                    is_buffed_virus and "Buffed Virus" or "Dark Hole"),
                visible = true,
                x = object.x, y = object.y, z = object.z, width = object.width, height = object.height,
                data = { type = "tile", gid = Net.get_tileset(base_area_id, "/server/assets/ezlibs-custom/nebulous-liberations/tiles/Liberation Collision.tsx").first_gid },
                custom_properties = object.custom_properties,
                visual_object_id = object.id,
                visual_gid = object.data.gid
            }

            if new_panel.enemy_config.ow_scale then new_panel.scale = new_panel.enemy_config.ow_scale end

            if panel_type == Constants.PanelTypes.ItemPanel then
                if not includes(mission.ITEM_PANEL_GID_LIST, object.data.gid) then
                    table.insert(mission.ITEM_PANEL_GID_LIST, object.data.gid)
                    TOTAL_PANEL_GIDS = TOTAL_PANEL_GIDS + 1
                end
                if object.custom_properties[Constants.CustomProperties.SpecificLoot] then
                    local check_loot = tostring(object.custom_properties[Constants.CustomProperties.SpecificLoot])
                        :upper()
                        :gsub("[%s%-]+", "_")
                    for i = 1, #Loot.FULL_POOL do
                        if Loot.FULL_POOL[i].animation == check_loot then
                            new_panel.loot = Loot.FULL_POOL[i]
                            break
                        end
                    end
                    if not new_panel.loot then
                        log:warn_data("Unknown Specific Loot value on Item Panel", {
                            base_area_id = self.base_area_id,
                            instance_area_id = self.area_id,
                            specific_loot = object.custom_properties[Constants.CustomProperties.SpecificLoot],
                            panel_x = object.x,
                            panel_y = object.y,
                        })
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

            local configured_boss_name = object.custom_properties
                and object.custom_properties[Constants.CustomProperties.Boss]
            if configured_boss_name and configured_boss_name ~= "" then
                local properties = object.custom_properties or {}
                local object_id_string = tostring(object.id)
                local configured_boss_id = normalized_reference(properties[Constants.CustomProperties.BossID])
                local definition = {
                    object_id = object.id,
                    boss_id = configured_boss_id or object_id_string,
                    group_id = configured_boss_id or object_id_string,
                    enemy_name = tostring(configured_boss_name),
                    direction = properties[Constants.CustomProperties.Direction] or "Down",
                    spawn_mode = properties[Constants.CustomProperties.SpawnMode] or "Immediate",
                    trigger_boss_object_id = normalized_reference(properties[Constants.CustomProperties.TriggerBoss]),
                    x = object.x, y = object.y, z = object.z,
                    offset_x = tonumber(properties[Constants.CustomProperties.SpawnOffsetX]) or 0,
                    offset_y = tonumber(properties[Constants.CustomProperties.SpawnOffsetY]) or 0,
                    offset_z = tonumber(properties[Constants.CustomProperties.SpawnOffsetZ]) or 0,
                    auto_face_player = properties[Constants.CustomProperties.AutoFacePlayer] == true
                        or properties[Constants.CustomProperties.AutoFacePlayer] == "true",
                    max_health_override = tonumber(properties[Constants.CustomProperties.BossHealthOverride]) or 0,
                    scale = new_panel.scale,
                    enemy_config = EnemyConfig.resolve(mission.area_id, object,
                        Constants.CustomProperties.BossHealthOverride, "Boss"),
                    spawn_enabled = not (properties[Constants.CustomProperties.SpawnEnabled] == false
                        or properties[Constants.CustomProperties.SpawnEnabled] == "false"),
                    display_name = tostring(properties[Constants.CustomProperties.BossDisplayName] or ""),
                    panel = new_panel,
                    spawned = false,
                    defeated = false,
                }
                mission.boss_definitions[#mission.boss_definitions + 1] = definition
            end
            if panel_type == Constants.PanelTypes.DarkHole then
                local template_name = new_panel.enemy_config and new_panel.enemy_config.template_name
                    or object.custom_properties[Constants.CustomProperties.Spawns]
                if not EnemyTemplates.has(template_name) then
                    spawn_log:warn_data("Panel overworld spawn unavailable", {
                        area_id = mission.area_id, source_object_id = object.id,
                        panel_type = object_type, template_name = tostring(template_name),
                        has_encounter_pool = new_panel.enemy_config and new_panel.enemy_config.encounter_pool ~= nil,
                        remediation = "Set Spawns to a registered overworld enemy template",
                    })
                else
                    pending_enemy_spawns[#pending_enemy_spawns + 1] = {
                    source_object_id = object.id,
                    source_panel = new_panel,
                    name = template_name,
                    direction = object.custom_properties[Constants.CustomProperties.Direction] or "Down",
                    position = { x = object.x, y = object.y, z = object.z },
                    }
                end
            end
        end
    end

    -- Now that the complete panel grid is available, resolve each configured
    -- panel enemy spawn. This ensures every Dark Hole checks its actual adjacent
    -- destination panel, regardless of Tiled object ordering.
    spawn_log:info_data("Panel overworld spawn queue constructed", {
        area_id = mission.area_id, configured_count = #pending_enemy_spawns,
        dark_hole_count = #mission.dark_holes,
    })
    local spawned_panel_enemy_count = 0
    for _, pending in ipairs(pending_enemy_spawns) do
        local position = EnemyHelpers.offset_position_with_direction(
            pending.position, pending.direction)
        if EnemyHelpers.can_spawn_on(mission, position.x, position.y, position.z) then
            local enemy = Enemy.from(mission, position, pending.direction, pending.name, {
                scale = pending.source_panel.scale,
                source_panel_type = pending.source_panel.source_type or pending.source_panel.type,
            })
            if enemy then
                -- The override belongs to this source Dark Hole, not to the
                -- enemy template. Different Dark Holes can therefore spawn
                -- the same bot type with different HP values.
                apply_panel_enemy_config(pending.source_panel, enemy)
                assign_dark_hole_bot_encounter(pending.source_panel, enemy)
                apply_dark_hole_minion_health_to_bot(pending.source_panel, enemy)
                pending.source_panel.enemy = enemy
                mission.enemies[#mission.enemies + 1] = enemy
                spawned_panel_enemy_count = spawned_panel_enemy_count + 1
                spawn_log:info_data("Configured panel enemy spawned", {
                    base_area_id = mission.base_area_id,
                    instance_area_id = mission.area_id,
                    source_object_id = pending.source_object_id,
                    source_panel_type = pending.source_panel.source_type or pending.source_panel.type,
                    panel_behavior_type = pending.source_panel.type,
                    requested_bot_scale = pending.source_panel.scale,
                    enemy_name = pending.name,
                    direction = tostring(pending.direction),
                    x = position.x, y = position.y, z = position.z,
                })
            else
                spawn_log:warn_data("Configured panel enemy creation returned nil", {
                    base_area_id = mission.base_area_id,
                    instance_area_id = mission.area_id,
                    source_object_id = pending.source_object_id,
                    enemy_name = pending.name,
                    x = position.x, y = position.y, z = position.z,
                })
            end
        else
            spawn_log:warn_data("Skipping enemy spawn on a non-enemy or occupied panel after panel indexing", {
                base_area_id = mission.base_area_id,
                instance_area_id = mission.area_id,
                enemy_name = pending.name,
                x = position.x, y = position.y, z = position.z,
                source_object_id = pending.source_object_id,
                source_panel_type = pending.source_panel.source_type or pending.source_panel.type,
                    panel_behavior_type = pending.source_panel.type,
                    requested_bot_scale = pending.source_panel.scale,
            })
        end
    end

    spawn_log:info_data("Completed configured panel enemy spawns", {
        base_area_id = mission.base_area_id,
        instance_area_id = mission.area_id,
        configured_spawn_count = #pending_enemy_spawns,
        spawned_count = spawned_panel_enemy_count,
    })

    -- Spawn modes are resolved only after all panel objects have been indexed,
    -- so On Dark Hole Cleared can correctly inspect its full group.
    for _, definition in ipairs(mission.boss_definitions) do
        if definition.spawn_mode == "Immediate" then
            mission:spawn_boss(definition.boss_id, false)
        elseif definition.spawn_mode == "On Dark Hole Cleared" then
            mission:spawn_boss(definition.boss_id, false)
        elseif definition.spawn_mode == "After Boss Defeated" then
            if not definition.trigger_boss_object_id then
                log:warn_data("Boss uses After Boss Defeated without Trigger Boss reference", {
                    boss_id = definition.boss_id,
                    object_id = definition.object_id,
                })
            end
        elseif definition.spawn_mode ~= "Manual" then
            log:warn_data("Unknown boss Spawn Mode; boss will remain dormant", {
                boss_id = definition.boss_id,
                spawn_mode = definition.spawn_mode,
            })
        end
    end

    log:info_data("Created liberation instance", {
        base_area_id = base_area_id,
        base_area_name = mission.area_name,
        instance_area_id = new_area_id,
        player_count = #players,
        target_phase = mission.target_phase,
        desired_player_count = desired_players,
        max_order_points = mission.MAX_ORDER_POINTS,
        honor_hp_mem = mission.honor_hp_mem,
        enemy_count = #mission.enemies,
        dark_hole_count = #mission.dark_holes,
        indestructible_panel_count = #mission.indestructible_panels,
        panel_gate_count = #mission.panel_gates,
        points_of_interest_count = #mission.points_of_interest,
        has_boss = #mission.boss_definitions > 0,
        boss_definition_count = #mission.boss_definitions,
    })

    return mission
end

function Mission:spawn_boss(boss_id, force, triggered)
    local requested_id = tostring(boss_id or "")
    local definition = nil
    for _, candidate in ipairs(self.boss_definitions or {}) do
        if candidate.boss_id == requested_id or tostring(candidate.object_id) == requested_id then
            definition = candidate
            break
        end
    end
    if not definition then
        log:warn_data("Requested boss definition was not found", {
            base_area_id = self.base_area_id,
            instance_area_id = self.area_id,
            boss_id = requested_id,
        })
        return false
    end
    if definition.defeated then return false end
    if definition.spawned then return true end
    if not force and not definition.spawn_enabled then return false end

    local mode = definition.spawn_mode
    if not force and mode == "Manual" then return false end
    if not force and mode == "After Boss Defeated" and not triggered then return false end
    if not force and mode == "On Dark Hole Cleared"
        and count_dark_holes_for_boss(self, definition) > 0 then
        return false
    end

    local position = {
        x = definition.x + definition.offset_x,
        y = definition.y + definition.offset_y,
        z = definition.z + definition.offset_z,
    }
    if not EnemyHelpers.can_spawn_on(self, position.x, position.y, position.z) then
        log:warn_data("Boss spawn deferred because its destination is occupied or invalid", {
            boss_id = definition.boss_id,
            enemy_name = definition.enemy_name,
            x = position.x, y = position.y, z = position.z,
        })
        return false
    end

    local enemy = Enemy.from(self, position, definition.direction, definition.enemy_name, {
        auto_face_player = definition.auto_face_player,
        scale = definition.scale,
        is_boss = true,
    })
    if not enemy then return false end

    enemy.is_boss = true
    enemy.boss_id = definition.boss_id
    enemy.boss_object_id = definition.object_id
    enemy.boss_definition = definition
    if definition.enemy_config then
        EnemyConfig.apply(enemy, definition.enemy_config)
        enemy.configured_max_hp = definition.enemy_config.max_hp ~= nil
        if not enemy.ow_bot_encounter_name then
            enemy.ow_bot_encounter_name = enemy.default_ow_bot_encounter_name
        end
        EnemyHelpers.update_name(enemy)
    end
    if definition.max_health_override > 0 and not enemy.configured_max_hp then
        -- Apply the Tiled override once at spawn. ezencounters consumes the
        -- persistent current HP through data.enemies[index].health and calls
        -- character:set_health() during package_build. max_health remains the
        -- persistent bot's healing/UI cap; ezencounters' max_hp field is not
        -- currently applied by its entry script.
        enemy.health = definition.max_health_override
        enemy.max_health = definition.max_health_override
        EnemyHelpers.update_name(enemy)
    end
    if definition.display_name ~= "" then
        enemy.display_name = definition.display_name
    end
    Net.set_bot_name(enemy.id, tostring(enemy.display_name or enemy.battle_name or enemy.name or definition.enemy_name)
        .. ": " .. tostring(enemy.health or 0))

    definition.spawned = true
    definition.enemy = enemy
    self.bosses[#self.bosses + 1] = definition
    self.boss = enemy -- compatibility alias for existing camera/UI code
    table.insert(self.enemies, 1, enemy)

    log:info_data("Boss spawned", {
        base_area_id = self.base_area_id,
        instance_area_id = self.area_id,
        boss_id = definition.boss_id,
        object_id = definition.object_id,
        enemy_name = definition.enemy_name,
        enemy_template = enemy.template_name,
        spawn_mode = definition.spawn_mode,
        x = position.x, y = position.y, z = position.z,
        health = enemy.health,
        max_health = enemy.max_health,
        health_override = definition.max_health_override,
    })
    return true
end

function Mission:spawn_bosses_for_cleared_dark_holes()
    for _, definition in ipairs(self.boss_definitions or {}) do
        if definition.spawn_mode == "On Dark Hole Cleared"
            and not definition.spawned and not definition.defeated
            and count_dark_holes_for_boss(self, definition) == 0 then
            self:spawn_boss(definition.boss_id, false)
        end
    end
end

function Mission:handle_boss_defeated(enemy)
    if not enemy or not enemy.boss_definition then
        -- Preserve the original single-boss completion behavior for older maps.
        liberate(self)
        return true
    end

    local defeated_definition = enemy.boss_definition
    HPIndicators.remove_enemy(self, enemy)
    defeated_definition.defeated = true
    defeated_definition.enemy = nil
    if Enemy.is_alive(enemy) then Net.remove_bot(enemy.id, false) end
    for index, active_enemy in ipairs(self.enemies) do
        if active_enemy == enemy then
            table.remove(self.enemies, index)
            break
        end
    end

    log:info_data("Boss defeated", {
        base_area_id = self.base_area_id,
        instance_area_id = self.area_id,
        boss_id = defeated_definition.boss_id,
        object_id = defeated_definition.object_id,
    })

    -- Spawn bosses whose Trigger Boss object reference points to the boss just defeated.
    for _, definition in ipairs(self.boss_definitions or {}) do
        if definition.spawn_mode == "After Boss Defeated"
            and not definition.spawned and not definition.defeated
            and tostring(definition.trigger_boss_object_id or "") == tostring(defeated_definition.object_id) then
            self:spawn_boss(definition.boss_id, false, true)
        end
    end

    local all_defeated = #self.boss_definitions > 0
    for _, definition in ipairs(self.boss_definitions) do
        if not definition.defeated then
            all_defeated = false
            break
        end
    end
    if all_defeated then
        liberate(self)
        return true
    else
        self.boss = nil
        for _, definition in ipairs(self.boss_definitions) do
            if definition.spawned and not definition.defeated and definition.enemy then
                self.boss = definition.enemy
                break
            end
        end
        return false
    end
end

function Mission:set_order_points(value)
    local clamped = math.max(0, math.min(math.floor(tonumber(value) or 0), self.MAX_ORDER_POINTS))
    self.order_points = clamped
    for _, gauge in pairs(self.points_gauges) do
        gauge:set_value(clamped)
    end
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
    log:info_data("Cleaning up liberation instance", {
        base_area_id = self.base_area_id,
        instance_area_id = self.area_id,
    })
    for _, gauge in pairs(self.points_gauges) do
        gauge:destroy()
    end
    self.points_gauges = {}
    HPIndicators.destroy(self)
    for _, id in ipairs(Net.list_bots(self.area_id)) do
        Net.remove_bot(id)
    end
    PanelEncounters.clear_mission_encounter_assets(self.area_id)
    Net.remove_area(self.area_id)
    self.resolve_disposal()
    return self.disposal_promise
end

function Mission:cleaning_up()
    return self.needs_disposal
end

function Mission:begin()
    if self.begin_started then
        log:warn_data("Ignoring duplicate liberation mission begin", {
            base_area_id = self.base_area_id,
            instance_area_id = self.area_id,
        })
        return
    end
    self.begin_started = true

    local spawn = self:get_spawn_position()
    local hold_time = .7
    local slide_time = .7
    local total_camera_time = 0
    local start_health = 0
    local player_ids = {}
    for _, player in ipairs(self.players) do
        player_ids[#player_ids + 1] = player.id
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
            PlayerControl.acquire_capture(player.id, "liberation:turn")
            if self.points_of_interest and #self.points_of_interest > 0 then
                -- CameraSequence.play returns the full duration of its
                -- movement/hold sequence. Include it so input is not
                -- unlocked before the camera has returned to the spawn.
                total_camera_time = total_camera_time + CameraSequence.play(self, player, spawn)
            else
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

    -- Create viewer-private HP indicators for players and active enemies.
    HPIndicators.register(self)

    -- Create one order-points gauge per participating player. Each draws to
    -- its own logical ids, so a party of N sees N independent HUDs showing
    -- the same shared value.
    for _, player in ipairs(self.players) do
        local gauge = PointsGauge:new(player.id, self.MAX_ORDER_POINTS)
        gauge:set_value(self.order_points)
        gauge:show()
        self.points_gauges[player.id] = gauge
    end

    log:info_data("Beginning liberation mission", {
        base_area_id = self.base_area_id,
        base_area_name = self.area_name,
        instance_area_id = self.area_id,
        player_ids = player_ids,
        player_count = #self.players,
        start_health = start_health,
        spawn_found = spawn ~= nil,
        order_points = self.order_points,
        max_order_points = self.MAX_ORDER_POINTS,
    })

    if not debug then
        Async.sleep(total_camera_time).and_then(function()
            for _, player in ipairs(self.players) do
                PlayerControl.release_capture(player.id, "liberation:turn")
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
    PlayerControl.acquire_capture(player_id, "liberation:turn")
    local quiz_promise = player_session.player:select_mission_option({ "Pass", "Cancel" }, "Panel interaction")
    quiz_promise.and_then(function(response)
        if response == 0 then
            player_session:get_pass_turn_permission()
        elseif response == 1 then
            PlayerControl.release_capture(player_id, "liberation:turn")
        else
            -- A failed/interrupted menu must not leave the player movement-locked.
            if Net.is_player(player_id) then
                PlayerControl.release_capture(player_id, "liberation:turn")
            end
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
        log:warn_data("Object interaction: object missing", {
            base_area_id = self.base_area_id,
            instance_area_id = self.area_id,
            player_id = player_id,
            object_id = object_id,
        })
        return
    end
    if not is_adjacent(player_session.player, object) then
        log:debug_data("Object interaction rejected: not adjacent", {
            base_area_id = self.base_area_id,
            player_id = player_id,
            object_id = object_id,
        })
        return
    end
    local panel = self:get_panel_at(object.x, object.y, object.z)
    if not panel then
        log:debug_data("Object interaction: no panel at object position", {
            base_area_id = self.base_area_id,
            player_id = player_id,
            object_id = object_id,
        })
        return
    end
    PlayerControl.acquire_capture(player_id, "liberation:turn")
    local panel_already_selected = false
    for _, ps in pairs(self.player_sessions) do
        if ps.selection.root_panel == panel then
            panel_already_selected = true
            break
        end
    end
    local can_liberate = not panel_already_selected and PanelRegistry.is_liberatable(panel.visual_gid)
    if not can_liberate then
        local quiz_promise = player_session.player:select_mission_option({ "Pass", "Cancel" }, "Panel interaction")
        quiz_promise.and_then(function(response)
            if response == 0 then
                player_session:get_pass_turn_permission()
            elseif response == 1 then
                PlayerControl.release_capture(player_id, "liberation:turn")
            else
                if Net.is_player(player_id) then
                    PlayerControl.release_capture(player_id, "liberation:turn")
                end
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
        local quiz_promise = player_session.player:select_mission_option({ "Liberation", "Pass", "Cancel" }, "Panel interaction")
        quiz_promise.and_then(function(response)
            if response == 0 then
                liberate_panel(self, player_session)
            elseif response == 1 then
                player_session.selection:clear()
                player_session:get_pass_turn_permission()
            elseif response == 2 then
                player_session.selection:clear()
                PlayerControl.release_capture(player_id, "liberation:turn")
            else
                player_session.selection:clear()
                if Net.is_player(player_id) then
                    PlayerControl.release_capture(player_id, "liberation:turn")
                end
            end
        end)
        return
    end
    player_session.selection:select_panel(panel)
    local quiz_promise = player_session.player:select_mission_option({ "Liberation", ability.name, "Pass" }, "Panel ability")
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
        else
            player_session.selection:clear()
            if Net.is_player(player_id) then
                PlayerControl.release_capture(player_id, "liberation:turn")
            end
        end
    end)
end

function Mission:handle_player_avatar_change(player_id)
    local player = self.player_sessions[player_id].player
    log:info_data("Player avatar changed, booting to lobby", {
        base_area_id = self.base_area_id,
        instance_area_id = self.area_id,
        player_id = player_id,
    })
    player:boot_to_lobby(false, self.area_name)
end

function Mission:handle_player_transfer(player_id)
    if not self.pending_transfer_players or not self.pending_transfer_players[player_id] then
        return
    end

    local current_area_id = Net.get_player_area(player_id)
    if current_area_id ~= self.area_id then
        log:debug_data("Liberation transfer event did not reach target instance", {
            player_id = player_id,
            expected_area_id = self.area_id,
            actual_area_id = current_area_id,
        })
        return
    end

    self.pending_transfer_players[player_id] = nil

    local remaining = 0
    for _ in pairs(self.pending_transfer_players) do
        remaining = remaining + 1
    end

    log:info_data("Liberation player transfer completed", {
        player_id = player_id,
        instance_area_id = self.area_id,
        remaining_transfers = remaining,
    })

    if remaining == 0 then
        log:info_data("All liberation players transferred; beginning mission", {
            base_area_id = self.base_area_id,
            instance_area_id = self.area_id,
            player_count = #self.players,
        })
        self:begin()
    end
end

function Mission:handle_player_disconnect(player_id)
    log:info_data("Player disconnected from liberation", {
        base_area_id = self.base_area_id,
        instance_area_id = self.area_id,
        player_id = player_id,
        remaining_players = #self.players - 1,
    })
    HPIndicators.remove_player(self, player_id)
    if self.points_gauges[player_id] then
        self.points_gauges[player_id]:destroy()
        self.points_gauges[player_id] = nil
    end
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
    if type(x) ~= "number" or type(y) ~= "number" or type(z) ~= "number" then
        return nil
    end
    y = math.floor(y) + 1
    z = math.floor(z) + 1
    local plane = self.panels[z]
    if plane == nil then return nil end
    local row = plane[y]
    if row == nil then return nil end
    x = math.floor(x) + 1
    return row[x]
end

function Mission:remove_panel(panel)
    if not panel or not self.panels then return end
    if type(panel.x) ~= "number" or type(panel.y) ~= "number" or type(panel.z) ~= "number" then
        return
    end
    local y = math.floor(panel.y) + 1
    local z = math.floor(panel.z) + 1
    local plane = self.panels[z]
    if plane == nil then return end
    local row = plane[y]
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