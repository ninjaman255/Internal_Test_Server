# 📄 `mob_tracker.lua`

> ⚠️ **Archive-only reference:** The source file `assets/bosses/com_louise_mob_HeelNavi/allies/Volgear/shared/mob_tracker.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../../../../../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `assets/bosses/com_louise_mob_HeelNavi/allies/Volgear/shared/mob_tracker.lua` (not present in the current server ZIP).  
> **Source lines:** 76  
> **SHA-256 (UTF-8):** `42309b87e47c95…`  
> **Declared/assigned functions detected:** 10  
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

Source-based reference for `assets/bosses/com_louise_mob_HeelNavi/allies/Volgear/shared/mob_tracker.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 3 | `MobTracker:new` | `(none)` | declared |
| 14 | `MobTracker:add_by_id` | `mob_id` | declared |
| 19 | `MobTracker:print_ids` | `(none)` | declared |
| 25 | `MobTracker:sort_turn_order` | `sort_function,reverse_sorting` | declared |
| 27 | `reversable_sort` | `a,b` | assigned |
| 37 | `MobTracker:get_index` | `mob_id` | declared |
| 46 | `MobTracker:remove_by_id` | `mob_id` | declared |
| 58 | `MobTracker:clear` | `(none)` | declared |
| 65 | `MobTracker:get_active_mob` | `(none)` | declared |
| 69 | `MobTracker:advance_a_turn` | `(none)` | declared |

### Function details

#### 1. `MobTracker:new()`

- **Location:** source line 3.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 2. `MobTracker:add_by_id(mob_id)`

- **Location:** source line 14.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `mob_id` | Not explicitly documented in adjacent source annotations. |

#### 3. `MobTracker:print_ids()`

- **Location:** source line 19.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 4. `MobTracker:sort_turn_order(sort_function,reverse_sorting)`

- **Location:** source line 25.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sort_function` | Not explicitly documented in adjacent source annotations. |
| 2 | `reverse_sorting` | Not explicitly documented in adjacent source annotations. |

#### 5. `reversable_sort(a,b)`

- **Location:** source line 27.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** print('sorting mob tracker turn order')

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |

#### 6. `MobTracker:get_index(mob_id)`

- **Location:** source line 37.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `mob_id` | Not explicitly documented in adjacent source annotations. |

#### 7. `MobTracker:remove_by_id(mob_id)`

- **Location:** source line 46.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `mob_id` | Not explicitly documented in adjacent source annotations. |

#### 8. `MobTracker:clear()`

- **Location:** source line 58.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 9. `MobTracker:get_active_mob()`

- **Location:** source line 65.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 10. `MobTracker:advance_a_turn()`

- **Location:** source line 69.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `MobTracker` — line 2

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `o` — line 4

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `o.tbl_mobs` — line 8

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
