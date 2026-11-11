# 📄 `helpers.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/helpers.lua`](../../../ezlibs-scripts/helpers.lua)  
> **Source lines:** 228  
> **SHA-256 (UTF-8):** `5743cdb0e9e9205ad4a3dbddc46d58cdce43dae7eaf6b5a60aaaf01961cafed9`  
> **Named/assigned functions detected:** 19  
> **Table initializers detected:** 8

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/helpers.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 3 | `scripts/ezlibs-scripts/utils/ezutil` |
| 4 | `scripts/ezlibs-scripts/urlencode` |
| 5 | `scripts/ezlibs-scripts/ezcache` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 220 | `Net` | `player_disconnect` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 9 | `async` | `p` | assigned/declared |
| 14 | `await` | `v` | assigned/declared |
| 16 | `first_value_from_table` | `tbl` | assigned/declared |
| 23 | `get_table_length` | `tbl` | assigned/declared |
| 27 | `helpers.indexOf` | `array, value` | assigned/declared |
| 36 | `helpers.extract_numbered_properties` | `object,property_prefix` | assigned/declared |
| 47 | `helpers.clear_table` | `tbl` | assigned/declared |
| 54 | `helpers.create_bbs_option` | `text,id` | assigned/declared |
| 61 | `helpers.deep_copy` | `orig` | assigned/declared |
| 65 | `helpers.split` | `string, delimiter` | assigned/declared |
| 73 | `helpers.get_safe_player_secret` | `player_id` | assigned/declared |
| 79 | `helpers.safe_require` | `script_path` | assigned/declared |
| 93 | `helpers.date_string_to_timestamp` | `date_string` | assigned/declared |
| 109 | `helpers.is_now_before_date` | `date_string` | assigned/declared |
| 118 | `helpers.position_overlaps_something` | `position,area_id` | assigned/declared |
| 135 | `helpers.get_lock` | `player_id,lock_id,timeout` | assigned/declared |
| 141 | `release` | `(none)` | assigned/declared |
| 160 | `helpers.read_item_information` | `area_id, item_object_id` | assigned/declared |
| 183 | `helpers.ensure_directory` | `path` | assigned/declared |

### Detailed parameter inventory

#### 1. `async(p)`

- **Line:** 9
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `p` | Declared in this function; type not inferred. |

#### 2. `await(v)`

- **Line:** 14
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `v` | Declared in this function; type not inferred. |

#### 3. `first_value_from_table(tbl)`

- **Line:** 16
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tbl` | Declared in this function; type not inferred. |

#### 4. `get_table_length(tbl)`

- **Line:** 23
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tbl` | Declared in this function; type not inferred. |

#### 5. `helpers.indexOf(array, value)`

- **Line:** 27
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `array` | Declared in this function; type not inferred. |
| 2 | `value` | Declared in this function; type not inferred. |

#### 6. `helpers.extract_numbered_properties(object,property_prefix)`

- **Line:** 36
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared in this function; type not inferred. |
| 2 | `property_prefix` | Declared in this function; type not inferred. |

#### 7. `helpers.clear_table(tbl)`

- **Line:** 47
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tbl` | Declared in this function; type not inferred. |

#### 8. `helpers.create_bbs_option(text,id)`

- **Line:** 54
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `text` | Declared in this function; type not inferred. |
| 2 | `id` | Declared in this function; type not inferred. |

#### 9. `helpers.deep_copy(orig)`

- **Line:** 61
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `orig` | Declared in this function; type not inferred. |

#### 10. `helpers.split(string, delimiter)`

- **Line:** 65
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `string` | Declared in this function; type not inferred. |
| 2 | `delimiter` | Declared in this function; type not inferred. |

#### 11. `helpers.get_safe_player_secret(player_id)`

- **Line:** 73
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 12. `helpers.safe_require(script_path)`

- **Line:** 79
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `script_path` | Declared in this function; type not inferred. |

#### 13. `helpers.date_string_to_timestamp(date_string)`

- **Line:** 93
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `date_string` | Declared in this function; type not inferred. |

#### 14. `helpers.is_now_before_date(date_string)`

- **Line:** 109
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `date_string` | Declared in this function; type not inferred. |

#### 15. `helpers.position_overlaps_something(position,area_id)`

- **Line:** 118
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `position` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |

#### 16. `helpers.get_lock(player_id,lock_id,timeout)`

- **Line:** 135
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `lock_id` | Declared in this function; type not inferred. |
| 3 | `timeout` | Declared in this function; type not inferred. |

#### 17. `release()`

- **Line:** 141
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 18. `helpers.read_item_information(area_id, item_object_id)`

- **Line:** 160
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `item_object_id` | Declared in this function; type not inferred. |

#### 19. `helpers.ensure_directory(path)`

- **Line:** 183
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 2 | `helpers` |
| 6 | `locks` |
| 7 | `locks_by_player` |
| 37 | `out_table` |
| 66 | `table` |
| 99 | `date_part_keys` |
| 140 | `lock` |
| 163 | `item` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_player_position` | 1 | 122 |
| `Net.get_player_secret` | 1 | 74 |
| `Net.list_players` | 1 | 119 |
| `Net.on` | 1 | 220 |
