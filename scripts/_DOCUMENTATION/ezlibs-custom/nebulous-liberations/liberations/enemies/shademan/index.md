# 📄 `shademan.lua`

[🏠 Documentation home](../../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`](../../../../../../ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua)  
> **Source lines:** 111  
> **SHA-256 (UTF-8):** `74a261b13ffc2b…`  
> **Declared/assigned functions detected:** 4  
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

Source-based reference for `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection` |
| 2 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` |
| 3 | `scripts/ezlibs-custom/nebulous-liberations/liberations/preloader` |
| 4 | `scripts/libs/direction` |
| 5 | `scripts/ezlibs-custom/nebulous-liberations/liberations/guard_interception` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 9 | `ShadeMan:new` | `instance, position, direction` | declared |
| 40 | `ShadeMan:spawn` | `direction` | declared |
| 55 | `ShadeMan:get_death_message` | `(none)` | declared |
| 59 | `ShadeMan:take_turn` | `(none)` | declared |

### Function details

#### 1. `ShadeMan:new(instance, position, direction)`

- **Location:** source line 9.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance` | Not explicitly documented in adjacent source annotations. |
| 2 | `position` | Not explicitly documented in adjacent source annotations. |
| 3 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 2. `ShadeMan:spawn(direction)`

- **Location:** source line 40.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 3. `ShadeMan:get_death_message()`

- **Location:** source line 55.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 4. `ShadeMan:take_turn()`

- **Location:** source line 59.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 60 | `(none)` | `graced again...!\nGyaaaahh!!" end function ShadeMan:take_turn() local co = coroutine…` |

## 📦 Tables and data

The following **5** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `ShadeMan` — line 7

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `shademan` — line 10

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `instance` | expression/reference | `instance` |
| `id` | nil | `nil` |
| `health` | numeric literal | `600` |
| `is_boss` | boolean literal | `true` |
| `max_health` | numeric literal | `600` |
| `x` | expression/reference | `math.floor(position.x)` |
| `y` | expression/reference | `math.floor(position.y)` |
| `z` | expression/reference | `math.floor(position.z)` |
| `mug` | nested table | `{ texture_path = "/server/assets/ezlibs-custom/nebulous-liberations/mugs/shademan.png", animation_path = "/server/assets/ezlibs-custom/nebulous-liberation…` |
| `encounter` | string literal | `"/server/assets/ezlibs-assets/ezencounters/Shademan.zip"` |
| `selection` | expression/reference | `EnemySelection:new(instance)` |

### 3. `mug` — line 19

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `texture_path` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/mugs/shademan.png"` |
| `animation_path` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/mugs/shademan.animation"` |

### 4. `shape` — line 30

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1}` |

### 5. `warp_back_pos` — line 88

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `self.x` |
| `y` | expression/reference | `self.y` |
| `z` | expression/reference | `self.z` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.await` | 6 |
| `Async.message_player` | 1 |
| `Async.promisify` | 1 |
| `Async.sleep` | 4 |
| `Net.create_bot` | 1 |
| `Net.set_bot_minimap_color` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
