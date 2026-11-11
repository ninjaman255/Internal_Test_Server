# 📄 `battle_helpers.lua`

> ⚠️ **Archive-only reference:** The source file `assets/bosses/com_louise_mob_HeelNavi/allies/Piranha/Piranha/battle_helpers.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../../../../../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `assets/bosses/com_louise_mob_HeelNavi/allies/Piranha/Piranha/battle_helpers.lua` (not present in the current server ZIP).  
> **Source lines:** 116  
> **SHA-256 (UTF-8):** `9e2f9d9768cf5b…`  
> **Declared/assigned functions detected:** 5  
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

Functions for easy reuse in scripts Version 1.0

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 6 | `battle_helpers.spawn_visual_artifact` | `field,tile,texture,animation_path,animation_state,position_x,position_y` | declared |
| 20 | `battle_helpers.can_move_to_func` | `tile, entity` | assigned |
| 45 | `battle_helpers.can_move_to_func_front_row` | `tile` | assigned |
| 67 | `battle_helpers.can_move_to_func_target_enemy` | `tile` | assigned |
| 93 | `battle_helpers.move_at_random` | `character` | declared |

### Function details

#### 1. `battle_helpers.spawn_visual_artifact(field,tile,texture,animation_path,animation_state,position_x,position_y)`

- **Location:** source line 6.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `field` | Not explicitly documented in adjacent source annotations. |
| 2 | `tile` | Not explicitly documented in adjacent source annotations. |
| 3 | `texture` | Not explicitly documented in adjacent source annotations. |
| 4 | `animation_path` | Not explicitly documented in adjacent source annotations. |
| 5 | `animation_state` | Not explicitly documented in adjacent source annotations. |
| 6 | `position_x` | Not explicitly documented in adjacent source annotations. |
| 7 | `position_y` | Not explicitly documented in adjacent source annotations. |

#### 2. `battle_helpers.can_move_to_func(tile, entity)`

- **Location:** source line 20.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |
| 2 | `entity` | Not explicitly documented in adjacent source annotations. |

#### 3. `battle_helpers.can_move_to_func_front_row(tile)`

- **Location:** source line 45.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |

#### 4. `battle_helpers.can_move_to_func_target_enemy(tile)`

- **Location:** source line 67.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |

#### 5. `battle_helpers.move_at_random(character)`

- **Location:** source line 93.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `character` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 12 | `(none)` | `on() anim:load(animation_path) anim:set_state(animation_state) anim:on_complete(` |
| 27 | `c` | `en return false end local has_character = false tile:find_characters(` |
| 34 | `c` | `has_character = true end return false end) tile:find_obstacles(` |
| 52 | `c` | `en return false end local has_character = false tile:find_characters(` |
| 79 | `c` | `return has_enemy end tile:get_tile(Direction.Left, x):find_characters(` |

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `battle_helpers` — line 4

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `tile_array` — line 97

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
