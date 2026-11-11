-- Compatibility adapter for createLogger(config) callers.
-- All writes and periodic flushes are provided by scripts/logger/logger.lua.
return require('scripts/logger/logger').createLogger
