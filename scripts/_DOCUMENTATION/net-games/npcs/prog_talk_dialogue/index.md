# 📄 `prog_talk_dialogue.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/prog_talk_dialogue.lua`](../../../../net-games/npcs/prog_talk_dialogue.lua)  
> **Source lines:** 52  
> **SHA-256 (UTF-8):** `9ba5eebb43cb20…`  
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

Example: PROG-style prompt that branches into dialogue Uses NEW Talk.npc + presets + purple frame dye

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 7 | `scripts/net-games/main` |
| 9 | `scripts/net-games/npcs/talk` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `prompt` — line 34

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `question` | string literal | `"Want to see the purple UI prompt in action?"` |
| `yes_lines` | nested table | `{ "Nice.", "This is the YES branch.", "Typing speed + open timing should match the PROG defaults.", "{end_page}And it should reuse the same textbox (no fl…` |
| `no_lines` | nested table | `{ "All good.", "This is the NO branch.", "B should behave like BN prompt cancel: selects No, then confirms No.", }` |

### 2. `yes_lines` — line 37

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Nice."` |
| `[2]` | string literal | `"This is the YES branch."` |
| `[3]` | string literal | `"Typing speed + open timing should match the PROG defaults."` |
| `[4]` | string literal | `"{end_page}And it should reuse the same textbox (no flicker)."` |

### 3. `no_lines` — line 44

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"All good."` |
| `[2]` | string literal | `"This is the NO branch."` |
| `[3]` | string literal | `"B should behave like BN prompt cancel: selects No, then confirms No."` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
