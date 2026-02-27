--[[
logger.lua – Flexible logging module with per‑logger configuration.
Uses persistence.lua to store logs as JSON files.
Supports buffering, periodic writes, and optional deduplication of repeated messages.
]]

local persistence = require("scripts/persistence/persistence")  -- returns a function that creates a persistence instance

local loggers = {}          -- all active logger instances
local next_check = 0        -- next tick time to check flushes (coarse)
local CHECK_INTERVAL = 0.5  -- check every 0.5 seconds

-- Helper to get current timestamp as string
local function timestamp()
    return os.date("%Y-%m-%d %H:%M:%S")
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
---@field pretty? boolean           # pretty‑print JSON (default true)
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
    self.pretty = (config.pretty ~= false)  -- default true

    -- Level priority mapping
    self.levelPriority = {
        debug = 1,
        info  = 2,
        warn  = 3,
        error = 4,
    }

    -- Internal state
    self.buffer = {}               -- buffered log entries (will be appended to persistence)
    self.lastFlush = os.clock()    -- time of last flush
    self.persistence = persistence(self.filePath)   -- persistence instance
    self.persistenceReady = false   -- whether persistence has loaded
    self.lastMessages = {}          -- for logIfChanged: last message per level (e.g., lastMessages["info"] = "some text")

    -- Load persistence (asynchronous) and set ready flag
    self.persistence:load():and_then(function()
        self.persistenceReady = true
        -- If there were any buffered messages while loading, they are still in self.buffer.
        -- They will be flushed on next tick.
    end)

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

-- Flush buffered entries to persistence
function LoggerMT:flush()
    if #self.buffer == 0 then return end
    if not self.persistenceReady then
        -- Persistence not ready yet; keep buffered
        return
    end

    -- Use persistence to append entries
    self.persistence:update(function(data)
        data.logs = data.logs or {}
        for _, entry in ipairs(self.buffer) do
            table.insert(data.logs, entry)
        end
    end)

    -- Save with optional pretty print
    local success, err = pcall(function()
        self.persistence:save():and_then(function()
            -- Success: clear buffer and update lastFlush
            self.buffer = {}
            self.lastFlush = os.clock()
        end, function(err)
            -- Error handler
            print("Logger: failed to save to " .. self.filePath .. ": " .. tostring(err))
            -- Keep buffer for retry later
        end)
    end)

    if not success then
        print("Logger: error during save on " .. self.filePath .. ": " .. tostring(err))
    end
end

-- Public logging methods
function LoggerMT:debug(msg, data)
    self:addEntry("debug", msg, data)
end

function LoggerMT:info(msg, data)
    self:addEntry("info", msg, data)
end

function LoggerMT:warn(msg, data)
    self:addEntry("warn", msg, data)
end

function LoggerMT:error(msg, data)
    self:addEntry("error", msg, data)
end

-- Force flush now (useful before shutdown)
function LoggerMT:forceFlush()
    if #self.buffer == 0 then return end
    if not self.persistenceReady then
        print("Logger: persistence not ready, cannot flush " .. self.filePath)
        return
    end
    self:flush()
end

-- --------------------------------------------------------------------
-- Global tick handler: check all loggers and flush if interval passed
-- --------------------------------------------------------------------
Net:on("tick", function(event)
    local now = os.clock()
    -- Only check every CHECK_INTERVAL seconds to avoid overhead
    if now - next_check < CHECK_INTERVAL then return end
    next_check = now

    for _, logger in ipairs(loggers) do
        if logger.persistenceReady and #logger.buffer > 0 then
            if now - logger.lastFlush >= logger.flushInterval then
                logger:flush()
            end
        end
    end
end)

-- Return the factory function
return createLogger