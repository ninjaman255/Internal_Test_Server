-- enemy_templates.lua
--
-- Enemy behaviour, health, and assets live here. Encounters do NOT live
-- here: they are always resolved from the area's Liberation Encounters
-- custom property via PanelEncounters.resolve_encounter(base_area_id),
-- which routes through ezencounters. Do not add a per-template encounter
-- path — it will be ignored by instance.lua.
local EnemySelection = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection")
local EnemyHelpers = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers")
local GuardInterception = require("scripts/ezlibs-custom/nebulous-liberations/liberations/guard_interception")
local Preloader = require("scripts/ezlibs-custom/nebulous-liberations/liberations/preloader")
local Constants = require("scripts/ezlibs-custom/nebulous-liberations/liberations/constants")
local Direction = require("scripts/libs/direction")

local Logger = require("scripts/ezlibs-custom/nebulous-liberations/liberations/logger")
local spawn_log = Logger.spawning

local EnemyTemplates = {}

-- Register a template
function EnemyTemplates.has(name)
    return type(name) == "string" and type(EnemyTemplates[name]) == "table"
end

function EnemyTemplates.register(name, template)
    EnemyTemplates[name] = template
end

-- Create an enemy instance from a template
function EnemyTemplates.create(instance, position, direction, template_name, spawn_options)
    local template = type(template_name) == "string" and EnemyTemplates[template_name] or nil
    if not template then
        spawn_log:error_data("Cannot create enemy: template missing or unregistered", {
            template_name = tostring(template_name),
            area_id = instance and instance.area_id,
            x = position and position.x, y = position and position.y, z = position and position.z,
        })
        return nil
    end
    local enemy = {
        instance = instance,
        id = nil,
        -- Preserve the ezencounters enemy_packages alias (the key used in
        -- data.enemies[index].name). Display names are not guaranteed to be
        -- identical to that alias, so battle HP must match against this key.
        template_name = template_name,
        battle_name = template.battle_name,
        default_ow_bot_encounter_name = template.default_ow_bot_encounter_name,
        health = template.health,
        max_health = template.max_health,
        -- Preserve the enemy's intended world scale across movement. A
        -- spawn-specific scale overrides the template scale; normal is 1.0.
        -- Resolve the OW scale before deriving the battle scale. A template
        -- battle_scale is an intentional explicit override; otherwise follow OW.
        battle_scale = tonumber(template.battle_scale),
        battle_scale_explicit = tonumber(template.battle_scale) ~= nil,
        battle_scale_scope = template.battle_scale_scope or "Matching",
        scale = tonumber(spawn_options and spawn_options.scale)
            or tonumber(template.scale)
            or 1.0,
        x = math.floor(position.x),
        y = math.floor(position.y),
        z = math.floor(position.z),
        selection = EnemySelection:new(instance),
        mug = template.mug,
        is_boss = (spawn_options and spawn_options.is_boss == true) or template.is_boss or false,
        is_special_encounter = template.is_special_encounter or false,
        ai_type = template.ai_type or "simple_charge",
        ai_params = template.ai_params or {},
        -- These fields are read from `self` at runtime (spawn, attack,
        -- death) and must be copied explicitly; the enemy instance table
        -- does not otherwise inherit from the template.
        texture_path = template.texture_path,
        animation_path = template.animation_path,
        attack_texture = template.attack_texture,
        attack_animation_path = template.attack_animation_path,
        attack_damage = template.attack_damage,
        death_message = template.death_message,
        preload_assets = template.preload_assets,
        auto_face_player = spawn_options == nil or spawn_options.auto_face_player ~= false,
    }
    if enemy.scale <= 0 or enemy.scale ~= enemy.scale
        or enemy.scale == math.huge or enemy.scale == -math.huge then
        enemy.scale = 1.0
    end
    if not enemy.battle_scale or enemy.battle_scale <= 0
        or enemy.battle_scale ~= enemy.battle_scale
        or enemy.battle_scale == math.huge or enemy.battle_scale == -math.huge then
        enemy.battle_scale = enemy.scale
    end
    setmetatable(enemy, EnemyTemplates.metatable)
    EnemyTemplates.metatable.__index = EnemyTemplates.metatable

    -- Set up selection shape
    local shape = template.shape or { {1} }
    local offset_x = template.shape_offset_x or 0
    local offset_y = template.shape_offset_y or -1
    enemy.selection:set_shape(shape, offset_x, offset_y)

    -- Preload assets
    if template.preload_assets then
        for _, asset in ipairs(template.preload_assets) do
            Preloader.add_asset(asset)
        end
    end

    enemy:spawn(direction)
    return enemy
end

-- Metatable with default methods
EnemyTemplates.metatable = {
    spawn = function(self, direction)
        local closest_session = EnemyHelpers.find_closest_player_session(self.instance, self)
        if self.auto_face_player and closest_session and closest_session.player then
            local player = closest_session.player
            direction = Direction.diagonal_from_offset(
                player.x - (self.x + .5),
                player.y - (self.y + .5)
            )
        end

        self.direction = direction
        self.id = Net.create_bot({
            texture_path = self.texture_path,
            animation_path = self.animation_path,
            area_id = self.instance.area_id,
            direction = direction,
            warp_in = false,
            x = self.x + .5,
            y = self.y + .5,
            z = self.z
        })
        local color = self.is_boss and EnemyHelpers.boss_minimap_color or EnemyHelpers.guardian_minimap_marker
        Net.set_bot_minimap_color(self.id, color)
    end,
    get_death_message = function(self)
        return self.death_message or "Gyaaaaahh!!"
    end,
    take_turn = function(self)
        -- Use the AI type to determine behaviour
        if self.ai_type == "simple_charge" then
            return EnemyTemplates.ai.simple_charge(self)
        elseif self.ai_type == "ranged" then
            return EnemyTemplates.ai.ranged(self)
        elseif self.ai_type == "shockwave_line" then
            return EnemyTemplates.ai.shockwave_line(self)
        else
            return Async.create_promise(function(resolve) resolve() end)
        end
    end,
}
local function sign(a)
  if a < 0 then
    return -1
  end

  return 1
end
-- AI implementations
EnemyTemplates.ai = {}

function EnemyTemplates.ai.simple_charge(self)
    local co = coroutine.create(function()
        local closest_session = EnemyHelpers.find_closest_player_session(self.instance, self)
        if not closest_session then return end
        local player = closest_session.player
        local distance = EnemyHelpers.chebyshev_tile_distance(self, player.x, player.y)
        if distance > 4 then return end

        local xdiff = math.floor(player.x) - self.x
        local ydiff = math.floor(player.y) - self.y

        local function attempt_axis(xstep, ystep, diff)
            return Async.create_promise(function(resolve)
                local step = (xstep ~= 0 and sign(xdiff)) or (ystep ~= 0 and sign(ydiff)) or 0
                local limit = math.min(math.abs(diff), 2)
                local offset = 0
                for i = limit, 1, -1 do
                    if EnemyHelpers.can_move_to(self.instance, self.x + xstep * i, self.y + ystep * i, self.z, self) then
                        offset = i
                        break
                    end
                end
                if offset == 0 then
                    resolve(false)
                    return
                end
                local targetx = self.x + xstep * offset
                local targety = self.y + ystep * offset
                EnemyHelpers.face_position(self, targetx + .5, targety + .5)
                local target_direction = Direction.diagonal_from_offset(player.x - (targetx + .5), player.y - (targety + .5))
                EnemyHelpers.move(self.instance, self, targetx, targety, self.z, target_direction).and_then(function()
                    resolve(true)
                end)
            end)
        end

        if (ydiff == 0 or math.abs(xdiff) < math.abs(ydiff)) and xdiff ~= 0 then
            if not Async.await(attempt_axis(xdiff > 0 and 1 or -1, 0, xdiff)) then
                Async.await(attempt_axis(0, ydiff > 0 and 1 or -1, ydiff))
            end
        elseif ydiff ~= 0 then
            if not Async.await(attempt_axis(0, ydiff > 0 and 1 or -1, ydiff)) then
                Async.await(attempt_axis(xdiff > 0 and 1 or -1, 0, xdiff))
            end
        end

        self.selection:move(self, Net.get_bot_direction(self.id))
        local caught_sessions = self.selection:detect_player_sessions()
        if #caught_sessions > 0 then
            local closest = EnemyHelpers.find_closest_player_session(self.instance, self)
            EnemyHelpers.face_position(self, closest.player.x, closest.player.y)
            self.selection:indicate()
            Async.await(Async.sleep(1))
            local attack_records = GuardInterception.prepare_attack(self.instance, self, caught_sessions, 0.5)
            EnemyHelpers.play_attack_animation(self)
            local spawned_bots = {}
            for _, record in ipairs(attack_records) do
                local position = record.visual_position
                if position then
                local bot_id = Net.create_bot({
                    texture_path = self.attack_texture or "/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/beast breath.png",
                    animation_path = self.attack_animation_path or "/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/beast breath.animation",
                    animation = "ANIMATE",
                    area_id = self.instance.area_id,
                    warp_in = false,
                    x = position.x + 1/32,
                    y = position.y + 1/32,
                    z = position.z
                })
                table.insert(spawned_bots, bot_id)
                end
            end
            Async.await(Async.sleep(.5))
            for _, player in ipairs(self.instance.players) do
                Net.shake_player_camera(player.id, 2, .5)
            end
            GuardInterception.apply_damage(attack_records, self.attack_damage or 20, self)
            GuardInterception.finish_attack(self.instance, attack_records)
            Async.await(Async.sleep(.5))
            for _, bot_id in ipairs(spawned_bots) do
                Net.remove_bot(bot_id, false)
            end
            Async.await(Async.sleep(1))
            self.selection:remove_indicators()
        end
    end)
    return Async.promisify(co)
end

function EnemyTemplates.ai.ranged(self)
    -- placeholder
    return Async.create_promise(function(resolve) resolve() end)
end

-- Register default templates from their own modules
require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/template_bigbrute")(EnemyTemplates)
require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/template_blizzardman")(EnemyTemplates)
require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/template_shademan")(EnemyTemplates)






-- Register the Mettaur template and its unique overworld shockwave AI.
-- Keep enemy-specific behaviors in enemies/ rather than in this shared registry.
require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/mettaur")(EnemyTemplates)

return EnemyTemplates