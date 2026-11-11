# 📄 `talk_vert_menu.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/talk_vert_menu.lua`](../../../../net-games/npcs/talk_vert_menu.lua)  
> **Source lines:** 410  
> **SHA-256 (UTF-8):** `ad91a7a6b4c1ae3a8c9537dafea632c3817b1763db5584353707ac64d0833a2e`  
> **Named functions detected:** 12  
> **Table initializers detected:** 6

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
| 7 | `scripts/net-games/npcs/talk` |
| 8 | `scripts/net-games/npcs/talk_presets` |
| 10 | `scripts/net-games/dialogue/dialogue` |
| 11 | `scripts/net-games/dialogue/prompt` |
| 12 | `scripts/net-games/dialogue/prompt_vertical` |
| 14 | `scripts/displayer/displayer` |
| 15 | `scripts/input/input` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 84 | `Net` | `tick` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 32 | `play_sfx` | `player_id, path` | local |
| 42 | `set_menu_locked` | `menu, locked` | local |
| 49 | `set_textbox_indicator` | `player_id, box_id, enabled` | local |
| 56 | `resolve_frame` | `frame_key_or_table` | local |
| 64 | `apply_default_layout_frame` | `talk_cfg, layout` | local |
| 80 | `ensure_tick` | `(none)` | local |
| 160 | `on_yes` | `(none)` | assigned/declared |
| 180 | `on_no` | `(none)` | assigned/declared |
| 280 | `TalkVertMenu.is_busy` | `player_id` | assigned/declared |
| 294 | `TalkVertMenu.open` | `player_id, bot_name, talk_cfg, menu_cfg` | assigned/declared |
| 337 | `on_choose` | `choice, index, menu` | assigned/declared |
| 362 | `do_post_text_then_ack` | `(none)` | local |

### Parameter inventory

#### 1. `play_sfx(player_id, path)`

- **Line:** 32
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `path` | Declared directly in the current Lua. Type not inferred. |

#### 2. `set_menu_locked(menu, locked)`

- **Line:** 42
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `menu` | Declared directly in the current Lua. Type not inferred. |
| 2 | `locked` | Declared directly in the current Lua. Type not inferred. |

#### 3. `set_textbox_indicator(player_id, box_id, enabled)`

- **Line:** 49
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `box_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `enabled` | Declared directly in the current Lua. Type not inferred. |

#### 4. `resolve_frame(frame_key_or_table)`

- **Line:** 56
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `frame_key_or_table` | Declared directly in the current Lua. Type not inferred. |

#### 5. `apply_default_layout_frame(talk_cfg, layout)`

- **Line:** 64
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `talk_cfg` | Declared directly in the current Lua. Type not inferred. |
| 2 | `layout` | Declared directly in the current Lua. Type not inferred. |

#### 6. `ensure_tick()`

- **Line:** 80
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 7. `on_yes()`

- **Line:** 160
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 8. `on_no()`

- **Line:** 180
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 9. `TalkVertMenu.is_busy(player_id)`

- **Line:** 280
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 10. `TalkVertMenu.open(player_id, bot_name, talk_cfg, menu_cfg)`

- **Line:** 294
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `bot_name` | Declared directly in the current Lua. Type not inferred. |
| 3 | `talk_cfg` | Declared directly in the current Lua. Type not inferred. |
| 4 | `menu_cfg` | Declared directly in the current Lua. Type not inferred. |

#### 11. `on_choose(choice, index, menu)`

- **Line:** 337
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `choice` | Declared directly in the current Lua. Type not inferred. |
| 2 | `index` | Declared directly in the current Lua. Type not inferred. |
| 3 | `menu` | Declared directly in the current Lua. Type not inferred. |

#### 12. `do_post_text_then_ack()`

- **Line:** 362
- **Declaration:** local
- **Parameters:** none explicitly declared.


## Tables

| Line | Identifier |
|---:|---|
| 17 | `TalkVertMenu` |
| 22 | `pending_ack` |
| 23 | `exit_pending` |
| 24 | `confirm_pending` |
| 25 | `goodbye_closing` |
| 69 | `layout.frame` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.on` | 1 | 84 |
| `Net.play_sound` | 1 | 38 |
| `Net.play_sound_for_player` | 1 | 36 |
| `Net.provide_asset_for_player` | 1 | 34 |
