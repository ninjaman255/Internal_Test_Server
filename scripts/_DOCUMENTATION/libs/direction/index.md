# 📄 `direction.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/libs/direction.lua`](../../../libs/direction.lua)  
> **Source lines:** 86  
> **SHA-256 (UTF-8):** `6af17183d741bc…`  
> **Declared/assigned functions detected:** 5  
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

Source-based reference for `scripts/libs/direction.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 23 | `Direction.reverse` | `direction` | declared |
| 27 | `Direction.from_points` | `point_a, point_b` | declared |
| 39 | `Direction.diagonal_from_points` | `point_a, point_b` | declared |
| 62 | `Direction.from_offset` | `x, y` | declared |
| 68 | `Direction.diagonal_from_offset` | `x, y` | declared |

### Function details

#### 1. `Direction.reverse(direction)`

- **Location:** source line 23.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 2. `Direction.from_points(point_a, point_b)`

- **Location:** source line 27.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `point_a` | Not explicitly documented in adjacent source annotations. |
| 2 | `point_b` | Not explicitly documented in adjacent source annotations. |

#### 3. `Direction.diagonal_from_points(point_a, point_b)`

- **Location:** source line 39.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `point_a` | Not explicitly documented in adjacent source annotations. |
| 2 | `point_b` | Not explicitly documented in adjacent source annotations. |

#### 4. `Direction.from_offset(x, y)`

- **Location:** source line 62.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |

#### 5. `Direction.diagonal_from_offset(x, y)`

- **Location:** source line 68.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Direction` — line 1

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `UP` | string literal | `"Up"` |
| `LEFT` | string literal | `"Left"` |
| `DOWN` | string literal | `"Down"` |
| `RIGHT` | string literal | `"Right"` |
| `UP_LEFT` | string literal | `"Up Left"` |
| `UP_RIGHT` | string literal | `"Up Right"` |
| `DOWN_LEFT` | string literal | `"Down Left"` |
| `DOWN_RIGHT` | string literal | `"Down Right"` |

### 2. `reverse_table` — line 12

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `["Up"]` | string literal | `"Down"` |
| `["Left"]` | string literal | `"Right"` |
| `["Down"]` | string literal | `"Up"` |
| `["Right"]` | string literal | `"Left"` |
| `[5]` | expression/reference | `["Up Left"] = "Down Right"` |
| `[6]` | expression/reference | `["Up Right"] = "Down Left"` |
| `[7]` | expression/reference | `["Down Left"] = "Up Right"` |
| `[8]` | expression/reference | `["Down Right"] = "Up Left"` |

### 3. `directions` — line 51

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Up Left"` |
| `[2]` | string literal | `"Up"` |
| `[3]` | string literal | `"Up Right"` |
| `[4]` | string literal | `"Right"` |
| `[5]` | string literal | `"Down Right"` |
| `[6]` | string literal | `"Down"` |
| `[7]` | string literal | `"Down Left"` |
| `[8]` | string literal | `"Left"` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
