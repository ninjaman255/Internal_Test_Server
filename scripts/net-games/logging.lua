-- Domain-scoped Logger configuration for Net Games.
-- All subsystem streams mirror to scripts/_DEBUGGING/net-games/_FULL-log.log.
-- No global print interception or tick-based polling.
local Logger = require("scripts/logger/logger")
local Log = {}
local names = {
    ["DIALOGUE"] = true, ["PROMPT"] = true, ["VERTICAL-MENU"] = true,
    ["TALK-MENU"] = true, ["BOT"] = true, ["DEMO-PROGS"] = true,
    ["VISUALS"] = true, ["NAMEPLATE"] = true, ["INPUT"] = true,
    ["MENU"] = true, ["STARTUP"] = true,
}
local streams = {}
function Log.get(subsystem)
    assert(type(subsystem) == "string" and names[subsystem],
        "[net-games/logging] unknown subsystem: " .. tostring(subsystem))
    if not streams[subsystem] then
        streams[subsystem] = Logger.register_subsystem("net-games", subsystem,
            {console = false, maxBufferSize = 1})
    end
    return streams[subsystem]
end
return Log
