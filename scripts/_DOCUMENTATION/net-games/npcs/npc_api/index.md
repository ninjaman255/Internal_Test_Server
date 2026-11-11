# 📄 `npc_api.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/npc_api.lua`](../../../../net-games/npcs/npc_api.lua)  
> **Source lines:** 56  
> **SHA-256 (UTF-8):** `291547111eb419…`  
> **Declared/assigned functions detected:** 3  
> **Anonymous closures detected:** 3  
> **Table initializers detected:** 1

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

Purpose: Remove NPC boilerplate (interaction wiring, busy guards, face-player, SFX helper). This does NOT contain dialogue/menu content defaults.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 5 | `scripts/libs/direction` |
| 6 | `scripts/net-games/dialogue/startup` |
| 8 | `scripts/net-games/dialogue/dialogue` |
| 9 | `scripts/net-games/npcs/talk_vert_menu` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 38 | `Net:on` | `actor_interaction` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 13 | `M.play_sfx` | `player_id, path` | declared |
| 24 | `M.face_player` | `bot_id, bot_pos, player_id` | declared |
| 34 | `M.bind_confirm_interaction` | `bot_id, bot_pos, handler, opts` | declared |

### Function details

#### 1. `M.play_sfx(player_id, path)`

- **Location:** source line 13.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `path` | Not explicitly documented in adjacent source annotations. |

#### 2. `M.face_player(bot_id, bot_pos, player_id)`

- **Location:** source line 24.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `bot_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `bot_pos` | Not explicitly documented in adjacent source annotations. |
| 3 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 3. `M.bind_confirm_interaction(bot_id, bot_pos, handler, opts)`

- **Location:** source line 34.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Standard interaction wrapper: filters to this bot + confirm button prevents overlap via TalkVertMenu busy + Dialogue active optionally faces player calls your handler(player_id)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `bot_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `bot_pos` | Not explicitly documented in adjacent source annotations. |
| 3 | `handler` | Not explicitly documented in adjacent source annotations. |
| 4 | `opts` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 18 | `(none)` | `Net.provide_asset_for_player(player_id, path) if Net.play_sound_for_player then pcal…` |
| 20 | `(none)` | `ction() Net.play_sound_for_player(player_id, path) end) elseif Net.play_sound then p…` |
| 38 | `event` | `, opts) opts = opts or {} local face = (opts.face ~= false) Net:on("actor_interactio…` |

## 📦 Tables and data

The following **1** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `M` — line 11

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.get_player_position` | 1 |
| `Net.on` | 1 |
| `Net.play_sound` | 1 |
| `Net.play_sound_for_player` | 1 |
| `Net.provide_asset_for_player` | 1 |
| `Net.set_bot_direction` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
