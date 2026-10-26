# `HP_Manager/background_manage.lua`

> **Source reference**
>
> Refreshed from the current `HP_Manager/background_manage.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `HP_Manager/background_manage.lua`
- **Reference:** `script-reference/HP_Manager/background_manage.lua.md`
- **Source SHA-256 prefix:** `db51a6af66f6`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/main` |
| `scripts/input-controller/main` |
| `scripts/displayer/text-layout` |
| `scripts/HP_Manager/constants/constants` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `load_background_data` | `` |
| `save_background_data` | `` |
| `background_asset_exists` | `asset_path` |
| `apply_background_data` | `` |
| `hide_background_manage_ui` | `player_id, session` |
| `find_backgrounds` | `` |
| `BackgroundManage.open` | `player_id, return_to_hp` |
| `handle_manager_input` | `event` |
| `input_owner` | `player_id` |
| `poll_manager_input` | `player_id, owner` |
| `take` | `action, raw_name, allow_repeat` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`list_areas`, `set_background`, `get_player_area`, `message_player`, `get_background`, `get_background_velocity`, `get_background_parallax`, `lock_player_input`, `unlock_player_input`, `on`

## Engine `Async` calls

`sleep`, `question_player`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/HP_Manager/background_manage_bar.png` |
| `/server/assets/HP_Manager/lb_button.png` |
| `/server/assets/HP_Manager/rb_button.png` |
| `/server/assets/net-games/cursors/text_cursor.png` |
| `/server/assets/net-games/cursors/text_cursor.animation` |
| `/server/assets/HP_Manager/board.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
