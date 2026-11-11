# 📄 `urlencode.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/urlencode.lua`](../../../ezlibs-scripts/urlencode.lua)  
> **Source lines:** 46  
> **SHA-256 (UTF-8):** `154e0b80c9e723…`  
> **Declared/assigned functions detected:** 2  
> **Anonymous closures detected:** 1  
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

Source-based reference for `scripts/ezlibs-scripts/urlencode.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `string` |
| 2 | `table` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 8 | `encode` | `str` | local |
| 29 | `urlencode.table` | `t` | declared |

### Function details

#### 1. `encode(str)`

- **Location:** source line 8.
- **Declaration style:** `local`.
- **Adjacent source comment:** URL encode a string.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |

#### 2. `urlencode.table(t)`

- **Location:** source line 29.
- **Declaration style:** `declared`.
- **Adjacent source comment:** URL encode a table as a series of parameters.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 17 | `c` | `-(except for space, which gets plus-encoded) str = string.gsub (str, "([^%w%-%.%_%~ …` |

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `urlencode` — line 5

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `argts` — line 32

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
