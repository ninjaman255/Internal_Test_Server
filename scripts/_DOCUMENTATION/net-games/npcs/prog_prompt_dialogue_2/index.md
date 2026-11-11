# 📄 `prog_prompt_dialogue_2.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_prompt_dialogue_2.lua`](../../../../net-games/npcs/prog_prompt_dialogue_2.lua)  
> **Source lines:** 167  
> **SHA-256 (UTF-8):** `34df4adb50f788…`  
> **Declared/assigned functions detected:** 7  
> **Anonymous closures detected:** 1  
> **Table initializers detected:** 4

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

Tiled-spawned NPC that shows a YES/NO prompt, then follows up with Dialogue.start.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 7 | `scripts/libs/direction` |
| 8 | `scripts/net-games/dialogue/dialogue` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 117 | `Net:on` | `actor_interaction` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 11 | `dbg` | `msg` | local |
| 41 | `basic_prog_ui` | `box_id` | local |
| 100 | `prog_ui_prompt` | `box_id` | local |
| 107 | `prog_ui_dialogue` | `box_id` | local |
| 135 | `on_yes` | `(none)` | assigned |
| 151 | `on_no` | `(none)` | assigned |
| 163 | `on_cancel` | `(none)` | assigned |

### Function details

#### 1. `dbg(msg)`

- **Location:** source line 11.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `msg` | Not explicitly documented in adjacent source annotations. |

#### 2. `basic_prog_ui(box_id)`

- **Location:** source line 41.
- **Declaration style:** `local`.
- **Adjacent source comment:** Shared UI base (clone of prog_basic_dialogue.lua settings)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `box_id` | Not explicitly documented in adjacent source annotations. |

#### 3. `prog_ui_prompt(box_id)`

- **Location:** source line 100.
- **Declaration style:** `local`.
- **Adjacent source comment:** Two helpers so you can tweak prompt vs dialogue later without collateral damage

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `box_id` | Not explicitly documented in adjacent source annotations. |

#### 4. `prog_ui_dialogue(box_id)`

- **Location:** source line 107.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `box_id` | Not explicitly documented in adjacent source annotations. |

#### 5. `on_yes()`

- **Location:** source line 135.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 6. `on_no()`

- **Location:** source line 151.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 7. `on_cancel()`

- **Location:** source line 163.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 117 | `event` | `on handler --===================================================== Net:on("actor_int…` |

## 📦 Tables and data

The following **4** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `return` — line 42

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `box_id` | expression/reference | `box_id` |
| `font` | string literal | `"THIN_BLACK"` |
| `scale` | numeric literal | `2.0` |
| `z` | numeric literal | `100` |
| `typing_speed` | numeric literal | `30` |
| `type_sfx_path` | string literal | `"/server/assets/net-games/sfx/text.ogg"` |
| `type_sfx_min_dt` | numeric literal | `0.05` |
| `backdrop` | nested table | `{ render_offset_x = 3, render_offset_y = 46, style = "textbox_panel", x = 1, y = 209, width = 478, height = 104, padding_x = 16, padding_y = 4, max_lines …` |
| `[9]` | expression/reference | `-- Keep mugshot consistent with prog_basic mugshot = { enabled = true, texture_path = "/server/assets/ow/prog/prog_mug.png", anim_path = "/server/assets/o…` |

### 2. `backdrop` — line 51

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `render_offset_x` | numeric literal | `3` |
| `render_offset_y` | numeric literal | `46` |
| `style` | string literal | `"textbox_panel"` |
| `x` | numeric literal | `1` |
| `y` | numeric literal | `209` |
| `width` | numeric literal | `478` |
| `height` | numeric literal | `104` |
| `padding_x` | numeric literal | `16` |
| `padding_y` | numeric literal | `4` |
| `max_lines` | numeric literal | `3` |
| `[11]` | expression/reference | `-- IMPORTANT: -- Leave indicator enabled in UI. Prompt.lua will toggle it dynamically: -- - ON while paging prompt text -- - OFF when Yes/No is visible (s…` |

### 3. `indicator` — line 67

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `width` | numeric literal | `2` |
| `height` | numeric literal | `2` |
| `offset_x` | numeric literal | `24` |
| `offset_y` | numeric literal | `26` |
| `indicator_timer` | numeric literal | `0` |
| `indicator_base_x` | nil | `nil` |
| `indicator_base_y` | nil | `nil` |

### 4. `mugshot` — line 80

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `texture_path` | string literal | `"/server/assets/ow/prog/prog_mug.png"` |
| `anim_path` | string literal | `"/server/assets/ow/prog/prog_mug.animation"` |
| `talk_anim_state` | string literal | `"TALK"` |
| `idle_anim_state` | string literal | `"IDLE"` |
| `reserve_w` | numeric literal | `40` |
| `reserve_h` | numeric literal | `40` |
| `offset_x` | numeric literal | `6` |
| `offset_y` | numeric literal | `-46` |
| `gap_px` | numeric literal | `6` |
| `sprite_id` | numeric literal | `5300` |
| `z_bias` | numeric literal | `50` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.create_bot` | 1 |
| `Net.get_object_by_name` | 1 |
| `Net.get_player_position` | 1 |
| `Net.on` | 1 |
| `Net.set_bot_direction` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
