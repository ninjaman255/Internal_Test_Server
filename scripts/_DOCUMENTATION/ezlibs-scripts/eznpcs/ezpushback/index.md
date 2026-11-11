# 📄 `ezpushback.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/eznpcs/ezpushback.lua`](../../../../ezlibs-scripts/eznpcs/ezpushback.lua)  
> **Source lines:** 857  
> **SHA-256 (UTF-8):** `be9d5d4ba4b6231edd437a50f11a2b1f4aebe7ea82ff2158ede0a25b11cb1b69`  
> **Named/assigned functions detected:** 32  
> **Table initializers detected:** 15

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/eznpcs/ezpushback.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/player-control/legacy-capture` |
| 30 | `scripts/logger/logger` |
| 31 | `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| 32 | `scripts/ezlibs-scripts/ezbus` |
| 33 | `scripts/ezlibs-scripts/ezemitter` |
| 34 | `scripts/ezlibs-scripts/object_registry` |
| 35 | `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| 36 | `scripts/ezlibs-scripts/utils/eztiledutils` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 645 | `trigger_emitter` | `entered` |
| 651 | `trigger_emitter` | `departed` |
| 724 | `ezbus` | `npc_spawned_from_spawner` |
| 758 | `ezbus` | `bot_removed` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 65 | `number_property` | `props, name, default, min_value` | local |
| 71 | `safe_call` | `fn, ...` | local |
| 76 | `get_area_players` | `area_id` | local |
| 82 | `provide_avatar_to_area` | `area_id, avatar` | local |
| 90 | `remove_bot` | `bot_id` | local |
| 94 | `event_for` | `entry, player_id, extra` | local |
| 108 | `emit_entry` | `entry, name, event` | local |
| 134 | `get_ezpress` | `(none)` | local |
| 156 | `set_player_scale_immediate` | `player_id, sx, sy` | local |
| 177 | `read_area_size_mode_state` | `area_id` | local |
| 192 | `resolve_target_scale_state` | `area_id, pos` | local |
| 222 | `restore_player_scale` | `player_id, area_id` | local |
| 293 | `map_vector_to_screen` | `dx, dy` | local |
| 298 | `screen_vector_to_map` | `sx, sy` | local |
| 303 | `atan2` | `y, x` | local |
| 324 | `snap_to_canonical_map` | `dx, dy` | local |
| 335 | `direction_vector` | `direction` | local |
| 350 | `get_push_vector` | `entry, player_pos, npc_pos, player_direction` | local |
| 371 | `calculate_target` | `entry, player_pos, npc_pos, player_direction` | local |
| 391 | `cleanup_push` | `player_id, state, reason, restore_player` | local |
| 422 | `perform_pushback` | `entry, player_id` | local |
| 579 | `update_entry_geometry` | `entry` | local |
| 662 | `ezpushback.attach_behavior` | `area_id, object_id, props, bot_id, x, y, z, name` | assigned/declared |
| 690 | `register_pushback_npc` | `area_id, object` | local |
| 776 | `ezpushback.get_emitter` | `area_id, object_id` | assigned/declared |
| 783 | `ezpushback.get_emitter_for_bot` | `bot_id` | assigned/declared |
| 793 | `ezpushback.set_collision_enabled` | `area_id, object_id, enabled` | assigned/declared |
| 801 | `ezpushback.handle_player_move` | `player_id, x, y, z` | assigned/declared |
| 806 | `ezpushback.on_tick` | `delta_time` | assigned/declared |
| 828 | `ezpushback.handle_player_join` | `player_id` | assigned/declared |
| 835 | `ezpushback.handle_player_transfer` | `player_id` | assigned/declared |
| 842 | `ezpushback.handle_player_disconnect` | `player_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `number_property(props, name, default, min_value)`

- **Line:** 65
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `props` | Declared in this function; type not inferred. |
| 2 | `name` | Declared in this function; type not inferred. |
| 3 | `default` | Declared in this function; type not inferred. |
| 4 | `min_value` | Declared in this function; type not inferred. |

#### 2. `safe_call(fn, ...)`

- **Line:** 71
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `fn` | Declared in this function; type not inferred. |
| 2 | `...` | Declared in this function; type not inferred. |

#### 3. `get_area_players(area_id)`

- **Line:** 76
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 4. `provide_avatar_to_area(area_id, avatar)`

- **Line:** 82
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `avatar` | Declared in this function; type not inferred. |

#### 5. `remove_bot(bot_id)`

- **Line:** 90
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |

#### 6. `event_for(entry, player_id, extra)`

- **Line:** 94
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `extra` | Declared in this function; type not inferred. |

#### 7. `emit_entry(entry, name, event)`

- **Line:** 108
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `name` | Declared in this function; type not inferred. |
| 3 | `event` | Declared in this function; type not inferred. |

#### 8. `get_ezpress()`

- **Line:** 134
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 9. `set_player_scale_immediate(player_id, sx, sy)`

- **Line:** 156
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `sx` | Declared in this function; type not inferred. |
| 3 | `sy` | Declared in this function; type not inferred. |

#### 10. `read_area_size_mode_state(area_id)`

- **Line:** 177
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 11. `resolve_target_scale_state(area_id, pos)`

- **Line:** 192
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `pos` | Declared in this function; type not inferred. |

#### 12. `restore_player_scale(player_id, area_id)`

- **Line:** 222
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |

#### 13. `map_vector_to_screen(dx, dy)`

- **Line:** 293
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dx` | Declared in this function; type not inferred. |
| 2 | `dy` | Declared in this function; type not inferred. |

#### 14. `screen_vector_to_map(sx, sy)`

- **Line:** 298
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sx` | Declared in this function; type not inferred. |
| 2 | `sy` | Declared in this function; type not inferred. |

#### 15. `atan2(y, x)`

- **Line:** 303
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `y` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |

#### 16. `snap_to_canonical_map(dx, dy)`

- **Line:** 324
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dx` | Declared in this function; type not inferred. |
| 2 | `dy` | Declared in this function; type not inferred. |

#### 17. `direction_vector(direction)`

- **Line:** 335
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `direction` | Declared in this function; type not inferred. |

#### 18. `get_push_vector(entry, player_pos, npc_pos, player_direction)`

- **Line:** 350
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `player_pos` | Declared in this function; type not inferred. |
| 3 | `npc_pos` | Declared in this function; type not inferred. |
| 4 | `player_direction` | Declared in this function; type not inferred. |

#### 19. `calculate_target(entry, player_pos, npc_pos, player_direction)`

- **Line:** 371
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `player_pos` | Declared in this function; type not inferred. |
| 3 | `npc_pos` | Declared in this function; type not inferred. |
| 4 | `player_direction` | Declared in this function; type not inferred. |

#### 20. `cleanup_push(player_id, state, reason, restore_player)`

- **Line:** 391
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `state` | Declared in this function; type not inferred. |
| 3 | `reason` | Declared in this function; type not inferred. |
| 4 | `restore_player` | Declared in this function; type not inferred. |

#### 21. `perform_pushback(entry, player_id)`

- **Line:** 422
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |

#### 22. `update_entry_geometry(entry)`

- **Line:** 579
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |

#### 23. `ezpushback.attach_behavior(area_id, object_id, props, bot_id, x, y, z, name)`

- **Line:** 662
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |
| 3 | `props` | Declared in this function; type not inferred. |
| 4 | `bot_id` | Declared in this function; type not inferred. |
| 5 | `x` | Declared in this function; type not inferred. |
| 6 | `y` | Declared in this function; type not inferred. |
| 7 | `z` | Declared in this function; type not inferred. |
| 8 | `name` | Declared in this function; type not inferred. |

#### 24. `register_pushback_npc(area_id, object)`

- **Line:** 690
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object` | Declared in this function; type not inferred. |

#### 25. `ezpushback.get_emitter(area_id, object_id)`

- **Line:** 776
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |

#### 26. `ezpushback.get_emitter_for_bot(bot_id)`

- **Line:** 783
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |

#### 27. `ezpushback.set_collision_enabled(area_id, object_id, enabled)`

- **Line:** 793
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |
| 3 | `enabled` | Declared in this function; type not inferred. |

#### 28. `ezpushback.handle_player_move(player_id, x, y, z)`

- **Line:** 801
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |
| 3 | `y` | Declared in this function; type not inferred. |
| 4 | `z` | Declared in this function; type not inferred. |

#### 29. `ezpushback.on_tick(delta_time)`

- **Line:** 806
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `delta_time` | Declared in this function; type not inferred. |

#### 30. `ezpushback.handle_player_join(player_id)`

- **Line:** 828
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 31. `ezpushback.handle_player_transfer(player_id)`

- **Line:** 835
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 32. `ezpushback.handle_player_disconnect(player_id)`

- **Line:** 842
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 38 | `ezpushback` |
| 39 | `entries` |
| 40 | `active_by_player` |
| 41 | `cooldowns` |
| 53 | `SCALE_STATES` |
| 95 | `event` |
| 165 | `properties` |
| 308 | `CANONICAL_DIRECTIONS` |
| 319 | `OPPOSITE_DIRECTION` |
| 453 | `state` |
| 458 | `start_position` |
| 516 | `properties` |
| 544 | `final_pos` |
| 610 | `trigger_object` |
| 621 | `entry` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_bot_position` | 1 | 436 |
| `Net.get_player_area` | 2 | 426 |
| `Net.get_player_direction` | 1 | 450 |
| `Net.get_player_position` | 2 | 435 |
| `Net.is_player` | 4 | 399 |
| `Net.is_player_input_locked` | 1 | 461 |
| `Net.list_areas` | 1 | 815 |
