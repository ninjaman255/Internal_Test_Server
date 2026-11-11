# 📄 `utility.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/utils/utility.lua`](../../../utils/utility.lua)  
> **Source lines:** 53  
> **SHA-256 (UTF-8):** `ba6238222dd900…`  
> **Declared/assigned functions detected:** 4  
> **Anonymous closures detected:** 4  
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

Main module that integrates EventEmitter and Async

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 7 | `scripts/utils/event-emitter` |
| 8 | `scripts/utils/async` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 17 | `Utility.create_event_test` | `(none)` | declared |
| 21 | `start_listening` | `(none)` | local |
| 37 | `Utility.resolve_multi` | `...` | declared |
| 45 | `Utility.event_to_promise` | `emitter, event_name` | declared |

### Function details

#### 1. `Utility.create_event_test()`

- **Location:** source line 17.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Example usage pattern from the original code

#### 2. `start_listening()`

- **Location:** source line 21.
- **Declaration style:** `local`.
- **Adjacent source comment:** Example of async iteration

#### 3. `Utility.resolve_multi(...)`

- **Location:** source line 37.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Helper for multi-value promises

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 4. `Utility.event_to_promise(emitter, event_name)`

- **Location:** source line 45.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Event-driven promise

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `emitter` | Not explicitly documented in adjacent source annotations. |
| 2 | `event_name` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 24 | `(none)` | `rt_listening() local iter = emitter:async_iter("data") Utility.run(` |
| 39 | `resolve` | `function Utility.resolve_multi(...) local args = {...} return Utility.create_promise(` |
| 46 | `resolve` | `ise function Utility.event_to_promise(emitter, event_name) return Utility.create_pro…` |
| 47 | `...` | `t_name) return Utility.create_promise(function(resolve) emitter:once(event_name,` |

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Utility` — line 4

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `args` — line 38

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `...` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
