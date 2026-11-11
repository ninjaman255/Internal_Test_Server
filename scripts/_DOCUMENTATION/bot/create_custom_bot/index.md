# 📄 `create_custom_bot.lua`

> ⚠️ **Archive-only reference:** The source file `scripts/bot/create_custom_bot.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `scripts/bot/create_custom_bot.lua` (not present in the current server ZIP).  
> **Source lines:** 96  
> **SHA-256 (UTF-8):** `07cc83393658de…`  
> **Declared/assigned functions detected:** 8  
> **Anonymous closures detected:** 0  
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

Source-based reference for `scripts/bot/create_custom_bot.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 1 | `create_custom_bot` | `id, initial_data` | local |
| 18 | `bot._tick` | `delta_time` | declared |
| 57 | `bot.message_player` | `player_id, message` | declared |
| 61 | `bot.question_player` | `player_id, message` | declared |
| 65 | `bot.quiz_player` | `player_id, option_a, option_b, option_c` | declared |
| 69 | `bot._handle_actor_interaction` | `player_id, other_id` | declared |
| 79 | `bot._handle_textbox_response` | `player_id, response` | declared |
| 85 | `bot._handle_player_disconnect` | `player_id` | declared |

### Function details

#### 1. `create_custom_bot(id, initial_data)`

- **Location:** source line 1.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `id` | Not explicitly documented in adjacent source annotations. |
| 2 | `initial_data` | Not explicitly documented in adjacent source annotations. |

#### 2. `bot._tick(delta_time)`

- **Location:** source line 18.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `delta_time` | Not explicitly documented in adjacent source annotations. |

#### 3. `bot.message_player(player_id, message)`

- **Location:** source line 57.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `message` | Not explicitly documented in adjacent source annotations. |

#### 4. `bot.question_player(player_id, message)`

- **Location:** source line 61.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `message` | Not explicitly documented in adjacent source annotations. |

#### 5. `bot.quiz_player(player_id, option_a, option_b, option_c)`

- **Location:** source line 65.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `option_a` | Not explicitly documented in adjacent source annotations. |
| 3 | `option_b` | Not explicitly documented in adjacent source annotations. |
| 4 | `option_c` | Not explicitly documented in adjacent source annotations. |

#### 6. `bot._handle_actor_interaction(player_id, other_id)`

- **Location:** source line 69.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `other_id` | Not explicitly documented in adjacent source annotations. |

#### 7. `bot._handle_textbox_response(player_id, response)`

- **Location:** source line 79.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `response` | Not explicitly documented in adjacent source annotations. |

#### 8. `bot._handle_player_disconnect(player_id)`

- **Location:** source line 85.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `bot` — line 2

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `_id` | expression/reference | `id` |
| `x` | expression/reference | `initial_data.x` |
| `y` | expression/reference | `initial_data.y` |
| `z` | expression/reference | `initial_data.z` |
| `path` | nested table | `{}` |
| `_path_target_index` | numeric literal | `1` |
| `talking_to` | nil | `nil` |
| `speed` | numeric literal | `1.2` |
| `size` | expression/reference | `.35` |
| `mug_texture_path` | nil | `nil` |
| `mug_animation_path` | nil | `nil` |
| `on_interact` | nil | `nil` |
| `on_response` | nil | `nil` |

### 2. `path` — line 7

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.create_bot` | 1 |
| `Net.get_bot_area` | 1 |
| `Net.get_player_position` | 1 |
| `Net.list_players` | 1 |
| `Net.message_player` | 1 |
| `Net.move_bot` | 2 |
| `Net.question_player` | 1 |
| `Net.quiz_player` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
