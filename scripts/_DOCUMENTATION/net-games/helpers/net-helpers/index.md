# 📄 `net-helpers.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/helpers/net-helpers.lua`](../../../../net-games/helpers/net-helpers.lua)  
> **Source lines:** 106  
> **SHA-256 (UTF-8):** `53a5dd55e9a5ea…`  
> **Declared/assigned functions detected:** 5  
> **Anonymous closures detected:** 1  
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

EZLIBS compatibility helpers for net-games Adds: Net:create_timer(seconds, callback) -> handle handle:cancel() Why:

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 25 | `Net:on` | `tick` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 21 | `attach_tick_listener` | `(none)` | local |
| 49 | `NetHelpers.create_timer` | `seconds, callback` | declared |
| 68 | `handle:cancel` | `(none)` | declared |
| 81 | `NetHelpers.safe_require` | `path` | declared |
| 93 | `NetHelpers.patch_net` | `(none)` | declared |

### Function details

#### 1. `attach_tick_listener()`

- **Location:** source line 21.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 2. `NetHelpers.create_timer(seconds, callback)`

- **Location:** source line 49.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Public: Net:create_timer(seconds, callback)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `seconds` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 3. `handle:cancel()`

- **Location:** source line 68.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 4. `NetHelpers.safe_require(path)`

- **Location:** source line 81.
- **Declaration style:** `declared`.
- **Adjacent source comment:** EZLIBS-ish safe_require: load a module without hard-crashing the whole server boot. Returns: module_or_nil, err_or_nil

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `path` | Not explicitly documented in adjacent source annotations. |

#### 5. `NetHelpers.patch_net()`

- **Location:** source line 93.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Patch Net only if missing, so you don't stomp something else later.

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 25 | `event` | `ction attach_tick_listener() if ATTACHED then return end ATTACHED = true Net:on("tic…` |

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `NetHelpers` — line 14

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `TIMERS` — line 19

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `handle` — line 67

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
