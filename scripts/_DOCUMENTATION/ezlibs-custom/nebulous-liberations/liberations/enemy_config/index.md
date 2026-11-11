# 📄 `enemy_config.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_config.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/enemy_config.lua)  
> **Source lines:** 156  
> **SHA-256 (UTF-8):** `36dbb24421aa62…`  
> **Declared/assigned functions detected:** 11  
> **Anonymous closures detected:** 2  
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

Tiled enemy settings resolver. Config object and category defaults are optional. Precedence: local object > referenced Enemy Config > category defaults > template. Empty strings and numeric zero mean "inherit" for optional numeric overrides.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 4 | `scripts/ezlibs-custom/nebulous-liberations/liberations/logger` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 9 | `props` | `object` | local |
| 13 | `trim` | `value` | local |
| 17 | `defined` | `value` | local |
| 21 | `number` | `value, allow_zero` | local |
| 30 | `get_object` | `area_id, reference, expected_type` | local |
| 42 | `area_defaults` | `area_id, category` | local |
| 64 | `Config.resolve` | `area_id, source, legacy_health_property, category` | declared |
| 70 | `get` | `key` | local |
| 76 | `positive` | `key` | local |
| 77 | `text` | `key` | local |
| 129 | `Config.apply` | `enemy, cfg` | declared |

### Function details

#### 1. `props(object)`

- **Location:** source line 9.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `object` | Not explicitly documented in adjacent source annotations. |

#### 2. `trim(value)`

- **Location:** source line 13.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 3. `defined(value)`

- **Location:** source line 17.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 4. `number(value, allow_zero)`

- **Location:** source line 21.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `allow_zero` | Not explicitly documented in adjacent source annotations. |

#### 5. `get_object(area_id, reference, expected_type)`

- **Location:** source line 30.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `area_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `reference` | Not explicitly documented in adjacent source annotations. |
| 3 | `expected_type` | Not explicitly documented in adjacent source annotations. |

#### 6. `area_defaults(area_id, category)`

- **Location:** source line 42.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `area_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `category` | Not explicitly documented in adjacent source annotations. |

#### 7. `Config.resolve(area_id, source, legacy_health_property, category)`

- **Location:** source line 64.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `area_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `source` | Not explicitly documented in adjacent source annotations. |
| 3 | `legacy_health_property` | Not explicitly documented in adjacent source annotations. |
| 4 | `category` | Not explicitly documented in adjacent source annotations. |

#### 8. `get(key)`

- **Location:** source line 70.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |

#### 9. `positive(key)`

- **Location:** source line 76.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |

#### 10. `text(key)`

- **Location:** source line 77.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |

#### 11. `Config.apply(enemy, cfg)`

- **Location:** source line 129.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `enemy` | Not explicitly documented in adjacent source annotations. |
| 2 | `cfg` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 48 | `a, b` | `pe(ids) ~= "table" then return {}, {} end local all, specific = {}, {} table.sort(id…` |
| 118 | `(none)` | `battle_defense_multiplier = positive("Battle Defense Multiplier"), ai_type = (` |

## 📦 Tables and data

The following **4** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Config` — line 7

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `return` — line 46

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `specific` — line 47

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `return` — line 107

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `template_name` | expression/reference | `template_name` |
| `max_hp` | expression/reference | `max_hp` |
| `starting_hp` | expression/reference | `starting_hp` |
| `ow_scale` | expression/reference | `ow_scale` |
| `battle_scale` | expression/reference | `battle_scale` |
| `battle_scale_explicit` | expression/reference | `explicit_battle_scale ~= nil` |
| `battle_scale_scope` | expression/reference | `scope` |
| `ow_attack_damage` | expression/reference | `positive("OW Attack Damage")` |
| `ow_damage_multiplier` | expression/reference | `positive("OW Damage Multiplier")` |
| `ow_defense_multiplier` | expression/reference | `positive("OW Defense Multiplier")` |
| `battle_attack_multiplier` | expression/reference | `positive("Battle Attack Multiplier")` |
| `battle_defense_multiplier` | expression/reference | `positive("Battle Defense Multiplier")` |
| `ai_type` | expression/reference | `(function() local value = text("AI Type") return value ~= "Auto" and value or nil end)()` |
| `encounter_name` | expression/reference | `text("OW Bot Encounter") or text("Boss Encounter")` |
| `encounter_mode` | expression/reference | `text("Encounter Mode") or "Auto"` |
| `encounter_pool` | expression/reference | `get("OW Encounter Pool")` |
| `encounter_category` | expression/reference | `text("Encounter Category")` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
