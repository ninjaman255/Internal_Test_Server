# 📄 `template_bigbrute.lua`

[🏠 Documentation home](../../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/template_bigbrute.lua`](../../../../../../ezlibs-custom/nebulous-liberations/liberations/enemies/template_bigbrute.lua)  
> **Source lines:** 19  
> **SHA-256 (UTF-8):** `876c2114c36566…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 1  
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

Registered overworld template. Legacy constructor module remains for compatibility.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 2 | `EnemyTemplates` | `-- Registered overworld template. Legacy constructor module remains for compatibilit…` |

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `shape` — line 9

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{1,1,1}` |
| `[2]` | nested table | `{1,0,1}` |
| `[3]` | nested table | `{1,1,1}` |

### 2. `preload_assets` — line 17

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/npcs/bigbrute.animation"` |
| `[2]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/beast breath.png"` |
| `[3]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/beast breath.animation"` |
| `[4]` | string literal | `"/server/assets/ezlibs-custom/nebulous-liberations/bots/npcs/bigbrute.png"` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
