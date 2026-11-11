# 📄 `ezbbs.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezbbs.lua`](../../../ezlibs-scripts/ezbbs.lua)  
> **Source lines:** 475  
> **SHA-256 (UTF-8):** `a01c13b5375e3b717299446193c6c8c914e57d3fcd6357dee92ecdf75a6fe025`  
> **Named/assigned functions detected:** 21  
> **Table initializers detected:** 16

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezbbs.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 6 | `scripts/logger/logger` |
| 7 | `scripts/libs/json` |
| 8 | `scripts/ezlibs-scripts/ezusers` |
| 9 | `scripts/ezlibs-scripts/helpers` |
| 10 | `scripts/ezlibs-scripts/ezconfig` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 31 | `shallow_copy` | `original` | local |
| 37 | `contains_only_whitespace` | `text` | local |
| 41 | `sanitize_title` | `text, limit` | local |
| 45 | `bbs_compare_pinned` | `a, b` | local |
| 55 | `bbs_compare_unpinned` | `a, b` | local |
| 62 | `bbs_display_order_ids` | `board_data` | local |
| 85 | `save_board` | `board_name` | local |
| 108 | `push_post` | `board_name, area_id, post` | local |
| 127 | `show_post` | `player_id, post_id` | local |
| 140 | `create_post` | `player_id, state` | local |
| 187 | `load_board` | `name, callback` | local |
| 222 | `open_board_with_data` | `board_data, player_id, board_name, color, postable, area_id, board_id` | local |
| 229 | `add_display_post` | `src` | local |
| 257 | `load_board_and_open` | `name, player_id, area_id, object, color, postable` | local |
| 266 | `preload_boards` | `(none)` | local |
| 292 | `ezbbs.handle_player_join` | `player_id` | assigned/declared |
| 296 | `ezbbs.handle_player_disconnect` | `player_id` | assigned/declared |
| 301 | `ezbbs.handle_object_interaction` | `player_id, object_id, button` | assigned/declared |
| 334 | `ezbbs.handle_post_selection` | `player_id, post_id` | assigned/declared |
| 439 | `ezbbs.handle_textbox_response` | `player_id, response` | assigned/declared |
| 468 | `ezbbs.handle_board_close` | `player_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `shallow_copy(original)`

- **Line:** 31
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `original` | Declared in this function; type not inferred. |

#### 2. `contains_only_whitespace(text)`

- **Line:** 37
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `text` | Declared in this function; type not inferred. |

#### 3. `sanitize_title(text, limit)`

- **Line:** 41
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `text` | Declared in this function; type not inferred. |
| 2 | `limit` | Declared in this function; type not inferred. |

#### 4. `bbs_compare_pinned(a, b)`

- **Line:** 45
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `a` | Declared in this function; type not inferred. |
| 2 | `b` | Declared in this function; type not inferred. |

#### 5. `bbs_compare_unpinned(a, b)`

- **Line:** 55
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `a` | Declared in this function; type not inferred. |
| 2 | `b` | Declared in this function; type not inferred. |

#### 6. `bbs_display_order_ids(board_data)`

- **Line:** 62
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `board_data` | Declared in this function; type not inferred. |

#### 7. `save_board(board_name)`

- **Line:** 85
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `board_name` | Declared in this function; type not inferred. |

#### 8. `push_post(board_name, area_id, post)`

- **Line:** 108
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `board_name` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `post` | Declared in this function; type not inferred. |

#### 9. `show_post(player_id, post_id)`

- **Line:** 127
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `post_id` | Declared in this function; type not inferred. |

#### 10. `create_post(player_id, state)`

- **Line:** 140
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `state` | Declared in this function; type not inferred. |

#### 11. `load_board(name, callback)`

- **Line:** 187
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared in this function; type not inferred. |
| 2 | `callback` | Declared in this function; type not inferred. |

#### 12. `open_board_with_data(board_data, player_id, board_name, color, postable, area_id, board_id)`

- **Line:** 222
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `board_data` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `board_name` | Declared in this function; type not inferred. |
| 4 | `color` | Declared in this function; type not inferred. |
| 5 | `postable` | Declared in this function; type not inferred. |
| 6 | `area_id` | Declared in this function; type not inferred. |
| 7 | `board_id` | Declared in this function; type not inferred. |

#### 13. `add_display_post(src)`

- **Line:** 229
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `src` | Declared in this function; type not inferred. |

#### 14. `load_board_and_open(name, player_id, area_id, object, color, postable)`

- **Line:** 257
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared in this function; type not inferred. |
| 2 | `player_id` | Declared in this function; type not inferred. |
| 3 | `area_id` | Declared in this function; type not inferred. |
| 4 | `object` | Declared in this function; type not inferred. |
| 5 | `color` | Declared in this function; type not inferred. |
| 6 | `postable` | Declared in this function; type not inferred. |

#### 15. `preload_boards()`

- **Line:** 266
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 16. `ezbbs.handle_player_join(player_id)`

- **Line:** 292
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 17. `ezbbs.handle_player_disconnect(player_id)`

- **Line:** 296
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 18. `ezbbs.handle_object_interaction(player_id, object_id, button)`

- **Line:** 301
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |
| 3 | `button` | Declared in this function; type not inferred. |

#### 19. `ezbbs.handle_post_selection(player_id, post_id)`

- **Line:** 334
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `post_id` | Declared in this function; type not inferred. |

#### 20. `ezbbs.handle_textbox_response(player_id, response)`

- **Line:** 439
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `response` | Declared in this function; type not inferred. |

#### 21. `ezbbs.handle_board_close(player_id)`

- **Line:** 468
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 21 | `last_read_time` |
| 22 | `player_states` |
| 23 | `board_cache` |
| 32 | `copy` |
| 74 | `ids` |
| 83 | `saving` |
| 84 | `pending_save` |
| 121 | `new_posts` |
| 144 | `board_data` |
| 157 | `post` |
| 205 | `data` |
| 224 | `posts` |
| 269 | `board_names` |
| 290 | `ezbbs` |
| 324 | `color` |
| 387 | `viewers` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.append_posts` | 1 | 411 |
| `Net.get_object_by_id` | 4 | 141 |
| `Net.get_player_area` | 1 | 303 |
| `Net.get_player_name` | 1 | 149 |
| `Net.list_areas` | 1 | 268 |
| `Net.list_objects` | 1 | 271 |
| `Net.list_players` | 1 | 122 |
| `Net.message_player` | 5 | 134 |
| `Net.open_board` | 1 | 246 |
| `Net.prompt_player` | 2 | 352 |
| `Net.question_player` | 1 | 447 |
| `Net.remove_post` | 2 | 410 |
