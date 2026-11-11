# 📄 `camera-manager.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/camera/camera-manager.lua`](../../../camera/camera-manager.lua)  
> **Source lines:** 159  
> **SHA-256 (UTF-8):** `6bdd2b97bb801b…`  
> **Declared/assigned functions detected:** 12  
> **Anonymous closures detected:** 0  
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

Source-based reference for `scripts/camera/camera-manager.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 8 | `scripts/camera/camera-controller` |
| 9 | `scripts/enum/predefined-enums` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 12 | `dbg` | `...` | local |
| 18 | `CameraManager:init` | `handle_on_join, tile_interaction, setup_inputs` | declared |
| 22 | `CameraManager:setup_event_listeners` | `handle_on_join, tile_interaction, setup_inputs` | declared |
| 28 | `CameraManager:get_controller` | `player_id` | declared |
| 36 | `CameraManager:activate_camera` | `player_id, mode, lock_input` | declared |
| 67 | `CameraManager:deactivate_camera` | `player_id, keep_camera_position` | declared |
| 82 | `CameraManager:is_camera_active` | `player_id` | declared |
| 91 | `CameraManager:has_pending_move` | `player_id` | declared |
| 100 | `CameraManager:move_camera` | `player_id, x, y, z` | declared |
| 114 | `CameraManager:pan_camera` | `player_id, dx, dy, dz` | declared |
| 128 | `CameraManager:get_camera_position` | `player_id` | declared |
| 141 | `CameraManager:get_pending_camera_position` | `player_id` | declared |

### Function details

#### 1. `dbg(...)`

- **Location:** source line 12.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 2. `CameraManager:init(handle_on_join, tile_interaction, setup_inputs)`

- **Location:** source line 18.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `handle_on_join` | Not explicitly documented in adjacent source annotations. |
| 2 | `tile_interaction` | Not explicitly documented in adjacent source annotations. |
| 3 | `setup_inputs` | Not explicitly documented in adjacent source annotations. |

#### 3. `CameraManager:setup_event_listeners(handle_on_join, tile_interaction, setup_inputs)`

- **Location:** source line 22.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `handle_on_join` | Not explicitly documented in adjacent source annotations. |
| 2 | `tile_interaction` | Not explicitly documented in adjacent source annotations. |
| 3 | `setup_inputs` | Not explicitly documented in adjacent source annotations. |

#### 4. `CameraManager:get_controller(player_id)`

- **Location:** source line 28.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 5. `CameraManager:activate_camera(player_id, mode, lock_input)`

- **Location:** source line 36.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `mode` | Not explicitly documented in adjacent source annotations. |
| 3 | `lock_input` | Not explicitly documented in adjacent source annotations. |

#### 6. `CameraManager:deactivate_camera(player_id, keep_camera_position)`

- **Location:** source line 67.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `keep_camera_position` | Not explicitly documented in adjacent source annotations. |

#### 7. `CameraManager:is_camera_active(player_id)`

- **Location:** source line 82.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 8. `CameraManager:has_pending_move(player_id)`

- **Location:** source line 91.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 9. `CameraManager:move_camera(player_id, x, y, z)`

- **Location:** source line 100.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |
| 4 | `z` | Not explicitly documented in adjacent source annotations. |

#### 10. `CameraManager:pan_camera(player_id, dx, dy, dz)`

- **Location:** source line 114.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `dx` | Not explicitly documented in adjacent source annotations. |
| 3 | `dy` | Not explicitly documented in adjacent source annotations. |
| 4 | `dz` | Not explicitly documented in adjacent source annotations. |

#### 11. `CameraManager:get_camera_position(player_id)`

- **Location:** source line 128.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 12. `CameraManager:get_pending_camera_position(player_id)`

- **Location:** source line 141.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `CameraManager` — line 2

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `PlayerControllers` — line 5

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
