# 📄 `encounters.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/libs/encounters.lua`](../../../libs/encounters.lua)  
> **Source lines:** 143  
> **SHA-256 (UTF-8):** `a6ce960265fb7a…`  
> **Declared/assigned functions detected:** 6  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 4

## 🗂️ Contents
- [📖 Guides & reference material](#guides--reference-material)

- [📌 Overview](#overview)
- [🔗 Dependencies](#dependencies)
- [📡 Event subscriptions](#event-subscriptions)
- [🧩 Functions](#functions)
- [🪄 Anonymous closures](#anonymous-closures)
- [📦 Tables and data](#tables-and-data)
- [⚙️ Runtime API calls](#runtime-api-calls)
- [🧪 Static-analysis notes](#static-analysis-notes)

## 📌 Overview

Source-based reference for `scripts/libs/encounters.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 8 | `lib.track_player` | `player_id` | declared |
| 16 | `lib.drop_player` | `player_id` | declared |
| 20 | `lib.setup` | `encounter_table` | declared |
| 26 | `lib.setup_area` | `area_id, area_table` | declared |
| 47 | `lib.handle_player_move` | `player_id, x, y, z` | declared |
| 104 | `lib.initiate_direct_encounter` | `player_id, asset_path` | declared |

### Function details

#### 1. `lib.track_player(player_id)`

- **Location:** source line 8.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 2. `lib.drop_player(player_id)`

- **Location:** source line 16.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 3. `lib.setup(encounter_table)`

- **Location:** source line 20.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `encounter_table` | Not explicitly documented in adjacent source annotations. |

#### 4. `lib.setup_area(area_id, area_table)`

- **Location:** source line 26.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `area_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `area_table` | Not explicitly documented in adjacent source annotations. |

#### 5. `lib.handle_player_move(player_id, x, y, z)`

- **Location:** source line 47.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |
| 4 | `z` | Not explicitly documented in adjacent source annotations. |

#### 6. `lib.initiate_direct_encounter(player_id, asset_path)`

- **Location:** source line 104.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `asset_path` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **4** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `lib` — line 1

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `BIG_TILE_MOVEMENT` | numeric literal | `1` |
| `[2]` | expression/reference | `-- users can't walk/run this far without help from the server` |

### 2. `player_trackers` — line 5

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `table` — line 6

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `pos` — line 68

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `x` |
| `y` | expression/reference | `y` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.get_player_area` | 2 |
| `Net.get_player_position` | 1 |
| `Net.initiate_encounter` | 2 |
| `Net.is_player_busy` | 1 |
| `Net.provide_asset` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `README.md`](README.md) | Encounter Tables |
| [📘 `SCHEMA.md`](SCHEMA.md) | Encounter Table Schema |
