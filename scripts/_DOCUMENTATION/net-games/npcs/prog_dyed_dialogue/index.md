# 📄 `prog_dyed_dialogue.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_dyed_dialogue.lua`](../../../../net-games/npcs/prog_dyed_dialogue.lua)  
> **Source lines:** 18  
> **SHA-256 (UTF-8):** `274d860d390269…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
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

Source-based reference for `scripts/net-games/npcs/prog_dyed_dialogue.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/net-games/npcs/talk` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `lines` — line 11

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Hey!{p_0.5} Look at that!"` |
| `[2]` | string literal | `"Dyed frames!"` |
| `[3]` | string literal | `"What a neat trick..."` |

### 2. `ui` — line 16

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `nameplate` | nested table | `{ debug = false }` |

### 3. `nameplate` — line 16

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `debug` | boolean literal | `false` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
