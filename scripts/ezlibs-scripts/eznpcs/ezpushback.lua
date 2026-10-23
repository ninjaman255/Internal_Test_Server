-- ezpushback.lua
-- A Pushback NPC uses the regular eznpcs NPC pipeline, with a moving rectangle
-- trigger that follows its bot. On collision, a temporary bot uses the player's
-- own avatar, plays a movement animation, and carries the player to its endpoint.
--
-- Pushback NPCs may also be produced by an NPC Spawner. The spawner emits
-- `npc_spawned_from_spawner` for each successful spawn; ezpushback listens
-- for events whose template_type is "Pushback NPC" and attaches a bot-scoped
-- moving collision zone to the new bot. Entries created this way are torn
-- down automatically on `bot_removed`.

local logger = require('scripts/ezlibs-scripts/ezlogger').get('ezpushback')
local eztriggers = require('scripts/ezlibs-scripts/eztriggers/eztriggers')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local EzEmitter = require('scripts/ezlibs-scripts/ezemitter')
local object_registry = require('scripts/ezlibs-scripts/object_registry')
local eznpcs = require('scripts/ezlibs-scripts/eznpcs/eznpcs')
local tu = require('scripts/ezlibs-scripts/utils/eztiledutils')

local ezpushback = {}
local entries = {} -- key -> NPC collision entry
local active_by_player = {}
local cooldowns = {}
local bot_counter = 0

local DEFAULT_WIDTH = 1.5
local DEFAULT_HEIGHT = 1.5
local DEFAULT_PUSH_DISTANCE = 1.0
local DEFAULT_PUSH_DURATION = 0.28
local DEFAULT_MOVE_STATE = 'MOVE'
local DEFAULT_COOLDOWN = 0.75

-- Backwards-compatible alias. Semantics identical to the previous local
-- truthy(value, default); single canonical implementation now lives in
-- tiled_utils.
local truthy = tu.is_true

-- Same call contract as before; the value parsing lives in tiled_utils.
local function number_property(props, name, default, min_value)
    local n = tu.get_number_from(props, name, default)
    if min_value and n < min_value then n = min_value end
    return n
end

local function safe_call(fn, ...)
    if type(fn) ~= 'function' then return false, 'API unavailable' end
    return pcall(fn, ...)
end

local function get_area_players(area_id)
    local ok, players = safe_call(Net.list_players, area_id)
    if ok and type(players) == 'table' then return players end
    return {}
end

local function provide_avatar_to_area(area_id, avatar)
    if not avatar then return end
    for _, viewer_id in ipairs(get_area_players(area_id)) do
        if avatar.texture_path then pcall(Net.provide_asset_for_player, viewer_id, avatar.texture_path) end
        if avatar.animation_path then pcall(Net.provide_asset_for_player, viewer_id, avatar.animation_path) end
    end
end

local function set_player_actor_hidden(player_id, area_id, hidden)
    for _, viewer_id in ipairs(get_area_players(area_id)) do
        if hidden then
            pcall(Net.exclude_actor_for_player, viewer_id, player_id)
        else
            pcall(Net.include_actor_for_player, viewer_id, player_id)
        end
    end
end

local function remove_bot(bot_id)
    if bot_id then pcall(Net.remove_bot, bot_id, false) end
end

local function event_for(entry, player_id, extra)
    local event = {
        player_id = player_id,
        area_id = entry.area_id,
        object_id = entry.object_id,
        npc_bot_id = entry.bot_id,
        trigger_id = entry.trigger_id,
    }
    if extra then
        for k, v in pairs(extra) do event[k] = v end
    end
    return event
end

local function emit_entry(entry, name, event)
    if entry.emitter then entry.emitter:emit(name, event) end
    ezbus:emit('ezpushback_' .. name, event)
end

-- --------------------------------------------------------------------------
-- Isometric projection
--
-- The map is a 64x32 isometric diamond. The camera controller moves the
-- camera in map-space coordinates (it writes Net.move_player_camera with
-- values derived from Net.get_player_position), and the player's on-screen
-- motion is the isometric projection of those map-space deltas.
--
-- The camera's eight labelled directions (UpLeft, UpRight, Up, Left, ...) are
-- exactly the eight canonical map-space directions at 45° intervals:
--
--   DownRight: map ( 1,  0)   → screen  26.5° down-right
--   Down:      map ( 0.707,  0.707) → screen  90° down
--   DownLeft:  map ( 0,  1)   → screen 153.5° down-left
--   Left:      map (-0.707,  0.707) → screen 180° left
--   UpLeft:    map (-1,  0)   → screen 206.5° up-left
--   Up:        map (-0.707, -0.707) → screen 270° up
--   UpRight:   map ( 0, -1)   → screen 333.5° up-right
--   Right:     map ( 0.707, -0.707) → screen   0° right
--
-- The pushback vector is computed radially from the NPC toward the player in
-- map space, and then snapped to the nearest of these eight directions so the
-- push always aligns with the camera's isometric vocabulary. This is what
-- "normalize to isometric space" means here: the radial direction is
-- projected and quantized into the same eight canonical directions the
-- camera controller uses, rather than being pushed at an arbitrary angle.
-- --------------------------------------------------------------------------
local ISO_TILE_WIDTH = 64
local ISO_TILE_HEIGHT = 32

local function map_vector_to_screen(dx, dy)
    return (dx - dy) * (ISO_TILE_WIDTH / 2),
           (dx + dy) * (ISO_TILE_HEIGHT / 2)
end

local function screen_vector_to_map(sx, sy)
    return sx / ISO_TILE_WIDTH + sy / ISO_TILE_HEIGHT,
           -sx / ISO_TILE_WIDTH + sy / ISO_TILE_HEIGHT
end

local function atan2(y, x)
    if math.atan2 then return math.atan2(y, x) end
    return math.atan(y, x)
end

local CANONICAL_DIRECTIONS = {
    { name = 'DownRight', x = 1,           y = 0           },
    { name = 'Down',      x = 0.70710678,  y = 0.70710678  },
    { name = 'DownLeft',  x = 0,           y = 1           },
    { name = 'Left',      x = -0.70710678, y = 0.70710678  },
    { name = 'UpLeft',    x = -1,          y = 0           },
    { name = 'Up',        x = -0.70710678, y = -0.70710678 },
    { name = 'UpRight',   x = 0,           y = -1          },
    { name = 'Right',     x = 0.70710678,  y = -0.70710678 },
}

local OPPOSITE_DIRECTION = {
    DownRight = 'UpLeft', Down = 'Up', DownLeft = 'UpRight', Left = 'Right',
    UpLeft = 'DownRight', Up = 'Down', UpRight = 'DownLeft', Right = 'Left',
}

local function snap_to_canonical_map(dx, dy)
    if not dx or not dy or (dx == 0 and dy == 0) then
        return 1, 0, 'DownRight'
    end
    local angle = atan2(dy, dx) * 180 / math.pi
    if angle < 0 then angle = angle + 360 end
    local bucket = math.floor((angle + 22.5) / 45) % 8
    local c = CANONICAL_DIRECTIONS[bucket + 1]
    return c.x, c.y, c.name
end

local function direction_vector(direction)
    direction = tostring(direction or 'Down'):lower():gsub('_', ' '):gsub('-', ' ')
    local sx, sy = 0, 1
    if direction == 'up' then sx, sy = 0, -1
    elseif direction == 'down' then sx, sy = 0, 1
    elseif direction == 'left' then sx, sy = -1, 0
    elseif direction == 'right' then sx, sy = 1, 0
    elseif direction == 'up left' or direction == 'upleft' then sx, sy = -0.89442719, -0.44721360
    elseif direction == 'up right' or direction == 'upright' then sx, sy = 0.89442719, -0.44721360
    elseif direction == 'down left' or direction == 'downleft' then sx, sy = -0.89442719, 0.44721360
    elseif direction == 'down right' or direction == 'downright' then sx, sy = 0.89442719, 0.44721360
    end
    return screen_vector_to_map(sx, sy)
end

local function get_push_vector(entry, player_pos, npc_pos, player_direction)
    local dx = (tonumber(player_pos.x) or 0) - (tonumber(npc_pos.x) or 0)
    local dy = (tonumber(player_pos.y) or 0) - (tonumber(npc_pos.y) or 0)

    local sx, sy = map_vector_to_screen(dx, dy)
    local screen_length = math.sqrt(sx * sx + sy * sy)
    if screen_length < 0.0001 then
        sx, sy = direction_vector(player_direction)
        sx, sy = map_vector_to_screen(sx, sy)
        screen_length = math.sqrt(sx * sx + sy * sy)
        if screen_length > 0.0001 then sx, sy = -sx, -sy end
    end
    if screen_length < 0.0001 then sx, sy, screen_length = 0, 1, 1 end

    sx, sy = sx / screen_length, sy / screen_length
    local map_x, map_y = screen_vector_to_map(sx, sy)
    local map_length = math.sqrt(map_x * map_x + map_y * map_y)
    if map_length < 0.0001 then return 0, 1 end
    return map_x / map_length, map_y / map_length
end

local function calculate_target(entry, player_pos, npc_pos, player_direction)
    local radial_x, radial_y = get_push_vector(entry, player_pos, npc_pos, player_direction)

    local nx, ny, push_name = snap_to_canonical_map(radial_x, radial_y)

    local half_w = math.max(0.05, entry.width / 2)
    local half_h = math.max(0.05, entry.height / 2)
    local edge_x = math.abs(nx) > 0.0001 and (half_w / math.abs(nx)) or math.huge
    local edge_y = math.abs(ny) > 0.0001 and (half_h / math.abs(ny)) or math.huge
    local edge_distance = math.min(edge_x, edge_y)
    local distance = edge_distance + entry.push_distance

    return {
        x = (tonumber(npc_pos.x) or 0) + nx * distance,
        y = (tonumber(npc_pos.y) or 0) + ny * distance,
        z = tonumber(player_pos.z) or tonumber(npc_pos.z) or 0,
        direction = OPPOSITE_DIRECTION[push_name] or 'Down',
    }
end

local function cleanup_push(player_id, state, reason, restore_player)
    if not state or state.cleaned then return end
    state.cleaned = true
    if active_by_player[player_id] == state then active_by_player[player_id] = nil end

    if state.bot_id then remove_bot(state.bot_id) end

    if restore_player and type(Net.is_player) == 'function' and Net.is_player(player_id) then
        if state.area_id then set_player_actor_hidden(player_id, state.area_id, false) end
        if not state.was_input_locked then
            pcall(Net.unlock_player_input, player_id)
        end
    end

    if state.entry then
        emit_entry(state.entry, 'pushback_finished', event_for(state.entry, player_id, {
            reason = reason,
            bot_id = state.bot_id,
            final_position = state.final_position,
        }))
    end
end

local function perform_pushback(entry, player_id)
    if not entry.enabled then return end
    if active_by_player[player_id] then return end
    if not Net.is_player(player_id) then return end
    if Net.get_player_area(player_id) ~= entry.area_id then return end

    local cooldown_key = entry.key .. ':' .. tostring(player_id)
    local now = os.clock()
    if cooldowns[cooldown_key] and (now - cooldowns[cooldown_key]) < entry.cooldown then
        return
    end
    cooldowns[cooldown_key] = now

    local player_pos = Net.get_player_position(player_id)
    local npc_pos = Net.get_bot_position(entry.bot_id)
    if type(player_pos) ~= 'table' or type(npc_pos) ~= 'table' then
        logger:for_player(player_id):warn('[ezpushback] Missing player/NPC position; pushback skipped.')
        return
    end

    local avatar_ok, avatar = safe_call(Net.get_player_avatar, player_id)
    if not avatar_ok or type(avatar) ~= 'table' or not avatar.texture_path or not avatar.animation_path then
        logger:for_player(player_id):warn('[ezpushback] Could not read player avatar; pushback skipped.')
        return
    end

    bot_counter = bot_counter + 1
    local temp_bot_id = 'ezpushback_' .. tostring(player_id) .. '_' .. tostring(os.time()) .. '_' .. tostring(bot_counter)
    local player_direction = Net.get_player_direction(player_id) or 'Down'
    local target = calculate_target(entry, player_pos, npc_pos, player_direction)
    local move_state = entry.move_state
    local state = {
        player_id = player_id,
        area_id = entry.area_id,
        entry = entry,
        bot_id = temp_bot_id,
        start_position = { x = player_pos.x, y = player_pos.y, z = player_pos.z or 0 },
        target_position = target,
        original_direction = player_direction,
        was_input_locked = (type(Net.is_player_input_locked) == 'function' and Net.is_player_input_locked(player_id)) or false,
        avatar = avatar,
        cleaned = false,
        transferring = false,
    }
    active_by_player[player_id] = state

    -- Lock and hide the real player before introducing the visual replacement.
    pcall(Net.lock_player_input, player_id)
    set_player_actor_hidden(player_id, entry.area_id, true)
    provide_avatar_to_area(entry.area_id, avatar)

    local name_ok, player_name = safe_call(Net.get_player_name, player_id)
    local ok_create, create_result = safe_call(Net.create_bot, temp_bot_id, {
        name = (name_ok and player_name) or 'Player',
        area_id = entry.area_id,
        warp_in = false,
        texture_path = avatar.texture_path,
        animation_path = avatar.animation_path,
        animation = move_state,
        x = player_pos.x,
        y = player_pos.y,
        z = player_pos.z or 0,
        -- Face toward the NPC from the first frame, opposite the push.
        direction = target.direction,
        solid = false,
    })
    if not ok_create or create_result == false or create_result == nil then
        logger:for_player(player_id):warn('[ezpushback] Could not create temporary avatar bot:', tostring(create_result))
        cleanup_push(player_id, state, 'bot_creation_failed', true)
        return
    end

    emit_entry(entry, 'pushback_started', event_for(entry, player_id, {
        bot_id = temp_bot_id,
        start_position = state.start_position,
        target_position = target,
        animation_state = move_state,
    }))

    pcall(Net.animate_bot, temp_bot_id, move_state, true)
    local duration = entry.push_duration
    local move_ok, move_result = safe_call(Net.animate_bot_properties, temp_bot_id, {
        {
            properties = {
                { property = 'X', value = target.x, ease = 'Out' },
                { property = 'Y', value = target.y, ease = 'Out' },
                { property = 'Z', value = target.z, ease = 'Linear' },
            },
            duration = duration,
        }
    })
    if not move_ok then
        logger:for_player(player_id):warn('[ezpushback] Bot property animation failed; using immediate movement:', tostring(move_result))
        pcall(Net.move_bot, temp_bot_id, target.x, target.y, target.z)
    end

    async(function()
        await(Async.sleep(duration))
        if active_by_player[player_id] ~= state or state.cleaned then return end
        if not Net.is_player(player_id) then
            cleanup_push(player_id, state, 'player_disconnected', false)
            return
        end

        local final_pos = target
        local ok_pos, bot_pos = safe_call(Net.get_bot_position, temp_bot_id)
        if ok_pos and type(bot_pos) == 'table'
            and tonumber(bot_pos.x) and tonumber(bot_pos.y) then
            local bot_dx = tonumber(bot_pos.x) - target.x
            local bot_dy = tonumber(bot_pos.y) - target.y
            if math.sqrt(bot_dx * bot_dx + bot_dy * bot_dy) <= 0.25 then
                final_pos = {
                    x = tonumber(bot_pos.x),
                    y = tonumber(bot_pos.y),
                    z = tonumber(bot_pos.z) or target.z,
                    direction = target.direction,
                }
            else
                pcall(Net.move_bot, temp_bot_id, target.x, target.y, target.z)
            end
        else
            pcall(Net.move_bot, temp_bot_id, target.x, target.y, target.z)
        end
        state.final_position = final_pos
        state.transferring = true

        local transfer_ok, transfer_result = safe_call(
            Net.transfer_player,
            player_id,
            entry.area_id,
            false,
            final_pos.x,
            final_pos.y,
            final_pos.z,
            final_pos.direction or target.direction
        )
        if not transfer_ok or transfer_result == false then
            logger:for_player(player_id):warn('[ezpushback] Final transfer failed:', tostring(transfer_result))
            cleanup_push(player_id, state, 'transfer_failed', true)
            return
        end

        cleanup_push(player_id, state, 'completed', true)
    end)
end

local function update_entry_geometry(entry)
    if not entry.bot_id then return false end
    local ok, pos = safe_call(Net.get_bot_position, entry.bot_id)
    if not ok or type(pos) ~= 'table' or not tonumber(pos.x) or not tonumber(pos.y) then
        return false
    end
    local x = tonumber(pos.x) - entry.width / 2
    local y = tonumber(pos.y) - entry.height / 2
    local z = tonumber(pos.z) or 0
    local moved = entry.last_bot_x == nil
        or math.abs(x - entry.trigger_object.x) > 0.0001
        or math.abs(y - entry.trigger_object.y) > 0.0001
        or z ~= (entry.trigger_object.z or 0)
    entry.trigger_object.x = x
    entry.trigger_object.y = y
    entry.trigger_object.z = z
    entry.last_bot_x, entry.last_bot_y, entry.last_bot_z = tonumber(pos.x), tonumber(pos.y), z
    return moved
end

-- Shared entry builder. Used by both the map-loaded Pushback NPC path
-- (register_pushback_npc) and the spawner-created path
-- (npc_spawned_from_spawner). Callers choose the trigger_id and initial
-- position; everything else (dimensions, timings, enabling, emitter wiring)
-- comes from the props table.
local function build_pushback_entry(area_id, object_id, props, bot_id, trigger_id,
                                   template_name, initial_x, initial_y, initial_z)
    if not bot_id then return nil end
    props = props or {}
    local width = number_property(props, 'Collision Width', DEFAULT_WIDTH, 0.1)
    local height = number_property(props, 'Collision Height', DEFAULT_HEIGHT, 0.1)
    local trigger_object = {
        id = trigger_id,
        name = template_name or ('Pushback NPC ' .. tostring(object_id)),
        x = (tonumber(initial_x) or 0) - width / 2,
        y = (tonumber(initial_y) or 0) - height / 2,
        z = tonumber(initial_z) or 0,
        width = width,
        height = height,
    }

    local emitter = EzEmitter.new()
    local entry = {
        key = trigger_id,
        trigger_id = trigger_id,
        area_id = area_id,
        object_id = object_id,
        bot_id = bot_id,
        width = width,
        height = height,
        push_distance = number_property(props, 'Push Distance', DEFAULT_PUSH_DISTANCE, 0.1),
        push_duration = number_property(props, 'Push Duration', DEFAULT_PUSH_DURATION, 0.05),
        cooldown = number_property(props, 'Push Cooldown', DEFAULT_COOLDOWN, 0),
        move_state = props['Move Animation State'] or DEFAULT_MOVE_STATE,
        enabled = truthy(props['Collision Enabled'], true),
        trigger_object = trigger_object,
        emitter = emitter,
    }
    entries[entry.key] = entry

    local trigger_emitter = eztriggers.add_rectangle_trigger(area_id, trigger_object, width, height, trigger_id)
    if not trigger_emitter then
        entries[entry.key] = nil
        return nil
    end

    trigger_emitter:on('entered', function(event)
        if not entry.enabled then return end
        local payload = event_for(entry, event.player_id, { reason = event.reason })
        emit_entry(entry, 'collision_entered', payload)
        perform_pushback(entry, event.player_id)
    end)
    trigger_emitter:on('departed', function(event)
        emit_entry(entry, 'collision_departed', event_for(entry, event.player_id, { reason = event.reason }))
    end)

    return entry
end

local function register_pushback_npc(area_id, object)
    local props = object.custom_properties or {}
    local bot_id = eznpcs.get_bot_for_placeholder(area_id, object.id)
    if not bot_id then
        -- Either the NPC is template-only (ezpushback handles spawned bots
        -- via the npc_spawned_from_spawner listener below) or ezpushback
        -- loaded before eznpcs finished creating the bot. Either way, the
        -- spawner path covers any bots that originate from a template.
        return
    end

    local trigger_id = 'ezpushback_' .. tostring(area_id) .. '_' .. tostring(object.id)
    local entry = build_pushback_entry(
        area_id, object.id, props, bot_id, trigger_id, object.name,
        tonumber(object.x) or 0, tonumber(object.y) or 0, tonumber(object.z) or 0
    )
    if not entry then
        logger:for_area(area_id):warn('[ezpushback] Failed to register moving rectangle trigger for object', tostring(object.id))
        return
    end

    logger:for_area(area_id):info(string.format(
        '[ezpushback] Registered Pushback NPC object=%s bot=%s zone=%.2fx%.2f push=%.2f duration=%.2f',
        tostring(object.id), tostring(bot_id), entry.width, entry.height, entry.push_distance, entry.push_duration))
end

object_registry.register_handler('Pushback NPC', register_pushback_npc, false)

-- Spawner integration. Fires once per spawned bot, with the template's
-- custom properties (for collision dims/timings) and the spawn position
-- (so the collision zone starts aligned with the bot rather than at the
-- template's authored location). Uses a bot-id-scoped trigger_id so
-- multiple spawned instances never collide in the entries table or in
-- eztriggers' registry.
ezbus:on("npc_spawned_from_spawner", function(event)
    if type(event) ~= "table" then return end
    if event.template_type ~= "Pushback NPC" then return end
    if not event.bot_id or not event.area_id then return end

    local trigger_id = 'ezpushback_spawn_'
        .. tostring(event.area_id) .. '_' .. tostring(event.bot_id)
    local entry = build_pushback_entry(
        event.area_id, event.template_object_id,
        event.template_custom_properties or {},
        event.bot_id, trigger_id, event.template_name,
        event.spawn_x or 0, event.spawn_y or 0, event.spawn_z or 0
    )
    if not entry then
        logger:for_area(event.area_id):warn(
            '[ezpushback] Failed to build spawned pushback entry bot=',
            tostring(event.bot_id),
            'spawner=', tostring(event.spawner_id))
        return
    end
    entry.spawned = true
    entry.spawner_id = event.spawner_id
    logger:for_area(event.area_id):info(string.format(
        '[ezpushback] Spawned Pushback NPC bot=%s spawner=%s zone=%.2fx%.2f push=%.2f',
        tostring(event.bot_id), tostring(event.spawner_id),
        entry.width, entry.height, entry.push_distance))
end)

-- Tear down entries whose bot has been removed (warp-out, path-complete
-- cleanup, external Net.remove_bot, disconnect, etc). We disable the entry
-- first so any in-flight trigger event fired before the entry is removed
-- from `entries` becomes a no-op, then drop the entry so on_tick stops
-- iterating it. The underlying eztriggers registration stays until the
-- area unloads, same as the map-loaded path.
ezbus:on("bot_removed", function(event)
    if type(event) ~= "table" or not event.bot_id then return end
    local bot_id = event.bot_id
    local dead = nil
    for key, entry in pairs(entries) do
        if entry.bot_id == bot_id then
            dead = dead or {}
            dead[#dead + 1] = { key = key, entry = entry }
        end
    end
    if not dead then return end
    for _, item in ipairs(dead) do
        item.entry.enabled = false
        entries[item.key] = nil
    end
    logger:info('[ezpushback] Cleaned up entries for removed bot', tostring(bot_id))
end)

function ezpushback.get_emitter(area_id, object_id)
    local key = 'ezpushback_' .. tostring(area_id) .. '_' .. tostring(object_id)
    return entries[key] and entries[key].emitter or nil
end

-- Look up the emitter for a spawner-created pushback entry by bot id.
-- Handy for scripted reactions that already track a spawner's bots.
function ezpushback.get_emitter_for_bot(bot_id)
    if bot_id == nil then return nil end
    for _, entry in pairs(entries) do
        if entry.bot_id == bot_id then
            return entry.emitter
        end
    end
    return nil
end

function ezpushback.set_collision_enabled(area_id, object_id, enabled)
    local key = 'ezpushback_' .. tostring(area_id) .. '_' .. tostring(object_id)
    local entry = entries[key]
    if not entry then return false end
    entry.enabled = enabled == true
    return true
end

function ezpushback.handle_player_move(player_id, x, y, z)
    -- The shared eztriggers plugin performs the actual player-overlap checks.
    -- This hook intentionally remains available for other integrations.
end

function ezpushback.on_tick(delta_time)
    local needs_refresh = false
    for _, entry in pairs(entries) do
        if update_entry_geometry(entry) then needs_refresh = true end
    end

    -- Refresh trigger overlaps after moving NPCs as well as after player movement.
    -- This catches a moving NPC entering a stationary player's collision zone.
    if needs_refresh then
        for _, area_id in ipairs(Net.list_areas() or {}) do
            for _, player_id in ipairs(get_area_players(area_id)) do
                if Net.is_player(player_id) and Net.get_player_area(player_id) == area_id then
                    local pos = Net.get_player_position(player_id)
                    if pos and tonumber(pos.x) and tonumber(pos.y) then
                        eztriggers.handle_player_move(player_id, tonumber(pos.x), tonumber(pos.y), tonumber(pos.z) or 0)
                    end
                end
            end
        end
    end
end

function ezpushback.handle_player_join(player_id)
    -- If a player joins while another player's real actor is hidden, apply the
    -- same per-viewer exclusion to the newly connected client.
    local area_id = Net.get_player_area(player_id)
    if not area_id then return end
    for hidden_player_id, state in pairs(active_by_player) do
        if state.area_id == area_id and not state.cleaned then
            pcall(Net.exclude_actor_for_player, player_id, hidden_player_id)
        end
    end
end

function ezpushback.handle_player_transfer(player_id)
    local state = active_by_player[player_id]
    if state and not state.transferring then
        cleanup_push(player_id, state, 'external_area_transfer', true)
    end
end

function ezpushback.handle_player_disconnect(player_id)
    local state = active_by_player[player_id]
    if state then cleanup_push(player_id, state, 'player_disconnected', false) end
    for key in pairs(cooldowns) do
        if key:sub(-#tostring(player_id) - 1) == ':' .. tostring(player_id) then
            cooldowns[key] = nil
        end
    end
end

logger:info('[ezpushback] Loaded; Pushback NPC custom type registered, spawner-created pushback supported.')
return ezpushback