-- ezmapinstance.lua
-- Reusable map cloning, instance ownership, host/party metadata, and lifecycle.
--
-- This module intentionally does not register Net event handlers. Call its API
-- from a plugin or game module that owns the instance's gameplay behavior.

local EzMapInstance = {}

local instances = {}
local player_to_instance = {}

local function valid_id(value)
    return type(value) == "string" and value ~= ""
end

local function copy_array(values)
    local result = {}
    if type(values) == "table" then
        for _, value in ipairs(values) do
            result[#result + 1] = value
        end
    end
    return result
end

local function area_id_is_listed(area_id)
    if not Net or type(Net.list_areas) ~= "function" then
        return false
    end

    local ok, area_ids = pcall(Net.list_areas)
    if not ok or type(area_ids) ~= "table" then
        return false
    end

    for _, listed_id in ipairs(area_ids) do
        if listed_id == area_id then
            return true
        end
    end

    return false
end

local function find_available_id(preferred_id)
    local base_id = tostring(preferred_id)
    local candidate = base_id
    local suffix = 1

    while instances[candidate] or area_id_is_listed(candidate) do
        candidate = base_id .. tostring(suffix)
        suffix = suffix + 1
    end

    return candidate
end

local function forget_player(instance_id, player_id)
    if player_to_instance[player_id] == instance_id then
        player_to_instance[player_id] = nil
    end
end

--- Clone a source area and register a new logical instance.
--- Returns instance_record on success, or nil, error_message on failure.
---
--- options:
---   host_id     - ID of the instance host/leader
---   player_ids  - initial player IDs (ordered; host defaults to first member)
---   party_id    - optional external party identifier
---   metadata    - optional caller-owned metadata table
function EzMapInstance.create(base_area_id, preferred_instance_id, options)
    options = options or {}

    if not valid_id(base_area_id) then
        return nil, "base_area_id must be a non-empty string"
    end
    if not valid_id(preferred_instance_id) then
        return nil, "preferred_instance_id must be a non-empty string"
    end
    if type(options) ~= "table" then
        return nil, "options must be a table"
    end
    if not Net or type(Net.clone_area) ~= "function" then
        return nil, "Net.clone_area is unavailable"
    end

    local instance_id = find_available_id(preferred_instance_id)
    local ok, clone_result = pcall(Net.clone_area, base_area_id, instance_id)
    if not ok then
        return nil, "Net.clone_area failed: " .. tostring(clone_result)
    end
    if clone_result == false then
        return nil, "Net.clone_area reported failure"
    end

    local player_ids = copy_array(options.player_ids)
    local host_id = options.host_id
    if host_id == nil then
        host_id = player_ids[1]
    end

    local record = {
        id = instance_id,
        area_id = instance_id,
        base_area_id = base_area_id,
        host_id = host_id,
        party_id = options.party_id,
        player_ids = player_ids,
        metadata = options.metadata or {},
        created_at = os.time(),
        removed = false
    }

    instances[instance_id] = record
    for _, player_id in ipairs(player_ids) do
        if player_id ~= nil then
            player_to_instance[player_id] = instance_id
        end
    end

    return record
end

--- Return an instance record by its cloned area ID.
function EzMapInstance.get(instance_id)
    return instances[instance_id]
end

--- Return the instance record currently associated with a player ID.
function EzMapInstance.get_for_player(player_id)
    local instance_id = player_to_instance[player_id]
    if instance_id == nil then
        return nil
    end
    return instances[instance_id]
end

--- Return a shallow array of all registered instance records.
function EzMapInstance.list()
    local result = {}
    for _, record in pairs(instances) do
        result[#result + 1] = record
    end
    return result
end

--- Set or change the recorded host. The caller controls host election policy.
function EzMapInstance.set_host(instance_id, player_id)
    local record = instances[instance_id]
    if not record then
        return false, "instance not found"
    end
    record.host_id = player_id
    return true
end

function EzMapInstance.get_host(instance_id)
    local record = instances[instance_id]
    return record and record.host_id or nil
end

function EzMapInstance.is_host(instance_id, player_id)
    local record = instances[instance_id]
    return record ~= nil and record.host_id == player_id
end

--- Add a player to an instance's membership tracking.
function EzMapInstance.register_player(instance_id, player_id)
    local record = instances[instance_id]
    if not record then
        return false, "instance not found"
    end
    if player_id == nil then
        return false, "player_id is required"
    end

    local previous_instance_id = player_to_instance[player_id]
    if previous_instance_id and previous_instance_id ~= instance_id then
        EzMapInstance.unregister_player(previous_instance_id, player_id)
    end

    for _, existing_id in ipairs(record.player_ids) do
        if existing_id == player_id then
            player_to_instance[player_id] = instance_id
            return true
        end
    end

    record.player_ids[#record.player_ids + 1] = player_id
    player_to_instance[player_id] = instance_id
    return true
end

--- Remove a player from membership tracking. This does not transfer the player.
function EzMapInstance.unregister_player(instance_id, player_id)
    local record = instances[instance_id]
    if not record then
        forget_player(instance_id, player_id)
        return false, "instance not found"
    end

    for index = #record.player_ids, 1, -1 do
        if record.player_ids[index] == player_id then
            table.remove(record.player_ids, index)
        end
    end
    forget_player(instance_id, player_id)

    if record.host_id == player_id then
        record.host_id = record.player_ids[1]
    end
    return true
end

--- Transfer a player to the cloned area at an explicit position.
--- Coordinates are required because spawn selection belongs to the caller.
function EzMapInstance.transfer_player(instance_id, player_id, x, y, z, warp_in)
    local record = instances[instance_id]
    if not record then
        return false, "instance not found"
    end
    if player_id == nil or type(x) ~= "number" or type(y) ~= "number" or type(z) ~= "number" then
        return false, "player_id and numeric x/y/z coordinates are required"
    end
    if not Net or type(Net.transfer_player) ~= "function" then
        return false, "Net.transfer_player is unavailable"
    end

    local should_warp_in = warp_in or true

    local ok, transfer_result = pcall(Net.transfer_player, player_id, instance_id, should_warp_in, x, y, z)
    if not ok then
        return false, "Net.transfer_player failed: " .. tostring(transfer_result)
    end
    if transfer_result == false then
        return false, "Net.transfer_player reported failure"
    end

    EzMapInstance.register_player(instance_id, player_id)
    return true
end

--- Remove the cloned area and its registry entries.
--- Removal is idempotent for records created through this module.
function EzMapInstance.remove(instance_id)
    local record = instances[instance_id]
    if record == nil then
        return false, "instance not found"
    end
    if record.removed then
        return true
    end

    record.removed = true
    if Net and type(Net.remove_area) == "function" then
        local ok, remove_result = pcall(Net.remove_area, instance_id)
        if not ok then
            record.removed = false
            return false, "Net.remove_area failed: " .. tostring(remove_result)
        end
        if remove_result == false then
            record.removed = false
            return false, "Net.remove_area reported failure"
        end
    else
        record.removed = false
        return false, "Net.remove_area is unavailable"
    end

    for _, player_id in ipairs(record.player_ids) do
        forget_player(instance_id, player_id)
    end
    instances[instance_id] = nil
    return true
end

return EzMapInstance
