# 📄 `menu_options.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/npcs/menu_options.lua`](../../../../net-games/npcs/menu_options.lua)  
> **Source lines:** 52  
> **SHA-256 (UTF-8):** `2def12bf1934fe…`  
> **Declared/assigned functions detected:** 3  
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

Purpose: Build PromptVertical option tables without loops/math in each NPC file.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 6 | `pad2` | `n` | local |
| 14 | `M.count` | `count, cfg` | declared |
| 38 | `M.list` | `items, cfg` | declared |

### Function details

#### 1. `pad2(n)`

- **Location:** source line 6.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `n` | Not explicitly documented in adjacent source annotations. |

#### 2. `M.count(count, cfg)`

- **Location:** source line 14.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Build numbered options from a count. Example: MenuOptions.count(40, { prefix="Lime Option ", pad=2, start=1, exit_text="Exit" })

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `count` | Not explicitly documented in adjacent source annotations. |
| 2 | `cfg` | Not explicitly documented in adjacent source annotations. |

#### 3. `M.list(items, cfg)`

- **Location:** source line 38.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Build from a list of strings. IDs become 1..N by default. Example: MenuOptions.list({ "Potion", "Antidote" }, { exit_text="Exit" })

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `items` | Not explicitly documented in adjacent source annotations. |
| 2 | `cfg` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `M` — line 4

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `t` — line 23

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `t` — line 43

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
