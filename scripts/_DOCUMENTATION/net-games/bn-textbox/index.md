# 📄 `bn-textbox.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/bn-textbox.lua`](../../../net-games/bn-textbox.lua)  
> **Source lines:** 141  
> **SHA-256 (UTF-8):** `552f66876260ae…`  
> **Declared/assigned functions detected:** 3  
> **Anonymous closures detected:** 0  
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

Simple BN-style text box with typewriter, optional nameplate, mugshot, and backdrop. Uses the existing Dialogue.start system for reliable behavior and input handling.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 5 | `scripts/net-games/dialogue/dialogue` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 10 | `shallow_copy` | `t` | local |
| 21 | `build_ui` | `player_id, opts` | local |
| 126 | `BNTextbox.show` | `player_id, text, opts` | declared |

### Function details

#### 1. `shallow_copy(t)`

- **Location:** source line 10.
- **Declaration style:** `local`.
- **Adjacent source comment:** Small helper to copy tables

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 2. `build_ui(player_id, opts)`

- **Location:** source line 21.
- **Declaration style:** `local`.
- **Adjacent source comment:** Build the UI configuration table expected by Dialogue.start

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 3. `BNTextbox.show(player_id, text, opts)`

- **Location:** source line 126.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Show a BN‑style text box. 
- **Lua documentation annotations:** `@param player_id string`, `@param text string|table   -- single string or array of lines (strings)`, `@param opts table          -- optional overrides (see documentation below)`, `@return table              -- the dialogue object (from Dialogue.start)`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `text` | `@param text string\|table   -- single string or array of lines (strings)` |
| 3 | `opts` | `@param opts table          -- optional overrides (see documentation below)` |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **8** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `BNTextbox` — line 7

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `o` — line 11

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `ui` — line 22

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `box_id` | expression/reference | `opts.box_id or ("bn_textbox_" .. player_id .. "_" .. tostring(os.time()))` |
| `font` | expression/reference | `opts.font or "THIN_BLACK"` |
| `scale` | expression/reference | `opts.scale or 2.0` |
| `z` | expression/reference | `opts.z or 100` |
| `typing_speed` | expression/reference | `opts.typing_speed or 30` |
| `type_sfx_path` | expression/reference | `opts.type_sfx_path or "/server/assets/net-games/sfx/text.ogg"` |
| `type_sfx_min_dt` | expression/reference | `opts.type_sfx_min_dt or 0.05` |

### 4. `backdrop` — line 33

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `render_offset_x` | expression/reference | `opts.backdrop_render_offset_x or 3` |
| `render_offset_y` | expression/reference | `opts.backdrop_render_offset_y or 46` |
| `style` | string literal | `"textbox_panel"` |
| `[4]` | expression/reference | `-- default; overridden if frame_tint is given open_seconds = opts.backdrop_open_seconds or 0.20` |
| `close_seconds` | expression/reference | `opts.backdrop_close_seconds or 0.25` |
| `x` | expression/reference | `opts.backdrop_x or 1` |
| `y` | expression/reference | `opts.backdrop_y or 209` |
| `width` | expression/reference | `opts.backdrop_width or 478` |
| `height` | expression/reference | `opts.backdrop_height or 104` |
| `padding_x` | expression/reference | `opts.backdrop_padding_x or 16` |
| `padding_y` | expression/reference | `opts.backdrop_padding_y or 4` |
| `max_lines` | expression/reference | `opts.backdrop_max_lines or 3` |
| `indicator` | nested table | `{ enabled = true, width = 2, height = 2, offset_x = 24, offset_y = 26, }` |

### 5. `indicator` — line 46

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `width` | numeric literal | `2` |
| `height` | numeric literal | `2` |
| `offset_x` | numeric literal | `24` |
| `offset_y` | numeric literal | `26` |

### 6. `ui.nameplate` — line 70

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `text` | expression/reference | `name` |
| `anchor` | expression/reference | `opts.nameplate_anchor or "above"` |
| `align` | expression/reference | `opts.nameplate_align or "left"` |
| `gap_x` | expression/reference | `opts.nameplate_gap_x or 6` |
| `gap_y` | expression/reference | `opts.nameplate_gap_y or 59` |
| `dur` | expression/reference | `opts.nameplate_dur or 0.20` |
| `close_dur` | expression/reference | `opts.nameplate_close_dur or 0.20` |
| `bob_amp` | expression/reference | `opts.nameplate_bob_amp or 1.2` |
| `bob_speed` | expression/reference | `opts.nameplate_bob_speed or 2` |

### 7. `ui.nameplate.frame` — line 84

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `backdrop.r` |
| `g` | expression/reference | `backdrop.g` |
| `b` | expression/reference | `backdrop.b` |
| `a` | expression/reference | `backdrop.a` |
| `color_mode` | expression/reference | `backdrop.color_mode` |

### 8. `ui.mugshot` — line 101

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `texture_path` | expression/reference | `opts.mugshot_texture` |
| `anim_path` | expression/reference | `opts.mugshot_anim_path or ""` |
| `talk_anim_state` | expression/reference | `opts.mugshot_talk_anim_state or "TALK"` |
| `idle_anim_state` | expression/reference | `opts.mugshot_idle_anim_state or "IDLE"` |
| `reserve_w` | expression/reference | `opts.mugshot_reserve_w or 40` |
| `reserve_h` | expression/reference | `opts.mugshot_reserve_h or 40` |
| `offset_x` | expression/reference | `opts.mugshot_offset_x or 6` |
| `offset_y` | expression/reference | `opts.mugshot_offset_y or -46` |
| `gap_px` | expression/reference | `opts.mugshot_gap_px or 6` |
| `sprite_id` | expression/reference | `opts.mugshot_sprite_id or 5300` |
| `z_bias` | expression/reference | `opts.mugshot_z_bias or 50` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
