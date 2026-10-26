-- enemy.lua
local ezlogger = require("scripts/ezlibs-scripts/ezlogger")
local log = ezlogger.get("nebulous-liberations")

local EnemyTemplates = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_templates")
local ExplodingEffect = require("scripts/ezlibs-custom/nebulous-liberations/utils/exploding_effect")

local Enemy = {}

function Enemy.from(instance, position, direction, name)
    -- `name` is the registered enemy-template key. The template stores its
    -- display name in `battle_name`; it does not necessarily define `enemy.name`.
    local enemy = EnemyTemplates.create(instance, position, direction, name)
    local display_name = enemy.battle_name or enemy.name or name or "Enemy"
    Net.set_bot_name(enemy.id, tostring(display_name) .. ": " .. tostring(enemy.health or 0))
    return enemy
end

function Enemy.is_alive(enemy)
    if not enemy or enemy.id == nil then return false end
    local ok, result = pcall(Net.is_bot, enemy.id)
    if not ok then
        log:warn_data("Net.is_bot raised during is_alive check", {
            enemy_id = tostring(enemy.id),
            enemy_name = enemy.battle_name,
            error = tostring(result),
        })
        return false
    end
    return result
end

function Enemy.destroy(instance, enemy)
    if not enemy then
        return Async.create_promise(function(resolve) resolve() end)
    end
    if not Enemy.is_alive(enemy) then
        return Async.create_promise(function(resolve) resolve() end)
    end
    for i, stored_enemy in pairs(instance.enemies) do
        if enemy == stored_enemy then
            table.remove(instance.enemies, i)
            break
        end
    end
    local co = coroutine.create(function()
        -- ExplodingEffect:new can return nil if the effect bot fails to spawn
        -- (e.g. asset not loaded on this instance, engine bot table full).
        -- Guard the effect so the rest of the destroy animation and, more
        -- importantly, the caller's turn completion still run.
        local explosions = ExplodingEffect:new(enemy.id)
        if not explosions then
            log:warn_data("ExplodingEffect:new returned nil; skipping explosion", {
                base_area_id = instance and instance.base_area_id,
                instance_area_id = instance and instance.area_id,
                enemy_name = enemy.battle_name,
                enemy_id = tostring(enemy.id),
            })
        end
        local slide_time = .2
        local hold_time = 3
        local extra_explosion_time = .5
        local lock_tracker = {}
        for _, player in ipairs(instance.players) do
            lock_tracker[player.id] = Net.is_player_input_locked(player.id)
            Net.lock_player_input(player.id)
            Net.slide_player_camera(player.id, enemy.x + .5, enemy.y + .5, enemy.z, slide_time)
            Net.move_player_camera(player.id, enemy.x + .5, enemy.y + .5, enemy.z, hold_time)
            Net.slide_player_camera(player.id, player.x, player.y, player.z, slide_time)
            Net.unlock_player_camera(player.id)
        end
        Async.await(Async.sleep(slide_time))
        local message = enemy:get_death_message()
        local texture_path = enemy.mug and enemy.mug.texture_path
        local animation_path = enemy.mug and enemy.mug.animation_path
        if message then
            for _, player in ipairs(instance.players) do
                player:message(message, texture_path, animation_path)
            end
        end
        Async.await(Async.sleep(hold_time - extra_explosion_time))
        Net.remove_bot(enemy.id)
        Async.await(Async.sleep(extra_explosion_time))
        if explosions and type(explosions.remove) == "function" then
            explosions:remove()
        end
        local unlock_padding = .3
        Async.await(Async.sleep(slide_time + unlock_padding))
        for _, player in ipairs(instance.players) do
            if not lock_tracker[player.id] then
                Net.unlock_player_input(player.id)
            end
        end
    end)
    return Async.promisify(co)
end

return Enemy