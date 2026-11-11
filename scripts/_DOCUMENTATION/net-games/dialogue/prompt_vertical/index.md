# 📄 `prompt_vertical.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/dialogue/prompt_vertical.lua`](../../../../net-games/dialogue/prompt_vertical.lua)  
> **Source lines:** 1201  
> **SHA-256 (UTF-8):** `53ae93803dd8c5cf714d02a43a2ce0e6aa91c65e59445883b8d1e2b1ee0653af`  
> **Named functions detected:** 46  
> **Table initializers detected:** 22

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
| 1 | `scripts/player-control/main` |
| 8 | `scripts/displayer/displayer` |
| 9 | `scripts/input/input` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 192 | `Net` | `tick` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 12 | `mdbg` | `pid, msg` | local |
| 33 | `merge_assets` | `overrides` | local |
| 46 | `play_cursor_move_sfx` | `player_id` | local |
| 59 | `ensure_backdrop_sprite` | `player_id` | local |
| 67 | `draw_backdrop` | `player_id, backdrop, z` | local |
| 96 | `erase_backdrop` | `player_id` | local |
| 101 | `get_text_width` | `text, font, scale` | local |
| 114 | `draw_text` | `inst, text, x, y, font, scale, z, id, tint` | local |
| 155 | `erase_text` | `inst, id` | local |
| 165 | `ensure_listener` | `(none)` | local |
| 171 | `set_input_locked` | `player_id, locked` | local |
| 179 | `mk_id` | `player_id` | local |
| 183 | `clamp` | `v, a, b` | local |
| 189 | `ensure_tick` | `(none)` | local |
| 204 | `provide_ui_assets` | `player_id, assets` | local |
| 215 | `alloc_ui_sprites` | `inst` | local |
| 239 | `draw_sprite` | `inst, sprite_id, draw_id, x, y, z, s, anim_state` | local |
| 255 | `draw_sprite_xy` | `inst, sprite_id, draw_id, x, y, z, sx, sy, anim_state` | local |
| 271 | `draw_menu_frame_overlay` | `inst, draw_id, x, y, z, s, anim_state, frame_cfg` | local |
| 298 | `erase_sprite` | `player_id, draw_id` | local |
| 303 | `normalize_ui` | `ui` | local |
| 331 | `normalize_layout` | `layout` | local |
| 400 | `PromptMenuInstance:new` | `player_id, opts` | assigned/declared |
| 489 | `PromptMenuInstance:render_textbox` | `(none)` | assigned/declared |
| 523 | `PromptMenuInstance:menu_origin` | `(none)` | assigned/declared |
| 536 | `PromptMenuInstance:start_close` | `reason, keep_textbox` | assigned/declared |
| 563 | `PromptMenuInstance:render_menu_window` | `(none)` | assigned/declared |
| 580 | `PromptMenuInstance:clear_menu_text` | `(none)` | assigned/declared |
| 587 | `PromptMenuInstance:update_scroll_for_selection` | `force` | assigned/declared |
| 605 | `set_textbox_indicator_enabled` | `player_id, box_id, enabled` | local |
| 612 | `PromptMenuInstance:menu_overlays_visible` | `(none)` | assigned/declared |
| 616 | `PromptMenuInstance:set_locked` | `locked` | assigned/declared |
| 633 | `PromptMenuInstance:update_cursor_bob` | `dt` | assigned/declared |
| 649 | `ease_out_quad` | `x` | local |
| 661 | `PromptMenuInstance:render_menu_contents` | `force` | assigned/declared |
| 869 | `PromptMenuInstance:start_text_intro` | `(none)` | assigned/declared |
| 883 | `PromptMenuInstance:become_ready` | `(none)` | assigned/declared |
| 911 | `PromptMenuInstance:select_current` | `(none)` | assigned/declared |
| 918 | `self._post_close_cb` | `(none)` | assigned/declared |
| 922 | `PromptMenuInstance:do_cancel` | `(none)` | assigned/declared |
| 928 | `self._post_close_cb` | `(none)` | assigned/declared |
| 943 | `PromptMenuInstance:restart_shop_item_intro` | `(none)` | assigned/declared |
| 949 | `PromptMenuInstance:update` | `_dt` | assigned/declared |
| 1134 | `PromptVertical.menu` | `player_id, opts` | assigned/declared |
| 1147 | `PromptVertical._finalize_close` | `player_id, _reason, opts` | assigned/declared |
| 1193 | `PromptVertical.close` | `player_id, _reason, opts` | assigned/declared |

### Parameter inventory

#### 1. `mdbg(pid, msg)`

- **Line:** 12
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `msg` | Declared directly in the current Lua. Type not inferred. |

#### 2. `merge_assets(overrides)`

- **Line:** 33
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `overrides` | Declared directly in the current Lua. Type not inferred. |

#### 3. `play_cursor_move_sfx(player_id)`

- **Line:** 46
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 4. `ensure_backdrop_sprite(player_id)`

- **Line:** 59
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 5. `draw_backdrop(player_id, backdrop, z)`

- **Line:** 67
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `backdrop` | Declared directly in the current Lua. Type not inferred. |
| 3 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 6. `erase_backdrop(player_id)`

- **Line:** 96
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 7. `get_text_width(text, font, scale)`

- **Line:** 101
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `text` | Declared directly in the current Lua. Type not inferred. |
| 2 | `font` | Declared directly in the current Lua. Type not inferred. |
| 3 | `scale` | Declared directly in the current Lua. Type not inferred. |

#### 8. `draw_text(inst, text, x, y, font, scale, z, id, tint)`

- **Line:** 114
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `inst` | Declared directly in the current Lua. Type not inferred. |
| 2 | `text` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `font` | Declared directly in the current Lua. Type not inferred. |
| 6 | `scale` | Declared directly in the current Lua. Type not inferred. |
| 7 | `z` | Declared directly in the current Lua. Type not inferred. |
| 8 | `id` | Declared directly in the current Lua. Type not inferred. |
| 9 | `tint` | Declared directly in the current Lua. Type not inferred. |

#### 9. `erase_text(inst, id)`

- **Line:** 155
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `inst` | Declared directly in the current Lua. Type not inferred. |
| 2 | `id` | Declared directly in the current Lua. Type not inferred. |

#### 10. `ensure_listener()`

- **Line:** 165
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 11. `set_input_locked(player_id, locked)`

- **Line:** 171
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `locked` | Declared directly in the current Lua. Type not inferred. |

#### 12. `mk_id(player_id)`

- **Line:** 179
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 13. `clamp(v, a, b)`

- **Line:** 183
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `v` | Declared directly in the current Lua. Type not inferred. |
| 2 | `a` | Declared directly in the current Lua. Type not inferred. |
| 3 | `b` | Declared directly in the current Lua. Type not inferred. |

#### 14. `ensure_tick()`

- **Line:** 189
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 15. `provide_ui_assets(player_id, assets)`

- **Line:** 204
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `assets` | Declared directly in the current Lua. Type not inferred. |

#### 16. `alloc_ui_sprites(inst)`

- **Line:** 215
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `inst` | Declared directly in the current Lua. Type not inferred. |

#### 17. `draw_sprite(inst, sprite_id, draw_id, x, y, z, s, anim_state)`

- **Line:** 239
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `inst` | Declared directly in the current Lua. Type not inferred. |
| 2 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `draw_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `x` | Declared directly in the current Lua. Type not inferred. |
| 5 | `y` | Declared directly in the current Lua. Type not inferred. |
| 6 | `z` | Declared directly in the current Lua. Type not inferred. |
| 7 | `s` | Declared directly in the current Lua. Type not inferred. |
| 8 | `anim_state` | Declared directly in the current Lua. Type not inferred. |

#### 18. `draw_sprite_xy(inst, sprite_id, draw_id, x, y, z, sx, sy, anim_state)`

- **Line:** 255
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `inst` | Declared directly in the current Lua. Type not inferred. |
| 2 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `draw_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `x` | Declared directly in the current Lua. Type not inferred. |
| 5 | `y` | Declared directly in the current Lua. Type not inferred. |
| 6 | `z` | Declared directly in the current Lua. Type not inferred. |
| 7 | `sx` | Declared directly in the current Lua. Type not inferred. |
| 8 | `sy` | Declared directly in the current Lua. Type not inferred. |
| 9 | `anim_state` | Declared directly in the current Lua. Type not inferred. |

#### 19. `draw_menu_frame_overlay(inst, draw_id, x, y, z, s, anim_state, frame_cfg)`

- **Line:** 271
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `inst` | Declared directly in the current Lua. Type not inferred. |
| 2 | `draw_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `z` | Declared directly in the current Lua. Type not inferred. |
| 6 | `s` | Declared directly in the current Lua. Type not inferred. |
| 7 | `anim_state` | Declared directly in the current Lua. Type not inferred. |
| 8 | `frame_cfg` | Declared directly in the current Lua. Type not inferred. |

#### 20. `erase_sprite(player_id, draw_id)`

- **Line:** 298
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `draw_id` | Declared directly in the current Lua. Type not inferred. |

#### 21. `normalize_ui(ui)`

- **Line:** 303
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ui` | Declared directly in the current Lua. Type not inferred. |

#### 22. `normalize_layout(layout)`

- **Line:** 331
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `layout` | Declared directly in the current Lua. Type not inferred. |

#### 23. `PromptMenuInstance:new(player_id, opts)`

- **Line:** 400
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 24. `PromptMenuInstance:render_textbox()`

- **Line:** 489
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 25. `PromptMenuInstance:menu_origin()`

- **Line:** 523
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 26. `PromptMenuInstance:start_close(reason, keep_textbox)`

- **Line:** 536
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `reason` | Declared directly in the current Lua. Type not inferred. |
| 2 | `keep_textbox` | Declared directly in the current Lua. Type not inferred. |

#### 27. `PromptMenuInstance:render_menu_window()`

- **Line:** 563
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 28. `PromptMenuInstance:clear_menu_text()`

- **Line:** 580
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 29. `PromptMenuInstance:update_scroll_for_selection(force)`

- **Line:** 587
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `force` | Declared directly in the current Lua. Type not inferred. |

#### 30. `set_textbox_indicator_enabled(player_id, box_id, enabled)`

- **Line:** 605
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `box_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `enabled` | Declared directly in the current Lua. Type not inferred. |

#### 31. `PromptMenuInstance:menu_overlays_visible()`

- **Line:** 612
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 32. `PromptMenuInstance:set_locked(locked)`

- **Line:** 616
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `locked` | Declared directly in the current Lua. Type not inferred. |

#### 33. `PromptMenuInstance:update_cursor_bob(dt)`

- **Line:** 633
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dt` | Declared directly in the current Lua. Type not inferred. |

#### 34. `ease_out_quad(x)`

- **Line:** 649
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `x` | Declared directly in the current Lua. Type not inferred. |

#### 35. `PromptMenuInstance:render_menu_contents(force)`

- **Line:** 661
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `force` | Declared directly in the current Lua. Type not inferred. |

#### 36. `PromptMenuInstance:start_text_intro()`

- **Line:** 869
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 37. `PromptMenuInstance:become_ready()`

- **Line:** 883
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 38. `PromptMenuInstance:select_current()`

- **Line:** 911
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 39. `self._post_close_cb()`

- **Line:** 918
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 40. `PromptMenuInstance:do_cancel()`

- **Line:** 922
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 41. `self._post_close_cb()`

- **Line:** 928
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 42. `PromptMenuInstance:restart_shop_item_intro()`

- **Line:** 943
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 43. `PromptMenuInstance:update(_dt)`

- **Line:** 949
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `_dt` | Declared directly in the current Lua. Type not inferred. |

#### 44. `PromptVertical.menu(player_id, opts)`

- **Line:** 1134
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 45. `PromptVertical._finalize_close(player_id, _reason, opts)`

- **Line:** 1147
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `_reason` | Declared directly in the current Lua. Type not inferred. |
| 3 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 46. `PromptVertical.close(player_id, _reason, opts)`

- **Line:** 1193
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `_reason` | Declared directly in the current Lua. Type not inferred. |
| 3 | `opts` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 17 | `PromptVertical` |
| 18 | `PromptVertical.instances` |
| 22 | `DEFAULT_ASSET` |
| 34 | `out` |
| 57 | `player_backdrop_sprite` |
| 118 | `opts` |
| 136 | `glyph_ids` |
| 243 | `opts` |
| 259 | `opts` |
| 281 | `opts` |
| 304 | `o` |
| 333 | `o` |
| 390 | `STATE` |
| 397 | `PromptMenuInstance` |
| 409 | `o.spr` |
| 447 | `o.draw` |
| 458 | `o.menu_text_ids` |
| 459 | `o.text_glyphs` |
| 491 | `text_options` |
| 584 | `self.menu_text_ids` |
| 774 | `self.menu_text_ids` |
| 900 | `held` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.on` | 1 | 192 |
| `Net.play_sound` | 1 | 51 |
| `Net.play_sound_for_player` | 1 | 49 |
| `Net.player_alloc_sprite` | 8 | 63 |
| `Net.player_draw_sprite` | 4 | 81 |
| `Net.player_erase_sprite` | 4 | 97 |
| `Net.provide_asset_for_player` | 10 | 47 |
