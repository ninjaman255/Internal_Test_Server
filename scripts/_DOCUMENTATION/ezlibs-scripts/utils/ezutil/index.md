# 📄 `ezutil.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/utils/ezutil.lua`](../../../../ezlibs-scripts/utils/ezutil.lua)  
> **Source lines:** 96  
> **SHA-256 (UTF-8):** `8fce621f2fd289…`  
> **Declared/assigned functions detected:** 8  
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

Small, dependency-free helpers for Lua 5.2. This module does not depend on ezlibs host APIs.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 7 | `ezutil.clamp` | `value, minimum, maximum` | declared |
| 18 | `ezutil.table_contains` | `list, value` | declared |
| 26 | `ezutil.table_remove_value` | `list, value, remove_all` | declared |
| 44 | `ezutil.table_count` | `value` | declared |
| 53 | `ezutil.table_is_empty` | `value` | declared |
| 58 | `ezutil.shallow_copy` | `source` | declared |
| 68 | `ezutil.deep_copy` | `source, seen` | declared |
| 85 | `ezutil.table_merge` | `target, source` | declared |

### Function details

#### 1. `ezutil.clamp(value, minimum, maximum)`

- **Location:** source line 7.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `minimum` | Not explicitly documented in adjacent source annotations. |
| 3 | `maximum` | Not explicitly documented in adjacent source annotations. |

#### 2. `ezutil.table_contains(list, value)`

- **Location:** source line 18.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `list` | Not explicitly documented in adjacent source annotations. |
| 2 | `value` | Not explicitly documented in adjacent source annotations. |

#### 3. `ezutil.table_remove_value(list, value, remove_all)`

- **Location:** source line 26.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `list` | Not explicitly documented in adjacent source annotations. |
| 2 | `value` | Not explicitly documented in adjacent source annotations. |
| 3 | `remove_all` | Not explicitly documented in adjacent source annotations. |

#### 4. `ezutil.table_count(value)`

- **Location:** source line 44.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 5. `ezutil.table_is_empty(value)`

- **Location:** source line 53.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 6. `ezutil.shallow_copy(source)`

- **Location:** source line 58.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `source` | Not explicitly documented in adjacent source annotations. |

#### 7. `ezutil.deep_copy(source, seen)`

- **Location:** source line 68.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Copies table keys and values recursively. Handles cycles and shared references.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `source` | Not explicitly documented in adjacent source annotations. |
| 2 | `seen` | Not explicitly documented in adjacent source annotations. |

#### 8. `ezutil.table_merge(target, source)`

- **Location:** source line 85.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Copies keys from source into target. Existing target keys are overwritten.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `target` | Not explicitly documented in adjacent source annotations. |
| 2 | `source` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `ezutil` — line 5

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `copy` — line 60

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `copy` — line 74

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
