# `persistence/logger.lua`

> **Source reference**
>
> Refreshed from the current `persistence/logger.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

logger.lua – Flexible logging module with per‑logger configuration. Uses append‑only JSON Lines format – each entry is written as a new line. Supports buffering, periodic writes, and optional deduplication of repeated messages. No longer depends on persistence.lua.

## Module location

- **Source:** `persistence/logger.lua`
- **Reference:** `script-reference/persistence/logger.lua.md`
- **Source SHA-256 prefix:** `d36111c50b93`

## Source header notes

- logger.lua – Flexible logging module with per‑logger configuration.
- Uses append‑only JSON Lines format – each entry is written as a new line.
- Supports buffering, periodic writes, and optional deduplication of repeated messages.
- No longer depends on persistence.lua.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/libs/json` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ensure_directory_exists` | `filePath` |
| `timestamp` | `` |
| `encode_entry` | `entry` |
| `escape` | `s` |
| `createLogger` | `config` |
| `LoggerMT:shouldLog` | `level` |
| `LoggerMT:addEntry` | `level, msg, data` |
| `LoggerMT:flush` | `` |
| `LoggerMT:debug` | `msg, data` |
| `LoggerMT:info` | `msg, data` |
| `LoggerMT:warn` | `msg, data` |
| `LoggerMT:error` | `msg, data` |
| `LoggerMT:forceFlush` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `CHECK_INTERVAL` | `0.5` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
