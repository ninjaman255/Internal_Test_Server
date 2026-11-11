-- Current-HP digits for Liberation mission participants and enemies.
-- Each viewer gets private world map-element bots for other players and
-- enemies. A viewer never receives an HP indicator for their own player.
-- Enemy/boss indicators use the enemy bot origin (enemy.x, enemy.y) and hide
-- during tile movement.

local NetGames = require("scripts/net-games/main")

local HPIndicators = {}

local FONT_TEXTURE = "/server/assets/net-games/fonts/fonts_compressed.png"
local FONT_ANIMATION = "/server/assets/net-games/fonts/fonts_compressed.animation"
local DIGIT_WIDTH = 6
local DIGIT_HEIGHT = 10
local ACTOR_Z_LIFT = 3
local instances_by_area = {}
local instances_by_enemy = setmetatable({}, { __mode = "k" })
local instances_by_player = {}

local function safe_id(value)
    return tostring(value):gsub("[^%w_-]", "_")
end

local function map_offset(horizontal_offset, vertical_offset, z_lift)
    -- Lift the indicator in Z while compensating X/Y so the projected screen
    -- position stays anchored to the actor's feet. This matches the projection
    -- used by Net Games' cosmetic world-bot implementation.
    local z_correction = (tonumber(z_lift) or 0) / 2
    local x = ((2 * -vertical_offset + horizontal_offset) / 64) + z_correction
    local y = ((2 * -vertical_offset - horizontal_offset) / 64) + z_correction
    return x, y
end

local function round_fraction(value, denominator)
    local int_part = math.floor(value)
    local decimal = value - int_part
    local n = math.floor(decimal * denominator + 0.5)
    return int_part, n / denominator
end

local function fix_offsets(x, y)
    local x_int, x_dec = round_fraction(x, 32)
    local y_int, y_dec = round_fraction(y, 32)
    local diff = math.abs(x_dec - y_dec)
    if diff < 1 then
        local diff_adj = math.floor(diff * 16 + 0.5) / 16
        if x_dec >= y_dec then
            y_dec = x_dec - diff_adj
        else
            y_dec = x_dec + diff_adj
        end
        if y_dec < 0 then y_dec = 0 end
        if y_dec >= 1 then y_dec = 1 - (1 / 32) end
    end
    return x_int + x_dec, y_int + y_dec
end

local function target_key(target_type, target_id)
    return target_type .. "_" .. safe_id(target_id)
end

local function get_target_position(target)
    local position = target.position or {}
    return tonumber(position.x) or 0,
        tonumber(position.y) or 0,
        tonumber(position.z) or 0
end

local function get_digit_layout(hp, index, digit_count)
    local hp_text = tostring(math.max(0, math.floor(tonumber(hp) or 0)))
    local text_width = digit_count * DIGIT_WIDTH
    local horizontal_offset = -text_width / 2 + ((index - 1) * DIGIT_WIDTH)
    return hp_text:sub(index, index), horizontal_offset
end

local function get_digit_position(target, index, digit_count)
    local x, y, z = get_target_position(target)
    local _, horizontal_offset = get_digit_layout(target.hp, index, digit_count)
    local offset_x, offset_y = map_offset(horizontal_offset, DIGIT_HEIGHT, ACTOR_Z_LIFT)
    offset_x, offset_y = fix_offsets(offset_x, offset_y)
    return x + offset_x, y + offset_y, z + ACTOR_Z_LIFT
end

local function remove_viewer_digits(viewer_id, target)
    local names = target.elements and target.elements[viewer_id]
    if not names then return end
    for _, name in ipairs(names) do
        pcall(NetGames.remove_map_element, name, viewer_id)
    end
    target.elements[viewer_id] = nil
end

local function render_player_for_viewer(state, viewer_id, target)
    -- Every viewer gets their own private world-space copy of this player's
    -- HP digits. This avoids asynchronous cosmetic-bot recreation and keeps
    -- each viewer's copy anchored to the same authoritative player position.
    remove_viewer_digits(viewer_id, target)

    local hp_text = tostring(math.max(0, math.floor(tonumber(target.hp) or 0)))
    local names = {}
    target.elements[viewer_id] = names

    for index = 1, #hp_text do
        local digit = hp_text:sub(index, index)
        local name = "libhp_player_" .. target.key .. "_" .. tostring(index)
        local x, y, z = get_digit_position(target, index, #hp_text)
        local ok, err = pcall(
            NetGames.add_map_element,
            name,
            viewer_id,
            FONT_TEXTURE,
            FONT_ANIMATION,
            "THICK_" .. digit,
            x, y, z,
            true
        )
        if ok then
            names[#names + 1] = name
            -- Enforce viewer-only visibility even if the online-player cache
            -- has not yet caught up with the current mission participants.
            local bot_id = tostring(viewer_id) .. "-map-" .. name
            for other_viewer_id in pairs(state.viewers) do
                if other_viewer_id ~= viewer_id then
                    pcall(Net.exclude_actor_for_player, other_viewer_id, bot_id)
                end
            end
        else
            print("[Liberations] Player HP indicator create failed for "
                .. tostring(name) .. ": " .. tostring(err))
        end
    end
end

local function render_enemy_for_viewer(state, viewer_id, target)
    remove_viewer_digits(viewer_id, target)
    local hp_text = tostring(math.max(0, math.floor(tonumber(target.hp) or 0)))
    local names = {}
    target.elements[viewer_id] = names

    for index = 1, #hp_text do
        local digit = hp_text:sub(index, index)
        local name = "libhp_" .. target.key .. "_" .. tostring(index)
        local x, y, z = get_digit_position(target, index, #hp_text)
        local ok, err = pcall(
            NetGames.add_map_element,
            name,
            viewer_id,
            FONT_TEXTURE,
            FONT_ANIMATION,
            "THICK_" .. digit,
            x, y, z,
            true
        )
        if ok then
            names[#names + 1] = name
            -- Keep each viewer's copy private even if Net Games' online-player
            -- cache has not yet caught up with the mission participant list.
            local bot_id = tostring(viewer_id) .. "-map-" .. name
            for other_viewer_id in pairs(state.viewers) do
                if other_viewer_id ~= viewer_id then
                    pcall(Net.exclude_actor_for_player, other_viewer_id, bot_id)
                end
            end
        else
            print("[Liberations] Enemy HP indicator create failed for "
                .. tostring(name) .. ": " .. tostring(err))
        end
    end
end

local function render_target(state, target)
    if target.type == "enemy" and target.hidden then
        for viewer_id in pairs(state.viewers) do
            remove_viewer_digits(viewer_id, target)
        end
        return
    end
    if target.type == "player" then
        for viewer_id in pairs(state.viewers) do
            -- HP is only useful for teammates. Never render the local player's
            -- own HP indicator on their client.
            if viewer_id ~= target.id then
                render_player_for_viewer(state, viewer_id, target)
            else
                remove_viewer_digits(viewer_id, target)
            end
        end
        return
    end
    for viewer_id in pairs(state.viewers) do
        render_enemy_for_viewer(state, viewer_id, target)
    end
end

local function add_target(instance, target_type, target_id, hp, position)
    local state = instance and instance.hp_indicator_state
    if not state then return end

    local key = target_key(target_type, target_id)
    local target = state.targets[key]
    if not target then
        target = {
            key = key,
            type = target_type,
            id = target_id,
            hp = math.max(0, math.floor(tonumber(hp) or 0)),
            position = position or { x = 0, y = 0, z = 0 },
            elements = {},
            hidden = false,
        }
        state.targets[key] = target
    else
        target.hp = math.max(0, math.floor(tonumber(hp) or target.hp or 0))
        if position then target.position = position end
    end
    render_target(state, target)
end

function HPIndicators.register(instance)
    if not instance or not instance.area_id then return end
    if instance.hp_indicator_state then
        HPIndicators.destroy(instance)
    end

    local state = { instance = instance, viewers = {}, targets = {} }
    instance.hp_indicator_state = state
    instances_by_area[instance.area_id] = instance

    for _, player in ipairs(instance.players or {}) do
        state.viewers[player.id] = true
        instances_by_player[player.id] = instance
        pcall(Net.provide_asset_for_player, player.id, FONT_TEXTURE)
        pcall(Net.provide_asset_for_player, player.id, FONT_ANIMATION)
    end

    for _, player in ipairs(instance.players or {}) do
        local position
        local ok, result = pcall(Net.get_player_position, player.id)
        if ok and type(result) == "table" then
            position = { x = result.x, y = result.y, z = result.z }
        else
            position = { x = player.x, y = player.y, z = player.z }
        end
        local session = instance.player_sessions and instance.player_sessions[player.id]
        add_target(instance, "player", player.id, session and session.health or 0, position)
    end

    for _, enemy in ipairs(instance.enemies or {}) do
        HPIndicators.add_enemy(instance, enemy)
    end
end

function HPIndicators.add_enemy(instance, enemy)
    if not instance or not enemy or not instance.hp_indicator_state then return end
    instances_by_enemy[enemy] = instance
    add_target(instance, "enemy", enemy.id, enemy.health, {
        -- Enemy bot placement uses enemy.x + 0.5 / enemy.y + 0.5, but the
        -- requested HP anchor is the bot's world origin, not tile center.
        x = (tonumber(enemy.x) or 0) + 0.5,
        y = (tonumber(enemy.y) or 0) + 0.6,
        z = tonumber(enemy.z) or 0,
    })
    local target = instance.hp_indicator_state.targets[target_key("enemy", enemy.id)]
    if target then target.object = enemy end
end

function HPIndicators.update_enemy_hp_for_enemy(enemy)
    local instance = enemy and instances_by_enemy[enemy]
    if instance then
        HPIndicators.update_enemy_hp(instance, enemy)
    end
end

function HPIndicators.update_player_hp(instance, player_id, hp)
    local state = instance and instance.hp_indicator_state
    local target = state and state.targets[target_key("player", player_id)]
    if not target then return end
    local value = math.max(0, math.floor(tonumber(hp) or 0))
    if target.hp == value then return end
    target.hp = value
    render_target(state, target)
end

function HPIndicators.update_enemy_hp(instance, enemy)
    local state = instance and instance.hp_indicator_state
    if not state or not enemy then return end
    local target = state.targets[target_key("enemy", enemy.id)]
    if not target then
        HPIndicators.add_enemy(instance, enemy)
        return
    end
    local value = math.max(0, math.floor(tonumber(enemy.health) or 0))
    if target.hp == value then return end
    target.hp = value
    render_target(state, target)
end

function HPIndicators.hide_enemy(instance, enemy)
    local state = instance and instance.hp_indicator_state
    local target = state and enemy and state.targets[target_key("enemy", enemy.id)]
    if not target or target.hidden then return end
    target.hidden = true
    for viewer_id in pairs(state.viewers) do
        remove_viewer_digits(viewer_id, target)
    end
end

function HPIndicators.show_enemy(instance, enemy)
    local state = instance and instance.hp_indicator_state
    local target = state and enemy and state.targets[target_key("enemy", enemy.id)]
    if not target then return end
    target.position = {
        x = (tonumber(enemy.x) or 0) + 0.5,
        y = (tonumber(enemy.y) or 0) + 0.6,
        z = tonumber(enemy.z) or 0,
    }
    target.hidden = false
    render_target(state, target)
end

function HPIndicators.update_enemy_position(instance, enemy)
    local state = instance and instance.hp_indicator_state
    local target = state and enemy and state.targets[target_key("enemy", enemy.id)]
    if not target then return end
    target.position = {
        x = (tonumber(enemy.x) or 0) + 0.5,
        y = (tonumber(enemy.y) or 0) + 0.6,
        z = tonumber(enemy.z) or 0,
    }
    if target.hidden then return end
    for viewer_id, names in pairs(target.elements) do
        for index, name in ipairs(names) do
            local x, y, z = get_digit_position(target, index, #names)
            pcall(NetGames.move_map_element, name, viewer_id, x, y, z)
        end
    end
end

function HPIndicators.remove_enemy(instance, enemy)
    local state = instance and instance.hp_indicator_state
    if not state or not enemy then return end
    local key = target_key("enemy", enemy.id)
    local target = state.targets[key]
    if not target then return end
    for viewer_id in pairs(state.viewers) do
        remove_viewer_digits(viewer_id, target)
    end
    instances_by_enemy[enemy] = nil
    state.targets[key] = nil
end

function HPIndicators.remove_player(instance, player_id)
    local state = instance and instance.hp_indicator_state
    if not state then return end
    local key = target_key("player", player_id)
    local target = state.targets[key]
    if target then
        for viewer_id in pairs(state.viewers) do
            remove_viewer_digits(viewer_id, target)
        end
        state.targets[key] = nil
    end

    -- Remove this viewer's private copies of every remaining target,
    -- including other players' HP digits.
    for _, other_target in pairs(state.targets) do
        remove_viewer_digits(player_id, other_target)
    end
    state.viewers[player_id] = nil
    if instances_by_player[player_id] == instance then
        instances_by_player[player_id] = nil
    end
end

function HPIndicators.destroy(instance)
    local state = instance and instance.hp_indicator_state
    if not state then return end
    for _, target in pairs(state.targets) do
        if target.type == "player" then
            for viewer_id in pairs(state.viewers) do
                remove_viewer_digits(viewer_id, target)
            end
        else
            for viewer_id in pairs(state.viewers) do
                remove_viewer_digits(viewer_id, target)
            end
            if target.object then instances_by_enemy[target.object] = nil end
        end
    end
    instances_by_area[instance.area_id] = nil
    for player_id in pairs(state.viewers) do
        if instances_by_player[player_id] == instance then
            instances_by_player[player_id] = nil
        end
    end
    instance.hp_indicator_state = nil
end

-- Move every viewer's private HP bots with the player's authoritative position.
Net:on("player_move", function(event)
    local instance = instances_by_player[event.player_id]
    local state = instance and instance.hp_indicator_state
    local target = state and state.targets[target_key("player", event.player_id)]
    if not target then return end

    target.position = {
        x = tonumber(event.x) or target.position.x or 0,
        y = tonumber(event.y) or target.position.y or 0,
        z = tonumber(event.z) or target.position.z or 0,
    }

    for viewer_id in pairs(state.viewers) do
        local names = target.elements and target.elements[viewer_id]
        if names then
            for index, name in ipairs(names) do
                local x, y, z = get_digit_position(target, index, #names)
                pcall(NetGames.move_map_element, name, viewer_id, x, y, z)
            end
        end
    end
end)

Net:on("player_area_transfer", function(event)
    local instance = instances_by_player[event.player_id]
    local state = instance and instance.hp_indicator_state
    local target = state and state.targets[target_key("player", event.player_id)]
    if not target then return end

    local ok, position = pcall(Net.get_player_position, event.player_id)
    if ok and type(position) == "table" then
        target.position = {
            x = tonumber(position.x) or target.position.x or 0,
            y = tonumber(position.y) or target.position.y or 0,
            z = tonumber(position.z) or target.position.z or 0,
        }
        for viewer_id in pairs(state.viewers) do
            local names = target.elements and target.elements[viewer_id]
            if names then
                for index, name in ipairs(names) do
                    local x, y, z = get_digit_position(target, index, #names)
                    pcall(NetGames.move_map_element, name, viewer_id, x, y, z)
                end
            end
        end
    end
end)

return HPIndicators
