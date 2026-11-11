local PlayerControl = require("scripts/player-control/main")
-- enemy.lua
local SharedLogger = require("scripts/logger/logger")
local log = SharedLogger.register("nebulous-liberations"):register_subsystem("enemy")

local EnemyTemplates = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_templates")
local ExplodingEffect = require("scripts/ezlibs-custom/nebulous-liberations/utils/exploding_effect")
local HPIndicators = require("scripts/ezlibs-custom/nebulous-liberations/liberations/hp_indicators")

local Enemy = {}

local function apply_bot_scale_after_spawn(enemy, requested_scale)
    if not enemy or enemy.id == nil then return end
    if type(requested_scale) ~= "number" or requested_scale <= 0
        or requested_scale ~= requested_scale or requested_scale == math.huge then
        return
    end

    -- Match the exact keyframe format used by ezpress.lua and the existing
    -- net-games bot scaling code. Do not call Net.set_bot_scale first: this
    -- project applies bot ScaleX/ScaleY through Net.animate_bot_properties.
    if type(Net.animate_bot_properties) ~= "function" then
        log:warn_data("Cannot apply overworld enemy bot scale: Net.animate_bot_properties is unavailable", {
            enemy_id = tostring(enemy.id),
            scale = requested_scale,
        })
        return
    end

    -- Net.create_bot returns the ID before the newly-created bot is always
    -- ready to receive property animation. Defer the animation until after
    -- creation has completed, then verify the bot exists. Retry briefly in
    -- case the engine has not registered it on the first check.
    local co = coroutine.create(function()
        for attempt = 1, 3 do
            Async.await(Async.sleep(0.1))

            local exists_ok, exists = pcall(Net.is_bot, enemy.id)
            if exists_ok and exists then
                local keyframes = {{
                    properties = {
                        { property = "ScaleX", value = requested_scale, ease = "Linear" },
                        { property = "ScaleY", value = requested_scale, ease = "Linear" },
                    },
                    duration = 0,
                }}

                local ok, result = pcall(
                    Net.animate_bot_properties,
                    enemy.id,
                    keyframes
                )

                if ok and result ~= false then
                    log:info_data("Applied overworld enemy bot scale after creation", {
                        enemy_id = tostring(enemy.id),
                        enemy_name = tostring(enemy.battle_name or enemy.name or "Enemy"),
                        scale = requested_scale,
                        attempt = attempt,
                    })
                    return
                end

                log:warn_data("Bot scale animation failed after bot creation", {
                    enemy_id = tostring(enemy.id),
                    scale = requested_scale,
                    attempt = attempt,
                    error = tostring(result),
                })
            else
                log:debug_data("Waiting for newly-created enemy bot before applying scale", {
                    enemy_id = tostring(enemy.id),
                    scale = requested_scale,
                    attempt = attempt,
                    exists_check_ok = exists_ok,
                    exists = exists,
                })
            end
        end

        log:warn_data("Could not apply overworld enemy bot scale after creation", {
            enemy_id = tostring(enemy.id),
            scale = requested_scale,
        })
    end)

    local promise = Async.promisify(co)
    promise:and_then(nil, function(err)
        log:error_data("Enemy bot scale task failed", {
            enemy_id = tostring(enemy.id),
            scale = requested_scale,
            error = tostring(err),
        })
    end)
end

function Enemy.from(instance, position, direction, name, spawn_options)
    -- `name` is the registered enemy-template key. The template stores its
    -- display name in `battle_name`; it does not necessarily define `enemy.name`.
    local enemy = EnemyTemplates.create(instance, position, direction, name, spawn_options)
    local display_name = enemy.battle_name or enemy.name or name or "Enemy"
    Net.set_bot_name(enemy.id, tostring(display_name) .. ": " .. tostring(enemy.health or 0))

    local requested_scale = spawn_options and tonumber(spawn_options.scale)
    if requested_scale then
        apply_bot_scale_after_spawn(enemy, requested_scale)
    end

    HPIndicators.add_enemy(instance, enemy)
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
    HPIndicators.remove_enemy(instance, enemy)
    -- Remove stale world-state records even if the engine already removed the
    -- bot. Otherwise occupancy and enemy-turn processing still see this bot.
    for i, stored_enemy in ipairs(instance.enemies or {}) do
        if enemy == stored_enemy then
            table.remove(instance.enemies, i)
            break
        end
    end
    if not Enemy.is_alive(enemy) then
        return Async.create_promise(function(resolve) resolve() end)
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
        for _, player in ipairs(instance.players) do
            PlayerControl.acquire_capture(player.id, "liberation:enemy")
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
            PlayerControl.release_capture(player.id, "liberation:enemy")
        end
    end)
    return Async.promisify(co)
end

return Enemy