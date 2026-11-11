# 📄 `player.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/player.lua`](../../../../ezlibs-custom/nebulous-liberations/player.lua)  
> **Source lines:** 328  
> **SHA-256 (UTF-8):** `1ced1a4fb9855bc22bb66fe65519037c462d95bdcaafa7276501f1183c81aa12`  
> **Named/assigned functions detected:** 21  
> **Table initializers detected:** 6

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-custom/nebulous-liberations/player.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/ezlibs-scripts/ezmemory` |
| 2 | `scripts/ezlibs-scripts/helpers` |
| 3 | `scripts/logger/logger` |
| 5 | `scripts/ezlibs-custom/nebulous-liberations/liberations/option_menu` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 9 | `create_textbox_promise` | `self` | local |
| 31 | `debug_print_battle_data` | `value, prefix, depth` | local |
| 59 | `stats_indicate_panic` | `stats` | local |
| 68 | `Player:new` | `player_id` | assigned/declared |
| 93 | `Player:message` | `message, texture_path, animation_path` | assigned/declared |
| 98 | `Player:message_with_mug` | `message` | assigned/declared |
| 105 | `Player:say` | `message, texture_path, animation_path` | assigned/declared |
| 110 | `Player:say_with_mug` | `message` | assigned/declared |
| 114 | `Player:question` | `question, texture_path, animation_path` | assigned/declared |
| 119 | `Player:question_with_mug` | `question` | assigned/declared |
| 123 | `Player:quiz` | `a, b, c, texture_path, animation_path` | assigned/declared |
| 131 | `Player:quiz_with_mug` | `a, b, c` | assigned/declared |
| 137 | `Player:select_mission_option` | `options, title` | assigned/declared |
| 141 | `Player:is_battling` | `(none)` | assigned/declared |
| 148 | `create_default_results` | `(none)` | local |
| 157 | `Player:initiate_encounter` | `asset_path, data` | assigned/declared |
| 175 | `Player:handle_textbox_response` | `response` | assigned/declared |
| 194 | `Player:handle_battle_results` | `stats` | assigned/declared |
| 240 | `Player:handle_battle_exit` | `stats` | assigned/declared |
| 271 | `Player:handle_disconnect` | `(none)` | assigned/declared |
| 295 | `Player:boot_to_lobby` | `isVictory, mapName` | assigned/declared |

### Detailed parameter inventory

#### 1. `create_textbox_promise(self)`

- **Line:** 9
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared in this function; type not inferred. |

#### 2. `debug_print_battle_data(value, prefix, depth)`

- **Line:** 31
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |
| 2 | `prefix` | Declared in this function; type not inferred. |
| 3 | `depth` | Declared in this function; type not inferred. |

#### 3. `stats_indicate_panic(stats)`

- **Line:** 59
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `stats` | Declared in this function; type not inferred. |

#### 4. `Player:new(player_id)`

- **Line:** 68
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 5. `Player:message(message, texture_path, animation_path)`

- **Line:** 93
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `message` | Declared in this function; type not inferred. |
| 2 | `texture_path` | Declared in this function; type not inferred. |
| 3 | `animation_path` | Declared in this function; type not inferred. |

#### 6. `Player:message_with_mug(message)`

- **Line:** 98
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `message` | Declared in this function; type not inferred. |

#### 7. `Player:say(message, texture_path, animation_path)`

- **Line:** 105
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `message` | Declared in this function; type not inferred. |
| 2 | `texture_path` | Declared in this function; type not inferred. |
| 3 | `animation_path` | Declared in this function; type not inferred. |

#### 8. `Player:say_with_mug(message)`

- **Line:** 110
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `message` | Declared in this function; type not inferred. |

#### 9. `Player:question(question, texture_path, animation_path)`

- **Line:** 114
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `question` | Declared in this function; type not inferred. |
| 2 | `texture_path` | Declared in this function; type not inferred. |
| 3 | `animation_path` | Declared in this function; type not inferred. |

#### 10. `Player:question_with_mug(question)`

- **Line:** 119
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `question` | Declared in this function; type not inferred. |

#### 11. `Player:quiz(a, b, c, texture_path, animation_path)`

- **Line:** 123
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `a` | Declared in this function; type not inferred. |
| 2 | `b` | Declared in this function; type not inferred. |
| 3 | `c` | Declared in this function; type not inferred. |
| 4 | `texture_path` | Declared in this function; type not inferred. |
| 5 | `animation_path` | Declared in this function; type not inferred. |

#### 12. `Player:quiz_with_mug(a, b, c)`

- **Line:** 131
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `a` | Declared in this function; type not inferred. |
| 2 | `b` | Declared in this function; type not inferred. |
| 3 | `c` | Declared in this function; type not inferred. |

#### 13. `Player:select_mission_option(options, title)`

- **Line:** 137
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `options` | Declared in this function; type not inferred. |
| 2 | `title` | Declared in this function; type not inferred. |

#### 14. `Player:is_battling()`

- **Line:** 141
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 15. `create_default_results()`

- **Line:** 148
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 16. `Player:initiate_encounter(asset_path, data)`

- **Line:** 157
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `asset_path` | Declared in this function; type not inferred. |
| 2 | `data` | Declared in this function; type not inferred. |

#### 17. `Player:handle_textbox_response(response)`

- **Line:** 175
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `response` | Declared in this function; type not inferred. |

#### 18. `Player:handle_battle_results(stats)`

- **Line:** 194
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `stats` | Declared in this function; type not inferred. |

#### 19. `Player:handle_battle_exit(stats)`

- **Line:** 240
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `stats` | Declared in this function; type not inferred. |

#### 20. `Player:handle_disconnect()`

- **Line:** 271
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 21. `Player:boot_to_lobby(isVictory, mapName)`

- **Line:** 295
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `isVictory` | Declared in this function; type not inferred. |
| 2 | `mapName` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 21 | `BattleReason` |
| 66 | `Player` |
| 71 | `player` |
| 75 | `textbox_promise_resolvers` |
| 152 | `enemies` |
| 216 | `token` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_area_custom_property` | 1 | 299 |
| `Net.get_object_by_id` | 1 | 311 |
| `Net.get_object_by_name` | 1 | 302 |
| `Net.get_player_area` | 1 | 298 |
| `Net.get_player_mugshot` | 1 | 74 |
| `Net.get_player_position` | 1 | 69 |
| `Net.get_spawn_position` | 1 | 305 |
| `Net.initiate_encounter` | 1 | 168 |
| `Net.list_objects` | 1 | 310 |
| `Net.message_player` | 2 | 94 |
| `Net.question_player` | 1 | 115 |
| `Net.quiz_player` | 1 | 124 |
| `Net.transfer_player` | 1 | 307 |
