# 📄 `ezfarms.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezfarms.lua`](../../../ezlibs-scripts/ezfarms.lua)  
> **Source lines:** 632  
> **SHA-256 (UTF-8):** `ad718635064ff25a5b9cb46dfcc914b292552812e1ba51729c7e8e65d7318143`  
> **Named/assigned functions detected:** 27  
> **Table initializers detected:** 36

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezfarms.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 4 | `scripts/ezlibs-scripts/ezconfig` |
| 5 | `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| 6 | `scripts/ezlibs-scripts/ezweather` |
| 7 | `scripts/ezlibs-scripts/ezmemory` |
| 8 | `table` |
| 9 | `scripts/ezlibs-scripts/helpers` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 105 | `calculate_plant_sell_price` | `plant_name` | local |
| 118 | `calculate_plant_gid` | `plant_name, growth_stage` | local |
| 136 | `determine_growth_stage` | `plant_name, elapsed_since_planted, elpased_since_water, death_time` | local |
| 157 | `update_tile` | `current_time, loc_string, area_weather` | local |
| 256 | `load_farm` | `(none)` | assigned/declared |
| 271 | `update_all_tiles` | `(none)` | assigned/declared |
| 290 | `ezfarms.handle_player_join` | `player_id` | assigned/declared |
| 299 | `ezfarms.on_tick` | `delta_time` | assigned/declared |
| 314 | `ezfarms.handle_post_selection` | `player_id, post_id` | assigned/declared |
| 338 | `ezfarms.handle_board_close` | `player_id` | assigned/declared |
| 342 | `try_buy_seed` | `player_id, plant_name` | assigned/declared |
| 355 | `list_plants` | `player_id` | local |
| 373 | `action` | `npc, player_id, dialogue` | assigned/declared |
| 389 | `ezfarms.list_player_tools` | `player_id` | assigned/declared |
| 404 | `ezfarms.open_held_item_select` | `player_id` | assigned/declared |
| 416 | `get_location_string` | `x, y, z` | local |
| 420 | `till_tile` | `tile, x, y, z, player_id` | local |
| 443 | `ezfarms.handle_object_interaction` | `player_id, object_id` | assigned/declared |
| 468 | `water_tile` | `tile, tile_loc_string, player_id, safe_secret` | local |
| 488 | `plant` | `tile_loc_string, player_id, seed, current_time` | local |
| 505 | `deleet_plant` | `tile_loc_string, current_time` | local |
| 516 | `scythe_plant` | `tile_loc_string, current_time, prexisting_plant, player_id` | local |
| 527 | `harvest` | `tile_loc_string, player_id, safe_secret, current_time` | local |
| 538 | `describe_growth_state` | `growth_stage` | local |
| 542 | `try_harvest` | `tile_loc_string, prexisting_plant, player_id, safe_secret, current_time` | local |
| 559 | `try_plant_seed` | `tile, tile_loc_string, player_id, seed` | local |
| 573 | `ezfarms.handle_tile_interaction` | `player_id, x, y, z, button` | assigned/declared |

### Detailed parameter inventory

#### 1. `calculate_plant_sell_price(plant_name)`

- **Line:** 105
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `plant_name` | Declared in this function; type not inferred. |

#### 2. `calculate_plant_gid(plant_name, growth_stage)`

- **Line:** 118
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `plant_name` | Declared in this function; type not inferred. |
| 2 | `growth_stage` | Declared in this function; type not inferred. |

#### 3. `determine_growth_stage(plant_name, elapsed_since_planted, elpased_since_water, death_time)`

- **Line:** 136
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `plant_name` | Declared in this function; type not inferred. |
| 2 | `elapsed_since_planted` | Declared in this function; type not inferred. |
| 3 | `elpased_since_water` | Declared in this function; type not inferred. |
| 4 | `death_time` | Declared in this function; type not inferred. |

#### 4. `update_tile(current_time, loc_string, area_weather)`

- **Line:** 157
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `current_time` | Declared in this function; type not inferred. |
| 2 | `loc_string` | Declared in this function; type not inferred. |
| 3 | `area_weather` | Declared in this function; type not inferred. |

#### 5. `load_farm()`

- **Line:** 256
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 6. `update_all_tiles()`

- **Line:** 271
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 7. `ezfarms.handle_player_join(player_id)`

- **Line:** 290
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 8. `ezfarms.on_tick(delta_time)`

- **Line:** 299
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `delta_time` | Declared in this function; type not inferred. |

#### 9. `ezfarms.handle_post_selection(player_id, post_id)`

- **Line:** 314
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `post_id` | Declared in this function; type not inferred. |

#### 10. `ezfarms.handle_board_close(player_id)`

- **Line:** 338
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 11. `try_buy_seed(player_id, plant_name)`

- **Line:** 342
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `plant_name` | Declared in this function; type not inferred. |

#### 12. `list_plants(player_id)`

- **Line:** 355
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 13. `action(npc, player_id, dialogue)`

- **Line:** 373
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `dialogue` | Declared in this function; type not inferred. |

#### 14. `ezfarms.list_player_tools(player_id)`

- **Line:** 389
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 15. `ezfarms.open_held_item_select(player_id)`

- **Line:** 404
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 16. `get_location_string(x, y, z)`

- **Line:** 416
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `x` | Declared in this function; type not inferred. |
| 2 | `y` | Declared in this function; type not inferred. |
| 3 | `z` | Declared in this function; type not inferred. |

#### 17. `till_tile(tile, x, y, z, player_id)`

- **Line:** 420
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tile` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |
| 3 | `y` | Declared in this function; type not inferred. |
| 4 | `z` | Declared in this function; type not inferred. |
| 5 | `player_id` | Declared in this function; type not inferred. |

#### 18. `ezfarms.handle_object_interaction(player_id, object_id)`

- **Line:** 443
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |

#### 19. `water_tile(tile, tile_loc_string, player_id, safe_secret)`

- **Line:** 468
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tile` | Declared in this function; type not inferred. |
| 2 | `tile_loc_string` | Declared in this function; type not inferred. |
| 3 | `player_id` | Declared in this function; type not inferred. |
| 4 | `safe_secret` | Declared in this function; type not inferred. |

#### 20. `plant(tile_loc_string, player_id, seed, current_time)`

- **Line:** 488
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tile_loc_string` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `seed` | Declared in this function; type not inferred. |
| 4 | `current_time` | Declared in this function; type not inferred. |

#### 21. `deleet_plant(tile_loc_string, current_time)`

- **Line:** 505
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tile_loc_string` | Declared in this function; type not inferred. |
| 2 | `current_time` | Declared in this function; type not inferred. |

#### 22. `scythe_plant(tile_loc_string, current_time, prexisting_plant, player_id)`

- **Line:** 516
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tile_loc_string` | Declared in this function; type not inferred. |
| 2 | `current_time` | Declared in this function; type not inferred. |
| 3 | `prexisting_plant` | Declared in this function; type not inferred. |
| 4 | `player_id` | Declared in this function; type not inferred. |

#### 23. `harvest(tile_loc_string, player_id, safe_secret, current_time)`

- **Line:** 527
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tile_loc_string` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `safe_secret` | Declared in this function; type not inferred. |
| 4 | `current_time` | Declared in this function; type not inferred. |

#### 24. `describe_growth_state(growth_stage)`

- **Line:** 538
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `growth_stage` | Declared in this function; type not inferred. |

#### 25. `try_harvest(tile_loc_string, prexisting_plant, player_id, safe_secret, current_time)`

- **Line:** 542
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tile_loc_string` | Declared in this function; type not inferred. |
| 2 | `prexisting_plant` | Declared in this function; type not inferred. |
| 3 | `player_id` | Declared in this function; type not inferred. |
| 4 | `safe_secret` | Declared in this function; type not inferred. |
| 5 | `current_time` | Declared in this function; type not inferred. |

#### 26. `try_plant_seed(tile, tile_loc_string, player_id, seed)`

- **Line:** 559
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tile` | Declared in this function; type not inferred. |
| 2 | `tile_loc_string` | Declared in this function; type not inferred. |
| 3 | `player_id` | Declared in this function; type not inferred. |
| 4 | `seed` | Declared in this function; type not inferred. |

#### 27. `ezfarms.handle_tile_interaction(player_id, x, y, z, button)`

- **Line:** 573
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |
| 3 | `y` | Declared in this function; type not inferred. |
| 4 | `z` | Declared in this function; type not inferred. |
| 5 | `button` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 2 | `ezfarms` |
| 11 | `players_using_bbs` |
| 12 | `player_tools` |
| 26 | `plant_ram` |
| 28 | `PlantData` |
| 29 | `Parsnip` |
| 30 | `Cauli` |
| 31 | `Garlic` |
| 32 | `Tomato` |
| 33 | `Chili` |
| 34 | `Radish` |
| 36 | `Eggplant` |
| 37 | `Pumpkin` |
| 38 | `Yam` |
| 39 | `Beetroot` |
| 42 | `Blueberry` |
| 43 | `Dead` |
| 47 | `ToolNames` |
| 58 | `growth_stage_descriptions` |
| 67 | `Tiles` |
| 73 | `sfx` |
| 86 | `Period` |
| 178 | `plant_tile_data` |
| 184 | `new_plant_data` |
| 206 | `plant_tile_data` |
| 261 | `area_memory.tile_states` |
| 358 | `plant_counts` |
| 371 | `veggie_stall` |
| 375 | `board_color` |
| 376 | `posts` |
| 392 | `tool_counts` |
| 406 | `board_color` |
| 407 | `posts` |
| 430 | `time` |
| 456 | `player_memory.farming` |
| 473 | `player_memory.farming` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.close_bbs` | 1 | 322 |
| `Net.create_object` | 1 | 194 |
| `Net.get_object_by_id` | 1 | 448 |
| `Net.get_object_by_name` | 1 | 20 |
| `Net.get_player_area` | 2 | 444 |
| `Net.get_player_mugshot` | 2 | 461 |
| `Net.get_tile` | 1 | 592 |
| `Net.message_player` | 14 | 321 |
| `Net.open_board` | 2 | 383 |
| `Net.play_sound` | 1 | 601 |
| `Net.play_sound_for_player` | 8 | 332 |
| `Net.provide_asset_for_player` | 1 | 293 |
| `Net.remove_object` | 1 | 219 |
| `Net.remove_post` | 1 | 330 |
| `Net.set_object_data` | 1 | 213 |
| `Net.set_tile` | 1 | 252 |
