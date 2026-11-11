-- default_spawn_guard.lua
-- Protect initial connections from landing at the empty (0,0) origin of
-- areas/default.tmx. Does NOT modify mission instances, other maps, or
-- valid preconfigured spawn positions.
--
-- The default map has its populated tiles away from the origin and already
-- contains a point called "Liberation Respawn" on its walkable map area.
-- This guard only uses that point if the engine default spawn is missing or
-- near the known-empty origin. It does not persist user positions.

local log = require("scripts/logger/logger").register("ezwarps"):register_subsystem("spawn-guard")
local Guard = {}

local DEFAULT_AREA = "default"
local FALLBACK_OBJECT = "Liberation Respawn"
local EMPTY_ORIGIN_RADIUS = 1.5

local function read_net(method, ...)
    if not Net or type(Net[method]) ~= "function" then
        return nil
    end
    local ok, value = pcall(Net[method], ...)
    if ok then return value end
    return nil
end

local function valid_position(value)
    return type(value) == "table"
        and type(value.x) == "number"
        and type(value.y) == "number"
        and value.x == value.x and value.y == value.y
end

local function at_empty_default_origin(pos)
    return not valid_position(pos)
        or (math.abs(pos.x) <= EMPTY_ORIGIN_RADIUS
            and math.abs(pos.y) <= EMPTY_ORIGIN_RADIUS)
end

local function fallback_position()
    local point = read_net("get_object_by_name", DEFAULT_AREA, FALLBACK_OBJECT)
    if not valid_position(point) then
        return nil
    end
    return {
        x = point.x,
        y = point.y,
        z = tonumber(point.z) or 0,
    }
end

function Guard.ensure_default_spawn()
    local current = read_net("get_spawn_position", DEFAULT_AREA)
    if not at_empty_default_origin(current) then
        return current, false
    end

    local destination = fallback_position()
    if not destination or at_empty_default_origin(destination) then
        log:warn("[default-spawn] Default spawn is missing/empty but no safe 'Liberation Respawn' was found")
        return nil, false
    end
    if not Net or type(Net.set_spawn_position) ~= "function" then
        log:warn("[default-spawn] Net.set_spawn_position is not available")
        return nil, false
    end

    local ok, result = pcall(Net.set_spawn_position,
        DEFAULT_AREA, destination.x, destination.y, destination.z)
    if not ok or result == false then
        log:warn("[default-spawn] Unable to set default spawn: " .. tostring(result))
        return nil, false
    end
    log:info("[default-spawn] Corrected default area spawn to point '" .. FALLBACK_OBJECT
        .. "' at " .. tostring(destination.x) .. ", " .. tostring(destination.y)
        .. ", " .. tostring(destination.z))
    return destination, true
end

-- The player_join callback runs after the client enters its initial map.
-- This is a last resort for a client that was placed at (0,0) before the
-- server could update its default spawn. Never touch a normal location.
function Guard.recover_new_arrival(player_id)
    local area = read_net("get_player_area", player_id)
    if area ~= DEFAULT_AREA then return false end

    local position = read_net("get_player_position", player_id)
    local configured = read_net("get_spawn_position", DEFAULT_AREA)
    log:info("[default-spawn] JOIN DIAG player=" .. tostring(player_id)
        .. " area=default position=" .. tostring(position and position.x)
        .. "," .. tostring(position and position.y)
        .. "," .. tostring(position and position.z)
        .. " configured_spawn=" .. tostring(configured and configured.x)
        .. "," .. tostring(configured and configured.y)
        .. "," .. tostring(configured and configured.z))
    if not at_empty_default_origin(position) then return false end

    local safe = Guard.ensure_default_spawn()
    if not valid_position(safe) or at_empty_default_origin(safe) then
        log:warn("[default-spawn] Unable to recover player " .. tostring(player_id)
            .. ": default spawn could not be resolved")
        return false
    end

    local ok, result
    if Net and type(Net.teleport_player) == "function" then
        ok, result = pcall(Net.teleport_player, player_id, false,
            safe.x, safe.y, safe.z)
    elseif Net and type(Net.set_player_position) == "function" then
        ok, result = pcall(Net.set_player_position, player_id,
            safe.x, safe.y, safe.z)
    else
        log:warn("[default-spawn] No supported local player positioning API")
        return false
    end
    if not ok or result == false then
        log:warn("[default-spawn] Recovery positioning failed: " .. tostring(result))
        return false
    end
    log:info("[default-spawn] Recovered joining player " .. tostring(player_id)
        .. " from empty default area origin")
    return true
end

return Guard
