-- ezpress.lua
-- Player compression/decompression driven by Tiled object properties and area
-- properties. Uses eztriggers for player tile events, ezbottriggers for bot
-- tile events, ezemitter for module-local events, and ezbus for cross-module
-- notifications.
--
-- Scale states:
--   normal     -> ScaleX/Y = 1
--   compressed -> ScaleX/Y = 3/8  (Minish-size)
--   enlarged   -> ScaleX/Y = 2    (Giant-size)
--
-- Area properties:
--   "Size Mode" (enum CompressionMode: Compress | Normalize | Enlarge)
--     Sets the default scale state for the whole area. Unset -> normal.
--   "Size Mode Scope" (enum SizeModeScope: Player | Area Wide)
--     "Player"    -> area default affects players only. (default)
--     "Area Wide" -> area default also applies to NPCs / bots in the area.
--
-- Compression Tile object properties:
--   "Mode" = "Compress" | "Normalize" | "Enlarge"   (CompressionMode enum)
--   Legacy boolean "Compress"/"Decompress" is still supported for old maps.
--
-- Each Compression Tile registers TWO triggers, both at the same rectangle:
--   * A player trigger via eztriggers (affects the player standing in it).
--   * A bot trigger    via ezbottriggers (affects NPCs standing in it).
-- Departing a tile falls back to the area's Size Mode when its scope is
-- Area Wide, and to normal otherwise. Overlapping tiles are resolved by
-- re-checking the entity's current position, mirroring eztriggers/ezbottriggers.

local logger = require('scripts/ezlibs-scripts/ezlogger').get('ezpress')
local eztriggers = require('scripts/ezlibs-scripts/eztriggers/eztriggers')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local EventEmitter = require('scripts/ezlibs-scripts/ezemitter')

-- ezbottriggers is a hard requirement for the bot-side tile triggers. If it
-- ever fails to load, keep player behavior working and disable bot tiles.
local ok_bottriggers, ezbottriggers = pcall(require, 'scripts/ezlibs-scripts/eztriggers/ezbottriggers')
if not ok_bottriggers then
    logger:warn("[ezpress] ezbottriggers could not be loaded; bot tile triggers disabled.", tostring(ezbottriggers))
    ezbottriggers = nil
end

local ezpress = {}
ezpress.events = EventEmitter.new()

-- player_scale_state[player_id] = nil (normal) | "compressed" | "enlarged"
local player_scale_state = {}
-- bot_scale_state[bot_id] = nil (normal) | "compressed" | "enlarged"
local bot_scale_state = {}
-- bots_by_area[area_id] = { [bot_id] = true }
local bots_by_area = {}
-- active_tile_by_player[player_id] = { area_id, object_id, type }
local active_tile_by_player = {}
-- active_tile_by_bot[bot_id] = { area_id, object_id, type }
local active_tile_by_bot = {}

local area_triggers = {}
local scaleSfx = "/server/assets/ezlibs-assets/sfx/compress.ogg"

local SCALE_NORMAL = 1
local SCALE_COMPRESSED = 3 / 8
local SCALE_ENLARGED = 2

local SCALE_STATES = {
    normal = SCALE_NORMAL,
    compressed = SCALE_COMPRESSED,
    enlarged = SCALE_ENLARGED,
}

local ANIMATION_DURATION = 0.15

local function is_true(value)
    if value == true or value == 1 then return true end
    if type(value) == "string" then
        value = string.lower(value)
        return value == "true" or value == "1" or value == "yes"
    end
    return false
end

-- Normalize any CompressionMode enum value (or loose spelling) to a scale state.
local function normalize_size_mode(value)
    if type(value) ~= "string" or value == "" then return nil end
    local m = string.lower(value)
    if m == "compress" or m == "compressed" then return "compressed" end
    if m == "normalize" or m == "normal" or m == "normalized" then return "normal" end
    if m == "enlarge" or m == "enlarged" or m == "giant" then return "enlarged" end
    return nil
end

-- Normalize the SizeModeScope enum value ("Player" | "Area Wide").
local function normalize_size_mode_scope(value)
    if type(value) ~= "string" or value == "" then return "player" end
    local s = string.lower(value)
    if s == "area wide" or s == "area_wide" or s == "areawide" or s == "area" then
        return "area_wide"
    end
    return "player"
end

local function emit_event(name, payload)
    ezpress.events:emit(name, payload)
    ezbus:emit(name, payload)
end

function ezpress:on(event_name, callback)
    ezpress.events:on(event_name, callback)
    return ezpress
end

function ezpress:once(event_name, callback)
    ezpress.events:once(event_name, callback)
    return ezpress
end

-- ---------------------------------------------------------------------------
-- Area property helpers
-- ---------------------------------------------------------------------------

function ezpress.get_area_scale_state(area_id)
    if area_id == nil then return "normal" end
    local ok, prop = pcall(Net.get_area_custom_property, area_id, "Size Mode")
    if not ok then
        logger:warn("[ezpress] Could not read Size Mode for area", tostring(area_id), prop)
        return "normal"
    end
    return normalize_size_mode(prop) or "normal"
end

function ezpress.get_area_size_mode_scope(area_id)
    if area_id == nil then return "player" end
    local ok, prop = pcall(Net.get_area_custom_property, area_id, "Size Mode Scope")
    if not ok then
        logger:warn("[ezpress] Could not read Size Mode Scope for area", tostring(area_id), prop)
        return "player"
    end
    return normalize_size_mode_scope(prop)
end

-- ---------------------------------------------------------------------------
-- Player scale state machine
-- ---------------------------------------------------------------------------

local function animate_scale(player_id, scale, immediate)
    local duration = immediate and 0 or ANIMATION_DURATION
    Net.animate_player_properties(player_id, {
        {
            properties = {
                { property = "ScaleX", value = scale, ease = "Linear" },
                { property = "ScaleY", value = scale, ease = "Linear" }
            },
            duration = duration
        }
    })
end

function ezpress.set_scale_state(player_id, state, immediate, metadata)
    if player_id == nil then return false end
    if not SCALE_STATES[state] then
        logger:warn("[ezpress] Unknown scale state:", tostring(state))
        return false
    end

    local previous_state = player_scale_state[player_id] or "normal"
    if previous_state == state then return false end

    logger:for_player(player_id):info(
        "[ezpress] Scale state", previous_state, "->", state,
        "; immediate =", immediate == true,
        "source =", metadata and metadata.source or "api")

    if state == "normal" then
        player_scale_state[player_id] = nil
    else
        player_scale_state[player_id] = state
    end

    animate_scale(player_id, SCALE_STATES[state], immediate)
    Net.play_sound_for_player(player_id, scaleSfx)

    local payload = {
        player_id = player_id,
        area_id = (metadata and metadata.area_id) or Net.get_player_area(player_id),
        state = state,
        previous_state = previous_state,
        source = metadata and metadata.source or "api",
        object_id = metadata and metadata.object_id or nil,
        trigger_type = metadata and metadata.trigger_type or nil,
        immediate = immediate == true
    }

    if state == "compressed" then
        emit_event("player_compressed", payload)
    elseif state == "normal" then
        emit_event("player_decompressed", payload)
    elseif state == "enlarged" then
        emit_event("player_enlarged", payload)
    end
    emit_event("player_scale_changed", payload)
    return true
end

function ezpress.get_scale_state(player_id)
    if player_id == nil then return "normal" end
    return player_scale_state[player_id] or "normal"
end

function ezpress.is_compressed(player_id)
    return ezpress.get_scale_state(player_id) == "compressed"
end

function ezpress.is_enlarged(player_id)
    return ezpress.get_scale_state(player_id) == "enlarged"
end

function ezpress.compress(player_id, immediate, metadata)
    return ezpress.set_scale_state(player_id, "compressed", immediate, metadata)
end

function ezpress.decompress(player_id, immediate, metadata)
    return ezpress.set_scale_state(player_id, "normal", immediate, metadata)
end

function ezpress.enlarge(player_id, immediate, metadata)
    return ezpress.set_scale_state(player_id, "enlarged", immediate, metadata)
end

-- ---------------------------------------------------------------------------
-- Bot (NPC) scale state machine
-- ---------------------------------------------------------------------------

local function animate_bot_scale(bot_id, scale, immediate)
    local duration = immediate and 0 or ANIMATION_DURATION
    local config = {
        {
            properties = {
                { property = "ScaleX", value = scale, ease = "Linear" },
                { property = "ScaleY", value = scale, ease = "Linear" }
            },
            duration = duration
        }
    }

    local ok, err = pcall(Net.animate_bot_properties, bot_id, config)
    if ok then return end

    logger:warn("[ezpress] Net.animate_bot_properties failed for bot", tostring(bot_id), err)
    local ok2, err2 = pcall(Net.set_bot_scale, bot_id, scale, scale)
    if not ok2 then
        logger:warn("[ezpress] Net.set_bot_scale fallback failed for bot", tostring(bot_id), err2)
    end
end

function ezpress.set_bot_scale_state(bot_id, state, immediate, metadata)
    if bot_id == nil then return false end
    if not SCALE_STATES[state] then
        logger:warn("[ezpress] Unknown bot scale state:", tostring(state))
        return false
    end

    local previous_state = bot_scale_state[bot_id] or "normal"
    if previous_state == state then return false end

    logger:info("[ezpress] Bot scale state", previous_state, "->", state,
        "; bot =", tostring(bot_id),
        "; immediate =", immediate == true,
        "source =", metadata and metadata.source or "api")

    if state == "normal" then
        bot_scale_state[bot_id] = nil
    else
        bot_scale_state[bot_id] = state
    end

    animate_bot_scale(bot_id, SCALE_STATES[state], immediate)

    local payload = {
        bot_id = bot_id,
        area_id = metadata and metadata.area_id or nil,
        state = state,
        previous_state = previous_state,
        source = metadata and metadata.source or "api",
        immediate = immediate == true
    }
    if state == "compressed" then
        emit_event("bot_compressed", payload)
    elseif state == "normal" then
        emit_event("bot_decompressed", payload)
    elseif state == "enlarged" then
        emit_event("bot_enlarged", payload)
    end
    emit_event("bot_scale_changed", payload)
    return true
end

function ezpress.get_bot_scale_state(bot_id)
    if bot_id == nil then return "normal" end
    return bot_scale_state[bot_id] or "normal"
end

-- ---------------------------------------------------------------------------
-- Tile lookup helpers
-- ---------------------------------------------------------------------------

local function position_matches_trigger(pos, trigger)
    if type(pos) ~= "table" or not trigger then return false end
    local x, y = tonumber(pos.x), tonumber(pos.y)
    local z = tonumber(pos.z) or 0
    if not x or not y then return false end
    if z ~= (tonumber(trigger.z) or 0) then return false end

    return x >= trigger.x and x <= trigger.x + trigger.width
        and y >= trigger.y and y <= trigger.y + trigger.height
end

local function get_matching_tile(area_id, pos)
    local triggers = area_triggers[area_id]
    if not triggers then return nil end
    for _, trigger in ipairs(triggers) do
        if position_matches_trigger(pos, trigger) then
            return trigger
        end
    end
    return nil
end

-- Public: read-only lookup for external modules that need to know what scale
-- a player "should" be at for a given world position. Returns the tile's
-- scale state ("normal" | "compressed" | "enlarged"), or nil when no tile
-- overlaps the position. Does not mutate any internal state, does not write
-- to the player, and does not fire events. ezpushback uses this to compute
-- the correct restore scale after a pushback teleport, since the engine has
-- no reader for the player's actual ScaleX/ScaleY.
function ezpress.get_tile_state_at(area_id, pos)
    if area_id == nil or type(pos) ~= "table" then return nil end
    local tile = get_matching_tile(area_id, pos)
    return tile and tile.type or nil
end

-- ---------------------------------------------------------------------------
-- Player tile reconciliation
-- ---------------------------------------------------------------------------

function ezpress.check_and_apply(player_id, area_id, pos, immediate)
    if player_id == nil or area_id == nil then return false end
    pos = pos or Net.get_player_position(player_id)

    local tile = get_matching_tile(area_id, pos)
    if not tile then return false end

    active_tile_by_player[player_id] = {
        area_id = area_id,
        object_id = tile.object_id,
        type = tile.type
    }

    local metadata = {
        area_id = area_id,
        source = "tile_trigger",
        object_id = tile.object_id,
        trigger_type = tile.type
    }
    ezpress.set_scale_state(player_id, tile.type, immediate, metadata)
    return true
end

local function reconcile_from_current_position(player_id, source, immediate)
    if player_id == nil then return end
    local ok_area, area_id = pcall(Net.get_player_area, player_id)
    if not ok_area or area_id == nil then return end
    local ok_pos, pos = pcall(Net.get_player_position, player_id)
    if not ok_pos or type(pos) ~= "table" then return end

    if ezpress.check_and_apply(player_id, area_id, pos, immediate) then
        return
    end

    local previous_tile = active_tile_by_player[player_id]
    if previous_tile then
        active_tile_by_player[player_id] = nil
        ezpress.apply_map_property(player_id, area_id, immediate, {
            source = source or "tile_departure"
        })
    end
end

local function on_trigger_transition(area_id, trigger, transition, event)
    local player_id = type(event) == "table" and event.player_id or nil
    if player_id == nil then return end

    logger:for_player(player_id):debug(
        "[ezpress] Player tile", transition,
        "state =", trigger.type,
        "object =", tostring(trigger.object_id),
        "area =", tostring(area_id))

    emit_event("ezpress_tile_" .. transition, {
        player_id = player_id,
        area_id = area_id,
        object_id = trigger.object_id,
        trigger_type = trigger.type,
        reason = event.reason
    })

    reconcile_from_current_position(player_id, "tile_" .. transition, false)
end

-- ---------------------------------------------------------------------------
-- Bot tile reconciliation
-- ---------------------------------------------------------------------------

-- Fallback used when a bot leaves a tile: apply the area's Size Mode when the
-- area's scope includes bots, and normalize otherwise.
local function apply_bot_area_fallback(bot_id, area_id, immediate, source)
    if ezpress.get_area_size_mode_scope(area_id) == "area_wide" then
        local state = ezpress.get_area_scale_state(area_id)
        return ezpress.set_bot_scale_state(bot_id, state, immediate, {
            area_id = area_id,
            source = source or "tile_departure"
        })
    end
    return ezpress.set_bot_scale_state(bot_id, "normal", immediate, {
        area_id = area_id,
        source = source or "tile_departure"
    })
end

-- Reconcile a bot's scale from a known position (from an ezbottriggers event)
-- so overlapping tiles resolve correctly. If pos is nil, the caller should
-- have supplied the position from the trigger event.
local function reconcile_bot_from_position(bot_id, area_id, pos, source, immediate)
    if bot_id == nil or area_id == nil then return false end
    if type(pos) ~= "table" then return false end

    local tile = get_matching_tile(area_id, pos)
    if tile then
        active_tile_by_bot[bot_id] = {
            area_id = area_id,
            object_id = tile.object_id,
            type = tile.type
        }
        return ezpress.set_bot_scale_state(bot_id, tile.type, immediate, {
            area_id = area_id,
            source = "bot_tile_trigger",
            object_id = tile.object_id,
            trigger_type = tile.type
        })
    end

    local previous_tile = active_tile_by_bot[bot_id]
    if previous_tile then
        active_tile_by_bot[bot_id] = nil
    end

    -- Always resolve to a baseline once the bot leaves a tile. If scope is
    -- Area Wide, baseline is the area default; otherwise it's normal (1x).
    -- Skipping when there was no previous tile preserves explicit API calls
    -- (e.g. a script that scaled the bot directly).
    if previous_tile then
        return apply_bot_area_fallback(bot_id, area_id, immediate, source)
    end
    return false
end

local function on_bot_trigger_transition(area_id, trigger, transition, event)
    local bot_id = type(event) == "table" and event.bot_id or nil
    if bot_id == nil then return end

    logger:debug(
        "[ezpress] Bot tile", transition,
        "state =", trigger.type,
        "object =", tostring(trigger.object_id),
        "area =", tostring(area_id),
        "bot =", tostring(bot_id))

    emit_event("ezpress_bot_tile_" .. transition, {
        bot_id = bot_id,
        area_id = area_id,
        object_id = trigger.object_id,
        trigger_type = trigger.type,
        reason = event.reason
    })

    -- ezbottriggers includes the position that caused the transition, so
    -- reconcile without an extra Net lookup.
    local pos = nil
    if type(event.x) == "number" and type(event.y) == "number" then
        pos = { x = event.x, y = event.y, z = tonumber(event.z) or 0 }
    end
    reconcile_bot_from_position(bot_id, area_id, pos, "bot_tile_" .. transition, false)
end

-- ---------------------------------------------------------------------------
-- Trigger registration (both player and bot)
-- ---------------------------------------------------------------------------

local function add_area_trigger(area_id, object_id, obj, target_state)
    local trigger = {
        area_id = area_id,
        object_id = object_id,
        x = tonumber(obj.x),
        y = tonumber(obj.y),
        z = tonumber(obj.z) or 0,
        width = tonumber(obj.width),
        height = tonumber(obj.height),
        type = target_state
    }

    if not trigger.x or not trigger.y or not trigger.width or not trigger.height
        or trigger.width < 0 or trigger.height < 0 then
        logger:for_area(area_id):warn(
            "[ezpress] Skipping tile with invalid geometry; object =", tostring(object_id))
        return
    end

    area_triggers[area_id] = area_triggers[area_id] or {}
    table.insert(area_triggers[area_id], trigger)

    -- Player trigger (via eztriggers)
    local player_runtime_id = "ezpress_" .. tostring(area_id) .. "_" .. tostring(object_id)
    local ok_player, player_emitter = pcall(
        eztriggers.add_rectangle_trigger,
        area_id,
        obj,
        trigger.width,
        trigger.height,
        player_runtime_id
    )
    if ok_player and player_emitter then
        player_emitter:on("entered", function(event)
            on_trigger_transition(area_id, trigger, "entered", event)
        end)
        player_emitter:on("departed", function(event)
            on_trigger_transition(area_id, trigger, "departed", event)
        end)
    else
        logger:for_area(area_id):warn(
            "[ezpress] Could not register player eztriggers emitter for object", tostring(object_id),
            "; position-based fallback remains enabled. Error/result =", tostring(player_emitter))
    end

    -- Bot trigger (via ezbottriggers). Same rectangle, separate registry.
    if ezbottriggers then
        local bot_runtime_id = "ezpress_bot_" .. tostring(area_id) .. "_" .. tostring(object_id)
        local ok_bot, bot_emitter = pcall(
            ezbottriggers.add_rectangle_trigger,
            area_id,
            obj,
            trigger.width,
            trigger.height,
            bot_runtime_id
        )
        if ok_bot and bot_emitter then
            bot_emitter:on("entered", function(event)
                on_bot_trigger_transition(area_id, trigger, "entered", event)
            end)
            bot_emitter:on("departed", function(event)
                on_bot_trigger_transition(area_id, trigger, "departed", event)
            end)
        else
            logger:for_area(area_id):warn(
                "[ezpress] Could not register bot ezbottriggers emitter for object", tostring(object_id),
                "; error/result =", tostring(bot_emitter))
        end
    end

    logger:for_area(area_id):info(string.format(
        "[ezpress] Registered '%s' tile object=%s at (%.1f, %.1f, z=%d), size=(%.1f, %.1f)",
        target_state, tostring(object_id), trigger.x, trigger.y, trigger.z,
        trigger.width, trigger.height))
end

-- ---------------------------------------------------------------------------
-- Tile property parsing (new enum + legacy booleans)
-- ---------------------------------------------------------------------------

local function read_tile_state_from_properties(props)
    local state = normalize_size_mode(props.Mode or props.mode)
    if state then return state end

    if is_true(props.Compress or props.compress) then return "compressed" end
    if is_true(props.Decompress or props.decompress) then return "normal" end

    return nil
end

-- ---------------------------------------------------------------------------
-- Apply area default (Size Mode + Size Mode Scope)
-- ---------------------------------------------------------------------------

function ezpress.apply_area_scale_to_bots(area_id, immediate, metadata)
    if area_id == nil then return end
    local bots = bots_by_area[area_id]
    if not bots then return end

    local applied = false
    for bot_id in pairs(bots) do
        -- Reconcile each bot from its current position so tiles win over the
        -- area default. Bots outside any tile fall back to the area default
        -- when the scope includes NPCs, otherwise stay at normal.
        local ok_area, actual_area = pcall(Net.get_bot_area, bot_id)
        if not ok_area or actual_area ~= area_id then
            -- Bot moved to a different area; skip.
        else
            local ok_pos, pos = pcall(Net.get_bot_position, bot_id)
            if ok_pos and type(pos) == "table" then
                local tile = get_matching_tile(area_id, pos)
                if tile then
                    active_tile_by_bot[bot_id] = {
                        area_id = area_id,
                        object_id = tile.object_id,
                        type = tile.type
                    }
                    if ezpress.set_bot_scale_state(bot_id, tile.type, immediate, {
                        area_id = area_id,
                        source = (metadata and metadata.source) or "area_property",
                        object_id = tile.object_id,
                        trigger_type = tile.type
                    }) then
                        applied = true
                    end
                else
                    local was_in_tile = active_tile_by_bot[bot_id] ~= nil
                    active_tile_by_bot[bot_id] = nil
                    local state = ezpress.get_area_scale_state(area_id)
                    -- Outside tiles: apply area default only if Area Wide OR
                    -- the bot just left a tile (so it doesn't get stuck at a
                    -- stale size in a Player-scope area).
                    if ezpress.get_area_size_mode_scope(area_id) == "area_wide" or was_in_tile then
                        if ezpress.set_bot_scale_state(bot_id, state, immediate, {
                            area_id = area_id,
                            source = (metadata and metadata.source) or "area_property"
                        }) then
                            applied = true
                        end
                    end
                end
            end
        end
    end
    return applied
end

function ezpress.apply_map_property(player_id, area_id, immediate, extra_metadata)
    local state = ezpress.get_area_scale_state(area_id)
    local applied = ezpress.set_scale_state(player_id, state, immediate, {
        area_id = area_id,
        source = (extra_metadata and extra_metadata.source) or "area_property"
    })

    if ezpress.get_area_size_mode_scope(area_id) == "area_wide" then
        ezpress.apply_area_scale_to_bots(area_id, immediate, {
            area_id = area_id,
            source = (extra_metadata and extra_metadata.source) or "area_property"
        })
    end

    return applied
end

-- ---------------------------------------------------------------------------
-- Bot lifecycle (from ezbus)
-- ---------------------------------------------------------------------------

function ezpress.handle_bot_created(bot_id, area_id, x, y, z)
    if bot_id == nil then return end
    if area_id == nil then
        local ok, actual = pcall(Net.get_bot_area, bot_id)
        if ok then area_id = actual end
    end
    if area_id == nil then return end

    bots_by_area[area_id] = bots_by_area[area_id] or {}
    bots_by_area[area_id][bot_id] = true

    -- Initial state: if the bot spawned inside a tile, that tile wins.
    -- Otherwise, apply the area default only when the scope is Area Wide.
    local pos = nil
    if type(x) == "number" and type(y) == "number" then
        pos = { x = x, y = y, z = tonumber(z) or 0 }
    end

    if pos then
        local tile = get_matching_tile(area_id, pos)
        if tile then
            active_tile_by_bot[bot_id] = {
                area_id = area_id,
                object_id = tile.object_id,
                type = tile.type
            }
            ezpress.set_bot_scale_state(bot_id, tile.type, true, {
                area_id = area_id,
                source = "bot_created",
                object_id = tile.object_id
            })
            return
        end
    end

    if ezpress.get_area_size_mode_scope(area_id) == "area_wide" then
        local state = ezpress.get_area_scale_state(area_id)
        ezpress.set_bot_scale_state(bot_id, state, true, {
            area_id = area_id,
            source = "bot_created"
        })
    end
end

function ezpress.handle_bot_removed(bot_id)
    if bot_id == nil then return end
    bot_scale_state[bot_id] = nil
    active_tile_by_bot[bot_id] = nil
    for _, bots in pairs(bots_by_area) do
        bots[bot_id] = nil
    end
end

ezbus:on("bot_created", function(event)
    if type(event) == "table" then
        ezpress.handle_bot_created(event.bot_id, event.area_id, event.x, event.y, event.z)
    end
end)

ezbus:on("bot_removed", function(event)
    if type(event) == "table" then
        ezpress.handle_bot_removed(event.bot_id)
    end
end)

-- ---------------------------------------------------------------------------
-- Player lifecycle handlers
-- ---------------------------------------------------------------------------

function ezpress.handle_player_join(player_id)
    if player_id == nil then return end
    pcall(Net.provide_asset_for_player, player_id, scaleSfx)

    local area_id = Net.get_player_area(player_id)
    local pos = Net.get_player_position(player_id)
    logger:for_player(player_id):debug("[ezpress] Player joined in area", tostring(area_id))

    active_tile_by_player[player_id] = nil
    ezpress.apply_map_property(player_id, area_id, true)
    local tile = get_matching_tile(area_id, pos)
    if tile then
        ezpress.check_and_apply(player_id, area_id, pos, false)
    end
end

function ezpress.handle_player_transfer(player_id)
    if player_id == nil then return end
    local area_id = Net.get_player_area(player_id)
    local pos = Net.get_player_position(player_id)
    logger:for_player(player_id):debug("[ezpress] Player transferred to area", tostring(area_id))

    active_tile_by_player[player_id] = nil
    ezpress.apply_map_property(player_id, area_id, true)
    local tile = get_matching_tile(area_id, pos)
    if tile then
        ezpress.check_and_apply(player_id, area_id, pos, false)
    end
end

function ezpress.handle_player_move(player_id, x, y, z)
    if player_id == nil then return end
    local area_id = Net.get_player_area(player_id)
    if area_id == nil then return end

    local pos = {
        x = tonumber(x),
        y = tonumber(y),
        z = tonumber(z) or 0
    }
    if not pos.x or not pos.y then
        pos = Net.get_player_position(player_id)
    end

    local tile = get_matching_tile(area_id, pos)
    if tile then
        ezpress.check_and_apply(player_id, area_id, pos, false)
    elseif active_tile_by_player[player_id] then
        active_tile_by_player[player_id] = nil
        ezpress.apply_map_property(player_id, area_id, false, { source = "tile_departure" })
    end
end

function ezpress.handle_player_disconnect(player_id)
    if player_id == nil then return end
    player_scale_state[player_id] = nil
    active_tile_by_player[player_id] = nil
    emit_event("player_disconnected", { player_id = player_id })
end

-- ---------------------------------------------------------------------------
-- Startup: scan for Compression Tiles
-- ---------------------------------------------------------------------------

local function scan_areas()
    logger:info("[ezpress] Scanning areas for Compress/Normalize/Enlarge objects...")
    local ok_areas, areas = pcall(Net.list_areas)
    if not ok_areas or type(areas) ~= "table" then
        logger:warn("[ezpress] Could not list areas; tile trigger scan skipped.")
        return
    end

    for _, area_id in ipairs(areas) do
        local ok_objects, objects = pcall(Net.list_objects, area_id)
        if ok_objects and type(objects) == "table" then
            for _, object_id in ipairs(objects) do
                local ok_obj, obj = pcall(Net.get_object_by_id, area_id, object_id)
                if ok_obj and type(obj) == "table" then
                    local props = obj.custom_properties or {}
                    local state = read_tile_state_from_properties(props)
                    if state then
                        add_area_trigger(area_id, object_id, obj, state)
                    end
                end
            end
        else
            logger:for_area(area_id):warn("[ezpress] Could not list objects in area", tostring(area_id))
        end
    end

    logger:info("[ezpress] Tile scan complete.")
end

scan_areas()

return ezpress