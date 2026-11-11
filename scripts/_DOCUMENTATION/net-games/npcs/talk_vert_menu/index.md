# 📄 `talk_vert_menu.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/talk_vert_menu.lua`](../../../../net-games/npcs/talk_vert_menu.lua)  
> **Source lines:** 410  
> **SHA-256 (UTF-8):** `affd50f15ead56…`  
> **Declared/assigned functions detected:** 12  
> **Anonymous closures detected:** 7  
> **Table initializers detected:** 6

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

Talk-mode wrapper for PromptVertical

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 6 | `scripts/net-games/npcs/talk` |
| 7 | `scripts/net-games/npcs/talk_presets` |
| 9 | `scripts/net-games/dialogue/dialogue` |
| 10 | `scripts/net-games/dialogue/prompt` |
| 11 | `scripts/net-games/dialogue/prompt_vertical` |
| 13 | `scripts/displayer/displayer` |
| 14 | `scripts/input/input` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 83 | `Net:on` | `tick` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 31 | `play_sfx` | `player_id, path` | local |
| 41 | `set_menu_locked` | `menu, locked` | local |
| 48 | `set_textbox_indicator` | `player_id, box_id, enabled` | local |
| 55 | `resolve_frame` | `frame_key_or_table` | local |
| 63 | `apply_default_layout_frame` | `talk_cfg, layout` | local |
| 79 | `ensure_tick` | `(none)` | local |
| 159 | `on_yes` | `(none)` | assigned |
| 179 | `on_no` | `(none)` | assigned |
| 279 | `TalkVertMenu.is_busy` | `player_id` | declared |
| 293 | `TalkVertMenu.open` | `player_id, bot_name, talk_cfg, menu_cfg` | declared |
| 336 | `on_choose` | `choice, index, menu` | assigned |
| 361 | `do_post_text_then_ack` | `(none)` | local |

### Function details

#### 1. `play_sfx(player_id, path)`

- **Location:** source line 31.
- **Declaration style:** `local`.
- **Adjacent source comment:** Small helpers

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `path` | Not explicitly documented in adjacent source annotations. |

#### 2. `set_menu_locked(menu, locked)`

- **Location:** source line 41.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `menu` | Not explicitly documented in adjacent source annotations. |
| 2 | `locked` | Not explicitly documented in adjacent source annotations. |

#### 3. `set_textbox_indicator(player_id, box_id, enabled)`

- **Location:** source line 48.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `box_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `enabled` | Not explicitly documented in adjacent source annotations. |

#### 4. `resolve_frame(frame_key_or_table)`

- **Location:** source line 55.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `frame_key_or_table` | Not explicitly documented in adjacent source annotations. |

#### 5. `apply_default_layout_frame(talk_cfg, layout)`

- **Location:** source line 63.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `talk_cfg` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout` | Not explicitly documented in adjacent source annotations. |

#### 6. `ensure_tick()`

- **Location:** source line 79.
- **Declaration style:** `local`.
- **Adjacent source comment:** Tick loop

#### 7. `on_yes()`

- **Location:** source line 159.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 8. `on_no()`

- **Location:** source line 179.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 9. `TalkVertMenu.is_busy(player_id)`

- **Location:** source line 279.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Busy guard

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 10. `TalkVertMenu.open(player_id, bot_name, talk_cfg, menu_cfg)`

- **Location:** source line 293.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Public API

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `bot_name` | Not explicitly documented in adjacent source annotations. |
| 3 | `talk_cfg` | Not explicitly documented in adjacent source annotations. |
| 4 | `menu_cfg` | Not explicitly documented in adjacent source annotations. |

#### 11. `on_choose(choice, index, menu)`

- **Location:** source line 336.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `choice` | Not explicitly documented in adjacent source annotations. |
| 2 | `index` | Not explicitly documented in adjacent source annotations. |
| 3 | `menu` | Not explicitly documented in adjacent source annotations. |

#### 12. `do_post_text_then_ack()`

- **Location:** source line 361.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 35 | `(none)` | `.provide_asset_for_player(player_id, path) if Net.play_sound_for_player then pcall(` |
| 37 | `(none)` | `) Net.play_sound_for_player(player_id, path) end) elseif Net.play_sound then pcall(` |
| 83 | `(none)` | `nsure_tick() if TICK_ATTACHED then return end TICK_ATTACHED = true Net:on("tick",` |
| 89 | `(none)` | `local box_id = g.box_id if Net.lock_player_input then pcall(` |
| 98 | `(none)` | `ing[player_id] = nil if Net.unlock_player_input then pcall(` |
| 183 | `(none)` | `lose) if Net.lock_player_input then pcall(` |
| 223 | `(none)` | `= nil else if Net.lock_player_input then pcall(` |

## 📦 Tables and data

The following **6** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `TalkVertMenu` — line 16

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `pending_ack` — line 21

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `exit_pending` — line 22

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `confirm_pending` — line 23

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `goodbye_closing` — line 24

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `layout.frame` — line 68

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `f.r` |
| `g` | expression/reference | `f.g` |
| `b` | expression/reference | `f.b` |
| `a` | expression/reference | `f.a` |
| `color_mode` | expression/reference | `f.color_mode` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.lock_player_input` | 3 |
| `Net.on` | 1 |
| `Net.play_sound` | 1 |
| `Net.play_sound_for_player` | 1 |
| `Net.provide_asset_for_player` | 1 |
| `Net.unlock_player_input` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
