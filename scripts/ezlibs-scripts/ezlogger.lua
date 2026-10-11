-- ezlogger.lua
-- Shared append-only JSONL logging for ezlibs modules.
-- Lua 5.2 compatible. Log files are written below:
-- scripts/ezlibs-scripts/_DEBUGGING/<module>/
--
-- Default module log: debugging.log
-- Player log:         <safe-player-secret>.log
-- Area/map log:       <area-id>.log

local json = require('scripts/ezlibs-scripts/json')

local ezlogger = {}

local ROOT = 'scripts/ezlibs-scripts/_DEBUGGING'
local LEVEL_PRIORITY = {
    debug = 1,
    info = 2,
    warn = 3,
    error = 4,
}

local instances = {}
local all_instances = {}
local defaults = {
    minLevel = 'debug',
    flushInterval = 2.0,
    maxBufferSize = 100,
    console = true,
}
local next_tick_check = 0
local TICK_CHECK_INTERVAL = 0.5
local safe_secret_by_player_id = {}

local function safe_component(value, fallback)
    value = tostring(value or '')
    value = value:gsub('[^%w%%._%-]', '_')
    value = value:gsub('%.%.+', '_')
    value = value:gsub('^%.+', '_')
    value = value:gsub('%.+$', '_')
    if value == '' then
        return fallback or 'unknown'
    end
    return value
end

local function copy_options(source)
    local out = {}
    for key, value in pairs(source or {}) do
        out[key] = value
    end
    return out
end

local function timestamp()
    return os.date('%Y-%m-%d %H:%M:%S')
end

local function join_arguments(...)
    local parts = {}
    for index = 1, select('#', ...) do
        parts[#parts + 1] = tostring(select(index, ...))
    end
    -- Match Lua print's conventional separator so replacing print() does not
    -- unexpectedly concatenate its arguments.
    return table.concat(parts, '\t')
end

local function normalize_path(path)
    return (tostring(path):gsub('\\', '/'))
end

local function directory_of(path)
    local normalized = normalize_path(path)
    return normalized:match('^(.*)/[^/]*$')
end

local function mkdir_recursive_lfs(path, lfs)
    path = normalize_path(path):gsub('/+$', '')
    if path == '' then return true end

    local attributes = lfs.attributes(path)
    if attributes then
        return attributes.mode == 'directory'
    end

    local parent = path:match('^(.*)/[^/]+$')
    if parent and parent ~= '' and parent ~= path then
        if not mkdir_recursive_lfs(parent, lfs) then
            return false
        end
    end

    local ok = lfs.mkdir(path)
    if ok then return true end

    -- A concurrent caller may have created the directory after attributes().
    attributes = lfs.attributes(path)
    return attributes ~= nil and attributes.mode == 'directory'
end

local function ensure_directory(path)
    local dir = directory_of(path)
    if not dir or dir == '' then return true end

    if file and type(file.CreateDir) == 'function' then
        local ok = pcall(file.CreateDir, dir)
        if ok then return true end
    end

    local has_lfs, lfs = pcall(require, 'lfs')
    if has_lfs and type(lfs) == 'table' and type(lfs.attributes) == 'function'
        and type(lfs.mkdir) == 'function' then
        local ok, result = pcall(mkdir_recursive_lfs, dir, lfs)
        if ok and result then return true end
    end

    -- The path is assembled from a fixed root and sanitized components.
    -- Keep the fallback for server environments without LuaFileSystem.
    local command
    if package.config and package.config:sub(1, 1) == '\\' then
        command = 'mkdir "' .. dir .. '" >nul 2>nul'
    else
        command = 'mkdir -p "' .. dir .. '" >/dev/null 2>&1'
    end

    local ok, result = pcall(os.execute, command)
    if not ok then return false, tostring(result) end
    return true
end

local function encode_string(value)
    local ok, encoded = pcall(json.encode, tostring(value or ''))
    if ok and type(encoded) == 'string' then
        return encoded
    end
    return '"<encoding-error>"'
end

local function encode_entry(entry)
    local fields = {
        '"timestamp":' .. encode_string(entry.timestamp),
        '"level":' .. encode_string(entry.level),
        '"module":' .. encode_string(entry.module),
        '"scope":' .. encode_string(entry.scope or 'module'),
        '"msg":' .. encode_string(entry.msg),
    }

    if entry.data ~= nil then
        local ok, encoded = pcall(json.encode, entry.data)
        if ok and type(encoded) == 'string' then
            fields[#fields + 1] = '"data":' .. encoded
        else
            fields[#fields + 1] = '"data_error":' .. encode_string('Could not JSON-encode log data')
        end
    end

    return '{' .. table.concat(fields, ',') .. '}'
end

local Logger = {}
Logger.__index = Logger

function Logger:_should_log(level)
    local message_priority = LEVEL_PRIORITY[level]
    local minimum_priority = LEVEL_PRIORITY[self.minLevel] or LEVEL_PRIORITY.debug
    return message_priority ~= nil and message_priority >= minimum_priority
end

function Logger:flush()
    if #self.buffer == 0 then return true end

    local directory_ok, directory_error = ensure_directory(self.filePath)
    if not directory_ok then
        -- Avoid routing this failure through the logger itself.
        print('[ezlogger] Could not create log directory for module ' .. tostring(self.moduleName)
            .. ' (' .. tostring(self.scope) .. ' scope): '
            .. tostring(directory_error or 'directory creation failed'))
        return false
    end

    local handle, open_error = io.open(self.filePath, 'a')
    if not handle then
        if self.scope == 'player' then
            -- Do not echo the safe-secret filename or an OS error that may repeat it.
            print('[ezlogger] Could not open player log for module ' .. tostring(self.moduleName)
                .. ' for append: file open failed')
        else
            print('[ezlogger] Could not open ' .. tostring(self.filePath)
                .. ' for append: ' .. tostring(open_error))
        end
        return false
    end

    local write_ok, write_error = pcall(function()
        for _, entry in ipairs(self.buffer) do
            local wrote, err = handle:write(encode_entry(entry), '\n')
            if not wrote then error(err or 'write failed') end
        end
        local flushed, flush_error = handle:flush()
        if not flushed then error(flush_error or 'flush failed') end
    end)
    handle:close()

    if not write_ok then
        if self.scope == 'player' then
            print('[ezlogger] Failed writing player log for module ' .. tostring(self.moduleName))
        else
            print('[ezlogger] Failed writing ' .. tostring(self.filePath) .. ': ' .. tostring(write_error))
        end
        return false
    end

    self.buffer = {}
    self.lastFlush = os.clock()
    return true
end

function Logger:_log(level, message, data)
    if not self:_should_log(level) then return end

    local entry = {
        timestamp = timestamp(),
        level = level,
        module = self.moduleName,
        scope = self.scope,
        msg = tostring(message or ''),
        data = data,
    }
    self.buffer[#self.buffer + 1] = entry

    if self.console then
        -- Preserve the previous print()-based diagnostics in server console.
        print(entry.msg)
    end

    if level == 'error' or #self.buffer >= self.maxBufferSize then
        self:flush()
    end
end

function Logger:debug(...)
    self:_log('debug', join_arguments(...))
end

function Logger:info(...)
    self:_log('info', join_arguments(...))
end

function Logger:warn(...)
    self:_log('warn', join_arguments(...))
end

function Logger:error(...)
    self:_log('error', join_arguments(...))
end

function Logger:debug_data(message, data)
    self:_log('debug', message, data)
end

function Logger:info_data(message, data)
    self:_log('info', message, data)
end

function Logger:warn_data(message, data)
    self:_log('warn', message, data)
end

function Logger:error_data(message, data)
    self:_log('error', message, data)
end

function Logger:forceFlush()
    return self:flush()
end

function Logger:set_min_level(level)
    if not LEVEL_PRIORITY[level] then
        return false, 'Unknown log level: ' .. tostring(level)
    end
    self.minLevel = level
    return true
end

local function cache_key(module_name, scope, path)
    return module_name .. '\0' .. scope .. '\0' .. path
end

local function make_logger(module_name, scope, file_path, options)
    local key = cache_key(module_name, scope, file_path)
    if instances[key] then return instances[key] end

    local config = copy_options(defaults)
    for option, value in pairs(options or {}) do
        config[option] = value
    end

    local logger = setmetatable({
        moduleName = module_name,
        scope = scope,
        filePath = file_path,
        minLevel = LEVEL_PRIORITY[config.minLevel] and config.minLevel or 'debug',
        flushInterval = tonumber(config.flushInterval) or 2.0,
        maxBufferSize = math.max(1, tonumber(config.maxBufferSize) or 100),
        console = config.console ~= false,
        buffer = {},
        lastFlush = os.clock(),
    }, Logger)

    instances[key] = logger
    all_instances[#all_instances + 1] = logger
    return logger
end

local function module_name_of(name)
    return safe_component(name, 'unknown-module')
end

function ezlogger.get(module_name, options)
    module_name = module_name_of(module_name)
    local module_directory = ROOT .. '/' .. module_name
    return make_logger(module_name, 'module', module_directory .. '/debugging.log', options)
end

-- Returns a logger whose file is keyed by the stable safe player secret.
-- The secret is used only as a sanitized filename; it is not automatically
-- copied into the log message or structured record.
function Logger:for_safe_secret(safe_secret, options)
    if type(safe_secret) ~= 'string' or safe_secret == '' then
        return self
    end
    safe_secret = safe_component(safe_secret, 'unknown-player')
    local path = ROOT .. '/' .. self.moduleName .. '/' .. safe_secret .. '.log'
    local scoped_options = copy_options({
        minLevel = self.minLevel,
        flushInterval = self.flushInterval,
        maxBufferSize = self.maxBufferSize,
        console = self.console,
    })
    for key, value in pairs(options or {}) do scoped_options[key] = value end
    return make_logger(self.moduleName, 'player', path, scoped_options)
end

-- Resolve the safe secret using the same extraction/URL-encoding convention
-- as helpers.get_safe_player_secret(), without requiring helpers.lua (which
-- itself may use ezlogger and would create a dependency cycle). Cache the
-- session-ID -> safe-secret mapping so disconnect handlers can still select
-- the stable player log after the engine stops resolving the live session.
local function resolve_safe_player_secret(player_id)
    if player_id == nil then return nil end

    if Net and type(Net.get_player_secret) == 'function' then
        local ok, safe_secret = pcall(function()
            local raw_secret = Net.get_player_secret(player_id)
            if type(raw_secret) ~= 'string' or #raw_secret < 2 then return nil end
            local encoded = require('scripts/ezlibs-scripts/urlencode')
            if type(encoded) ~= 'table' or type(encoded.string) ~= 'function' then return nil end
            return encoded.string(raw_secret:sub(2, 32))
        end)
        if ok and type(safe_secret) == 'string' and safe_secret ~= '' then
            safe_secret_by_player_id[player_id] = safe_secret
            return safe_secret
        end
    end

    return safe_secret_by_player_id[player_id]
end

function Logger:for_player(player_id, options)
    local safe_secret = resolve_safe_player_secret(player_id)
    if type(safe_secret) ~= 'string' or safe_secret == '' then
        return self
    end
    return self:for_safe_secret(safe_secret, options)
end

-- Area/map identifiers are sanitized into a single filename component.
function Logger:for_area(area_id, options)
    if area_id == nil or tostring(area_id) == '' then return self end
    local area_component = safe_component(area_id, 'unknown-area')
    local path = ROOT .. '/' .. self.moduleName .. '/' .. area_component .. '.log'
    local scoped_options = copy_options({
        minLevel = self.minLevel,
        flushInterval = self.flushInterval,
        maxBufferSize = self.maxBufferSize,
        console = self.console,
    })
    for key, value in pairs(options or {}) do scoped_options[key] = value end
    return make_logger(self.moduleName, 'area', path, scoped_options)
end

function ezlogger.configure(options)
    if type(options) ~= 'table' then
        return false, 'options must be a table'
    end
    if options.minLevel ~= nil and not LEVEL_PRIORITY[options.minLevel] then
        return false, 'Unknown minLevel: ' .. tostring(options.minLevel)
    end
    if options.flushInterval ~= nil and tonumber(options.flushInterval) == nil then
        return false, 'flushInterval must be numeric'
    end
    if options.maxBufferSize ~= nil and tonumber(options.maxBufferSize) == nil then
        return false, 'maxBufferSize must be numeric'
    end
    if options.console ~= nil and type(options.console) ~= 'boolean' then
        return false, 'console must be a boolean'
    end

    for key, value in pairs(options) do defaults[key] = value end
    for _, logger in ipairs(all_instances) do
        if options.minLevel ~= nil then logger.minLevel = options.minLevel end
        if options.flushInterval ~= nil then logger.flushInterval = tonumber(options.flushInterval) end
        if options.maxBufferSize ~= nil then
            logger.maxBufferSize = math.max(1, tonumber(options.maxBufferSize))
        end
        if options.console ~= nil then logger.console = options.console end
    end
    return true
end

function ezlogger.flush_all()
    local all_ok = true
    for _, logger in ipairs(all_instances) do
        if not logger:flush() then all_ok = false end
    end
    return all_ok
end

-- Register one shared tick handler to flush all logger instances. Event
-- callbacks follow the server convention: one parameter named `event`.
if Net and type(Net.on) == 'function' then
    local registered, register_error = pcall(function()
        Net:on('player_join', function(event)
            if type(event) == 'table' and event.player_id ~= nil then
                resolve_safe_player_secret(event.player_id)
            end
        end)

        Net:on('tick', function(event)
            local now = os.clock()
            if now - next_tick_check < TICK_CHECK_INTERVAL then return end
            next_tick_check = now

            for _, logger in ipairs(all_instances) do
                if #logger.buffer > 0 and now - logger.lastFlush >= logger.flushInterval then
                    logger:flush()
                end
            end
        end)
    end)
    if not registered then
        print('[ezlogger] Failed to register lifecycle/flush handlers: ' .. tostring(register_error))
    end
end

return ezlogger
