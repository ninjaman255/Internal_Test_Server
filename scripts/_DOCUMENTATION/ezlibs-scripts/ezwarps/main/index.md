# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezwarps/main.lua`](../../../../ezlibs-scripts/ezwarps/main.lua)  
> **Source lines:** 420  
> **SHA-256 (UTF-8):** `d22bce8f346824679a6e7d7f8dfc782d141d3aa48027490e753b97674d1d3a98`  
> **Named functions detected:** 20  
> **Table initializers detected:** 9

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

## Functions and parameters

| Line | Function | Arguments | Declaration |
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

### Parameter inventory

#### 1. `ezwarps.guard_return_warp(player_id, area_id, warp_object_id, position)`

- **Line:** 44
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `warp_object_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `position` | Declared directly in the current Lua. Type not inferred. |

#### 2. `update_return_warp_guard(player_id, area, x, y)`

- **Line:** 59
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |

#### 3. `ezwarps.handle_player_move(player_id, x, y, z)`

- **Line:** 71
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `x` | Declared directly in the current Lua. Type not inferred. |
| 3 | `y` | Declared directly in the current Lua. Type not inferred. |
| 4 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 4. `ezwarps.handle_player_disconnect(player_id)`

- **Line:** 75
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 5. `table_has_value(table, val)`

- **Line:** 79
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `table` | Declared directly in the current Lua. Type not inferred. |
| 2 | `val` | Declared directly in the current Lua. Type not inferred. |

#### 6. `log(message)`

- **Line:** 89
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `message` | Declared directly in the current Lua. Type not inferred. |

#### 7. `property_is_true(value)`

- **Line:** 95
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared directly in the current Lua. Type not inferred. |

#### 8. `add_landing(area_id, incoming_data, x, y, z, direction, warp_in, arrival_animation)`

- **Line:** 99
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `incoming_data` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `z` | Declared directly in the current Lua. Type not inferred. |
| 6 | `direction` | Declared directly in the current Lua. Type not inferred. |
| 7 | `warp_in` | Declared directly in the current Lua. Type not inferred. |
| 8 | `arrival_animation` | Declared directly in the current Lua. Type not inferred. |

#### 9. `doAnimationForWarp(player_id,animation_name,is_leave_animation,warp_object)`

- **Line:** 117
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `animation_name` | Declared directly in the current Lua. Type not inferred. |
| 3 | `is_leave_animation` | Declared directly in the current Lua. Type not inferred. |
| 4 | `warp_object` | Declared directly in the current Lua. Type not inferred. |

#### 10. `add_interact_warp(object, object_id, area_id, area_name)`

- **Line:** 136
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `area_name` | Declared directly in the current Lua. Type not inferred. |

#### 11. `add_radius_warp(object, object_id, area_id, area_name)`

- **Line:** 149
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `area_name` | Declared directly in the current Lua. Type not inferred. |

#### 12. `add_custom_warp(object, object_id, area_id, area_name)`

- **Line:** 166
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `area_name` | Declared directly in the current Lua. Type not inferred. |

#### 13. `process_warp_object(area_id, object)`

- **Line:** 186
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object` | Declared directly in the current Lua. Type not inferred. |

#### 14. `prepare_player_arrival(player_id,x,y,z,special_animation_name)`

- **Line:** 211
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `x` | Declared directly in the current Lua. Type not inferred. |
| 3 | `y` | Declared directly in the current Lua. Type not inferred. |
| 4 | `z` | Declared directly in the current Lua. Type not inferred. |
| 5 | `special_animation_name` | Declared directly in the current Lua. Type not inferred. |

#### 15. `ezwarps.handle_player_request(player_id, data)`

- **Line:** 228
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `data` | Declared directly in the current Lua. Type not inferred. |

#### 16. `use_warp(player_id,warp_object,warp_meta)`

- **Line:** 246
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `warp_object` | Declared directly in the current Lua. Type not inferred. |
| 3 | `warp_meta` | Declared directly in the current Lua. Type not inferred. |

#### 17. `ezwarps.handle_custom_warp(player_id, object_id)`

- **Line:** 362
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |

#### 18. `ezwarps.handle_player_join(player_id)`

- **Line:** 393
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 19. `ezwarps.player_is_in_animation(player_id)`

- **Line:** 402
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 20. `ezwarps.handle_player_transfer(player_id)`

- **Line:** 409
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
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

| API | Count | First line |
|---|---:|---:|
| `Net.get_area_name` | 3 | 198 |
| `Net.get_player_area` | 3 | 72 |
| `Net.get_player_position` | 2 | 252 |
| `Net.transfer_player` | 3 | 238 |
| `Net.transfer_server` | 1 | 318 |
