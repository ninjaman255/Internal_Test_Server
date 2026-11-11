# 📄 `selection.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/selection.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/selection.lua)  
> **Source lines:** 189  
> **SHA-256 (UTF-8):** `22a4901ae3afbf…`  
> **Declared/assigned functions detected:** 9  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 8

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

Source-based reference for `scripts/ezlibs-custom/nebulous-liberations/liberations/selection.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/libs/direction` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 5 | `generate_selection_object` | `self` | local |
| 22 | `Selection:new` | `instance` | declared |
| 41 | `Selection:set_filter` | `filter` | declared |
| 54 | `Selection:set_indicator` | `indicator` | declared |
| 59 | `Selection:set_shape` | `shape, shape_offset_x, shape_offset_y` | declared |
| 65 | `Selection:move` | `position, direction` | declared |
| 72 | `Selection:is_within` | `x, y, z` | declared |
| 128 | `Selection:indicate` | `(none)` | declared |
| 180 | `Selection:remove_indicators` | `(none)` | declared |

### Function details

#### 1. `generate_selection_object(self)`

- **Location:** source line 5.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 2. `Selection:new(instance)`

- **Location:** source line 22.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |

#### 3. `Selection:set_filter(filter)`

- **Location:** source line 41.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `filter` | Not explicitly documented in adjacent source annotations. |

#### 4. `Selection:set_indicator(indicator)`

- **Location:** source line 54.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `indicator` | Not explicitly documented in adjacent source annotations. |

#### 5. `Selection:set_shape(shape, shape_offset_x, shape_offset_y)`

- **Location:** source line 59.
- **Declaration style:** `declared`.
- **Adjacent source comment:** shape = [m][n] bool array, n being odd, just below bottom center is actor position
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `shape` | Not explicitly documented in adjacent source annotations. |
| 2 | `shape_offset_x` | Not explicitly documented in adjacent source annotations. |
| 3 | `shape_offset_y` | Not explicitly documented in adjacent source annotations. |

#### 6. `Selection:move(position, direction)`

- **Location:** source line 65.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `position` | Not explicitly documented in adjacent source annotations. |
| 2 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 7. `Selection:is_within(x, y, z)`

- **Location:** source line 72.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |
| 3 | `z` | Not explicitly documented in adjacent source annotations. |

#### 8. `Selection:indicate()`

- **Location:** source line 128.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 9. `Selection:remove_indicators()`

- **Location:** source line 180.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **8** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `return` — line 6

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `self.position.x + self.indicator.offset_x / 32` |
| `y` | expression/reference | `self.position.y + self.indicator.offset_y / 32` |
| `z` | expression/reference | `self.position.z` |
| `width` | expression/reference | `self.indicator.width / 32` |
| `height` | expression/reference | `self.indicator.height / 32` |
| `data` | nested table | `{ type = "tile", gid = self.indicator.gid, }` |

### 2. `data` — line 12

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | string literal | `"tile"` |
| `gid` | expression/reference | `self.indicator.gid` |

### 3. `Selection` — line 20

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `attack_collider` — line 23

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `instance` | expression/reference | `instance` |
| `position` | nested table | `{ x = 0, y = 0, z = 0 }` |
| `shape` | nested table | `{}` |
| `shape_offset_x` | numeric literal | `0` |
| `shape_offset_y` | numeric literal | `0` |
| `direction` | nil | `nil` |
| `filter` | nil | `nil` |
| `objects` | nested table | `{}` |
| `indicator` | nil | `nil` |

### 5. `position` — line 25

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | numeric literal | `0` |
| `y` | numeric literal | `0` |
| `z` | numeric literal | `0` |

### 6. `shape` — line 26

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `objects` — line 31

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `self.objects` — line 186

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.create_object` | 1 |
| `Net.remove_object` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
