# 📄 `prog_vert_prompt_sapphire.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_vert_prompt_sapphire.lua`](../../../../net-games/npcs/prog_vert_prompt_sapphire.lua)  
> **Source lines:** 255  
> **SHA-256 (UTF-8):** `7bec270976b8ac…`  
> **Declared/assigned functions detected:** 8  
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

Flow: Interact -> YES/NO prompt: "Do you wanna check out the vertical menu?" YES -> SAME textbox becomes:

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 17 | `scripts/libs/direction` |
| 18 | `scripts/net-games/dialogue/startup` |
| 20 | `scripts/net-games/dialogue/dialogue` |
| 21 | `scripts/net-games/dialogue/prompt` |
| 22 | `scripts/net-games/dialogue/prompt_vertical` |
| 23 | `scripts/net-games/npcs/talk_presets` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 224 | `Net:on` | `actor_interaction` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 57 | `copy_frame_preset` | `preset` | local |
| 70 | `build_options` | `(none)` | local |
| 82 | `build_ui_config` | `box_id` | local |
| 160 | `build_layout_config` | `(none)` | local |
| 194 | `open_vertical_menu` | `player_id, intro_text` | local |
| 210 | `on_select` | `choice, index` | assigned |
| 239 | `on_yes` | `(none)` | assigned |
| 243 | `on_no` | `(none)` | assigned |

### Function details

#### 1. `copy_frame_preset(preset)`

- **Location:** source line 57.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `preset` | Not explicitly documented in adjacent source annotations. |

#### 2. `build_options()`

- **Location:** source line 70.
- **Declaration style:** `local`.
- **Adjacent source comment:** Menu options

#### 3. `build_ui_config(box_id)`

- **Location:** source line 82.
- **Declaration style:** `local`.
- **Adjacent source comment:** Shared UI config (textbox + nameplate + mug)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `box_id` | Not explicitly documented in adjacent source annotations. |

#### 4. `build_layout_config()`

- **Location:** source line 160.
- **Declaration style:** `local`.
- **Adjacent source comment:** Vertical menu layout (frame overlay dye uses layout.frame)

#### 5. `open_vertical_menu(player_id, intro_text)`

- **Location:** source line 194.
- **Declaration style:** `local`.
- **Adjacent source comment:** Open the vertical menu. NOTE: reuse_existing_box=true is what forces the textbox text to change from the YES/NO prompt into the new "Awesome..." line.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `intro_text` | Not explicitly documented in adjacent source annotations. |

#### 6. `on_select(choice, index)`

- **Location:** source line 210.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `choice` | Not explicitly documented in adjacent source annotations. |
| 2 | `index` | Not explicitly documented in adjacent source annotations. |

#### 7. `on_yes()`

- **Location:** source line 239.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 8. `on_no()`

- **Location:** source line 243.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 224 | `event` | `nteraction --===================================================== Net:on("actor_int…` |

## 📦 Tables and data

The following **8** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `return` — line 59

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `preset.r` |
| `g` | expression/reference | `preset.g` |
| `b` | expression/reference | `preset.b` |
| `a` | expression/reference | `preset.a` |
| `color_mode` | expression/reference | `preset.color_mode` |

### 2. `t` — line 71

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `return` — line 83

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `box_id` | expression/reference | `box_id` |
| `font` | string literal | `"THIN_BLACK"` |
| `scale` | numeric literal | `2.0` |
| `z` | numeric literal | `100` |
| `typing_speed` | numeric literal | `12` |
| `type_sfx_path` | string literal | `"/server/assets/net-games/sfx/text.ogg"` |
| `type_sfx_min_dt` | numeric literal | `0.05` |
| `mugshot` | nested table | `{ enabled = true, texture_path = SAPPHIRE_MUG.texture_path, anim_path = SAPPHIRE_MUG.anim_path, talk_anim_state = SAPPHIRE_MUG.talk_anim_state, idle_anim_…` |
| `[9]` | expression/reference | `-- Textbox frame tint (same as your dye system) backdrop = { render_offset_x = 3, render_offset_y = 46, style = "textbox_panel_frame_tint", open_seconds =…` |
| `[10]` | expression/reference | `-- Nameplate frame dye nameplate = { frame = FRAME, text = BOT_NAME, anchor = "above", align = "left", gap_x = 6, gap_y = 59, dur = 0.20, close_dur = 0.20…` |

### 4. `mugshot` — line 93

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `texture_path` | expression/reference | `SAPPHIRE_MUG.texture_path` |
| `anim_path` | expression/reference | `SAPPHIRE_MUG.anim_path` |
| `talk_anim_state` | expression/reference | `SAPPHIRE_MUG.talk_anim_state` |
| `idle_anim_state` | expression/reference | `SAPPHIRE_MUG.idle_anim_state` |
| `reserve_w` | expression/reference | `SAPPHIRE_MUG.reserve_w` |
| `reserve_h` | expression/reference | `SAPPHIRE_MUG.reserve_h` |
| `offset_x` | expression/reference | `SAPPHIRE_MUG.offset_x` |
| `offset_y` | expression/reference | `SAPPHIRE_MUG.offset_y` |
| `gap_px` | expression/reference | `SAPPHIRE_MUG.gap_px` |
| `sprite_id` | expression/reference | `SAPPHIRE_MUG.sprite_id` |
| `z_bias` | expression/reference | `SAPPHIRE_MUG.z_bias` |

### 5. `backdrop` — line 109

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `render_offset_x` | numeric literal | `3` |
| `render_offset_y` | numeric literal | `46` |
| `style` | string literal | `"textbox_panel_frame_tint"` |
| `open_seconds` | numeric literal | `0.20` |
| `close_seconds` | numeric literal | `0.25` |
| `r` | expression/reference | `FRAME.r` |
| `g` | expression/reference | `FRAME.g` |
| `b` | expression/reference | `FRAME.b` |
| `a` | expression/reference | `FRAME.a` |
| `color_mode` | expression/reference | `FRAME.color_mode` |
| `x` | numeric literal | `1` |
| `y` | numeric literal | `209` |
| `width` | numeric literal | `478` |
| `height` | numeric literal | `104` |
| `padding_x` | numeric literal | `16` |
| `padding_y` | numeric literal | `4` |
| `max_lines` | numeric literal | `3` |
| `indicator` | nested table | `{ enabled = true, width = 2, height = 2, offset_x = 24, offset_y = 26, }` |

### 6. `indicator` — line 131

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `width` | numeric literal | `2` |
| `height` | numeric literal | `2` |
| `offset_x` | numeric literal | `24` |
| `offset_y` | numeric literal | `26` |

### 7. `nameplate` — line 141

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `frame` | expression/reference | `FRAME` |
| `text` | expression/reference | `BOT_NAME` |
| `anchor` | string literal | `"above"` |
| `align` | string literal | `"left"` |
| `gap_x` | numeric literal | `6` |
| `gap_y` | numeric literal | `59` |
| `dur` | numeric literal | `0.20` |
| `close_dur` | numeric literal | `0.20` |
| `bob_amp` | numeric literal | `1.2` |
| `bob_speed` | numeric literal | `2` |

### 8. `return` — line 161

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `anchor` | string literal | `"textbox"` |
| `offset_x` | numeric literal | `1` |
| `offset_y` | numeric literal | `-199` |
| `width` | numeric literal | `160` |
| `height` | numeric literal | `64` |
| `frame` | expression/reference | `FRAME` |
| `visible_rows` | numeric literal | `5` |
| `row_height` | numeric literal | `14` |
| `padding_x` | numeric literal | `48` |
| `padding_y` | numeric literal | `4` |
| `scrollbar_x` | numeric literal | `452` |
| `scrollbar_y` | numeric literal | `12` |
| `scrollbar_h` | numeric literal | `126` |
| `scroll_indicator_h` | numeric literal | `12` |
| `highlight_inset_x` | numeric literal | `12` |
| `highlight_inset_y` | numeric literal | `3` |
| `cursor_offset_x` | numeric literal | `16` |
| `cursor_offset_y` | numeric literal | `4` |

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
