# 📄 `panel_encounters.lua` — Current Lua reference

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua)  
> **Source lines:** 511  
> **SHA-256 (UTF-8):** `8d8cdf20974d3800339731cd057e11cb6b083abc0fa098d7f6f182b625da4fdc`  
> **Named/assigned functions detected:** 16  
> **Table initializers detected:** 17

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 2 | `scripts/ezlibs-custom/nebulous-liberations/liberations/logger` |
| 3 | `scripts/ezlibs-scripts/ezconfig` |
| 215 | `scripts/ezlibs-scripts/ezencounters/main` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 65 | `has_dark_panel` | `instance, x, y, z` | local |
| 69 | `includes` | `values, value` | local |
| 80 | `PanelEncounters.resolve_terrain` | `instance, player` | assigned/declared |
| 109 | `candidate_area_keys` | `base_area_id` | local |
| 124 | `load_area_encounter_table` | `base_area_id` | local |
| 152 | `pick_encounter` | `encounter_table, category` | local |
| 186 | `PanelEncounters.pick_weighted` | `candidates` | assigned/declared |
| 213 | `PanelEncounters.resolve_encounter_value` | `reference, base_area_id` | assigned/declared |
| 226 | `PanelEncounters.resolve_named_encounter` | `base_area_id, category, reference` | assigned/declared |
| 263 | `PanelEncounters.resolve_dark_hole_liberation_encounters` | `base_area_id, object_reference` | assigned/declared |
| 302 | `nonempty` | `value` | local |
| 309 | `normalize_category` | `value, fallback` | local |
| 316 | `weighted_pool` | `base_area_id, reference, inherited_category` | local |
| 366 | `PanelEncounters.resolve_enemy_encounter` | `base_area_id, default_category, enemy, properties, config` | assigned/declared |
| 418 | `PanelEncounters.resolve_encounter` | `base_area_id, category` | assigned/declared |
| 469 | `startup_diagnostic` | `(none)` | local |

### Detailed parameter inventory

#### 1. `has_dark_panel(instance, x, y, z)`

- **Line:** 65
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `x` | Declared in this function; type not inferred. |
| 3 | `y` | Declared in this function; type not inferred. |
| 4 | `z` | Declared in this function; type not inferred. |

#### 2. `includes(values, value)`

- **Line:** 69
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared in this function; type not inferred. |
| 2 | `value` | Declared in this function; type not inferred. |

#### 3. `PanelEncounters.resolve_terrain(instance, player)`

- **Line:** 80
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `player` | Declared in this function; type not inferred. |

#### 4. `candidate_area_keys(base_area_id)`

- **Line:** 109
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `base_area_id` | Declared in this function; type not inferred. |

#### 5. `load_area_encounter_table(base_area_id)`

- **Line:** 124
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `base_area_id` | Declared in this function; type not inferred. |

#### 6. `pick_encounter(encounter_table, category)`

- **Line:** 152
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `encounter_table` | Declared in this function; type not inferred. |
| 2 | `category` | Declared in this function; type not inferred. |

#### 7. `PanelEncounters.pick_weighted(candidates)`

- **Line:** 186
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `candidates` | Declared in this function; type not inferred. |

#### 8. `PanelEncounters.resolve_encounter_value(reference, base_area_id)`

- **Line:** 213
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `reference` | Declared in this function; type not inferred. |
| 2 | `base_area_id` | Declared in this function; type not inferred. |

#### 9. `PanelEncounters.resolve_named_encounter(base_area_id, category, reference)`

- **Line:** 226
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `base_area_id` | Declared in this function; type not inferred. |
| 2 | `category` | Declared in this function; type not inferred. |
| 3 | `reference` | Declared in this function; type not inferred. |

#### 10. `PanelEncounters.resolve_dark_hole_liberation_encounters(base_area_id, object_reference)`

- **Line:** 263
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `base_area_id` | Declared in this function; type not inferred. |
| 2 | `object_reference` | Declared in this function; type not inferred. |

#### 11. `nonempty(value)`

- **Line:** 302
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 12. `normalize_category(value, fallback)`

- **Line:** 309
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |
| 2 | `fallback` | Declared in this function; type not inferred. |

#### 13. `weighted_pool(base_area_id, reference, inherited_category)`

- **Line:** 316
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `base_area_id` | Declared in this function; type not inferred. |
| 2 | `reference` | Declared in this function; type not inferred. |
| 3 | `inherited_category` | Declared in this function; type not inferred. |

#### 14. `PanelEncounters.resolve_enemy_encounter(base_area_id, default_category, enemy, properties, config)`

- **Line:** 366
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `base_area_id` | Declared in this function; type not inferred. |
| 2 | `default_category` | Declared in this function; type not inferred. |
| 3 | `enemy` | Declared in this function; type not inferred. |
| 4 | `properties` | Declared in this function; type not inferred. |
| 5 | `config` | Declared in this function; type not inferred. |

#### 15. `PanelEncounters.resolve_encounter(base_area_id, category)`

- **Line:** 418
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `base_area_id` | Declared in this function; type not inferred. |
| 2 | `category` | Declared in this function; type not inferred. |

#### 16. `startup_diagnostic()`

- **Line:** 469
- **Declaration:** local
- **Parameters:** none explicitly declared.


## Tables

| Source line | Assignment |
|---:|---|
| 5 | `PanelEncounters` |
| 15 | `encounters` |
| 20 | `enemies` |
| 26 | `bosses` |
| 31 | `enemies` |
| 37 | `special_encounters` |
| 42 | `enemies` |
| 58 | `corner_offsets` |
| 68 | `panel_type_table` |
| 107 | `area_table_cache` |
| 110 | `keys` |
| 189 | `valid` |
| 243 | `copy` |
| 278 | `numbered` |
| 288 | `candidates` |
| 334 | `entries` |
| 461 | `out` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_area_custom_property` | 1 | 472 |
| `Net.get_area_name` | 4 | 420 |
| `Net.get_object_by_id` | 1 | 268 |
| `Net.list_areas` | 1 | 470 |
