# 📄 `dialogue.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/dialogue/dialogue.lua`](../../../../net-games/dialogue/dialogue.lua)  
> **Source lines:** 331  
> **SHA-256 (UTF-8):** `40349ec0839a188a19bf55a4f9c28e8d1f9c4d26578900b05a834758b2421933`  
> **Named functions detected:** 17  
> **Table initializers detected:** 7

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
| 8 | `scripts/net-games/main` |
| 10 | `scripts/displayer/displayer` |
| 11 | `scripts/displayer/text-display` |
| 12 | `scripts/input/input` |
| 13 | `scripts/net-games/dialogue/constants` |
| 14 | `scripts/net-games/dialogue/prompt` |
| 15 | `scripts/net-games/dialogue/prompt_vertical` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 162 | `Net` | `tick` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 25 | `ensure_backdrop_sprite` | `player_id` | local |
| 38 | `draw_backdrop` | `player_id, backdrop, z` | local |
| 59 | `erase_backdrop` | `player_id` | local |
| 63 | `set_input_locked` | `player_id, locked` | local |
| 73 | `ensure_listener` | `(none)` | local |
| 81 | `default_opts` | `(none)` | local |
| 97 | `merge` | `a, b` | local |
| 102 | `mk_box_id` | `player_id, ui` | local |
| 106 | `gate_handoff_input` | `player_id, seconds` | local |
| 112 | `close_instance` | `player_id, reason` | local |
| 137 | `finish_instance` | `player_id, inst` | local |
| 158 | `attach_tick` | `(none)` | local |
| 206 | `Dialogue.is_active` | `player_id` | assigned/declared |
| 210 | `Dialogue.prompt_yesno` | `player_id, opts` | assigned/declared |
| 214 | `Dialogue.prompt_menu` | `player_id, opts` | assigned/declared |
| 218 | `Dialogue.start` | `player_id, script, opts` | assigned/declared |
| 327 | `Dialogue.close` | `player_id` | assigned/declared |

### Parameter inventory

#### 1. `ensure_backdrop_sprite(player_id)`

- **Line:** 25
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 2. `draw_backdrop(player_id, backdrop, z)`

- **Line:** 38
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `backdrop` | Declared directly in the current Lua. Type not inferred. |
| 3 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 3. `erase_backdrop(player_id)`

- **Line:** 59
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 4. `set_input_locked(player_id, locked)`

- **Line:** 63
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `locked` | Declared directly in the current Lua. Type not inferred. |

#### 5. `ensure_listener()`

- **Line:** 73
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 6. `default_opts()`

- **Line:** 81
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 7. `merge(a, b)`

- **Line:** 97
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `a` | Declared directly in the current Lua. Type not inferred. |
| 2 | `b` | Declared directly in the current Lua. Type not inferred. |

#### 8. `mk_box_id(player_id, ui)`

- **Line:** 102
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `ui` | Declared directly in the current Lua. Type not inferred. |

#### 9. `gate_handoff_input(player_id, seconds)`

- **Line:** 106
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `seconds` | Declared directly in the current Lua. Type not inferred. |

#### 10. `close_instance(player_id, reason)`

- **Line:** 112
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `reason` | Declared directly in the current Lua. Type not inferred. |

#### 11. `finish_instance(player_id, inst)`

- **Line:** 137
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `inst` | Declared directly in the current Lua. Type not inferred. |

#### 12. `attach_tick()`

- **Line:** 158
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 13. `Dialogue.is_active(player_id)`

- **Line:** 206
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 14. `Dialogue.prompt_yesno(player_id, opts)`

- **Line:** 210
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 15. `Dialogue.prompt_menu(player_id, opts)`

- **Line:** 214
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 16. `Dialogue.start(player_id, script, opts)`

- **Line:** 218
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `script` | Declared directly in the current Lua. Type not inferred. |
| 3 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 17. `Dialogue.close(player_id)`

- **Line:** 327
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 17 | `Dialogue` |
| 18 | `Dialogue.instances` |
| 23 | `player_backdrop_sprite` |
| 257 | `pages` |
| 259 | `pages` |
| 265 | `pages` |
| 276 | `text_options` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.on` | 1 | 162 |
| `Net.player_alloc_sprite` | 1 | 33 |
| `Net.player_draw_sprite` | 1 | 42 |
| `Net.player_erase_sprite` | 1 | 60 |
| `Net.provide_asset_for_player` | 1 | 31 |
