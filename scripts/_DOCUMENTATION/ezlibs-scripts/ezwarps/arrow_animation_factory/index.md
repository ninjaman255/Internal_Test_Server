# 📄 `arrow_animation_factory.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezwarps/arrow_animation_factory.lua`](../../../../ezlibs-scripts/ezwarps/arrow_animation_factory.lua)  
> **Source lines:** 93  
> **SHA-256 (UTF-8):** `979f83bbdd6154…`  
> **Declared/assigned functions detected:** 2  
> **Anonymous closures detected:** 1  
> **Table initializers detected:** 7

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

Source-based reference for `scripts/ezlibs-scripts/ezwarps/arrow_animation_factory.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/ezlibs-scripts/ezweather` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 17 | `create_arrow_animation` | `is_arriving,direction_str` | declared |
| 44 | `animate` | `player_id` | assigned |

### Function details

#### 1. `create_arrow_animation(is_arriving,direction_str)`

- **Location:** source line 17.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `is_arriving` | Not explicitly documented in adjacent source annotations. |
| 2 | `direction_str` | Not explicitly documented in adjacent source annotations. |

#### 2. `animate(player_id)`

- **Location:** source line 44.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 45 | `(none)` | `ffset, z=0 }, animate=function(player_id) return async(` |

## 📦 Tables and data

The following **7** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Direction` — line 3

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `UP_LEFT` | string literal | `"Up Left"` |
| `UP_RIGHT` | string literal | `"Up Right"` |
| `DOWN_LEFT` | string literal | `"Down Left"` |
| `DOWN_RIGHT` | string literal | `"Down Right"` |

### 2. `reverse_table` — line 10

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `["Up Left"] = "Down Right"` |
| `[2]` | expression/reference | `["Up Right"] = "Down Left"` |
| `[3]` | expression/reference | `["Down Left"] = "Up Right"` |
| `[4]` | expression/reference | `["Down Right"] = "Up Left"` |

### 3. `new_animation` — line 38

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `pre_animation_offsets` | nested table | `{ x=x_start_offset, y=y_start_offset, z=0 }` |
| `animate` | function | `function(player_id) return async(function() local player_pos = Net.get_player_position(player_id) local area_id = Net.get_player_area(player_id) local wea…` |

### 4. `pre_animation_offsets` — line 39

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `x_start_offset` |
| `y` | expression/reference | `y_start_offset` |
| `z` | numeric literal | `0` |

### 5. `player_keyframes` — line 49

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `properties` — line 52

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ property="X", ease="Linear", value=player_pos.x, }` |
| `[2]` | nested table | `{ property="Y", ease="Linear", value=player_pos.y }` |

### 7. `properties` — line 73

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ property="X", ease="Linear", value=player_pos.x+x_distance }` |
| `[2]` | nested table | `{ property="Y", ease="Linear", value=player_pos.y+y_distance }` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.sleep` | 1 |
| `Net.animate_player_properties` | 1 |
| `Net.fade_player_camera` | 2 |
| `Net.get_player_area` | 1 |
| `Net.get_player_position` | 1 |
| `Net.move_player_camera` | 1 |
| `Net.slide_player_camera` | 1 |
| `Net.unlock_player_camera` | 2 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
