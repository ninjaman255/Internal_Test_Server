-- ezmapinstance.lua
-- Reusable map cloning, instance ownership, host/party metadata, and lifecycle.
--
-- This module intentionally does not register Net event handlers. Call its API
-- from a plugin or game module that owns the instance's gameplay behavior.
--
-- Event surfaces (backed by ezemitter):
--
--   EzMapInstance.events            -- global; every instance event, args begin with instance_id
--   record.events / record:on(...)  -- per-instance; args omit instance_id
--
-- Built-in lifecycle events (emitted on both surfaces):
--
--   "created"             record: ()                        global: (instance_id)
--   "removed"             record: ()                        global: (instance_id)
--   "player_joined"       record: (player_id)               global: (instance_id, player_id)
--   "player_left"         record: (player_id)               global: (instance_id, player_id)
--   "host_changed"        record: (new, old)                global: (instance_id, new, old)
--   "player_transferred"  record: (player_id, x, y, z)      global: (instance_id, player_id, x, y, z)
--
-- Custom events may be emitted with EzMapInstance.emit(...) or record:emit(...).
-- Custom events are NOT mirrored across surfaces automatically.

local EventEmitter
do
    local loaded
    if type(require) == "function" then
        local ok, module = pcall(require, "scripts/ezlibs-scripts/ezemitter")
        if ok and type(module) == "table" and type(module.new) == "function" then
            loaded = module
        end
    end
    if not loaded and type(rawget(_G, "EventEmitter")) == "table" then
        loaded = rawget(_G, "EventEmitter")
    end
    if not loaded then
        error("ezmapinstance: ezemitter module is required")
    end
    EventEmitter = loaded
end

local EzMapInstance = {}

-- Event name constants (for discoverability and typo protection).
EzMapInstance.EVENT = {
    CREATED            = "created",
    REMOVED            = "removed",
    PLAYER_JOINED      = "player_joined",
    PLAYER_LEFT        = "player_left",
    HOST_CHANGED       = "host_changed",
    PLAYER_TRANSFERRED = "player_transferred",
}

-- Global emitter (all instances).
EzMapInstance.events = EventEmitter.new()

local instances = {}
-- instances.__index = instances
local player_to_instance = {}
local record_mt = {}
record_mt.__index = record_mt
local error_handler = function() end

--- Route listener errors somewhere safe. Defaults to silent no-op.
function EzMapInstance.set_error_handler(handler)
    error_handler = type(handler) == "function" and handler or function() end
end

local function safe_emit(emitter, ...)
    if not emitter then return end
    local ok, err = pcall(emitter.emit, emitter, ...)
    if not ok then
        pcall(error_handler, tostring(err))
    end
end

--- Fire an event on both the per-instance and global emitters.
local function emit_event(record, event, ...)
    if record.events then
        safe_emit(record.events, event, ...)
    end
    safe_emit(EzMapInstance.events, event, record.id, ...)
end

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

-- ---------------------------------------------------------------------------
-- Per-record convenience methods (delegate to record.events)
-- ---------------------------------------------------------------------------

function record_mt:on(event, callback)
    if self.events then self.events:on(event, callback) end
    return self
end

function record_mt:once(event, callback)
    if self.events then self.events:once(event, callback) end
    return self
end

function record_mt:on_any(callback)
    if self.events then self.events:on_any(callback) end
    return self
end

function record_mt:on_any_once(callback)
    if self.events then self.events:on_any_once(callback) end
    return self
end

function record_mt:off(event, callback)
    if self.events then self.events:remove_listener(event, callback) end
    return self
end

function record_mt:off_any(callback)
    if self.events then self.events:remove_on_any_listener(callback) end
    return self
end

--- Emit a custom event on this instance only.
function record_mt:emit(event, ...)
    if not self.events then return self end
    local ok, err = pcall(self.events.emit, self.events, event, ...)
    if not ok then pcall(error_handler, tostring(err)) end
    return self
end

--- Create an async iterator scoped to a single event on this instance.
function record_mt:async_iter(event)
    if not self.events then return nil end
    return self.events:async_iter(event)
end

--- Create an async iterator for every event on this instance.
function record_mt:async_iter_all()
    if not self.events then return nil end
    return self.events:async_iter_all()
end

-- ---------------------------------------------------------------------------
-- Global convenience methods (delegate to EzMapInstance.events)
-- ---------------------------------------------------------------------------

function EzMapInstance.on(event, callback)
    EzMapInstance.events:on(event, callback)
    return EzMapInstance
end

function EzMapInstance.once(event, callback)
    EzMapInstance.events:once(event, callback)
    return EzMapInstance
end

function EzMapInstance.on_any(callback)
    EzMapInstance.events:on_any(callback)
    return EzMapInstance
end

function EzMapInstance.on_any_once(callback)
    EzMapInstance.events:on_any_once(callback)
    return EzMapInstance
end

function EzMapInstance.off(event, callback)
    EzMapInstance.events:remove_listener(event, callback)
    return EzMapInstance
end

function EzMapInstance.off_any(callback)
    EzMapInstance.events:remove_on_any_listener(callback)
    return EzMapInstance
end

--- Emit a custom event on the global surface only.
function EzMapInstance.emit(event, ...)
    local ok, err = pcall(EzMapInstance.events.emit, EzMapInstance.events, event, ...)
    if not ok then pcall(error_handler, tostring(err)) end
    return EzMapInstance
end

--- Async iterator for a single event across all instances.
function EzMapInstance.async_iter(event)
    return EzMapInstance.events:async_iter(event)
end

--- Async iterator for every instance event.
function EzMapInstance.async_iter_all()
    return EzMapInstance.events:async_iter_all()
end

-- ---------------------------------------------------------------------------
-- Lifecycle API
-- ---------------------------------------------------------------------------

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

    local record = setmetatable({
        id = instance_id,
        area_id = instance_id,
        base_area_id = base_area_id,
        host_id = host_id,
        party_id = options.party_id,
        player_ids = player_ids,
        metadata = options.metadata or {},
        created_at = os.time(),
        removed = false,
        events = EventEmitter.new(),
    }, record_mt)

    instances[instance_id] = record
    for _, player_id in ipairs(player_ids) do
        if player_id ~= nil then
            player_to_instance[player_id] = instance_id
        end
    end

    emit_event(record, EzMapInstance.EVENT.CREATED)
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
--- Emits "host_changed" when the host actually changes.
function EzMapInstance.set_host(instance_id, player_id)
    local record = instances[instance_id]
    if not record then
        return false, "instance not found"
    end
    local previous_host_id = record.host_id
    record.host_id = player_id
    if previous_host_id ~= player_id then
        emit_event(record, EzMapInstance.EVENT.HOST_CHANGED, player_id, previous_host_id)
    end
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
--- Emits "player_joined" only for newly-added members (not for re-registration).
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
    emit_event(record, EzMapInstance.EVENT.PLAYER_JOINED, player_id)
    return true
end

--- Remove a player from membership tracking. This does not transfer the player.
--- Emits "player_left" if the player was a member, and "host_changed" if the
--- leaving player was the host.
function EzMapInstance.unregister_player(instance_id, player_id)
    local record = instances[instance_id]
    if not record then
        forget_player(instance_id, player_id)
        return false, "instance not found"
    end

    local removed = false
    for index = #record.player_ids, 1, -1 do
        if record.player_ids[index] == player_id then
            table.remove(record.player_ids, index)
            removed = true
        end
    end
    forget_player(instance_id, player_id)

    if removed then
        emit_event(record, EzMapInstance.EVENT.PLAYER_LEFT, player_id)
    end

    if record.host_id == player_id then
        local previous_host_id = record.host_id
        record.host_id = record.player_ids[1]
        if previous_host_id ~= record.host_id then
            emit_event(record, EzMapInstance.EVENT.HOST_CHANGED, record.host_id, previous_host_id)
        end
    end
    return true
end

--- Transfer a player to the cloned area at an explicit position.
--- Coordinates are required because spawn selection belongs to the caller.
--- Emits "player_joined" (via register_player) and "player_transferred".
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
    emit_event(record, EzMapInstance.EVENT.PLAYER_TRANSFERRED, player_id, x, y, z)
    return true
end

--- Remove the cloned area and its registry entries.
--- Removal is idempotent for records created through this module.
--- Emits "removed" on both surfaces before state is torn down.
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

    -- Fire before tearing down state so listeners can still inspect the record.
    emit_event(record, EzMapInstance.EVENT.REMOVED)

    for _, player_id in ipairs(record.player_ids) do
        forget_player(instance_id, player_id)
    end
    instances[instance_id] = nil

    -- Release any pending async iterators / listeners on the per-instance emitter.
    if record.events then
        record.events:destroy()
    end

    return true
end

return EzMapInstance
