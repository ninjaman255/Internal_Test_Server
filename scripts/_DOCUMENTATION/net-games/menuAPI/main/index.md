# 📄 `main.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/menuAPI/main.lua`](../../../../net-games/menuAPI/main.lua)  
> **Source lines:** 732  
> **SHA-256 (UTF-8):** `f6ee48f9fd2d4d…`  
> **Declared/assigned functions detected:** 46  
> **Anonymous closures detected:** 2  
> **Table initializers detected:** 45

## 🗂️ Contents

- [📌 Overview](#overview)
- [🔗 Dependencies](#dependencies)
- [📡 Event subscriptions](#event-subscriptions)
- [🧩 Functions](#functions)
- [🪄 Anonymous closures](#anonymous-closures)
- [📦 Tables and data](#tables-and-data)
- [⚙️ Runtime API calls](#runtime-api-calls)
- [🧪 Static-analysis notes](#static-analysis-notes)

## 📌 Overview

Reusable BN-style menu layer for net-games. This is a creator-side rewrite inspired by the production MenuAPI used by shadis_hp. It intentionally depends only on net-games/Displayer/Input and does not contain pet, inventory, LMenu, or server-specific business logic.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 8 | `scripts/net-games/main` |
| 10 | `scripts/displayer/displayer` |
| 11 | `scripts/input-controller/main` |
| 12 | `scripts/net-games/ui-safe` |
| 13 | `scripts/net-games/ui-suppression` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 673 | `Net:on` | `tick` |
| 723 | `Net:on` | `player_disconnect` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 18 | `get_controller` | `player_id` | local |
| 23 | `menu_input_owner` | `player_id` | local |
| 27 | `guard_input` | `player_id, swallow_seconds` | local |
| 60 | `tint_copy` | `src` | local |
| 76 | `MenuAPI.get_palette` | `name` | declared |
| 153 | `copy_table` | `src` | local |
| 161 | `merge` | `dst, src` | local |
| 169 | `resolve_type` | `value` | local |
| 178 | `stack_for` | `player_id, create` | local |
| 183 | `active` | `player_id` | local |
| 190 | `set_input_locked` | `player_id, locked` | local |
| 217 | `play_sfx` | `player_id, path` | local |
| 222 | `normalize_rows` | `rows` | local |
| 236 | `row_selectable` | `row` | local |
| 240 | `first_selectable` | `rows` | local |
| 245 | `next_selectable` | `rows, start, direction` | local |
| 256 | `ensure_visible` | `st` | local |
| 267 | `sprite_key` | `st, key` | local |
| 268 | `text_key` | `st, key` | local |
| 270 | `draw_text` | `st, key, text, x, y, options` | local |
| 277 | `erase_text` | `st, key` | local |
| 281 | `tint_options` | `tint, extra` | local |
| 293 | `draw_background` | `st` | local |
| 306 | `draw_title` | `st` | local |
| 312 | `clear_visible_rows` | `st` | local |
| 321 | `draw_rows` | `st` | local |
| 362 | `draw_cursor` | `st` | local |
| 377 | `draw_scroll` | `st` | local |
| 394 | `draw_profile` | `st` | local |
| 432 | `draw_confirm` | `st` | local |
| 451 | `full_draw` | `st` | local |
| 457 | `cleanup` | `st` | local |
| 467 | `move_selection` | `st, direction` | local |
| 489 | `confirm` | `st` | local |
| 505 | `handle_cancel` | `st` | local |
| 514 | `MenuAPI.open` | `player_id, spec` | declared |
| 585 | `MenuAPI.close` | `player_id, opts` | declared |
| 613 | `MenuAPI.close_all` | `player_id, opts` | declared |
| 628 | `MenuAPI.is_open` | `player_id` | declared |
| 629 | `MenuAPI.get_state` | `player_id` | declared |
| 630 | `MenuAPI.get_stack` | `player_id` | declared |
| 632 | `MenuAPI.refresh` | `player_id` | declared |
| 639 | `MenuAPI.set_rows` | `player_id, rows, preserve_selection` | declared |
| 653 | `MenuAPI.set_profile` | `player_id, profile` | declared |
| 661 | `MenuAPI.set_title` | `player_id, title` | declared |
| 666 | `MenuAPI.handle_cancel` | `player_id` | declared |

### Function details

#### 1. `get_controller(player_id)`

- **Location:** source line 18.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 2. `menu_input_owner(player_id)`

- **Location:** source line 23.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 3. `guard_input(player_id, swallow_seconds)`

- **Location:** source line 27.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `swallow_seconds` | Not explicitly documented in adjacent source annotations. |

#### 4. `tint_copy(src)`

- **Location:** source line 60.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `src` | Not explicitly documented in adjacent source annotations. |

#### 5. `MenuAPI.get_palette(name)`

- **Location:** source line 76.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `name` | Not explicitly documented in adjacent source annotations. |

#### 6. `copy_table(src)`

- **Location:** source line 153.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `src` | Not explicitly documented in adjacent source annotations. |

#### 7. `merge(dst, src)`

- **Location:** source line 161.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `dst` | Not explicitly documented in adjacent source annotations. |
| 2 | `src` | Not explicitly documented in adjacent source annotations. |

#### 8. `resolve_type(value)`

- **Location:** source line 169.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 9. `stack_for(player_id, create)`

- **Location:** source line 178.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `create` | Not explicitly documented in adjacent source annotations. |

#### 10. `active(player_id)`

- **Location:** source line 183.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 11. `set_input_locked(player_id, locked)`

- **Location:** source line 190.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `locked` | Not explicitly documented in adjacent source annotations. |

#### 12. `play_sfx(player_id, path)`

- **Location:** source line 217.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `path` | Not explicitly documented in adjacent source annotations. |

#### 13. `normalize_rows(rows)`

- **Location:** source line 222.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `rows` | Not explicitly documented in adjacent source annotations. |

#### 14. `row_selectable(row)`

- **Location:** source line 236.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `row` | Not explicitly documented in adjacent source annotations. |

#### 15. `first_selectable(rows)`

- **Location:** source line 240.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `rows` | Not explicitly documented in adjacent source annotations. |

#### 16. `next_selectable(rows, start, direction)`

- **Location:** source line 245.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `rows` | Not explicitly documented in adjacent source annotations. |
| 2 | `start` | Not explicitly documented in adjacent source annotations. |
| 3 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 17. `ensure_visible(st)`

- **Location:** source line 256.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |

#### 18. `sprite_key(st, key)`

- **Location:** source line 267.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |

#### 19. `text_key(st, key)`

- **Location:** source line 268.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |

#### 20. `draw_text(st, key, text, x, y, options)`

- **Location:** source line 270.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `options` | Not explicitly documented in adjacent source annotations. |

#### 21. `erase_text(st, key)`

- **Location:** source line 277.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |

#### 22. `tint_options(tint, extra)`

- **Location:** source line 281.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tint` | Not explicitly documented in adjacent source annotations. |
| 2 | `extra` | Not explicitly documented in adjacent source annotations. |

#### 23. `draw_background(st)`

- **Location:** source line 293.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |

#### 24. `draw_title(st)`

- **Location:** source line 306.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |

#### 25. `clear_visible_rows(st)`

- **Location:** source line 312.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |

#### 26. `draw_rows(st)`

- **Location:** source line 321.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |

#### 27. `draw_cursor(st)`

- **Location:** source line 362.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |

#### 28. `draw_scroll(st)`

- **Location:** source line 377.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |

#### 29. `draw_profile(st)`

- **Location:** source line 394.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |

#### 30. `draw_confirm(st)`

- **Location:** source line 432.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |

#### 31. `full_draw(st)`

- **Location:** source line 451.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |

#### 32. `cleanup(st)`

- **Location:** source line 457.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |

#### 33. `move_selection(st, direction)`

- **Location:** source line 467.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |
| 2 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 34. `confirm(st)`

- **Location:** source line 489.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |

#### 35. `handle_cancel(st)`

- **Location:** source line 505.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `st` | Not explicitly documented in adjacent source annotations. |

#### 36. `MenuAPI.open(player_id, spec)`

- **Location:** source line 514.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `spec` | Not explicitly documented in adjacent source annotations. |

#### 37. `MenuAPI.close(player_id, opts)`

- **Location:** source line 585.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 38. `MenuAPI.close_all(player_id, opts)`

- **Location:** source line 613.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 39. `MenuAPI.is_open(player_id)`

- **Location:** source line 628.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 40. `MenuAPI.get_state(player_id)`

- **Location:** source line 629.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 41. `MenuAPI.get_stack(player_id)`

- **Location:** source line 630.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 42. `MenuAPI.refresh(player_id)`

- **Location:** source line 632.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 43. `MenuAPI.set_rows(player_id, rows, preserve_selection)`

- **Location:** source line 639.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `rows` | Not explicitly documented in adjacent source annotations. |
| 3 | `preserve_selection` | Not explicitly documented in adjacent source annotations. |

#### 44. `MenuAPI.set_profile(player_id, profile)`

- **Location:** source line 653.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `profile` | Not explicitly documented in adjacent source annotations. |

#### 45. `MenuAPI.set_title(player_id, title)`

- **Location:** source line 661.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `title` | Not explicitly documented in adjacent source annotations. |

#### 46. `MenuAPI.handle_cancel(player_id)`

- **Location:** source line 666.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 673 | `event` | `r. -- virtual_input and repeat timing are handled by input-controller/main.lua. Net:…` |
| 723 | `event` | `handle_cancel(st) end end end end) Net:on("player_disconnect",` |

## 📦 Tables and data

The following **45** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `MenuAPI` — line 15

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `cfg` — line 44

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `open_sfx` | string literal | `"/server/assets/net-games/sfx/screen_open.ogg"` |
| `move_sfx` | string literal | `"/server/assets/net-games/sfx/cursor_move.ogg"` |
| `choose_sfx` | string literal | `"/server/assets/net-games/sfx/choose.ogg"` |
| `cancel_sfx` | string literal | `"/server/assets/net-games/sfx/cancel.ogg"` |
| `title_tint` | nested table | `{ r = 18, g = 42, b = 100, color_mode = 2 }` |
| `row_tint` | nested table | `{ r = 95, g = 100, b = 108, color_mode = 2 }` |
| `right_tint` | nested table | `{ r = 95, g = 100, b = 108, color_mode = 2 }` |
| `disabled_tint` | nested table | `{ r = 110, g = 110, b = 110, color_mode = 0, opacity = 150 }` |
| `lock_input_by_default` | boolean literal | `true` |
| `asset_root` | string literal | `"/server/assets/ui/menuAPI/"` |

### 3. `title_tint` — line 50

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `18` |
| `g` | numeric literal | `42` |
| `b` | numeric literal | `100` |
| `color_mode` | numeric literal | `2` |

### 4. `row_tint` — line 51

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `95` |
| `g` | numeric literal | `100` |
| `b` | numeric literal | `108` |
| `color_mode` | numeric literal | `2` |

### 5. `right_tint` — line 52

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `95` |
| `g` | numeric literal | `100` |
| `b` | numeric literal | `108` |
| `color_mode` | numeric literal | `2` |

### 6. `disabled_tint` — line 53

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `110` |
| `g` | numeric literal | `110` |
| `b` | numeric literal | `110` |
| `color_mode` | numeric literal | `0` |
| `opacity` | numeric literal | `150` |

### 7. `out` — line 61

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `MenuAPI.tint_palettes` — line 66

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `default` | nested table | `{ title_tint = tint_copy(cfg.title_tint), row_tint = tint_copy(cfg.row_tint), right_tint = tint_copy(cfg.right_tint) }` |
| `red` | nested table | `{ title_tint = {r=120,g=20,b=24,color_mode=2}, row_tint={r=128,g=27,b=27,color_mode=2}, right_tint={r=120,g=50,b=50,color_mode=2} }` |
| `blue` | nested table | `{ title_tint = {r=18,g=42,b=100,color_mode=2}, row_tint={r=70,g=90,b=125,color_mode=2}, right_tint={r=65,g=85,b=120,color_mode=2} }` |
| `green` | nested table | `{ title_tint = {r=20,g=95,b=55,color_mode=2}, row_tint={r=65,g=105,b=75,color_mode=2}, right_tint={r=55,g=115,b=70,color_mode=2} }` |
| `gold` | nested table | `{ title_tint = {r=145,g=95,b=20,color_mode=2}, row_tint={r=115,g=95,b=55,color_mode=2}, right_tint={r=135,g=100,b=35,color_mode=2} }` |
| `purple` | nested table | `{ title_tint = {r=95,g=40,b=125,color_mode=2}, row_tint={r=95,g=80,b=115,color_mode=2}, right_tint={r=105,g=75,b=125,color_mode=2} }` |
| `gray` | nested table | `{ title_tint = {r=55,g=60,b=70,color_mode=2}, row_tint={r=95,g=100,b=108,color_mode=2}, right_tint={r=95,g=100,b=108,color_mode=2} }` |

### 9. `default` — line 67

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `title_tint` | expression/reference | `tint_copy(cfg.title_tint)` |
| `row_tint` | expression/reference | `tint_copy(cfg.row_tint)` |
| `right_tint` | expression/reference | `tint_copy(cfg.right_tint)` |

### 10. `red` — line 68

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `title_tint` | nested table | `{r=120,g=20,b=24,color_mode=2}` |
| `row_tint` | nested table | `{r=128,g=27,b=27,color_mode=2}` |
| `right_tint` | nested table | `{r=120,g=50,b=50,color_mode=2}` |

### 11. `title_tint` — line 68

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `120` |
| `g` | numeric literal | `20` |
| `b` | numeric literal | `24` |
| `color_mode` | numeric literal | `2` |

### 12. `row_tint` — line 68

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `128` |
| `g` | numeric literal | `27` |
| `b` | numeric literal | `27` |
| `color_mode` | numeric literal | `2` |

### 13. `right_tint` — line 68

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `120` |
| `g` | numeric literal | `50` |
| `b` | numeric literal | `50` |
| `color_mode` | numeric literal | `2` |

### 14. `blue` — line 69

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `title_tint` | nested table | `{r=18,g=42,b=100,color_mode=2}` |
| `row_tint` | nested table | `{r=70,g=90,b=125,color_mode=2}` |
| `right_tint` | nested table | `{r=65,g=85,b=120,color_mode=2}` |

### 15. `title_tint` — line 69

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `18` |
| `g` | numeric literal | `42` |
| `b` | numeric literal | `100` |
| `color_mode` | numeric literal | `2` |

### 16. `row_tint` — line 69

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `70` |
| `g` | numeric literal | `90` |
| `b` | numeric literal | `125` |
| `color_mode` | numeric literal | `2` |

### 17. `right_tint` — line 69

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `65` |
| `g` | numeric literal | `85` |
| `b` | numeric literal | `120` |
| `color_mode` | numeric literal | `2` |

### 18. `green` — line 70

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `title_tint` | nested table | `{r=20,g=95,b=55,color_mode=2}` |
| `row_tint` | nested table | `{r=65,g=105,b=75,color_mode=2}` |
| `right_tint` | nested table | `{r=55,g=115,b=70,color_mode=2}` |

### 19. `title_tint` — line 70

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `20` |
| `g` | numeric literal | `95` |
| `b` | numeric literal | `55` |
| `color_mode` | numeric literal | `2` |

### 20. `row_tint` — line 70

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `65` |
| `g` | numeric literal | `105` |
| `b` | numeric literal | `75` |
| `color_mode` | numeric literal | `2` |

### 21. `right_tint` — line 70

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `55` |
| `g` | numeric literal | `115` |
| `b` | numeric literal | `70` |
| `color_mode` | numeric literal | `2` |

### 22. `gold` — line 71

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `title_tint` | nested table | `{r=145,g=95,b=20,color_mode=2}` |
| `row_tint` | nested table | `{r=115,g=95,b=55,color_mode=2}` |
| `right_tint` | nested table | `{r=135,g=100,b=35,color_mode=2}` |

### 23. `title_tint` — line 71

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `145` |
| `g` | numeric literal | `95` |
| `b` | numeric literal | `20` |
| `color_mode` | numeric literal | `2` |

### 24. `row_tint` — line 71

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `115` |
| `g` | numeric literal | `95` |
| `b` | numeric literal | `55` |
| `color_mode` | numeric literal | `2` |

### 25. `right_tint` — line 71

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `135` |
| `g` | numeric literal | `100` |
| `b` | numeric literal | `35` |
| `color_mode` | numeric literal | `2` |

### 26. `purple` — line 72

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `title_tint` | nested table | `{r=95,g=40,b=125,color_mode=2}` |
| `row_tint` | nested table | `{r=95,g=80,b=115,color_mode=2}` |
| `right_tint` | nested table | `{r=105,g=75,b=125,color_mode=2}` |

### 27. `title_tint` — line 72

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `95` |
| `g` | numeric literal | `40` |
| `b` | numeric literal | `125` |
| `color_mode` | numeric literal | `2` |

### 28. `row_tint` — line 72

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `95` |
| `g` | numeric literal | `80` |
| `b` | numeric literal | `115` |
| `color_mode` | numeric literal | `2` |

### 29. `right_tint` — line 72

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `105` |
| `g` | numeric literal | `75` |
| `b` | numeric literal | `125` |
| `color_mode` | numeric literal | `2` |

### 30. `gray` — line 73

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `title_tint` | nested table | `{r=55,g=60,b=70,color_mode=2}` |
| `row_tint` | nested table | `{r=95,g=100,b=108,color_mode=2}` |
| `right_tint` | nested table | `{r=95,g=100,b=108,color_mode=2}` |

### 31. `title_tint` — line 73

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `55` |
| `g` | numeric literal | `60` |
| `b` | numeric literal | `70` |
| `color_mode` | numeric literal | `2` |

### 32. `row_tint` — line 73

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `95` |
| `g` | numeric literal | `100` |
| `b` | numeric literal | `108` |
| `color_mode` | numeric literal | `2` |

### 33. `right_tint` — line 73

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `95` |
| `g` | numeric literal | `100` |
| `b` | numeric literal | `108` |
| `color_mode` | numeric literal | `2` |

### 34. `MENU_TYPES` — line 80

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ name = "scroll_list", selectable = true, vertical = true, layout = { texture = cfg.asset_root .. "menu1.png", x = 49, y = 17, z = 220, scale = 2, title_…` |
| `[2]` | nested table | `{ name = "info_window", selectable = false, vertical = false, layout = { texture = cfg.asset_root .. "menu2.png", x = 49, y = 17, z = 220, scale = 2, titl…` |
| `[3]` | nested table | `{ name = "compact_menu", selectable = true, vertical = true, layout = { texture = cfg.asset_root .. "menu2.png", x = 49, y = 17, z = 220, scale = 2, title…` |
| `[4]` | nested table | `{ name = "confirm_prompt", selectable = true, horizontal = true, layout = { texture = cfg.asset_root .. "menu2.png", x = 49, y = 17, z = 220, scale = 2, t…` |
| `[5]` | nested table | `{ name = "profile_list", selectable = true, vertical = true, layout = { profile_texture = cfg.asset_root .. "menu3.png", profile_x = 144, profile_y = 20, …` |

### 35. `layout` — line 85

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture` | expression/reference | `cfg.asset_root .. "menu1.png"` |
| `x` | numeric literal | `49` |
| `y` | numeric literal | `17` |
| `z` | numeric literal | `220` |
| `scale` | numeric literal | `2` |
| `title_x` | numeric literal | `17` |
| `title_y` | numeric literal | `1` |
| `title_font` | string literal | `"THICK"` |
| `title_scale` | numeric literal | `1.5` |
| `row_x` | numeric literal | `13` |
| `row_y` | numeric literal | `16` |
| `row_font` | string literal | `"THICK"` |
| `row_scale` | numeric literal | `1.5` |
| `row_advance` | numeric literal | `13` |
| `right_x` | numeric literal | `103` |
| `right_font` | string literal | `"THICK"` |
| `right_scale` | numeric literal | `1.5` |
| `visible_rows` | numeric literal | `8` |
| `cursor_texture` | expression/reference | `cfg.asset_root .. "cursor.png"` |
| `cursor_x` | numeric literal | `1` |
| `cursor_y_offset` | numeric literal | `-2` |
| `cursor_scale` | numeric literal | `2` |
| `scroll_texture` | expression/reference | `cfg.asset_root .. "scroll.png"` |
| `scroll_x` | numeric literal | `131` |
| `scroll_top_y` | numeric literal | `11` |
| `scroll_bottom_y` | numeric literal | `106` |
| `scroll_h` | numeric literal | `13` |
| `scroll_scale` | numeric literal | `2` |

### 36. `layout` — line 99

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture` | expression/reference | `cfg.asset_root .. "menu2.png"` |
| `x` | numeric literal | `49` |
| `y` | numeric literal | `17` |
| `z` | numeric literal | `220` |
| `scale` | numeric literal | `2` |
| `title_x` | numeric literal | `17` |
| `title_y` | numeric literal | `1` |
| `title_font` | string literal | `"THICK"` |
| `title_scale` | numeric literal | `1.5` |
| `row_x` | numeric literal | `13` |
| `row_y` | numeric literal | `16` |
| `row_font` | string literal | `"THICK"` |
| `row_scale` | numeric literal | `1.5` |
| `row_advance` | numeric literal | `13` |
| `visible_rows` | numeric literal | `4` |

### 37. `layout` — line 110

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture` | expression/reference | `cfg.asset_root .. "menu2.png"` |
| `x` | numeric literal | `49` |
| `y` | numeric literal | `17` |
| `z` | numeric literal | `220` |
| `scale` | numeric literal | `2` |
| `title_x` | numeric literal | `17` |
| `title_y` | numeric literal | `1` |
| `title_font` | string literal | `"THICK"` |
| `title_scale` | numeric literal | `1.5` |
| `row_x` | numeric literal | `13` |
| `row_y` | numeric literal | `16` |
| `row_font` | string literal | `"THICK"` |
| `row_scale` | numeric literal | `1.5` |
| `row_advance` | numeric literal | `13` |
| `visible_rows` | numeric literal | `4` |
| `cursor_texture` | expression/reference | `cfg.asset_root .. "cursor.png"` |
| `cursor_x` | numeric literal | `1` |
| `cursor_y_offset` | numeric literal | `-2` |
| `cursor_scale` | numeric literal | `2` |

### 38. `layout` — line 122

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture` | expression/reference | `cfg.asset_root .. "menu2.png"` |
| `x` | numeric literal | `49` |
| `y` | numeric literal | `17` |
| `z` | numeric literal | `220` |
| `scale` | numeric literal | `2` |
| `title_x` | numeric literal | `17` |
| `title_y` | numeric literal | `1` |
| `title_font` | string literal | `"THICK"` |
| `title_scale` | numeric literal | `1.5` |
| `line_x` | numeric literal | `13` |
| `line_y` | numeric literal | `16` |
| `line_font` | string literal | `"THICK"` |
| `line_scale` | numeric literal | `1.5` |
| `line_advance` | numeric literal | `13` |
| `choice_y` | numeric literal | `55` |
| `yes_x` | numeric literal | `25` |
| `no_x` | numeric literal | `82` |
| `choice_scale` | numeric literal | `1.5` |

### 39. `layout` — line 133

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `profile_texture` | expression/reference | `cfg.asset_root .. "menu3.png"` |
| `profile_x` | numeric literal | `144` |
| `profile_y` | numeric literal | `20` |
| `profile_z` | numeric literal | `220` |
| `profile_scale` | numeric literal | `2` |
| `mug_x` | numeric literal | `4` |
| `mug_y` | numeric literal | `13` |
| `mug_scale` | numeric literal | `1` |
| `profile_title_x` | numeric literal | `17` |
| `profile_title_y` | numeric literal | `2` |
| `profile_title_font` | string literal | `"THICK_BLACK"` |
| `profile_title_scale` | numeric literal | `1.8` |
| `profile_text_x` | numeric literal | `40` |
| `profile_text_y` | numeric literal | `24` |
| `profile_text_advance` | numeric literal | `10` |
| `profile_font` | string literal | `"THICK"` |
| `profile_text_scale` | numeric literal | `1.5` |
| `texture` | expression/reference | `cfg.asset_root .. "menu1.png"` |
| `x` | numeric literal | `2` |
| `y` | numeric literal | `20` |
| `z` | numeric literal | `220` |
| `scale` | numeric literal | `2` |
| `title_x` | numeric literal | `17` |
| `title_y` | numeric literal | `1` |
| `title_font` | string literal | `"THICK"` |
| `title_scale` | numeric literal | `1.5` |
| `row_x` | numeric literal | `13` |
| `row_y` | numeric literal | `16` |
| `row_font` | string literal | `"THICK"` |
| `row_scale` | numeric literal | `1.5` |
| `row_advance` | numeric literal | `13` |
| `right_x` | numeric literal | `96` |
| `right_font` | string literal | `"THICK"` |
| `right_scale` | numeric literal | `1.5` |
| `visible_rows` | numeric literal | `8` |
| `cursor_texture` | expression/reference | `cfg.asset_root .. "cursor.png"` |
| `cursor_x` | numeric literal | `1` |
| `cursor_y_offset` | numeric literal | `-2` |
| `cursor_scale` | numeric literal | `2` |
| `scroll_texture` | expression/reference | `cfg.asset_root .. "scroll.png"` |
| `scroll_x` | numeric literal | `131` |
| `scroll_top_y` | numeric literal | `11` |
| `scroll_bottom_y` | numeric literal | `106` |
| `scroll_h` | numeric literal | `13` |
| `scroll_scale` | numeric literal | `2` |

### 40. `stacks` — line 150

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 41. `out` — line 154

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 42. `input_lock_handles` — line 188

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 43. `out` — line 223

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 44. `opts` — line 283

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | string literal | `"THICK"` |
| `scale` | numeric literal | `1.5` |
| `z` | numeric literal | `225` |
| `r` | expression/reference | `tint.r or 255` |
| `g` | expression/reference | `tint.g or 255` |
| `b` | expression/reference | `tint.b or 255` |
| `opacity` | expression/reference | `tint.opacity or 255` |
| `a` | expression/reference | `tint.a or 255` |
| `color_mode` | expression/reference | `tint.color_mode or 0` |

### 45. `st` — line 526

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `player_id` | expression/reference | `player_id` |
| `type` | expression/reference | `type_id` |
| `type_name` | expression/reference | `def.name` |
| `prefix` | string literal | `"menuapi_" .. tostring(player_id) .. "_" .. tostring(next_id)` |
| `layout` | expression/reference | `layout` |
| `title` | expression/reference | `spec.title or "Menu"` |
| `rows` | expression/reference | `normalize_rows(spec.rows)` |
| `cursor` | numeric literal | `1` |
| `top_index` | numeric literal | `1` |
| `profile` | expression/reference | `copy_table(spec.profile)` |
| `lines` | expression/reference | `copy_table(spec.lines)` |
| `choice` | expression/reference | `(tonumber(spec.default_selection) == 2 or tostring(spec.default_selection):lower() == "no") and 2 or 1` |
| `yes_text` | expression/reference | `spec.yes_text` |
| `no_text` | expression/reference | `spec.no_text` |
| `title_tint` | expression/reference | `copy_table(spec.title_tint or palette.title_tint)` |
| `row_tint` | expression/reference | `copy_table(spec.row_tint or palette.row_tint)` |
| `right_tint` | expression/reference | `copy_table(spec.right_tint or palette.right_tint)` |
| `bg_tint` | expression/reference | `copy_table(spec.bg_tint)` |
| `on_select` | expression/reference | `spec.on_select` |
| `on_move` | expression/reference | `spec.on_move` |
| `on_cancel` | expression/reference | `spec.on_cancel` |
| `on_result` | expression/reference | `spec.on_result` |
| `on_close` | expression/reference | `spec.on_close` |
| `close_on_select` | expression/reference | `spec.close_on_select` |
| `lock_input` | expression/reference | `spec.lock_input ~= false and cfg.lock_input_by_default` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 2 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
