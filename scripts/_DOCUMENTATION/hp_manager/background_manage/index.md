# 📄 `background_manage.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/hp_manager/background_manage.lua`](../../../hp_manager/background_manage.lua)  
> **Source lines:** 878  
> **SHA-256 (UTF-8):** `10f0b2fa48e5cd34c0644467d402b63ecd2a9c1287132d6470043f30653f62fe`  
> **Named/assigned functions detected:** 17

> **Static reference:** Declarations, parameters, event hooks, and Net calls are extracted from this complete Lua file. Locals are not public APIs.

## Dependencies

| Line | Module |
|---:|---|
| 7 | `scripts/net-games/main` |
| 8 | `scripts/player-control/main` |
| 9 | `scripts/logger/logger` |
| 10 | `scripts/displayer/text-layout` |
| 17 | `scripts/hp_manager/constants/constants` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 814 | `Net` | `tick` |
| 843 | `Net` | `player_disconnect` |
| 846 | `Net` | `player_area_transfer` |
| 851 | `Net` | `tick` |

## Functions

| Line | Function | Arguments |
|---:|---|---|
| 59 | `background_description` | `data` |
| 68 | `disk_background_record` | `area_id` |
| 89 | `live_background_description` | `area_id` |
| 103 | `load_background_data` | `(none)` |
| 141 | `save_background_data` | `(none)` |
| 219 | `background_asset_exists` | `asset_path` |
| 236 | `apply_background_data` | `(none)` |
| 284 | `hide_background_manage_ui` | `player_id, session` |
| 285 | `remove` | `kind, id` |
| 313 | `copy_background` | `bg` |
| 320 | `set_session_background` | `session, background` |
| 326 | `restore_original_background` | `session` |
| 336 | `finish_background_session` | `player_id, session, action` |
| 406 | `find_backgrounds` | `(none)` |
| 454 | `BackgroundManage.open` | `player_id, return_to_hp, options` |
| 578 | `handle_manager_input` | `event` |
| 830 | `abandon_background_editor` | `player_id` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.get_background` | 2 | 91 |
| `Net.get_background_parallax` | 2 | 92 |
| `Net.get_background_velocity` | 2 | 91 |
| `Net.get_player_area` | 1 | 456 |
| `Net.list_areas` | 1 | 240 |
| `Net.message_player` | 1 | 460 |
| `Net.on` | 4 | 814 |
| `Net.set_background` | 3 | 253 |
