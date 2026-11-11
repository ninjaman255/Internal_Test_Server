# 📄 `tileset_embedder.lua` — Current Lua reference

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/tileset_embedder.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/tileset_embedder.lua)  
> **Source lines:** 356  
> **SHA-256 (UTF-8):** `30b6d2c4f2b34fb381b435d1f8722decc5851d1a4d2b285d83156d2668ed7e3a`  
> **Named/assigned functions detected:** 12  
> **Table initializers detected:** 8

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-custom/nebulous-liberations/liberations/tileset_embedder.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 7 | `scripts/logger/logger` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 41 | `basename` | `path` | local |
| 45 | `source_to_file_path` | `source` | local |
| 55 | `parse_tilesets` | `tmx` | local |
| 73 | `get_liberation_config` | `area_id` | local |
| 85 | `publish_shared_assets` | `(none)` | local |
| 129 | `read_tileset_tilecount` | `entry` | local |
| 158 | `next_gid_after_existing_tilesets` | `entries` | local |
| 172 | `normalize_shared_sources` | `tmx, entries` | local |
| 191 | `insert_declarations` | `tmx, declarations` | local |
| 208 | `write_updated_map` | `area_id, map_path, original, updated` | local |
| 250 | `process_map` | `area_id` | local |
| 322 | `Embedder.run` | `(none)` | assigned/declared |

### Detailed parameter inventory

#### 1. `basename(path)`

- **Line:** 41
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |

#### 2. `source_to_file_path(source)`

- **Line:** 45
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `source` | Declared in this function; type not inferred. |

#### 3. `parse_tilesets(tmx)`

- **Line:** 55
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tmx` | Declared in this function; type not inferred. |

#### 4. `get_liberation_config(area_id)`

- **Line:** 73
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 5. `publish_shared_assets()`

- **Line:** 85
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 6. `read_tileset_tilecount(entry)`

- **Line:** 129
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |

#### 7. `next_gid_after_existing_tilesets(entries)`

- **Line:** 158
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entries` | Declared in this function; type not inferred. |

#### 8. `normalize_shared_sources(tmx, entries)`

- **Line:** 172
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tmx` | Declared in this function; type not inferred. |
| 2 | `entries` | Declared in this function; type not inferred. |

#### 9. `insert_declarations(tmx, declarations)`

- **Line:** 191
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tmx` | Declared in this function; type not inferred. |
| 2 | `declarations` | Declared in this function; type not inferred. |

#### 10. `write_updated_map(area_id, map_path, original, updated)`

- **Line:** 208
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `map_path` | Declared in this function; type not inferred. |
| 3 | `original` | Declared in this function; type not inferred. |
| 4 | `updated` | Declared in this function; type not inferred. |

#### 11. `process_map(area_id)`

- **Line:** 250
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 12. `Embedder.run()`

- **Line:** 322
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.


## Tables

| Source line | Assignment |
|---:|---|
| 6 | `Embedder` |
| 9 | `SHARED_TILESETS` |
| 36 | `TARGET_BY_FILENAME` |
| 56 | `entries` |
| 88 | `asset_files` |
| 174 | `found` |
| 277 | `missing` |
| 299 | `declarations` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_object_by_id` | 1 | 76 |
| `Net.list_objects` | 1 | 74 |
| `Net.update_asset` | 2 | 108 |
