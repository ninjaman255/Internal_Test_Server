# 📄 `entry.lua`

> ⚠️ **Archive-only reference:** The source file `assets/bosses/com_louise_mob_HeelNavi/shared/chipattacks/Cannonball/entry.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../../../../../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `assets/bosses/com_louise_mob_HeelNavi/shared/chipattacks/Cannonball/entry.lua` (not present in the current server ZIP).  
> **Source lines:** 156  
> **SHA-256 (UTF-8):** `60f10959657813…`  
> **Declared/assigned functions detected:** 9  
> **Anonymous closures detected:** 3  
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

Source-based reference for `assets/bosses/com_louise_mob_HeelNavi/shared/chipattacks/Cannonball/entry.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 10 | `debug_print` | `text` | declared |
| 24 | `chip.card_create_action` | `user, props, target_tile_in` | assigned |
| 39 | `action.execute_func` | `self, user` | assigned |
| 62 | `action.on_landing` | `(none)` | assigned |
| 81 | `toss_spell` | `tosser, toss_height, texture, animation_path, target_tile, frames_in_air, arrival_callback` | declared |
| 105 | `spell.update_func` | `self` | assigned |
| 119 | `spell.can_move_to_func` | `tile` | assigned |
| 125 | `hit_explosion` | `user, target_tile, props, texture, anim_path, explosion_sound` | declared |
| 142 | `spell.update_func` | `self` | assigned |

### Function details

#### 1. `debug_print(text)`

- **Location:** source line 10.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text` | Not explicitly documented in adjacent source annotations. |

#### 2. `chip.card_create_action(user, props, target_tile_in)`

- **Location:** source line 24.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `user` | Not explicitly documented in adjacent source annotations. |
| 2 | `props` | Not explicitly documented in adjacent source annotations. |
| 3 | `target_tile_in` | Not explicitly documented in adjacent source annotations. |

#### 3. `action.execute_func(self, user)`

- **Location:** source line 39.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `user` | Not explicitly documented in adjacent source annotations. |

#### 4. `action.on_landing()`

- **Location:** source line 62.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 5. `toss_spell(tosser, toss_height, texture, animation_path, target_tile, frames_in_air, arrival_callback)`

- **Location:** source line 81.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tosser` | Not explicitly documented in adjacent source annotations. |
| 2 | `toss_height` | Not explicitly documented in adjacent source annotations. |
| 3 | `texture` | Not explicitly documented in adjacent source annotations. |
| 4 | `animation_path` | Not explicitly documented in adjacent source annotations. |
| 5 | `target_tile` | Not explicitly documented in adjacent source annotations. |
| 6 | `frames_in_air` | Not explicitly documented in adjacent source annotations. |
| 7 | `arrival_callback` | Not explicitly documented in adjacent source annotations. |

#### 6. `spell.update_func(self)`

- **Location:** source line 105.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 7. `spell.can_move_to_func(tile)`

- **Location:** source line 119.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |

#### 8. `hit_explosion(user, target_tile, props, texture, anim_path, explosion_sound)`

- **Location:** source line 125.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `user` | Not explicitly documented in adjacent source annotations. |
| 2 | `target_tile` | Not explicitly documented in adjacent source annotations. |
| 3 | `props` | Not explicitly documented in adjacent source annotations. |
| 4 | `texture` | Not explicitly documented in adjacent source annotations. |
| 5 | `anim_path` | Not explicitly documented in adjacent source annotations. |
| 6 | `explosion_sound` | Not explicitly documented in adjacent source annotations. |

#### 9. `spell.update_func(self)`

- **Location:** source line 142.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 51 | `(none)` | `ion:set_state("DEFAULT") user:toggle_counter(true) self:add_anim_action(3,` |
| 71 | `(none)` | `mes_in_air, action.on_landing) end) self:add_anim_action(4,` |
| 136 | `(none)` | `e:set_texture(texture) spell_animation:refresh(sprite) spell_animation:on_complete(` |

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `chip` — line 16

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `name` | string literal | `"Ball"` |
| `damage` | numeric literal | `140` |
| `element` | expression/reference | `Element.Break` |
| `description` | string literal | `"Breaks 3rd panel ahead"` |
| `codes` | nested table | `{ "C", "T", "Z", "B", "V", "*" }` |

### 2. `codes` — line 21

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"C"` |
| `[2]` | string literal | `"T"` |
| `[3]` | string literal | `"Z"` |
| `[4]` | string literal | `"B"` |
| `[5]` | string literal | `"V"` |
| `[6]` | string literal | `"*"` |

### 3. `override_frames` — line 27

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ 1, 0.064 }` |
| `[2]` | nested table | `{ 2, 0.064 }` |
| `[3]` | nested table | `{ 3, 0.064 }` |
| `[4]` | nested table | `{ 4, 0.064 }` |
| `[5]` | nested table | `{ 5, 0.064 }` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Engine.load_audio` | 2 |
| `Engine.load_texture` | 2 |
| `Engine.play_audio` | 2 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
