# `simon-says.lua`

> **Source reference**
>
> Refreshed from the current `simon-says.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `simon-says.lua`
- **Reference:** `script-reference/simon-says.lua.md`
- **Source SHA-256 prefix:** `2bec9fee8aa3`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/persistence/logger` |
| `scripts/net-games/main` |

## `Net:on` subscriptions

| Event |
|---|
| `player_disconnect` |
| `actor_interaction` |
| `virtual_input` |
| `countdown_ended` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `async` | `p` |
| `await` | `v` |
| `removeValue` | `array, valueToRemove` |
| `is_simon_button` | `name` |
| `spawn_simon` | `` |
| `simon_says_press` | `player_id` |
| `end_game_cleanup` | `player_id, reason, simon` |
| `greet_simon` | `actor_id, player_id` |
| `jiggle` | `off_x, off_y` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`list_areas`, `list_objects`, `get_object_by_id`, `remove_object`, `create_bot`, `on`, `get_player_area`, `fade_player_camera`, `toggle_player_hud`, `unlock_player_input`, `message_player`, `lock_player_input`, `get_player_position`, `play_sound_for_player`

## Engine `Async` calls

`promisify`, `await`, `sleep`, `question_player`, `message_player`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `INPUT_CHOICES` | `{ "Interact", "Shoulder L","Shoulder R", "Move Down", "Move Left", "Move Right", "Move ...` |
| `OVERLAY_Z_LIFT` | `4` |
| `OVERLAY_XY_COMP` | `OVERLAY_Z_LIFT / 2   -- = 2` |
| `INDICATOR_ORIGINAL_Z_OFFSET` | `2` |
| `INDICATOR_STATE` | `{` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/simon-says/normal-navi-bn4_green` |
| `/server/assets/simon-says/normal-navi-bn4_green-mug` |
| `/server/assets/simon-says/indicators.png` |
| `/server/assets/simon-says/indicators.animation` |
| `/server/assets/simon-says/board.png` |
| `/server/assets/simon-says/board.animation` |
| `/server/assets/simon-says/count.ogg` |
| `/server/assets/simon-says/game_start.ogg` |
| `/server/assets/simon-says/chat.png` |
| `/server/assets/simon-says/chat.animation` |
| `/server/assets/simon-says/correct.ogg` |
| `/server/assets/simon-says/succeed.ogg` |
| `/server/assets/simon-says/wrong_answer.ogg` |
| `/server/assets/simon-says/time_up.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
