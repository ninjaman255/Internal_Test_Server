# 📄 `fall_in_animation.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezwarps/fall_in_animation.lua`](../../../../ezlibs-scripts/ezwarps/fall_in_animation.lua)  
> **Source lines:** 40  
> **SHA-256 (UTF-8):** `4c68dc15985bfd…`  
> **Declared/assigned functions detected:** 1  
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

Source-based reference for `scripts/ezlibs-scripts/ezwarps/fall_in_animation.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 8 | `animate` | `player_id` | assigned |

### Function details

#### 1. `animate(player_id)`

- **Location:** source line 8.
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
| 9 | `(none)` | `x=0, y=0, z=40 }, animate=function(player_id) return async(` |

## 📦 Tables and data

The following **5** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `fall_in_animation` — line 1

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `--these offsets will modify the warp landing location so that the player can animate from their spawn location nicely pre_animation_offsets={ x=0, y=0, z=…` |
| `animate` | function | `function(player_id) return async(function() local player_pos = Net.get_player_position(player_id) local area_id = Net.get_player_area(player_id) local lan…` |

### 2. `pre_animation_offsets` — line 3

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | numeric literal | `0` |
| `y` | numeric literal | `0` |
| `z` | numeric literal | `40` |

### 3. `keyframes` — line 14

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ properties={{ property="Z", value=player_pos.z }}, duration=0.0 }` |

### 4. `properties` — line 15

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ property="Z", value=player_pos.z }` |

### 5. `properties` — line 22

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ property="Z", ease="Linear", value=landing_z }` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.sleep` | 1 |
| `Net.animate_player_properties` | 1 |
| `Net.get_player_area` | 1 |
| `Net.get_player_position` | 1 |
| `Net.play_sound` | 1 |
| `Net.shake_player_camera` | 1 |
| `Net.unlock_player_input` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
