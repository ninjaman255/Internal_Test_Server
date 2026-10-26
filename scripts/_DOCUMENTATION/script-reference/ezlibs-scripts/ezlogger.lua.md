# `ezlibs-scripts/ezlogger.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezlogger.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezlogger.lua Shared append-only JSONL logging for ezlibs modules. Lua 5.2 compatible. Log files are written below: scripts/ezlibs-scripts/_DEBUGGING/<module>/ Default module log: debugging.log Player log:         <safe-player-secret>.log Area/map log:       <area-id>.log

## Module location

- **Source:** `ezlibs-scripts/ezlogger.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezlogger.lua.md`
- **Source SHA-256 prefix:** `b2e65b5ae22e`

## Source header notes

- ezlogger.lua
- Shared append-only JSONL logging for ezlibs modules.
- Lua 5.2 compatible. Log files are written below:
- scripts/ezlibs-scripts/_DEBUGGING/<module>/
- Default module log: debugging.log
- Player log:         <safe-player-secret>.log

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/json` |
| `scripts/ezlibs-scripts/urlencode` |

## `Net:on` subscriptions

| Event |
|---|
| `player_join` |
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `safe_component` | `value, fallback` |
| `copy_options` | `source` |
| `timestamp` | `` |
| `join_arguments` | `...` |
| `normalize_path` | `path` |
| `directory_of` | `path` |
| `mkdir_recursive_lfs` | `path, lfs` |
| `ensure_directory` | `path` |
| `encode_string` | `value` |
| `encode_entry` | `entry` |
| `Logger:_should_log` | `level` |
| `Logger:flush` | `` |
| `Logger:_log` | `level, message, data` |
| `Logger:debug` | `...` |
| `Logger:info` | `...` |
| `Logger:warn` | `...` |
| `Logger:error` | `...` |
| `Logger:debug_data` | `message, data` |
| `Logger:info_data` | `message, data` |
| `Logger:warn_data` | `message, data` |
| `Logger:error_data` | `message, data` |
| `Logger:forceFlush` | `` |
| `Logger:set_min_level` | `level` |
| `cache_key` | `module_name, scope, path` |
| `make_logger` | `module_name, scope, file_path, options` |
| `module_name_of` | `name` |
| `ezlogger.get` | `module_name, options` |
| `Logger:for_safe_secret` | `safe_secret, options` |
| `resolve_safe_player_secret` | `player_id` |
| `Logger:for_player` | `player_id, options` |
| `Logger:for_area` | `area_id, options` |
| `ezlogger.configure` | `options` |
| `ezlogger.flush_all` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_player_secret`, `on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `ROOT` | `'scripts/ezlibs-scripts/_DEBUGGING'` |
| `LEVEL_PRIORITY` | `{` |
| `TICK_CHECK_INTERVAL` | `0.5` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
