# 📄 `ezcheckpoints.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezcheckpoints.lua`](../../../ezlibs-scripts/ezcheckpoints.lua)  
> **Source lines:** 534  
> **SHA-256 (UTF-8):** `8be7f5f4314f0ed18d6f781cbaa2aa23902f8608694031aaf93a0502776c2bb9`  
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

Current source inventory for `scripts/ezlibs-scripts/ezcheckpoints.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/player-control/legacy-capture` |
| 2 | `scripts/logger/logger` |
| 3 | `scripts/ezlibs-scripts/ezmemory` |
| 4 | `scripts/ezlibs-scripts/helpers` |
| 5 | `scripts/ezlibs-scripts/condition` |
| 6 | `scripts/ezlibs-scripts/ezbus` |
| 7 | `scripts/ezlibs-scripts/utils/eztiledutils` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 63 | `Net` | `player_avatar_change` |
| 79 | `Net` | `player_disconnect` |
| 134 | `Net` | `player_avatar_change` |
| 334 | `Net` | `object_interaction` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 34 | `is_player_alive` | `player_id` | local |
| 45 | `safe_net` | `fn, ...` | local |
| 86 | `ezcheckpoints.handle_player_disconnect` | `player_id` | assigned/declared |
| 94 | `ezcheckpoints.get_player_navi_info` | `player_id` | assigned/declared |
| 102 | `names_equal` | `a, b` | local |
| 107 | `ezcheckpoints.player_has_navi` | `player_id, name` | assigned/declared |
| 112 | `ezcheckpoints.player_has_navi_element` | `player_id, element` | assigned/declared |
| 117 | `ezcheckpoints.player_has_any_navi` | `player_id, names` | assigned/declared |
| 126 | `evaluate_navi_check` | `player_id, navi_check` | local |
| 180 | `ezcheckpoints.unlock_checkpoint_for_player` | `player_id, area_id, object_id, unlocking_asset_name, unlocking_sound_path, unlocking_animation_time, once, opts` | assigned/declared |
| 269 | `ezcheckpoints.force_unlock_checkpoint` | `player_id, area_id, object_id, once, opts` | assigned/declared |
| 291 | `ezcheckpoints.relock_checkpoint` | `player_id, area_id, object_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `is_player_alive(player_id)`

- **Line:** 34
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 2. `safe_net(fn, ...)`

- **Line:** 45
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `fn` | Declared in this function; type not inferred. |
| 2 | `...` | Declared in this function; type not inferred. |

#### 3. `ezcheckpoints.handle_player_disconnect(player_id)`

- **Line:** 86
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 4. `ezcheckpoints.get_player_navi_info(player_id)`

- **Line:** 94
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 5. `names_equal(a, b)`

- **Line:** 102
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `a` | Declared in this function; type not inferred. |
| 2 | `b` | Declared in this function; type not inferred. |

#### 6. `ezcheckpoints.player_has_navi(player_id, name)`

- **Line:** 107
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `name` | Declared in this function; type not inferred. |

#### 7. `ezcheckpoints.player_has_navi_element(player_id, element)`

- **Line:** 112
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `element` | Declared in this function; type not inferred. |

#### 8. `ezcheckpoints.player_has_any_navi(player_id, names)`

- **Line:** 117
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `names` | Declared in this function; type not inferred. |

#### 9. `evaluate_navi_check(player_id, navi_check)`

- **Line:** 126
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `navi_check` | Declared in this function; type not inferred. |

#### 10. `ezcheckpoints.unlock_checkpoint_for_player(player_id, area_id, object_id, unlocking_asset_name, unlocking_sound_path, unlocking_animation_time, once, opts)`

- **Line:** 180
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `object_id` | Declared in this function; type not inferred. |
| 4 | `unlocking_asset_name` | Declared in this function; type not inferred. |
| 5 | `unlocking_sound_path` | Declared in this function; type not inferred. |
| 6 | `unlocking_animation_time` | Declared in this function; type not inferred. |
| 7 | `once` | Declared in this function; type not inferred. |
| 8 | `opts` | Declared in this function; type not inferred. |

#### 11. `ezcheckpoints.force_unlock_checkpoint(player_id, area_id, object_id, once, opts)`

- **Line:** 269
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `object_id` | Declared in this function; type not inferred. |
| 4 | `once` | Declared in this function; type not inferred. |
| 5 | `opts` | Declared in this function; type not inferred. |

#### 12. `ezcheckpoints.relock_checkpoint(player_id, area_id, object_id)`

- **Line:** 291
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `object_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 20 | `ezcheckpoints` |
| 61 | `navi_cache` |
| 225 | `new_bot_props` |
| 407 | `cond` |
| 411 | `cond` |
| 415 | `cond` |
| 425 | `cond` |
| 442 | `navi_check` |
| 453 | `navi_check` |
| 457 | `navi_list` |
| 470 | `navi_check` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.create_bot` | 1 | 237 |
| `Net.get_object_by_id` | 3 | 190 |
| `Net.get_player_area` | 1 | 340 |
| `Net.on` | 4 | 63 |
