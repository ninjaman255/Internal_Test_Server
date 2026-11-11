# 📄 `prog_vert_prompt_emerald.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_vert_prompt_emerald.lua`](../../../../net-games/npcs/prog_vert_prompt_emerald.lua)  
> **Source lines:** 65  
> **SHA-256 (UTF-8):** `924257c9b81997…`  
> **Declared/assigned functions detected:** 1  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 3

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

Shop-themed variant of ProgVertPromptRed: - identical flow + option generator - overrides PromptVertical assets ONLY for this NPC instance

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 8 | `scripts/net-games/npcs/talk` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 25 | `on_interact` | `player_id, _bot_id, bot_name` | assigned |

### Function details

#### 1. `on_interact(player_id, _bot_id, bot_name)`

- **Location:** source line 25.
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

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `options` — line 35

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `count` | numeric literal | `99` |
| `prefix` | string literal | `"Item "` |
| `pad` | numeric literal | `2` |
| `exit_text` | string literal | `"Exit"` |
| `exit_id` | string literal | `"exit"` |

### 2. `texts` — line 38

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `open_question` | string literal | `"Welcome! Wanna browse the shop menu?"` |
| `intro_text` | string literal | `"Take your time. I won't judge your impulse buys."` |
| `decline_open` | string literal | `"No worries. Window shopping is still shopping."` |
| `confirm_format` | string literal | `'Buy "%s"?'` |
| `post_select_format` | string literal | `'You bought "%s".'` |
| `after_yes` | string literal | `"Nice!{p_1} Anything else catch your eye?"` |
| `after_no` | string literal | `"Fair. Anything else?"` |
| `exit_goodbye` | string literal | `"Thanks for stopping by!"` |

### 3. `assets` — line 53

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `menu_bg` | string literal | `"/server/assets/net-games/ui/prompt_vert_menu_shop_an.png"` |
| `menu_bg_anim` | string literal | `"/server/assets/net-games/ui/prompt_vert_menu_an.animation"` |
| `menu_bg_frame` | string literal | `"/server/assets/net-games/ui/prompt_vert_menu_shop_an_frame.png"` |
| `highlight` | string literal | `"/server/assets/net-games/ui/highlight_shop.png"` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
