# 📄 `prompt_vertical.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/dialogue/prompt_vertical.lua`](../../../../net-games/dialogue/prompt_vertical.lua)  
> **Source lines:** 1201  
> **SHA-256 (UTF-8):** `3bfe625d59e037…`  
> **Declared/assigned functions detected:** 46  
> **Anonymous closures detected:** 6  
> **Table initializers detected:** 22

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

Vertical menu prompt helper for net-games Dialogue (adapted to new displayer) NOTE: This version preserves the original logic but marks areas where the new displayer no longer exposes internal fields (pages, current_page, backdrop indicator). These parts will need to be reimplemented using the available APIs.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 7 | `scripts/displayer/displayer` |
| 8 | `scripts/input/input` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 191 | `Net:on` | `tick` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 11 | `mdbg` | `pid, msg` | local |
| 32 | `merge_assets` | `overrides` | local |
| 45 | `play_cursor_move_sfx` | `player_id` | local |
| 58 | `ensure_backdrop_sprite` | `player_id` | local |
| 66 | `draw_backdrop` | `player_id, backdrop, z` | local |
| 95 | `erase_backdrop` | `player_id` | local |
| 100 | `get_text_width` | `text, font, scale` | local |
| 113 | `draw_text` | `inst, text, x, y, font, scale, z, id, tint` | local |
| 154 | `erase_text` | `inst, id` | local |
| 164 | `ensure_listener` | `(none)` | local |
| 170 | `set_input_locked` | `player_id, locked` | local |
| 178 | `mk_id` | `player_id` | local |
| 182 | `clamp` | `v, a, b` | local |
| 188 | `ensure_tick` | `(none)` | local |
| 203 | `provide_ui_assets` | `player_id, assets` | local |
| 214 | `alloc_ui_sprites` | `inst` | local |
| 238 | `draw_sprite` | `inst, sprite_id, draw_id, x, y, z, s, anim_state` | local |
| 254 | `draw_sprite_xy` | `inst, sprite_id, draw_id, x, y, z, sx, sy, anim_state` | local |
| 270 | `draw_menu_frame_overlay` | `inst, draw_id, x, y, z, s, anim_state, frame_cfg` | local |
| 297 | `erase_sprite` | `player_id, draw_id` | local |
| 302 | `normalize_ui` | `ui` | local |
| 330 | `normalize_layout` | `layout` | local |
| 399 | `PromptMenuInstance:new` | `player_id, opts` | declared |
| 488 | `PromptMenuInstance:render_textbox` | `(none)` | declared |
| 522 | `PromptMenuInstance:menu_origin` | `(none)` | declared |
| 535 | `PromptMenuInstance:start_close` | `reason, keep_textbox` | declared |
| 562 | `PromptMenuInstance:render_menu_window` | `(none)` | declared |
| 579 | `PromptMenuInstance:clear_menu_text` | `(none)` | declared |
| 586 | `PromptMenuInstance:update_scroll_for_selection` | `force` | declared |
| 604 | `set_textbox_indicator_enabled` | `player_id, box_id, enabled` | local |
| 611 | `PromptMenuInstance:menu_overlays_visible` | `(none)` | declared |
| 615 | `PromptMenuInstance:set_locked` | `locked` | declared |
| 632 | `PromptMenuInstance:update_cursor_bob` | `dt` | declared |
| 648 | `ease_out_quad` | `x` | local |
| 660 | `PromptMenuInstance:render_menu_contents` | `force` | declared |
| 868 | `PromptMenuInstance:start_text_intro` | `(none)` | declared |
| 882 | `PromptMenuInstance:become_ready` | `(none)` | declared |
| 910 | `PromptMenuInstance:select_current` | `(none)` | declared |
| 917 | `self._post_close_cb` | `(none)` | assigned |
| 921 | `PromptMenuInstance:do_cancel` | `(none)` | declared |
| 927 | `self._post_close_cb` | `(none)` | assigned |
| 942 | `PromptMenuInstance:restart_shop_item_intro` | `(none)` | declared |
| 948 | `PromptMenuInstance:update` | `_dt` | declared |
| 1133 | `PromptVertical.menu` | `player_id, opts` | declared |
| 1146 | `PromptVertical._finalize_close` | `player_id, _reason, opts` | declared |
| 1192 | `PromptVertical.close` | `player_id, _reason, opts` | declared |

### Function details

#### 1. `mdbg(pid, msg)`

- **Location:** source line 11.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `msg` | Not explicitly documented in adjacent source annotations. |

#### 2. `merge_assets(overrides)`

- **Location:** source line 32.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `overrides` | Not explicitly documented in adjacent source annotations. |

#### 3. `play_cursor_move_sfx(player_id)`

- **Location:** source line 45.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 4. `ensure_backdrop_sprite(player_id)`

- **Location:** source line 58.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 5. `draw_backdrop(player_id, backdrop, z)`

- **Location:** source line 66.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `backdrop` | Not explicitly documented in adjacent source annotations. |
| 3 | `z` | Not explicitly documented in adjacent source annotations. |

#### 6. `erase_backdrop(player_id)`

- **Location:** source line 95.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 7. `get_text_width(text, font, scale)`

- **Location:** source line 100.
- **Declaration style:** `local`.
- **Adjacent source comment:** Text drawing helpers using Displayer.Font

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |
| 2 | `font` | Not explicitly documented in adjacent source annotations. |
| 3 | `scale` | Not explicitly documented in adjacent source annotations. |

#### 8. `draw_text(inst, text, x, y, font, scale, z, id, tint)`

- **Location:** source line 113.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `inst` | Not explicitly documented in adjacent source annotations. |
| 2 | `text` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `font` | Not explicitly documented in adjacent source annotations. |
| 6 | `scale` | Not explicitly documented in adjacent source annotations. |
| 7 | `z` | Not explicitly documented in adjacent source annotations. |
| 8 | `id` | Not explicitly documented in adjacent source annotations. |
| 9 | `tint` | Not explicitly documented in adjacent source annotations. |

#### 9. `erase_text(inst, id)`

- **Location:** source line 154.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `inst` | Not explicitly documented in adjacent source annotations. |
| 2 | `id` | Not explicitly documented in adjacent source annotations. |

#### 10. `ensure_listener()`

- **Location:** source line 164.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 11. `set_input_locked(player_id, locked)`

- **Location:** source line 170.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `locked` | Not explicitly documented in adjacent source annotations. |

#### 12. `mk_id(player_id)`

- **Location:** source line 178.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 13. `clamp(v, a, b)`

- **Location:** source line 182.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `v` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |

#### 14. `ensure_tick()`

- **Location:** source line 188.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 15. `provide_ui_assets(player_id, assets)`

- **Location:** source line 203.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `assets` | Not explicitly documented in adjacent source annotations. |

#### 16. `alloc_ui_sprites(inst)`

- **Location:** source line 214.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `inst` | Not explicitly documented in adjacent source annotations. |

#### 17. `draw_sprite(inst, sprite_id, draw_id, x, y, z, s, anim_state)`

- **Location:** source line 238.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `inst` | Not explicitly documented in adjacent source annotations. |
| 2 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `draw_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `z` | Not explicitly documented in adjacent source annotations. |
| 7 | `s` | Not explicitly documented in adjacent source annotations. |
| 8 | `anim_state` | Not explicitly documented in adjacent source annotations. |

#### 18. `draw_sprite_xy(inst, sprite_id, draw_id, x, y, z, sx, sy, anim_state)`

- **Location:** source line 254.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `inst` | Not explicitly documented in adjacent source annotations. |
| 2 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `draw_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `z` | Not explicitly documented in adjacent source annotations. |
| 7 | `sx` | Not explicitly documented in adjacent source annotations. |
| 8 | `sy` | Not explicitly documented in adjacent source annotations. |
| 9 | `anim_state` | Not explicitly documented in adjacent source annotations. |

#### 19. `draw_menu_frame_overlay(inst, draw_id, x, y, z, s, anim_state, frame_cfg)`

- **Location:** source line 270.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `inst` | Not explicitly documented in adjacent source annotations. |
| 2 | `draw_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `z` | Not explicitly documented in adjacent source annotations. |
| 6 | `s` | Not explicitly documented in adjacent source annotations. |
| 7 | `anim_state` | Not explicitly documented in adjacent source annotations. |
| 8 | `frame_cfg` | Not explicitly documented in adjacent source annotations. |

#### 20. `erase_sprite(player_id, draw_id)`

- **Location:** source line 297.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `draw_id` | Not explicitly documented in adjacent source annotations. |

#### 21. `normalize_ui(ui)`

- **Location:** source line 302.
- **Declaration style:** `local`.
- **Adjacent source comment:** Layout normalization

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `ui` | Not explicitly documented in adjacent source annotations. |

#### 22. `normalize_layout(layout)`

- **Location:** source line 330.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `layout` | Not explicitly documented in adjacent source annotations. |

#### 23. `PromptMenuInstance:new(player_id, opts)`

- **Location:** source line 399.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 24. `PromptMenuInstance:render_textbox()`

- **Location:** source line 488.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 25. `PromptMenuInstance:menu_origin()`

- **Location:** source line 522.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 26. `PromptMenuInstance:start_close(reason, keep_textbox)`

- **Location:** source line 535.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `reason` | Not explicitly documented in adjacent source annotations. |
| 2 | `keep_textbox` | Not explicitly documented in adjacent source annotations. |

#### 27. `PromptMenuInstance:render_menu_window()`

- **Location:** source line 562.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 28. `PromptMenuInstance:clear_menu_text()`

- **Location:** source line 579.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 29. `PromptMenuInstance:update_scroll_for_selection(force)`

- **Location:** source line 586.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `force` | Not explicitly documented in adjacent source annotations. |

#### 30. `set_textbox_indicator_enabled(player_id, box_id, enabled)`

- **Location:** source line 604.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `box_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `enabled` | Not explicitly documented in adjacent source annotations. |

#### 31. `PromptMenuInstance:menu_overlays_visible()`

- **Location:** source line 611.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 32. `PromptMenuInstance:set_locked(locked)`

- **Location:** source line 615.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `locked` | Not explicitly documented in adjacent source annotations. |

#### 33. `PromptMenuInstance:update_cursor_bob(dt)`

- **Location:** source line 632.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `dt` | Not explicitly documented in adjacent source annotations. |

#### 34. `ease_out_quad(x)`

- **Location:** source line 648.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |

#### 35. `PromptMenuInstance:render_menu_contents(force)`

- **Location:** source line 660.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `force` | Not explicitly documented in adjacent source annotations. |

#### 36. `PromptMenuInstance:start_text_intro()`

- **Location:** source line 868.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 37. `PromptMenuInstance:become_ready()`

- **Location:** source line 882.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 38. `PromptMenuInstance:select_current()`

- **Location:** source line 910.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 39. `self._post_close_cb()`

- **Location:** source line 917.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 40. `PromptMenuInstance:do_cancel()`

- **Location:** source line 921.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 41. `self._post_close_cb()`

- **Location:** source line 927.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 42. `PromptMenuInstance:restart_shop_item_intro()`

- **Location:** source line 942.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 43. `PromptMenuInstance:update(_dt)`

- **Location:** source line 948.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `_dt` | Not explicitly documented in adjacent source annotations. |

#### 44. `PromptVertical.menu(player_id, opts)`

- **Location:** source line 1133.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Public API

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 45. `PromptVertical._finalize_close(player_id, _reason, opts)`

- **Location:** source line 1146.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `_reason` | Not explicitly documented in adjacent source annotations. |
| 3 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 46. `PromptVertical.close(player_id, _reason, opts)`

- **Location:** source line 1192.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `_reason` | Not explicitly documented in adjacent source annotations. |
| 3 | `opts` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 48 | `(none)` | `or_player(player_id, CURSOR_MOVE_SFX_PATH) if Net.play_sound_for_player then pcall(` |
| 50 | `(none)` | `_for_player(player_id, CURSOR_MOVE_SFX_PATH) end) elseif Net.play_sound then pcall(` |
| 191 | `event` | `cal._tick_attached then return end PromptVertical._tick_attached = true Net:on("tick…` |
| 435 | `_choice, _index` | `o.reuse_existing_box = (opts.reuse_existing_box == true) o.on_select = opts.on_selec…` |
| 436 | `(none)` | `n_select = opts.on_select or function(_choice, _index) end o.on_cancel = opts.on_can…` |
| 914 | `(none)` | `election_behavior == "callback_only" and type(self.on_choose) == "function" then pca…` |

## 📦 Tables and data

The following **22** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `PromptVertical` — line 16

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `PromptVertical.instances` — line 17

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `DEFAULT_ASSET` — line 21

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `menu_bg` | string literal | `"/server/assets/net-games/ui/prompt_vert_menu_an.png"` |
| `menu_bg_anim` | string literal | `"/server/assets/net-games/ui/prompt_vert_menu_an.animation"` |
| `menu_bg_frame` | string literal | `"/server/assets/net-games/ui/prompt_vert_menu_an_frame.png"` |
| `highlight` | string literal | `"/server/assets/net-games/ui/highlight_default.png"` |
| `cursor` | string literal | `"/server/assets/net-games/cursors/green_cursor.png"` |
| `scrollbar` | string literal | `"/server/assets/net-games/ui/scrollbar.png"` |
| `shop_item` | string literal | `"/server/assets/net-games/ui/card_shop_item.png"` |
| `shop_exit` | string literal | `"/server/assets/net-games/ui/card_shop_exit.png"` |

### 4. `out` — line 33

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `player_backdrop_sprite` — line 56

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `opts` — line 117

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `scale` | expression/reference | `scale` |
| `z` | expression/reference | `z` |
| `r` | expression/reference | `tint and tint.r or 255` |
| `g` | expression/reference | `tint and tint.g or 255` |
| `b` | expression/reference | `tint and tint.b or 255` |
| `opacity` | expression/reference | `tint and tint.opacity or 255` |
| `a` | expression/reference | `tint and tint.a or 255` |
| `ro` | numeric literal | `0` |
| `color_mode` | numeric literal | `0` |

### 7. `glyph_ids` — line 135

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `opts` — line 242

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `id` | expression/reference | `draw_id` |
| `x` | expression/reference | `x` |
| `y` | expression/reference | `y` |
| `z` | expression/reference | `z` |
| `sx` | expression/reference | `s or 2.0` |
| `sy` | expression/reference | `s or 2.0` |

### 9. `opts` — line 258

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `id` | expression/reference | `draw_id` |
| `x` | expression/reference | `x` |
| `y` | expression/reference | `y` |
| `z` | expression/reference | `z` |
| `sx` | expression/reference | `sx or 2.0` |
| `sy` | expression/reference | `sy or 2.0` |

### 10. `opts` — line 280

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `id` | expression/reference | `draw_id` |
| `x` | expression/reference | `x` |
| `y` | expression/reference | `y` |
| `z` | expression/reference | `z` |
| `sx` | expression/reference | `s or 2.0` |
| `sy` | expression/reference | `s or 2.0` |
| `r` | expression/reference | `tonumber(frame_cfg.r) or 255` |
| `g` | expression/reference | `tonumber(frame_cfg.g) or 255` |
| `b` | expression/reference | `tonumber(frame_cfg.b) or 255` |
| `a` | expression/reference | `a` |
| `color_mode` | expression/reference | `tonumber(frame_cfg.color_mode) or 2` |

### 11. `o` — line 303

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `box_id` | expression/reference | `ui.box_id` |
| `font` | expression/reference | `ui.font or "THIN_BLACK"` |
| `scale` | expression/reference | `ui.scale or 2.0` |
| `z` | expression/reference | `ui.z or 100` |
| `x` | expression/reference | `ui.x or 8` |
| `y` | expression/reference | `ui.y or 110` |
| `w` | expression/reference | `ui.w or 224` |
| `h` | expression/reference | `ui.h or 42` |
| `backdrop` | expression/reference | `ui.backdrop or ui.backdrop_config or nil` |
| `mugshot` | expression/reference | `ui.mugshot or nil` |
| `nameplate` | expression/reference | `ui.nameplate` |
| `typing_speed` | expression/reference | `ui.typing_speed or 12` |
| `type_sfx_path` | expression/reference | `ui.type_sfx_path` |
| `type_sfx_min_dt` | expression/reference | `ui.type_sfx_min_dt` |

### 12. `o` — line 332

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `anchor` | expression/reference | `layout.anchor or "textbox"` |
| `x` | expression/reference | `layout.x` |
| `y` | expression/reference | `layout.y` |
| `offset_x` | expression/reference | `layout.offset_x or 0` |
| `offset_y` | expression/reference | `layout.offset_y or -200` |
| `gap` | expression/reference | `layout.gap or 4` |
| `width` | expression/reference | `layout.width or 160` |
| `height` | expression/reference | `layout.height or 64` |
| `font` | expression/reference | `layout.font or "THIN_BLACK"` |
| `scale` | expression/reference | `layout.scale or 2.0` |
| `z` | expression/reference | `layout.z or 130` |
| `frame` | expression/reference | `layout.frame` |
| `padding_x` | expression/reference | `layout.padding_x or 12` |
| `padding_y` | expression/reference | `layout.padding_y or 10` |
| `row_height` | expression/reference | `layout.row_height or 12` |
| `visible_rows` | expression/reference | `tonumber(layout.visible_rows or 5) or 5` |
| `cursor_offset_x` | expression/reference | `layout.cursor_offset_x or 6` |
| `cursor_offset_y` | expression/reference | `layout.cursor_offset_y or 1` |
| `highlight_inset_x` | expression/reference | `layout.highlight_inset_x or 8` |
| `highlight_inset_y` | expression/reference | `layout.highlight_inset_y or 0` |
| `scrollbar_x` | expression/reference | `layout.scrollbar_x or 148` |
| `scrollbar_y` | expression/reference | `layout.scrollbar_y or 12` |
| `scrollbar_h` | expression/reference | `layout.scrollbar_h or 40` |
| `thumb_min_h` | expression/reference | `layout.thumb_min_h or 6` |
| `thumb_w` | expression/reference | `layout.thumb_w or 6` |
| `text_intro_enabled` | expression/reference | `(layout.text_intro_enabled == true)` |
| `text_intro_frames` | expression/reference | `tonumber(layout.text_intro_frames or 20) or 20` |
| `text_intro_stagger_frames` | expression/reference | `tonumber(layout.text_intro_stagger_frames or 3) or 3` |
| `text_intro_slide_px` | expression/reference | `tonumber(layout.text_intro_slide_px or 10) or 10` |
| `monies_label_enabled` | expression/reference | `(layout.monies_label_enabled == true)` |
| `monies_label_text` | expression/reference | `layout.monies_label_text` |
| `monies_label_font` | expression/reference | `layout.monies_label_font` |
| `monies_label_pad_x` | expression/reference | `layout.monies_label_pad_x` |
| `monies_label_pad_y` | expression/reference | `layout.monies_label_pad_y` |
| `monies_label_z_add` | expression/reference | `layout.monies_label_z_add` |
| `monies_amount_enabled` | expression/reference | `(layout.monies_amount_enabled == true)` |
| `monies_amount_text` | expression/reference | `layout.monies_amount_text` |
| `monies_amount_font` | expression/reference | `layout.monies_amount_font` |
| `monies_amount_offset_x` | expression/reference | `layout.monies_amount_offset_x` |
| `monies_amount_offset_y` | expression/reference | `layout.monies_amount_offset_y` |
| `shop_item_enabled` | expression/reference | `(layout.shop_item_enabled == true)` |
| `shop_item_pad_x` | expression/reference | `layout.shop_item_pad_x` |
| `shop_item_pad_y` | expression/reference | `layout.shop_item_pad_y` |
| `shop_item_z_add` | expression/reference | `layout.shop_item_z_add` |
| `shop_item_swap_exit` | expression/reference | `(layout.shop_item_swap_exit == true)` |
| `shop_item_intro_enabled` | expression/reference | `(layout.shop_item_intro_enabled == true)` |
| `shop_item_intro_frames` | expression/reference | `tonumber(layout.shop_item_intro_frames or 10) or 10` |
| `shop_item_w` | expression/reference | `tonumber(layout.shop_item_w or 0) or 0` |
| `shop_item_h` | expression/reference | `tonumber(layout.shop_item_h or 0) or 0` |
| `shop_exit_w` | expression/reference | `tonumber(layout.shop_exit_w or 0) or 0` |
| `shop_exit_h` | expression/reference | `tonumber(layout.shop_exit_h or 0) or 0` |

### 13. `STATE` — line 389

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `TEXT` | string literal | `"text"` |
| `MENU` | string literal | `"menu"` |
| `SUBPROMPT` | string literal | `"subprompt"` |
| `CLOSING` | string literal | `"closing"` |

### 14. `PromptMenuInstance` — line 396

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 15. `o.spr` — line 408

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `MENU_BG` | string literal | `"pv_" .. base .. "_spr_menu_bg"` |
| `MENU_FRAME` | string literal | `"pv_" .. base .. "_spr_menu_frame"` |
| `HILITE` | string literal | `"pv_" .. base .. "_spr_hilite"` |
| `CURSOR` | string literal | `"pv_" .. base .. "_spr_cursor"` |
| `SCROLL` | string literal | `"pv_" .. base .. "_spr_scroll"` |
| `SHOP_ITEM` | string literal | `"pv_" .. base .. "_spr_shop_item"` |
| `SHOP_EXIT` | string literal | `"pv_" .. base .. "_spr_shop_exit"` |

### 16. `o.draw` — line 446

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `menu_bg` | expression/reference | `base .. "_menu_bg"` |
| `menu_frame` | expression/reference | `base .. "_menu_frame"` |
| `hilite` | expression/reference | `base .. "_menu_hilite"` |
| `cursor` | expression/reference | `base .. "_menu_cursor"` |
| `scroll` | expression/reference | `base .. "_menu_scroll"` |
| `monies` | expression/reference | `base .. "_menu_monies"` |
| `monies_amount` | expression/reference | `base .. "_menu_monies_amount"` |
| `shop_item` | expression/reference | `base .. "_menu_shop_item"` |
| `shop_exit` | expression/reference | `base .. "_menu_shop_exit"` |

### 17. `o.menu_text_ids` — line 457

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 18. `o.text_glyphs` — line 458

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 19. `text_options` — line 490

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | expression/reference | `ui.font` |
| `scale` | expression/reference | `ui.scale` |
| `z` | expression/reference | `ui.z` |
| `speed` | expression/reference | `ui.typing_speed` |
| `type_sound` | expression/reference | `ui.type_sfx_path` |
| `type_sound_min_dt` | expression/reference | `ui.type_sfx_min_dt` |

### 20. `self.menu_text_ids` — line 583

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 21. `self.menu_text_ids` — line 773

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 22. `held` — line 899

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 1 |
| `Net.play_sound` | 1 |
| `Net.play_sound_for_player` | 1 |
| `Net.player_alloc_sprite` | 8 |
| `Net.player_draw_sprite` | 4 |
| `Net.player_erase_sprite` | 4 |
| `Net.provide_asset_for_player` | 10 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
