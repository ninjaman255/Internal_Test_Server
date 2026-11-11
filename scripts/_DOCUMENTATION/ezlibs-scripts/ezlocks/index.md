# 📄 `ezlocks.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezlocks.lua`](../../../ezlibs-scripts/ezlocks.lua)  
> **Source lines:** 65  
> **SHA-256 (UTF-8):** `1cc7aa3a2580ed…`  
> **Declared/assigned functions detected:** 3  
> **Anonymous closures detected:** 3  
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

ezlocks.lua - Reusable lock/unlock behaviors

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 2 | `scripts/ezlibs-scripts/helpers` |
| 3 | `scripts/ezlibs-scripts/ezmemory` |
| 4 | `scripts/ezlibs-scripts/ezbus` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 9 | `ezlocks.check_password` | `player_id, prompt_message, correct_password` | declared |
| 22 | `ezlocks.check_money` | `player_id, prompt_message, amount, consume` | declared |
| 43 | `ezlocks.check_item` | `player_id, prompt_message, required_item, amount, consume` | declared |

### Function details

#### 1. `ezlocks.check_password(player_id, prompt_message, correct_password)`

- **Location:** source line 9.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Password check

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `prompt_message` | Not explicitly documented in adjacent source annotations. |
| 3 | `correct_password` | Not explicitly documented in adjacent source annotations. |

#### 2. `ezlocks.check_money(player_id, prompt_message, amount, consume)`

- **Location:** source line 22.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Money check

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `prompt_message` | Not explicitly documented in adjacent source annotations. |
| 3 | `amount` | Not explicitly documented in adjacent source annotations. |
| 4 | `consume` | Not explicitly documented in adjacent source annotations. |

#### 3. `ezlocks.check_item(player_id, prompt_message, required_item, amount, consume)`

- **Location:** source line 43.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Item check

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `prompt_message` | Not explicitly documented in adjacent source annotations. |
| 3 | `required_item` | Not explicitly documented in adjacent source annotations. |
| 4 | `amount` | Not explicitly documented in adjacent source annotations. |
| 5 | `consume` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 10 | `(none)` | `function ezlocks.check_password(player_id, prompt_message, correct_password) return …` |
| 23 | `(none)` | `heck function ezlocks.check_money(player_id, prompt_message, amount, consume) return…` |
| 45 | `(none)` | `, prompt_message, required_item, amount, consume) return async(` |

## 📦 Tables and data

The following **1** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `ezlocks` — line 6

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.message_player` | 1 |
| `Async.prompt_player` | 1 |
| `Async.question_player` | 2 |
| `Net.get_player_money` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
