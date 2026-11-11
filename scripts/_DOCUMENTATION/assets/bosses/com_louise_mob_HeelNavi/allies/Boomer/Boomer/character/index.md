# 📄 `character.lua`

> ⚠️ **Archive-only reference:** The source file `assets/bosses/com_louise_mob_HeelNavi/allies/Boomer/Boomer/character.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../../../../../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `assets/bosses/com_louise_mob_HeelNavi/allies/Boomer/Boomer/character.lua` (not present in the current server ZIP).  
> **Source lines:** 317  
> **SHA-256 (UTF-8):** `109763ba0f4611…`  
> **Declared/assigned functions detected:** 18  
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

Imports -@type BattleHelper

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 17 | `package_init` | `self, character_info` | declared |
| 58 | `self.defense_rule.can_block_func` | `judge, attacker, defender` | assigned |
| 87 | `self.action_idle` | `frame` | assigned |
| 97 | `self.turn` | `(none)` | assigned |
| 105 | `self.action_move` | `frame` | assigned |
| 145 | `self.action_wait` | `frame` | assigned |
| 162 | `self.set_state` | `state` | assigned |
| 169 | `self.update_func` | `(none)` | assigned |
| 184 | `self.throw_boomerang` | `(none)` | assigned |
| 205 | `Tiletostring` | `tile` | declared |
| 211 | `boomerang` | `user` | declared |
| 239 | `spell.update_func` | `self, dt` | assigned |
| 266 | `spell.collision_func` | `self, other` | assigned |
| 268 | `spell.attack_func` | `self, other` | assigned |
| 272 | `spell.delete_func` | `self` | assigned |
| 275 | `spell.can_move_to_func` | `tile` | assigned |
| 283 | `get_free_direction` | `tile, direction1, direction2` | declared |
| 291 | `is_tile_free_for_movement` | `tile, character` | declared |

### Function details

#### 1. `package_init(self, character_info)`

- **Location:** source line 17.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param self Entity`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | `@param self Entity` |
| 2 | `character_info` | Not explicitly documented in adjacent source annotations. |

#### 2. `self.defense_rule.can_block_func(judge, attacker, defender)`

- **Location:** source line 58.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `judge` | Not explicitly documented in adjacent source annotations. |
| 2 | `attacker` | Not explicitly documented in adjacent source annotations. |
| 3 | `defender` | Not explicitly documented in adjacent source annotations. |

#### 3. `self.action_idle(frame)`

- **Location:** source line 87.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** state idle
- **Lua documentation annotations:** `@param frame number`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `frame` | `@param frame number` |

#### 4. `self.turn()`

- **Location:** source line 97.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 5. `self.action_move(frame)`

- **Location:** source line 105.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** state move
- **Lua documentation annotations:** `@param frame number`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `frame` | `@param frame number` |

#### 6. `self.action_wait(frame)`

- **Location:** source line 145.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** state wait
- **Lua documentation annotations:** `@param frame number`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `frame` | `@param frame number` |

#### 7. `self.set_state(state)`

- **Location:** source line 162.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** utility to set the update state, and reset frame counter
- **Lua documentation annotations:** `@param state number`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `state` | `@param state number` |

#### 8. `self.update_func()`

- **Location:** source line 169.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 9. `self.throw_boomerang()`

- **Location:** source line 184.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 10. `Tiletostring(tile)`

- **Location:** source line 205.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |

#### 11. `boomerang(user)`

- **Location:** source line 211.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Boomerang!
- **Lua documentation annotations:** `@param user Entity`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `user` | `@param user Entity` |

#### 12. `spell.update_func(self, dt)`

- **Location:** source line 239.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `dt` | Not explicitly documented in adjacent source annotations. |

#### 13. `spell.collision_func(self, other)`

- **Location:** source line 266.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `other` | Not explicitly documented in adjacent source annotations. |

#### 14. `spell.attack_func(self, other)`

- **Location:** source line 268.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `other` | Not explicitly documented in adjacent source annotations. |

#### 15. `spell.delete_func(self)`

- **Location:** source line 272.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 16. `spell.can_move_to_func(tile)`

- **Location:** source line 275.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |

#### 17. `get_free_direction(tile, direction1, direction2)`

- **Location:** source line 283.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Checks if the tile in 2 given directions is free and returns that direction

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |
| 2 | `direction1` | Not explicitly documented in adjacent source annotations. |
| 3 | `direction2` | Not explicitly documented in adjacent source annotations. |

#### 18. `is_tile_free_for_movement(tile, character)`

- **Location:** source line 291.
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
| 75 | `(none)` | `et_state("DEFAULT") anim:refresh(artifact:sprite()) anim:on_complete(` |
| 190 | `(none)` | `_state("THROW") self.has_attacked_once = true self.animation:on_frame(3,` |
| 194 | `(none)` | `false self:toggle_counter(true) end) self.animation:on_complete(` |
| 249 | `(none)` | `if (not user:is_deleted()) then user.animation:on_complete(` |
| 300 | `ent` | `(tile:is_edge()) then return false end local occupants = tile:find_entities(` |

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `states` — line 15

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `IDLE` | numeric literal | `1` |
| `MOVE` | numeric literal | `2` |
| `WAIT` | numeric literal | `3` |

### 2. `actions` — line 167

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `self.action_idle` |
| `[2]` | expression/reference | `self.action_move` |
| `[3]` | expression/reference | `self.action_wait` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Engine.load_audio` | 2 |
| `Engine.load_texture` | 5 |
| `Engine.play_audio` | 2 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
