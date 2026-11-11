-- scripts/logger/logger.lua
-- Single shared logger for all scripts (Lua 5.2-compatible).
-- Extracted from ezlibs-scripts/ezlogger.lua. All systems now write to:
--   scripts/_DEBUGGING/<system>/_FULL-log.log
--   scripts/_DEBUGGING/<system>/_<SUBSYSTEM>.log
-- Existing player/area-specific .log files are retained for compatibility.
--
-- Human-readable logs are the default; JSONL remains available by option.
-- Existing historic JSONL lines are preserved when appending new readable logs.
-- Files are .log text files, not Lua source.
--
-- register("system") / get("system") -> system-wide logger.
-- module:register_subsystem("subsystem") / module:subsystem("subsystem")
-- -> isolated subsystem stream ALSO mirrored to _FULL-log.log.
-- The console flag retains previous behavior. Global print() interception is
-- intentionally not part of this version of the debugging suite.

local json = require('scripts/libs/json')

local SharedLogger = {}

local ROOT = 'scripts/_DEBUGGING'
SharedLogger.ROOT = ROOT
function SharedLogger.get_root() return ROOT end
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
    format = 'readable',    -- 'readable' or 'jsonl'
    details = 'expanded',   -- 'expanded' or 'compact' (readable only)
    timestamps = true,     -- include timestamps in output
    logIfChanged = false, -- legacy per-level message deduplication (opt-in)
}
local next_tick_check = 0
local TICK_CHECK_INTERVAL = 0.5
local safe_secret_by_player_id = {}

-- I/O errors should not turn a periodic flush into a console spam loop.
-- os.time() measures wall time, unlike os.clock() (CPU time).
local IO_RETRY_MAX_SECONDS = 30
local IO_WARNING_INTERVAL_SECONDS = 30
local warning_until_by_directory = {}

local function wall_time()
    return os.time()
end

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
        local ok, result = pcall(file.CreateDir, dir)
        if ok and result ~= false then return true end
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
        command = 'mkdir "' .. dir:gsub('/', '\\') .. '" >nul 2>nul'
    else
        command = 'mkdir -p "' .. dir .. '" >/dev/null 2>&1'
    end

    local ok, result = pcall(os.execute, command)
    if not ok or (result ~= true and result ~= 0) then
        return false, tostring(result or 'mkdir failed')
    end
    return true
end

local function encode_string(value)
    local ok, encoded = pcall(json.encode, tostring(value or ''))
    if ok and type(encoded) == 'string' then
        return encoded
    end
    return '"<encoding-error>"'
end

-- Produce the original JSONL record structure when configured for JSONL.
-- Do not flatten or trim JSONL data so external parsers retain compatibility.
local function encode_entry_jsonl(entry, include_timestamp)
    local fields = {}
    if include_timestamp then
        fields[#fields + 1] = '"timestamp":' .. encode_string(entry.timestamp)
    end
    fields[#fields + 1] = '"level":' .. encode_string(entry.level)
    fields[#fields + 1] = '"module":' .. encode_string(entry.module)
    fields[#fields + 1] = '"scope":' .. encode_string(entry.scope or 'module')
    fields[#fields + 1] = '"msg":' .. encode_string(entry.msg)

    if entry.subsystem ~= nil then
        fields[#fields + 1] = '"subsystem":' .. encode_string(entry.subsystem)
    end

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

local function safe_to_string(value)
    local ok, result = pcall(tostring, value)
    return ok and result or '<unprintable>'
end

-- Keep simple identifiers unquoted in the readable format; strings with
-- whitespace, control characters, and punctuation use JSON quoting/escaping.
local function readable_scalar(value)
    if type(value) == 'string' then
        -- Quote number-/boolean-like strings so human readers can distinguish
        -- the literal string '100' from the numeric value 100, etc.
        local resembles_scalar = value == 'true' or value == 'false' or value == 'nil'
            or tonumber(value) ~= nil
        if value ~= '' and not resembles_scalar
            and value:match('^[%w_%.%/%-]+$') then
            return value
        end
        return encode_string(value)
    end
    return safe_to_string(value)
end

local function key_label(key)
    if type(key) == 'string' then return key end
    return '[' .. readable_scalar(key) .. ']'
end

local function ordered_keys(record)
    local keys = {}
    for key in pairs(record) do keys[#keys + 1] = key end
    table.sort(keys, function(a, b)
        local ta, tb = type(a), type(b)
        if ta == 'number' and tb == 'number' then return a < b end
        if ta == 'number' then return true end
        if tb == 'number' then return false end
        return key_label(a) < key_label(b)
    end)
    return keys
end

local MAX_DATA_DEPTH = 12

local function compact_value(value, depth, active)
    if type(value) ~= 'table' then return readable_scalar(value) end
    if active[value] then return '<cycle>' end
    if depth >= MAX_DATA_DEPTH then return '<max-depth>' end

    active[value] = true
    local fields = {}
    for _, key in ipairs(ordered_keys(value)) do
        fields[#fields + 1] = key_label(key) .. '=' ..
            compact_value(value[key], depth + 1, active)
    end
    active[value] = nil
    return '{' .. table.concat(fields, ', ') .. '}'
end

-- Recursively expand nested records, with stable field order and aligned keys.
-- The active table tracks the current recursion path, not every table seen,
-- so two references to the same ordinary table are not mistaken for a cycle.
local function expanded_lines(record, indentation, depth, active, lines)
    if active[record] then
        lines[#lines + 1] = indentation .. '<cycle>'
        return
    end
    if depth >= MAX_DATA_DEPTH then
        lines[#lines + 1] = indentation .. '<max-depth>'
        return
    end
    active[record] = true
    local keys = ordered_keys(record)
    if #keys == 0 then
        lines[#lines + 1] = indentation .. '{}'
    else
        local width = 0
        for _, key in ipairs(keys) do
            width = math.max(width, #key_label(key))
        end
        for _, key in ipairs(keys) do
            local label = key_label(key)
            local prefix = indentation .. label .. string.rep(' ', width - #label) .. ' : '
            local value = record[key]
            if type(value) == 'table' then
                lines[#lines + 1] = prefix:sub(1, -2)
                expanded_lines(value, indentation .. '    ', depth + 1, active, lines)
            else
                lines[#lines + 1] = prefix .. readable_scalar(value)
            end
        end
    end
    active[record] = nil
end

local function encode_entry_readable(entry, details, include_timestamp)
    local prefix = include_timestamp and ('[' .. entry.timestamp .. '] ') or ''
    -- Pad the level labels for quick visual scanning in long combined logs.
    local level = string.upper(entry.level or 'info')
    prefix = prefix .. '[' .. level .. string.rep(' ', math.max(0, 5 - #level)) .. ']'
    local source = entry.module or 'unknown-module'
    if entry.subsystem then
        source = source .. '/' .. string.upper(entry.subsystem)
    end
    if entry.scope ~= 'module' and entry.scope ~= 'subsystem' then
        -- Preserve player/area context in the combined log without exposing
        -- stable player-secret identifiers used in filenames.
        source = source .. '/' .. string.upper(tostring(entry.scope))
    end
    prefix = prefix .. ' [' .. source .. '] '

    local msg = tostring(entry.msg or ''):gsub('\r\n', '\n'):gsub('\r', '\n')
    -- Keep each record identifiable even when its Lua message includes a trace.
    msg = msg:gsub('\n', '\n    ')
    local lines = { prefix .. msg }

    if entry.data ~= nil then
        if details == 'compact' then
            if type(entry.data) == 'table' then
                local fields = {}
                for _, key in ipairs(ordered_keys(entry.data)) do
                    fields[#fields + 1] = key_label(key) .. '=' ..
                        compact_value(entry.data[key], 1, {})
                end
                lines[1] = lines[1] .. (#fields > 0 and (' | ' .. table.concat(fields, ' ')) or ' | {}')
            else
                lines[1] = lines[1] .. ' | data=' .. readable_scalar(entry.data)
            end
        elseif type(entry.data) == 'table' then
            expanded_lines(entry.data, '    ', 0, {}, lines)
        else
            lines[#lines + 1] = '    data : ' .. readable_scalar(entry.data)
        end
    end
    return table.concat(lines, '\n')
end

-- Legacy JSONL format is retained for existing createLogger(filePath) callers.
-- New register() callers keep the ezlogger JSONL schema with module/scope.
local function encode_entry_legacy_jsonl(entry, include_timestamp)
    local fields = {}
    if include_timestamp then
        fields[#fields + 1] = '"timestamp":' .. encode_string(entry.timestamp)
    end
    fields[#fields + 1] = '"level":' .. encode_string(entry.level)
    fields[#fields + 1] = '"msg":' .. encode_string(entry.msg)
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

local function encode_entry(entry, logger)
    if logger.format == 'legacy_jsonl' then
        return encode_entry_legacy_jsonl(entry, logger.timestamps)
    end
    if logger.format == 'jsonl' then
        return encode_entry_jsonl(entry, logger.timestamps)
    end
    local ok, output = pcall(encode_entry_readable, entry, logger.details, logger.timestamps)
    if ok then return output end
    -- A broken table metatable or custom tostring() must not prevent a log
    -- record from being written. Preserve the event even without its data.
    return '[' .. string.upper(entry.level or 'info') .. '] [' ..
        tostring(entry.module or 'unknown-module') .. '] ' ..
        tostring(entry.msg or '') .. ' [readable formatter failed]'
end

-- Forward declaration: mirroring needs the instance constructor.
local make_logger

local Logger = {}
Logger.__index = Logger

function Logger:_should_log(level)
    local message_priority = LEVEL_PRIORITY[level]
    local minimum_priority = LEVEL_PRIORITY[self.minLevel] or LEVEL_PRIORITY.debug
    return message_priority ~= nil and message_priority >= minimum_priority
end

-- Failures retain the buffer and back off instead of rerunning mkdir on every
-- tick. Attempt the append first: on Windows, mkdir may report an error when
-- the destination already exists, even though writing to it works perfectly.
local function warn_io_failure(logger, detail)
    local directory = directory_of(logger.filePath) or ROOT
    local now = wall_time()
    if (warning_until_by_directory[directory] or 0) > now then
        return
    end
    warning_until_by_directory[directory] = now + IO_WARNING_INTERVAL_SECONDS
    -- Do not expose player-secret filenames or OS error strings that may
    -- contain those secrets in the console.
    if logger.scope == 'player' then
        print('[logger] Could not write player log for system ' .. logger.moduleName
            .. ' (retrying in the background; entries buffered)')
    else
        print('[logger] Could not write logs for system ' .. logger.moduleName
            .. ' (' .. logger.scope .. ' scope, ' .. directory .. '): '
            .. tostring(detail or 'I/O error') .. ' (will retry; entries buffered)')
    end
end

local function schedule_io_retry(logger, detail)
    logger._io_failures = (logger._io_failures or 0) + 1
    local exponent = math.min(logger._io_failures - 1, 5)
    local delay = math.min(IO_RETRY_MAX_SECONDS, 2 ^ exponent)
    logger._next_retry_at = wall_time() + delay
    warn_io_failure(logger, detail)
end

function Logger:flush()
    if #self.buffer == 0 then return true end
    if self._next_retry_at and wall_time() < self._next_retry_at then
        return false
    end

    local handle, open_error = io.open(self.filePath, 'a')
    if not handle then
        -- Directory creation is a fallback, not a prerequisite for writing.
        -- Always retry io.open regardless of mkdir's reported exit status.
        local directory_ok, directory_error = ensure_directory(self.filePath)
        handle, open_error = io.open(self.filePath, 'a')
        if not handle then
            schedule_io_retry(self, open_error or directory_error
                or (not directory_ok and 'directory creation failed') or 'file open failed')
            return false
        end
    end

    local write_ok, write_error = pcall(function()
        for _, entry in ipairs(self.buffer) do
            local wrote, err = handle:write(encode_entry(entry, self), '\n')
            if not wrote then error(err or 'write failed') end
        end
        local flushed, flush_error = handle:flush()
        if not flushed then error(flush_error or 'flush failed') end
    end)
    local close_ok, close_error = handle:close()
    if not close_ok then
        write_ok = false
        write_error = close_error or 'close failed'
    end

    if not write_ok then
        schedule_io_retry(self, write_error or 'write failed')
        return false
    end

    self.buffer = {}
    self.lastFlush = os.clock()
    self._io_failures = 0
    self._next_retry_at = nil
    return true
end

local function inherited_options(logger)
    return {
        minLevel = logger.minLevel,
        flushInterval = logger.flushInterval,
        maxBufferSize = logger.maxBufferSize,
        console = logger.console,
        format = logger.format,
        details = logger.details,
        timestamps = logger.timestamps,
        logIfChanged = logger.logIfChanged,
    }
end

local function full_log_path(module_name)
    return ROOT .. '/' .. module_name .. '/_FULL-log.log'
end

local function subsystem_log_path(module_name, subsystem_name)
    return ROOT .. '/' .. module_name .. '/_' .. subsystem_name:upper() .. '.log'
end

-- A scoped logger may have a player/area file in addition to its subsystem
-- file. Every record is also mirrored to the consolidated module stream.
-- Mirroring calls _append(), NOT _log(), to avoid recursion/double console.
local function mirrored_loggers(logger)
    local mirrors = {}
    local options = inherited_options(logger)
    if logger.subsystemName then
        local path = subsystem_log_path(logger.moduleName, logger.subsystemName)
        if logger.filePath ~= path then
            mirrors[#mirrors + 1] = make_logger(logger.moduleName,
                'subsystem', path, options, logger.subsystemName)
        end
    end
    local combined = full_log_path(logger.moduleName)
    if logger.filePath ~= combined then
        mirrors[#mirrors + 1] = make_logger(logger.moduleName,
            'module', combined, options)
    end
    return mirrors
end

function Logger:_append(entry)
    self.buffer[#self.buffer + 1] = entry
    if #self.buffer >= self.maxBufferSize then
        self:flush()
    end
end

function Logger:_log(level, message, data)
    if not self:_should_log(level) then return end
    -- Same per-level deduplication semantics as the old persistence logger.
    -- Only update the last-message cache for records actually accepted.
    if self.logIfChanged then
        local previous = self.lastMessages[level]
        if previous == message then return end
        self.lastMessages[level] = message
    end

    local entry = {
        timestamp = timestamp(),
        level = level,
        module = self.moduleName,
        scope = self.scope,
        subsystem = self.subsystemName,
        msg = tostring(message or ''),
        data = data,
    }
    -- Use the same entry for all destinations so metadata is identical.
    self:_append(entry)
    for _, mirror in ipairs(mirrored_loggers(self)) do
        mirror:_append(entry)
    end

    if self.console then
        -- Preserve existing ezlogger console messages. Do not capture print().
        print(entry.msg)
    end

    if level == 'error' then
        self:forceFlush()
    end
end

-- The original ezlogger treats all varargs as print-like tab-separated
-- values (including tables). Only legacy factory instances interpret the
-- two-argument (message, data_table) convention from persistence/logger.lua.
local function arguments_and_data(logger, ...)
    if logger.scope == 'legacy' and select('#', ...) == 2
        and type(select(2, ...)) == 'table' then
        return tostring(select(1, ...)), select(2, ...)
    end
    return join_arguments(...), nil
end

function Logger:debug(...) self:_log('debug', arguments_and_data(self, ...)) end
function Logger:info(...) self:_log('info', arguments_and_data(self, ...)) end
function Logger:warn(...) self:_log('warn', arguments_and_data(self, ...)) end
function Logger:error(...) self:_log('error', arguments_and_data(self, ...)) end

-- Legacy createLogger(config) method aliases.
function Logger:shouldLog(level) return self:_should_log(level) end
function Logger:addEntry(level, message, data) self:_log(level, tostring(message), data) end

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
    local ok = self:flush()
    for _, mirror in ipairs(mirrored_loggers(self)) do
        if not mirror:flush() then ok = false end
    end
    return ok
end

function Logger:set_min_level(level)
    if not LEVEL_PRIORITY[level] then
        return false, 'Unknown log level: ' .. tostring(level)
    end
    self.minLevel = level
    return true
end

local function cache_key(module_name, scope, path, subsystem_name)
    return module_name .. '\0' .. scope .. '\0' .. path
        .. '\0' .. (subsystem_name or '')
end

make_logger = function(module_name, scope, file_path, options, subsystem_name)
    local key = cache_key(module_name, scope, file_path, subsystem_name)
    if instances[key] then return instances[key] end

    local config = copy_options(defaults)
    for option, value in pairs(options or {}) do
        config[option] = value
    end

    local logger = setmetatable({
        moduleName = module_name,
        scope = scope,
        subsystemName = subsystem_name,
        filePath = file_path,
        minLevel = LEVEL_PRIORITY[config.minLevel] and config.minLevel or 'debug',
        flushInterval = tonumber(config.flushInterval) or 2.0,
        maxBufferSize = math.max(1, tonumber(config.maxBufferSize) or 100),
        console = config.console ~= false,
        format = (config.format == 'jsonl' or config.format == 'legacy_jsonl')
            and config.format or 'readable',
        details = config.details == 'compact' and 'compact' or 'expanded',
        timestamps = config.timestamps ~= false,
        logIfChanged = config.logIfChanged == true,
        lastMessages = {},
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

function SharedLogger.register(module_name, options)
    module_name = module_name_of(module_name)
    return make_logger(module_name, 'module', full_log_path(module_name), options)
end

-- Both get() and register() are supported; module names are stable system IDs.
SharedLogger.get = SharedLogger.register

function Logger:register_subsystem(subsystem_name, options)
    local safe_name = safe_component(subsystem_name, 'unknown-subsystem')
    local parent_options = inherited_options(self)
    for key, value in pairs(options or {}) do parent_options[key] = value end
    return make_logger(self.moduleName, 'subsystem',
        subsystem_log_path(self.moduleName, safe_name), parent_options, safe_name)
end

Logger.subsystem = Logger.register_subsystem

function SharedLogger.register_subsystem(module_name, subsystem_name, options)
    return SharedLogger.register(module_name):register_subsystem(subsystem_name, options)
end

SharedLogger.get_subsystem = SharedLogger.register_subsystem

-- Returns a logger whose file is keyed by the stable safe player secret.
-- The secret is used only as a sanitized filename; it is not automatically
-- copied into the log message or structured record.
function Logger:for_safe_secret(safe_secret, options)
    if type(safe_secret) ~= 'string' or safe_secret == '' then
        return self
    end
    safe_secret = safe_component(safe_secret, 'unknown-player')
    local path = ROOT .. '/' .. self.moduleName .. '/' .. safe_secret .. '.log'
    local scoped_options = inherited_options(self)
    for key, value in pairs(options or {}) do scoped_options[key] = value end
    return make_logger(self.moduleName, 'player', path, scoped_options,
        self.subsystemName)
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
    local scoped_options = inherited_options(self)
    for key, value in pairs(options or {}) do scoped_options[key] = value end
    return make_logger(self.moduleName, 'area', path, scoped_options,
        self.subsystemName)
end

function SharedLogger.configure(options)
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
    if options.format ~= nil and options.format ~= 'readable' and options.format ~= 'jsonl' and options.format ~= 'legacy_jsonl' then
        return false, 'format must be readable, jsonl, or legacy_jsonl'
    end
    if options.details ~= nil and options.details ~= 'compact' and options.details ~= 'expanded' then
        return false, 'details must be compact or expanded'
    end
    if options.timestamps ~= nil and type(options.timestamps) ~= 'boolean' then
        return false, 'timestamps must be a boolean'
    end
    if options.logIfChanged ~= nil and type(options.logIfChanged) ~= 'boolean' then
        return false, 'logIfChanged must be a boolean'
    end

    for key, value in pairs(options) do defaults[key] = value end
    for _, logger in ipairs(all_instances) do
        if options.minLevel ~= nil then logger.minLevel = options.minLevel end
        if options.flushInterval ~= nil then logger.flushInterval = tonumber(options.flushInterval) end
        if options.maxBufferSize ~= nil then
            logger.maxBufferSize = math.max(1, tonumber(options.maxBufferSize))
        end
        if options.console ~= nil then logger.console = options.console end
        if options.format ~= nil then logger.format = options.format end
        if options.details ~= nil then logger.details = options.details end
        if options.timestamps ~= nil then logger.timestamps = options.timestamps end
        if options.logIfChanged ~= nil then logger.logIfChanged = options.logIfChanged end
    end
    return true
end

function SharedLogger.flush_all()
    local all_ok = true
    for _, logger in ipairs(all_instances) do
        if not logger:flush() then all_ok = false end
    end
    return all_ok
end

-- Compatibility factory for callers of scripts/logger/logger and
-- scripts/persistence/logger. It does NOT install a second tick handler.
-- Preserve the old JSON Lines field order and custom data table support.
local function legacy_file_path(path)
    if type(path) ~= 'string' or path == '' then
        return nil, 'filePath is required'
    end
    path = normalize_path(path)
    path = path:gsub('^scripts/ezlibs%-scripts/_DEBUGGING/', ROOT .. '/')
    -- Check traversal before resolving legacy aliases.
    if path:find('%.%.') then
        return nil, 'filePath must not contain parent-directory traversal'
    end
    local system, filename = path:match('^scripts/_DEBUGGING/([%w_%%.%-]+)/([^/]+)$')
    if not system or not filename then
        return nil, 'filePath must be within scripts/_DEBUGGING/<system>/*.log'
    end
    local folded = filename:lower()
    if folded == 'debugging.lua' or folded == 'debugging.log'
        or folded == '_full-log.log' then
        -- Older factory callers used debugging.lua or debugging.log for the
        -- combined stream. Never create a Lua source file to store log text.
        return full_log_path(system)
    end
    if not filename:match('^[%w_%%.%-]+%.log$') then
        return nil, 'filePath must end in .log'
    end
    return path
end

function SharedLogger.createLogger(config)
    if type(config) ~= 'table' then
        error('logger: expected a configuration table', 2)
    end
    local path, err = legacy_file_path(config.filePath)
    if not path then error('logger: ' .. err, 2) end
    local system = path:match('^scripts/_DEBUGGING/([^/]+)/')
    local options = copy_options(config)
    if options.format == nil then options.format = 'legacy_jsonl' end
    if options.console == nil then options.console = false end
    if options.minLevel == nil then options.minLevel = 'info' end
    return make_logger(system, 'legacy', path, options)
end

-- Allow the old `local createLogger = require("scripts/logger/logger")`
-- followed by `createLogger({...})` to keep working unchanged.
setmetatable(SharedLogger, {
    __call = function(_, config) return SharedLogger.createLogger(config) end,
})

-- Register one shared tick handler to flush all logger instances. Event
-- callbacks follow the server convention: one parameter named `event`.
if Net and type(Net.on) == 'function' then
    local joined, join_error = pcall(function()
        Net:on('player_join', function(event)
            if type(event) == 'table' and event.player_id ~= nil then
                resolve_safe_player_secret(event.player_id)
            end
        end)
    end)
    if not joined then
        print('[logger] Failed to register player_join: ' .. tostring(join_error))
    end

    local ticking, tick_error = pcall(function()
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
    if not ticking then
        print('[logger] Failed to register periodic flushing: ' .. tostring(tick_error))
    end
end

return SharedLogger
