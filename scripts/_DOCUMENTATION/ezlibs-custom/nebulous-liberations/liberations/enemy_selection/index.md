# 📄 `enemy_selection.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua)  
> **Source lines:** 69  
> **SHA-256 (UTF-8):** `e5f50970f14448…`  
> **Declared/assigned functions detected:** 7  
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

Source-based reference for `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/ezlibs-custom/nebulous-liberations/liberations/selection` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 5 | `EnemySelection:new` | `instance` | declared |
| 16 | `filter` | `x, y, z` | local |
| 36 | `EnemySelection:set_shape` | `shape, shape_offset_x, shape_offset_y` | declared |
| 40 | `EnemySelection:move` | `position, direction` | declared |
| 45 | `EnemySelection:detect_player_sessions` | `(none)` | declared |
| 59 | `EnemySelection:indicate` | `(none)` | declared |
| 63 | `EnemySelection:remove_indicators` | `(none)` | declared |

### Function details

#### 1. `EnemySelection:new(instance)`

- **Location:** source line 5.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |

#### 2. `filter(x, y, z)`

- **Location:** source line 16.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |
| 3 | `z` | Not explicitly documented in adjacent source annotations. |

#### 3. `EnemySelection:set_shape(shape, shape_offset_x, shape_offset_y)`

- **Location:** source line 36.
- **Declaration style:** `declared`.
- **Adjacent source comment:** shape = [m][n] bool array, n being odd, just below bottom center is enemy position
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `shape` | Not explicitly documented in adjacent source annotations. |
| 2 | `shape_offset_x` | Not explicitly documented in adjacent source annotations. |
| 3 | `shape_offset_y` | Not explicitly documented in adjacent source annotations. |

#### 4. `EnemySelection:move(position, direction)`

- **Location:** source line 40.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `position` | Not explicitly documented in adjacent source annotations. |
| 2 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 5. `EnemySelection:detect_player_sessions()`

- **Location:** source line 45.
- **Declaration style:** `declared`.
- **Adjacent source comment:** returns player sessions that collide
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 6. `EnemySelection:indicate()`

- **Location:** source line 59.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 7. `EnemySelection:remove_indicators()`

- **Location:** source line 63.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `EnemySelection` — line 3

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `enemy_selection` — line 6

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `instance` | expression/reference | `instance` |
| `selection` | expression/reference | `Selection:new(instance)` |

### 3. `sessions` — line 46

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.get_tile` | 1 |
| `Net.get_tileset` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
