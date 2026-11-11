# 📄 `buttons.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/input-controller/buttons.lua`](../../../input-controller/buttons.lua)  
> **Source lines:** 12  
> **SHA-256 (UTF-8):** `d2df61d2c2d669…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 9

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

Source-based reference for `scripts/input-controller/buttons.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **9** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Buttons` — line 1

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `ShoulderL` | nested table | `{"Shoulder L"}` |
| `ShoulderR` | nested table | `{"Shoulder R"}` |
| `Start` | nested table | `{"Pause"}` |
| `Minimap` | nested table | `{"Minimap"}` |
| `Confirm` | nested table | `{ "Confirm", "A", "Interact", "Use Card"}` |
| `Cancel` | nested table | `{ "Cancel", "Shoot", "Run" }` |
| `Options` | nested table | `{"Option", "Special"}` |
| `CustomMenu` | nested table | `{"Cust"}` |

### 2. `ShoulderL` — line 2

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Shoulder L"` |

### 3. `ShoulderR` — line 3

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Shoulder R"` |

### 4. `Start` — line 4

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Pause"` |

### 5. `Minimap` — line 5

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Minimap"` |

### 6. `Confirm` — line 6

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Confirm"` |
| `[2]` | string literal | `"A"` |
| `[3]` | string literal | `"Interact"` |
| `[4]` | string literal | `"Use Card"` |

### 7. `Cancel` — line 7

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Cancel"` |
| `[2]` | string literal | `"Shoot"` |
| `[3]` | string literal | `"Run"` |

### 8. `Options` — line 8

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Option"` |
| `[2]` | string literal | `"Special"` |

### 9. `CustomMenu` — line 9

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Cust"` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
