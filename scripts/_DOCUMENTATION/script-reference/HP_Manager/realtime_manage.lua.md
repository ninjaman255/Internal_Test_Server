# `HP_Manager/realtime_manage.lua`

> **Source reference**
>
> Refreshed from the current `HP_Manager/realtime_manage.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `HP_Manager/realtime_manage.lua`
- **Reference:** `script-reference/HP_Manager/realtime_manage.lua.md`
- **Source SHA-256 prefix:** `5a944e426eef`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/main` |
| `scripts/input-controller/main` |
| `scripts/displayer/text-layout` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `load_realtime_data` | `` |
| `save_realtime_data` | `` |
| `apply_realtime_data` | `` |
| `draw_current_time` | `player_id, session` |
| `draw_setting` | `player_id, area_id, index` |
| `hide_settings_ui` | `player_id` |
| `RealtimeManage.open` | `player_id, return_to_hp, real_day_time` |
| `restore_original_settings` | `session` |
| `handle_manager_input` | `event` |
| `input_owner` | `player_id` |
| `poll_manager_input` | `player_id, owner` |
| `take` | `action, raw_name, allow_repeat` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`list_areas`, `set_area_custom_property`, `get_area_custom_property`, `get_player_area`, `lock_player_input`, `unlock_player_input`, `on`

## Engine `Async` calls

`sleep`, `question_player`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/HP_Manager/board.png` |
| `/server/assets/net-games/cursors/text_cursor.png` |
| `/server/assets/net-games/cursors/text_cursor.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
