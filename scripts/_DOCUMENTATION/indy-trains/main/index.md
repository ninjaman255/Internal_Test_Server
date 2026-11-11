# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/indy-trains/main.lua`](../../../indy-trains/main.lua)  
> **Source lines:** 1255  
> **SHA-256 (UTF-8):** `486503e4ae0d746b057b4561db38da5df57bd74768b71927fa3fc3d8039e4ac0`  
> **Named functions detected:** 13  
> **Table initializers detected:** 56

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

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 1156 | `Net` | `actor_interaction` |
| 1164 | `Net` | `player_disconnect` |
| 1175 | `Net` | `post_selection` |
| 1183 | `Net` | `player_area_transfer` |
| 1195 | `Net` | `player_join` |
| 1207 | `Net` | `player_request` |
| 1239 | `Net` | `tick` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 52 | `splitter` | `inputstr, sep` | local |
| 66 | `async` | `p` | assigned/declared |
| 72 | `await` | `v` | assigned/declared |
| 78 | `summon_arriving_passenger_train` | `player_id` | local |
| 295 | `summon_departing_passenger_train` | `player_id,post_id` | local |
| 603 | `validate_passenger_train` | `area_id,train_name` | local |
| 719 | `greet_conductor` | `bot_id,player_id` | local |
| 823 | `populate_server_list` | `(none)` | local |
| 879 | `check_servers` | `(none)` | local |
| 894 | `spawn_conductor` | `area_id, object_data` | local |
| 944 | `validate_cargo_train` | `area_id,train_name` | local |
| 1049 | `run_cargo_train` | `area_id,train_name` | local |
| 1111 | `find_trains` | `(none)` | local |

### Parameter inventory

#### 1. `splitter(inputstr, sep)`

- **Line:** 52
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `inputstr` | Declared directly in the current Lua. Type not inferred. |
| 2 | `sep` | Declared directly in the current Lua. Type not inferred. |

#### 2. `async(p)`

- **Line:** 66
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `p` | Declared directly in the current Lua. Type not inferred. |

#### 3. `await(v)`

- **Line:** 72
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `v` | Declared directly in the current Lua. Type not inferred. |

#### 4. `summon_arriving_passenger_train(player_id)`

- **Line:** 78
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 5. `summon_departing_passenger_train(player_id,post_id)`

- **Line:** 295
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `post_id` | Declared directly in the current Lua. Type not inferred. |

#### 6. `validate_passenger_train(area_id,train_name)`

- **Line:** 603
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `train_name` | Declared directly in the current Lua. Type not inferred. |

#### 7. `greet_conductor(bot_id,player_id)`

- **Line:** 719
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 8. `populate_server_list()`

- **Line:** 823
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 9. `check_servers()`

- **Line:** 879
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 10. `spawn_conductor(area_id, object_data)`

- **Line:** 894
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_data` | Declared directly in the current Lua. Type not inferred. |

#### 11. `validate_cargo_train(area_id,train_name)`

- **Line:** 944
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `train_name` | Declared directly in the current Lua. Type not inferred. |

#### 12. `run_cargo_train(area_id,train_name)`

- **Line:** 1049
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `train_name` | Declared directly in the current Lua. Type not inferred. |

#### 13. `find_trains()`

- **Line:** 1111
- **Declaration:** local
- **Parameters:** none explicitly declared.


## Tables

| Line | Identifier |
|---:|---|
| 23 | `passenger_train_required_properties` |
| 24 | `passenger_train_optional_properties` |
| 26 | `cargo_train_required_properties` |
| 27 | `cargo_train_optional_properties` |
| 29 | `conductor_required_properties` |
| 30 | `conductor_optional_properties` |
| 40 | `servers` |
| 42 | `train_cache` |
| 43 | `conductor_cache` |
| 44 | `cargo_schedule` |
| 45 | `passenger_cache` |
| 46 | `track_cache` |
| 47 | `player_using_train_menu` |
| 59 | `t` |
| 177 | `keyframes` |
| 182 | `keyframes` |
| 186 | `keyframes` |
| 191 | `keyframes` |
| 198 | `keyframes` |
| 201 | `keyframes` |
| 204 | `keyframes` |
| 209 | `keyframes` |
| 220 | `keyframes` |
| 229 | `keyframes` |
| 234 | `keyframes` |
| 239 | `keyframes` |
| 244 | `keyframes` |
| 258 | `keyframes` |
| 263 | `keyframes` |
| 268 | `keyframes` |
| 275 | `keyframes` |
| 430 | `keyframes` |
| 433 | `keyframes` |
| 436 | `keyframes` |
| 442 | `keyframes` |
| 453 | `keyframes` |
| 466 | `keyframes` |
| 475 | `keyframes` |
| 481 | `keyframes` |
| 489 | `keyframes` |
| 495 | `keyframes` |
| 503 | `keyframes` |
| 508 | `keyframes` |
| 516 | `keyframes` |
| 522 | `keyframes` |
| 525 | `keyframes` |
| 528 | `keyframes` |
| 532 | `keyframes` |
| 740 | `board_color` |
| 741 | `posts` |
| 856 | `servers2` |
| 857 | `hash` |
| 864 | `servers` |
| 1091 | `keyframes` |
| 1095 | `keyframes` |
| 1099 | `keyframes` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.animate_bot_properties` | 21 | 200 |
| `Net.animate_player` | 8 | 116 |
| `Net.animate_player_properties` | 16 | 179 |
| `Net.close_bbs` | 1 | 328 |
| `Net.create_bot` | 14 | 98 |
| `Net.fade_player_camera` | 6 | 82 |
| `Net.get_object_by_id` | 2 | 1121 |
| `Net.get_player_area` | 3 | 88 |
| `Net.get_player_position` | 2 | 462 |
| `Net.list_areas` | 1 | 1112 |
| `Net.list_objects` | 2 | 1119 |
| `Net.message_player` | 3 | 320 |
| `Net.move_bot` | 4 | 542 |
| `Net.on` | 7 | 1156 |
| `Net.open_board` | 1 | 818 |
| `Net.play_sound_for_player` | 6 | 83 |
| `Net.remove_bot` | 13 | 255 |
| `Net.remove_object` | 3 | 1126 |
| `Net.slide_player_camera` | 1 | 540 |
| `Net.transfer_player` | 5 | 572 |
| `Net.transfer_server` | 1 | 591 |
| `Net.unlock_player_camera` | 1 | 94 |
