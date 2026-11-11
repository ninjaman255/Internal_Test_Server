# 📄 `persistence.lua` — Refreshed Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/persistence/persistence.lua`](../../../persistence/persistence.lua)  
> **Source lines:** 338  
> **SHA-256 (UTF-8):** `4be2c4230d0b27f03969a6f466c5ee039fda59e3acb5783a239e631a80dfe510`  
> **Named/assigned functions detected:** 21  
> **Table initializers detected (simple pattern):** 11

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/persistence/persistence.lua` from the latest overlaid server archive.

## Dependencies

| Line | `require` module |
|---:|---|
| 8 | `scripts/libs/json` |
| 9 | `scripts/utils/utility` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 54 | `Net` | `tick` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 22 | `ensure_directory_exists` | `filePath` | local |
| 44 | `async_ensure_dir` | `filePath` | local |
| 72 | `new` | `filePath` | local |
| 84 | `self:_mark_dirty` | `(none)` | assigned/declared |
| 93 | `self:load` | `(none)` | assigned/declared |
| 117 | `self:getData` | `(none)` | assigned/declared |
| 128 | `self:setData` | `newData` | assigned/declared |
| 136 | `self:update` | `func` | assigned/declared |
| 144 | `self:removeKey` | `key` | assigned/declared |
| 148 | `self:setKey` | `key, value` | assigned/declared |
| 152 | `self:clear` | `(none)` | assigned/declared |
| 161 | `split` | `str, delim` | local |
| 170 | `resolve_path` | `data, path, create` | local |
| 190 | `self:removePath` | `path` | assigned/declared |
| 197 | `self:setPath` | `path, value` | assigned/declared |
| 205 | `self:_save_internal` | `(none)` | assigned/declared |
| 269 | `self:save` | `(none)` | assigned/declared |
| 288 | `self:saveData` | `data` | assigned/declared |
| 314 | `self:ready` | `callback` | assigned/declared |
| 318 | `self:updateAndSave` | `func` | assigned/declared |
| 326 | `get_instance` | `filePath` | local |

### Detailed parameter inventory

#### 1. `ensure_directory_exists(filePath)`

- **Line:** 22
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `filePath` | Declared by this function; type not inferred. |

#### 2. `async_ensure_dir(filePath)`

- **Line:** 44
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `filePath` | Declared by this function; type not inferred. |

#### 3. `new(filePath)`

- **Line:** 72
- **Declaration:** local
- **Nearby code comment:** ---------------------------------------------------------------------------- Persistence instance constructor ----------------------------------------------------------------------------

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `filePath` | Declared by this function; type not inferred. |

#### 4. `self:_mark_dirty()`

- **Line:** 84
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 5. `self:load()`

- **Line:** 93
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 6. `self:getData()`

- **Line:** 117
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 7. `self:setData(newData)`

- **Line:** 128
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `newData` | Declared by this function; type not inferred. |

#### 8. `self:update(func)`

- **Line:** 136
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `func` | Declared by this function; type not inferred. |

#### 9. `self:removeKey(key)`

- **Line:** 144
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |

#### 10. `self:setKey(key, value)`

- **Line:** 148
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |
| 2 | `value` | Declared by this function; type not inferred. |

#### 11. `self:clear()`

- **Line:** 152
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 12. `split(str, delim)`

- **Line:** 161
- **Declaration:** local
- **Nearby code comment:** Helper for nested path access

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `str` | Declared by this function; type not inferred. |
| 2 | `delim` | Declared by this function; type not inferred. |

#### 13. `resolve_path(data, path, create)`

- **Line:** 170
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `data` | Declared by this function; type not inferred. |
| 2 | `path` | Declared by this function; type not inferred. |
| 3 | `create` | Declared by this function; type not inferred. |

#### 14. `self:removePath(path)`

- **Line:** 190
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared by this function; type not inferred. |

#### 15. `self:setPath(path, value)`

- **Line:** 197
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared by this function; type not inferred. |
| 2 | `value` | Declared by this function; type not inferred. |

#### 16. `self:_save_internal()`

- **Line:** 205
- **Declaration:** table/global or assignment
- **Nearby code comment:** Internal save (called by timer or manual) – does NOT clear dirty here
- **Parameters:** none explicitly declared.

#### 17. `self:save()`

- **Line:** 269
- **Declaration:** table/global or assignment
- **Nearby code comment:** Public save: forces an immediate save (bypasses timer)
- **Parameters:** none explicitly declared.

#### 18. `self:saveData(data)`

- **Line:** 288
- **Declaration:** table/global or assignment
- **Nearby code comment:** NEW: Save arbitrary data without modifying internal state. Used by save‑game to avoid inconsistency on failure.

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `data` | Declared by this function; type not inferred. |

#### 19. `self:ready(callback)`

- **Line:** 314
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `callback` | Declared by this function; type not inferred. |

#### 20. `self:updateAndSave(func)`

- **Line:** 318
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `func` | Declared by this function; type not inferred. |

#### 21. `get_instance(filePath)`

- **Line:** 326
- **Declaration:** local
- **Nearby code comment:** Manager: returns the instance for a given file path (creates if not exist)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `filePath` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 12 | `instances` |
| 73 | `self` |
| 81 | `after_save` |
| 109 | `self.data` |
| 121 | `copy` |
| 156 | `self.data` |
| 162 | `result` |
| 222 | `self.after_save` |
| 244 | `self.after_save` |
| 248 | `self.after_save` |
| 257 | `self.after_save` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.on` | 1 | 54 |
