# 📄 `simon-says.lua` — Current Lua reference

[🏠 Documentation home](../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/simon-says.lua`](../../simon-says.lua)  
> **Source lines:** 447  
> **SHA-256 (UTF-8):** `b29639c7bb7f60258c1407b94c93b17228f18fdee61fe02f9305c5d8b61e6451`  
> **Named/assigned functions detected:** 9  
> **Table initializers detected:** 7

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/simon-says.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/player-control/legacy-capture` |
| 9 | `scripts/logger/logger` |
| 19 | `scripts/net-games/main` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 158 | `Net` | `player_disconnect` |
| 348 | `Net` | `actor_interaction` |
| 354 | `Net` | `virtual_input` |
| 427 | `Net` | `countdown_ended` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 32 | `async` | `p` | local |
| 36 | `await` | `v` | local |
| 38 | `removeValue` | `array, valueToRemove` | local |
| 81 | `is_simon_button` | `name` | local |
| 89 | `spawn_simon` | `(none)` | local |
| 175 | `simon_says_press` | `player_id` | local |
| 211 | `end_game_cleanup` | `player_id, reason, simon` | local |
| 239 | `greet_simon` | `actor_id, player_id` | local |
| 406 | `jiggle` | `off_x, off_y` | local |

### Detailed parameter inventory

#### 1. `async(p)`

- **Line:** 32
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `p` | Declared in this function; type not inferred. |

#### 2. `await(v)`

- **Line:** 36
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `v` | Declared in this function; type not inferred. |

#### 3. `removeValue(array, valueToRemove)`

- **Line:** 38
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `array` | Declared in this function; type not inferred. |
| 2 | `valueToRemove` | Declared in this function; type not inferred. |

#### 4. `is_simon_button(name)`

- **Line:** 81
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared in this function; type not inferred. |

#### 5. `spawn_simon()`

- **Line:** 89
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 6. `simon_says_press(player_id)`

- **Line:** 175
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 7. `end_game_cleanup(player_id, reason, simon)`

- **Line:** 211
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `reason` | Declared in this function; type not inferred. |
| 3 | `simon` | Declared in this function; type not inferred. |

#### 8. `greet_simon(actor_id, player_id)`

- **Line:** 239
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `actor_id` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |

#### 9. `jiggle(off_x, off_y)`

- **Line:** 406
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `off_x` | Declared in this function; type not inferred. |
| 2 | `off_y` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 21 | `simon_cache` |
| 22 | `simon_players` |
| 23 | `simon_optional_properties` |
| 25 | `defaults` |
| 50 | `INPUT_CHOICES` |
| 70 | `INDICATOR_STATE` |
| 188 | `possibilities` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.create_bot` | 1 | 139 |
| `Net.fade_player_camera` | 4 | 218 |
| `Net.get_object_by_id` | 1 | 97 |
| `Net.get_player_area` | 2 | 163 |
| `Net.get_player_position` | 1 | 285 |
| `Net.list_areas` | 1 | 90 |
| `Net.list_objects` | 1 | 95 |
| `Net.message_player` | 6 | 246 |
| `Net.on` | 4 | 158 |
| `Net.play_sound_for_player` | 8 | 323 |
| `Net.remove_object` | 1 | 105 |
