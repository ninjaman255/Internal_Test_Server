# 📄 `prog_vert_prompt_lime.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_vert_prompt_lime.lua`](../../../../net-games/npcs/prog_vert_prompt_lime.lua)  
> **Source lines:** 171  
> **SHA-256 (UTF-8):** `fe4e2a1387e65e…`  
> **Declared/assigned functions detected:** 5  
> **Anonymous closures detected:** 3  
> **Table initializers detected:** 10

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

LIME variant of prog_vert_prompt_pink.lua. Key requirement: identical in-game flow, but implemented using Talk.lua + TalkVertMenu.lua (reusable wrapper).

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 10 | `scripts/libs/direction` |
| 11 | `scripts/net-games/dialogue/startup` |
| 13 | `scripts/net-games/dialogue/dialogue` |
| 14 | `scripts/net-games/npcs/talk` |
| 15 | `scripts/net-games/npcs/talk_vert_menu` |
| 16 | `scripts/net-games/npcs/talk_presets` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 100 | `Net:on` | `actor_interaction` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 27 | `play_sfx` | `player_id, path` | local |
| 38 | `shallow_copy` | `t` | local |
| 88 | `build_options` | `(none)` | local |
| 115 | `on_yes` | `(none)` | assigned |
| 161 | `on_no` | `(none)` | assigned |

### Function details

#### 1. `play_sfx(player_id, path)`

- **Location:** source line 27.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `path` | Not explicitly documented in adjacent source annotations. |

#### 2. `shallow_copy(t)`

- **Location:** source line 38.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 3. `build_options()`

- **Location:** source line 88.
- **Declaration style:** `local`.
- **Adjacent source comment:** Menu options

#### 4. `on_yes()`

- **Location:** source line 115.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 5. `on_no()`

- **Location:** source line 161.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 32 | `(none)` | `Net.provide_asset_for_player(player_id, path) if Net.play_sound_for_player then pcal…` |
| 34 | `(none)` | `ction() Net.play_sound_for_player(player_id, path) end) elseif Net.play_sound then p…` |
| 100 | `event` | `nteraction --===================================================== Net:on("actor_int…` |

## 📦 Tables and data

The following **10** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `SFX` — line 21

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `DESC` | string literal | `"/server/assets/net-games/sfx/card_desc.ogg"` |
| `CONFIRM` | string literal | `"/server/assets/net-games/sfx/card_confirm.ogg"` |
| `DESC_CLOSE` | string literal | `"/server/assets/net-games/sfx/card_desc_close.ogg"` |

### 2. `o` — line 39

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `TALK_CFG` — line 74

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `area_id` | expression/reference | `area_id` |
| `object` | expression/reference | `obj_name` |
| `box_id` | string literal | `"prog_vert_lime_box"` |
| `preset` | string literal | `"prog_prompt"` |
| `frame` | string literal | `"lime"` |
| `mug` | string literal | `"prog_lime"` |
| `nameplate` | string literal | `"prog"` |

### 4. `t` — line 89

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `flow` — line 130

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `keep_menu_open` | boolean literal | `true` |
| `lock_dim_alpha` | numeric literal | `0.35` |
| `hide_cursor_when_locked` | boolean literal | `true` |
| `confirm` | nested table | `{ enabled = true, text_format = 'Are you sure you want "%s"?', skip_ids = { exit = true }, }` |
| `post_select` | nested table | `{ enabled = true, text_format = 'You got "%s".', skip_ids = { exit = true }, }` |
| `after_yes_text` | string literal | `"Thank you!{p_1} Is there anything else you'd like?"` |
| `after_no_text` | string literal | `"Is there anything else you'd like?"` |
| `exit_goodbye_text` | string literal | `"Thanks for stopping by!"` |
| `sfx` | nested table | `{ desc = SFX.DESC, confirm = SFX.CONFIRM, close = SFX.DESC_CLOSE, }` |

### 6. `confirm` — line 135

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `text_format` | string literal | `'Are you sure you want "%s"?'` |
| `skip_ids` | nested table | `{ exit = true }` |

### 7. `skip_ids` — line 138

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `exit` | boolean literal | `true` |

### 8. `post_select` — line 141

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `text_format` | string literal | `'You got "%s".'` |
| `skip_ids` | nested table | `{ exit = true }` |

### 9. `skip_ids` — line 144

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `exit` | boolean literal | `true` |

### 10. `sfx` — line 152

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `desc` | expression/reference | `SFX.DESC` |
| `confirm` | expression/reference | `SFX.CONFIRM` |
| `close` | expression/reference | `SFX.DESC_CLOSE` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.create_bot` | 1 |
| `Net.get_bot_name` | 1 |
| `Net.get_object_by_name` | 1 |
| `Net.get_player_position` | 1 |
| `Net.on` | 1 |
| `Net.play_sound` | 1 |
| `Net.play_sound_for_player` | 1 |
| `Net.provide_asset_for_player` | 1 |
| `Net.set_bot_direction` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
