# 🔄 Logger migration — `ezlogger` → shared logger

[🏠 Documentation home](../index.md) · [🪵 Shared Logger](README.md) · [🧪 Tests](TESTING.md)

## Summary

All direct imports of `scripts/ezlibs-scripts/ezlogger` in the current server Lua have been migrated to **`scripts/logger/logger`**. The old `ezlogger.lua` is now only a compatibility alias. The duplicate implementation under `scripts/persistence/logger.lua` is also an adapter that delegates to the shared singleton.

Every new log is written under root `scripts/_DEBUGGING/<system>/`, preserving the existing `_<SUBSYSTEM>.log` plus `_FULL-log.log` mirroring convention, readable text style and optional JSONL.

## Before / after

```lua
-- Before:
local ezlogger = require("scripts/ezlibs-scripts/ezlogger")
local log = ezlogger.register("nebulous-liberations"):register_subsystem("instance")

-- After:
local Logger = require("scripts/logger/logger")
local log = Logger.register("nebulous-liberations"):register_subsystem("instance")
```

When an older module still uses `require("scripts/ezlibs-scripts/ezlogger")`, no second logger registry or tick handler appears: that shim returns the same shared table.

## Compatibility points

| Feature | Status |
|---|---|
| `register`, `get`, `register_subsystem`, `get_subsystem` | Preserved |
| `for_player`, `for_area`, `for_safe_secret` | Preserved |
| `_FULL-log.log` and `_<SUBSYSTEM>.log` | Preserved |
| `debug/info/warn/error` scalar varargs and `*_data` | Preserved |
| Readable timestamps/levels/source/data indentation | Preserved |
| `jsonl` structured fields | Preserved |
| Legacy `createLogger({filePath, ...})` | Supported with original-style JSONL |
| `logIfChanged` | Supported by shared registry |
| Legacy `_DEBUGGING` logs on disk | **Not automatically deleted/migrated** |

## Existing on-disk logs

The old directory `scripts/ezlibs-scripts/_DEBUGGING/` is no longer a writing destination. Existing files are historical data. To consolidate them, stop the server, back up both directories, and **copy** their system subdirectories to `scripts/_DEBUGGING/`. Where filenames collide, append to the target files or retain both backups. Remove the old directory only after checking the logs were preserved.

## Integration guidance

- Choose a stable **system name**, then one or more **subsystems**. Avoid creating a new system for each player, instance ID or map.
- Use `for_player` or `for_area` for a scoped per-player/per-area log while retaining the same system's full and subsystem files.
- HP Manager now uses `hp_manager` with four subsystems. Jukebox uses `jukebox` with two subsystems. The old console message text stays the same.
- All callers use one registration/flush queue. Do not import another logger implementation from elsewhere.
- No `Net`/`Async` gameplay API was changed by this logging migration.

## November 11 logger reliability hotfix

- The canonical combined filename is now **`_FULL-log.log`**, not `_FULL-LOG.log` or `debugging.log`. Subsystem filenames are unchanged.
- `createLogger({ filePath = 'scripts/_DEBUGGING/System/debugging.log' })` and older `debugging.lua` paths are accepted but remapped to the canonical combined log. No Lua source log file is created.
- The flush path attempts `io.open(..., 'a')` before mkdir, fixing a false `mkdir failed` report on Windows when the directory already exists.
- Disk failures retain the buffer and use retry backoff plus per-directory warning throttling to prevent tick-loop console floods.
- **Manual history migration:** Old `_FULL-LOG.log`, `debugging.log` and `debugging.lua` files are not renamed or deleted by the patch. While the server is stopped, back them up and append/merge history into the new `_FULL-log.log` if desired.
