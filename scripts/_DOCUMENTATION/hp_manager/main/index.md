# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/hp_manager/main.lua`](../../../hp_manager/main.lua)  
> **Source lines:** 662  
> **SHA-256 (UTF-8):** `e3f72147974d800a143a5c8d92aff5ae9b556824889b71fe72da316b424f7f15`  
> **Named/assigned functions detected:** 11

> **Static reference:** Function and parameter names below come from the modified Lua. Private local functions are not public APIs.

## Contents
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Dependencies

| Line | Module |
|---:|---|
| 18 | `scripts/net-games/main` |
| 19 | `scripts/player-control/main` |
| 20 | `scripts/logger/logger` |
| 21 | `scripts/displayer/text-layout` |
| 23 | `scripts/hp_manager/warp_manage` |
| 24 | `scripts/hp_manager/background_manage` |
| 25 | `scripts/hp_manager/realtime_manage` |
| 27 | `scripts/hp_manager/constants/constants` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 578 | `Net` | `tick` |
| 598 | `Net` | `object_interaction` |
| 616 | `Net` | `player_disconnect` |
| 621 | `Net` | `player_area_transfer` |
| 633 | `Net` | `tick` |

## Functions

| Line | Function | Parameters | Scope |
|---:|---|---|---|
| 78 | `add_desktop_icons` | `(none)` | local |
| 123 | `draw_option_name` | `player_id, option` | local |
| 150 | `get_server_os` | `(none)` | local |
| 191 | `close_hp_manage` | `player_id` | local |
| 200 | `open_hp_manager` | `player_id, selected_id` | local |
| 291 | `safe_open_hp_manager` | `player_id, selected_id` | local |
| 306 | `resume_desktop` | `player_id, option_id, expected_control, after_resume` | local |
| 307 | `resume` | `(none)` | local |
| 332 | `guarded_resume` | `(none)` | local |
| 354 | `launch_child` | `player_id, option_id, callback, abort_child` | local |
| 379 | `handle_manager_input` | `event` | local |

## Tables

| Line | Table |
|---:|---|
| 29 | `hp_sessions` |
| 30 | `desktop_control` |
| 32 | `desktop_options` |
| 54 | `optional_icons` |
| 75 | `extensions` |
| 110 | `desktop_options_by_id` |
| 111 | `desktop_option_indexes` |
| 132 | `desktop_elements` |
| 180 | `system_wallpaper` |
| 572 | `desktop_actions` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.fade_player_camera` | 2 | 472 |
| `Net.get_object_by_id` | 1 | 603 |
| `Net.get_player_area` | 4 | 230 |
| `Net.on` | 5 | 578 |
