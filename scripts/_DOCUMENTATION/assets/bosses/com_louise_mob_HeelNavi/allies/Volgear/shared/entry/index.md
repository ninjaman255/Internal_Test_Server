# 📄 `entry.lua`

> ⚠️ **Archive-only reference:** The source file `assets/bosses/com_louise_mob_HeelNavi/allies/Volgear/shared/entry.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../../../../../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `assets/bosses/com_louise_mob_HeelNavi/allies/Volgear/shared/entry.lua` (not present in the current server ZIP).  
> **Source lines:** 329  
> **SHA-256 (UTF-8):** `ee8b472cfa61d6…`  
> **Declared/assigned functions detected:** 25  
> **Anonymous closures detected:** 9  
> **Table initializers detected:** 0

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

Source-based reference for `assets/bosses/com_louise_mob_HeelNavi/allies/Volgear/shared/entry.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 14 | `debug_print` | `text` | local |
| 18 | `get_tracker_from_direction` | `facing` | declared |
| 26 | `advance_a_turn_by_facing` | `facing` | declared |
| 31 | `get_active_mob_id_for_same_direction` | `facing` | declared |
| 36 | `add_enemy_to_tracking` | `enemy` | declared |
| 43 | `remove_enemy_from_tracking` | `enemy` | declared |
| 50 | `package_init` | `self, character_info` | declared |
| 92 | `self.update_func` | `self, dt` | assigned |
| 112 | `self.battle_start_func` | `self` | assigned |
| 116 | `mob_sort_func` | `a, b` | assigned |
| 126 | `self.on_spawn_func` | `self, spawn_tile` | assigned |
| 131 | `self.can_move_to_func` | `tile` | assigned |
| 134 | `self.delete_func` | `self` | assigned |
| 140 | `find_target` | `self` | declared |
| 154 | `take_turn` | `self` | declared |
| 168 | `self.flame_action.action_end_func` | `(none)` | assigned |
| 180 | `move_random` | `self` | declared |
| 212 | `action_flame` | `character` | declared |
| 216 | `action.execute_func` | `self, user` | assigned |
| 232 | `is_tile_free_for_movement` | `tile, character` | declared |
| 245 | `getNextTile` | `direction, spell` | declared |
| 259 | `spawn_flame` | `owner, tile, direction, damage, wave_texture, wave_animation, wave_sfx, cascade_frame_index` | declared |
| 265 | `spawn_next` | `(none)` | assigned |
| 287 | `spell.collision_func` | `self, other` | assigned |
| 319 | `spell.update_func` | `(none)` | assigned |

### Function details

#### 1. `debug_print(text)`

- **Location:** source line 14.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |

#### 2. `get_tracker_from_direction(facing)`

- **Location:** source line 18.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `facing` | Not explicitly documented in adjacent source annotations. |

#### 3. `advance_a_turn_by_facing(facing)`

- **Location:** source line 26.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `facing` | Not explicitly documented in adjacent source annotations. |

#### 4. `get_active_mob_id_for_same_direction(facing)`

- **Location:** source line 31.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `facing` | Not explicitly documented in adjacent source annotations. |

#### 5. `add_enemy_to_tracking(enemy)`

- **Location:** source line 36.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `enemy` | Not explicitly documented in adjacent source annotations. |

#### 6. `remove_enemy_from_tracking(enemy)`

- **Location:** source line 43.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `enemy` | Not explicitly documented in adjacent source annotations. |

#### 7. `package_init(self, character_info)`

- **Location:** source line 50.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `character_info` | Not explicitly documented in adjacent source annotations. |

#### 8. `self.update_func(self, dt)`

- **Location:** source line 92.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `dt` | Not explicitly documented in adjacent source annotations. |

#### 9. `self.battle_start_func(self)`

- **Location:** source line 112.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 10. `mob_sort_func(a, b)`

- **Location:** source line 116.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |

#### 11. `self.on_spawn_func(self, spawn_tile)`

- **Location:** source line 126.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `spawn_tile` | Not explicitly documented in adjacent source annotations. |

#### 12. `self.can_move_to_func(tile)`

- **Location:** source line 131.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |

#### 13. `self.delete_func(self)`

- **Location:** source line 134.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 14. `find_target(self)`

- **Location:** source line 140.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 15. `take_turn(self)`

- **Location:** source line 154.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 16. `self.flame_action.action_end_func()`

- **Location:** source line 168.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 17. `move_random(self)`

- **Location:** source line 180.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 18. `action_flame(character)`

- **Location:** source line 212.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `character` | Not explicitly documented in adjacent source annotations. |

#### 19. `action.execute_func(self, user)`

- **Location:** source line 216.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `user` | Not explicitly documented in adjacent source annotations. |

#### 20. `is_tile_free_for_movement(tile, character)`

- **Location:** source line 232.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |
| 2 | `character` | Not explicitly documented in adjacent source annotations. |

#### 21. `getNextTile(direction, spell)`

- **Location:** source line 245.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `direction` | Not explicitly documented in adjacent source annotations. |
| 2 | `spell` | Not explicitly documented in adjacent source annotations. |

#### 22. `spawn_flame(owner, tile, direction, damage, wave_texture, wave_animation, wave_sfx, cascade_frame_index)`

- **Location:** source line 259.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `owner` | Not explicitly documented in adjacent source annotations. |
| 2 | `tile` | Not explicitly documented in adjacent source annotations. |
| 3 | `direction` | Not explicitly documented in adjacent source annotations. |
| 4 | `damage` | Not explicitly documented in adjacent source annotations. |
| 5 | `wave_texture` | Not explicitly documented in adjacent source annotations. |
| 6 | `wave_animation` | Not explicitly documented in adjacent source annotations. |
| 7 | `wave_sfx` | Not explicitly documented in adjacent source annotations. |
| 8 | `cascade_frame_index` | Not explicitly documented in adjacent source annotations. |

#### 23. `spawn_next()`

- **Location:** source line 265.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 24. `spell.collision_func(self, other)`

- **Location:** source line 287.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `other` | Not explicitly documented in adjacent source annotations. |

#### 25. `spell.update_func()`

- **Location:** source line 319.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 143 | `other_character` | `f:get_field() local team = self:get_team() local target_list = field:find_characters(` |
| 217 | `(none)` | `on_lockout()) action.execute_func = function(self, user) self:add_anim_action(8,` |
| 220 | `(none)` | `() character:toggle_counter(true) end) self:add_anim_action(12,` |
| 225 | `(none)` | `wave_sfx, character.cascade_frame_index) end) self:add_anim_action(14,` |
| 236 | `other_character` | `if not tile:is_walkable() then return false end local occupants = tile:find_characte…` |
| 295 | `(none)` | `fact:get_animation() anim:set_state("flame_impact") anim:on_complete(` |
| 307 | `(none)` | `DEFAULT") animation:refresh(sprite) animation:on_frame(cascade_frame - 10,` |
| 310 | `(none)` | `tile = getNextTile(direction, spell) end) animation:on_frame(cascade_frame,` |
| 314 | `(none)` | `ame, function() spawn_next() end, true) animation:on_complete(` |

## 📦 Tables and data

*No `name = { ... }` or `return { ... }` constructors detected. Dynamically created tables and table mutations may still exist.*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Engine.load_audio` | 1 |
| `Engine.load_texture` | 5 |
| `Engine.play_audio` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
