-- ezdebug.lua
-- Small logger wrapper. By default it writes to standard output.
-- Host-specific logging can be supplied as a callback.

local ezdebug = {
    enabled = true,
    prefix = "[ezlibs]",
    sink = print
}

function ezdebug.configure(options)
    assert(type(options) == "table", "options must be a table")

    if options.enabled ~= nil then
        assert(type(options.enabled) == "boolean", "enabled must be a boolean")
        ezdebug.enabled = options.enabled
    end
    if options.prefix ~= nil then
        assert(type(options.prefix) == "string", "prefix must be a string")
        ezdebug.prefix = options.prefix
    end
    if options.sink ~= nil then
        assert(type(options.sink) == "function", "sink must be a function")
        ezdebug.sink = options.sink
    end
end

local function write(level, ...)
    if not ezdebug.enabled then return end

    local parts = {}
    for index = 1, select("#", ...) do
        parts[#parts + 1] = tostring(select(index, ...))
    end

    ezdebug.sink(ezdebug.prefix .. " [" .. level .. "] " .. table.concat(parts, " "))
end

function ezdebug.info(...) write("INFO", ...) end
function ezdebug.warn(...) write("WARN", ...) end
function ezdebug.error(...) write("ERROR", ...) end

function ezdebug.traceback(message, level)
    return debug.traceback(tostring(message or ""), (level or 1) + 1)
end

return ezdebug
