# 📄 `battle_helpers.lua`

> ⚠️ **Archive-only reference:** The source file `assets/bosses/com_louise_mob_HeelNavi/allies/Volgear/shared/battle_helpers.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../../../../../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `assets/bosses/com_louise_mob_HeelNavi/allies/Volgear/shared/battle_helpers.lua` (not present in the current server ZIP).  
> **Source lines:** 151  
> **SHA-256 (UTF-8):** `f7176902cc5dae…`  
> **Declared/assigned functions detected:** 7  
> **Anonymous closures detected:** 5  
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

Functions for easy reuse in scripts Version 1.8 (optionally ignore neutral team for get_first_target_ahead, add is_tile_free_for_movement) Version 1.7 (fixed find targets ahead getting non character/obstacles)

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 7 | `battle_helpers.spawn_visual_artifact` | `character,tile,texture,animation_path,animation_state,position_x,position_y,dont_flip_offset` | declared |
| 30 | `battle_helpers.find_all_enemies` | `user` | declared |
| 42 | `battle_helpers.find_targets_ahead` | `user` | declared |
| 68 | `battle_helpers.get_first_target_ahead` | `user,ignore_neutral_team` | declared |
| 94 | `battle_helpers.drop_trace_fx` | `target_artifact,lifetime_ms` | declared |
| 111 | `fx.update_func` | `self, dt` | assigned |
| 126 | `battle_helpers.is_tile_free_for_movement` | `tile,character,must_be_walkable` | declared |

### Function details

#### 1. `battle_helpers.spawn_visual_artifact(character,tile,texture,animation_path,animation_state,position_x,position_y,dont_flip_offset)`

- **Location:** source line 7.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `character` | Not explicitly documented in adjacent source annotations. |
| 2 | `tile` | Not explicitly documented in adjacent source annotations. |
| 3 | `texture` | Not explicitly documented in adjacent source annotations. |
| 4 | `animation_path` | Not explicitly documented in adjacent source annotations. |
| 5 | `animation_state` | Not explicitly documented in adjacent source annotations. |
| 6 | `position_x` | Not explicitly documented in adjacent source annotations. |
| 7 | `position_y` | Not explicitly documented in adjacent source annotations. |
| 8 | `dont_flip_offset` | Not explicitly documented in adjacent source annotations. |

#### 2. `battle_helpers.find_all_enemies(user)`

- **Location:** source line 30.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `user` | Not explicitly documented in adjacent source annotations. |

#### 3. `battle_helpers.find_targets_ahead(user)`

- **Location:** source line 42.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `user` | Not explicitly documented in adjacent source annotations. |

#### 4. `battle_helpers.get_first_target_ahead(user,ignore_neutral_team)`

- **Location:** source line 68.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `user` | Not explicitly documented in adjacent source annotations. |
| 2 | `ignore_neutral_team` | Not explicitly documented in adjacent source annotations. |

#### 5. `battle_helpers.drop_trace_fx(target_artifact,lifetime_ms)`

- **Location:** source line 94.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `target_artifact` | Not explicitly documented in adjacent source annotations. |
| 2 | `lifetime_ms` | Not explicitly documented in adjacent source annotations. |

#### 6. `fx.update_func(self, dt)`

- **Location:** source line 111.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `dt` | Not explicitly documented in adjacent source annotations. |

#### 7. `battle_helpers.is_tile_free_for_movement(tile,character,must_be_walkable)`

- **Location:** source line 126.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |
| 2 | `character` | Not explicitly documented in adjacent source annotations. |
| 3 | `must_be_walkable` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 17 | `(none)` | `ng() anim:load(animation_path) anim:set_state(animation_state) anim:on_complete(` |
| 33 | `character` | `ser:get_field() local user_team = user:get_team() local list = field:find_characters(` |
| 47 | `entity` | `er:get_team() local user_facing = user:get_facing() local list = field:find_entities(` |
| 81 | `a, b` | `end else filtered_targets = targets end table.sort(filtered_targets,` |
| 137 | `other_entity` | `tile:is_hidden() then return false end local occupants = tile:find_entities(` |

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `battle_helpers` — line 5

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `filtered_targets` — line 71

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
