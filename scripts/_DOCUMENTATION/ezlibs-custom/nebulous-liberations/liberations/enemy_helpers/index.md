# 📄 `enemy_helpers.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua)  
> **Source lines:** 344  
> **SHA-256 (UTF-8):** `29f902eec3a28e…`  
> **Declared/assigned functions detected:** 15  
> **Anonymous closures detected:** 2  
> **Table initializers detected:** 9

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

Source-based reference for `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/ezlibs-custom/nebulous-liberations/utils/recover_effect` |
| 2 | `scripts/libs/direction` |
| 3 | `scripts/ezlibs-custom/nebulous-liberations/liberations/hp_indicators` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 14 | `animate_enemy_scale` | `bot_id, scale` | local |
| 44 | `EnemyHelpers.play_attack_animation` | `enemy` | declared |
| 53 | `EnemyHelpers.update_name` | `enemy` | declared |
| 60 | `EnemyHelpers.heal` | `enemy, amount` | declared |
| 76 | `EnemyHelpers.face_position` | `enemy, x, y` | declared |
| 83 | `is_enemy_team_panel` | `panel` | local |
| 91 | `EnemyHelpers.is_occupied_by_enemy` | `instance, x, y, z, ignored_enemy` | declared |
| 118 | `EnemyHelpers.can_spawn_on` | `instance, x, y, z` | declared |
| 124 | `EnemyHelpers.can_move_to` | `instance, x, y, z, moving_enemy` | declared |
| 132 | `EnemyHelpers.move` | `instance, enemy, x, y, z, direction` | declared |
| 223 | `EnemyHelpers.offset_position_with_direction` | `position, direction` | declared |
| 243 | `EnemyHelpers.chebyshev_tile_distance` | `enemy, x, y` | declared |
| 250 | `EnemyHelpers.find_closest_player_session` | `instance, enemy` | declared |
| 274 | `normalize_enemy_name` | `value` | local |
| 283 | `EnemyHelpers.sync_health` | `enemy, results, encounter_data` | declared |

### Function details

#### 1. `animate_enemy_scale(bot_id, scale)`

- **Location:** source line 14.
- **Declaration style:** `local`.
- **Adjacent source comment:** Liberation movement briefly collapses the enemy bot, then restores the scale captured from its template/spawn options after the destination transfer. This also overrides any scale reconciliation caused by the bot's ezbottriggers movement event.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `bot_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `scale` | Not explicitly documented in adjacent source annotations. |

#### 2. `EnemyHelpers.play_attack_animation(enemy)`

- **Location:** source line 44.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `enemy` | Not explicitly documented in adjacent source annotations. |

#### 3. `EnemyHelpers.update_name(enemy)`

- **Location:** source line 53.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `enemy` | Not explicitly documented in adjacent source annotations. |

#### 4. `EnemyHelpers.heal(enemy, amount)`

- **Location:** source line 60.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `enemy` | Not explicitly documented in adjacent source annotations. |
| 2 | `amount` | Not explicitly documented in adjacent source annotations. |

#### 5. `EnemyHelpers.face_position(enemy, x, y)`

- **Location:** source line 76.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `enemy` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |

#### 6. `is_enemy_team_panel(panel)`

- **Location:** source line 83.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `panel` | Not explicitly documented in adjacent source annotations. |

#### 7. `EnemyHelpers.is_occupied_by_enemy(instance, x, y, z, ignored_enemy)`

- **Location:** source line 91.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |
| 4 | `z` | Not explicitly documented in adjacent source annotations. |
| 5 | `ignored_enemy` | Not explicitly documented in adjacent source annotations. |

#### 8. `EnemyHelpers.can_spawn_on(instance, x, y, z)`

- **Location:** source line 118.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Liberation's enemy-owned territory is represented by the panel types already used by enemy movement. Keep spawning and movement on the same rule.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |
| 4 | `z` | Not explicitly documented in adjacent source annotations. |

#### 9. `EnemyHelpers.can_move_to(instance, x, y, z, moving_enemy)`

- **Location:** source line 124.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |
| 4 | `z` | Not explicitly documented in adjacent source annotations. |
| 5 | `moving_enemy` | Not explicitly documented in adjacent source annotations. |

#### 10. `EnemyHelpers.move(instance, enemy, x, y, z, direction)`

- **Location:** source line 132.
- **Declaration style:** `declared`.
- **Adjacent source comment:** takes instance to move player cameras x, y, z should be floored

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `enemy` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `z` | Not explicitly documented in adjacent source annotations. |
| 6 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 11. `EnemyHelpers.offset_position_with_direction(position, direction)`

- **Location:** source line 223.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `position` | Not explicitly documented in adjacent source annotations. |
| 2 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 12. `EnemyHelpers.chebyshev_tile_distance(enemy, x, y)`

- **Location:** source line 243.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `enemy` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |

#### 13. `EnemyHelpers.find_closest_player_session(instance, enemy)`

- **Location:** source line 250.
- **Declaration style:** `declared`.
- **Adjacent source comment:** uses chebyshev_tile_distance

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `enemy` | Not explicitly documented in adjacent source annotations. |

#### 14. `normalize_enemy_name(value)`

- **Location:** source line 274.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 15. `EnemyHelpers.sync_health(enemy, results, encounter_data)`

- **Location:** source line 283.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `enemy` | Not explicitly documented in adjacent source annotations. |
| 2 | `results` | Not explicitly documented in adjacent source annotations. |
| 3 | `encounter_data` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 70 | `resolve` | `th then return RecoverEffect:new(enemy.id):remove() else return Async.create_promise(` |
| 141 | `(none)` | `= .25 local startup_time = .25 local animation_time = .042 local co = coroutine.crea…` |

## 📦 Tables and data

The following **9** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `EnemyHelpers` — line 5

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `guardian_minimap_marker` | nested table | `{ r = 230, g = 50, b = 40 }` |
| `boss_minimap_color` | nested table | `{ r = 170, g = 50, b = 170 }` |

### 2. `guardian_minimap_marker` — line 6

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `230` |
| `g` | numeric literal | `50` |
| `b` | numeric literal | `40` |

### 3. `boss_minimap_color` — line 7

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `170` |
| `g` | numeric literal | `50` |
| `b` | numeric literal | `170` |

### 4. `config` — line 19

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ properties = { { property = "ScaleX", value = scale, ease = "Linear" }, { property = "ScaleY", value = scale, ease = "Linear" } }, duration = 0 }` |

### 5. `properties` — line 21

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ property = "ScaleX", value = scale, ease = "Linear" }` |
| `[2]` | nested table | `{ property = "ScaleY", value = scale, ease = "Linear" }` |

### 6. `direction_suffix_map` — line 37

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[Direction.DOWN_LEFT]` | string literal | `"DL"` |
| `[Direction.DOWN_RIGHT]` | string literal | `"DR"` |
| `[Direction.UP_LEFT]` | string literal | `"UL"` |
| `[Direction.UP_RIGHT]` | string literal | `"UR"` |

### 7. `position` — line 224

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `position.x` |
| `y` | expression/reference | `position.y` |
| `z` | expression/reference | `position.z` |

### 8. `expected_names` — line 290

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `reported_names` — line 301

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.await` | 5 |
| `Async.create_promise` | 1 |
| `Async.promisify` | 1 |
| `Async.sleep` | 5 |
| `Net.animate_bot` | 3 |
| `Net.create_bot` | 1 |
| `Net.get_bot_area` | 1 |
| `Net.get_bot_direction` | 1 |
| `Net.get_width` | 1 |
| `Net.remove_bot` | 1 |
| `Net.set_bot_direction` | 2 |
| `Net.set_bot_name` | 1 |
| `Net.slide_player_camera` | 1 |
| `Net.transfer_bot` | 3 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
