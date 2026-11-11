# 📄 `state.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/footbomb/state.lua`](../../../../ezlibs-custom/footbomb/state.lua)  
> **Source lines:** 27  
> **SHA-256 (UTF-8):** `c2fbdef6e96a61…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
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

FootBomb state store. Mutable match/NPC/player registries live here instead of in the entry point. Keep this module data-only so main.lua remains responsible for game behavior.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **7** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `State` — line 4

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `-- area_id -> actor_id -> NPC reference npc_refs = {}` |
| `[2]` | expression/reference | `-- player_id -> true while an NPC/match interaction is being handled pending_interactions = {}` |
| `[3]` | expression/reference | `-- source area -> waiting VS Player match waiting_matches = {}` |
| `[4]` | expression/reference | `-- player_id -> bot/cursor/camera/input representation player_representations = {}` |
| `[5]` | expression/reference | `-- instance_id -> bot slot records instance_bots = {}` |
| `[6]` | expression/reference | `-- instance_id -> named Player 1/2 spawn positions instance_spawn_points = {}` |
| `[7]` | expression/reference | `-- Rotating deterministic NPC direction choice index npc_direction_sequence_index = 0` |

### 2. `npc_refs` — line 6

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `pending_interactions` — line 9

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `waiting_matches` — line 12

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `player_representations` — line 15

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `instance_bots` — line 18

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `instance_spawn_points` — line 21

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
