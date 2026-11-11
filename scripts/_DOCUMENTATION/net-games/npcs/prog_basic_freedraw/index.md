# 📄 `prog_basic_freedraw.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_basic_freedraw.lua`](../../../../net-games/npcs/prog_basic_freedraw.lua)  
> **Source lines:** 128  
> **SHA-256 (UTF-8):** `c454f5e77d7c3e…`  
> **Declared/assigned functions detected:** 4  
> **Anonymous closures detected:** 3  
> **Table initializers detected:** 3

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

Tiled-spawned NPC that draws ALL available fonts on screen WITHOUT using Dialogue / textbox pipeline.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 7 | `scripts/libs/direction` |
| 8 | `scripts/displayer/displayer` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 109 | `Net:on` | `actor_interaction` |
| 126 | `Net:on` | `player_disconnect` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 11 | `dbg` | `msg` | local |
| 57 | `display_id_for` | `font_name` | local |
| 61 | `show` | `player_id` | local |
| 96 | `hide` | `player_id` | local |

### Function details

#### 1. `dbg(msg)`

- **Location:** source line 11.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `msg` | Not explicitly documented in adjacent source annotations. |

#### 2. `display_id_for(font_name)`

- **Location:** source line 57.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `font_name` | Not explicitly documented in adjacent source annotations. |

#### 3. `show(player_id)`

- **Location:** source line 61.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 4. `hide(player_id)`

- **Location:** source line 96.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 63 | `(none)` | `ame) end local function show(player_id) -- Ensure dark font texture is provided pcal…` |
| 109 | `event` | `on handler --===================================================== Net:on("actor_int…` |
| 126 | `event` | `hide(player_id) else show(player_id) end end) Net:on("player_disconnect",` |

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `FONT_TESTS` — line 41

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ font = "THICK", label = "THICK", sample = "ABC abc 0123 !?.,:;()[]+-*/" }` |
| `[2]` | nested table | `{ font = "THICK_BLACK", label = "THICK_BLACK", sample = "ABC abc 0123 !?.,:;()[]+-*/" }` |
| `[3]` | nested table | `{ font = "BATTLE", label = "BATTLE", sample = "<PROG_EXE> ABC 0123 !?" }` |
| `[4]` | nested table | `{ font = "THIN", label = "THIN", sample = "ABC abc 0123 !?.,:;()[]+-*/" }` |
| `[5]` | nested table | `{ font = "TINY", label = "TINY", sample = "ABC abc 0123 !?.,:;()[]+-*/" }` |
| `[6]` | nested table | `{ font = "WIDE", label = "WIDE", sample = "ABC abc 0123 !?.,:;()[]+-*/" }` |
| `[7]` | nested table | `{ font = "GRADIENT", label = "GRADIENT", sample = "ABC abc 0123 !?.,:;()[]+-*/" }` |
| `[8]` | nested table | `{ font = "GRADIENT_BLACK", label = "GRADIENT_BLACK", sample = "ABC abc 0123 !?.,:;()[]+-*/" }` |

### 2. `active_texts` — line 55

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `ids` — line 72

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.create_bot` | 1 |
| `Net.get_object_by_name` | 1 |
| `Net.get_player_position` | 1 |
| `Net.on` | 2 |
| `Net.provide_asset_for_player` | 1 |
| `Net.set_bot_direction` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
