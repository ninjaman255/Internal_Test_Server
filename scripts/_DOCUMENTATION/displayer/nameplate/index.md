# 📄 `nameplate.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/displayer/nameplate.lua`](../../../displayer/nameplate.lua)  
> **Source lines:** 628  
> **SHA-256 (UTF-8):** `aa5aa842fae14c…`  
> **Declared/assigned functions detected:** 14  
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

Source-based reference for `scripts/displayer/nameplate.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 10 | `scripts/animation-engine/animation-engine` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 36 | `Net:on` | `player_disconnect` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 11 | `ceil_div` | `a, b` | assigned |
| 13 | `Nameplate:new` | `font_system` | declared |
| 52 | `Nameplate:setTextAPI` | `api` | declared |
| 57 | `Nameplate:ensureAssets` | `player_id` | declared |
| 97 | `Nameplate:cleanupPlayer` | `player_id` | declared |
| 117 | `Nameplate:_redraw` | `player_id, np, assets` | declared |
| 260 | `Nameplate:attach` | `player_id, player_data, box_id, box_data, cfg` | declared |
| 419 | `on_update` | `values` | assigned |
| 438 | `on_update` | `values` | assigned |
| 448 | `Nameplate:erase` | `player_id, player_data, box_data` | declared |
| 547 | `Nameplate:begin_close` | `player_id, player_data, box_data, cfg` | declared |
| 604 | `on_update` | `values` | assigned |
| 608 | `on_complete` | `(none)` | assigned |
| 624 | `Nameplate:update` | `player_id, player_data, box_data, dt` | declared |

### Function details

#### 1. `ceil_div(a, b)`

- **Location:** source line 11.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |

#### 2. `Nameplate:new(font_system)`

- **Location:** source line 13.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `font_system` | Not explicitly documented in adjacent source annotations. |

#### 3. `Nameplate:setTextAPI(api)`

- **Location:** source line 52.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Inject the Text API (called from displayer:init() after Text is ready)
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `api` | Not explicitly documented in adjacent source annotations. |

#### 4. `Nameplate:ensureAssets(player_id)`

- **Location:** source line 57.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Ensure all required sprite assets are allocated for a player.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 5. `Nameplate:cleanupPlayer(player_id)`

- **Location:** source line 97.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Deallocate all nameplate assets for a player.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 6. `Nameplate:_redraw(player_id, np, assets)`

- **Location:** source line 117.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Redraw the nameplate based on current np.mids_drawn, np.y, etc.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `np` | Not explicitly documented in adjacent source annotations. |
| 3 | `assets` | Not explicitly documented in adjacent source annotations. |

#### 7. `Nameplate:attach(player_id, player_data, box_id, box_data, cfg)`

- **Location:** source line 260.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Attach a nameplate to a text box.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_data` | Not explicitly documented in adjacent source annotations. |
| 3 | `box_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `box_data` | Not explicitly documented in adjacent source annotations. |
| 5 | `cfg` | Not explicitly documented in adjacent source annotations. |

#### 8. `on_update(values)`

- **Location:** source line 419.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 9. `on_update(values)`

- **Location:** source line 438.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 10. `Nameplate:erase(player_id, player_data, box_data)`

- **Location:** source line 448.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Erase a nameplate
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_data` | Not explicitly documented in adjacent source annotations. |
| 3 | `box_data` | Not explicitly documented in adjacent source annotations. |

#### 11. `Nameplate:begin_close(player_id, player_data, box_data, cfg)`

- **Location:** source line 547.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Begin the closing animation
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_data` | Not explicitly documented in adjacent source annotations. |
| 3 | `box_data` | Not explicitly documented in adjacent source annotations. |
| 4 | `cfg` | Not explicitly documented in adjacent source annotations. |

#### 12. `on_update(values)`

- **Location:** source line 604.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 13. `on_complete()`

- **Location:** source line 608.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 14. `Nameplate:update(player_id, player_data, box_data, dt)`

- **Location:** source line 624.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_data` | Not explicitly documented in adjacent source annotations. |
| 3 | `box_data` | Not explicitly documented in adjacent source annotations. |
| 4 | `dt` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 36 | `event` | `o.nameplate_registry = {} -- player_id -> { box_id = np } Net:on("player_disconnect",` |
| 37 | `(none)` | `{ box_id = np } Net:on("player_disconnect", function(event) local ok, err = pcall(` |

## 📦 Tables and data

The following **9** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Nameplate` — line 7

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `o.player_assets` — line 33

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `o.nameplate_registry` — line 34

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `assets` — line 60

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `assets.base_mid` — line 74

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `assets.frame_mid` — line 86

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `glyph_ids` — line 231

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `frame_tint` — line 348

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `tonumber(f.r) or 255` |
| `g` | expression/reference | `tonumber(f.g) or 255` |
| `b` | expression/reference | `tonumber(f.b) or 255` |
| `a` | expression/reference | `tonumber(f.a) or 255` |
| `color_mode` | expression/reference | `tonumber(f.color_mode) or 2` |

### 9. `np` — line 360

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `box_id` | expression/reference | `box_id` |
| `idp` | expression/reference | `idp` |
| `text` | expression/reference | `text` |
| `font` | expression/reference | `font_name` |
| `text_scale` | expression/reference | `text_scale` |
| `pad_px` | expression/reference | `pad_px` |
| `scale` | expression/reference | `scale` |
| `base_x` | expression/reference | `x` |
| `base_y` | expression/reference | `y` |
| `y` | expression/reference | `y` |
| `z` | expression/reference | `z` |
| `frame` | expression/reference | `frame_tint` |
| `bob_amp` | expression/reference | `(type(cfg) == "table" and cfg.bob_amp) or (3 * scale)` |
| `bob_speed` | expression/reference | `(type(cfg) == "table" and cfg.bob_speed) or 1.0` |
| `bob_offset` | numeric literal | `0` |
| `mids_target` | expression/reference | `mids_target` |
| `mid_w` | expression/reference | `mid_w` |
| `total_w_full` | expression/reference | `total_w` |
| `center_x` | expression/reference | `center_x` |
| `mids_drawn` | numeric literal | `0` |
| `complete` | boolean literal | `false` |
| `text_glyph_ids` | nil | `nil` |
| `closing` | boolean literal | `false` |
| `unfold_anim_id` | nil | `nil` |
| `bob_anim_id` | nil | `nil` |
| `close_anim_id` | nil | `nil` |
| `erasing` | boolean literal | `false` |
| `[28]` | expression/reference | `-- re‑entrancy guard` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 1 |
| `Net.player_alloc_sprite` | 6 |
| `Net.player_dealloc_sprite` | 6 |
| `Net.player_draw_sprite` | 6 |
| `Net.player_erase_sprite` | 11 |
| `Net.provide_asset_for_player` | 6 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
