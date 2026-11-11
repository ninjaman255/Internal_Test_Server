# 📄 `warp_manage.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/hp_manager/warp_manage.lua`](../../../hp_manager/warp_manage.lua)  
> **Source lines:** 469  
> **SHA-256 (UTF-8):** `09a47e6e36be2010825c0b8d5ee36644de15a0768321c13e51bc5efb9589219f`  
> **Named/assigned functions detected:** 10

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
| 8 | `scripts/player-control/main` |
| 9 | `scripts/logger/logger` |
| 18 | `scripts/hp_manager/constants/constants` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 289 | `Net` | `post_selection` |
| 432 | `Net` | `board_close` |
| 455 | `Net` | `player_disconnect` |
| 458 | `Net` | `player_area_transfer` |

## Functions

| Line | Function | Parameters | Scope |
|---:|---|---|---|
| 21 | `load_warp_data` | `(none)` | local |
| 54 | `save_warp_data` | `(none)` | local |
| 127 | `async` | `func` | local |
| 132 | `await` | `promise` | local |
| 137 | `find_warp_controllers` | `area_id` | local |
| 205 | `apply_saved_warps` | `area_id` | local |
| 229 | `WarpManage.open` | `player_id, return_to_hp, options` | table/assigned |
| 323 | `still_current` | `(none)` | local |
| 326 | `reopen` | `(none)` | local |
| 448 | `abandon_warp_editor` | `pid` | local |

## Tables

| Line | Table |
|---:|---|
| 7 | `WarpManage` |
| 10 | `warp_contexts` |
| 12 | `board_color` |
| 13 | `warp_sessions` |
| 16 | `warp_data` |
| 65 | `areas` |
| 76 | `controllers` |
| 138 | `warp_groups` |
| 155 | `warp` |
| 156 | `object_ids` |
| 187 | `warps` |
| 253 | `posts` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.close_bbs` | 2 | 308 |
| `Net.get_object_by_id` | 2 | 144 |
| `Net.get_player_area` | 1 | 250 |
| `Net.list_areas` | 1 | 465 |
| `Net.list_objects` | 2 | 139 |
| `Net.on` | 4 | 289 |
| `Net.set_object_custom_property` | 6 | 220 |
