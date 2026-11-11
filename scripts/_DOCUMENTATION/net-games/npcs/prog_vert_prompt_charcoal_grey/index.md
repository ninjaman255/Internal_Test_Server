# 📄 `prog_vert_prompt_charcoal_grey.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_vert_prompt_charcoal_grey.lua`](../../../../net-games/npcs/prog_vert_prompt_charcoal_grey.lua)  
> **Source lines:** 150  
> **SHA-256 (UTF-8):** `fed28bbc131fab…`  
> **Declared/assigned functions detected:** 2  
> **Anonymous closures detected:** 1  
> **Table initializers detected:** 9

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

New NPC that mirrors Lime/Pink vertical menu flow, but uses the new helpers: - npc_api.lua (bind interaction + guards + face + sfx) - menu_options.lua (count/list -> options table)

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 10 | `scripts/net-games/npcs/npc_api` |
| 11 | `scripts/net-games/npcs/menu_options` |
| 13 | `scripts/libs/direction` |
| 15 | `scripts/net-games/npcs/talk` |
| 16 | `scripts/net-games/npcs/talk_vert_menu` |
| 17 | `scripts/net-games/npcs/talk_presets` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 85 | `on_yes` | `(none)` | assigned |
| 132 | `on_no` | `(none)` | assigned |

### Function details

#### 1. `on_yes()`

- **Location:** source line 85.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 2. `on_no()`

- **Location:** source line 132.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 83 | `player_id` | `================================================ NPC.bind_confirm_interaction(bot_id…` |

## 📦 Tables and data

The following **9** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `SFX` — line 22

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `DESC` | string literal | `"/server/assets/net-games/sfx/card_desc.ogg"` |
| `CONFIRM` | string literal | `"/server/assets/net-games/sfx/card_confirm.ogg"` |
| `DESC_CLOSE` | string literal | `"/server/assets/net-games/sfx/card_desc_close.ogg"` |

### 2. `TALK_CFG` — line 57

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `area_id` | expression/reference | `area_id` |
| `object` | expression/reference | `obj_name` |
| `box_id` | string literal | `"prog_vert_charcoal_box"` |
| `preset` | string literal | `"prog_prompt"` |
| `frame` | string literal | `"charcoal_grey"` |
| `[6]` | expression/reference | `-- frame dye exists in presets mug = "prog_charcoal_grey"` |
| `[7]` | expression/reference | `-- mug key exists in presets nameplate = "prog"` |

### 3. `flow` — line 100

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `keep_menu_open` | boolean literal | `true` |
| `lock_dim_alpha` | numeric literal | `0.35` |
| `hide_cursor_when_locked` | boolean literal | `true` |
| `confirm` | nested table | `{ enabled = true, text_format = 'Are you sure you want "%s"?', skip_ids = { exit = true }, }` |
| `post_select` | nested table | `{ enabled = true, text_format = 'You got "%s".', skip_ids = { exit = true }, }` |
| `[6]` | expression/reference | `-- YES vs NO follow-up lines (the bug you fixed) after_yes_text = "Confirmed.{p_0.2} Thank you."` |
| `after_no_text` | string literal | `"Understood."` |
| `exit_goodbye_text` | string literal | `"Signal closed."` |
| `sfx` | nested table | `{ desc = SFX.DESC, confirm = SFX.CONFIRM, close = SFX.DESC_CLOSE, }` |

### 4. `confirm` — line 105

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `text_format` | string literal | `'Are you sure you want "%s"?'` |
| `skip_ids` | nested table | `{ exit = true }` |

### 5. `skip_ids` — line 108

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `exit` | boolean literal | `true` |

### 6. `post_select` — line 111

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `text_format` | string literal | `'You got "%s".'` |
| `skip_ids` | nested table | `{ exit = true }` |

### 7. `skip_ids` — line 114

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `exit` | boolean literal | `true` |

### 8. `sfx` — line 123

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `desc` | expression/reference | `SFX.DESC` |
| `confirm` | expression/reference | `SFX.CONFIRM` |
| `close` | expression/reference | `SFX.DESC_CLOSE` |

### 9. `next_cfg` — line 133

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `area_id` | expression/reference | `TALK_CFG.area_id` |
| `object` | expression/reference | `TALK_CFG.object` |
| `box_id` | expression/reference | `TALK_CFG.box_id` |
| `preset` | expression/reference | `TALK_CFG.preset` |
| `frame` | expression/reference | `TALK_CFG.frame` |
| `mug` | expression/reference | `TALK_CFG.mug` |
| `nameplate` | expression/reference | `TALK_CFG.nameplate` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.create_bot` | 1 |
| `Net.get_bot_name` | 1 |
| `Net.get_object_by_name` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
