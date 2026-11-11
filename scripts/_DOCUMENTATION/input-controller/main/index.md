# 📄 `main.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/input-controller/main.lua`](../../../input-controller/main.lua)  
> **Source lines:** 192  
> **SHA-256 (UTF-8):** `f5522cd74635fa…`  
> **Declared/assigned functions detected:** 13  
> **Anonymous closures detected:** 4  
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

main.lua – Unified input API

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 12 | `scripts/utils/utility` |
| 13 | `scripts/input-controller/d-pad` |
| 14 | `scripts/input-controller/input-controller` |
| 15 | `scripts/input-controller/buttons` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 46 | `Net:on` | `player_join` |
| 55 | `Net:on` | `player_disconnect` |
| 64 | `Net:on` | `virtual_input` |
| 71 | `Net:on` | `tick` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 35 | `make_controller` | `player_id, opts` | local |
| 93 | `API.set_controller_class` | `class` | declared |
| 97 | `API.get_controller_class` | `(none)` | declared |
| 103 | `API.get_controller` | `player_id` | declared |
| 108 | `API.get_controller_identity` | `player_id` | declared |
| 119 | `API.create_controller` | `player_id, opts` | declared |
| 127 | `API.spawn_controller` | `player_id, opts` | declared |
| 137 | `API.reload_controller` | `player_id, opts` | declared |
| 150 | `API.set_repeat_delays` | `player_id, first_repeat_delay, repeat_delay` | declared |
| 158 | `API.restore_repeat_delays` | `player_id` | declared |
| 166 | `API.activate_controller` | `player_id` | declared |
| 172 | `API.deactivate_controller` | `player_id` | declared |
| 178 | `API.destroy_controller` | `player_id` | declared |

### Function details

#### 1. `make_controller(player_id, opts)`

- **Location:** source line 35.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 2. `API.set_controller_class(class)`

- **Location:** source line 93.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `class` | Not explicitly documented in adjacent source annotations. |

#### 3. `API.get_controller_class()`

- **Location:** source line 97.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 4. `API.get_controller(player_id)`

- **Location:** source line 103.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 5. `API.get_controller_identity(player_id)`

- **Location:** source line 108.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Diagnostic helper: Lua table identity as seen by each input consumer.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 6. `API.create_controller(player_id, opts)`

- **Location:** source line 119.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create + register a controller for a player_id (idempotent). `opts` may include: auto_activate        (boolean, default true) button_mappings      (table)   override the default mapping direction_raw_names  (table)   override the default direction raw names first_repeat_delay   (number)  seconds before first repeat after press repeat_delay         (number)  seconds between subsequent repeats

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 7. `API.spawn_controller(player_id, opts)`

- **Location:** source line 127.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Build a controller without adding it to the registry.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 8. `API.reload_controller(player_id, opts)`

- **Location:** source line 137.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Swap in fresh mappings on an existing controller without a full destroy/ recreate cycle. If no controller is registered, one is created.  `opts` may include: button_mappings      (table)   new mapping table; omitted = keep current direction_raw_names  (table)   new direction raw-name set; omitted = keep current

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 9. `API.set_repeat_delays(player_id, first_repeat_delay, repeat_delay)`

- **Location:** source line 150.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Runtime repeat-cadence control (convenience wrappers around the per- controller methods).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `first_repeat_delay` | Not explicitly documented in adjacent source annotations. |
| 3 | `repeat_delay` | Not explicitly documented in adjacent source annotations. |

#### 10. `API.restore_repeat_delays(player_id)`

- **Location:** source line 158.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 11. `API.activate_controller(player_id)`

- **Location:** source line 166.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 12. `API.deactivate_controller(player_id)`

- **Location:** source line 172.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 13. `API.destroy_controller(player_id)`

- **Location:** source line 178.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 46 | `event` | `ass.new(player_id, mappings, dirs, opts) end -- Internal event handlers Net:on("play…` |
| 55 | `event` | `ifications are harmless; keep the existing instance. end end) Net:on("player_disconn…` |
| 64 | `event` | `trl:destroy() controllers[event.player_id] = nil end end) Net:on("virtual_input",` |
| 71 | `event` | `_id] if ctrl then ctrl:handle_raw_input(event.events) end end) Net:on("tick",` |

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `button_mappings` — line 18

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `controllers` — line 30

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `API` — line 81

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 4 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
