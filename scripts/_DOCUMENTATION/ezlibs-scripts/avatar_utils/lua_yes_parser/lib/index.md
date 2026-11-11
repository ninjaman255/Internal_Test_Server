# 📄 `lib.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/lib.lua`](../../../../../ezlibs-scripts/avatar_utils/lua_yes_parser/lib.lua)  
> **Source lines:** 53  
> **SHA-256 (UTF-8):** `176424700ed33c…`  
> **Declared/assigned functions detected:** 3  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 7

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

Source-based reference for `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/lib.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums` |
| 2 | `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/element` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 6 | `Collector.new` | `(none)` | assigned |
| 14 | `self.handleLine` | `line` | assigned |
| 40 | `parse` | `path` | local |

### Function details

#### 1. `Collector.new()`

- **Location:** source line 6.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 2. `self.handleLine(line)`

- **Location:** source line 14.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `line` | Not explicitly documented in adjacent source annotations. |

#### 3. `parse(path)`

- **Location:** source line 40.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `path` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **7** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Collector` — line 4

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `self` — line 7

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `lineCount` | numeric literal | `0` |
| `pendingAttrs` | nested table | `{}` |
| `elements` | nested table | `{}` |
| `errors` | nested table | `{}` |

### 3. `pendingAttrs` — line 9

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `elements` — line 10

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `errors` — line 11

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `self.pendingAttrs` — line 31

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `return` — line 49

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `parse` | expression/reference | `parse` |
| `enums` | expression/reference | `enums` |
| `element` | expression/reference | `element` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
