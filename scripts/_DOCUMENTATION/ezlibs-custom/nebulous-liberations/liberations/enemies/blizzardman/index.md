# 📄 `blizzardman.lua`

[🏠 Documentation home](../../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`](../../../../../../ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua)  
> **Source lines:** 159  
> **SHA-256 (UTF-8):** `3545179c7760c6…`  
> **Declared/assigned functions detected:** 4  
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

Source-based reference for `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection` |
| 2 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` |
| 3 | `scripts/ezlibs-custom/nebulous-liberations/liberations/preloader` |
| 4 | `scripts/ezlibs-custom/nebulous-liberations/liberations/guard_interception` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 11 | `BlizzardMan:new` | `instance, position, direction` | declared |
| 45 | `BlizzardMan:spawn` | `direction` | declared |
| 59 | `BlizzardMan:get_death_message` | `(none)` | declared |
| 63 | `BlizzardMan:take_turn` | `(none)` | declared |

### Function details

#### 1. `BlizzardMan:new(instance, position, direction)`

- **Location:** source line 11.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `position` | Not explicitly documented in adjacent source annotations. |
| 3 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 2. `BlizzardMan:spawn(direction)`

- **Location:** source line 45.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 3. `BlizzardMan:get_death_message()`

- **Location:** source line 59.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 4. `BlizzardMan:take_turn()`

- **Location:** source line 63.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 64 | `(none)` | `it. I can't lose.\nNOOOO!" end function BlizzardMan:take_turn() local co = coroutine…` |

## 📦 Tables and data

The following **7** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `BlizzardMan` — line 9

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `blizzardman` — line 12

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `instance` | expression/reference | `instance` |
| `id` | nil | `nil` |
| `health` | numeric literal | `400` |
| `is_boss` | boolean literal | `true` |
| `max_health` | numeric literal | `400` |
| `x` | expression/reference | `math.floor(position.x)` |
| `y` | expression/reference | `math.floor(position.y)` |
| `z` | expression/reference | `math.floor(position.z)` |
| `mug` | nested table | `{ texture_path = "/server/assets/ezlibs-custom/nebulous-liberations/mugs/blizzardman.png", animation_path = "/server/assets/ezlibs-custom/nebulous-liberat…` |
| `encounter` | string literal | `"/server/assets/encounters/big_brute_encounter.zip"` |
| `selection` | expression/reference | `EnemySelection:new(instance)` |

### 3. `mug` — line 21

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/mugs/blizzardman.png"` |
| `animation_path` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/mugs/blizzardman.animation"` |

### 4. `shape` — line 32

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1, 1, 1}` |
| `[2]` | nested table | `{1, 0, 1}` |
| `[3]` | nested table | `{1, 1, 1}` |
| `[4]` | nested table | `{1, 1, 1}` |

### 5. `spawned_bots` — line 103

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `properties` — line 120

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ property = "Animation", value = "FALL" }` |

### 7. `properties` — line 125

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ property = "Z", ease = "Linear", value = position.z + 1 }` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.await` | 6 |
| `Async.promisify` | 1 |
| `Async.sleep` | 6 |
| `Net.animate_bot_properties` | 1 |
| `Net.create_bot` | 2 |
| `Net.get_bot_direction` | 1 |
| `Net.remove_bot` | 1 |
| `Net.set_bot_minimap_color` | 1 |
| `Net.shake_player_camera` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
