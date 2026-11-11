# 📄 `option_menu.lua` — Current Lua reference

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/option_menu.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/option_menu.lua)  
> **Source lines:** 459  
> **SHA-256 (UTF-8):** `503c753e4becb24a6b8508f2f8baf42ab7683acfc07ada64d64ad00ad9e62d5c`  
> **Named functions detected:** 12  
> **Table initializers detected:** 11

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
| 8 | `scripts/displayer/displayer` |
| 9 | `scripts/player-control/main` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 285 | `Net` | `tick` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 62 | `is_menu_up_pressed` | `controller, owner` | local |
| 68 | `is_menu_down_pressed` | `controller, owner` | local |
| 74 | `make_header_children` | `title` | local |
| 85 | `make_body_children` | `options, selected` | local |
| 104 | `remove_panel` | `player_id, panel_id` | local |
| 110 | `position_panels` | `menu` | local |
| 142 | `find_cancel_option` | `options` | local |
| 152 | `refresh_body` | `menu` | local |
| 162 | `cleanup` | `player_id, menu, result` | local |
| 184 | `apply_shared_width` | `menu` | local |
| 211 | `create_panels` | `player_id, menu` | local |
| 350 | `OptionMenu.select` | `player_id, options, title` | assigned/declared |

### Parameter inventory

#### 1. `is_menu_up_pressed(controller, owner)`

- **Line:** 62
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `controller` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |

#### 2. `is_menu_down_pressed(controller, owner)`

- **Line:** 68
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `controller` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |

#### 3. `make_header_children(title)`

- **Line:** 74
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `title` | Declared directly in the current Lua. Type not inferred. |

#### 4. `make_body_children(options, selected)`

- **Line:** 85
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `options` | Declared directly in the current Lua. Type not inferred. |
| 2 | `selected` | Declared directly in the current Lua. Type not inferred. |

#### 5. `remove_panel(player_id, panel_id)`

- **Line:** 104
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `panel_id` | Declared directly in the current Lua. Type not inferred. |

#### 6. `position_panels(menu)`

- **Line:** 110
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `menu` | Declared directly in the current Lua. Type not inferred. |

#### 7. `find_cancel_option(options)`

- **Line:** 142
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 8. `refresh_body(menu)`

- **Line:** 152
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `menu` | Declared directly in the current Lua. Type not inferred. |

#### 9. `cleanup(player_id, menu, result)`

- **Line:** 162
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `menu` | Declared directly in the current Lua. Type not inferred. |
| 3 | `result` | Declared directly in the current Lua. Type not inferred. |

#### 10. `apply_shared_width(menu)`

- **Line:** 184
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `menu` | Declared directly in the current Lua. Type not inferred. |

#### 11. `create_panels(player_id, menu)`

- **Line:** 211
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `menu` | Declared directly in the current Lua. Type not inferred. |

#### 12. `OptionMenu.select(player_id, options, title)`

- **Line:** 350
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `options` | Declared directly in the current Lua. Type not inferred. |
| 3 | `title` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 11 | `OptionMenu` |
| 37 | `PANEL_PADDING` |
| 38 | `CHILD_PADDING` |
| 51 | `active_menus` |
| 55 | `MENU_ACTIONS` |
| 79 | `color` |
| 86 | `children` |
| 95 | `color` |
| 212 | `initial_options` |
| 359 | `menu_options` |
| 381 | `menu` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.is_player` | 2 | 288 |
| `Net.on` | 1 | 285 |
