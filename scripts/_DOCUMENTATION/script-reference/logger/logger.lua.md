# `logger/logger.lua`

> **Source reference**
>
> Generated from `logger/logger.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

logger.lua – Flexible logging module with per‑logger configuration. Uses append‑only JSON Lines format – each entry is written as a new line. Supports buffering, periodic writes, and optional deduplication of repeated messages. No longer depends on persistence.lua.

## Module location

- **Source:** `logger/logger.lua`
- **Relative reference:** `script-reference/logger/logger.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/enum/predefined-enums` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/libs/json` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `LoggerMT:addEntry` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LoggerMT:debug` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LoggerMT:error` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LoggerMT:flush` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LoggerMT:forceFlush` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LoggerMT:info` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LoggerMT:shouldLog` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LoggerMT:warn` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `createLogger` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `encode_entry` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_directory_exists` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `escape` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `timestamp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 198 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
