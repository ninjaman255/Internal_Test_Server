# 📄 `ezcheckpoints.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezcheckpoints.lua`](../../../ezlibs-scripts/ezcheckpoints.lua)  
> **Source lines:** 534  
> **SHA-256 (UTF-8):** `9578485faf87fd57ee35daa910410bcf56692767d68f5e8df0c3c3bc6c4e447f`  
> **Named functions detected:** 12  
> **Table initializers detected:** 11

> **Static reference:** Function signatures, dependency paths, and event names are extracted from current Lua. The listing does not establish runtime reachability or public API exposure. See the authored guide for semantics.

## Contents
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Dependencies

| Line | `require` path |
|---:|---|
| 1 | `scripts/player-control/main` |
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

## Functions and parameters

| Line | Function | Arguments | Declaration |
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

### Parameter inventory

#### 1. `is_player_alive(player_id)`

- **Line:** 34
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 2. `safe_net(fn, ...)`

- **Line:** 45
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `fn` | Declared directly in the current Lua. Type not inferred. |
| 2 | `...` | Declared directly in the current Lua. Type not inferred. |

#### 3. `ezcheckpoints.handle_player_disconnect(player_id)`

- **Line:** 86
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 4. `ezcheckpoints.get_player_navi_info(player_id)`

- **Line:** 94
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 5. `names_equal(a, b)`

- **Line:** 102
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `a` | Declared directly in the current Lua. Type not inferred. |
| 2 | `b` | Declared directly in the current Lua. Type not inferred. |

#### 6. `ezcheckpoints.player_has_navi(player_id, name)`

- **Line:** 107
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `name` | Declared directly in the current Lua. Type not inferred. |

#### 7. `ezcheckpoints.player_has_navi_element(player_id, element)`

- **Line:** 112
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `element` | Declared directly in the current Lua. Type not inferred. |

#### 8. `ezcheckpoints.player_has_any_navi(player_id, names)`

- **Line:** 117
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `names` | Declared directly in the current Lua. Type not inferred. |

#### 9. `evaluate_navi_check(player_id, navi_check)`

- **Line:** 126
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `navi_check` | Declared directly in the current Lua. Type not inferred. |

#### 10. `ezcheckpoints.unlock_checkpoint_for_player(player_id, area_id, object_id, unlocking_asset_name, unlocking_sound_path, unlocking_animation_time, once, opts)`

- **Line:** 180
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `unlocking_asset_name` | Declared directly in the current Lua. Type not inferred. |
| 5 | `unlocking_sound_path` | Declared directly in the current Lua. Type not inferred. |
| 6 | `unlocking_animation_time` | Declared directly in the current Lua. Type not inferred. |
| 7 | `once` | Declared directly in the current Lua. Type not inferred. |
| 8 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 11. `ezcheckpoints.force_unlock_checkpoint(player_id, area_id, object_id, once, opts)`

- **Line:** 269
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `once` | Declared directly in the current Lua. Type not inferred. |
| 5 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 12. `ezcheckpoints.relock_checkpoint(player_id, area_id, object_id)`

- **Line:** 291
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `object_id` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
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

| API | Count | First line |
|---|---:|---:|
| `Net.create_bot` | 1 | 237 |
| `Net.get_object_by_id` | 3 | 190 |
| `Net.get_player_area` | 1 | 340 |
| `Net.on` | 4 | 63 |
