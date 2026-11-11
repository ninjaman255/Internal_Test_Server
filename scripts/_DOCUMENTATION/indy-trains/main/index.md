# 📄 `main.lua` — Refreshed Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/indy-trains/main.lua`](../../../indy-trains/main.lua)  
> **Source lines:** 1255  
> **SHA-256 (UTF-8):** `129c4acc1825ca32a6c3c031ffe18802ee530d0b13425b0d690033969fda5d99`  
> **Named/assigned functions detected:** 13  
> **Table initializers detected (simple pattern):** 56

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/indy-trains/main.lua` from the latest overlaid server archive.

## Dependencies

No statically identified literal `require` module strings.

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 1155 | `Net` | `actor_interaction` |
| 1163 | `Net` | `player_disconnect` |
| 1174 | `Net` | `post_selection` |
| 1182 | `Net` | `player_area_transfer` |
| 1194 | `Net` | `player_join` |
| 1206 | `Net` | `player_request` |
| 1238 | `Net` | `tick` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 51 | `splitter` | `inputstr, sep` | local |
| 65 | `async` | `p` | assigned/declared |
| 71 | `await` | `v` | assigned/declared |
| 77 | `summon_arriving_passenger_train` | `player_id` | local |
| 294 | `summon_departing_passenger_train` | `player_id,post_id` | local |
| 602 | `validate_passenger_train` | `area_id,train_name` | local |
| 718 | `greet_conductor` | `bot_id,player_id` | local |
| 822 | `populate_server_list` | `(none)` | local |
| 878 | `check_servers` | `(none)` | local |
| 893 | `spawn_conductor` | `area_id, object_data` | local |
| 943 | `validate_cargo_train` | `area_id,train_name` | local |
| 1048 | `run_cargo_train` | `area_id,train_name` | local |
| 1110 | `find_trains` | `(none)` | local |

### Detailed parameter inventory

#### 1. `splitter(inputstr, sep)`

- **Line:** 51
- **Declaration:** local
- **Nearby code comment:** purpose: splits a string based on a delimiter usaged: used at various points to seperate values

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `inputstr` | Declared by this function; type not inferred. |
| 2 | `sep` | Declared by this function; type not inferred. |

#### 2. `async(p)`

- **Line:** 65
- **Declaration:** table/global or assignment
- **Nearby code comment:** Shorthand for async

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `p` | Declared by this function; type not inferred. |

#### 3. `await(v)`

- **Line:** 71
- **Declaration:** table/global or assignment
- **Nearby code comment:** Shorthand for await

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `v` | Declared by this function; type not inferred. |

#### 4. `summon_arriving_passenger_train(player_id)`

- **Line:** 77
- **Declaration:** local
- **Nearby code comment:** usage: called when a player selects an option from a train menu purpose: to spawn a train, pickup player, and depart (if track is not already occupied)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |

#### 5. `summon_departing_passenger_train(player_id,post_id)`

- **Line:** 294
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared by this function; type not inferred. |
| 2 | `post_id` | Declared by this function; type not inferred. |

#### 6. `validate_passenger_train(area_id,train_name)`

- **Line:** 602
- **Declaration:** local
- **Nearby code comment:** purpose: validates passenger train configuration, checks provided properties, and assigns necessary properties. usage: called on server boot for each passenger train object

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `train_name` | Declared by this function; type not inferred. |

#### 7. `greet_conductor(bot_id,player_id)`

- **Line:** 718
- **Declaration:** local
- **Nearby code comment:** purpose: populates and opens train route selection menu usage: called when player interacts with conductor

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared by this function; type not inferred. |
| 2 | `player_id` | Declared by this function; type not inferred. |

#### 8. `populate_server_list()`

- **Line:** 822
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 9. `check_servers()`

- **Line:** 878
- **Declaration:** local
- **Nearby code comment:** purpose: polls servers to check if they are online and returns a status to the list usage: automatically runs on a loop
- **Parameters:** none explicitly declared.

#### 10. `spawn_conductor(area_id, object_data)`

- **Line:** 893
- **Declaration:** local
- **Nearby code comment:** purpose: validates conductor configuration, checks provided properties, assigns necessary properties, and spawns bot. usage: called on server boot for each conductor object

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `object_data` | Declared by this function; type not inferred. |

#### 11. `validate_cargo_train(area_id,train_name)`

- **Line:** 943
- **Declaration:** local
- **Nearby code comment:** purpose: validates cargo train configuraton, checks properties, assigns necessary properties, and spawns bots. usage: called on server boot for each cargo train object

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `train_name` | Declared by this function; type not inferred. |

#### 12. `run_cargo_train(area_id,train_name)`

- **Line:** 1048
- **Declaration:** local
- **Nearby code comment:** animate a given cargo train for one loop usage: called within the Net.on("tick") function whenever a given cargo train's animation ends

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared by this function; type not inferred. |
| 2 | `train_name` | Declared by this function; type not inferred. |

#### 13. `find_trains()`

- **Line:** 1110
- **Declaration:** local
- **Nearby code comment:** Find all trains in all areas, removes placeholders, and triggers them to start usage: runs on server boot to find all train and conductor objects and handle setup
- **Parameters:** none explicitly declared.


## Tables

| Source line | Assignment |
|---:|---|
| 22 | `passenger_train_required_properties` |
| 23 | `passenger_train_optional_properties` |
| 25 | `cargo_train_required_properties` |
| 26 | `cargo_train_optional_properties` |
| 28 | `conductor_required_properties` |
| 29 | `conductor_optional_properties` |
| 39 | `servers` |
| 41 | `train_cache` |
| 42 | `conductor_cache` |
| 43 | `cargo_schedule` |
| 44 | `passenger_cache` |
| 45 | `track_cache` |
| 46 | `player_using_train_menu` |
| 58 | `t` |
| 176 | `keyframes` |
| 181 | `keyframes` |
| 185 | `keyframes` |
| 190 | `keyframes` |
| 197 | `keyframes` |
| 200 | `keyframes` |
| 203 | `keyframes` |
| 208 | `keyframes` |
| 219 | `keyframes` |
| 228 | `keyframes` |
| 233 | `keyframes` |
| 238 | `keyframes` |
| 243 | `keyframes` |
| 257 | `keyframes` |
| 262 | `keyframes` |
| 267 | `keyframes` |
| 274 | `keyframes` |
| 429 | `keyframes` |
| 432 | `keyframes` |
| 435 | `keyframes` |
| 441 | `keyframes` |
| 452 | `keyframes` |
| 465 | `keyframes` |
| 474 | `keyframes` |
| 480 | `keyframes` |
| 488 | `keyframes` |
| 494 | `keyframes` |
| 502 | `keyframes` |
| 507 | `keyframes` |
| 515 | `keyframes` |
| 521 | `keyframes` |
| 524 | `keyframes` |
| 527 | `keyframes` |
| 531 | `keyframes` |
| 739 | `board_color` |
| 740 | `posts` |
| 855 | `servers2` |
| 856 | `hash` |
| 863 | `servers` |
| 1090 | `keyframes` |
| 1094 | `keyframes` |
| 1098 | `keyframes` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.animate_bot_properties` | 21 | 199 |
| `Net.animate_player` | 8 | 115 |
| `Net.animate_player_properties` | 16 | 178 |
| `Net.close_bbs` | 1 | 327 |
| `Net.create_bot` | 14 | 97 |
| `Net.fade_player_camera` | 6 | 81 |
| `Net.get_object_by_id` | 2 | 1120 |
| `Net.get_player_area` | 3 | 87 |
| `Net.get_player_position` | 2 | 461 |
| `Net.list_areas` | 1 | 1111 |
| `Net.list_objects` | 2 | 1118 |
| `Net.lock_player_input` | 3 | 92 |
| `Net.message_player` | 3 | 319 |
| `Net.move_bot` | 4 | 541 |
| `Net.on` | 7 | 1155 |
| `Net.open_board` | 1 | 817 |
| `Net.play_sound_for_player` | 6 | 82 |
| `Net.remove_bot` | 13 | 254 |
| `Net.remove_object` | 3 | 1125 |
| `Net.slide_player_camera` | 1 | 539 |
| `Net.transfer_player` | 5 | 571 |
| `Net.transfer_server` | 1 | 590 |
| `Net.unlock_player_camera` | 1 | 93 |
| `Net.unlock_player_input` | 2 | 253 |
