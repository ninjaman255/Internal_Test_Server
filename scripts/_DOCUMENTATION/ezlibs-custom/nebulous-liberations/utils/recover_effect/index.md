# 📄 `recover_effect.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/utils/recover_effect.lua`](../../../../../ezlibs-custom/nebulous-liberations/utils/recover_effect.lua)  
> **Source lines:** 55  
> **SHA-256 (UTF-8):** `e107218642d5cd…`  
> **Declared/assigned functions detected:** 2  
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

Source-based reference for `scripts/ezlibs-custom/nebulous-liberations/utils/recover_effect.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 5 | `RecoverEffect:new` | `actor_id, area_wide_sfx` | declared |
| 51 | `RecoverEffect:remove` | `(none)` | declared |

### Function details

#### 1. `RecoverEffect:new(actor_id, area_wide_sfx)`

- **Location:** source line 5.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `actor_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `area_wide_sfx` | Not explicitly documented in adjacent source annotations. |

#### 2. `RecoverEffect:remove()`

- **Location:** source line 51.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 41 | `resolve` | `Net.animate_bot(recover_bot_id, "RECOVER") recover_effect.promise = Async.create_pro…` |
| 42 | `(none)` | `recover_effect.promise = Async.create_promise(function(resolve) Async.sleep(.5).and_…` |

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `RecoverEffect` — line 1

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `recover_effect` — line 6

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `promise` | nil | `nil` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.create_promise` | 1 |
| `Async.sleep` | 1 |
| `Net.animate_bot` | 1 |
| `Net.create_bot` | 1 |
| `Net.get_bot_area` | 1 |
| `Net.get_bot_position` | 1 |
| `Net.get_player_area` | 1 |
| `Net.get_player_position` | 1 |
| `Net.is_bot` | 1 |
| `Net.is_player` | 2 |
| `Net.play_sound` | 1 |
| `Net.play_sound_for_player` | 1 |
| `Net.remove_bot` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
