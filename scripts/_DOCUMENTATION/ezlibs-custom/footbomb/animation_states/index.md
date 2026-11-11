# 📄 `animation_states.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/footbomb/animation_states.lua`](../../../../ezlibs-custom/footbomb/animation_states.lua)  
> **Source lines:** 19  
> **SHA-256 (UTF-8):** `656e5e39d071de…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
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

Animation states shared by FootBomb's Navi assets. These names are intentionally centralized: update the roster animation files and this list together when the game adds or renames a state.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **1** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `return` — line 4

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `IDLE_D` | string literal | `"IDLE_D"` |
| `IDLE_UR` | string literal | `"IDLE_UR"` |
| `IDLE_U` | string literal | `"IDLE_U"` |
| `WALK_U` | string literal | `"WALK_U"` |
| `WALK_UR` | string literal | `"WALK_UR"` |
| `FOOTBOMB_IDLE_DEFENSE` | string literal | `"FOOTBOMB_IDLE_DEFENSE"` |
| `FOOTBOMB_READY_DEFENSE` | string literal | `"FOOTBOMB_READY_DEFENSE"` |
| `FOOTBOMB_JUMP_RIGHT` | string literal | `"FOOTBOMB_JUMP_RIGHT"` |
| `FOOTBOMB_JUMP_RIGHT_END` | string literal | `"FOOTBOMB_JUMP_RIGHT_END"` |
| `FOOTBOMB_JUMP_LEFT` | string literal | `"FOOTBOMB_JUMP_LEFT"` |
| `FOOTBOMB_JUMP_LEFT_END` | string literal | `"FOOTBOMB_JUMP_LEFT_END"` |
| `BOMB_PREVIEW` | string literal | `"Preview"` |
| `SMALL_BOMB` | string literal | `"Small-Bomb"` |
| `BIG_BOMB` | string literal | `"Big-Bomb"` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
