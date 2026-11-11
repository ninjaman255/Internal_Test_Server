# 📄 `test_utilities.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/tests/test_utilities.lua`](../../../../ezlibs-scripts/tests/test_utilities.lua)  
> **Source lines:** 77  
> **SHA-256 (UTF-8):** `19c182d1e04b2f…`  
> **Declared/assigned functions detected:** 2  
> **Anonymous closures detected:** 5  
> **Table initializers detected:** 5

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

Run from the package root with: lua tests/test_utilities.lua

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 6 | `ezutil` |
| 7 | `ezvalidate` |
| 8 | `ezdebug` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 10 | `test` | `name, callback` | local |
| 64 | `sink` | `message` | assigned |

### Function details

#### 1. `test(name, callback)`

- **Location:** source line 10.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `name` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 2. `sink(message)`

- **Location:** source line 64.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 19 | `(none)` | `.. "\n") os.exit(1) end io.write("PASS: " .. name .. "\n") end test("clamp",` |
| 25 | `(none)` | `2, 1, 4) == 1) assert(ezutil.clamp(3, 1, 4) == 3) end) test("table_contains and remo…` |
| 33 | `(none)` | `le_remove_value(values, "b", true) == 2) assert(#values == 2) end) test("copy and me…` |
| 44 | `(none)` | `e(target, {a = 2, b = 3}) assert(target.a == 2 and target.b == 3) end) test("validat…` |
| 59 | `(none)` | `id = "number", name = "string" })) end) test("debug sink and disabled mode",` |

## 📦 Tables and data

The following **5** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `values` — line 26

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"a"` |
| `[2]` | string literal | `"b"` |
| `[3]` | string literal | `"b"` |
| `[4]` | string literal | `"c"` |

### 2. `source` — line 34

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `nested` | nested table | `{value = 7}` |
| `a` | numeric literal | `1` |

### 3. `nested` — line 34

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `value` | numeric literal | `7` |

### 4. `target` — line 39

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `a` | numeric literal | `1` |

### 5. `messages` — line 60

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
