-- logger.lua (append‑only version)
local json = require('scripts/libs/json')

local loggers = {}
local next_check = 0
local CHECK_INTERVAL = 0.5

local function timestamp()
    return os.date("%Y-%m-%d %H:%M:%S")
end

local LoggerMT = {}
LoggerMT.__index = LoggerMT

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

    self.levelPriority = {
        debug = 1,
        info  = 2,
        warn  = 3,
        error = 4,
    }

    self.buffer = {}
    self.lastFlush = os.clock()
    self.lastMessages = {}

    table.insert(loggers, self)
    return self
end

function LoggerMT:shouldLog(level)
    local msgPriority = self.levelPriority[level]
    local minPriority = self.levelPriority[self.minLevel] or 2
    return msgPriority and msgPriority >= minPriority
end

function LoggerMT:addEntry(level, msg, data)
    if not self:shouldLog(level) then return end

    if self.logIfChanged then
        local last = self.lastMessages[level]
        if last == msg then
            return
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

    if #self.buffer >= self.maxBufferSize then
        self:flush()
    end
end

-- Append all buffered entries as JSON Lines
function LoggerMT:flush()
    if #self.buffer == 0 then return end

    -- Open file in append mode (synchronous but quick)
    local file, err = io.open(self.filePath, "a")
    if not file then
        print("Logger: failed to open " .. self.filePath .. " for append: " .. tostring(err))
        return
    end

    -- Write each entry as a separate line
    for _, entry in ipairs(self.buffer) do
        local line = json.encode(entry) .. "\n"
        file:write(line)
    end

    file:close()

    self.buffer = {}
    self.lastFlush = os.clock()
end

function LoggerMT:debug(msg, data) self:addEntry("debug", msg, data) end
function LoggerMT:info(msg, data)  self:addEntry("info", msg, data) end
function LoggerMT:warn(msg, data)  self:addEntry("warn", msg, data) end
function LoggerMT:error(msg, data) self:addEntry("error", msg, data) end

function LoggerMT:forceFlush()
    if #self.buffer == 0 then return end
    self:flush()
end

Net:on("tick", function(event)
    local now = os.clock()
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