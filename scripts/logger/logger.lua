-- logger.lua – Flexible logging module with per‑logger configuration.
-- Uses append‑only JSON Lines format – each entry is written as a new line.
-- Supports buffering, periodic writes, and optional deduplication of repeated messages.
-- No longer depends on persistence.lua.

local json = require('scripts/libs/json')

local loggers = {}
local next_check = 0
local CHECK_INTERVAL = 0.5

-- OS‑aware directory creation helper (same as the others)
local is_windows = package.config:sub(1,1) == '\\'

local function ensure_directory_exists(filePath)
    local normalized = filePath:gsub("\\", "/")
    local dir = normalized:match("^(.*)/[^/]*$")
    if not dir or dir == "" then return end

    if file and file.CreateDir then
        file.CreateDir(dir)
        return
    end

    local cmd
    if is_windows then
        cmd = 'mkdir "' .. dir .. '" 2>nul'
    else
        cmd = 'mkdir -p "' .. dir .. '" 2>/dev/null'
    end
    os.execute(cmd)
end

-- Helper to get current timestamp as string
local function timestamp()
    return os.date("%Y-%m-%d %H:%M:%S")
end

-- ============================================================
-- NEW: Custom JSON encoder with fixed field order
-- ============================================================
local function encode_entry(entry)
    -- Escape JSON string characters
    local function escape(s)
        return s:gsub("\\", "\\\\")
               :gsub('"', '\\"')
               :gsub("\n", "\\n")
               :gsub("\r", "\\r")
               :gsub("\t", "\\t")
    end

    local fields = {
        string.format('"timestamp":"%s"', escape(entry.timestamp)),
        string.format('"level":"%s"', escape(entry.level)),
        string.format('"msg":"%s"', escape(entry.msg)),
    }
    if entry.data then
        table.insert(fields, '"data":' .. json.encode(entry.data))
    end
    return "{" .. table.concat(fields, ",") .. "}"
end

-- Logger metatable
local LoggerMT = {}
LoggerMT.__index = LoggerMT

-- Create a new logger instance
---@param config table
---@field filePath string           # required: path to log file
---@field minLevel? string          # "debug", "info", "warn", "error" (default "info")
---@field flushInterval? number     # seconds between writes (default 2.0)
---@field maxBufferSize? number     # max messages before forcing flush (default 100)
---@field logIfChanged? boolean     # only log if message differs from last (default false)
function createLogger(config)
    if not config.filePath then
        error("logger: filePath is required")
    end

    local self = setmetatable({}, LoggerMT)

    self.filePath = config.filePath
    self.minLevel = config.minLevel or "info"
    self.flushInterval = config.flushInterval or 2.0
    self.maxBufferSize = config.maxBufferSize or 100
    self.logIfChanged = config.logIfChanged or false

    -- Level priority mapping
    self.levelPriority = {
        debug = 1,
        info  = 2,
        warn  = 3,
        error = 4,
    }

    -- Internal state
    self.buffer = {}
    self.lastFlush = os.clock()
    self.lastMessages = {}   -- for deduplication

    -- Register this logger
    table.insert(loggers, self)

    return self
end

-- Internal method to check if a message should be logged based on level
function LoggerMT:shouldLog(level)
    local msgPriority = self.levelPriority[level]
    local minPriority = self.levelPriority[self.minLevel] or 2
    return msgPriority and msgPriority >= minPriority
end

-- Internal method to add an entry to buffer
function LoggerMT:addEntry(level, msg, data)
    if not self:shouldLog(level) then return end

    -- Deduplicate if enabled and message unchanged for this level
    if self.logIfChanged then
        local last = self.lastMessages[level]
        if last == msg then
            return  -- skip, same as last
        end
        self.lastMessages[level] = msg
    end

    local entry = {
        timestamp = timestamp(),
        level = level,
        msg = msg,
    }
    if data and type(data) == "table" then
        entry.data = data
    end

    table.insert(self.buffer, entry)

    -- If buffer exceeds max size, trigger flush immediately
    if #self.buffer >= self.maxBufferSize then
        self:flush()
    end
end

-- Flush buffered entries to file (append‑only)
function LoggerMT:flush()
    if #self.buffer == 0 then return end

    -- Ensure the directory exists before opening the file
    ensure_directory_exists(self.filePath)

    local file, err = io.open(self.filePath, "a")
    if not file then
        print("Logger: failed to open " .. self.filePath .. " for append: " .. tostring(err))
        return
    end

    -- Write each entry as a JSON‑encoded line
    for _, entry in ipairs(self.buffer) do
        -- === CHANGED: use our custom encoder with fixed order ===
        local line = encode_entry(entry) .. "\n"
        file:write(line)
    end

    file:close()

    self.buffer = {}
    self.lastFlush = os.clock()
end

-- Public logging methods
function LoggerMT:debug(msg, data) self:addEntry("debug", msg, data) end
function LoggerMT:info(msg, data)  self:addEntry("info", msg, data) end
function LoggerMT:warn(msg, data)  self:addEntry("warn", msg, data) end
function LoggerMT:error(msg, data) self:addEntry("error", msg, data) end

-- Force flush now (useful before shutdown)
function LoggerMT:forceFlush()
    if #self.buffer == 0 then return end
    self:flush()
end

-- Global tick handler: check all loggers and flush if interval passed
Net:on("tick", function(event)
    local now = os.clock()
    -- Only check every CHECK_INTERVAL seconds to avoid overhead
    if now - next_check < CHECK_INTERVAL then return end
    next_check = now

    for _, logger in ipairs(loggers) do
        if #logger.buffer > 0 then
            if now - logger.lastFlush >= logger.flushInterval then
                logger:flush()
            end
        end
    end
end)

return createLogger