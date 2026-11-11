# 📄 `event_emitter.lua`

> ⚠️ **Archive-only reference:** The source file `scripts/tests/event_emitter.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `scripts/tests/event_emitter.lua` (not present in the current server ZIP).  
> **Source lines:** 103  
> **SHA-256 (UTF-8):** `5a30030735182d…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 4  
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

functions tested: Net.EventEmitter.new :on :once :on_any

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
| 40 | `num, word` | `1] = params end end -- the test -- once also tests :remove_listener emitter:once("a",` |
| 50 | `name, num, word` | `match") end end) -- on_any_once also tests :remove_on_any_listener emitter:on_any_on…` |
| 59 | `(none)` | `then error("event data does not match") end end) Async.promisify(coroutine.create(` |
| 89 | `(none)` | `) end i = i + 1 end -- testing helpful error local success, err = pcall(` |

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `emitted_events` — line 19

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{"b", 2, '?'}` |
| `[2]` | nested table | `{"a", 1, '?'}` |
| `[3]` | nested table | `{"a", 3, '?'}` |
| `[4]` | nested table | `{"c", 5, '?'}` |
| `[5]` | nested table | `{"a", 4, '?'}` |
| `[6]` | nested table | `{"d", 6, '?'}` |
| `[7]` | nested table | `{"a", 7, '?'}` |
| `[8]` | nested table | `{"e", 8, '?'}` |

### 2. `a_events` — line 30

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.await` | 2 |
| `Async.promisify` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
