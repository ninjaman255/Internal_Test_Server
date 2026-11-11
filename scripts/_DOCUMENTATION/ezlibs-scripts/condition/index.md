# 📄 `condition.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/condition.lua`](../../../ezlibs-scripts/condition.lua)  
> **Source lines:** 93  
> **SHA-256 (UTF-8):** `8f622dfa086310…`  
> **Declared/assigned functions detected:** 8  
> **Anonymous closures detected:** 0  
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

Source-based reference for `scripts/ezlibs-scripts/condition.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 2 | `scripts/ezlibs-scripts/ezmemory` |
| 3 | `scripts/ezlibs-scripts/ezquests` |
| 4 | `scripts/ezlibs-scripts/helpers` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 6 | `condition.date_before` | `date_string` | declared |
| 10 | `condition.date_after` | `date_string` | declared |
| 14 | `condition.item` | `player_id, item_name, amount, consume` | declared |
| 23 | `condition.money` | `player_id, amount, consume` | declared |
| 32 | `condition.fragments` | `player_id, amount, consume` | declared |
| 41 | `condition.tokens` | `player_id, amount, consume` | declared |
| 50 | `condition.quest_flag` | `player_id, quest_name, flag_name, expected, op` | declared |
| 73 | `condition.evaluate` | `player_id, cond` | declared |

### Function details

#### 1. `condition.date_before(date_string)`

- **Location:** source line 6.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `date_string` | Not explicitly documented in adjacent source annotations. |

#### 2. `condition.date_after(date_string)`

- **Location:** source line 10.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `date_string` | Not explicitly documented in adjacent source annotations. |

#### 3. `condition.item(player_id, item_name, amount, consume)`

- **Location:** source line 14.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `item_name` | Not explicitly documented in adjacent source annotations. |
| 3 | `amount` | Not explicitly documented in adjacent source annotations. |
| 4 | `consume` | Not explicitly documented in adjacent source annotations. |

#### 4. `condition.money(player_id, amount, consume)`

- **Location:** source line 23.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `amount` | Not explicitly documented in adjacent source annotations. |
| 3 | `consume` | Not explicitly documented in adjacent source annotations. |

#### 5. `condition.fragments(player_id, amount, consume)`

- **Location:** source line 32.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `amount` | Not explicitly documented in adjacent source annotations. |
| 3 | `consume` | Not explicitly documented in adjacent source annotations. |

#### 6. `condition.tokens(player_id, amount, consume)`

- **Location:** source line 41.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `amount` | Not explicitly documented in adjacent source annotations. |
| 3 | `consume` | Not explicitly documented in adjacent source annotations. |

#### 7. `condition.quest_flag(player_id, quest_name, flag_name, expected, op)`

- **Location:** source line 50.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `quest_name` | Not explicitly documented in adjacent source annotations. |
| 3 | `flag_name` | Not explicitly documented in adjacent source annotations. |
| 4 | `expected` | Not explicitly documented in adjacent source annotations. |
| 5 | `op` | Not explicitly documented in adjacent source annotations. |

#### 8. `condition.evaluate(player_id, cond)`

- **Location:** source line 73.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `cond` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **1** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `condition` — line 1

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
