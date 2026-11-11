# 📄 `battle_helpers.lua`

> ⚠️ **Archive-only reference:** The source file `assets/bosses/com_louise_mob_HeelNavi/shared/battle_helpers.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../../../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `assets/bosses/com_louise_mob_HeelNavi/shared/battle_helpers.lua` (not present in the current server ZIP).  
> **Source lines:** 212  
> **SHA-256 (UTF-8):** `09c6f746fc4d84…`  
> **Declared/assigned functions detected:** 9  
> **Anonymous closures detected:** 6  
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

Functions for easy reuse in scripts Version 1.0

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 15 | `battle_helpers.spawn_visual_artifact` | `field, tile, texture, animation_path, animation_state, position_x, position_y` | declared |
| 30 | `battle_helpers.can_move_to_func` | `tile, entity` | assigned |
| 56 | `battle_helpers.can_move_to_func_front_row` | `tile` | assigned |
| 79 | `battle_helpers.can_move_to_func_target_enemy` | `tile` | assigned |
| 110 | `battle_helpers.choose_random_tile` | `character, column` | declared |
| 130 | `battle_helpers.find_target` | `self` | declared |
| 144 | `battle_helpers.move_to_back_col` | `character` | declared |
| 166 | `battle_helpers.move_to_front_col` | `character` | declared |
| 188 | `battle_helpers.jump_to_target_row` | `character, jump_speed` | declared |

### Function details

#### 1. `battle_helpers.spawn_visual_artifact(field, tile, texture, animation_path, animation_state, position_x, position_y)`

- **Location:** source line 15.
- **Declaration style:** `declared`.
- **Adjacent source comment:** comment
- **Lua documentation annotations:** `@param field #reference to battlefield`, `@param tile #tile to spawn the visual artifact on`, `@param texture #texture to use`, `@param animation_path #path to animation`, `@param animation_state #state to use`, `@param position_x #offsetX`, `@param position_y #offsetY`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `field` | `@param field #reference to battlefield` |
| 2 | `tile` | `@param tile #tile to spawn the visual artifact on` |
| 3 | `texture` | `@param texture #texture to use` |
| 4 | `animation_path` | `@param animation_path #path to animation` |
| 5 | `animation_state` | `@param animation_state #state to use` |
| 6 | `position_x` | `@param position_x #offsetX` |
| 7 | `position_y` | `@param position_y #offsetY` |

#### 2. `battle_helpers.can_move_to_func(tile, entity)`

- **Location:** source line 30.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |
| 2 | `entity` | Not explicitly documented in adjacent source annotations. |

#### 3. `battle_helpers.can_move_to_func_front_row(tile)`

- **Location:** source line 56.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |

#### 4. `battle_helpers.can_move_to_func_target_enemy(tile)`

- **Location:** source line 79.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |

#### 5. `battle_helpers.choose_random_tile(character, column)`

- **Location:** source line 110.
- **Declaration style:** `declared`.
- **Adjacent source comment:** comment
- **Lua documentation annotations:** `@param character any`, `@param column any`, `@return Tile | nil`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `character` | `@param character any` |
| 2 | `column` | `@param column any` |

#### 6. `battle_helpers.find_target(self)`

- **Location:** source line 130.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 7. `battle_helpers.move_to_back_col(character)`

- **Location:** source line 144.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `character` | Not explicitly documented in adjacent source annotations. |

#### 8. `battle_helpers.move_to_front_col(character)`

- **Location:** source line 166.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `character` | Not explicitly documented in adjacent source annotations. |

#### 9. `battle_helpers.jump_to_target_row(character, jump_speed)`

- **Location:** source line 188.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `character` | Not explicitly documented in adjacent source annotations. |
| 2 | `jump_speed` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 22 | `(none)` | `on() anim:load(animation_path) anim:set_state(animation_state) anim:on_complete(` |
| 38 | `c` | `return false end local has_character = false tile:find_characters(` |
| 45 | `c` | `has_character = true end return false end) tile:find_obstacles(` |
| 64 | `c` | `return false end local has_character = false tile:find_characters(` |
| 92 | `c` | `return has_enemy end tile:get_tile(Direction.Left, x):find_characters(` |
| 133 | `other_character` | `f:get_field() local team = self:get_team() local target_list = field:find_characters(` |

## 📦 Tables and data

The following **5** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `battle_helpers` — line 5

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `tile_array` — line 114

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `tile_array` — line 149

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `tile_array` — line 171

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `tile_array` — line 194

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
