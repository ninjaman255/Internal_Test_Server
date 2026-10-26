# `indy-trains/main.lua`

> **Source reference**
>
> Refreshed from the current `indy-trains/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

VERSION v1.10

## Module location

- **Source:** `indy-trains/main.lua`
- **Reference:** `script-reference/indy-trains/main.lua.md`
- **Source SHA-256 prefix:** `d9aadefd7e00`

## `Net:on` subscriptions

| Event |
|---|
| `actor_interaction` |
| `player_disconnect` |
| `post_selection` |
| `player_area_transfer` |
| `player_join` |
| `player_request` |
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `splitter` | `inputstr, sep` |
| `async` | `p` |
| `await` | `v` |
| `summon_arriving_passenger_train` | `player_id` |
| `summon_departing_passenger_train` | `player_id,post_id` |
| `validate_passenger_train` | `area_id,train_name` |
| `greet_conductor` | `bot_id,player_id` |
| `populate_server_list` | `` |
| `check_servers` | `` |
| `spawn_conductor` | `area_id, object_data` |
| `validate_cargo_train` | `area_id,train_name` |
| `run_cargo_train` | `area_id,train_name` |
| `find_trains` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`fade_player_camera`, `play_sound_for_player`, `get_player_area`, `lock_player_input`, `unlock_player_camera`, `create_bot`, `animate_player`, `animate_player_properties`, `animate_bot_properties`, `unlock_player_input`, `remove_bot`, `message_player`, `close_bbs`, `get_player_position`, `slide_player_camera`, `move_bot`, `transfer_player`, `transfer_server`, `open_board`, `on`, `list_areas`, `list_objects`, `get_object_by_id`, `remove_object`

## Engine `Async` calls

`promisify`, `await`, `sleep`, `poll_server`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/indy-trains/conductor-prog.png` |
| `/server/assets/indy-trains/conductor-prog.animation` |
| `/server/assets/indy-trains/conductor-prog-mug.png` |
| `/server/assets/indy-trains/conductor-prog-mug.animation` |
| `/server/assets/indy-trains/train_arrive_short.ogg` |
| `/server/assets/indy-trains/` |
| `/server/assets/indy-trains/pedestal.png` |
| `/server/assets/indy-trains/pedestal_` |
| `/server/assets/indy-trains/lightpath.png` |
| `/server/assets/indy-trains/lightpath_` |
| `/server/assets/indy-trains/train_jingle.ogg` |
| `/server/assets/indy-trains/train_away.ogg` |
| `/server/assets/indy-trains/train_arrive.ogg` |
| `/server/assets/indy-trains/train_depart.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
