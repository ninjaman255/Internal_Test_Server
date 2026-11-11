# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/main.lua`](../../../../ezlibs-custom/nebulous-liberations/main.lua)  
> **Source lines:** 731  
> **SHA-256 (UTF-8):** `7ccf10b847cbc1b6eb965d462f3e6eef7bb064a15c11d2ece9cd80981805bea4`  
> **Named/assigned functions detected:** 22  
> **Table initializers detected:** 11

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-custom/nebulous-liberations/main.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 10 | `scripts/logger/logger` |
| 11 | `scripts/ezlibs-scripts/ezmapinstance` |
| 24 | `scripts/ezlibs-custom/nebulous-liberations/player` |
| 25 | `scripts/ezlibs-custom/nebulous-liberations/liberations/instance` |
| 26 | `scripts/ezlibs-custom/nebulous-liberations/utils/parties` |
| 27 | `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |
| 28 | `scripts/ezlibs-custom/nebulous-liberations/liberations/validation` |
| 29 | `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_registry` |
| 33 | `scripts/ezlibs-custom/nebulous-liberations/liberations/tileset_embedder` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 52 | `get_spawn_direction` | `spawn` | local |
| 66 | `transfer_players_to_new_instance` | `base_area, player_ids` | local |
| 200 | `LibPlugin.spawn_boss` | `instance_area_id, boss_id` | assigned/declared |
| 212 | `LibPlugin.start_game_for_player` | `player_id, liberation_id` | assigned/declared |
| 230 | `detect_door_interaction` | `area_id, player_id, object_id, button` | local |
| 251 | `leave_party` | `player` | local |
| 271 | `remove_instance` | `area_id` | assigned/declared |
| 320 | `LibPlugin.on_tick` | `delta_time` | assigned/declared |
| 339 | `LibPlugin.handle_tile_interaction` | `player_id, x, y, z, button` | assigned/declared |
| 355 | `LibPlugin.handle_object_interaction` | `player_id, object_id, button` | assigned/declared |
| 373 | `LibPlugin.handle_actor_interaction` | `player_id, actor_id, button` | assigned/declared |
| 405 | `LibPlugin.handle_textbox_response` | `player_id, response` | assigned/declared |
| 412 | `LibPlugin.handle_battle_results` | `...` | assigned/declared |
| 439 | `LibPlugin.handle_battle_exit` | `...` | assigned/declared |
| 466 | `LibPlugin.handle_player_avatar_change` | `player_id, details` | assigned/declared |
| 475 | `LibPlugin.handle_player_transfer` | `player_id` | assigned/declared |
| 509 | `LibPlugin.handle_player_request` | `player_id, data` | assigned/declared |
| 515 | `LibPlugin.handle_player_disconnect` | `player_id` | assigned/declared |
| 527 | `LibPlugin.handle_player_move` | `player_id, x, y, z` | assigned/declared |
| 545 | `resolve_area_reference` | `area_reference, area_ids` | local |
| 568 | `register_waiting_area` | `source_area_id, source_area_name, waiting_area, respawn_area, area_ids` | local |
| 593 | `initialize_areas` | `(none)` | local |

### Detailed parameter inventory

#### 1. `get_spawn_direction(spawn)`

- **Line:** 52
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `spawn` | Declared in this function; type not inferred. |

#### 2. `transfer_players_to_new_instance(base_area, player_ids)`

- **Line:** 66
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `base_area` | Declared in this function; type not inferred. |
| 2 | `player_ids` | Declared in this function; type not inferred. |

#### 3. `LibPlugin.spawn_boss(instance_area_id, boss_id)`

- **Line:** 200
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_area_id` | Declared in this function; type not inferred. |
| 2 | `boss_id` | Declared in this function; type not inferred. |

#### 4. `LibPlugin.start_game_for_player(player_id, liberation_id)`

- **Line:** 212
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `liberation_id` | Declared in this function; type not inferred. |

#### 5. `detect_door_interaction(area_id, player_id, object_id, button)`

- **Line:** 230
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `object_id` | Declared in this function; type not inferred. |
| 4 | `button` | Declared in this function; type not inferred. |

#### 6. `leave_party(player)`

- **Line:** 251
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player` | Declared in this function; type not inferred. |

#### 7. `remove_instance(area_id)`

- **Line:** 271
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 8. `LibPlugin.on_tick(delta_time)`

- **Line:** 320
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `delta_time` | Declared in this function; type not inferred. |

#### 9. `LibPlugin.handle_tile_interaction(player_id, x, y, z, button)`

- **Line:** 339
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |
| 3 | `y` | Declared in this function; type not inferred. |
| 4 | `z` | Declared in this function; type not inferred. |
| 5 | `button` | Declared in this function; type not inferred. |

#### 10. `LibPlugin.handle_object_interaction(player_id, object_id, button)`

- **Line:** 355
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |
| 3 | `button` | Declared in this function; type not inferred. |

#### 11. `LibPlugin.handle_actor_interaction(player_id, actor_id, button)`

- **Line:** 373
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `actor_id` | Declared in this function; type not inferred. |
| 3 | `button` | Declared in this function; type not inferred. |

#### 12. `LibPlugin.handle_textbox_response(player_id, response)`

- **Line:** 405
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `response` | Declared in this function; type not inferred. |

#### 13. `LibPlugin.handle_battle_results(...)`

- **Line:** 412
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `...` | Declared in this function; type not inferred. |

#### 14. `LibPlugin.handle_battle_exit(...)`

- **Line:** 439
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `...` | Declared in this function; type not inferred. |

#### 15. `LibPlugin.handle_player_avatar_change(player_id, details)`

- **Line:** 466
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `details` | Declared in this function; type not inferred. |

#### 16. `LibPlugin.handle_player_transfer(player_id)`

- **Line:** 475
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 17. `LibPlugin.handle_player_request(player_id, data)`

- **Line:** 509
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `data` | Declared in this function; type not inferred. |

#### 18. `LibPlugin.handle_player_disconnect(player_id)`

- **Line:** 515
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 19. `LibPlugin.handle_player_move(player_id, x, y, z)`

- **Line:** 527
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |
| 3 | `y` | Declared in this function; type not inferred. |
| 4 | `z` | Declared in this function; type not inferred. |

#### 20. `resolve_area_reference(area_reference, area_ids)`

- **Line:** 545
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_reference` | Declared in this function; type not inferred. |
| 2 | `area_ids` | Declared in this function; type not inferred. |

#### 21. `register_waiting_area(source_area_id, source_area_name, waiting_area, respawn_area, area_ids)`

- **Line:** 568
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `source_area_id` | Declared in this function; type not inferred. |
| 2 | `source_area_name` | Declared in this function; type not inferred. |
| 3 | `waiting_area` | Declared in this function; type not inferred. |
| 4 | `respawn_area` | Declared in this function; type not inferred. |
| 5 | `area_ids` | Declared in this function; type not inferred. |

#### 22. `initialize_areas()`

- **Line:** 593
- **Declaration:** local
- **Parameters:** none explicitly declared.


## Tables

| Source line | Assignment |
|---:|---|
| 19 | `LibPlugin` |
| 35 | `waiting_area_map` |
| 36 | `respawn_table` |
| 37 | `gate_to_area_map` |
| 38 | `instances` |
| 39 | `players` |
| 41 | `SPAWN_DIRECTIONS` |
| 75 | `instance_players` |
| 76 | `instance_player_ids` |
| 99 | `metadata` |
| 324 | `dead_instances` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_area_custom_properties` | 1 | 597 |
| `Net.get_area_name` | 4 | 114 |
| `Net.get_object_by_id` | 3 | 614 |
| `Net.get_object_by_name` | 1 | 279 |
| `Net.get_player_area` | 6 | 307 |
| `Net.get_player_name` | 2 | 256 |
| `Net.get_player_position` | 1 | 485 |
| `Net.get_spawn_position` | 1 | 282 |
| `Net.get_tileset` | 1 | 672 |
| `Net.is_bot` | 1 | 376 |
| `Net.list_areas` | 1 | 594 |
| `Net.list_objects` | 1 | 612 |
| `Net.transfer_player` | 1 | 308 |
