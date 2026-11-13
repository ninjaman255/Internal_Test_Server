-- Domain-scoped Logger configuration for Displayer.
-- Streams mirror to scripts/_DEBUGGING/displayer/_FULL-log.log.
local Logger = require("scripts/logger/logger")
local Log = {}
local names = {
    ["CORE"] = true, ["FONT"] = true, ["TEXT"] = true,
    ["TIMER"] = true, ["SLICED-SPRITE"] = true,
    ["SCROLLING-TEXT"] = true, ["SCROLLING-SPRITE"] = true,
}
local streams = {}
function Log.get(subsystem)
    assert(type(subsystem) == "string" and names[subsystem],
        "[displayer/logging] unknown subsystem: " .. tostring(subsystem))
    if not streams[subsystem] then
        streams[subsystem] = Logger.register_subsystem("displayer", subsystem,
            {console = false, maxBufferSize = 1})
    end
    return streams[subsystem]
end
return Log
