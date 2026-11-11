# 📄 `prog_dyed_dialogue(bak).lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_dyed_dialogue(bak).lua`](../../../../net-games/npcs/prog_dyed_dialogue%28bak%29.lua)  
> **Source lines:** 125  
> **SHA-256 (UTF-8):** `70756ef4f85eff…`  
> **Declared/assigned functions detected:** 2  
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

Tiled-spawned NPC that triggers net-games Dialogue Uses textbox_panel_frame_tint (base textbox untouched + tinted frame overlay)

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 7 | `scripts/libs/direction` |
| 8 | `scripts/net-games/dialogue/dialogue` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 41 | `Net:on` | `actor_interaction` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 11 | `dbg` | `msg` | local |
| 121 | `on_finish` | `(none)` | assigned |

### Function details

#### 1. `dbg(msg)`

- **Location:** source line 11.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `msg` | Not explicitly documented in adjacent source annotations. |

#### 2. `on_finish()`

- **Location:** source line 121.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 41 | `event` | `on handler --===================================================== Net:on("actor_int…` |

## 📦 Tables and data

The following **4** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `ui` — line 62

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `box_id` | string literal | `"prog_dyed_dialogue_box"` |
| `font` | string literal | `"THIN_BLACK"` |
| `scale` | numeric literal | `2.0` |
| `z` | numeric literal | `100` |
| `typing_speed` | numeric literal | `30` |
| `type_sfx_path` | string literal | `"/server/assets/net-games/sfx/text.ogg"` |
| `type_sfx_min_dt` | numeric literal | `0.05` |
| `backdrop` | nested table | `{ render_offset_x = 3, render_offset_y = 46, -- base textbox unchanged + tinted frame overlay style = "textbox_panel_frame_tint", -- lime-ish tint (only a…` |
| `mugshot` | nested table | `{ enabled = true, texture_path = "/server/assets/ow/prog/prog_mug.png", anim_path = "/server/assets/ow/prog/prog_mug.animation", talk_anim_state = "TALK",…` |

### 2. `backdrop` — line 71

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `render_offset_x` | numeric literal | `3` |
| `render_offset_y` | numeric literal | `46` |
| `[3]` | expression/reference | `-- base textbox unchanged + tinted frame overlay style = "textbox_panel_frame_tint"` |
| `[4]` | expression/reference | `-- lime-ish tint (only applied to the gray frame overlay sprite) r = 80` |
| `g` | numeric literal | `255` |
| `b` | numeric literal | `80` |
| `a` | numeric literal | `255` |
| `color_mode` | numeric literal | `2` |
| `x` | numeric literal | `1` |
| `y` | numeric literal | `209` |
| `width` | numeric literal | `478` |
| `height` | numeric literal | `104` |
| `padding_x` | numeric literal | `16` |
| `padding_y` | numeric literal | `4` |
| `max_lines` | numeric literal | `3` |
| `indicator` | nested table | `{ enabled = true, width = 2, height = 2, offset_x = 24, offset_y = 26, indicator_timer = 0, indicator_base_x = nil, indicator_base_y = nil, }` |

### 3. `indicator` — line 93

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

### 4. `mugshot` — line 105

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
