# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/real_daytime/main.lua`](../../../real_daytime/main.lua)  
> **Source lines:** 310  
> **SHA-256 (UTF-8):** `e51f446bc655c19de952cdba77ea53026a8c4e5e43d870bb119d9f31afc707d6`  
> **Named/assigned functions detected:** 14

> **Static reference:** Declarations, parameters, event hooks, and Net calls are extracted from this complete Lua file. Locals are not public APIs.

## Dependencies

| Line | Module |
|---:|---|
| 8 | `scripts/logger/logger` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 298 | `Net` | `tick` |

## Functions

| Line | Function | Arguments |
|---:|---|---|
| 12 | `foreground_description` | `area_id` |
| 26 | `log_foreground` | `area_id, reason, mode, offset, phase` |
| 54 | `get_area_settings` | `area_id` |
| 110 | `get_current_time` | `settings` |
| 124 | `get_day_phase` | `time` |
| 143 | `get_day_date` | `time` |
| 158 | `get_day_type` | `time` |
| 163 | `restore_foreground` | `area_id, settings` |
| 173 | `apply_day_phase` | `area_id, settings, phase` |
| 197 | `clear_day_properties` | `area_id` |
| 209 | `update_area` | `area_id` |
| 242 | `AmbientManage.refresh_area` | `area_id` |
| 272 | `AmbientManage.get_day_night_mode` | `area_id` |
| 281 | `AmbientManage.get_timezone` | `area_id` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.get_area_custom_property` | 5 | 61 |
| `Net.get_foreground` | 2 | 14 |
| `Net.get_foreground_parallax` | 2 | 15 |
| `Net.get_foreground_velocity` | 2 | 14 |
| `Net.list_areas` | 1 | 293 |
| `Net.on` | 1 | 298 |
| `Net.set_area_custom_property` | 4 | 202 |
| `Net.set_foreground` | 4 | 166 |
