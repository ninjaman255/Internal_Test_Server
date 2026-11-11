# 📄 `ezemitter.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezemitter.lua`](../../../ezlibs-scripts/ezemitter.lua)  
> **Source lines:** 337  
> **SHA-256 (UTF-8):** `21cd7063ac0071…`  
> **Declared/assigned functions detected:** 24  
> **Anonymous closures detected:** 3  
> **Table initializers detected:** 21

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

A flexible event system with async capabilities. Design notes: * emit() snapshots callback lists before iterating, so listeners may safely add/remove other listeners during a call. * once-listeners are cleared BEFORE invocation, so a re-emitted event

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 18 | `EventEmitter.new` | `(none)` | declared |
| 34 | `EventEmitter:set_error_handler` | `fn` | declared |
| 40 | `EventEmitter:_call` | `callback, ...` | declared |
| 56 | `EventEmitter:on` | `event, callback` | declared |
| 64 | `EventEmitter:once` | `event, callback` | declared |
| 72 | `EventEmitter:on_any` | `callback` | declared |
| 79 | `EventEmitter:on_any_once` | `callback` | declared |
| 86 | `snapshot` | `list` | local |
| 93 | `EventEmitter:emit` | `event, ...` | declared |
| 128 | `EventEmitter:remove_listener` | `event, callback` | declared |
| 132 | `prune` | `list` | local |
| 150 | `EventEmitter:remove_on_any_listener` | `callback` | declared |
| 161 | `EventEmitter:remove_all_listeners` | `event` | declared |
| 176 | `EventEmitter:has_listeners` | `event` | declared |
| 187 | `EventEmitter:listener_count` | `event` | declared |
| 203 | `make_iterator_state` | `(none)` | local |
| 207 | `iterator_next` | `state` | local |
| 218 | `EventEmitter:async_iter` | `event` | declared |
| 225 | `on_event` | `...` | local |
| 242 | `close_fn` | `(none)` | local |
| 265 | `EventEmitter:async_iter_all` | `(none)` | declared |
| 271 | `on_any` | `event, ...` | local |
| 286 | `close_fn` | `(none)` | local |
| 306 | `EventEmitter:destroy` | `(none)` | declared |

### Function details

#### 1. `EventEmitter.new()`

- **Location:** source line 18.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create a new EventEmitter instance

#### 2. `EventEmitter:set_error_handler(fn)`

- **Location:** source line 34.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Install (or clear) an error handler for callbacks. When set, each listener is pcall'd and any failure is forwarded to `fn(err, ...)`; the emit loop continues. When nil (default), errors propagate synchronously.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `fn` | Not explicitly documented in adjacent source annotations. |

#### 3. `EventEmitter:_call(callback, ...)`

- **Location:** source line 40.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Internal: dispatch a callback, honoring the current error mode.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `callback` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 4. `EventEmitter:on(event, callback)`

- **Location:** source line 56.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Register a listener for a specific event
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 5. `EventEmitter:once(event, callback)`

- **Location:** source line 64.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Register a one-time listener for a specific event
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 6. `EventEmitter:on_any(callback)`

- **Location:** source line 72.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Register a listener for any event
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 7. `EventEmitter:on_any_once(callback)`

- **Location:** source line 79.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Register a one-time listener for any event
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 8. `snapshot(list)`

- **Location:** source line 86.
- **Declaration style:** `local`.
- **Adjacent source comment:** Copy a list so listeners mutating it during emit can't corrupt the loop.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `list` | Not explicitly documented in adjacent source annotations. |

#### 9. `EventEmitter:emit(event, ...)`

- **Location:** source line 93.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Emit an event
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 10. `EventEmitter:remove_listener(event, callback)`

- **Location:** source line 128.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Remove a specific listener (from both `on` and `once`). Removes every occurrence. Returns (self, removed_any).
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 11. `prune(list)`

- **Location:** source line 132.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `list` | Not explicitly documented in adjacent source annotations. |

#### 12. `EventEmitter:remove_on_any_listener(callback)`

- **Location:** source line 150.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Remove a specific on_any listener
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 13. `EventEmitter:remove_all_listeners(event)`

- **Location:** source line 161.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Remove every listener for one event (or everything when `event` is nil).
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |

#### 14. `EventEmitter:has_listeners(event)`

- **Location:** source line 176.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Introspection
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |

#### 15. `EventEmitter:listener_count(event)`

- **Location:** source line 187.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |

#### 16. `make_iterator_state()`

- **Location:** source line 203.
- **Declaration style:** `local`.
- **Adjacent source comment:** Build the shared (queue + waiter) machinery used by both iterator variants.

#### 17. `iterator_next(state)`

- **Location:** source line 207.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `state` | Not explicitly documented in adjacent source annotations. |

#### 18. `EventEmitter:async_iter(event)`

- **Location:** source line 218.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create an async iterator for a specific event. Returns (next_fn, close_fn). close_fn unregisters the underlying listener and wakes any pending waiter with nil.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |

#### 19. `on_event(...)`

- **Location:** source line 225.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 20. `close_fn()`

- **Location:** source line 242.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 21. `EventEmitter:async_iter_all()`

- **Location:** source line 265.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create an async iterator for all events. Returns (next_fn, close_fn) just like async_iter.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 22. `on_any(event, ...)`

- **Location:** source line 271.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 23. `close_fn()`

- **Location:** source line 286.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 24. `EventEmitter:destroy()`

- **Location:** source line 306.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Clean up all resources
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 212 | `resolve` | `te.queue > 0 then return table.unpack(table.remove(state.queue, 1)) end return` |
| 260 | `(none)` | `.waiting state.waiting = nil wait(nil) end end return` |
| 302 | `(none)` | `.waiting state.waiting = nil wait(nil) end end return` |

## 📦 Tables and data

The following **21** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `EventEmitter` — line 14

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `self._events` — line 20

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `self._once_events` — line 21

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `self._any_events` — line 22

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `self._any_once_events` — line 23

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `self._iterators` — line 25

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `self._any_iterators` — line 26

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `s` — line 87

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `self._any_once_events` — line 118

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `self._events` — line 164

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `self._once_events` — line 165

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `self._any_events` — line 166

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `self._any_once_events` — line 167

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 14. `return` — line 204

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `queue` | nested table | `{}` |
| `waiting` | nil | `nil` |
| `closed` | boolean literal | `false` |

### 15. `queue` — line 204

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 16. `self._events` — line 309

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 17. `self._once_events` — line 310

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 18. `self._any_events` — line 311

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 19. `self._any_once_events` — line 312

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 20. `self._iterators` — line 333

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 21. `self._any_iterators` — line 334

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
