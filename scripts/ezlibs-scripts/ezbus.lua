-- ezbus.lua - Named event-bus registry.
--
-- Three usage modes are supported:
--
--   1. Named emitters (recommended for cross-script communication)
--        local EzBus = require("scripts/ezlibs-scripts/ezbus")
--        local round_bus = EzBus.get("footbomb:round:" .. instance_id)
--        round_bus:emit("round_complete", { ... })
--
--      Any other script can call EzBus.get(name) to reach the SAME emitter.
--      Call EzBus.destroy(name) when the consumer is finished (e.g. instance
--      removal) so the entry does not leak.
--
--   2. Fresh per-use emitters (per-round, per-response, etc.)
--        local round_events = EzBus.new()
--
--   3. Backward-compatible default emitter
--        local EzBus = require("scripts/ezlibs-scripts/ezbus")
--        EzBus:on("some_event", cb)
--        EzBus:emit("some_event", data)
--
--      Every EzEmitter method (on/once/emit/... ) proxies to an unnamed
--      default emitter, so code that treated ezbus as a single global bus
--      keeps working. Use `:` method-call syntax as with any Lua object.
--
-- Lifecycle helpers:
--   EzBus.get(name)          -> emitter  (creates on first use)
--   EzBus.destroy(name)      -> true if a bus existed and was destroyed
--   EzBus.destroy_all()      -> destroys and forgets every named bus
--   EzBus.exists(name)       -> boolean
--   EzBus.list()             -> sorted array of registered names
--   EzBus.new()              -> fresh, unregistered emitter (old factory)

local EzEmitter = require("scripts/ezlibs-scripts/ezemitter")

local named = {}
local default = EzEmitter.new()

local ezbus = {}

-- Factory (backward compat). EzBus.new() -> fresh EventEmitter.
ezbus.new = EzEmitter.new

-- Retrieve (or lazily create) a named emitter. `nil`/"" returns the default
-- unnamed emitter so callers can pass an optional name.
function ezbus.get(name)
    if name == nil or name == "" then return default end
    local bus = named[name]
    if not bus then
        bus = EzEmitter.new()
        named[name] = bus
    end
    return bus
end

-- Destroy a named bus and drop the registry entry. Does NOT touch the
-- default emitter. Returns true if a bus was actually removed.
function ezbus.destroy(name)
    if name == nil or name == "" then return false end
    local bus = named[name]
    if not bus then return false end
    named[name] = nil
    bus:destroy()
    return true
end

-- Destroy every named bus. The default emitter is preserved.
function ezbus.destroy_all()
    local snapshot = {}
    for name, bus in pairs(named) do snapshot[#snapshot + 1] = { name, bus } end
    named = {}
    for _, entry in ipairs(snapshot) do entry[2]:destroy() end
end

function ezbus.exists(name)
    if name == nil or name == "" then return true end  -- default always exists
    return named[name] ~= nil
end

function ezbus.list()
    local names = {}
    for n in pairs(named) do names[#names + 1] = n end
    table.sort(names)
    return names
end

-- Proxy any EventEmitter method (on/once/emit/... ) to the default emitter,
-- so legacy callers that did `EzBus:on(...)` continue to work.
-- Callers must use `:` syntax; `EzBus.on(x, cb)` was already broken before
-- this rewrite because it resolves to EventEmitter.on with self=x.
setmetatable(ezbus, {
    __index = function(_, key)
        local v = default[key]
        if type(v) == "function" then
            -- self is the ezbus table for `:` calls; call the method on the
            -- real default emitter so its internal state is used.
            return function(_, ...) return v(default, ...) end
        end
        return v
    end,
    __newindex = function(_, key, value)
        -- Fields on `default` (like `_on_error`) are the source of truth.
        default[key] = value
    end,
})

return ezbus