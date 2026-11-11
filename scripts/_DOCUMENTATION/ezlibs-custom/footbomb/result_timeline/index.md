# 📄 `result_timeline.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/footbomb/result_timeline.lua`](../../../../ezlibs-custom/footbomb/result_timeline.lua)  
> **Source lines:** 57  
> **SHA-256 (UTF-8):** `1b51ed585de176…`  
> **Declared/assigned functions detected:** 2  
> **Anonymous closures detected:** 0  
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

Pure timing helpers for FootBomb's result sequence. This module deliberately does not animate actors or wait on async tasks; it calculates timing boundaries from authored animation data and gameplay travel estimates so callers can coordinate their own event-driven tracks.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 7 | `ResultTimeline.state_timing` | `state` | declared |
| 39 | `ResultTimeline.shared_response_duration` | `options` | declared |

### Function details

#### 1. `ResultTimeline.state_timing(state)`

- **Location:** source line 7.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `state` | Not explicitly documented in adjacent source annotations. |

#### 2. `ResultTimeline.shared_response_duration(options)`

- **Location:** source line 39.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `options` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `ResultTimeline` — line 5

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `return` — line 30

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `frame_count` | expression/reference | `#frames` |
| `total_duration` | expression/reference | `total_duration` |
| `movement_duration` | expression/reference | `movement_duration` |
| `final_frame_duration` | expression/reference | `math.max(0, tonumber(frames[#frames].duration) or 0)` |
| `final_frame_start` | expression/reference | `movement_duration` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
