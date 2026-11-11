local LegacyCapture = require("scripts/player-control/legacy-capture")
local logger = require('scripts/logger/logger').register('ezwarps')
local json = require('scripts/ezlibs-scripts/json')
local create_arrow_animation = require('scripts/ezlibs-scripts/ezwarps/arrow_animation_factory')
local create_jack_in_out_animation = require('scripts/ezlibs-scripts/ezwarps/log_in_animation')
local eztriggers = require('scripts/ezlibs-scripts/eztriggers/eztriggers')
local object_registry = require('scripts/ezlibs-scripts/object_registry')
local ezbus = require('scripts/ezlibs-scripts/ezbus')
local ezcache = require('scripts/ezlibs-scripts/ezcache')
local DefaultSpawnGuard = require('scripts/ezlibs-scripts/ezwarps/default_spawn_guard')

local ezwarps = {}

--arrival / leaving animations
local special_animations = {
    fall_in = require('scripts/ezlibs-scripts/ezwarps/fall_in_animation'),
    lev_beast_in = require('scripts/ezlibs-scripts/ezwarps/lev_beast_in_animation'),
    lev_beast_out = require('scripts/ezlibs-scripts/ezwarps/lev_beast_out_animation'),
    arrow_up_left_out = create_arrow_animation(false,"Up Left"),
    arrow_up_right_out = create_arrow_animation(false,"Up Right"),
    arrow_down_left_out = create_arrow_animation(false,"Down Left"),
    arrow_down_right_out = create_arrow_animation(false,"Down Right"),
    arrow_up_left_in = create_arrow_animation(true,"Up Left"),
    arrow_up_right_in = create_arrow_animation(true,"Up Right"),
    arrow_down_left_in = create_arrow_animation(true,"Down Left"),
    arrow_down_right_in = create_arrow_animation(true,"Down Right"),
    fall_off_2 = require('scripts/ezlibs-scripts/ezwarps/fall_off_2'),
    log_in = create_jack_in_out_animation(true),
    log_out = create_jack_in_out_animation(false)
}

local landings = {}
local player_animations = {}
local players_in_animations = {}
local warp_types_with_landings = {"Server Warp","Custom Warp","Interact Warp","Radius Warp"}

-- When a scripted activity returns a player to the exact place they entered,
-- the custom-warp tile can immediately send them back. Guard only that
-- player's source warp until they physically walk away from the entry point.
-- World coordinates are in tiles; allow a 1.5-tile departure before re-arming.
local RETURN_WARP_REARM_DISTANCE_SQ = 1.5 * 1.5
local return_warp_guards = {}

function ezwarps.guard_return_warp(player_id, area_id, warp_object_id, position)
    if not player_id or not area_id or not warp_object_id
        or type(position) ~= "table" then return false end
    local x, y = tonumber(position.x), tonumber(position.y)
    if not x or not y then return false end
    return_warp_guards[player_id] = {
        area = tostring(area_id), object_id = tostring(warp_object_id),
        x = x, y = y, z = tonumber(position.z) or 0,
    }
    log('[return-guard] armed player=' .. tostring(player_id)
        .. ' area=' .. tostring(area_id)
        .. ' warp=' .. tostring(warp_object_id))
    return true
end

local function update_return_warp_guard(player_id, area, x, y)
    local guard = return_warp_guards[player_id]
    if not guard or area ~= guard.area then return end
    if type(x) ~= "number" or type(y) ~= "number" then return end
    local dx, dy = x - guard.x, y - guard.y
    if dx * dx + dy * dy >= RETURN_WARP_REARM_DISTANCE_SQ then
        return_warp_guards[player_id] = nil
        log('[return-guard] rearmed player=' .. tostring(player_id)
            .. ' warp=' .. guard.object_id .. ' after walking away')
    end
end

function ezwarps.handle_player_move(player_id, x, y, z)
    update_return_warp_guard(player_id, Net.get_player_area(player_id), x, y)
end

function ezwarps.handle_player_disconnect(player_id)
    return_warp_guards[player_id] = nil
end

function table_has_value (table, val)
    for index, value in ipairs(table) do
        if value == val then
            return true
        end
    end
    return false
end

-- Logs the given message on screen --
function log(message)
   logger:info('[ezwarps] '.. message)
end

-- Normalizes a custom property that may be a real boolean or a string
-- such as "true"/"false" into a real Lua boolean.
local function property_is_true(value)
    return value == true or value == "true" or value == "True"
end

function add_landing(area_id, incoming_data, x, y, z, direction, warp_in, arrival_animation)
    local new_landing = {
        area_id = area_id,
        warp_in = warp_in,
        x = x,
        y = y,
        z = z,
        pre_animation_x=x,
        pre_animation_y=y,
        pre_animation_z=z,
        direction = direction,
        arrival_animation = arrival_animation
    }
    landings[incoming_data] = new_landing

    log('added landing for '..incoming_data.." = "..json.encode(new_landing, true))
end

function doAnimationForWarp(player_id,animation_name,is_leave_animation,warp_object)
    return async(function()
        log('doing special animation '..animation_name)
        players_in_animations[player_id] = true
        if warp_object and property_is_true(warp_object.custom_properties["Dont Teleport"]) then
            players_in_animations[player_id] = nil
        end
        LegacyCapture.lock(player_id, "ezwarps")
        local animation_properties = special_animations[animation_name]
        local animation_duration = 0
        if animation_properties then
            await(animation_properties.animate(player_id,warp_object))
            log('animation complete '..animation_name)
            player_animations[player_id] = nil
        end
        LegacyCapture.unlock(player_id, "ezwarps")
    end)
end

function add_interact_warp(object, object_id, area_id, area_name)
    log('adding interact warp... '..object_id)
    local interact_warp_emitter = eztriggers.add_interact_trigger(area_id,object)
    interact_warp_emitter:on("interaction",function(event)
        if not players_in_animations[event.player_id] then
            log('using interact warp')
            use_warp(event.player_id,object)
        end
    end)
    log('added interact warp '..object_id)
end

-- Adds the given radius warp to the list of detected radius warps
function add_radius_warp(object, object_id, area_id, area_name)
    local diameter = tonumber(object.custom_properties["Activation Radius"])*2
    log('adding radius warp '..object_id..", "..diameter)
    local radius_warp_emitter = eztriggers.add_radius_trigger(area_id,object,diameter,diameter,0,0)
    radius_warp_emitter:on("entered",function(event)
        if not players_in_animations[event.player_id] then
            log('using radius warp')
            use_warp(event.player_id,object)
        else
            log('player arrived in radius warp range')
            players_in_animations[event.player_id] = nil
        end
    end)
    log('added radius warp '..object_id)
end

-- Adds the given custom warp to the list of detected custom warps
function add_custom_warp(object, object_id, area_id, area_name) 
    local warp_is_valid = true
            
    log('adding custom warp with id ' .. object_id .. ' in ' .. area_name .. ' ... ')
    local target_object = nil
    local target_area = object.custom_properties["Target Area"]
    local dont_teleport = property_is_true(object.custom_properties["Dont Teleport"])
    if not dont_teleport and target_area then
        local target_object_id = tostring(object.custom_properties["Target Object"])
        target_object = ezcache.get_object_by_id_cached(target_area, target_object_id)
        if target_object == nil then
            log('found warp in ' .. area_name .. ' with target area, but could not find target object')
            log('skipping current warp due to missing target object')
            warp_is_valid = false
        end
    end
    -- Note: This function is currently unused; triggers are set up in process_warp_object.
end

-- Shared function to process any warp object
local function process_warp_object(area_id, object)
    -- Add landing if it has Incoming Data
    if object.custom_properties["Incoming Data"] then
        local direction = object.custom_properties.Direction or "Down"
        local warp_in = property_is_true(object.custom_properties["Warp In"])
        add_landing(area_id, object.custom_properties["Incoming Data"],
                    object.x+0.5, object.y+0.5, object.z,
                    direction, warp_in, object.custom_properties["Arrival Animation"])
    end

    -- Set up the appropriate trigger based on type
    if object.type == "Radius Warp" then
        add_radius_warp(object, object.id, area_id, Net.get_area_name(area_id))
    elseif object.type == "Custom Warp" then
        add_custom_warp(object, object.id, area_id, Net.get_area_name(area_id))
    elseif object.type == "Interact Warp" then
        add_interact_warp(object, object.id, area_id, Net.get_area_name(area_id))
    end
end

-- Register handlers for all warp types with caching disabled
object_registry.register_handler("Radius Warp", process_warp_object, false)
object_registry.register_handler("Custom Warp", process_warp_object, false)
object_registry.register_handler("Interact Warp", process_warp_object, false)

function prepare_player_arrival(player_id,x,y,z,special_animation_name)
    local entry_x = x
    local entry_y = y
    local entry_z = z
    if special_animation_name then
        if special_animations[special_animation_name] then
            local special_animation = special_animations[special_animation_name]
            player_animations[player_id] = special_animation_name
            entry_x = entry_x + special_animation.pre_animation_offsets.x
            entry_y = entry_y + special_animation.pre_animation_offsets.y
            entry_z = entry_z + special_animation.pre_animation_offsets.z
            log('[Landings] stored arrival animation '..special_animation_name..' to run when player joins')
        end
    end
    return {x=entry_x,y=entry_y,z=entry_z}
end

function ezwarps.handle_player_request(player_id, data)
    -- Ensure the default area's landing is usable before initial entry.
    DefaultSpawnGuard.ensure_default_spawn()
    log('player '..player_id..' requested connection with data: '..data)
    if data == nil or data == "" then
        return
    end
    for key, l in next, landings do
        if data == key then
            local entry_pos = prepare_player_arrival(player_id,l["x"],l["y"],l["z"],l["arrival_animation"])
            Net.transfer_player(player_id, l["area_id"], l["warp_in"], entry_pos.x, entry_pos.y, entry_pos.z, l["direction"])
            log('transfering player to landing',data)
            return
        end
    end
    log('no landing for '..data)
end

function use_warp(player_id,warp_object,warp_meta)
    return async(function()
        local from_area = Net.get_player_area(player_id)
        -- Preserve the departure position before leave animations or transfer.
        -- Additional `warp` event metadata is backward-compatible with all
        -- existing consumers and enables the Endless Runner return trip.
        local from_position = Net.get_player_position(player_id)
        if type(from_position) == "table" then
            from_position = {
                x = from_position.x,
                y = from_position.y,
                z = from_position.z or 0,
            }
        else
            from_position = nil
        end
        local warp_properties = warp_object.custom_properties
        local is_valid_warp = false
        local is_remote_warp = false

        if warp_properties.Address and warp_properties.Port then
            is_remote_warp = true
            is_valid_warp = true
        end

        local target_object_id = warp_object.custom_properties["Target Object"]
        local target_area = warp_object.custom_properties["Target Area"]

        if target_object_id ~= nil and target_area ~= nil then
            is_remote_warp = false
            is_valid_warp = true
        end

        -- Normalize Dont Teleport to a real boolean before using it anywhere.
        local dont_teleport = property_is_true(warp_object.custom_properties["Dont Teleport"])

        if dont_teleport then
            is_valid_warp = true
        end

        if is_valid_warp == false then
            log('warp '..warp_object.id..' is invalid')
            return
        end

        local warp_out = property_is_true(warp_properties["Warp Out"])
        local warp_in = property_is_true(warp_properties["Warp In"])
        local data = warp_properties.Data

        -- Play leave animation if specified
        if warp_properties["Leave Animation"] and warp_properties["Leave Animation"] ~= "" then
            await(doAnimationForWarp(player_id, warp_properties["Leave Animation"], true, warp_object))
        end

        -- ----------------------------------------------------------------------
        -- Pre‑transfer Size Mode adjustment (immediate)
        -- Apply the target area's Size Mode (Compress / Normalize / Enlarge) to
        -- the player before the transfer so they arrive already at the correct
        -- scale (no visible pop). When the target area's Size Mode Scope is
        -- Area Wide, apply_map_property also re-syncs NPCs in that area; this
        -- is idempotent with ezpress's bot_created handling and with the
        -- arrival-time handle_player_transfer, so it is always safe to call.
        -- ----------------------------------------------------------------------
        if target_area and not is_remote_warp then
            local ezpress = require('scripts/ezlibs-scripts/ezpress')
            ezpress.apply_map_property(player_id, target_area, true, {
                source = "warp_pretransfer"
            })
        end

        -- Perform the warp
        if is_remote_warp then
            Net.transfer_server(player_id, warp_properties.Address, warp_properties.Port, warp_out, data)
            ezbus:emit("warp", {
                player_id = player_id,
                from_area = from_area,
                from_position = from_position,
                to_area = warp_properties.Address,
                warp_type = "server"
            })
        else
            local direction = "Down"
            local arrival_animation_name = nil
            if target_object_id and not dont_teleport then
                local target_id_str = tostring(target_object_id)
                local target_object = ezcache.get_object_by_id_cached(target_area, target_id_str)
                if not target_object then
                    log('ERROR: target object not found! ID: ' .. target_id_str .. ' in area: ' .. target_area)
                    LegacyCapture.unlock(player_id, "ezwarps")
                    return
                end
                if target_object.custom_properties["Direction"] then
                    direction = target_object.custom_properties["Direction"]
                end
                arrival_animation_name = target_object.custom_properties["Arrival Animation"]
                if arrival_animation_name then
                    local entry_pos = prepare_player_arrival(player_id, target_object.x, target_object.y, target_object.z, arrival_animation_name)
                    Net.transfer_player(player_id, target_area, warp_in, entry_pos.x, entry_pos.y, entry_pos.z, direction)
                else
                    Net.transfer_player(player_id, target_area, true, target_object.x+0.5, target_object.y+0.5, target_object.z, direction)
                end
            else
                log('unable to transfer, no target object or Dont Teleport is enabled')
            end
            ezbus:emit("warp", {
                player_id = player_id,
                from_area = from_area,
                from_position = from_position,
                from_warp_object_id = tostring(warp_object.id),
                to_area = target_area,
                warp_type = "custom"
            })
        end
    end)
end

function ezwarps.handle_custom_warp(player_id, object_id)
    if ezwarps.player_is_in_animation(player_id) then
        return
    end
    local player_area = Net.get_player_area(player_id)
    local guard = return_warp_guards[player_id]
    if guard and guard.area == player_area
        and guard.object_id == tostring(object_id) then
        local pos = Net.get_player_position(player_id)
        if type(pos) == "table" then
            update_return_warp_guard(player_id, player_area, pos.x, pos.y)
        end
        if return_warp_guards[player_id] then
            log('[return-guard] suppressed repeat entry player=' .. tostring(player_id)
                .. ' area=' .. tostring(player_area)
                .. ' warp=' .. tostring(object_id))
            return
        end
    end
    local object = ezcache.get_object_by_id_cached(player_area, tostring(object_id))
    if not object then
        return
    end
    local target_object = object.custom_properties["Target Object"]
    local target_area = object.custom_properties["Target Area"]
    if not (target_area and target_object) then
        return
    end
    use_warp(player_id,object)
end

function ezwarps.handle_player_join(player_id)
    -- Rescue only players stranded at the empty origin of the default map.
    DefaultSpawnGuard.recover_new_arrival(player_id)
    if player_animations[player_id] then
        doAnimationForWarp(player_id,player_animations[player_id],false)
        player_animations[player_id] = nil
    end
end

function ezwarps.player_is_in_animation(player_id)
    if players_in_animations[player_id] then
        return true
    end
    return false
end

function ezwarps.handle_player_transfer(player_id)
    if player_animations[player_id] then
        doAnimationForWarp(player_id,player_animations[player_id])
    end
end

-- The server may construct the first player immediately after plugin startup.
DefaultSpawnGuard.ensure_default_spawn()

log('Loaded')

return ezwarps