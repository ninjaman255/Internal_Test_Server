# 📄 `ezcache.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezcache.lua`](../../../ezlibs-scripts/ezcache.lua)  
> **Source lines:** 59  
> **SHA-256 (UTF-8):** `10baf11108a380…`  
> **Declared/assigned functions detected:** 4  
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

Source-based reference for `scripts/ezlibs-scripts/ezcache.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 6 | `ezcache.add_cacheable_type` | `type_name` | declared |
| 11 | `ezcache.object_is_of_type` | `object` | declared |
| 16 | `ezcache.cache_object` | `area_id, object` | declared |
| 36 | `ezcache.get_object_by_id_cached` | `area_id, object_id` | declared |

### Function details

#### 1. `ezcache.add_cacheable_type(type_name)`

- **Location:** source line 6.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Add a type to the cacheable set

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `type_name` | Not explicitly documented in adjacent source annotations. |

#### 2. `ezcache.object_is_of_type(object)`

- **Location:** source line 11.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Check if an object type should be cached

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `object` | Not explicitly documented in adjacent source annotations. |

#### 3. `ezcache.cache_object(area_id, object)`

- **Location:** source line 16.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Store a pre‑fetched object in the cache and remove it from Net

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `area_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `object` | Not explicitly documented in adjacent source annotations. |

#### 4. `ezcache.get_object_by_id_cached(area_id, object_id)`

- **Location:** source line 36.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Get an object by ID, using cache and fetching if necessary

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `area_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `object_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `ezcache` — line 1

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `ezcache.cache` — line 2

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `ezcache.cacheable_types` — line 3

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.get_object_by_id` | 1 |
| `Net.remove_object` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
