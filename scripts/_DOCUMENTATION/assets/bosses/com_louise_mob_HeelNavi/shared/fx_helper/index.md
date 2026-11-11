# 📄 `fx_helper.lua`

> ⚠️ **Archive-only reference:** The source file `assets/bosses/com_louise_mob_HeelNavi/shared/fx_helper.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../../../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `assets/bosses/com_louise_mob_HeelNavi/shared/fx_helper.lua` (not present in the current server ZIP).  
> **Source lines:** 44  
> **SHA-256 (UTF-8):** `996d466c22b03d…`  
> **Declared/assigned functions detected:** 2  
> **Anonymous closures detected:** 1  
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

-@class FxHelper

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 14 | `fx_helper.create_hit_effect` | `field, tile, fx_texture, fx_anim_path, fx_anim_state, sfx` | declared |
| 28 | `fx_helper.create_basic_effect` | `field, tile, hit_texture, hit_anim_path, hit_anim_state` | declared |

### Function details

#### 1. `fx_helper.create_hit_effect(field, tile, fx_texture, fx_anim_path, fx_anim_state, sfx)`

- **Location:** source line 14.
- **Declaration style:** `declared`.
- **Adjacent source comment:** create fx effect. comment
- **Lua documentation annotations:** `@param field A field to spawn the effect on`, `@param tile Tile tile to spawn effect on`, `@param fx_texture any Texture fx effect. (Engine.load_texture)`, `@param fx_anim_path any The animation file path`, `@param fx_anim_state any The fx animation to play`, `@param sfx any Audio # Audio object to play`, `@return any returns the fx fx`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `field` | `@param field A field to spawn the effect on` |
| 2 | `tile` | `@param tile Tile tile to spawn effect on` |
| 3 | `fx_texture` | `@param fx_texture any Texture fx effect. (Engine.load_texture)` |
| 4 | `fx_anim_path` | `@param fx_anim_path any The animation file path` |
| 5 | `fx_anim_state` | `@param fx_anim_state any The fx animation to play` |
| 6 | `sfx` | `@param sfx any Audio # Audio object to play` |

#### 2. `fx_helper.create_basic_effect(field, tile, hit_texture, hit_anim_path, hit_anim_state)`

- **Location:** source line 28.
- **Declaration style:** `declared`.
- **Adjacent source comment:** create a self deleting basic effect. comment
- **Lua documentation annotations:** `@param field A field to spawn the effect on`, `@param tile Tile tile to spawn effect on`, `@param hit_texture any Texture hit effect. (Engine.load_texture)`, `@param hit_anim_path any The animation file path`, `@param hit_anim_state any The hit animation to play`, `@return any returns the hit fx`

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `field` | `@param field A field to spawn the effect on` |
| 2 | `tile` | `@param tile Tile tile to spawn effect on` |
| 3 | `hit_texture` | `@param hit_texture any Texture hit effect. (Engine.load_texture)` |
| 4 | `hit_anim_path` | `@param hit_anim_path any The animation file path` |
| 5 | `hit_anim_state` | `@param hit_anim_state any The hit animation to play` |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 37 | `(none)` | `fx_anim:set_state(hit_anim_state) fx_anim:refresh(fx_sprite) fx_anim:on_complete(` |

## 📦 Tables and data

The following **1** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `fx_helper` — line 2

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Engine.play_audio` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
