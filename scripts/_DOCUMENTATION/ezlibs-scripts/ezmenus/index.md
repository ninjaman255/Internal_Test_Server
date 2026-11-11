# 📄 `ezmenus.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezmenus.lua`](../../../ezlibs-scripts/ezmenus.lua)  
> **Source lines:** 45  
> **SHA-256 (UTF-8):** `c9c06ad13acfd5…`  
> **Declared/assigned functions detected:** 4  
> **Anonymous closures detected:** 5  
> **Table initializers detected:** 1

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

Source-based reference for `scripts/ezlibs-scripts/ezmenus.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 9 | `board_emitter:on` | `board_close` |
| 29 | `Net:on` | `player_disconnect` |
| 30 | `board_emitter:on` | `post_selection` |
| 33 | `board_emitter:on` | `board_close` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 3 | `ezmenus.open_menu` | `player_id, board_name, color, posts` | assigned |
| 5 | `board_emitter.close_async` | `(none)` | assigned |
| 19 | `board_emitter.selection_once` | `(none)` | assigned |
| 23 | `handle_cancel` | `event` | assigned |

### Function details

#### 1. `ezmenus.open_menu(player_id, board_name, color, posts)`

- **Location:** source line 3.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `board_name` | Not explicitly documented in adjacent source annotations. |
| 3 | `color` | Not explicitly documented in adjacent source annotations. |
| 4 | `posts` | Not explicitly documented in adjacent source annotations. |

#### 2. `board_emitter.close_async()`

- **Location:** source line 5.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 3. `board_emitter.selection_once()`

- **Location:** source line 19.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 4. `handle_cancel(event)`

- **Location:** source line 23.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 6 | `(none)` | `_id, board_name, color, posts) board_emitter.close_async = function() return async(` |
| 9 | `event` | `d_closed = false local max_timeout = 2 board_emitter:on("board_close",` |
| 20 | `(none)` | `end end) end board_emitter.selection_once = function() return async(` |
| 30 | `event` | `Net:on("player_disconnect", handle_cancel) board_emitter:on("post_selection",` |
| 33 | `event` | `selection = event.post_id end) board_emitter:on("board_close",` |

## 📦 Tables and data

The following **1** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `ezmenus` — line 1

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.sleep` | 2 |
| `Net.close_bbs` | 1 |
| `Net.on` | 1 |
| `Net.open_board` | 1 |
| `Net.remove_listener` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
