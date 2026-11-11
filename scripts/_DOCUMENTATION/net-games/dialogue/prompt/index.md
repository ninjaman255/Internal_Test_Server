# 📄 `prompt.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/dialogue/prompt.lua`](../../../../net-games/dialogue/prompt.lua)  
> **Source lines:** 411  
> **SHA-256 (UTF-8):** `28ab08eb068aa8…`  
> **Declared/assigned functions detected:** 22  
> **Anonymous closures detected:** 5  
> **Table initializers detected:** 13

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

Hardened YES/NO prompt using the public TextLayout service.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 4 | `scripts/displayer/displayer` |
| 5 | `scripts/displayer/text-layout` |
| 6 | `scripts/displayer/text-display` |
| 7 | `scripts/input/input` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 351 | `Net:on` | `tick` |
| 397 | `Net:on` | `player_disconnect` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 21 | `has_asset` | `path` | local |
| 27 | `safe_provide` | `player_id, path` | local |
| 33 | `play_cursor_move_sfx` | `player_id` | local |
| 39 | `ensure_backdrop_asset` | `player_id` | local |
| 48 | `draw_backdrop` | `player_id, backdrop, z` | local |
| 66 | `erase_backdrop` | `player_id` | local |
| 70 | `ensure_cursor_asset` | `player_id` | local |
| 83 | `selector_draw` | `player_id, draw_id, virtual_x, virtual_y, z, scale` | local |
| 95 | `selector_erase` | `player_id, draw_id` | local |
| 99 | `normalize_ui` | `ui` | local |
| 128 | `build_prompt_text` | `question, ui` | local |
| 167 | `options_visible` | `player_id, box_id` | local |
| 176 | `find_option_virtual_positions` | `player_id, box_id, selection` | local |
| 197 | `set_input_locked` | `player_id, locked` | local |
| 202 | `mk_id` | `player_id` | local |
| 207 | `PromptInstance:new` | `player_id, opts` | declared |
| 230 | `PromptInstance:render_initial` | `(none)` | declared |
| 264 | `PromptInstance:render_cursor` | `(none)` | declared |
| 270 | `PromptInstance:update` | `dt` | declared |
| 348 | `ensure_tick` | `(none)` | local |
| 362 | `Prompt.yesno` | `player_id, opts` | declared |
| 375 | `Prompt.close` | `player_id, _reason, opts` | declared |

### Function details

#### 1. `has_asset(path)`

- **Location:** source line 21.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `path` | Not explicitly documented in adjacent source annotations. |

#### 2. `safe_provide(player_id, path)`

- **Location:** source line 27.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `path` | Not explicitly documented in adjacent source annotations. |

#### 3. `play_cursor_move_sfx(player_id)`

- **Location:** source line 33.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 4. `ensure_backdrop_asset(player_id)`

- **Location:** source line 39.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 5. `draw_backdrop(player_id, backdrop, z)`

- **Location:** source line 48.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `backdrop` | Not explicitly documented in adjacent source annotations. |
| 3 | `z` | Not explicitly documented in adjacent source annotations. |

#### 6. `erase_backdrop(player_id)`

- **Location:** source line 66.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 7. `ensure_cursor_asset(player_id)`

- **Location:** source line 70.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 8. `selector_draw(player_id, draw_id, virtual_x, virtual_y, z, scale)`

- **Location:** source line 83.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `draw_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `virtual_x` | Not explicitly documented in adjacent source annotations. |
| 4 | `virtual_y` | Not explicitly documented in adjacent source annotations. |
| 5 | `z` | Not explicitly documented in adjacent source annotations. |
| 6 | `scale` | Not explicitly documented in adjacent source annotations. |

#### 9. `selector_erase(player_id, draw_id)`

- **Location:** source line 95.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `draw_id` | Not explicitly documented in adjacent source annotations. |

#### 10. `normalize_ui(ui)`

- **Location:** source line 99.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `ui` | Not explicitly documented in adjacent source annotations. |

#### 11. `build_prompt_text(question, ui)`

- **Location:** source line 128.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `question` | Not explicitly documented in adjacent source annotations. |
| 2 | `ui` | Not explicitly documented in adjacent source annotations. |

#### 12. `options_visible(player_id, box_id)`

- **Location:** source line 167.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `box_id` | Not explicitly documented in adjacent source annotations. |

#### 13. `find_option_virtual_positions(player_id, box_id, selection)`

- **Location:** source line 176.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `box_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `selection` | Not explicitly documented in adjacent source annotations. |

#### 14. `set_input_locked(player_id, locked)`

- **Location:** source line 197.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `locked` | Not explicitly documented in adjacent source annotations. |

#### 15. `mk_id(player_id)`

- **Location:** source line 202.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 16. `PromptInstance:new(player_id, opts)`

- **Location:** source line 207.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 17. `PromptInstance:render_initial()`

- **Location:** source line 230.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 18. `PromptInstance:render_cursor()`

- **Location:** source line 264.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 19. `PromptInstance:update(dt)`

- **Location:** source line 270.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `dt` | Not explicitly documented in adjacent source annotations. |

#### 20. `ensure_tick()`

- **Location:** source line 348.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 21. `Prompt.yesno(player_id, opts)`

- **Location:** source line 362.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 22. `Prompt.close(player_id, _reason, opts)`

- **Location:** source line 375.
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
| 214 | `(none)` | `r mk_id(player_id) o.question = opts.question or "Continue?" o.on_yes = opts.on_yes …` |
| 215 | `(none)` | `estion or "Continue?" o.on_yes = opts.on_yes or function() end o.on_no = opts.on_no …` |
| 216 | `(none)` | `function() end o.on_no = opts.on_no or function() end o.on_cancel = opts.on_cancel or` |
| 351 | `event` | `if Prompt._tick_attached then return end Prompt._tick_attached = true Net:on("tick",` |
| 397 | `event` | `"confirm", "cancel" }) Prompt.instances[player_id] = nil end Net:on("player_disconne…` |

## 📦 Tables and data

The following **13** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Prompt` — line 9

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `Prompt.instances` — line 10

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `player_cursor_asset` — line 18

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `player_backdrop_asset` — line 19

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `o` — line 101

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
| `backdrop` | expression/reference | `ui.backdrop or ui.backdrop_config` |
| `mugshot` | expression/reference | `ui.mugshot` |
| `nameplate` | expression/reference | `ui.nameplate` |
| `typing_speed` | expression/reference | `ui.typing_speed or 99999` |
| `type_sfx_path` | expression/reference | `ui.type_sfx_path` |
| `type_sfx_min_dt` | expression/reference | `ui.type_sfx_min_dt` |

### 6. `qlines` — line 136

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `pages` — line 142

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `page` — line 149

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `final` — line 155

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `page_strings` — line 162

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `PromptInstance` — line 204

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `text_options` — line 236

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | expression/reference | `ui.font` |
| `scale` | expression/reference | `ui.scale` |
| `z` | expression/reference | `ui.z` |
| `speed` | expression/reference | `ui.typing_speed` |
| `type_sound` | expression/reference | `ui.type_sfx_path` |
| `type_sound_min_dt` | expression/reference | `ui.type_sfx_min_dt` |
| `max_lines` | expression/reference | `ui.backdrop and ui.backdrop.max_lines or nil` |

### 13. `held` — line 288

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 2 |
| `Net.player_alloc_sprite` | 2 |
| `Net.player_draw_sprite` | 2 |
| `Net.player_erase_sprite` | 2 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
