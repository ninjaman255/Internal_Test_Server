# 📄 `keyval.lua`

[🏠 Documentation home](../../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/keyval.lua`](../../../../../../ezlibs-scripts/avatar_utils/lua_yes_parser/src/keyval.lua)  
> **Source lines:** 22  
> **SHA-256 (UTF-8):** `fba4b30476d2ab…`  
> **Declared/assigned functions detected:** 2  
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

Source-based reference for `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/keyval.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 2 | `KeyVal.new` | `key, val` | assigned |
| 8 | `__tostring` | `self` | assigned |

### Function details

#### 1. `KeyVal.new(key, val)`

- **Location:** source line 2.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |
| 2 | `val` | Not explicitly documented in adjacent source annotations. |

#### 2. `__tostring(self)`

- **Location:** source line 8.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `KeyVal` — line 1

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `this` — line 3

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `key` | expression/reference | `key` |
| `val` | expression/reference | `val` |

### 3. `mt` — line 16

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `__tostring` | expression/reference | `__tostring` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
