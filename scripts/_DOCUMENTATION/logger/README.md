# 🪵 Shared Logger — Programmer Guide

[🏠 Documentation home](../index.md) · [📂 Logger index](index.md) · [🔄 Migration guide](MIGRATION.md) · [🧪 Tests](TESTING.md)

## 🗂️ Contents

- [Overview](#overview)
- [Import and register a system](#import-and-register-a-system)
- [Directory and file layout](#directory-and-file-layout)
- [API reference](#api-reference)
- [Options](#options)
- [Formatting and compatibility](#formatting-and-compatibility)
- [HP Manager logging](#hp-manager-logging)
- [Operational notes](#operational-notes)

## Overview

**Implementation:** `scripts/logger/logger.lua`. This is the single registry, buffer pool and lifecycle/tick flushing handler for all migrated scripts. It combines the former `ezlibs-scripts/ezlogger.lua` structured readable/JSONL logger with the `scripts/logger/logger.lua`/`scripts/persistence/logger.lua` legacy factory API.

**Important:** Requiring `scripts/ezlibs-scripts/ezlogger` or `scripts/persistence/logger` continues to work as an alias/factory. Both route to the **same** shared instance; no extra tick hooks are installed by those aliases.

This logger does **not** intercept the global `print()` function. The existing console lines for migrated ezlogger calls remain unchanged, including message prefixes supplied by the caller.

## Import and register a system

```lua
local Logger = require("scripts/logger/logger")

-- Always write to one system-wide combined log.
local log = Logger.register("nebulous-liberations")
log:info("Mission initialized")

-- A subsystem writes to its own file AND the combined system log.
local spawn_log = log:register_subsystem("spawning")
spawn_log:debug("Spawn queued", bot_id)

-- Optional structured key/value data (human-readable, expanded by default).
spawn_log:info_data("Enemy created", { name = "Mettaur", hp = 240 })
```

## Directory and file layout

Every log created by the shared logger lives below **`scripts/_DEBUGGING/`** at the root of `scripts/`. The names of systems and subsystems are preserved (and sanitized as safe filename components). Subsystem names are uppercased for filenames.

```text
scripts/
├── _DEBUGGING/
│   ├── nebulous-liberations/
│   │   ├── _FULL-log.log
│   │   ├── _SPAWNING.log
│   │   ├── _ENCOUNTERS.log
│   │   └── default.log           # Optional area-specific stream
│   ├── eznpcs/
│   │   ├── _FULL-log.log
│   │   └── _DIALOGUE-TYPES.log
│   ├── hp_manager/
│   │   ├── _FULL-log.log
│   │   ├── _DESKTOP.log
│   │   ├── _BACKGROUND.log
│   │   ├── _REAL-TIME.log
│   │   └── _WARP.log
│   └── jukebox/
│       ├── _FULL-log.log
│       ├── _MAIN.log
│       └── _UTILS.log
├── logger/logger.lua         # Canonical implementation
├── persistence/logger.lua    # Older createLogger shim
└── ezlibs-scripts/ezlogger.lua  # Older ezlogger shim
```

A player log uses a filename based on the sanitized **safe player secret**, not the raw player secret. Player and area logs are also mirrored into their subsystem file (if any) and into `_FULL-log.log`. System log data includes `module`, `subsystem`, and `scope` metadata.

## API reference

| Function | Arguments | Result / behavior |
|---|---|---|
| `Logger.register(system, options?)` | `system: string`, `options?: table` | Cached system logger; **preferred** entry point |
| `Logger.get(system, options?)` | Same | Alias of `register` |
| `Logger.register_subsystem(system, name, options?)` | Two names, options | Direct subsystem logger |
| `Logger.get_subsystem(system, name, options?)` | Same | Alias of `register_subsystem` |
| `Logger.get_root()` | None | `scripts/_DEBUGGING` |
| `Logger.configure(options)` | Options table | Updates defaults and existing logger configurations; `true` or `false,error` |
| `Logger.flush_all()` | None | Attempts to flush every buffered logger and returns success |
| `Logger.createLogger(config)` | Legacy config with `filePath` | Older JSONL factory; filePath must remain under root `_DEBUGGING` |
| `logger:register_subsystem(name, options?)` | Subsystem name, options | Cached subsystem logger for the same system |
| `logger:subsystem(name, options?)` | Same | Alias of `register_subsystem` |
| `logger:for_player(player_id, options?)` | Player session ID, options | Player-specific log, falling back to current logger when secret unavailable |
| `logger:for_safe_secret(secret, options?)` | Encoded safe secret, options | Secret-keyed player file |
| `logger:for_area(area_id, options?)` | Area ID, options | Area-specific file |
| `logger:debug(...)` / `:info(...)` | Message or multiple scalar arguments | Adds a message at the selected level |
| `logger:warn(...)` / `:error(...)` | Message or multiple scalar arguments | Warn or error; error forces a flush |
| `logger:debug_data(message, data)` | `message:string`, `data:any` | Structured `data` without flattening |
| `logger:info_data` / `:warn_data` / `:error_data` | Same | Structured records at other levels |
| `logger:flush()` / `:forceFlush()` | None | Write buffered records; returns success status |
| `logger:set_min_level(level)` | debug/info/warn/error | Updates this logger's level; returns status |
| `logger:shouldLog(level)` | Level string | Compatibility method returning boolean |
| `logger:addEntry(level, msg, data?)` | Level, message, optional data | Compatibility method for older factory instances |

**Data arguments:** `log:info_data("message", { key = value })` is the explicit structured-data API for regular registered loggers. The original ezlogger `log:info(...)` still formats *all* arguments as tab-separated text. Compatibility loggers created through `createLogger` retain their two-argument `(message, data_table)` behavior.

## Options

| Key | Default `register()` | Meaning |
|---|---|---|
| `minLevel` | `debug` | Minimum recorded severity |
| `flushInterval` | `2.0` | Seconds of CPU time between periodic flush checks |
| `maxBufferSize` | `100` | Buffered entries per file before forced flush |
| `console` | `true` | Print original message text once (not once per mirrored file) |
| `format` | `readable` | `readable`, `jsonl`, or compatibility-only `legacy_jsonl` |
| `details` | `expanded` | For readable output: `expanded` (indented) or `compact` |
| `timestamps` | `true` | Include timestamp in log lines |
| `logIfChanged` | `false` | Deduplicate successive **identical messages at the same level** |

`createLogger(config)` retains the old defaults: `minLevel="info"`, `console=false`, `format="legacy_jsonl"`. It requires `filePath` under `scripts/_DEBUGGING/<system>/*.log` (legacy `debugging.lua` is recognized as an alias only) and mirrors entries to that system's `_FULL-log.log`. It also accepts legacy paths beginning `scripts/ezlibs-scripts/_DEBUGGING/` and maps them to the new root; this is for callers, not automatic migration of old files.

## Formatting and compatibility

Readable logs preserve the ezlogger format:

```text
[2026-11-11 12:00:00] [INFO ] [hp_manager/BACKGROUND] [Background Manager] Applied background
    area      : default
    image     : example.png
```

The preceding line is **an illustrative format example, not an observed runtime event**. `jsonl` keeps structured `module`, `scope`, and `subsystem` fields. Older factory logs use `legacy_jsonl` with the original `timestamp`, `level`, `msg`, `data` structure.

`register()` caches one logger per `(system,scope,path,subsystem)`; changing configuration later should use `configure()` or `set_min_level()` rather than expecting an existing cached logger to reconstruct itself.

## HP Manager logging

| Script | System | Subsystem |
|---|---|---|
| `hp_manager/main.lua` | `hp_manager` | `desktop` |
| `hp_manager/background_manage.lua` | `hp_manager` | `background` |
| `hp_manager/realtime_manage.lua` | `hp_manager` | `real-time` |
| `hp_manager/warp_manage.lua` | `hp_manager` | `warp` |
| `jukebox/main.lua` | `jukebox` | `main` |
| `jukebox/utils.lua` | `jukebox` | `utils` |

HP Manager retains the previous console message prefixes (such as `[HP_Manager]`, `[Background Manager]`, and `[Warp Manager]`) while also recording structured system/subsystem metadata in files. Log level changes to `error` on failures cause immediate flushing, which helps diagnose an editor that closes unexpectedly.

## Operational notes

- Files are append-only; **old logs are not deleted** by the code change. Old `scripts/ezlibs-scripts/_DEBUGGING/` contents may be copied into `scripts/_DEBUGGING/` if you want historical records in one place. Do not overwrite existing destination logs; append or keep backups.
- A flush **first attempts to append** to the log file. If the file cannot be opened, directory creation tries `file.CreateDir`, LuaFileSystem, and then OS `mkdir`; the logger retries the append even if `mkdir` reported a nonzero exit status (important on Windows when the directory already exists).
- If the append or write still fails, records remain buffered. The affected stream retries with exponential backoff (1, 2, 4, 8, 16, then 30 seconds), and console warnings are limited to one per system directory per 30 seconds. Persistent disk failures can accumulate buffered records in memory: resolve path/permission/disk problems rather than ignoring the warning.
- **Exact combined filename:** `_FULL-log.log` (uppercase `FULL`, lowercase `log`). Historical `debugging.log`, `debugging.lua` and `_FULL-LOG.log` paths passed to the legacy `createLogger({filePath=...})` factory are redirected to `_FULL-log.log`. Existing files on disk are not renamed or deleted automatically.
- `player_join` caches safe player secrets when possible. `tick` flushes buffered logs periodically. These handlers are registered **once** by the canonical module.
- Avoid logging raw secrets/passwords/tokens. `for_player` derives its filename from the pre-existing safe-secret convention; it does not automatically scrub message contents.
- Errors while writing log files are reported by direct console output to avoid recursive logger failure.

## 🎮 PlayerControl subsystem logs

`PlayerControl` registers the `player_control` system with the shared logger. Its `_INPUT.log`, `_CAPTURE.log`, `_CAMERA.log`, and `_HANDOFF.log` are mirrored into `_FULL-log.log`. These are event-driven lifetime transitions, not per-frame input spam. See [PlayerControl programmer guide](../player-control/README.md).
