# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/hp_manager/main.lua`](../../../hp_manager/main.lua)  
> **Source lines:** 688  
> **SHA-256 (UTF-8):** `59c9bc11617edc3df41734e2351a233ceaf0d4c27faab51439a4533fdec10016`  
> **Named functions detected:** 11  
> **Table initializers detected:** 10

> **Static reference:** Function signatures, dependency paths, and event names are extracted from current Lua. The listing does not establish runtime reachability or public API exposure. See the authored guide for semantics.

## Contents
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Dependencies

| Line | `require` path |
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
| 604 | `Net` | `tick` |
| 624 | `Net` | `object_interaction` |
| 642 | `Net` | `player_disconnect` |
| 647 | `Net` | `player_area_transfer` |
| 659 | `Net` | `tick` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 84 | `add_desktop_icons` | `(none)` | local |
| 129 | `draw_option_name` | `player_id, option` | local |
| 156 | `get_server_os` | `(none)` | local |
| 197 | `close_hp_manage` | `player_id` | local |
| 206 | `open_hp_manager` | `player_id, selected_id` | local |
| 297 | `safe_open_hp_manager` | `player_id, selected_id` | local |
| 312 | `resume_desktop` | `player_id, option_id, expected_control, after_resume` | local |
| 313 | `resume` | `(none)` | local |
| 358 | `guarded_resume` | `(none)` | local |
| 380 | `launch_child` | `player_id, option_id, callback, abort_child` | local |
| 405 | `handle_manager_input` | `event` | local |

### Parameter inventory

#### 1. `add_desktop_icons()`

- **Line:** 84
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 2. `draw_option_name(player_id, option)`

- **Line:** 129
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `option` | Declared directly in the current Lua. Type not inferred. |

#### 3. `get_server_os()`

- **Line:** 156
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 4. `close_hp_manage(player_id)`

- **Line:** 197
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 5. `open_hp_manager(player_id, selected_id)`

- **Line:** 206
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `selected_id` | Declared directly in the current Lua. Type not inferred. |

#### 6. `safe_open_hp_manager(player_id, selected_id)`

- **Line:** 297
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `selected_id` | Declared directly in the current Lua. Type not inferred. |

#### 7. `resume_desktop(player_id, option_id, expected_control, after_resume)`

- **Line:** 312
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `option_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `expected_control` | Declared directly in the current Lua. Type not inferred. |
| 4 | `after_resume` | Declared directly in the current Lua. Type not inferred. |

#### 8. `resume()`

- **Line:** 313
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 9. `guarded_resume()`

- **Line:** 358
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 10. `launch_child(player_id, option_id, callback, abort_child)`

- **Line:** 380
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `option_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `callback` | Declared directly in the current Lua. Type not inferred. |
| 4 | `abort_child` | Declared directly in the current Lua. Type not inferred. |

#### 11. `handle_manager_input(event)`

- **Line:** 405
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `event` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 29 | `hp_sessions` |
| 30 | `desktop_control` |
| 38 | `desktop_options` |
| 60 | `optional_icons` |
| 81 | `extensions` |
| 116 | `desktop_options_by_id` |
| 117 | `desktop_option_indexes` |
| 138 | `desktop_elements` |
| 186 | `system_wallpaper` |
| 598 | `desktop_actions` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.fade_player_camera` | 2 | 498 |
| `Net.get_object_by_id` | 1 | 629 |
| `Net.get_player_area` | 4 | 236 |
| `Net.on` | 5 | 604 |
