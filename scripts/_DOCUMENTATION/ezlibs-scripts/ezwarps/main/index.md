# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezwarps/main.lua`](../../../../ezlibs-scripts/ezwarps/main.lua)  
> **Source lines:** 420  
> **SHA-256 (UTF-8):** `3df720eb5e128ca1f02d150ce8e55e5df17f97a5bcb78b4d6a798e5220808bb3`  
> **Named/assigned functions detected:** 20  
> **Table initializers detected:** 9

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezwarps/main.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/player-control/legacy-capture` |
| 2 | `scripts/logger/logger` |
| 3 | `scripts/ezlibs-scripts/json` |
| 4 | `scripts/ezlibs-scripts/ezwarps/arrow_animation_factory` |
| 5 | `scripts/ezlibs-scripts/ezwarps/log_in_animation` |
| 6 | `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| 7 | `scripts/ezlibs-scripts/object_registry` |
| 8 | `scripts/ezlibs-scripts/ezbus` |
| 9 | `scripts/ezlibs-scripts/ezcache` |
| 10 | `scripts/ezlibs-scripts/ezwarps/default_spawn_guard` |
| 16 | `scripts/ezlibs-scripts/ezwarps/fall_in_animation` |
| 17 | `scripts/ezlibs-scripts/ezwarps/lev_beast_in_animation` |
| 18 | `scripts/ezlibs-scripts/ezwarps/lev_beast_out_animation` |
| 27 | `scripts/ezlibs-scripts/ezwarps/fall_off_2` |
| 310 | `scripts/ezlibs-scripts/ezpress` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 139 | `interact_warp_emitter` | `interaction` |
| 153 | `radius_warp_emitter` | `entered` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 44 | `ezwarps.guard_return_warp` | `player_id, area_id, warp_object_id, position` | assigned/declared |
| 59 | `update_return_warp_guard` | `player_id, area, x, y` | local |
| 71 | `ezwarps.handle_player_move` | `player_id, x, y, z` | assigned/declared |
| 75 | `ezwarps.handle_player_disconnect` | `player_id` | assigned/declared |
| 79 | `table_has_value` | `table, val` | assigned/declared |
| 89 | `log` | `message` | assigned/declared |
| 95 | `property_is_true` | `value` | local |
| 99 | `add_landing` | `area_id, incoming_data, x, y, z, direction, warp_in, arrival_animation` | assigned/declared |
| 117 | `doAnimationForWarp` | `player_id,animation_name,is_leave_animation,warp_object` | assigned/declared |
| 136 | `add_interact_warp` | `object, object_id, area_id, area_name` | assigned/declared |
| 149 | `add_radius_warp` | `object, object_id, area_id, area_name` | assigned/declared |
| 166 | `add_custom_warp` | `object, object_id, area_id, area_name` | assigned/declared |
| 186 | `process_warp_object` | `area_id, object` | local |
| 211 | `prepare_player_arrival` | `player_id,x,y,z,special_animation_name` | assigned/declared |
| 228 | `ezwarps.handle_player_request` | `player_id, data` | assigned/declared |
| 246 | `use_warp` | `player_id,warp_object,warp_meta` | assigned/declared |
| 362 | `ezwarps.handle_custom_warp` | `player_id, object_id` | assigned/declared |
| 393 | `ezwarps.handle_player_join` | `player_id` | assigned/declared |
| 402 | `ezwarps.player_is_in_animation` | `player_id` | assigned/declared |
| 409 | `ezwarps.handle_player_transfer` | `player_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `ezwarps.guard_return_warp(player_id, area_id, warp_object_id, position)`

- **Line:** 44
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `warp_object_id` | Declared in this function; type not inferred. |
| 4 | `position` | Declared in this function; type not inferred. |

#### 2. `update_return_warp_guard(player_id, area, x, y)`

- **Line:** 59
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area` | Declared in this function; type not inferred. |
| 3 | `x` | Declared in this function; type not inferred. |
| 4 | `y` | Declared in this function; type not inferred. |

#### 3. `ezwarps.handle_player_move(player_id, x, y, z)`

- **Line:** 71
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |
| 3 | `y` | Declared in this function; type not inferred. |
| 4 | `z` | Declared in this function; type not inferred. |

#### 4. `ezwarps.handle_player_disconnect(player_id)`

- **Line:** 75
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 5. `table_has_value(table, val)`

- **Line:** 79
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `table` | Declared in this function; type not inferred. |
| 2 | `val` | Declared in this function; type not inferred. |

#### 6. `log(message)`

- **Line:** 89
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `message` | Declared in this function; type not inferred. |

#### 7. `property_is_true(value)`

- **Line:** 95
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 8. `add_landing(area_id, incoming_data, x, y, z, direction, warp_in, arrival_animation)`

- **Line:** 99
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `incoming_data` | Declared in this function; type not inferred. |
| 3 | `x` | Declared in this function; type not inferred. |
| 4 | `y` | Declared in this function; type not inferred. |
| 5 | `z` | Declared in this function; type not inferred. |
| 6 | `direction` | Declared in this function; type not inferred. |
| 7 | `warp_in` | Declared in this function; type not inferred. |
| 8 | `arrival_animation` | Declared in this function; type not inferred. |

#### 9. `doAnimationForWarp(player_id,animation_name,is_leave_animation,warp_object)`

- **Line:** 117
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `animation_name` | Declared in this function; type not inferred. |
| 3 | `is_leave_animation` | Declared in this function; type not inferred. |
| 4 | `warp_object` | Declared in this function; type not inferred. |

#### 10. `add_interact_warp(object, object_id, area_id, area_name)`

- **Line:** 136
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |
| 3 | `area_id` | Declared in this function; type not inferred. |
| 4 | `area_name` | Declared in this function; type not inferred. |

#### 11. `add_radius_warp(object, object_id, area_id, area_name)`

- **Line:** 149
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |
| 3 | `area_id` | Declared in this function; type not inferred. |
| 4 | `area_name` | Declared in this function; type not inferred. |

#### 12. `add_custom_warp(object, object_id, area_id, area_name)`

- **Line:** 166
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |
| 3 | `area_id` | Declared in this function; type not inferred. |
| 4 | `area_name` | Declared in this function; type not inferred. |

#### 13. `process_warp_object(area_id, object)`

- **Line:** 186
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object` | Declared in this function; type not inferred. |

#### 14. `prepare_player_arrival(player_id,x,y,z,special_animation_name)`

- **Line:** 211
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |
| 3 | `y` | Declared in this function; type not inferred. |
| 4 | `z` | Declared in this function; type not inferred. |
| 5 | `special_animation_name` | Declared in this function; type not inferred. |

#### 15. `ezwarps.handle_player_request(player_id, data)`

- **Line:** 228
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `data` | Declared in this function; type not inferred. |

#### 16. `use_warp(player_id,warp_object,warp_meta)`

- **Line:** 246
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `warp_object` | Declared in this function; type not inferred. |
| 3 | `warp_meta` | Declared in this function; type not inferred. |

#### 17. `ezwarps.handle_custom_warp(player_id, object_id)`

- **Line:** 362
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |

#### 18. `ezwarps.handle_player_join(player_id)`

- **Line:** 393
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 19. `ezwarps.player_is_in_animation(player_id)`

- **Line:** 402
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 20. `ezwarps.handle_player_transfer(player_id)`

- **Line:** 409
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 12 | `ezwarps` |
| 15 | `special_animations` |
| 32 | `landings` |
| 33 | `player_animations` |
| 34 | `players_in_animations` |
| 35 | `warp_types_with_landings` |
| 42 | `return_warp_guards` |
| 100 | `new_landing` |
| 254 | `from_position` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_area_name` | 3 | 198 |
| `Net.get_player_area` | 3 | 72 |
| `Net.get_player_position` | 2 | 252 |
| `Net.transfer_player` | 3 | 238 |
| `Net.transfer_server` | 1 | 318 |
