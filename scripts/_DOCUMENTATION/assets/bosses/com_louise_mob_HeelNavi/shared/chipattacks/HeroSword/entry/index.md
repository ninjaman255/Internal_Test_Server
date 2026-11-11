# 📄 `entry.lua`

> ⚠️ **Archive-only reference:** The source file `assets/bosses/com_louise_mob_HeelNavi/shared/chipattacks/HeroSword/entry.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../../../../../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `assets/bosses/com_louise_mob_HeelNavi/shared/chipattacks/HeroSword/entry.lua` (not present in the current server ZIP).  
> **Source lines:** 94  
> **SHA-256 (UTF-8):** `df0bc9e0400cd8…`  
> **Declared/assigned functions detected:** 5  
> **Anonymous closures detected:** 3  
> **Table initializers detected:** 1

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

Source-based reference for `assets/bosses/com_louise_mob_HeelNavi/shared/chipattacks/HeroSword/entry.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 7 | `chip.card_create_action` | `actor, props` | assigned |
| 11 | `action.execute_func` | `self, user` | assigned |
| 59 | `create_slash` | `user, props` | declared |
| 73 | `spell.update_func` | `self, dt` | assigned |
| 85 | `spell.can_move_to_func` | `tile` | assigned |

### Function details

#### 1. `chip.card_create_action(actor, props)`

- **Location:** source line 7.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `actor` | Not explicitly documented in adjacent source annotations. |
| 2 | `props` | Not explicitly documented in adjacent source annotations. |

#### 2. `action.execute_func(self, user)`

- **Location:** source line 11.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `user` | Not explicitly documented in adjacent source annotations. |

#### 3. `create_slash(user, props)`

- **Location:** source line 59.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `user` | Not explicitly documented in adjacent source annotations. |
| 2 | `props` | Not explicitly documented in adjacent source annotations. |

#### 4. `spell.update_func(self, dt)`

- **Location:** source line 73.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `dt` | Not explicitly documented in adjacent source annotations. |

#### 5. `spell.can_move_to_func(tile)`

- **Location:** source line 85.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tile` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 13 | `(none)` | `imation_lockout()) action.execute_func = function(self, user) self:add_anim_action(2,` |
| 36 | `(none)` | `animation") blade_anim:set_state("DEFAULT") end ) self:add_anim_action(3,` |
| 47 | `(none)` | `th .. "spell_sword_slashes.animation") anim:set_state("BIG") anim:on_complete(` |

## 📦 Tables and data

The following **1** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `chip` — line 5

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Engine.load_audio` | 1 |
| `Engine.load_texture` | 2 |
| `Engine.play_audio` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
