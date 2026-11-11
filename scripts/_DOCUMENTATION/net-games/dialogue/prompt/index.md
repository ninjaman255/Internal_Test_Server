# 📄 `prompt.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/dialogue/prompt.lua`](../../../../net-games/dialogue/prompt.lua)  
> **Source lines:** 411  
> **SHA-256 (UTF-8):** `9f86a867144c6c1888691862fc944b66899831a951423b83d447402e008ffc4e`  
> **Named functions detected:** 22  
> **Table initializers detected:** 13

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
| 5 | `scripts/displayer/displayer` |
| 6 | `scripts/displayer/text-layout` |
| 7 | `scripts/displayer/text-display` |
| 8 | `scripts/input/input` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 352 | `Net` | `tick` |
| 398 | `Net` | `player_disconnect` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 22 | `has_asset` | `path` | local |
| 28 | `safe_provide` | `player_id, path` | local |
| 34 | `play_cursor_move_sfx` | `player_id` | local |
| 40 | `ensure_backdrop_asset` | `player_id` | local |
| 49 | `draw_backdrop` | `player_id, backdrop, z` | local |
| 67 | `erase_backdrop` | `player_id` | local |
| 71 | `ensure_cursor_asset` | `player_id` | local |
| 84 | `selector_draw` | `player_id, draw_id, virtual_x, virtual_y, z, scale` | local |
| 96 | `selector_erase` | `player_id, draw_id` | local |
| 100 | `normalize_ui` | `ui` | local |
| 129 | `build_prompt_text` | `question, ui` | local |
| 168 | `options_visible` | `player_id, box_id` | local |
| 177 | `find_option_virtual_positions` | `player_id, box_id, selection` | local |
| 198 | `set_input_locked` | `player_id, locked` | local |
| 203 | `mk_id` | `player_id` | local |
| 208 | `PromptInstance:new` | `player_id, opts` | assigned/declared |
| 231 | `PromptInstance:render_initial` | `(none)` | assigned/declared |
| 265 | `PromptInstance:render_cursor` | `(none)` | assigned/declared |
| 271 | `PromptInstance:update` | `dt` | assigned/declared |
| 349 | `ensure_tick` | `(none)` | local |
| 363 | `Prompt.yesno` | `player_id, opts` | assigned/declared |
| 376 | `Prompt.close` | `player_id, _reason, opts` | assigned/declared |

### Parameter inventory

#### 1. `has_asset(path)`

- **Line:** 22
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared directly in the current Lua. Type not inferred. |

#### 2. `safe_provide(player_id, path)`

- **Line:** 28
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `path` | Declared directly in the current Lua. Type not inferred. |

#### 3. `play_cursor_move_sfx(player_id)`

- **Line:** 34
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 4. `ensure_backdrop_asset(player_id)`

- **Line:** 40
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 5. `draw_backdrop(player_id, backdrop, z)`

- **Line:** 49
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `backdrop` | Declared directly in the current Lua. Type not inferred. |
| 3 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 6. `erase_backdrop(player_id)`

- **Line:** 67
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 7. `ensure_cursor_asset(player_id)`

- **Line:** 71
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 8. `selector_draw(player_id, draw_id, virtual_x, virtual_y, z, scale)`

- **Line:** 84
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `draw_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `virtual_x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `virtual_y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `z` | Declared directly in the current Lua. Type not inferred. |
| 6 | `scale` | Declared directly in the current Lua. Type not inferred. |

#### 9. `selector_erase(player_id, draw_id)`

- **Line:** 96
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `draw_id` | Declared directly in the current Lua. Type not inferred. |

#### 10. `normalize_ui(ui)`

- **Line:** 100
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ui` | Declared directly in the current Lua. Type not inferred. |

#### 11. `build_prompt_text(question, ui)`

- **Line:** 129
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `question` | Declared directly in the current Lua. Type not inferred. |
| 2 | `ui` | Declared directly in the current Lua. Type not inferred. |

#### 12. `options_visible(player_id, box_id)`

- **Line:** 168
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `box_id` | Declared directly in the current Lua. Type not inferred. |

#### 13. `find_option_virtual_positions(player_id, box_id, selection)`

- **Line:** 177
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `box_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `selection` | Declared directly in the current Lua. Type not inferred. |

#### 14. `set_input_locked(player_id, locked)`

- **Line:** 198
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `locked` | Declared directly in the current Lua. Type not inferred. |

#### 15. `mk_id(player_id)`

- **Line:** 203
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 16. `PromptInstance:new(player_id, opts)`

- **Line:** 208
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 17. `PromptInstance:render_initial()`

- **Line:** 231
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 18. `PromptInstance:render_cursor()`

- **Line:** 265
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 19. `PromptInstance:update(dt)`

- **Line:** 271
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dt` | Declared directly in the current Lua. Type not inferred. |

#### 20. `ensure_tick()`

- **Line:** 349
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 21. `Prompt.yesno(player_id, opts)`

- **Line:** 363
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 22. `Prompt.close(player_id, _reason, opts)`

- **Line:** 376
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `_reason` | Declared directly in the current Lua. Type not inferred. |
| 3 | `opts` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 10 | `Prompt` |
| 11 | `Prompt.instances` |
| 19 | `player_cursor_asset` |
| 20 | `player_backdrop_asset` |
| 102 | `o` |
| 137 | `qlines` |
| 143 | `pages` |
| 150 | `page` |
| 156 | `final` |
| 163 | `page_strings` |
| 205 | `PromptInstance` |
| 237 | `text_options` |
| 289 | `held` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.on` | 2 | 352 |
| `Net.player_alloc_sprite` | 2 | 44 |
| `Net.player_draw_sprite` | 2 | 52 |
| `Net.player_erase_sprite` | 2 | 68 |
