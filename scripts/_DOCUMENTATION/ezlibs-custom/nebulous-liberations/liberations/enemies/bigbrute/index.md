# 📄 `bigbrute.lua`

[🏠 Documentation home](../../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`](../../../../../../ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua)  
> **Source lines:** 224  
> **SHA-256 (UTF-8):** `ea4daa2d6e464a…`  
> **Declared/assigned functions detected:** 9  
> **Anonymous closures detected:** 6  
> **Table initializers detected:** 4

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

Source-based reference for `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` |
| 2 | `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection` |
| 3 | `scripts/ezlibs-custom/nebulous-liberations/liberations/preloader` |
| 4 | `scripts/libs/direction` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 11 | `BigBrute:new` | `instance, position, direction` | declared |
| 40 | `BigBrute:spawn` | `direction` | declared |
| 63 | `BigBrute:get_death_message` | `(none)` | declared |
| 67 | `sign` | `a` | local |
| 75 | `find_offset` | `self, xstep, ystep, limit` | local |
| 90 | `attempt_axis_move` | `self, player, diff, xfilter, yfilter` | local |
| 117 | `attempt_move` | `self` | local |
| 156 | `attempt_attack` | `self` | local |
| 216 | `BigBrute:take_turn` | `(none)` | declared |

### Function details

#### 1. `BigBrute:new(instance, position, direction)`

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

#### 2. `BigBrute:spawn(direction)`

- **Location:** source line 40.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 3. `BigBrute:get_death_message()`

- **Location:** source line 63.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 4. `sign(a)`

- **Location:** source line 67.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |

#### 5. `find_offset(self, xstep, ystep, limit)`

- **Location:** source line 75.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `xstep` | Not explicitly documented in adjacent source annotations. |
| 3 | `ystep` | Not explicitly documented in adjacent source annotations. |
| 4 | `limit` | Not explicitly documented in adjacent source annotations. |

#### 6. `attempt_axis_move(self, player, diff, xfilter, yfilter)`

- **Location:** source line 90.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `player` | Not explicitly documented in adjacent source annotations. |
| 3 | `diff` | Not explicitly documented in adjacent source annotations. |
| 4 | `xfilter` | Not explicitly documented in adjacent source annotations. |
| 5 | `yfilter` | Not explicitly documented in adjacent source annotations. |

#### 7. `attempt_move(self)`

- **Location:** source line 117.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 8. `attempt_attack(self)`

- **Location:** source line 156.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 9. `BigBrute:take_turn()`

- **Location:** source line 216.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 91 | `resolve` | `function attempt_axis_move(self, player, diff, xfilter, yfilter) return Async.create…` |
| 111 | `(none)` | `EnemyHelpers.move(self.instance, self, targetx, targety, self.z, target_direction).a…` |
| 118 | `(none)` | `lve(true) end) end) end local function attempt_move(self) local co = coroutine.creat…` |
| 157 | `(none)` | `urn Async.promisify(co) end local function attempt_attack(self) local co = coroutine…` |
| 217 | `resolve` | `return Async.promisify(co) end function BigBrute:take_turn() return Async.create_pro…` |
| 218 | `(none)` | `te:take_turn() return Async.create_promise(function(resolve) attempt_move(self).and_…` |

## 📦 Tables and data

The following **4** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `BigBrute` — line 9

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `bigbrute` — line 12

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `instance` | expression/reference | `instance` |
| `id` | nil | `nil` |
| `battle_name` | string literal | `"BigBrute"` |
| `health` | numeric literal | `120` |
| `max_health` | numeric literal | `120` |
| `x` | expression/reference | `math.floor(position.x)` |
| `y` | expression/reference | `math.floor(position.y)` |
| `z` | expression/reference | `math.floor(position.z)` |
| `selection` | expression/reference | `EnemySelection:new(instance)` |
| `encounter` | string literal | `"/server/assets/encounters/big_brute_encounter.zip"` |

### 3. `shape` — line 28

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1, 1, 1}` |
| `[2]` | nested table | `{1, 0, 1}` |
| `[3]` | nested table | `{1, 1, 1}` |

### 4. `spawned_bots` — line 175

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.await` | 8 |
| `Async.create_promise` | 2 |
| `Async.promisify` | 2 |
| `Async.sleep` | 4 |
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
