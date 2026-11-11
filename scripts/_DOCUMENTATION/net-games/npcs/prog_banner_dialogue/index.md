# 📄 `prog_banner_dialogue.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_banner_dialogue.lua`](../../../../net-games/npcs/prog_banner_dialogue.lua)  
> **Source lines:** 164  
> **SHA-256 (UTF-8):** `130ce6dcb12cb2…`  
> **Declared/assigned functions detected:** 5  
> **Anonymous closures detected:** 3  
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

Tiled-spawned NPC that triggers net-games Marquee

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 6 | `scripts/libs/direction` |
| 7 | `scripts/displayer/displayer` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 94 | `Net:on` | `tick` |
| 109 | `Net:on` | `actor_interaction` |
| 161 | `Net:on` | `player_disconnect` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 10 | `dbg` | `msg` | local |
| 20 | `ensure_backdrop_sprite` | `player_id` | local |
| 28 | `draw_backdrop` | `player_id, backdrop, z` | local |
| 57 | `erase_backdrop` | `player_id` | local |
| 91 | `ensure_tick` | `(none)` | local |

### Function details

#### 1. `dbg(msg)`

- **Location:** source line 10.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `msg` | Not explicitly documented in adjacent source annotations. |

#### 2. `ensure_backdrop_sprite(player_id)`

- **Location:** source line 20.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 3. `draw_backdrop(player_id, backdrop, z)`

- **Location:** source line 28.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `backdrop` | Not explicitly documented in adjacent source annotations. |
| 3 | `z` | Not explicitly documented in adjacent source annotations. |

#### 4. `erase_backdrop(player_id)`

- **Location:** source line 57.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 5. `ensure_tick()`

- **Location:** source line 91.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 94 | `(none)` | `ensure_tick() if TICK_ATTACHED then return end TICK_ATTACHED = true Net:on("tick",` |
| 109 | `event` | `on handler --===================================================== Net:on("actor_int…` |
| 161 | `event` | `)", text_y, options ) ensure_tick() end) Net:on("player_disconnect",` |

## 📦 Tables and data

The following **4** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `player_backdrop_sprite` — line 18

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `marquee_active` — line 87

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `backdrop` — line 124

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | numeric literal | `0` |
| `y` | numeric literal | `0` |
| `width` | numeric literal | `240` |
| `height` | numeric literal | `30` |
| `padding_x` | numeric literal | `6` |
| `padding_y` | numeric literal | `0` |
| `loops` | string literal | `"once"` |
| `keep_backdrop` | boolean literal | `false` |

### 4. `options` — line 142

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | string literal | `"THICK"` |
| `scale` | numeric literal | `2.0` |
| `z` | numeric literal | `100` |
| `speed` | numeric literal | `60` |
| `loops` | numeric literal | `1` |
| `[6]` | expression/reference | `-- once` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.create_bot` | 1 |
| `Net.get_object_by_name` | 1 |
| `Net.get_player_position` | 1 |
| `Net.on` | 3 |
| `Net.player_alloc_sprite` | 1 |
| `Net.player_draw_sprite` | 1 |
| `Net.player_erase_sprite` | 1 |
| `Net.provide_asset_for_player` | 1 |
| `Net.set_bot_direction` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
