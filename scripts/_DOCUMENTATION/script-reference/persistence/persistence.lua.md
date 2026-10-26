# `persistence/persistence.lua`

> **Source reference**
>
> Refreshed from the current `persistence/persistence.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

persistence.lua Persistent JSON file storage with automatic debounced saving and per‑file instance management. Supports chained updates and waiting for save completion via promise‑returning save(). Automatically creates missing directories when saving. Now includes saveData() for direct writes without altering internal state, and dirty flag is cleared only after successful write.

## Module location

- **Source:** `persistence/persistence.lua`
- **Reference:** `script-reference/persistence/persistence.lua.md`
- **Source SHA-256 prefix:** `4be2c4230d0b`

## Source header notes

- persistence.lua
- Persistent JSON file storage with automatic debounced saving and per‑file instance management.
- Supports chained updates and waiting for save completion via promise‑returning save().
- Automatically creates missing directories when saving.
- Now includes saveData() for direct writes without altering internal state, and
- dirty flag is cleared only after successful write.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/libs/json` |
| `scripts/utils/utility` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ensure_directory_exists` | `filePath` |
| `async_ensure_dir` | `filePath` |
| `new` | `filePath` |
| `self:_mark_dirty` | `` |
| `self:load` | `` |
| `self:getData` | `` |
| `self:setData` | `newData` |
| `self:update` | `func` |
| `self:removeKey` | `key` |
| `self:setKey` | `key, value` |
| `self:clear` | `` |
| `split` | `str, delim` |
| `resolve_path` | `data, path, create` |
| `self:removePath` | `path` |
| `self:setPath` | `path, value` |
| `self:_save_internal` | `` |
| `self:save` | `` |
| `self:saveData` | `data` |
| `self:ready` | `callback` |
| `self:updateAndSave` | `func` |
| `get_instance` | `filePath` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`

## Engine `Async` calls

`read_file`, `write_file`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
