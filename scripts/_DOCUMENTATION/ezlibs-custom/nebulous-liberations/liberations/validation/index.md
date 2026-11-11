# 📄 `validation.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/validation.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/validation.lua)  
> **Source lines:** 254  
> **SHA-256 (UTF-8):** `7e1f5a0aa4ed46…`  
> **Declared/assigned functions detected:** 4  
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

Source-based reference for `scripts/ezlibs-custom/nebulous-liberations/liberations/validation.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 2 | `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |
| 3 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_config` |
| 4 | `scripts/ezlibs-custom/nebulous-liberations/liberations/logger` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 9 | `log` | `level, message` | local |
| 19 | `validate_object` | `area_id, object` | local |
| 136 | `Validation.validate_area` | `area_id` | declared |
| 243 | `Validation.report` | `area_id` | declared |

### Function details

#### 1. `log(level, message)`

- **Location:** source line 9.
- **Declaration style:** `local`.
- **Adjacent source comment:** Separate mission validation output from generic server console logging.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `level` | Not explicitly documented in adjacent source annotations. |
| 2 | `message` | Not explicitly documented in adjacent source annotations. |

#### 2. `validate_object(area_id, object)`

- **Location:** source line 19.
- **Declaration style:** `local`.
- **Adjacent source comment:** Validate a single object

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `area_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `object` | Not explicitly documented in adjacent source annotations. |

#### 3. `Validation.validate_area(area_id)`

- **Location:** source line 136.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Validate a whole area

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `area_id` | Not explicitly documented in adjacent source annotations. |

#### 4. `Validation.report(area_id)`

- **Location:** source line 243.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Print validation results to console

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `area_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **7** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Validation` — line 6

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `details` — line 10

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `message` | expression/reference | `message` |

### 3. `valid_modes` — line 95

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `["Immediate"]` | boolean literal | `true` |
| `[2]` | expression/reference | `["On Dark Hole Cleared"] = true` |
| `["Manual"]` | boolean literal | `true` |
| `[4]` | expression/reference | `["After Boss Defeated"] = true` |

### 4. `boss_object_ids` — line 140

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `boss_ids` — line 141

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `boss_trigger_refs` — line 142

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `panel_boss_refs` — line 143

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.get_area_name` | 2 |
| `Net.get_object_by_id` | 2 |
| `Net.list_objects` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
