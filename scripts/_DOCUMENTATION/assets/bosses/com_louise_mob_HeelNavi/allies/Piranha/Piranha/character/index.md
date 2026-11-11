# 📄 `character.lua`

> ⚠️ **Archive-only reference:** The source file `assets/bosses/com_louise_mob_HeelNavi/allies/Piranha/Piranha/character.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../../../../../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `assets/bosses/com_louise_mob_HeelNavi/allies/Piranha/Piranha/character.lua` (not present in the current server ZIP).  
> **Source lines:** 361  
> **SHA-256 (UTF-8):** `a52bda1ae265e8…`  
> **Declared/assigned functions detected:** 22  
> **Anonymous closures detected:** 7  
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

Source-based reference for `assets/bosses/com_louise_mob_HeelNavi/allies/Piranha/Piranha/character.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 21 | `package_init` | `self, character_info` | declared |
| 58 | `self.action_idle` | `frame` | assigned |
| 69 | `self.action_attack` | `frame` | assigned |
| 98 | `self.action_scan` | `frame` | assigned |
| 107 | `self.action_teleport` | `frame` | assigned |
| 129 | `self.on_spawn_func` | `self` | assigned |
| 134 | `self.delete_func` | `self` | assigned |
| 140 | `self.set_state` | `state` | assigned |
| 148 | `self.update_func` | `(none)` | assigned |
| 163 | `create_scanner` | `owner` | declared |
| 204 | `spell.update_func` | `(none)` | assigned |
| 229 | `spell.get_actual_tile` | `self` | assigned |
| 238 | `spell.can_move_to_func` | `self` | assigned |
| 242 | `spell.collision_func` | `self, other` | assigned |
| 247 | `begin` | `(none)` | assigned |
| 274 | `create_arrow` | `owner` | declared |
| 302 | `spell.update_func` | `(none)` | assigned |
| 316 | `spell.can_move_to_func` | `self` | assigned |
| 320 | `spell.collision_func` | `self, dt` | assigned |
| 337 | `tiletostring` | `tile` | declared |
| 342 | `shuffle` | `tbl` | declared |
| 350 | `removebyId` | `tab, val` | declared |

### Function details

#### 1. `package_init(self, character_info)`

- **Location:** source line 21.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param self Entity`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | `@param self Entity` |
| 2 | `character_info` | Not explicitly documented in adjacent source annotations. |

#### 2. `self.action_idle(frame)`

- **Location:** source line 58.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** actions for states state idle

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `frame` | Not explicitly documented in adjacent source annotations. |

#### 3. `self.action_attack(frame)`

- **Location:** source line 69.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** state attack
- **Lua documentation annotations:** `@param frame number`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `frame` | `@param frame number` |

#### 4. `self.action_scan(frame)`

- **Location:** source line 98.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** state scan
- **Lua documentation annotations:** `@param frame number`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `frame` | `@param frame number` |

#### 5. `self.action_teleport(frame)`

- **Location:** source line 107.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** state teleport
- **Lua documentation annotations:** `@param frame number`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `frame` | `@param frame number` |

#### 6. `self.on_spawn_func(self)`

- **Location:** source line 129.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 7. `self.delete_func(self)`

- **Location:** source line 134.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 8. `self.set_state(state)`

- **Location:** source line 140.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** utility to set the update state, and reset frame counter
- **Lua documentation annotations:** `@param state number`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `state` | `@param state number` |

#### 9. `self.update_func()`

- **Location:** source line 148.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 10. `create_scanner(owner)`

- **Location:** source line 163.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Used by piranha to create a scanner
- **Lua documentation annotations:** `@param owner Entity`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `owner` | `@param owner Entity` |

#### 11. `spell.update_func()`

- **Location:** source line 204.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 12. `spell.get_actual_tile(self)`

- **Location:** source line 229.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 13. `spell.can_move_to_func(self)`

- **Location:** source line 238.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 14. `spell.collision_func(self, other)`

- **Location:** source line 242.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `other` | Not explicitly documented in adjacent source annotations. |

#### 15. `begin()`

- **Location:** source line 247.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 16. `create_arrow(owner)`

- **Location:** source line 274.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Used by piranha to create an arrow
- **Lua documentation annotations:** `@param owner Entity`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `owner` | `@param owner Entity` |

#### 17. `spell.update_func()`

- **Location:** source line 302.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 18. `spell.can_move_to_func(self)`

- **Location:** source line 316.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 19. `spell.collision_func(self, dt)`

- **Location:** source line 320.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `dt` | Not explicitly documented in adjacent source annotations. |

#### 20. `tiletostring(tile)`

- **Location:** source line 337.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |

#### 21. `shuffle(tbl)`

- **Location:** source line 342.
- **Declaration style:** `declared`.
- **Adjacent source comment:** shuffle function to provide some randomness

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tbl` | Not explicitly documented in adjacent source annotations. |

#### 22. `removebyId(tab, val)`

- **Location:** source line 350.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tab` | Not explicitly documented in adjacent source annotations. |
| 2 | `val` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 75 | `(none)` | `ore attack starts elseif (frame == 22) then self.animation:on_frame(4,` |
| 78 | `(none)` | `self.animation:set_state("ATTACK_BEGIN") self.animation:on_complete(` |
| 84 | `(none)` | `self.animation:set_state("ATTACK") self.animation:on_complete(` |
| 86 | `(none)` | `self.animation:set_state("ATTACK_END") self.animation:on_complete(` |
| 253 | `(none)` | `spell:get_animation():set_state("TARGET_FOUND") spell:get_animation():on_complete(` |
| 255 | `(none)` | `ll:get_animation():set_state("TARGET_LOCK") spell:get_animation():on_complete(` |
| 328 | `(none)` | `anim = artifact:get_animation() anim:set_state("3") anim:on_complete(` |

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `states` — line 16

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `IDLE` | numeric literal | `1` |
| `SCAN` | numeric literal | `2` |
| `ATTACK` | numeric literal | `3` |
| `TELEPORT` | numeric literal | `4` |

### 2. `piranhas` — line 18

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `actions` — line 145

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `self.action_idle` |
| `[2]` | expression/reference | `self.action_scan` |
| `[3]` | expression/reference | `self.action_attack` |
| `[4]` | expression/reference | `self.action_teleport` |

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
