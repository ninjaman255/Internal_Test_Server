-- ezpress.lua
-- Player compression/decompression driven by Tiled object properties and area
-- properties. Uses eztriggers for transition events, ezemitter for module-local
-- events, and ezbus for cross-module notifications.

local logger = require('scripts/ezlibs-scripts/ezlogger').get('ezpress')
local eztriggers = require('scripts/ezlibs-scripts/eztriggers')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local EventEmitter = require('scripts/ezlibs-scripts/ezemitter')

local ezpress = {}
ezpress.events = EventEmitter.new()

local compressed_players = {}
local area_triggers = {}
local active_tile_by_player = {}
local compressSfx = "/server/assets/ezlibs-assets/sfx/compress.ogg"

local SCALE_COMPRESSED = 3 / 8
local ANIMATION_DURATION = 0.15

local function is_true(value)
    if value == true or value == 1 then return true end
    if type(value) == "string" then
        value = string.lower(value)
        return value == "true" or value == "1" or value == "yes"
    end
    return false
end

local function emit_event(name, payload)
    -- Keep the local emitter useful for modules that want to subscribe directly,
    -- while publishing the same event to the shared application-wide bus.
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

function ezpress.get_area_minish_mode(area_id)
    if area_id == nil then return false end
    local ok, prop = pcall(Net.get_area_custom_property, area_id, "Minish Mode")
    if not ok then
        logger:warn("[ezpress] Could not read Minish Mode for area", tostring(area_id), prop)
        return false
    end
    return is_true(prop)
end

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

function ezpress.compress(player_id, immediate, metadata)
    if player_id == nil then return false end
    if compressed_players[player_id] then return false end

    logger:for_player(player_id):info(
        "[ezpress] Compressing player; immediate =", immediate == true,
        "source =", metadata and metadata.source or "api")

    animate_scale(player_id, SCALE_COMPRESSED, immediate)
    Net.play_sound_for_player(player_id, compressSfx)
    compressed_players[player_id] = true

    emit_event("player_compressed", {
        player_id = player_id,
        area_id = metadata and metadata.area_id or Net.get_player_area(player_id),
        source = metadata and metadata.source or "api",
        object_id = metadata and metadata.object_id or nil,
        trigger_type = metadata and metadata.trigger_type or nil,
        immediate = immediate == true
    })
    return true
end

function ezpress.decompress(player_id, immediate, metadata)
    if player_id == nil then return false end
    if not compressed_players[player_id] then return false end

    logger:for_player(player_id):info(
        "[ezpress] Decompressing player; immediate =", immediate == true,
        "source =", metadata and metadata.source or "api")

    animate_scale(player_id, 1, immediate)
    Net.play_sound_for_player(player_id, compressSfx)
    compressed_players[player_id] = nil

    emit_event("player_decompressed", {
        player_id = player_id,
        area_id = metadata and metadata.area_id or Net.get_player_area(player_id),
        source = metadata and metadata.source or "api",
        object_id = metadata and metadata.object_id or nil,
        trigger_type = metadata and metadata.trigger_type or nil,
        immediate = immediate == true
    })
    return true
end

function ezpress.apply_map_property(player_id, area_id, immediate, extra_metadata)
    local minish = ezpress.get_area_minish_mode(area_id)
    if minish then
        return ezpress.compress(player_id, immediate, {
            area_id = area_id,
            source = extra_metadata and extra_metadata.source or "area_property"
        })
    end
    return ezpress.decompress(player_id, immediate, {
        area_id = area_id,
        source = extra_metadata and extra_metadata.source or "area_property"
    })
end

local function position_matches_trigger(pos, trigger)
    if type(pos) ~= "table" or not trigger then return false end
    local x, y = tonumber(pos.x), tonumber(pos.y)
    local z = tonumber(pos.z) or 0
    if not x or not y then return false end
    if z ~= (tonumber(trigger.z) or 0) then return false end

    -- Match eztriggers' AABB semantics, including the rectangle edges.
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

-- Resolve the effective state from the player's actual position, rather than
-- trusting a single enter/leave callback. This handles overlapping tiles,
-- transfers, joins directly inside a tile, and missed/stale trigger transitions.
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
    if tile.type == "compress" then
        ezpress.compress(player_id, immediate, metadata)
    else
        ezpress.decompress(player_id, immediate, metadata)
    end
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
        "[ezpress] Tile", transition,
        "type =", trigger.type,
        "object =", tostring(trigger.object_id),
        "area =", tostring(area_id))

    emit_event("ezpress_tile_" .. transition, {
        player_id = player_id,
        area_id = area_id,
        object_id = trigger.object_id,
        trigger_type = trigger.type,
        reason = event.reason
    })

    -- The position is authoritative. A departure should fall back to another
    -- overlapping tile if present, otherwise to the area's Minish Mode property.
    reconcile_from_current_position(player_id, "tile_" .. transition, false)
end

local function add_area_trigger(area_id, object_id, obj, trigger_type)
    local trigger = {
        area_id = area_id,
        object_id = object_id,
        x = tonumber(obj.x),
        y = tonumber(obj.y),
        z = tonumber(obj.z) or 0,
        width = tonumber(obj.width),
        height = tonumber(obj.height),
        type = trigger_type
    }

    if not trigger.x or not trigger.y or not trigger.width or not trigger.height
        or trigger.width < 0 or trigger.height < 0 then
        logger:for_area(area_id):warn(
            "[ezpress] Skipping tile with invalid geometry; object =", tostring(object_id))
        return
    end

    area_triggers[area_id] = area_triggers[area_id] or {}
    table.insert(area_triggers[area_id], trigger)

    -- Give ezpress its own runtime trigger key. eztriggers otherwise keys by the
    -- Tiled object ID, which can collide with another module using that object.
    local runtime_trigger_id = "ezpress_" .. tostring(area_id) .. "_" .. tostring(object_id)
    local ok, emitter = pcall(
        eztriggers.add_rectangle_trigger,
        area_id,
        obj,
        trigger.width,
        trigger.height,
        runtime_trigger_id
    )

    if ok and emitter then
        emitter:on("entered", function(event)
            on_trigger_transition(area_id, trigger, "entered", event)
        end)
        emitter:on("departed", function(event)
            on_trigger_transition(area_id, trigger, "departed", event)
        end)
    else
        logger:for_area(area_id):warn(
            "[ezpress] Could not register eztriggers emitter for object", tostring(object_id),
            "; position-based fallback remains enabled. Error/result =", tostring(emitter))
    end

    logger:for_area(area_id):info(string.format(
        "[ezpress] Registered %s tile object=%s at (%.1f, %.1f, z=%d), size=(%.1f, %.1f)",
        trigger_type, tostring(object_id), trigger.x, trigger.y, trigger.z,
        trigger.width, trigger.height))
end

function ezpress.handle_player_join(player_id)
    if player_id == nil then return end
    pcall(Net.provide_asset_for_player, player_id, compressSfx)

    local area_id = Net.get_player_area(player_id)
    local pos = Net.get_player_position(player_id)
    logger:for_player(player_id):debug("[ezpress] Player joined in area", tostring(area_id))

    -- Preserve the original behavior: apply the area default immediately, then
    -- animate a tile override if the player spawned directly on a tile.
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

-- The central ezlibs main module dispatches player_move to plugin handlers.
-- Reconcile on movement as a safety net if an eztriggers transition was missed.
-- compress/decompress are idempotent, so this does not restart animations or SFX
-- while the player's effective state remains unchanged.
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

    -- Only impose the area's default when leaving a tile we were tracking.
    -- This keeps an explicit ezpress.compress() call from being undone on every
    -- ordinary movement in an area without Minish Mode.
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
    compressed_players[player_id] = nil
    active_tile_by_player[player_id] = nil
    -- Do not broadcast a decompression on disconnect; the player no longer exists.
    emit_event("player_disconnected", { player_id = player_id })
end

local function scan_areas()
    logger:info("[ezpress] Scanning areas for Compress/Decompress objects...")
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
                    local is_compress = is_true(props.Compress or props.compress)
                    local is_decompress = is_true(props.Decompress or props.decompress)

                    if is_compress or is_decompress then
                        -- If both are true, Compress wins, matching the previous script.
                        add_area_trigger(area_id, object_id, obj,
                            is_compress and "compress" or "decompress")
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
