# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/menuAPI/main.lua`](../../../../net-games/menuAPI/main.lua)  
> **Source lines:** 699  
> **SHA-256 (UTF-8):** `b3d7050855e7d6dfe4cc81c24baa7c0df215dba864de0799320bef3ac927d786`  
> **Named functions detected:** 47  
> **Table initializers detected:** 27

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
| 8 | `scripts/net-games/main` |
| 10 | `scripts/displayer/displayer` |
| 11 | `scripts/input-controller/main` |
| 12 | `scripts/net-games/ui-safe` |
| 13 | `scripts/player-control/main` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 658 | `Net` | `tick` |
| 695 | `Net` | `player_disconnect` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 18 | `get_controller` | `player_id` | local |
| 39 | `tint_copy` | `src` | local |
| 55 | `MenuAPI.get_palette` | `name` | assigned/declared |
| 132 | `copy_table` | `src` | local |
| 140 | `merge` | `dst, src` | local |
| 148 | `resolve_type` | `value` | local |
| 157 | `stack_for` | `player_id, create` | local |
| 162 | `active` | `player_id` | local |
| 169 | `retained_owner` | `pid` | local |
| 172 | `retain_input` | `pid` | local |
| 177 | `release_retained_input` | `pid` | local |
| 185 | `guard_input` | `player_id,swallow_seconds` | local |
| 193 | `play_sfx` | `player_id, path` | local |
| 198 | `normalize_rows` | `rows` | local |
| 212 | `row_selectable` | `row` | local |
| 216 | `first_selectable` | `rows` | local |
| 221 | `next_selectable` | `rows, start, direction` | local |
| 232 | `ensure_visible` | `st` | local |
| 243 | `sprite_key` | `st, key` | local |
| 244 | `text_key` | `st, key` | local |
| 246 | `draw_text` | `st, key, text, x, y, options` | local |
| 253 | `erase_text` | `st, key` | local |
| 257 | `tint_options` | `tint, extra` | local |
| 269 | `draw_background` | `st` | local |
| 282 | `draw_title` | `st` | local |
| 288 | `clear_visible_rows` | `st` | local |
| 297 | `draw_rows` | `st` | local |
| 338 | `draw_cursor` | `st` | local |
| 353 | `draw_scroll` | `st` | local |
| 370 | `draw_profile` | `st` | local |
| 408 | `draw_confirm` | `st` | local |
| 427 | `full_draw` | `st` | local |
| 433 | `cleanup` | `st` | local |
| 443 | `move_selection` | `st, direction` | local |
| 465 | `confirm` | `st` | local |
| 481 | `handle_cancel` | `st` | local |
| 490 | `MenuAPI.open` | `player_id, spec` | assigned/declared |
| 579 | `MenuAPI.close` | `player_id,opts` | assigned/declared |
| 596 | `MenuAPI.close_all` | `player_id,opts` | assigned/declared |
| 613 | `MenuAPI.is_open` | `player_id` | assigned/declared |
| 614 | `MenuAPI.get_state` | `player_id` | assigned/declared |
| 615 | `MenuAPI.get_stack` | `player_id` | assigned/declared |
| 617 | `MenuAPI.refresh` | `player_id` | assigned/declared |
| 624 | `MenuAPI.set_rows` | `player_id, rows, preserve_selection` | assigned/declared |
| 638 | `MenuAPI.set_profile` | `player_id, profile` | assigned/declared |
| 646 | `MenuAPI.set_title` | `player_id, title` | assigned/declared |
| 651 | `MenuAPI.handle_cancel` | `player_id` | assigned/declared |

### Parameter inventory

#### 1. `get_controller(player_id)`

- **Line:** 18
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 2. `tint_copy(src)`

- **Line:** 39
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `src` | Declared directly in the current Lua. Type not inferred. |

#### 3. `MenuAPI.get_palette(name)`

- **Line:** 55
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared directly in the current Lua. Type not inferred. |

#### 4. `copy_table(src)`

- **Line:** 132
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `src` | Declared directly in the current Lua. Type not inferred. |

#### 5. `merge(dst, src)`

- **Line:** 140
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dst` | Declared directly in the current Lua. Type not inferred. |
| 2 | `src` | Declared directly in the current Lua. Type not inferred. |

#### 6. `resolve_type(value)`

- **Line:** 148
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared directly in the current Lua. Type not inferred. |

#### 7. `stack_for(player_id, create)`

- **Line:** 157
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `create` | Declared directly in the current Lua. Type not inferred. |

#### 8. `active(player_id)`

- **Line:** 162
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 9. `retained_owner(pid)`

- **Line:** 169
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 10. `retain_input(pid)`

- **Line:** 172
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 11. `release_retained_input(pid)`

- **Line:** 177
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 12. `guard_input(player_id,swallow_seconds)`

- **Line:** 185
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `swallow_seconds` | Declared directly in the current Lua. Type not inferred. |

#### 13. `play_sfx(player_id, path)`

- **Line:** 193
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `path` | Declared directly in the current Lua. Type not inferred. |

#### 14. `normalize_rows(rows)`

- **Line:** 198
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `rows` | Declared directly in the current Lua. Type not inferred. |

#### 15. `row_selectable(row)`

- **Line:** 212
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `row` | Declared directly in the current Lua. Type not inferred. |

#### 16. `first_selectable(rows)`

- **Line:** 216
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `rows` | Declared directly in the current Lua. Type not inferred. |

#### 17. `next_selectable(rows, start, direction)`

- **Line:** 221
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `rows` | Declared directly in the current Lua. Type not inferred. |
| 2 | `start` | Declared directly in the current Lua. Type not inferred. |
| 3 | `direction` | Declared directly in the current Lua. Type not inferred. |

#### 18. `ensure_visible(st)`

- **Line:** 232
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |

#### 19. `sprite_key(st, key)`

- **Line:** 243
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |
| 2 | `key` | Declared directly in the current Lua. Type not inferred. |

#### 20. `text_key(st, key)`

- **Line:** 244
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |
| 2 | `key` | Declared directly in the current Lua. Type not inferred. |

#### 21. `draw_text(st, key, text, x, y, options)`

- **Line:** 246
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |
| 2 | `key` | Declared directly in the current Lua. Type not inferred. |
| 3 | `text` | Declared directly in the current Lua. Type not inferred. |
| 4 | `x` | Declared directly in the current Lua. Type not inferred. |
| 5 | `y` | Declared directly in the current Lua. Type not inferred. |
| 6 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 22. `erase_text(st, key)`

- **Line:** 253
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |
| 2 | `key` | Declared directly in the current Lua. Type not inferred. |

#### 23. `tint_options(tint, extra)`

- **Line:** 257
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tint` | Declared directly in the current Lua. Type not inferred. |
| 2 | `extra` | Declared directly in the current Lua. Type not inferred. |

#### 24. `draw_background(st)`

- **Line:** 269
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |

#### 25. `draw_title(st)`

- **Line:** 282
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |

#### 26. `clear_visible_rows(st)`

- **Line:** 288
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |

#### 27. `draw_rows(st)`

- **Line:** 297
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |

#### 28. `draw_cursor(st)`

- **Line:** 338
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |

#### 29. `draw_scroll(st)`

- **Line:** 353
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |

#### 30. `draw_profile(st)`

- **Line:** 370
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |

#### 31. `draw_confirm(st)`

- **Line:** 408
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |

#### 32. `full_draw(st)`

- **Line:** 427
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |

#### 33. `cleanup(st)`

- **Line:** 433
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |

#### 34. `move_selection(st, direction)`

- **Line:** 443
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |
| 2 | `direction` | Declared directly in the current Lua. Type not inferred. |

#### 35. `confirm(st)`

- **Line:** 465
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |

#### 36. `handle_cancel(st)`

- **Line:** 481
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `st` | Declared directly in the current Lua. Type not inferred. |

#### 37. `MenuAPI.open(player_id, spec)`

- **Line:** 490
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `spec` | Declared directly in the current Lua. Type not inferred. |

#### 38. `MenuAPI.close(player_id,opts)`

- **Line:** 579
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 39. `MenuAPI.close_all(player_id,opts)`

- **Line:** 596
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 40. `MenuAPI.is_open(player_id)`

- **Line:** 613
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 41. `MenuAPI.get_state(player_id)`

- **Line:** 614
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 42. `MenuAPI.get_stack(player_id)`

- **Line:** 615
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 43. `MenuAPI.refresh(player_id)`

- **Line:** 617
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 44. `MenuAPI.set_rows(player_id, rows, preserve_selection)`

- **Line:** 624
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `rows` | Declared directly in the current Lua. Type not inferred. |
| 3 | `preserve_selection` | Declared directly in the current Lua. Type not inferred. |

#### 45. `MenuAPI.set_profile(player_id, profile)`

- **Line:** 638
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `profile` | Declared directly in the current Lua. Type not inferred. |

#### 46. `MenuAPI.set_title(player_id, title)`

- **Line:** 646
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `title` | Declared directly in the current Lua. Type not inferred. |

#### 47. `MenuAPI.handle_cancel(player_id)`

- **Line:** 651
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 15 | `MenuAPI` |
| 23 | `cfg` |
| 29 | `title_tint` |
| 30 | `row_tint` |
| 31 | `right_tint` |
| 32 | `disabled_tint` |
| 40 | `out` |
| 45 | `MenuAPI.tint_palettes` |
| 46 | `default` |
| 47 | `red` |
| 48 | `blue` |
| 49 | `green` |
| 50 | `gold` |
| 51 | `purple` |
| 52 | `gray` |
| 59 | `MENU_TYPES` |
| 64 | `layout` |
| 78 | `layout` |
| 89 | `layout` |
| 101 | `layout` |
| 112 | `layout` |
| 129 | `stacks` |
| 133 | `out` |
| 199 | `out` |
| 259 | `opts` |
| 502 | `st` |
| 534 | `options` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.on` | 2 | 658 |
