# 📄 `player_selection.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/player_selection.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/player_selection.lua)  
> **Source lines:** 152  
> **SHA-256 (UTF-8):** `0d703df33bfea9…`  
> **Declared/assigned functions detected:** 11  
> **Anonymous closures detected:** 0  
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

Source-based reference for `scripts/ezlibs-custom/nebulous-liberations/liberations/player_selection.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/ezlibs-custom/nebulous-liberations/liberations/selection` |
| 2 | `scripts/libs/direction` |
| 3 | `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_registry` |
| 4 | `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 9 | `is_dark_hole_panel` | `panel` | local |
| 19 | `includes` | `table, value` | local |
| 29 | `resolve_selection_direction` | `player_pos, panel_object` | local |
| 38 | `PlayerSelection:new` | `instance, player_id` | declared |
| 54 | `filter` | `x, y, z` | local |
| 103 | `PlayerSelection:select_panel` | `panel_object` | declared |
| 115 | `PlayerSelection:set_include_all_liberatable_panels` | `enabled` | declared |
| 119 | `PlayerSelection:set_shape` | `shape, shape_offset_x, shape_offset_y` | declared |
| 125 | `PlayerSelection:get_panels` | `(none)` | declared |
| 140 | `PlayerSelection:clear` | `(none)` | declared |
| 145 | `PlayerSelection:count_panels` | `(none)` | declared |

### Function details

#### 1. `is_dark_hole_panel(panel)`

- **Location:** source line 9.
- **Declaration style:** `local`.
- **Adjacent source comment:** Tiled's "Dark Hole Buffed Virus" is normalized to "Dark Hole" when the mission registers panels. Check the source type as well for older maps and any callers that still supply the original Tiled object type.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `panel` | Not explicitly documented in adjacent source annotations. |

#### 2. `includes(table, value)`

- **Location:** source line 19.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `table` | Not explicitly documented in adjacent source annotations. |
| 2 | `value` | Not explicitly documented in adjacent source annotations. |

#### 3. `resolve_selection_direction(player_pos, panel_object)`

- **Location:** source line 29.
- **Declaration style:** `local`.
- **Adjacent source comment:** private functions

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_pos` | Not explicitly documented in adjacent source annotations. |
| 2 | `panel_object` | Not explicitly documented in adjacent source annotations. |

#### 4. `PlayerSelection:new(instance, player_id)`

- **Location:** source line 38.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 5. `filter(x, y, z)`

- **Location:** source line 54.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |
| 3 | `z` | Not explicitly documented in adjacent source annotations. |

#### 6. `PlayerSelection:select_panel(panel_object)`

- **Location:** source line 103.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `panel_object` | Not explicitly documented in adjacent source annotations. |

#### 7. `PlayerSelection:set_include_all_liberatable_panels(enabled)`

- **Location:** source line 115.
- **Declaration style:** `declared`.
- **Adjacent source comment:** shape = [m][n] bool array, n being odd, just below bottom center is player position
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `enabled` | Not explicitly documented in adjacent source annotations. |

#### 8. `PlayerSelection:set_shape(shape, shape_offset_x, shape_offset_y)`

- **Location:** source line 119.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `shape` | Not explicitly documented in adjacent source annotations. |
| 2 | `shape_offset_x` | Not explicitly documented in adjacent source annotations. |
| 3 | `shape_offset_y` | Not explicitly documented in adjacent source annotations. |

#### 9. `PlayerSelection:get_panels()`

- **Location:** source line 125.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 10. `PlayerSelection:clear()`

- **Location:** source line 140.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 11. `PlayerSelection:count_panels()`

- **Location:** source line 145.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `PlayerSelection` — line 36

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `player_selection` — line 41

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `player_id` | expression/reference | `player_id` |
| `instance` | expression/reference | `instance` |
| `root_panel` | nil | `nil` |
| `selection` | expression/reference | `Selection:new(instance)` |
| `LIBERATING_PANEL_GID` | expression/reference | `LIBERATING_PANEL_GID` |
| `SELECTED_PANEL_GID` | expression/reference | `LIBERATING_PANEL_GID + 1` |
| `include_all_liberatable_panels` | boolean literal | `false` |

### 3. `panels` — line 126

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.get_player_position` | 1 |
| `Net.get_tileset` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
