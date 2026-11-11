# 📄 `constants.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/navi-emotes/constants.lua`](../../../../net-games/navi-emotes/constants.lua)  
> **Source lines:** 44  
> **SHA-256 (UTF-8):** `c8b6a2175cb1e2…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 11

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

Source-based reference for `scripts/net-games/navi-emotes/constants.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **11** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Constants` — line 1

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `emote_prefix` | string literal | `"EMOTE_"` |
| `emote_icon_prefix` | string literal | `"EMOTE_ICON_"` |
| `defaults` | nested table | `{ one = { icon = "EMOTE_ICON_1", emote = "EMOTE_1", }, two = { icon = "EMOTE_ICON_2", emote = "EMOTE_2", }, three = { icon = "EMOTE_ICON_3", emote = "EMOT…` |

### 2. `defaults` — line 4

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `one` | nested table | `{ icon = "EMOTE_ICON_1", emote = "EMOTE_1", }` |
| `two` | nested table | `{ icon = "EMOTE_ICON_2", emote = "EMOTE_2", }` |
| `three` | nested table | `{ icon = "EMOTE_ICON_3", emote = "EMOTE_3", }` |
| `four` | nested table | `{ icon = "EMOTE_ICON_4", emote = "EMOTE_4", }` |
| `five` | nested table | `{ icon = "EMOTE_ICON_5", emote = "EMOTE_5", }` |
| `six` | nested table | `{ icon = "EMOTE_ICON_6", emote = "EMOTE_6", }` |
| `seven` | nested table | `{ icon = "EMOTE_ICON_7", emote = "EMOTE_7", }` |
| `eight` | nested table | `{ icon = "EMOTE_ICON_8", emote = "EMOTE_8", }` |
| `nine` | nested table | `{ icon = "EMOTE_ICON_9", emote = "EMOTE_9", }` |

### 3. `one` — line 5

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `icon` | string literal | `"EMOTE_ICON_1"` |
| `emote` | string literal | `"EMOTE_1"` |

### 4. `two` — line 9

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `icon` | string literal | `"EMOTE_ICON_2"` |
| `emote` | string literal | `"EMOTE_2"` |

### 5. `three` — line 13

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `icon` | string literal | `"EMOTE_ICON_3"` |
| `emote` | string literal | `"EMOTE_3"` |

### 6. `four` — line 17

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `icon` | string literal | `"EMOTE_ICON_4"` |
| `emote` | string literal | `"EMOTE_4"` |

### 7. `five` — line 21

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `icon` | string literal | `"EMOTE_ICON_5"` |
| `emote` | string literal | `"EMOTE_5"` |

### 8. `six` — line 25

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `icon` | string literal | `"EMOTE_ICON_6"` |
| `emote` | string literal | `"EMOTE_6"` |

### 9. `seven` — line 29

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `icon` | string literal | `"EMOTE_ICON_7"` |
| `emote` | string literal | `"EMOTE_7"` |

### 10. `eight` — line 33

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `icon` | string literal | `"EMOTE_ICON_8"` |
| `emote` | string literal | `"EMOTE_8"` |

### 11. `nine` — line 37

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `icon` | string literal | `"EMOTE_ICON_9"` |
| `emote` | string literal | `"EMOTE_9"` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
