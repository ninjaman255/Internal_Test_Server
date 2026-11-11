# 📄 `event-emitter.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/utils/event-emitter.lua`](../../../utils/event-emitter.lua)  
> **Source lines:** 303  
> **SHA-256 (UTF-8):** `32498fe60e97da…`  
> **Declared/assigned functions detected:** 14  
> **Anonymous closures detected:** 4  
> **Table initializers detected:** 18

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

A flexible event system with async capabilities

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 8 | `EventEmitter.new` | `(none)` | declared |
| 21 | `EventEmitter:on` | `event, callback` | declared |
| 32 | `EventEmitter:once` | `event, callback` | declared |
| 43 | `EventEmitter:on_any` | `callback` | declared |
| 51 | `EventEmitter:on_any_once` | `callback` | declared |
| 59 | `EventEmitter:emit` | `event, ...` | declared |
| 95 | `EventEmitter:remove_listener` | `event, callback` | declared |
| 113 | `EventEmitter:remove_on_any_listener` | `callback` | declared |
| 127 | `EventEmitter:async_iter` | `event` | declared |
| 137 | `on_event` | `...` | local |
| 169 | `EventEmitter:async_iter_all` | `(none)` | declared |
| 178 | `on_any` | `event, ...` | local |
| 209 | `EventEmitter:_notify_iterators` | `event, ...` | declared |
| 233 | `EventEmitter:destroy` | `(none)` | declared |

### Function details

#### 1. `EventEmitter.new()`

- **Location:** source line 8.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create a new EventEmitter instance

#### 2. `EventEmitter:on(event, callback)`

- **Location:** source line 21.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Register a listener for a specific event
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 3. `EventEmitter:once(event, callback)`

- **Location:** source line 32.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Register a one-time listener for a specific event
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 4. `EventEmitter:on_any(callback)`

- **Location:** source line 43.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Register a listener for any event
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 5. `EventEmitter:on_any_once(callback)`

- **Location:** source line 51.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Register a one-time listener for any event
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 6. `EventEmitter:emit(event, ...)`

- **Location:** source line 59.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Emit an event
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 7. `EventEmitter:remove_listener(event, callback)`

- **Location:** source line 95.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Remove a specific listener
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 8. `EventEmitter:remove_on_any_listener(callback)`

- **Location:** source line 113.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Remove a specific on_any listener
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 9. `EventEmitter:async_iter(event)`

- **Location:** source line 127.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create an async iterator for a specific event
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |

#### 10. `on_event(...)`

- **Location:** source line 137.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 11. `EventEmitter:async_iter_all()`

- **Location:** source line 169.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create an async iterator for all events
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 12. `on_any(event, ...)`

- **Location:** source line 178.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 13. `EventEmitter:_notify_iterators(event, ...)`

- **Location:** source line 209.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Notify all iterators of an event
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 14. `EventEmitter:destroy()`

- **Location:** source line 233.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Clean up all resources
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 155 | `(none)` | `ors[event] = {} end table.insert(self._iterators[event], iterator) return` |
| 161 | `resolve` | `return table.unpack(table.remove(iterator.queue, 1)) else return` |
| 194 | `(none)` | `tor.listener = on_any table.insert(self._any_iterators, iterator) return` |
| 201 | `resolve` | `ve(iterator.queue, 1) return table.unpack(data) else return` |

## 📦 Tables and data

The following **18** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `EventEmitter` — line 4

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `self._events` — line 10

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `self._once_events` — line 11

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `self._any_events` — line 12

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `self._any_once_events` — line 13

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `self._iterators` — line 15

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `self._any_iterators` — line 16

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `self._any_once_events` — line 86

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `iterator` — line 130

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `event` | expression/reference | `event` |
| `queue` | nested table | `{}` |
| `waiting` | nil | `nil` |
| `closed` | boolean literal | `false` |

### 10. `queue` — line 132

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `iterator` — line 172

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `queue` | nested table | `{}` |
| `waiting` | nil | `nil` |
| `closed` | boolean literal | `false` |

### 12. `queue` — line 173

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `self._events` — line 237

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 14. `self._once_events` — line 238

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 15. `self._any_events` — line 239

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 16. `self._any_once_events` — line 240

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 17. `self._iterators` — line 261

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 18. `self._any_iterators` — line 262

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
