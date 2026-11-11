# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezencounters/main.lua`](../../../../ezlibs-scripts/ezencounters/main.lua)  
> **Source lines:** 459  
> **SHA-256 (UTF-8):** `0ce3896bd6b77d3ef39faff9d2cb666801abe34a37e8501044b80aef62ede5fb`  
> **Named/assigned functions detected:** 17  
> **Table initializers detected:** 19

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezencounters/main.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 2 | `scripts/ezlibs-scripts/ezwarps/main` |
| 3 | `scripts/ezlibs-scripts/ezmemory` |
| 4 | `scripts/ezlibs-scripts/helpers` |
| 5 | `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| 6 | `scripts/ezlibs-scripts/object_registry` |
| 7 | `scripts/ezlibs-scripts/ezbus` |
| 8 | `scripts/ezlibs-scripts/ezconfig` |
| 9 | `scripts/ezlibs-scripts/ezencounters/rewards` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 328 | `Net` | `battle_results` |
| 454 | `emitter` | `entered` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 28 | `load_encounters_for_areas` | `(none)` | local |
| 89 | `ezencounters.get_encounter_by_name` | `encounter_name, area_id` | assigned/declared |
| 109 | `ezencounters.register_external_battle` | `player_id, encounter_data, options` | assigned/declared |
| 124 | `ezencounters.clear_external_battle` | `player_id, token` | assigned/declared |
| 135 | `ezencounters.resolve_encounter` | `encounter_reference, area_id` | assigned/declared |
| 148 | `should_record_step` | `player_id` | local |
| 171 | `ezencounters.increment_steps_since_encounter` | `player_id` | assigned/declared |
| 190 | `ezencounters.handle_player_move` | `player_id, x, y, z` | assigned/declared |
| 212 | `ezencounters.pick_encounter_from_table` | `encounter_table` | assigned/declared |
| 236 | `ezencounters.try_random_encounter` | `player_id,encounter_table` | assigned/declared |
| 252 | `ezencounters.begin_encounter_by_name` | `player_id,encounter_name,trigger_object,runtime_data` | assigned/declared |
| 271 | `ezencounters.begin_encounter` | `player_id,encounter_info,trigger_object,runtime_data` | assigned/declared |
| 317 | `ezencounters.clear_tiles_since_encounter` | `player_id` | assigned/declared |
| 321 | `ezencounters.clear_last_position` | `player_id` | assigned/declared |
| 369 | `append_callback` | `callback, info` | local |
| 415 | `ezencounters.handle_player_disconnect` | `player_id` | assigned/declared |
| 421 | `on_radius_encounter_triggered` | `event` | local |

### Detailed parameter inventory

#### 1. `load_encounters_for_areas()`

- **Line:** 28
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 2. `ezencounters.get_encounter_by_name(encounter_name, area_id)`

- **Line:** 89
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `encounter_name` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |

#### 3. `ezencounters.register_external_battle(player_id, encounter_data, options)`

- **Line:** 109
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `encounter_data` | Declared in this function; type not inferred. |
| 3 | `options` | Declared in this function; type not inferred. |

#### 4. `ezencounters.clear_external_battle(player_id, token)`

- **Line:** 124
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `token` | Declared in this function; type not inferred. |

#### 5. `ezencounters.resolve_encounter(encounter_reference, area_id)`

- **Line:** 135
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `encounter_reference` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |

#### 6. `should_record_step(player_id)`

- **Line:** 148
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 7. `ezencounters.increment_steps_since_encounter(player_id)`

- **Line:** 171
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 8. `ezencounters.handle_player_move(player_id, x, y, z)`

- **Line:** 190
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |
| 3 | `y` | Declared in this function; type not inferred. |
| 4 | `z` | Declared in this function; type not inferred. |

#### 9. `ezencounters.pick_encounter_from_table(encounter_table)`

- **Line:** 212
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `encounter_table` | Declared in this function; type not inferred. |

#### 10. `ezencounters.try_random_encounter(player_id,encounter_table)`

- **Line:** 236
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `encounter_table` | Declared in this function; type not inferred. |

#### 11. `ezencounters.begin_encounter_by_name(player_id,encounter_name,trigger_object,runtime_data)`

- **Line:** 252
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `encounter_name` | Declared in this function; type not inferred. |
| 3 | `trigger_object` | Declared in this function; type not inferred. |
| 4 | `runtime_data` | Declared in this function; type not inferred. |

#### 12. `ezencounters.begin_encounter(player_id,encounter_info,trigger_object,runtime_data)`

- **Line:** 271
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `encounter_info` | Declared in this function; type not inferred. |
| 3 | `trigger_object` | Declared in this function; type not inferred. |
| 4 | `runtime_data` | Declared in this function; type not inferred. |

#### 13. `ezencounters.clear_tiles_since_encounter(player_id)`

- **Line:** 317
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 14. `ezencounters.clear_last_position(player_id)`

- **Line:** 321
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 15. `append_callback(callback, info)`

- **Line:** 369
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `callback` | Declared in this function; type not inferred. |
| 2 | `info` | Declared in this function; type not inferred. |

#### 16. `ezencounters.handle_player_disconnect(player_id)`

- **Line:** 415
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 17. `on_radius_encounter_triggered(event)`

- **Line:** 421
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `event` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 11 | `ezencounters` |
| 12 | `players_in_encounters` |
| 13 | `player_last_position` |
| 14 | `player_steps_since_encounter` |
| 17 | `named_encounters` |
| 18 | `named_encounters_by_area` |
| 19 | `ambiguous_named_encounters` |
| 20 | `provided_encounter_assets` |
| 21 | `encounter_finished_callbacks` |
| 22 | `external_battles` |
| 30 | `area_encounter_tables` |
| 39 | `encounter_sections` |
| 45 | `area_named` |
| 46 | `area_ambiguous` |
| 283 | `encounter_data` |
| 298 | `battle_data` |
| 362 | `reward_options` |
| 400 | `stats` |
| 434 | `encounter_info` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_player_area` | 6 | 149 |
| `Net.get_tile` | 1 | 160 |
| `Net.get_tileset_for_tile` | 1 | 161 |
| `Net.is_player_battling` | 1 | 153 |
| `Net.list_areas` | 1 | 29 |
| `Net.on` | 1 | 328 |
| `Net.provide_asset` | 1 | 55 |
