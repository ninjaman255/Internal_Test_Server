# `HP_Manager/main.lua`

> **Source reference**
>
> Refreshed from the current `HP_Manager/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `HP_Manager/main.lua`
- **Reference:** `script-reference/HP_Manager/main.lua.md`
- **Source SHA-256 prefix:** `fc16e0680a74`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/main` |
| `scripts/input-controller/main` |
| `scripts/displayer/text-layout` |
| `scripts/HP_Manager/warp_manage` |
| `scripts/HP_Manager/background_manage` |
| `scripts/HP_Manager/realtime_manage` |
| `scripts/HP_Manager/constants/constants` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |
| `object_interaction` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `add_desktop_icons` | `` |
| `draw_option_name` | `player_id, option` |
| `get_server_os` | `` |
| `close_hp_manage` | `player_id` |
| `open_hp_manager` | `player_id, selected_id` |
| `handle_manager_input` | `event` |
| `input_owner` | `player_id` |
| `release_manager_input` | `player_id` |
| `poll_manager_input` | `player_id, owner` |
| `take` | `action, raw_name, allow_repeat` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`lock_player_input`, `unlock_player_input`, `fade_player_camera`, `on`, `get_player_area`, `get_object_by_id`

## Engine `Async` calls

`sleep`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/HP_Manager/realtime_icon.png` |
| `/server/assets/HP_Manager/music_icon.png` |
| `/server/assets/HP_Manager/Wallpapers/windows_wallpaper.png` |
| `/server/assets/HP_Manager/Wallpapers/linux_wallpaper.png` |
| `/server/assets/HP_Manager/Wallpapers/macos_wallpaper.png` |
| `/server/assets/HP_Manager/border.png` |
| `/server/assets/HP_Manager/emblem.png` |
| `/server/assets/HP_Manager/warp_icon.png` |
| `/server/assets/HP_Manager/background_icon.png` |
| `/server/assets/net-games/cursors/text_cursor.png` |
| `/server/assets/net-games/cursors/text_cursor.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
