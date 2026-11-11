# 📄 `prog_vert_prompt_red.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_vert_prompt_red.lua`](../../../../net-games/npcs/prog_vert_prompt_red.lua)  
> **Source lines:** 58  
> **SHA-256 (UTF-8):** `1d1c28fd605419…`  
> **Declared/assigned functions detected:** 1  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 2

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

Max-condensed example: - no Net:on in this file - no TalkVertMenu.open in this file - no SFX table in this file - no exit_index math in this file

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 11 | `scripts/net-games/npcs/talk` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 26 | `on_interact` | `player_id, _bot_id, bot_name` | assigned |

### Function details

#### 1. `on_interact(player_id, _bot_id, bot_name)`

- **Location:** source line 26.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `_bot_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `bot_name` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `options` — line 36

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `count` | numeric literal | `99` |
| `prefix` | string literal | `"Red Option "` |
| `pad` | numeric literal | `2` |
| `exit_text` | string literal | `"Exit"` |
| `exit_id` | string literal | `"exit"` |

### 2. `texts` — line 40

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `open_question` | string literal | `"Do you wanna check out the vertical menu?"` |
| `intro_text` | string literal | `"Awesome. Let me know if there's anything that you like."` |
| `decline_open` | string literal | `"No worries. Maybe next time."` |
| `confirm_format` | string literal | `'Are you sure you want "%s"?'` |
| `post_select_format` | string literal | `'You got "%s".'` |
| `after_yes` | string literal | `"Thank you!{p_1} Is there anything else you'd like?"` |
| `after_no` | string literal | `"No worries. Anything else?"` |
| `exit_goodbye` | string literal | `"Thanks for stopping by!"` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
