# 📄 `enums.lua`

[🏠 Documentation home](../../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums.lua`](../../../../../../ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums.lua)  
> **Source lines:** 68  
> **SHA-256 (UTF-8):** `3decc38959d566…`  
> **Declared/assigned functions detected:** 2  
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

Source-based reference for `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 25 | `glyphForType` | `type` | assigned |
| 40 | `glyphIsReserved` | `glyph` | assigned |

### Function details

#### 1. `glyphForType(type)`

- **Location:** source line 25.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `type` | Not explicitly documented in adjacent source annotations. |

#### 2. `glyphIsReserved(glyph)`

- **Location:** source line 40.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `glyph` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **1** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `return` — line 61

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `Delimiters` | expression/reference | `Delimiters` |
| `ElementTypes` | expression/reference | `ElementTypes` |
| `Glyphs` | expression/reference | `Glyphs` |
| `glyphForType` | expression/reference | `glyphForType` |
| `glyphIsReserved` | expression/reference | `glyphIsReserved` |
| `ErrorTypes` | expression/reference | `ErrorTypes` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
