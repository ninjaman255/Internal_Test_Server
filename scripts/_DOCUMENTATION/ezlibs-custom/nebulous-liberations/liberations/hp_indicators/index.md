# 📄 `hp_indicators.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/hp_indicators.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/hp_indicators.lua)  
> **Source lines:** 448  
> **SHA-256 (UTF-8):** `348fd6b4f9a727…`  
> **Declared/assigned functions detected:** 24  
> **Anonymous closures detected:** 2  
> **Table initializers detected:** 16

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

Current-HP digits for Liberation mission participants and enemies. Each viewer gets private world map-element bots for other players and enemies. A viewer never receives an HP indicator for their own player. Enemy/boss indicators use the enemy bot origin (enemy.x, enemy.y) and hide during tile movement.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 7 | `scripts/net-games/main` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 400 | `Net:on` | `player_move` |
| 423 | `Net:on` | `player_area_transfer` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 20 | `safe_id` | `value` | local |
| 24 | `map_offset` | `horizontal_offset, vertical_offset, z_lift` | local |
| 34 | `round_fraction` | `value, denominator` | local |
| 41 | `fix_offsets` | `x, y` | local |
| 58 | `target_key` | `target_type, target_id` | local |
| 62 | `get_target_position` | `target` | local |
| 69 | `get_digit_layout` | `hp, index, digit_count` | local |
| 76 | `get_digit_position` | `target, index, digit_count` | local |
| 84 | `remove_viewer_digits` | `viewer_id, target` | local |
| 93 | `render_player_for_viewer` | `state, viewer_id, target` | local |
| 134 | `render_enemy_for_viewer` | `state, viewer_id, target` | local |
| 171 | `render_target` | `state, target` | local |
| 195 | `add_target` | `instance, target_type, target_id, hp, position` | local |
| 219 | `HPIndicators.register` | `instance` | declared |
| 253 | `HPIndicators.add_enemy` | `instance, enemy` | declared |
| 267 | `HPIndicators.update_enemy_hp_for_enemy` | `enemy` | declared |
| 274 | `HPIndicators.update_player_hp` | `instance, player_id, hp` | declared |
| 284 | `HPIndicators.update_enemy_hp` | `instance, enemy` | declared |
| 298 | `HPIndicators.hide_enemy` | `instance, enemy` | declared |
| 308 | `HPIndicators.show_enemy` | `instance, enemy` | declared |
| 321 | `HPIndicators.update_enemy_position` | `instance, enemy` | declared |
| 339 | `HPIndicators.remove_enemy` | `instance, enemy` | declared |
| 352 | `HPIndicators.remove_player` | `instance, player_id` | declared |
| 375 | `HPIndicators.destroy` | `instance` | declared |

### Function details

#### 1. `safe_id(value)`

- **Location:** source line 20.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 2. `map_offset(horizontal_offset, vertical_offset, z_lift)`

- **Location:** source line 24.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `horizontal_offset` | Not explicitly documented in adjacent source annotations. |
| 2 | `vertical_offset` | Not explicitly documented in adjacent source annotations. |
| 3 | `z_lift` | Not explicitly documented in adjacent source annotations. |

#### 3. `round_fraction(value, denominator)`

- **Location:** source line 34.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `denominator` | Not explicitly documented in adjacent source annotations. |

#### 4. `fix_offsets(x, y)`

- **Location:** source line 41.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |

#### 5. `target_key(target_type, target_id)`

- **Location:** source line 58.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `target_type` | Not explicitly documented in adjacent source annotations. |
| 2 | `target_id` | Not explicitly documented in adjacent source annotations. |

#### 6. `get_target_position(target)`

- **Location:** source line 62.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `target` | Not explicitly documented in adjacent source annotations. |

#### 7. `get_digit_layout(hp, index, digit_count)`

- **Location:** source line 69.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `hp` | Not explicitly documented in adjacent source annotations. |
| 2 | `index` | Not explicitly documented in adjacent source annotations. |
| 3 | `digit_count` | Not explicitly documented in adjacent source annotations. |

#### 8. `get_digit_position(target, index, digit_count)`

- **Location:** source line 76.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `target` | Not explicitly documented in adjacent source annotations. |
| 2 | `index` | Not explicitly documented in adjacent source annotations. |
| 3 | `digit_count` | Not explicitly documented in adjacent source annotations. |

#### 9. `remove_viewer_digits(viewer_id, target)`

- **Location:** source line 84.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `viewer_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `target` | Not explicitly documented in adjacent source annotations. |

#### 10. `render_player_for_viewer(state, viewer_id, target)`

- **Location:** source line 93.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `state` | Not explicitly documented in adjacent source annotations. |
| 2 | `viewer_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `target` | Not explicitly documented in adjacent source annotations. |

#### 11. `render_enemy_for_viewer(state, viewer_id, target)`

- **Location:** source line 134.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `state` | Not explicitly documented in adjacent source annotations. |
| 2 | `viewer_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `target` | Not explicitly documented in adjacent source annotations. |

#### 12. `render_target(state, target)`

- **Location:** source line 171.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `state` | Not explicitly documented in adjacent source annotations. |
| 2 | `target` | Not explicitly documented in adjacent source annotations. |

#### 13. `add_target(instance, target_type, target_id, hp, position)`

- **Location:** source line 195.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `target_type` | Not explicitly documented in adjacent source annotations. |
| 3 | `target_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `hp` | Not explicitly documented in adjacent source annotations. |
| 5 | `position` | Not explicitly documented in adjacent source annotations. |

#### 14. `HPIndicators.register(instance)`

- **Location:** source line 219.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |

#### 15. `HPIndicators.add_enemy(instance, enemy)`

- **Location:** source line 253.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `enemy` | Not explicitly documented in adjacent source annotations. |

#### 16. `HPIndicators.update_enemy_hp_for_enemy(enemy)`

- **Location:** source line 267.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `enemy` | Not explicitly documented in adjacent source annotations. |

#### 17. `HPIndicators.update_player_hp(instance, player_id, hp)`

- **Location:** source line 274.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `hp` | Not explicitly documented in adjacent source annotations. |

#### 18. `HPIndicators.update_enemy_hp(instance, enemy)`

- **Location:** source line 284.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `enemy` | Not explicitly documented in adjacent source annotations. |

#### 19. `HPIndicators.hide_enemy(instance, enemy)`

- **Location:** source line 298.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `enemy` | Not explicitly documented in adjacent source annotations. |

#### 20. `HPIndicators.show_enemy(instance, enemy)`

- **Location:** source line 308.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `enemy` | Not explicitly documented in adjacent source annotations. |

#### 21. `HPIndicators.update_enemy_position(instance, enemy)`

- **Location:** source line 321.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `enemy` | Not explicitly documented in adjacent source annotations. |

#### 22. `HPIndicators.remove_enemy(instance, enemy)`

- **Location:** source line 339.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `enemy` | Not explicitly documented in adjacent source annotations. |

#### 23. `HPIndicators.remove_player(instance, player_id)`

- **Location:** source line 352.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 24. `HPIndicators.destroy(instance)`

- **Location:** source line 375.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 400 | `event` | `every viewer's private HP bots with the player's authoritative position. Net:on("pla…` |
| 423 | `event` | `, viewer_id, x, y, z) end end end end) Net:on("player_area_transfer",` |

## 📦 Tables and data

The following **16** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `HPIndicators` — line 9

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `instances_by_area` — line 16

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `instances_by_player` — line 18

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `names` — line 100

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `names` — line 137

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `target` — line 202

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `key` | expression/reference | `key` |
| `type` | expression/reference | `target_type` |
| `id` | expression/reference | `target_id` |
| `hp` | expression/reference | `math.max(0, math.floor(tonumber(hp) or 0))` |
| `position` | expression/reference | `position or { x = 0, y = 0, z = 0 }` |
| `elements` | nested table | `{}` |
| `hidden` | boolean literal | `false` |

### 7. `elements` — line 208

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `state` — line 225

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `instance` | expression/reference | `instance` |
| `viewers` | nested table | `{}` |
| `targets` | nested table | `{}` |

### 9. `viewers` — line 225

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `targets` — line 225

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `position` — line 240

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `result.x` |
| `y` | expression/reference | `result.y` |
| `z` | expression/reference | `result.z` |

### 12. `position` — line 242

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `player.x` |
| `y` | expression/reference | `player.y` |
| `z` | expression/reference | `player.z` |

### 13. `target.position` — line 312

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `(tonumber(enemy.x) or 0) + 0.5` |
| `y` | expression/reference | `(tonumber(enemy.y) or 0) + 0.6` |
| `z` | expression/reference | `tonumber(enemy.z) or 0` |

### 14. `target.position` — line 325

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `(tonumber(enemy.x) or 0) + 0.5` |
| `y` | expression/reference | `(tonumber(enemy.y) or 0) + 0.6` |
| `z` | expression/reference | `tonumber(enemy.z) or 0` |

### 15. `target.position` — line 406

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `tonumber(event.x) or target.position.x or 0` |
| `y` | expression/reference | `tonumber(event.y) or target.position.y or 0` |
| `z` | expression/reference | `tonumber(event.z) or target.position.z or 0` |

### 16. `target.position` — line 431

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `tonumber(position.x) or target.position.x or 0` |
| `y` | expression/reference | `tonumber(position.y) or target.position.y or 0` |
| `z` | expression/reference | `tonumber(position.z) or target.position.z or 0` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 2 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
