# 📄 `battle_scale.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/battle_scale.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/battle_scale.lua)  
> **Source lines:** 138  
> **SHA-256 (UTF-8):** `500b7a17df5846…`  
> **Declared/assigned functions detected:** 4  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 5

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

Battle rendering policy is independent of persistent overworld HP. Resolve one configured scale for a battle, then apply it to selected encounter enemy entries WITHOUT mutating the cached encounter definition. Target policy: Matching: all entries matching the OW template/display alias; if a

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 15 | `scripts/ezlibs-custom/nebulous-liberations/liberations/logger` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 19 | `positive` | `value` | local |
| 25 | `normalized` | `name` | local |
| 30 | `scope_for` | `source, options` | local |
| 38 | `BattleScale.apply` | `data, source, options` | declared |

### Function details

#### 1. `positive(value)`

- **Location:** source line 19.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 2. `normalized(name)`

- **Location:** source line 25.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `name` | Not explicitly documented in adjacent source annotations. |

#### 3. `scope_for(source, options)`

- **Location:** source line 30.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `source` | Not explicitly documented in adjacent source annotations. |
| 2 | `options` | Not explicitly documented in adjacent source annotations. |

#### 4. `BattleScale.apply(data, source, options)`

- **Location:** source line 38.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `data` | Not explicitly documented in adjacent source annotations. |
| 2 | `source` | Not explicitly documented in adjacent source annotations. |
| 3 | `options` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **5** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `BattleScale` — line 17

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `result` — line 41

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `count` | numeric literal | `0` |
| `scale` | nil | `nil` |
| `target` | nil | `nil` |
| `scope` | expression/reference | `scope_for(source, options)` |
| `matched_name` | nil | `nil` |
| `reason` | nil | `nil` |

### 3. `targets` — line 65

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `summary` — line 107

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `fields` — line 116

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `base_area_id` | expression/reference | `options.base_area_id` |
| `source_object_id` | expression/reference | `options.source_object_id` |
| `encounter_name` | expression/reference | `options.encounter_name` |
| `encounter_source` | expression/reference | `options.encounter_source` |
| `source_enemy_template` | expression/reference | `source.template_name` |
| `requested_scale` | expression/reference | `requested` |
| `ow_scale` | expression/reference | `source.ow_scale or source.scale` |
| `battle_scale` | expression/reference | `source.battle_scale` |
| `explicit_battle_scale` | expression/reference | `source.battle_scale_explicit == true` |
| `scope` | expression/reference | `result.scope` |
| `target` | expression/reference | `result.target` |
| `updated_count` | expression/reference | `result.count` |
| `reason` | expression/reference | `result.reason` |
| `final_enemies` | expression/reference | `summary` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
