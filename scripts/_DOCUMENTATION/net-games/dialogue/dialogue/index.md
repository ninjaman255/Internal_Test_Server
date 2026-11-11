# 📄 `dialogue.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/dialogue/dialogue.lua`](../../../../net-games/dialogue/dialogue.lua)  
> **Source lines:** 331  
> **SHA-256 (UTF-8):** `6489da0b43083d…`  
> **Declared/assigned functions detected:** 17  
> **Anonymous closures detected:** 1  
> **Table initializers detected:** 8

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

Hardened net-games dialogue lifecycle. Keeps the creator-side Displayer architecture while preserving production behavior learned from shadis_hp: held-input handoff protection, real visual teardown before unlock/on_complete, BN-style A/B behavior, and textbox reuse.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 7 | `scripts/net-games/main` |
| 9 | `scripts/displayer/displayer` |
| 10 | `scripts/displayer/text-display` |
| 11 | `scripts/input/input` |
| 12 | `scripts/net-games/dialogue/constants` |
| 13 | `scripts/net-games/dialogue/prompt` |
| 14 | `scripts/net-games/dialogue/prompt_vertical` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 161 | `Net:on` | `tick` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 24 | `ensure_backdrop_sprite` | `player_id` | local |
| 37 | `draw_backdrop` | `player_id, backdrop, z` | local |
| 58 | `erase_backdrop` | `player_id` | local |
| 62 | `set_input_locked` | `player_id, locked` | local |
| 72 | `ensure_listener` | `(none)` | local |
| 80 | `default_opts` | `(none)` | local |
| 96 | `merge` | `a, b` | local |
| 101 | `mk_box_id` | `player_id, ui` | local |
| 105 | `gate_handoff_input` | `player_id, seconds` | local |
| 111 | `close_instance` | `player_id, reason` | local |
| 136 | `finish_instance` | `player_id, inst` | local |
| 157 | `attach_tick` | `(none)` | local |
| 205 | `Dialogue.is_active` | `player_id` | declared |
| 209 | `Dialogue.prompt_yesno` | `player_id, opts` | declared |
| 213 | `Dialogue.prompt_menu` | `player_id, opts` | declared |
| 217 | `Dialogue.start` | `player_id, script, opts` | declared |
| 326 | `Dialogue.close` | `player_id` | declared |

### Function details

#### 1. `ensure_backdrop_sprite(player_id)`

- **Location:** source line 24.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 2. `draw_backdrop(player_id, backdrop, z)`

- **Location:** source line 37.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `backdrop` | Not explicitly documented in adjacent source annotations. |
| 3 | `z` | Not explicitly documented in adjacent source annotations. |

#### 3. `erase_backdrop(player_id)`

- **Location:** source line 58.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 4. `set_input_locked(player_id, locked)`

- **Location:** source line 62.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `locked` | Not explicitly documented in adjacent source annotations. |

#### 5. `ensure_listener()`

- **Location:** source line 72.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 6. `default_opts()`

- **Location:** source line 80.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 7. `merge(a, b)`

- **Location:** source line 96.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |

#### 8. `mk_box_id(player_id, ui)`

- **Location:** source line 101.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `ui` | Not explicitly documented in adjacent source annotations. |

#### 9. `gate_handoff_input(player_id, seconds)`

- **Location:** source line 105.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `seconds` | Not explicitly documented in adjacent source annotations. |

#### 10. `close_instance(player_id, reason)`

- **Location:** source line 111.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `reason` | Not explicitly documented in adjacent source annotations. |

#### 11. `finish_instance(player_id, inst)`

- **Location:** source line 136.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `inst` | Not explicitly documented in adjacent source annotations. |

#### 12. `attach_tick()`

- **Location:** source line 157.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 13. `Dialogue.is_active(player_id)`

- **Location:** source line 205.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 14. `Dialogue.prompt_yesno(player_id, opts)`

- **Location:** source line 209.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 15. `Dialogue.prompt_menu(player_id, opts)`

- **Location:** source line 213.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 16. `Dialogue.start(player_id, script, opts)`

- **Location:** source line 217.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `script` | Not explicitly documented in adjacent source annotations. |
| 3 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 17. `Dialogue.close(player_id)`

- **Location:** source line 326.
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
| 161 | `_event` | `Dialogue._tick_attached then return end Dialogue._tick_attached = true Net:on("tick",` |

## 📦 Tables and data

The following **8** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Dialogue` — line 16

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `Dialogue.instances` — line 17

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `player_backdrop_sprite` — line 22

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `return` — line 81

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | numeric literal | `8` |
| `y` | numeric literal | `110` |
| `w` | numeric literal | `224` |
| `h` | numeric literal | `42` |
| `font` | string literal | `"THICK"` |
| `scale` | numeric literal | `2.0` |
| `z` | numeric literal | `100` |
| `typing_speed` | numeric literal | `30` |
| `page_advance` | expression/reference | `C.PageAdvance.WAIT_FOR_CONFIRM` |
| `advance_delay` | numeric literal | `2.0` |
| `confirm_during_typing` | boolean literal | `true` |
| `input_mode` | expression/reference | `C.InputMode.DIALOGUE_OWNS_INPUT` |
| `cancel_behavior` | string literal | `"battle_network"` |
| `debug` | boolean literal | `false` |

### 5. `pages` — line 256

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `pages` — line 258

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `script` |

### 7. `pages` — line 264

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `""` |

### 8. `text_options` — line 275

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | expression/reference | `o.font` |
| `scale` | expression/reference | `o.scale` |
| `z` | expression/reference | `o.z` |
| `speed` | expression/reference | `o.typing_speed` |
| `type_sound` | expression/reference | `o.type_sfx_path` |
| `type_sound_min_dt` | expression/reference | `o.type_sfx_min_dt` |
| `max_lines` | expression/reference | `backdrop and backdrop.max_lines or nil` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 1 |
| `Net.player_alloc_sprite` | 1 |
| `Net.player_draw_sprite` | 1 |
| `Net.player_erase_sprite` | 1 |
| `Net.provide_asset_for_player` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
