# 📄 `ezpushback.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezpushback.lua`](../../../ezlibs-scripts/ezpushback.lua)  
> **Source lines:** 573  
> **SHA-256 (UTF-8):** `b1a24795cdfda2ce5224db8204b257aff863d758ce296e7e46f4c12d4d2ac6d3`  
> **Named/assigned functions detected:** 27  
> **Table initializers detected:** 13

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezpushback.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/player-control/legacy-capture` |
| 7 | `scripts/logger/logger` |
| 8 | `scripts/ezlibs-scripts/eztriggers` |
| 9 | `scripts/ezlibs-scripts/ezbus` |
| 10 | `scripts/ezlibs-scripts/ezemitter` |
| 11 | `scripts/ezlibs-scripts/object_registry` |
| 12 | `scripts/ezlibs-scripts/eznpcs/eznpcs` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 486 | `trigger_emitter` | `entered` |
| 492 | `trigger_emitter` | `departed` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 27 | `truthy` | `value, default` | local |
| 37 | `number_property` | `props, name, default, min_value` | local |
| 44 | `safe_call` | `fn, ...` | local |
| 49 | `get_area_players` | `area_id` | local |
| 55 | `provide_avatar_to_area` | `area_id, avatar` | local |
| 63 | `set_player_actor_hidden` | `player_id, area_id, hidden` | local |
| 73 | `remove_bot` | `bot_id` | local |
| 77 | `event_for` | `entry, player_id, extra` | local |
| 91 | `emit_entry` | `entry, name, event` | local |
| 126 | `map_vector_to_screen` | `dx, dy` | local |
| 131 | `screen_vector_to_map` | `sx, sy` | local |
| 136 | `atan2` | `y, x` | local |
| 160 | `snap_to_canonical_map` | `dx, dy` | local |
| 171 | `direction_vector` | `direction` | local |
| 193 | `get_push_vector` | `entry, player_pos, npc_pos, player_direction` | local |
| 220 | `calculate_target` | `entry, player_pos, npc_pos, player_direction` | local |
| 247 | `cleanup_push` | `player_id, state, reason, restore_player` | local |
| 268 | `perform_pushback` | `entry, player_id` | local |
| 419 | `update_entry_geometry` | `entry` | local |
| 439 | `register_pushback_npc` | `area_id, object` | local |
| 503 | `ezpushback.get_emitter` | `area_id, object_id` | assigned/declared |
| 508 | `ezpushback.set_collision_enabled` | `area_id, object_id, enabled` | assigned/declared |
| 516 | `ezpushback.handle_player_move` | `player_id, x, y, z` | assigned/declared |
| 521 | `ezpushback.on_tick` | `delta_time` | assigned/declared |
| 543 | `ezpushback.handle_player_join` | `player_id` | assigned/declared |
| 555 | `ezpushback.handle_player_transfer` | `player_id` | assigned/declared |
| 562 | `ezpushback.handle_player_disconnect` | `player_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `truthy(value, default)`

- **Line:** 27
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |
| 2 | `default` | Declared in this function; type not inferred. |

#### 2. `number_property(props, name, default, min_value)`

- **Line:** 37
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `props` | Declared in this function; type not inferred. |
| 2 | `name` | Declared in this function; type not inferred. |
| 3 | `default` | Declared in this function; type not inferred. |
| 4 | `min_value` | Declared in this function; type not inferred. |

#### 3. `safe_call(fn, ...)`

- **Line:** 44
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `fn` | Declared in this function; type not inferred. |
| 2 | `...` | Declared in this function; type not inferred. |

#### 4. `get_area_players(area_id)`

- **Line:** 49
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 5. `provide_avatar_to_area(area_id, avatar)`

- **Line:** 55
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `avatar` | Declared in this function; type not inferred. |

#### 6. `set_player_actor_hidden(player_id, area_id, hidden)`

- **Line:** 63
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `hidden` | Declared in this function; type not inferred. |

#### 7. `remove_bot(bot_id)`

- **Line:** 73
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |

#### 8. `event_for(entry, player_id, extra)`

- **Line:** 77
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `extra` | Declared in this function; type not inferred. |

#### 9. `emit_entry(entry, name, event)`

- **Line:** 91
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `name` | Declared in this function; type not inferred. |
| 3 | `event` | Declared in this function; type not inferred. |

#### 10. `map_vector_to_screen(dx, dy)`

- **Line:** 126
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dx` | Declared in this function; type not inferred. |
| 2 | `dy` | Declared in this function; type not inferred. |

#### 11. `screen_vector_to_map(sx, sy)`

- **Line:** 131
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sx` | Declared in this function; type not inferred. |
| 2 | `sy` | Declared in this function; type not inferred. |

#### 12. `atan2(y, x)`

- **Line:** 136
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `y` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |

#### 13. `snap_to_canonical_map(dx, dy)`

- **Line:** 160
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dx` | Declared in this function; type not inferred. |
| 2 | `dy` | Declared in this function; type not inferred. |

#### 14. `direction_vector(direction)`

- **Line:** 171
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `direction` | Declared in this function; type not inferred. |

#### 15. `get_push_vector(entry, player_pos, npc_pos, player_direction)`

- **Line:** 193
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `player_pos` | Declared in this function; type not inferred. |
| 3 | `npc_pos` | Declared in this function; type not inferred. |
| 4 | `player_direction` | Declared in this function; type not inferred. |

#### 16. `calculate_target(entry, player_pos, npc_pos, player_direction)`

- **Line:** 220
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `player_pos` | Declared in this function; type not inferred. |
| 3 | `npc_pos` | Declared in this function; type not inferred. |
| 4 | `player_direction` | Declared in this function; type not inferred. |

#### 17. `cleanup_push(player_id, state, reason, restore_player)`

- **Line:** 247
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `state` | Declared in this function; type not inferred. |
| 3 | `reason` | Declared in this function; type not inferred. |
| 4 | `restore_player` | Declared in this function; type not inferred. |

#### 18. `perform_pushback(entry, player_id)`

- **Line:** 268
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |

#### 19. `update_entry_geometry(entry)`

- **Line:** 419
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `entry` | Declared in this function; type not inferred. |

#### 20. `register_pushback_npc(area_id, object)`

- **Line:** 439
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object` | Declared in this function; type not inferred. |

#### 21. `ezpushback.get_emitter(area_id, object_id)`

- **Line:** 503
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |

#### 22. `ezpushback.set_collision_enabled(area_id, object_id, enabled)`

- **Line:** 508
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |
| 3 | `enabled` | Declared in this function; type not inferred. |

#### 23. `ezpushback.handle_player_move(player_id, x, y, z)`

- **Line:** 516
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |
| 3 | `y` | Declared in this function; type not inferred. |
| 4 | `z` | Declared in this function; type not inferred. |

#### 24. `ezpushback.on_tick(delta_time)`

- **Line:** 521
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `delta_time` | Declared in this function; type not inferred. |

#### 25. `ezpushback.handle_player_join(player_id)`

- **Line:** 543
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 26. `ezpushback.handle_player_transfer(player_id)`

- **Line:** 555
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 27. `ezpushback.handle_player_disconnect(player_id)`

- **Line:** 562
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 14 | `ezpushback` |
| 15 | `entries` |
| 16 | `active_by_player` |
| 17 | `cooldowns` |
| 78 | `event` |
| 142 | `CANONICAL_DIRECTIONS` |
| 153 | `OPPOSITE_DIRECTION` |
| 299 | `state` |
| 304 | `start_position` |
| 351 | `properties` |
| 382 | `final_pos` |
| 450 | `trigger_object` |
| 461 | `entry` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_bot_position` | 1 | 282 |
| `Net.get_player_area` | 3 | 272 |
| `Net.get_player_direction` | 1 | 296 |
| `Net.get_player_position` | 2 | 281 |
| `Net.is_player` | 4 | 254 |
| `Net.is_player_input_locked` | 1 | 307 |
| `Net.list_areas` | 1 | 530 |
