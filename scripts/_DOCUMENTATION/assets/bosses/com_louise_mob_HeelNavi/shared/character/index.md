# 📄 `character.lua`

> ⚠️ **Archive-only reference:** The source file `assets/bosses/com_louise_mob_HeelNavi/shared/character.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../../../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `assets/bosses/com_louise_mob_HeelNavi/shared/character.lua` (not present in the current server ZIP).  
> **Source lines:** 292  
> **SHA-256 (UTF-8):** `e1c95d5041db7f…`  
> **Declared/assigned functions detected:** 15  
> **Anonymous closures detected:** 5  
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

Imports -@type BattleHelper

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 38 | `package_init` | `self, character_info` | declared |
| 81 | `self.action_idle` | `frame` | assigned |
| 108 | `self.prepare_close_attack_action` | `frame` | assigned |
| 117 | `action.action_end_func` | `(none)` | assigned |
| 128 | `self.prepare_range_attack_action` | `frame` | assigned |
| 142 | `action.action_end_func` | `(none)` | assigned |
| 153 | `self.set_state` | `state` | assigned |
| 161 | `self.update_func` | `(none)` | assigned |
| 177 | `self.delete_func` | `(none)` | assigned |
| 191 | `summon` | `character` | declared |
| 223 | `spawn_ally` | `owner` | declared |
| 238 | `insert_into_available` | `id` | declared |
| 247 | `tiletostring` | `tile` | declared |
| 252 | `find_target` | `self` | declared |
| 265 | `is_tile_free_for_movement` | `tile, character` | declared |

### Function details

#### 1. `package_init(self, character_info)`

- **Location:** source line 38.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param self Entity`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | `@param self Entity` |
| 2 | `character_info` | Not explicitly documented in adjacent source annotations. |

#### 2. `self.action_idle(frame)`

- **Location:** source line 81.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** state idle
- **Lua documentation annotations:** `@param frame number`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `frame` | `@param frame number` |

#### 3. `self.prepare_close_attack_action(frame)`

- **Location:** source line 108.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** state move
- **Lua documentation annotations:** `@param frame number`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `frame` | `@param frame number` |

#### 4. `action.action_end_func()`

- **Location:** source line 117.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 5. `self.prepare_range_attack_action(frame)`

- **Location:** source line 128.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** state prepare_range_attack_action move can be started from anywhere.
- **Lua documentation annotations:** `@param frame number`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `frame` | `@param frame number` |

#### 6. `action.action_end_func()`

- **Location:** source line 142.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 7. `self.set_state(state)`

- **Location:** source line 153.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** utility to set the update state, and reset frame counter
- **Lua documentation annotations:** `@param state number`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `state` | `@param state number` |

#### 8. `self.update_func()`

- **Location:** source line 161.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 9. `self.delete_func()`

- **Location:** source line 177.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Deleting Heel Navi deletes his minions as well.

#### 10. `summon(character)`

- **Location:** source line 191.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `character` | Not explicitly documented in adjacent source annotations. |

#### 11. `spawn_ally(owner)`

- **Location:** source line 223.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `owner` | Not explicitly documented in adjacent source annotations. |

#### 12. `insert_into_available(id)`

- **Location:** source line 238.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `id` | Not explicitly documented in adjacent source annotations. |

#### 13. `tiletostring(tile)`

- **Location:** source line 247.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |

#### 14. `find_target(self)`

- **Location:** source line 252.
- **Declaration style:** `declared`.
- **Adjacent source comment:** find a target character

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 15. `is_tile_free_for_movement(tile, character)`

- **Location:** source line 265.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |
| 2 | `character` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 207 | `(none)` | `character.animation:set_state("SUMMON") character.animation:on_frame(10,` |
| 210 | `(none)` | `spawn_ally(character) end); character.animation:on_complete(` |
| 216 | `(none)` | `character.animation:set_state("CHEER") character.animation:on_complete(` |
| 255 | `other_character` | `eld() local team = self:get_team() local target_list = field:find_characters(` |
| 274 | `ent` | `e()) then return false end local occupants = tile:find_entities(` |

## 📦 Tables and data

The following **7** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `states` — line 17

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `DEFAULT` | numeric literal | `1` |
| `PREPARE_CLOSE_ATTACK` | numeric literal | `2` |
| `PREPARE_RANGE_ATTACK` | numeric literal | `3` |

### 2. `enemies` — line 25

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"included.Volgear"` |
| `[2]` | string literal | `"included.Piranha"` |
| `[3]` | string literal | `"included.Boomer"` |

### 3. `chips` — line 33

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Lilbomb"` |
| `[2]` | string literal | `"Cannonball"` |
| `[3]` | string literal | `"Herosword"` |

### 4. `self.minions` — line 72

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ -1, 4 }` |
| `[2]` | nested table | `{ -1, 5 }` |

### 5. `self.available_columns` — line 73

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `self.minions` — line 75

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ -1, 2 }` |
| `[2]` | nested table | `{ -1, 3 }` |

### 7. `actions` — line 158

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `self.action_idle` |
| `[2]` | expression/reference | `self.prepare_close_attack_action` |
| `[3]` | expression/reference | `self.prepare_range_attack_action` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Engine.load_audio` | 1 |
| `Engine.load_texture` | 3 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
