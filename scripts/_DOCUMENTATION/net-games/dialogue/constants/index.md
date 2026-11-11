# 📄 `constants.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/dialogue/constants.lua`](../../../../net-games/dialogue/constants.lua)  
> **Source lines:** 21  
> **SHA-256 (UTF-8):** `6c0ee9d1d4af17…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
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

Source-based reference for `scripts/net-games/dialogue/constants.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **4** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `C` — line 3

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `C.AdvanceMode` — line 5

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `INPUT` | string literal | `"input"` |
| `[2]` | expression/reference | `-- BN style: wait for confirm TIMER = "timer"` |
| `[3]` | expression/reference | `-- legacy/auto: delay then advance` |

### 3. `C.PageAdvance` — line 10

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `WAIT_FOR_CONFIRM` | string literal | `"wait_for_confirm"` |
| `AUTO_ADVANCE` | string literal | `"auto_advance"` |
| `AUTO_ADVANCE_OR_CONFIRM` | string literal | `"auto_advance_or_confirm"` |

### 4. `C.InputMode` — line 16

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `DIALOGUE_OWNS_INPUT` | string literal | `"dialogue_owns_input"` |
| `OVERLAY_ONLY` | string literal | `"overlay_only"` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
