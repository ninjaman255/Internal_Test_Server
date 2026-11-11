# 📄 `exploding_effect.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`](../../../../../ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua)  
> **Source lines:** 98  
> **SHA-256 (UTF-8):** `cb875c71fca73a…`  
> **Declared/assigned functions detected:** 5  
> **Anonymous closures detected:** 2  
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

Source-based reference for `scripts/ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 5 | `update_tracked_position` | `exploding_effect` | local |
| 17 | `explode` | `self, explosion_bot_id` | local |
| 52 | `spawn` | `self, area_id, position` | local |
| 77 | `ExplodingEffect:new` | `actor_id` | declared |
| 94 | `ExplodingEffect:remove` | `(none)` | declared |

### Function details

#### 1. `update_tracked_position(exploding_effect)`

- **Location:** source line 5.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `exploding_effect` | Not explicitly documented in adjacent source annotations. |

#### 2. `explode(self, explosion_bot_id)`

- **Location:** source line 17.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `explosion_bot_id` | Not explicitly documented in adjacent source annotations. |

#### 3. `spawn(self, area_id, position)`

- **Location:** source line 52.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `area_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `position` | Not explicitly documented in adjacent source annotations. |

#### 4. `ExplodingEffect:new(actor_id)`

- **Location:** source line 77.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `actor_id` | Not explicitly documented in adjacent source annotations. |

#### 5. `ExplodingEffect:remove()`

- **Location:** source line 94.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 47 | `(none)` | `ion_bot_id, "SMOKE") end -- explode again Async.sleep(EXPLOSION_DURATION) .and_then(` |
| 66 | `(none)` | `> 1 then Async.sleep((i - 1) * EXPLOSION_DURATION / TOTAL_EXPLOSIONS) .and_then(` |

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `ExplodingEffect` — line 75

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `exploding_effect` — line 78

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `tracked_actor_id` | expression/reference | `actor_id` |
| `position` | nil | `nil` |
| `area_id` | nil | `nil` |
| `done` | boolean literal | `false` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.sleep` | 2 |
| `Net.animate_bot` | 2 |
| `Net.create_bot` | 1 |
| `Net.get_bot_area` | 1 |
| `Net.get_bot_position` | 1 |
| `Net.get_player_area` | 1 |
| `Net.get_player_position` | 1 |
| `Net.is_bot` | 1 |
| `Net.is_player` | 1 |
| `Net.play_sound` | 1 |
| `Net.remove_bot` | 1 |
| `Net.transfer_bot` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
