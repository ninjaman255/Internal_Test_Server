# 📄 `mettaur.lua`

[🏠 Documentation home](../../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/mettaur.lua`](../../../../../../ezlibs-custom/nebulous-liberations/liberations/enemies/mettaur.lua)  
> **Source lines:** 223  
> **SHA-256 (UTF-8):** `7d45bbc2718911…`  
> **Declared/assigned functions detected:** 4  
> **Anonymous closures detected:** 2  
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

Mettaur overworld template and directional shockwave AI. Registered by enemy_templates.lua after its shared AI helpers are defined. No separate enemy constructor: EnemyTemplates.create handles instance lifecycle.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 4 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` |
| 5 | `scripts/ezlibs-custom/nebulous-liberations/liberations/guard_interception` |
| 6 | `scripts/ezlibs-custom/nebulous-liberations/liberations/preloader` |
| 7 | `scripts/libs/direction` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 34 | `has_terrain_tile` | `instance, x, y, z` | local |
| 45 | `aligned_shockwave_direction` | `x, y, target_x, target_y` | local |
| 59 | `find_shockwave_firing_position` | `self, target` | local |
| 99 | `EnemyTemplates.ai.shockwave_line` | `self` | declared |

### Function details

#### 1. `has_terrain_tile(instance, x, y, z)`

- **Location:** source line 34.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |
| 4 | `z` | Not explicitly documented in adjacent source annotations. |

#### 2. `aligned_shockwave_direction(x, y, target_x, target_y)`

- **Location:** source line 45.
- **Declaration style:** `local`.
- **Adjacent source comment:** A shockwave is one straight three-tile ray in the direction the Mettaur faces. The normal enemy turn loop calls this once; no client battle AI is involved. First try to align with the target by moving to a nearby valid enemy-owned panel, then always play the attack (a miss still has visuals).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |
| 3 | `target_x` | Not explicitly documented in adjacent source annotations. |
| 4 | `target_y` | Not explicitly documented in adjacent source annotations. |

#### 3. `find_shockwave_firing_position(self, target)`

- **Location:** source line 59.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `target` | Not explicitly documented in adjacent source annotations. |

#### 4. `EnemyTemplates.ai.shockwave_line(self)`

- **Location:** source line 99.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 9 | `EnemyTemplates` | `iberations/liberations/preloader") local Direction = require("scripts/libs/direction…` |
| 100 | `(none)` | `turn best end function EnemyTemplates.ai.shockwave_line(self) local co = coroutine.c…` |

## 📦 Tables and data

The following **5** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `SHOCKWAVE_DIRECTION` — line 19

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[Direction.UP_LEFT]` | nested table | `{ suffix = "UL", dx = -1, dy = 0 }` |
| `[Direction.UP_RIGHT]` | nested table | `{ suffix = "UR", dx = 0, dy = -1 }` |
| `[Direction.DOWN_RIGHT]` | nested table | `{ suffix = "DR", dx = 1, dy = 0 }` |
| `[Direction.DOWN_LEFT]` | nested table | `{ suffix = "DL", dx = 0, dy = 1 }` |

### 2. `SHOCKWAVE_FRAME_SECONDS` — line 27

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `0.09` |
| `[2]` | numeric literal | `0.10` |
| `[3]` | numeric literal | `0.11` |
| `[4]` | numeric literal | `0.125` |
| `[5]` | numeric literal | `0.125` |
| `[6]` | numeric literal | `0.13` |

### 3. `best` — line 88

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `x` |
| `y` | expression/reference | `y` |
| `direction` | expression/reference | `direction` |

### 4. `spawned_bots` — line 149

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `shape` — line 217

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1}` |
| `[2]` | nested table | `{1}` |
| `[3]` | nested table | `{1}` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.await` | 5 |
| `Async.promisify` | 1 |
| `Async.sleep` | 4 |
| `Net.create_bot` | 1 |
| `Net.get_bot_direction` | 1 |
| `Net.remove_bot` | 1 |
| `Net.set_bot_direction` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
