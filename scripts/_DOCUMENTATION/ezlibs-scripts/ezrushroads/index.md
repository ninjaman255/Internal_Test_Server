# 📄 `ezrushroads.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezrushroads.lua`](../../../ezlibs-scripts/ezrushroads.lua)  
> **Source lines:** 676  
> **SHA-256 (UTF-8):** `6a59350a2cec27c2e03b6a75c0fde2ccfcc052c46d06ab8e87aace8d7e1c8734`  
> **Named/assigned functions detected:** 22  
> **Table initializers detected:** 17

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezrushroads.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/player-control/legacy-capture` |
| 5 | `scripts/logger/logger` |
| 11 | `scripts/ezlibs-scripts/helpers` |
| 12 | `scripts/ezlibs-scripts/ezmemory` |
| 13 | `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| 14 | `scripts/ezlibs-scripts/ezbus` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 282 | `emitter` | `entered` |
| 297 | `emitter` | `departed` |
| 433 | `ezbus` | `rush_tile_entered` |
| 456 | `ezbus` | `rush_tile_departed` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 17 | `async` | `p` | local |
| 24 | `get_table_length` | `tbl` | local |
| 31 | `get_anim_state_from_direction` | `direction` | local |
| 66 | `get_food_item_id` | `player_id` | local |
| 73 | `get_player_rush_memory` | `player_id` | local |
| 83 | `update_food_item` | `player_id, count` | local |
| 98 | `ezrushroads.get_food` | `player_id` | assigned/declared |
| 103 | `ezrushroads.add_food` | `player_id, amount` | assigned/declared |
| 112 | `ezrushroads.remove_food` | `player_id, amount` | assigned/declared |
| 128 | `group_rush_roads_in_area` | `area_id` | local |
| 140 | `dfs` | `start_id, group_id` | local |
| 183 | `create_permanent_bot` | `area_id, road_id, linked_obj, direction` | local |
| 241 | `process_rush_road` | `area_id, object` | local |
| 315 | `ezrushroads.init` | `(none)` | assigned/declared |
| 339 | `update_visibility_for_player` | `player_id, area_id` | local |
| 372 | `create_temp_bots_for_player` | `player_id` | local |
| 411 | `remove_temp_bots_for_player` | `player_id` | local |
| 424 | `clear_active_animation` | `player_id` | local |
| 482 | `ezrushroads.handle_player_join` | `player_id` | assigned/declared |
| 506 | `ezrushroads.handle_player_disconnect` | `player_id` | assigned/declared |
| 527 | `ezrushroads.handle_player_transfer` | `player_id` | assigned/declared |
| 535 | `ezrushroads.handle_object_interaction` | `player_id, object_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `async(p)`

- **Line:** 17
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `p` | Declared in this function; type not inferred. |

#### 2. `get_table_length(tbl)`

- **Line:** 24
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tbl` | Declared in this function; type not inferred. |

#### 3. `get_anim_state_from_direction(direction)`

- **Line:** 31
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `direction` | Declared in this function; type not inferred. |

#### 4. `get_food_item_id(player_id)`

- **Line:** 66
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 5. `get_player_rush_memory(player_id)`

- **Line:** 73
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 6. `update_food_item(player_id, count)`

- **Line:** 83
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `count` | Declared in this function; type not inferred. |

#### 7. `ezrushroads.get_food(player_id)`

- **Line:** 98
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 8. `ezrushroads.add_food(player_id, amount)`

- **Line:** 103
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `amount` | Declared in this function; type not inferred. |

#### 9. `ezrushroads.remove_food(player_id, amount)`

- **Line:** 112
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `amount` | Declared in this function; type not inferred. |

#### 10. `group_rush_roads_in_area(area_id)`

- **Line:** 128
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 11. `dfs(start_id, group_id)`

- **Line:** 140
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `start_id` | Declared in this function; type not inferred. |
| 2 | `group_id` | Declared in this function; type not inferred. |

#### 12. `create_permanent_bot(area_id, road_id, linked_obj, direction)`

- **Line:** 183
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `road_id` | Declared in this function; type not inferred. |
| 3 | `linked_obj` | Declared in this function; type not inferred. |
| 4 | `direction` | Declared in this function; type not inferred. |

#### 13. `process_rush_road(area_id, object)`

- **Line:** 241
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object` | Declared in this function; type not inferred. |

#### 14. `ezrushroads.init()`

- **Line:** 315
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 15. `update_visibility_for_player(player_id, area_id)`

- **Line:** 339
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |

#### 16. `create_temp_bots_for_player(player_id)`

- **Line:** 372
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 17. `remove_temp_bots_for_player(player_id)`

- **Line:** 411
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 18. `clear_active_animation(player_id)`

- **Line:** 424
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 19. `ezrushroads.handle_player_join(player_id)`

- **Line:** 482
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 20. `ezrushroads.handle_player_disconnect(player_id)`

- **Line:** 506
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 21. `ezrushroads.handle_player_transfer(player_id)`

- **Line:** 527
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 22. `ezrushroads.handle_object_interaction(player_id, object_id)`

- **Line:** 535
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 6 | `ezrushroads` |
| 42 | `rush_roads` |
| 43 | `player_temp_bots` |
| 44 | `player_active_animation` |
| 45 | `bot_occupants` |
| 46 | `any_player` |
| 77 | `mem.rushroads` |
| 132 | `road_ids` |
| 137 | `visited` |
| 141 | `stack` |
| 246 | `road` |
| 581 | `group_roads` |
| 605 | `anim_state` |
| 609 | `roads` |
| 624 | `move_in` |
| 628 | `keyframes` |
| 657 | `move_out` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.animate_bot_properties` | 3 | 625 |
| `Net.create_item` | 1 | 89 |
| `Net.exclude_actor_for_player` | 2 | 362 |
| `Net.exclude_object_for_player` | 2 | 351 |
| `Net.get_object_by_id` | 3 | 268 |
| `Net.get_player_area` | 3 | 500 |
| `Net.get_player_name` | 2 | 491 |
| `Net.give_player_item` | 1 | 94 |
| `Net.include_actor_for_player` | 2 | 359 |
| `Net.include_object_for_player` | 1 | 353 |
| `Net.list_areas` | 1 | 317 |
| `Net.list_objects` | 1 | 319 |
| `Net.message_player` | 1 | 558 |
| `Net.move_bot` | 3 | 450 |
| `Net.remove_bot` | 1 | 415 |
| `Net.remove_player_item` | 1 | 86 |
