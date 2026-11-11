# 📄 `realtime_manage.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/hp_manager/realtime_manage.lua`](../../../hp_manager/realtime_manage.lua)  
> **Source lines:** 632  
> **SHA-256 (UTF-8):** `b80bbb3a8f556e02195dccbb76567f45bb1bc8e9b2da19392521938b8ecc2fa8`  
> **Named/assigned functions detected:** 15

> **Static reference:** Declarations, parameters, event hooks, and Net calls are extracted from this complete Lua file. Locals are not public APIs.

## Dependencies

| Line | Module |
|---:|---|
| 7 | `scripts/net-games/main` |
| 8 | `scripts/player-control/main` |
| 9 | `scripts/logger/logger` |
| 10 | `scripts/displayer/text-layout` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 569 | `Net` | `tick` |
| 595 | `Net` | `player_disconnect` |
| 598 | `Net` | `player_area_transfer` |
| 603 | `Net` | `tick` |

## Functions

| Line | Function | Arguments |
|---:|---|---|
| 37 | `realtime_description` | `mode, timezone` |
| 43 | `disk_realtime_record` | `area_id` |
| 59 | `live_realtime_description` | `area_id` |
| 69 | `load_realtime_data` | `(none)` |
| 101 | `save_realtime_data` | `(none)` |
| 175 | `apply_realtime_data` | `(none)` |
| 198 | `draw_current_time` | `player_id, session` |
| 219 | `draw_setting` | `player_id, area_id, index, session` |
| 243 | `hide_settings_ui` | `player_id` |
| 257 | `RealtimeManage.open` | `player_id, return_to_hp, real_day_time, options` |
| 343 | `restore_original_settings` | `session` |
| 357 | `apply_preview` | `session` |
| 365 | `finish_realtime_session` | `player_id, session, action` |
| 434 | `handle_manager_input` | `event` |
| 585 | `abandon_realtime_editor` | `player_id` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.get_area_custom_property` | 6 | 61 |
| `Net.get_player_area` | 1 | 260 |
| `Net.list_areas` | 1 | 178 |
| `Net.on` | 4 | 569 |
| `Net.set_area_custom_property` | 6 | 184 |
