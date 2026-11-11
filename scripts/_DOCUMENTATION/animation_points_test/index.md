# 📄 `animation_points_test.lua`

[🏠 Documentation home](../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/animation_points_test.lua`](../../animation_points_test.lua)  
> **Source lines:** 22  
> **SHA-256 (UTF-8):** `93baf8b49bdb3f…`  
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

Source-based reference for `scripts/animation_points_test.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 2 | `scripts/ezlibs-custom/footbomb/animation_points` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 4 | `check` | `label, frame, point, expected_x, expected_y` | local |

### Function details

#### 1. `check(label, frame, point, expected_x, expected_y)`

- **Location:** source line 4.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `label` | Not explicitly documented in adjacent source annotations. |
| 2 | `frame` | Not explicitly documented in adjacent source annotations. |
| 3 | `point` | Not explicitly documented in adjacent source annotations. |
| 4 | `expected_x` | Not explicitly documented in adjacent source annotations. |
| 5 | `expected_y` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `base` — line 12

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `w` | numeric literal | `36` |
| `h` | numeric literal | `36` |
| `originx` | numeric literal | `19` |
| `originy` | numeric literal | `35` |

### 2. `ball` — line 13

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | numeric literal | `31` |
| `y` | numeric literal | `11` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
