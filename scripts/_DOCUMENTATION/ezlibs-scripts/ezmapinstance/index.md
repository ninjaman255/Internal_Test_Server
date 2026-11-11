# 📄 `ezmapinstance.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezmapinstance.lua`](../../../ezlibs-scripts/ezmapinstance.lua)  
> **Source lines:** 532  
> **SHA-256 (UTF-8):** `c0d36c057aa2bd…`  
> **Declared/assigned functions detected:** 42  
> **Anonymous closures detected:** 1  
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

Reusable map cloning, instance ownership, host/party metadata, and lifecycle. This module intentionally does not register Net event handlers. Call its API from a plugin or game module that owns the instance's gameplay behavior. Event surfaces (backed by ezemitter): EzMapInstance.events -- global; every instance event, args begin with instance_id

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 62 | `error_handler` | `(none)` | assigned |
| 65 | `EzMapInstance.set_error_handler` | `handler` | declared |
| 69 | `safe_emit` | `emitter, ...` | local |
| 78 | `emit_event` | `record, event, ...` | local |
| 85 | `valid_id` | `value` | local |
| 89 | `copy_array` | `values` | local |
| 99 | `area_id_is_listed` | `area_id` | local |
| 118 | `find_available_id` | `preferred_id` | local |
| 131 | `forget_player` | `instance_id, player_id` | local |
| 141 | `record_mt:on` | `event, callback` | declared |
| 146 | `record_mt:once` | `event, callback` | declared |
| 151 | `record_mt:on_any` | `callback` | declared |
| 156 | `record_mt:on_any_once` | `callback` | declared |
| 161 | `record_mt:off` | `event, callback` | declared |
| 166 | `record_mt:off_any` | `callback` | declared |
| 172 | `record_mt:emit` | `event, ...` | declared |
| 180 | `record_mt:async_iter` | `event` | declared |
| 186 | `record_mt:async_iter_all` | `(none)` | declared |
| 195 | `EzMapInstance.on` | `event, callback` | declared |
| 200 | `EzMapInstance.once` | `event, callback` | declared |
| 205 | `EzMapInstance.on_any` | `callback` | declared |
| 210 | `EzMapInstance.on_any_once` | `callback` | declared |
| 215 | `EzMapInstance.off` | `event, callback` | declared |
| 220 | `EzMapInstance.off_any` | `callback` | declared |
| 226 | `EzMapInstance.emit` | `event, ...` | declared |
| 233 | `EzMapInstance.async_iter` | `event` | declared |
| 238 | `EzMapInstance.async_iter_all` | `(none)` | declared |
| 254 | `EzMapInstance.create` | `base_area_id, preferred_instance_id, options` | declared |
| 315 | `EzMapInstance.get` | `instance_id` | declared |
| 320 | `EzMapInstance.exists` | `instance_id` | declared |
| 326 | `EzMapInstance.is_valid` | `instance_id` | declared |
| 338 | `EzMapInstance.get_for_player` | `player_id` | declared |
| 347 | `EzMapInstance.list` | `(none)` | declared |
| 357 | `EzMapInstance.set_host` | `instance_id, player_id` | declared |
| 370 | `EzMapInstance.get_host` | `instance_id` | declared |
| 375 | `EzMapInstance.is_host` | `instance_id, player_id` | declared |
| 382 | `EzMapInstance.register_player` | `instance_id, player_id` | declared |
| 412 | `EzMapInstance.unregister_player` | `instance_id, player_id` | declared |
| 444 | `EzMapInstance.add_player` | `instance_id, player_id` | declared |
| 448 | `EzMapInstance.remove_player` | `instance_id, player_id` | declared |
| 456 | `EzMapInstance.transfer_player` | `instance_id, player_id, x, y, z, warp_in, direction` | declared |
| 491 | `EzMapInstance.remove` | `instance_id` | declared |

### Function details

#### 1. `error_handler()`

- **Location:** source line 62.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 2. `EzMapInstance.set_error_handler(handler)`

- **Location:** source line 65.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Route listener errors somewhere safe. Defaults to silent no-op.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `handler` | Not explicitly documented in adjacent source annotations. |

#### 3. `safe_emit(emitter, ...)`

- **Location:** source line 69.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `emitter` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 4. `emit_event(record, event, ...)`

- **Location:** source line 78.
- **Declaration style:** `local`.
- **Adjacent source comment:** Fire an event on both the per-instance and global emitters.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `record` | Not explicitly documented in adjacent source annotations. |
| 2 | `event` | Not explicitly documented in adjacent source annotations. |
| 3 | `...` | Not explicitly documented in adjacent source annotations. |

#### 5. `valid_id(value)`

- **Location:** source line 85.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 6. `copy_array(values)`

- **Location:** source line 89.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 7. `area_id_is_listed(area_id)`

- **Location:** source line 99.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `area_id` | Not explicitly documented in adjacent source annotations. |

#### 8. `find_available_id(preferred_id)`

- **Location:** source line 118.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `preferred_id` | Not explicitly documented in adjacent source annotations. |

#### 9. `forget_player(instance_id, player_id)`

- **Location:** source line 131.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 10. `record_mt:on(event, callback)`

- **Location:** source line 141.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 11. `record_mt:once(event, callback)`

- **Location:** source line 146.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 12. `record_mt:on_any(callback)`

- **Location:** source line 151.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 13. `record_mt:on_any_once(callback)`

- **Location:** source line 156.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 14. `record_mt:off(event, callback)`

- **Location:** source line 161.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 15. `record_mt:off_any(callback)`

- **Location:** source line 166.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 16. `record_mt:emit(event, ...)`

- **Location:** source line 172.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Emit a custom event on this instance only.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 17. `record_mt:async_iter(event)`

- **Location:** source line 180.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create an async iterator scoped to a single event on this instance.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |

#### 18. `record_mt:async_iter_all()`

- **Location:** source line 186.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create an async iterator for every event on this instance.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 19. `EzMapInstance.on(event, callback)`

- **Location:** source line 195.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 20. `EzMapInstance.once(event, callback)`

- **Location:** source line 200.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 21. `EzMapInstance.on_any(callback)`

- **Location:** source line 205.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 22. `EzMapInstance.on_any_once(callback)`

- **Location:** source line 210.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 23. `EzMapInstance.off(event, callback)`

- **Location:** source line 215.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 24. `EzMapInstance.off_any(callback)`

- **Location:** source line 220.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `callback` | Not explicitly documented in adjacent source annotations. |

#### 25. `EzMapInstance.emit(event, ...)`

- **Location:** source line 226.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Emit a custom event on the global surface only.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 26. `EzMapInstance.async_iter(event)`

- **Location:** source line 233.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Async iterator for a single event across all instances.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event` | Not explicitly documented in adjacent source annotations. |

#### 27. `EzMapInstance.async_iter_all()`

- **Location:** source line 238.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Async iterator for every instance event.

#### 28. `EzMapInstance.create(base_area_id, preferred_instance_id, options)`

- **Location:** source line 254.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Clone a source area and register a new logical instance. Returns instance_record on success, or nil, error_message on failure.  options: host_id     - ID of the instance host/leader player_ids  - initial player IDs (ordered; host defaults to first member) party_id    - optional external party identifier metadata    - optional caller-owned metadata table

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `base_area_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `preferred_instance_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `options` | Not explicitly documented in adjacent source annotations. |

#### 29. `EzMapInstance.get(instance_id)`

- **Location:** source line 315.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Return an instance record by its cloned area ID.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance_id` | Not explicitly documented in adjacent source annotations. |

#### 30. `EzMapInstance.exists(instance_id)`

- **Location:** source line 320.
- **Declaration style:** `declared`.
- **Adjacent source comment:** True when this module currently owns a registered instance record.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance_id` | Not explicitly documented in adjacent source annotations. |

#### 31. `EzMapInstance.is_valid(instance_id)`

- **Location:** source line 326.
- **Declaration style:** `declared`.
- **Adjacent source comment:** True when the record exists and its cloned area is still listed by Net. If Net.list_areas is unavailable, the registered record remains authoritative.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance_id` | Not explicitly documented in adjacent source annotations. |

#### 32. `EzMapInstance.get_for_player(player_id)`

- **Location:** source line 338.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Return the instance record currently associated with a player ID.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 33. `EzMapInstance.list()`

- **Location:** source line 347.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Return a shallow array of all registered instance records.

#### 34. `EzMapInstance.set_host(instance_id, player_id)`

- **Location:** source line 357.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Set or change the recorded host. The caller controls host election policy. Emits "host_changed" when the host actually changes.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 35. `EzMapInstance.get_host(instance_id)`

- **Location:** source line 370.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance_id` | Not explicitly documented in adjacent source annotations. |

#### 36. `EzMapInstance.is_host(instance_id, player_id)`

- **Location:** source line 375.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 37. `EzMapInstance.register_player(instance_id, player_id)`

- **Location:** source line 382.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Add a player to an instance's membership tracking. Emits "player_joined" only for newly-added members (not for re-registration).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 38. `EzMapInstance.unregister_player(instance_id, player_id)`

- **Location:** source line 412.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Remove a player from membership tracking. This does not transfer the player. Emits "player_left" if the player was a member, and "host_changed" if the leaving player was the host.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 39. `EzMapInstance.add_player(instance_id, player_id)`

- **Location:** source line 444.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Naming aliases make membership intent clearer for callers while preserving the original register/unregister API used by FootBomb.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 40. `EzMapInstance.remove_player(instance_id, player_id)`

- **Location:** source line 448.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 41. `EzMapInstance.transfer_player(instance_id, player_id, x, y, z, warp_in, direction)`

- **Location:** source line 456.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Transfer a player to the cloned area at an explicit position and optional facing direction. Coordinates are required because spawn selection belongs to the caller. direction is passed through to Net.transfer_player as its final argument. Emits "player_joined" (via register_player) and "player_transferred".

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `z` | Not explicitly documented in adjacent source annotations. |
| 6 | `warp_in` | Not explicitly documented in adjacent source annotations. |
| 7 | `direction` | Not explicitly documented in adjacent source annotations. |

#### 42. `EzMapInstance.remove(instance_id)`

- **Location:** source line 491.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Remove the cloned area and its registry entries. Removal is idempotent for records created through this module. Emits "removed" on both surfaces before state is torn down.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `instance_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 66 | `(none)` | `ance.set_error_handler(handler) error_handler = type(handler) == "function" and hand…` |

## 📦 Tables and data

The following **7** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `EzMapInstance` — line 42

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `EzMapInstance.EVENT` — line 45

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `CREATED` | string literal | `"created"` |
| `REMOVED` | string literal | `"removed"` |
| `PLAYER_JOINED` | string literal | `"player_joined"` |
| `PLAYER_LEFT` | string literal | `"player_left"` |
| `HOST_CHANGED` | string literal | `"host_changed"` |
| `PLAYER_TRANSFERRED` | string literal | `"player_transferred"` |

### 3. `instances` — line 57

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `player_to_instance` — line 59

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `record_mt` — line 60

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `result` — line 90

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `result` — line 348

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
