# 📄 `navi_options.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/footbomb/navi_options.lua`](../../../../ezlibs-custom/footbomb/navi_options.lua)  
> **Source lines:** 15  
> **SHA-256 (UTF-8):** `9411ad10a53975…`  
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

Selectable Navi roster. Each entry references shared paths and state names.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 2 | `scripts/ezlibs-custom/footbomb/constants` |
| 3 | `scripts/ezlibs-custom/footbomb/animation_states` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **1** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `return` — line 6

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ name = "MegaMan", texture = root .. "megaman.png", animation = root .. "megaman.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE }` |
| `[2]` | nested table | `{ name = "Roll", texture = root .. "roll.png", animation = root .. "roll.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE }` |
| `[3]` | nested table | `{ name = "Normal Navi", texture = root .. "normal-navi-green.png", animation = root .. "normal-navi-green.animation", animation_state = States.FOOTBOMB_ID…` |
| `[4]` | nested table | `{ name = "ProtoMan", texture = root .. "protoman.png", animation = root .. "protoman.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE }` |
| `[5]` | nested table | `{ name = "Glyde", texture = root .. "glyde.png", animation = root .. "glyde.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE }` |
| `[6]` | nested table | `{ name = "GutsMan", texture = root .. "gutsman.png", animation = root .. "gutsman.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE }` |
| `[7]` | nested table | `{ name = "Prog", texture = root .. "prog.png", animation = root .. "prog.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE }` |
| `[8]` | nested table | `{ name = "GridMan", texture = root .. "gridman.png", animation = root .. "gridman.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE }` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
