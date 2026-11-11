# 📄 `prog_prompt_dialogue.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_prompt_dialogue.lua`](../../../../net-games/npcs/prog_prompt_dialogue.lua)  
> **Source lines:** 185  
> **SHA-256 (UTF-8):** `b8fab5efab4eb1…`  
> **Declared/assigned functions detected:** 7  
> **Anonymous closures detected:** 1  
> **Table initializers detected:** 5

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

Tiled-spawned NPC that shows a YES/NO prompt, then follows up with Dialogue.start, reusing the same textbox UI (no close/recreate).

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 8 | `scripts/libs/direction` |
| 9 | `scripts/net-games/dialogue/dialogue` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 134 | `Net:on` | `actor_interaction` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 12 | `dbg` | `msg` | local |
| 49 | `basic_prog_ui` | `box_id` | local |
| 119 | `prog_ui_prompt` | `(none)` | local |
| 125 | `prog_ui_dialogue` | `(none)` | local |
| 153 | `on_yes` | `(none)` | assigned |
| 168 | `on_no` | `(none)` | assigned |
| 181 | `on_cancel` | `(none)` | assigned |

### Function details

#### 1. `dbg(msg)`

- **Location:** source line 12.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `msg` | Not explicitly documented in adjacent source annotations. |

#### 2. `basic_prog_ui(box_id)`

- **Location:** source line 49.
- **Declaration style:** `local`.
- **Adjacent source comment:** Shared UI base (clone of prog_basic_dialogue.lua settings)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `box_id` | Not explicitly documented in adjacent source annotations. |

#### 3. `prog_ui_prompt()`

- **Location:** source line 119.
- **Declaration style:** `local`.
- **Adjacent source comment:** Two helpers so you can tweak prompt vs dialogue later without collateral damage NOTE: both return the SAME box_id now, so prompt and dialogue reuse the textbox.

#### 4. `prog_ui_dialogue()`

- **Location:** source line 125.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 5. `on_yes()`

- **Location:** source line 153.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 6. `on_no()`

- **Location:** source line 168.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 7. `on_cancel()`

- **Location:** source line 181.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 134 | `event` | `on handler --===================================================== Net:on("actor_int…` |

## 📦 Tables and data

The following **5** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `return` — line 50

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `box_id` | expression/reference | `box_id` |
| `font` | string literal | `"THIN_BLACK"` |
| `scale` | numeric literal | `2.0` |
| `z` | numeric literal | `100` |
| `typing_speed` | numeric literal | `12` |
| `type_sfx_path` | string literal | `"/server/assets/net-games/sfx/text.ogg"` |
| `type_sfx_min_dt` | numeric literal | `0.05` |
| `nameplate` | nested table | `{ text = BOT_NAME, anchor = "above", align = "left", gap_x = 6, gap_y = 59, dur = 0.20, close_dur = 0.20, bob_amp = 1.2, bob_speed = 2 }` |
| `backdrop` | nested table | `{ close_seconds = 0.25, render_offset_x = 3, render_offset_y = 46, style = "textbox_panel", open_seconds = 0.20, x = 1, y = 209, width = 478, height = 104…` |
| `mugshot` | nested table | `{ enabled = true, texture_path = "/server/assets/ow/prog/prog_mug.png", anim_path = "/server/assets/ow/prog/prog_mug.animation", talk_anim_state = "TALK",…` |

### 2. `nameplate` — line 58

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `text` | expression/reference | `BOT_NAME` |
| `anchor` | string literal | `"above"` |
| `align` | string literal | `"left"` |
| `gap_x` | numeric literal | `6` |
| `gap_y` | numeric literal | `59` |
| `dur` | numeric literal | `0.20` |
| `close_dur` | numeric literal | `0.20` |
| `bob_amp` | numeric literal | `1.2` |
| `bob_speed` | numeric literal | `2` |

### 3. `backdrop` — line 70

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `close_seconds` | numeric literal | `0.25` |
| `render_offset_x` | numeric literal | `3` |
| `render_offset_y` | numeric literal | `46` |
| `style` | string literal | `"textbox_panel"` |
| `open_seconds` | numeric literal | `0.20` |
| `x` | numeric literal | `1` |
| `y` | numeric literal | `209` |
| `width` | numeric literal | `478` |
| `height` | numeric literal | `104` |
| `padding_x` | numeric literal | `16` |
| `padding_y` | numeric literal | `4` |
| `max_lines` | numeric literal | `3` |
| `[13]` | expression/reference | `-- Leave indicator enabled in UI. -- Prompt.lua toggles it dynamically when Yes/No selector is visible. indicator = { enabled = true, width = 2, height = …` |

### 4. `indicator` — line 86

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

### 5. `mugshot` — line 98

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
| `Net.get_bot_name` | 1 |
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
