# 📄 `eztriggers.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/eztriggers/eztriggers.lua`](../../../../ezlibs-scripts/eztriggers/eztriggers.lua)  
> **Source lines:** 436  
> **SHA-256 (UTF-8):** `384ed7cef6c58ddd9f2b2a209dc7af4a5c8b7e94ed8af85c24a86dec60751e4b`  
> **Named/assigned functions detected:** 14  
> **Table initializers detected:** 10

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/eztriggers/eztriggers.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 2 | `scripts/ezlibs-scripts/helpers` |
| 3 | `scripts/ezlibs-scripts/object_registry` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 56 | `emitter` | `entered` |
| 421 | `Net` | `tick` |
| 428 | `Net` | `player_disconnect` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 10 | `is_button_trigger` | `trigger_info` | local |
| 26 | `eztriggers.add_location_event_trigger` | `area_id,object` | assigned/declared |
| 74 | `eztriggers.add_interact_trigger` | `area_id,trigger_object` | assigned/declared |
| 90 | `eztriggers.add_radius_trigger` | `area_id, trigger_object, diameter_x, diameter_y, center_x, center_y, trigger_id` | assigned/declared |
| 149 | `eztriggers.add_rectangle_trigger` | `area_id, trigger_object, width, height, trigger_id` | assigned/declared |
| 200 | `eztriggers.handle_object_interaction` | `player_id,object_id,button` | assigned/declared |
| 217 | `set_player_overlap` | `trigger_info, player_id, is_inside, reason` | local |
| 246 | `eztriggers.handle_player_move` | `player_id, x, y, z` | assigned/declared |
| 326 | `eztriggers.add_event` | `event_object` | assigned/declared |
| 341 | `eztriggers.clear_radius_overlaps_for_player` | `player_id, reason` | assigned/declared |
| 349 | `eztriggers.clear_rectangle_overlaps_for_player` | `player_id, reason` | assigned/declared |
| 357 | `eztriggers.handle_player_transfer` | `player_id` | assigned/declared |
| 370 | `eztriggers.handle_player_disconnect` | `player_id` | assigned/declared |
| 395 | `tick_check_player_triggers` | `(none)` | local |

### Detailed parameter inventory

#### 1. `is_button_trigger(trigger_info)`

- **Line:** 10
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `trigger_info` | Declared in this function; type not inferred. |

#### 2. `eztriggers.add_location_event_trigger(area_id,object)`

- **Line:** 26
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object` | Declared in this function; type not inferred. |

#### 3. `eztriggers.add_interact_trigger(area_id,trigger_object)`

- **Line:** 74
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `trigger_object` | Declared in this function; type not inferred. |

#### 4. `eztriggers.add_radius_trigger(area_id, trigger_object, diameter_x, diameter_y, center_x, center_y, trigger_id)`

- **Line:** 90
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `trigger_object` | Declared in this function; type not inferred. |
| 3 | `diameter_x` | Declared in this function; type not inferred. |
| 4 | `diameter_y` | Declared in this function; type not inferred. |
| 5 | `center_x` | Declared in this function; type not inferred. |
| 6 | `center_y` | Declared in this function; type not inferred. |
| 7 | `trigger_id` | Declared in this function; type not inferred. |

#### 5. `eztriggers.add_rectangle_trigger(area_id, trigger_object, width, height, trigger_id)`

- **Line:** 149
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `trigger_object` | Declared in this function; type not inferred. |
| 3 | `width` | Declared in this function; type not inferred. |
| 4 | `height` | Declared in this function; type not inferred. |
| 5 | `trigger_id` | Declared in this function; type not inferred. |

#### 6. `eztriggers.handle_object_interaction(player_id,object_id,button)`

- **Line:** 200
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |
| 3 | `button` | Declared in this function; type not inferred. |

#### 7. `set_player_overlap(trigger_info, player_id, is_inside, reason)`

- **Line:** 217
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `trigger_info` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `is_inside` | Declared in this function; type not inferred. |
| 4 | `reason` | Declared in this function; type not inferred. |

#### 8. `eztriggers.handle_player_move(player_id, x, y, z)`

- **Line:** 246
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |
| 3 | `y` | Declared in this function; type not inferred. |
| 4 | `z` | Declared in this function; type not inferred. |

#### 9. `eztriggers.add_event(event_object)`

- **Line:** 326
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `event_object` | Declared in this function; type not inferred. |

#### 10. `eztriggers.clear_radius_overlaps_for_player(player_id, reason)`

- **Line:** 341
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `reason` | Declared in this function; type not inferred. |

#### 11. `eztriggers.clear_rectangle_overlaps_for_player(player_id, reason)`

- **Line:** 349
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `reason` | Declared in this function; type not inferred. |

#### 12. `eztriggers.handle_player_transfer(player_id)`

- **Line:** 357
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 13. `eztriggers.handle_player_disconnect(player_id)`

- **Line:** 370
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 14. `tick_check_player_triggers()`

- **Line:** 395
- **Declaration:** local
- **Parameters:** none explicitly declared.


## Tables

| Source line | Assignment |
|---:|---|
| 5 | `eztriggers` |
| 15 | `eztriggers.interact_triggers` |
| 16 | `eztriggers.radius_triggers` |
| 17 | `eztriggers.rectangle_triggers` |
| 18 | `eztriggers._event_table` |
| 24 | `last_player_positions` |
| 122 | `trigger_info` |
| 126 | `overlapping_players` |
| 178 | `trigger_info` |
| 182 | `overlapping_players` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_player_area` | 2 | 202 |
| `Net.list_areas` | 1 | 396 |
| `Net.list_players` | 1 | 397 |
| `Net.on` | 2 | 421 |
