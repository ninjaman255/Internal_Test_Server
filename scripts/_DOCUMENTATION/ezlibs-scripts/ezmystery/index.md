# 📄 `ezmystery.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezmystery.lua`](../../../ezlibs-scripts/ezmystery.lua)  
> **Source lines:** 398  
> **SHA-256 (UTF-8):** `0cfb11326e25b5abf45332acba3c8f200751d8237cb24c5aa41583b6c264d384`  
> **Named/assigned functions detected:** 12  
> **Table initializers detected:** 11

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezmystery.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 3 | `scripts/ezlibs-scripts/ezmemory` |
| 4 | `scripts/ezlibs-scripts/ezcache` |
| 5 | `scripts/ezlibs-scripts/helpers` |
| 6 | `scripts/ezlibs-scripts/ezlocks` |
| 7 | `scripts/ezlibs-scripts/condition` |
| 8 | `scripts/ezlibs-scripts/ezencounters/main` |
| 9 | `math` |
| 10 | `scripts/ezlibs-scripts/ezbus` |
| 12 | `scripts/ezlibs-scripts/avatar_utils/main` |
| 13 | `scripts/ezlibs-scripts/avatar_utils/avatar_utils` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 74 | `Net` | `player_join` |
| 79 | `Net` | `avatar_change` |
| 84 | `Net` | `object_interaction` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 26 | `is_property_true` | `val` | local |
| 40 | `resource_name` | `cost_type` | local |
| 47 | `object_is_mystery_data` | `object` | local |
| 53 | `fetch_player_avatar_and_details` | `player_id` | local |
| 92 | `ezmystery.handle_player_disconnect` | `player_id` | assigned/declared |
| 96 | `ezmystery.hide_random_data` | `player_id` | assigned/declared |
| 133 | `ezmystery.handle_player_transfer` | `player_id` | assigned/declared |
| 137 | `ezmystery.handle_player_join` | `player_id` | assigned/declared |
| 141 | `run_quiz_from_list` | `player_id, area_id, quiz_list_id, failure_message` | local |
| 201 | `try_collect_datum` | `player_id, area_id, object` | assigned/declared |
| 308 | `read_datum_information` | `area_id, object` | assigned/declared |
| 323 | `collect_datum` | `player_id, object, datum_id_override, is_quiz` | assigned/declared |

### Detailed parameter inventory

#### 1. `is_property_true(val)`

- **Line:** 26
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `val` | Declared in this function; type not inferred. |

#### 2. `resource_name(cost_type)`

- **Line:** 40
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `cost_type` | Declared in this function; type not inferred. |

#### 3. `object_is_mystery_data(object)`

- **Line:** 47
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared in this function; type not inferred. |

#### 4. `fetch_player_avatar_and_details(player_id)`

- **Line:** 53
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 5. `ezmystery.handle_player_disconnect(player_id)`

- **Line:** 92
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 6. `ezmystery.hide_random_data(player_id)`

- **Line:** 96
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 7. `ezmystery.handle_player_transfer(player_id)`

- **Line:** 133
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 8. `ezmystery.handle_player_join(player_id)`

- **Line:** 137
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 9. `run_quiz_from_list(player_id, area_id, quiz_list_id, failure_message)`

- **Line:** 141
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `quiz_list_id` | Declared in this function; type not inferred. |
| 4 | `failure_message` | Declared in this function; type not inferred. |

#### 10. `try_collect_datum(player_id, area_id, object)`

- **Line:** 201
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `object` | Declared in this function; type not inferred. |

#### 11. `read_datum_information(area_id, object)`

- **Line:** 308
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object` | Declared in this function; type not inferred. |

#### 12. `collect_datum(player_id, object, datum_id_override, is_quiz)`

- **Line:** 323
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `object` | Declared in this function; type not inferred. |
| 3 | `datum_id_override` | Declared in this function; type not inferred. |
| 4 | `is_quiz` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 2 | `ezmystery` |
| 15 | `object_cache` |
| 16 | `revealed_mysteries_for_players` |
| 18 | `sfx` |
| 22 | `player_avatars` |
| 23 | `player_animations` |
| 109 | `datum_list` |
| 167 | `options` |
| 228 | `check_cond` |
| 250 | `spend_cond` |
| 329 | `item_info` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_area_custom_property` | 2 | 99 |
| `Net.get_object_by_id` | 2 | 86 |
| `Net.get_player_area` | 3 | 85 |
| `Net.get_player_direction` | 1 | 373 |
| `Net.get_player_secret` | 1 | 54 |
| `Net.list_objects` | 1 | 98 |
| `Net.on` | 3 | 74 |
