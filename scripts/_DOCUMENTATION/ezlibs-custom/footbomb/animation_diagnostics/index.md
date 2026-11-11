# 📄 `animation_diagnostics.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/footbomb/animation_diagnostics.lua`](../../../../ezlibs-custom/footbomb/animation_diagnostics.lua)  
> **Source lines:** 99  
> **SHA-256 (UTF-8):** `71b1236dbd6ba3…`  
> **Declared/assigned functions detected:** 4  
> **Anonymous closures detected:** 1  
> **Table initializers detected:** 4

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

Startup diagnostics for FootBomb's active v2.0 Navi animations and their optional v2.5 .ani counterparts. This module is read-only: it never changes the animation state used by Net.animate_bot.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 4 | `scripts/boom/main` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 8 | `emit` | `log, message` | local |
| 12 | `sorted_state_names` | `states` | local |
| 19 | `inspect_file` | `option, path, expected_state, log` | local |
| 82 | `Diagnostics.run` | `options, log` | declared |

### Function details

#### 1. `emit(log, message)`

- **Location:** source line 8.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `log` | Not explicitly documented in adjacent source annotations. |
| 2 | `message` | Not explicitly documented in adjacent source annotations. |

#### 2. `sorted_state_names(states)`

- **Location:** source line 12.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `states` | Not explicitly documented in adjacent source annotations. |

#### 3. `inspect_file(option, path, expected_state, log)`

- **Location:** source line 19.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `option` | Not explicitly documented in adjacent source annotations. |
| 2 | `path` | Not explicitly documented in adjacent source annotations. |
| 3 | `expected_state` | Not explicitly documented in adjacent source annotations. |
| 4 | `log` | Not explicitly documented in adjacent source annotations. |

#### 4. `Diagnostics.run(options, log)`

- **Location:** source line 82.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `options` | Not explicitly documented in adjacent source annotations. |
| 2 | `log` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 53 | `(none)` | `te_name .. " frame=" .. index .. " label=" .. point_name .. " values=" .. (` |

## 📦 Tables and data

The following **4** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Diagnostics` — line 6

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `names` — line 13

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `point_names` — line 47

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `parts` — line 54

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
