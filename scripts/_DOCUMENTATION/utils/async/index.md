# 📄 `async.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/utils/async.lua`](../../../utils/async.lua)  
> **Source lines:** 302  
> **SHA-256 (UTF-8):** `1c4e5b893cf39d…`  
> **Declared/assigned functions detected:** 15  
> **Anonymous closures detected:** 6  
> **Table initializers detected:** 10

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

Async/await and Promise utilities for Lua 5.2. Supports both coroutine functions and already-created coroutine threads. Async.await() may yield either a Promise or a continuation function. The latter is the protocol used by EventEmitter:async_iter() and by pending Promise waits.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 17 | `pack` | `...` | local |
| 24 | `unpack_values` | `values, first, last` | local |
| 28 | `is_promise` | `value` | local |
| 37 | `Async.create_promise` | `executor` | declared |
| 50 | `resolve` | `...` | local |
| 69 | `reject` | `reason` | local |
| 88 | `promise:and_then` | `on_fulfilled, on_rejected` | declared |
| 125 | `Async.promisify` | `coroutine_or_function` | declared |
| 146 | `fail` | `reason` | local |
| 155 | `step` | `...` | assigned |
| 214 | `resume_wait` | `...` | local |
| 222 | `reject_wait` | `reason` | local |
| 246 | `Async.await` | `promise_or_iterator` | declared |
| 278 | `Async.run` | `main_function` | declared |
| 287 | `Async.create_validator` | `expected_values, error_message` | declared |

### Function details

#### 1. `pack(...)`

- **Location:** source line 17.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 2. `unpack_values(values, first, last)`

- **Location:** source line 24.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |
| 2 | `first` | Not explicitly documented in adjacent source annotations. |
| 3 | `last` | Not explicitly documented in adjacent source annotations. |

#### 3. `is_promise(value)`

- **Location:** source line 28.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 4. `Async.create_promise(executor)`

- **Location:** source line 37.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create a Promise.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `executor` | Not explicitly documented in adjacent source annotations. |

#### 5. `resolve(...)`

- **Location:** source line 50.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 6. `reject(reason)`

- **Location:** source line 69.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `reason` | Not explicitly documented in adjacent source annotations. |

#### 7. `promise:and_then(on_fulfilled, on_rejected)`

- **Location:** source line 88.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Retain the existing project's and_then contract: callbacks are invoked with the resolved values, and and_then returns this same Promise.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `on_fulfilled` | Not explicitly documented in adjacent source annotations. |
| 2 | `on_rejected` | Not explicitly documented in adjacent source annotations. |

#### 8. `Async.promisify(coroutine_or_function)`

- **Location:** source line 125.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Convert a coroutine function or an existing coroutine thread to a Promise.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `coroutine_or_function` | Not explicitly documented in adjacent source annotations. |

#### 9. `fail(reason)`

- **Location:** source line 146.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `reason` | Not explicitly documented in adjacent source annotations. |

#### 10. `step(...)`

- **Location:** source line 155.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 11. `resume_wait(...)`

- **Location:** source line 214.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 12. `reject_wait(reason)`

- **Location:** source line 222.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `reason` | Not explicitly documented in adjacent source annotations. |

#### 13. `Async.await(promise_or_iterator)`

- **Location:** source line 246.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Await a Promise or an EventEmitter async iterator inside a coroutine.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `promise_or_iterator` | Not explicitly documented in adjacent source annotations. |

#### 14. `Async.run(main_function)`

- **Location:** source line 278.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Run a coroutine function and return its Promise.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `main_function` | Not explicitly documented in adjacent source annotations. |

#### 15. `Async.create_validator(expected_values, error_message)`

- **Location:** source line 287.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create a function that validates positional arguments.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `expected_values` | Not explicitly documented in adjacent source annotations. |
| 2 | `error_message` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 139 | `resolve, reject` | `romisify expected a function or coroutine thread", 2) end return Async.create_promis…` |
| 182 | `(none)` | `ocal this_wait = wait_id waiting = true local ok, err = pcall(` |
| 184 | `...` | `local ok, err = pcall(function() yielded:and_then(` |
| 191 | `reason` | `lse step(...) end,` |
| 272 | `resolve, reject` | `.REJECTED then error(promise_or_iterator.error, 2) end return coroutine.yield(` |
| 292 | `...` | `error("Async.create_validator expected expected_values to be a table", 2) end return` |

## 📦 Tables and data

The following **10** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Async` — line 9

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `PROMISE_STATE` — line 11

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `PENDING` | string literal | `"pending"` |
| `FULFILLED` | string literal | `"fulfilled"` |
| `REJECTED` | string literal | `"rejected"` |

### 3. `return` — line 18

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `n` | expression/reference | `select("#", ...)` |
| `[2]` | expression/reference | `...` |

### 4. `promise` — line 42

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `state` | expression/reference | `PROMISE_STATE.PENDING` |
| `value` | nil | `nil` |
| `error` | nil | `nil` |
| `on_fulfilled` | nested table | `{}` |
| `on_rejected` | nested table | `{}` |

### 5. `on_fulfilled` — line 46

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `on_rejected` — line 47

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `promise.on_fulfilled` — line 61

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `promise.on_rejected` — line 62

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `promise.on_fulfilled` — line 78

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `promise.on_rejected` — line 79

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.await` | 1 |
| `Async.create_promise` | 2 |
| `Async.create_validator` | 1 |
| `Async.promisify` | 2 |
| `Async.run` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
