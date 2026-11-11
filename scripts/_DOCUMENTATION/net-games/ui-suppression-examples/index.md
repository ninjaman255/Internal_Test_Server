# 📄 `ui-suppression-examples.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/ui-suppression-examples.lua`](../../../net-games/ui-suppression-examples.lua)  
> **Source lines:** 36  
> **SHA-256 (UTF-8):** `b0e7b91a540bdf…`  
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

Usage examples for scripts/net-games/ui-suppression.lua. This file is documentation only; it is not required by the framework.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 3 | `scripts/net-games/ui-suppression` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 25 | `acquire` | `pid, owner, options` | assigned |
| 30 | `release` | `pid, token` | assigned |

### Function details

#### 1. `acquire(pid, owner, options)`

- **Location:** source line 25.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `owner` | Not explicitly documented in adjacent source annotations. |
| 3 | `options` | Not explicitly documented in adjacent source annotations. |

#### 2. `release(pid, token)`

- **Location:** source line 30.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pid` | Not explicitly documented in adjacent source annotations. |
| 2 | `token` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **1** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `return` — line 28

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `owner` | expression/reference | `owner` |
| `options` | expression/reference | `options` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
