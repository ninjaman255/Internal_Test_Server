-- enemy_templates.lua
--
-- Enemy behaviour, health, and assets live here. Encounters do NOT live
-- here: they are always resolved from the area's Liberation Encounters
-- custom property via PanelEncounters.resolve_encounter(base_area_id),
-- which routes through ezencounters. Do not add a per-template encounter
-- path — it will be ignored by instance.lua.
local EnemySelection = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection")
local EnemyHelpers = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers")
local Preloader = require("scripts/ezlibs-custom/nebulous-liberations/liberations/preloader")
local Constants = require("scripts/ezlibs-custom/nebulous-liberations/liberations/constants")
local Direction = require("scripts/libs/direction")

local EnemyTemplates = {}

-- Register a template
function EnemyTemplates.register(name, template)
    EnemyTemplates[name] = template
end

-- Create an enemy instance from a template
function EnemyTemplates.create(instance, position, direction, template_name)
    local template = EnemyTemplates[template_name]
    if not template then
        error("Unknown enemy template: " .. template_name)
    end
    local enemy = {
        instance = instance,
        id = nil,
        battle_name = template.battle_name,
        health = template.health,
        max_health = template.max_health,
        x = math.floor(position.x),
        y = math.floor(position.y),
        z = math.floor(position.z),
        selection = EnemySelection:new(instance),
        mug = template.mug,
        is_boss = template.is_boss or false,
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
    }
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
                    if EnemyHelpers.can_move_to(self.instance, self.x + xstep * i, self.y + ystep * i, self.z) then
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
            EnemyHelpers.play_attack_animation(self)
            local spawned_bots = {}
            for _, player_session in ipairs(caught_sessions) do
                local player = player_session.player
                local bot_id = Net.create_bot({
                    texture_path = self.attack_texture or "/server/assets/NebuLibsAssets/bots/beast breath.png",
                    animation_path = self.attack_animation_path or "/server/assets/NebuLibsAssets/bots/beast breath.animation",
                    animation = "ANIMATE",
                    area_id = self.instance.area_id,
                    warp_in = false,
                    x = player.x + 1/32,
                    y = player.y + 1/32,
                    z = player.z
                })
                table.insert(spawned_bots, bot_id)
            end
            Async.await(Async.sleep(.5))
            for _, player in ipairs(self.instance.players) do
                Net.shake_player_camera(player.id, 2, .5)
            end
            for _, player_session in ipairs(caught_sessions) do
                player_session:hurt(self.attack_damage or 20)
            end
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

-- Register default templates
EnemyTemplates.register("BigBrute", {
    battle_name = "BigBrute",
    health = 120,
    max_health = 120,
    texture_path = "/server/assets/NebuLibsAssets/bots/bigbrute.png",
    animation_path = "/server/assets/NebuLibsAssets/bots/bigbrute.animation",
    shape = { {1,1,1}, {1,0,1}, {1,1,1} },
    shape_offset_x = 0,
    shape_offset_y = -2,
    attack_damage = 20,
    attack_texture = "/server/assets/NebuLibsAssets/bots/beast breath.png",
    attack_animation_path = "/server/assets/NebuLibsAssets/bots/beast breath.animation",
    ai_type = "simple_charge",
    is_special_encounter = true,
    preload_assets = { "/server/assets/NebuLibsAssets/bots/bigbrute.animation","/server/assets/NebuLibsAssets/bots/beast breath.png", "/server/assets/NebuLibsAssets/bots/beast breath.animation","/server/assets/NebuLibsAssets/bots/bigbrute.png", },
})

EnemyTemplates.register("BlizzardMan", {
    battle_name = "BlizzardMan",
    health = 400,
    max_health = 400,
    texture_path = "/server/assets/NebuLibsAssets/bots/blizzardman.png",
    animation_path = "/server/assets/NebuLibsAssets/bots/blizzardman.animation",
    shape = { {1,1,1}, {1,0,1}, {1,1,1}, {1,1,1} },
    shape_offset_x = 0,
    shape_offset_y = -2,
    attack_damage = 40,
    attack_texture = "/server/assets/NebuLibsAssets/bots/snowball.png",
    attack_animation_path = "/server/assets/NebuLibsAssets/bots/snowball.animation",
    ai_type = "simple_charge",
    is_boss = true,
    mug = {
        texture_path = "/server/assets/NebuLibsAssets/mugs/blizzardman.png",
        animation_path = "/server/assets/NebuLibsAssets/mugs/blizzardman.animation",
    },
    death_message = "Woosh!\nI can't believe\nit. I can't lose.\nNOOOO!",
    preload_assets = { "/server/assets/NebuLibsAssets/bots/snowball.png", "/server/assets/NebuLibsAssets/bots/snowball.animation" },
})

EnemyTemplates.register("ShadeMan", {
    battle_name = "ShadeMan",
    health = 600,
    max_health = 600,
    texture_path = "/server/assets/NebuLibsAssets/bots/shademan.png",
    animation_path = "/server/assets/NebuLibsAssets/bots/shademan.animation",
    shape = { {1} },
    shape_offset_x = 0,
    shape_offset_y = -1,
    attack_damage = 60,
    ai_type = "ranged",  -- custom AI will be implemented separately
    is_boss = true,
    mug = {
        texture_path = "/server/assets/NebuLibsAssets/mugs/shademan.png",
        animation_path = "/server/assets/NebuLibsAssets/mugs/shademan.animation",
    },
    death_message = "Grr! I can't\nbelieve I've been\ndisgraced again...!\nGyaaaahh!!",
    preload_assets = { "/server/assets/NebuLibsAssets/bots/shademan.animation", "/server/assets/NebuLibsAssets/bots/shademan.png", "/server/assets/NebuLibsAssets/mugs/shademan.png","/server/assets/NebuLibsAssets/mugs/shademan.animation",}
})

return EnemyTemplates