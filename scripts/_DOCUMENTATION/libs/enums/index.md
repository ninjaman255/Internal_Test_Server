# 📄 `enums.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/libs/enums.lua`](../../../libs/enums.lua)  
> **Source lines:** 85  
> **SHA-256 (UTF-8):** `201cde86c4cc96…`  
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

Source-based reference for `scripts/libs/enums.lua`. No module-purpose prose was supplied in the leading source comments.

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

### 1. `ColorMode` — line 1

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `MULT` | numeric literal | `0` |
| `[2]` | expression/reference | `-- Multiply (default) ADD = 1` |
| `[3]` | expression/reference | `-- Addititve COLOR = 2` |
| `[4]` | expression/reference | `-- Colorize` |

### 2. `BattleItem` — line 7

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `MONEY` | numeric literal | `0` |
| `CARD` | numeric literal | `1` |
| `HEALTH` | numeric literal | `2` |
| `FRAGMENT` | numeric literal | `3` |

### 3. `InputState` — line 15

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `NONE` | numeric literal | `0` |
| `PRESSED` | numeric literal | `1` |
| `HELD` | numeric literal | `2` |
| `RELEASED` | numeric literal | `3` |

### 4. `InputEvent` — line 22

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `--- --- OW Events --- RUN = "Run"` |
| `INTERACT` | string literal | `"Interact"` |
| `MINIMAP` | string literal | `"Minimap"` |
| `[4]` | expression/reference | `--- --- Battle Events --- SHOOT = "Shoot"` |
| `USE_CARD` | string literal | `"Use Card"` |
| `SPECIAL` | string literal | `"Special"` |
| `CUST_MENU` | string literal | `"Cust Menu"` |
| `PAUSE` | string literal | `"Pause"` |
| `[9]` | expression/reference | `--- --- Shared Battle & OW Events --- MOVE_UP = "Move Up"` |
| `MOVE_DOWN` | string literal | `"Move Down"` |
| `MOVE_LEFT` | string literal | `"Move Left"` |
| `MOVE_RIGHT` | string literal | `"Move Right"` |
| `SHOULDER_L` | string literal | `"Shoulder L"` |
| `SHOULDER_R` | string literal | `"Shoulder R"` |
| `[15]` | expression/reference | `--- --- UI Events --- UI_UP = "UI Up"` |
| `UI_DOWN` | string literal | `"UI Down"` |
| `UI_LEFT` | string literal | `"UI Left"` |
| `UI_RIGHT` | string literal | `"UI Right"` |
| `CONFIRM` | string literal | `"Confirm"` |
| `CANCEL` | string literal | `"Cancel"` |
| `OPTION` | string literal | `"Option"` |
| `[22]` | expression/reference | `--- --- META --- LEN = 21` |

### 5. `AssetType` — line 62

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `TEXT` | numeric literal | `0` |
| `TEXTURE` | numeric literal | `1` |
| `AUDIO` | numeric literal | `2` |
| `DATA` | numeric literal | `3` |

### 6. `PackageType` — line 69

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `BLOCKS` | numeric literal | `0` |
| `CARD` | numeric literal | `1` |
| `ENCOUNTER` | numeric literal | `2` |
| `CHARACTER` | numeric literal | `3` |
| `LIBRARY` | numeric literal | `4` |
| `PLAYER` | numeric literal | `5` |

### 7. `return` — line 78

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `ColorMode` | expression/reference | `ColorMode` |
| `BattleItem` | expression/reference | `BattleItem` |
| `InputState` | expression/reference | `InputState` |
| `InputEvent` | expression/reference | `InputEvent` |
| `AssetType` | expression/reference | `AssetType` |
| `PackageType` | expression/reference | `PackageType` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
