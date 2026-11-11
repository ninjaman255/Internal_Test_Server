# 📄 `ui-safe.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/ui-safe.lua`](../../../net-games/ui-safe.lua)  
> **Source lines:** 164  
> **SHA-256 (UTF-8):** `2271b874de226e…`  
> **Declared/assigned functions detected:** 12  
> **Anonymous closures detected:** 1  
> **Table initializers detected:** 5

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

Small hardened sprite helper for reusable net-games UI. Public coordinates are virtual 240x160 coordinates. Production lessons captured here: * arbitrary assets are checked before provide_asset_for_player when possible; * changing a texture/animation allocates a fresh physical sprite id to avoid

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 160 | `Net:on` | `player_disconnect` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 18 | `player_state` | `player_id` | local |
| 23 | `confirmed_missing` | `path` | local |
| 30 | `UISafe.asset_exists` | `path` | declared |
| 34 | `UISafe.safe_provide` | `player_id, path` | declared |
| 39 | `same_draw` | `a, b` | local |
| 51 | `erase_entry` | `player_id, entry` | local |
| 57 | `allocate_entry` | `player_id, logical_id, texture_path, anim_path, anim_state` | local |
| 80 | `virtual_to_screen` | `v, pixel_snap` | local |
| 86 | `UISafe.draw` | `player_id, logical_id, texture_path, options` | declared |
| 136 | `UISafe.erase` | `player_id, logical_id` | declared |
| 147 | `UISafe.cleanup_player` | `player_id` | declared |
| 154 | `UISafe.invalidate` | `player_id, logical_id` | declared |

### Function details

#### 1. `player_state(player_id)`

- **Location:** source line 18.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 2. `confirmed_missing(path)`

- **Location:** source line 23.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `path` | Not explicitly documented in adjacent source annotations. |

#### 3. `UISafe.asset_exists(path)`

- **Location:** source line 30.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `path` | Not explicitly documented in adjacent source annotations. |

#### 4. `UISafe.safe_provide(player_id, path)`

- **Location:** source line 34.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `path` | Not explicitly documented in adjacent source annotations. |

#### 5. `same_draw(a, b)`

- **Location:** source line 39.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |

#### 6. `erase_entry(player_id, entry)`

- **Location:** source line 51.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `entry` | Not explicitly documented in adjacent source annotations. |

#### 7. `allocate_entry(player_id, logical_id, texture_path, anim_path, anim_state)`

- **Location:** source line 57.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `logical_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `texture_path` | Not explicitly documented in adjacent source annotations. |
| 4 | `anim_path` | Not explicitly documented in adjacent source annotations. |
| 5 | `anim_state` | Not explicitly documented in adjacent source annotations. |

#### 8. `virtual_to_screen(v, pixel_snap)`

- **Location:** source line 80.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `v` | Not explicitly documented in adjacent source annotations. |
| 2 | `pixel_snap` | Not explicitly documented in adjacent source annotations. |

#### 9. `UISafe.draw(player_id, logical_id, texture_path, options)`

- **Location:** source line 86.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `logical_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `texture_path` | Not explicitly documented in adjacent source annotations. |
| 4 | `options` | Not explicitly documented in adjacent source annotations. |

#### 10. `UISafe.erase(player_id, logical_id)`

- **Location:** source line 136.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `logical_id` | Not explicitly documented in adjacent source annotations. |

#### 11. `UISafe.cleanup_player(player_id)`

- **Location:** source line 147.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 12. `UISafe.invalidate(player_id, logical_id)`

- **Location:** source line 154.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `logical_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 160 | `event` | `ring(logical_id)] if entry then entry.last_draw = nil end end Net:on("player_disconn…` |

## 📦 Tables and data

The following **5** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `UISafe` — line 13

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `players` — line 15

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `keys` — line 41

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"x"` |
| `[2]` | string literal | `"y"` |
| `[3]` | string literal | `"z"` |
| `[4]` | string literal | `"sx"` |
| `[5]` | string literal | `"sy"` |
| `[6]` | string literal | `"r"` |
| `[7]` | string literal | `"g"` |
| `[8]` | string literal | `"b"` |
| `[9]` | string literal | `"opacity"` |
| `[10]` | string literal | `"a"` |
| `[11]` | string literal | `"ro"` |
| `[12]` | string literal | `"ox"` |
| `[13]` | string literal | `"oy"` |
| `[14]` | string literal | `"color_mode"` |
| `[15]` | string literal | `"anim_state"` |

### 4. `return` — line 70

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `logical_id` | expression/reference | `logical_id` |
| `draw_id` | string literal | `"ngui_draw_" .. tostring(logical_id)` |
| `sprite_id` | expression/reference | `sprite_id` |
| `texture_path` | expression/reference | `texture_path` |
| `anim_path` | expression/reference | `anim_path or ""` |
| `last_draw` | nil | `nil` |

### 5. `draw` — line 107

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `id` | expression/reference | `entry.draw_id` |
| `x` | expression/reference | `virtual_to_screen(options.x, options.pixel_snap)` |
| `y` | expression/reference | `virtual_to_screen(options.y, options.pixel_snap)` |
| `z` | expression/reference | `options.z or 100` |
| `sx` | expression/reference | `options.sx or options.scale or 2.0` |
| `sy` | expression/reference | `options.sy or options.scale or options.sx or 2.0` |
| `r` | expression/reference | `options.r or 255` |
| `g` | expression/reference | `options.g or 255` |
| `b` | expression/reference | `options.b or 255` |
| `opacity` | expression/reference | `options.opacity or 255` |
| `a` | expression/reference | `options.a or 255` |
| `ro` | expression/reference | `options.ro or 0` |
| `ox` | expression/reference | `options.ox` |
| `oy` | expression/reference | `options.oy` |
| `color_mode` | expression/reference | `options.color_mode or 0` |
| `anim_state` | expression/reference | `options.anim_state or ""` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
