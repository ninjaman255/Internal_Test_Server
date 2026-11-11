# 📄 `ezbus.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezbus.lua`](../../../ezlibs-scripts/ezbus.lua)  
> **Source lines:** 107  
> **SHA-256 (UTF-8):** `85aa9acf06e046…`  
> **Declared/assigned functions detected:** 7  
> **Anonymous closures detected:** 1  
> **Table initializers detected:** 5

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

ezbus.lua - Named event-bus registry. Three usage modes are supported: 1. Named emitters (recommended for cross-script communication) local EzBus = require("scripts/ezlibs-scripts/ezbus") local round_bus = EzBus.get("footbomb:round:" .. instance_id)

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 34 | `scripts/ezlibs-scripts/ezemitter` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 46 | `ezbus.get` | `name` | declared |
| 58 | `ezbus.destroy` | `name` | declared |
| 68 | `ezbus.destroy_all` | `(none)` | declared |
| 75 | `ezbus.exists` | `name` | declared |
| 80 | `ezbus.list` | `(none)` | declared |
| 92 | `__index` | `_, key` | assigned |
| 101 | `__newindex` | `_, key, value` | assigned |

### Function details

#### 1. `ezbus.get(name)`

- **Location:** source line 46.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Retrieve (or lazily create) a named emitter. `nil`/"" returns the default unnamed emitter so callers can pass an optional name.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `name` | Not explicitly documented in adjacent source annotations. |

#### 2. `ezbus.destroy(name)`

- **Location:** source line 58.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Destroy a named bus and drop the registry entry. Does NOT touch the default emitter. Returns true if a bus was actually removed.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `name` | Not explicitly documented in adjacent source annotations. |

#### 3. `ezbus.destroy_all()`

- **Location:** source line 68.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Destroy every named bus. The default emitter is preserved.

#### 4. `ezbus.exists(name)`

- **Location:** source line 75.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `name` | Not explicitly documented in adjacent source annotations. |

#### 5. `ezbus.list()`

- **Location:** source line 80.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 6. `__index(_, key)`

- **Location:** source line 92.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `_` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |

#### 7. `__newindex(_, key, value)`

- **Location:** source line 101.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `_` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `value` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 97 | `_, ...` | `d on the -- real default emitter so its internal state is used. return` |

## 📦 Tables and data

The following **5** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `named` — line 36

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `ezbus` — line 39

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `snapshot` — line 69

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `named` — line 71

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `names` — line 81

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
