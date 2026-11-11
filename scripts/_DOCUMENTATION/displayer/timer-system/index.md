# 📄 `timer-system.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/displayer/timer-system.lua`](../../../displayer/timer-system.lua)  
> **Source lines:** 486  
> **SHA-256 (UTF-8):** `4f27a428ded6b5…`  
> **Declared/assigned functions detected:** 30  
> **Anonymous closures detected:** 6  
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

Timer System with Global and Player-specific Timers

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 14 | `Net:on` | `player_join` |
| 24 | `Net:on` | `tick` |
| 35 | `Net:on` | `player_disconnect` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 6 | `Timer:init` | `(none)` | declared |
| 47 | `Timer:handlePlayerJoin` | `player_id` | declared |
| 62 | `Timer:handlePlayerLeave` | `player_id` | declared |
| 69 | `Timer:updateTimers` | `delta` | declared |
| 209 | `Timer:emitToAllPlayers` | `event_name, data` | declared |
| 223 | `Timer:pausePlayerTimer` | `player_id, timer_id` | declared |
| 229 | `Timer:resumePlayerTimer` | `player_id, timer_id` | declared |
| 235 | `Timer:pausePlayerCountdown` | `player_id, countdown_id` | declared |
| 241 | `Timer:resumePlayerCountdown` | `player_id, countdown_id` | declared |
| 247 | `Timer:removePlayerTimer` | `player_id, timer_id` | declared |
| 252 | `Timer:removePlayerCountdown` | `player_id, countdown_id` | declared |
| 258 | `Timer:createGlobalTimer` | `timer_id, duration, callback, loop` | declared |
| 281 | `Timer:createGlobalCountdown` | `countdown_id, duration, callback, loop` | declared |
| 304 | `Timer:pauseGlobalTimer` | `timer_id` | declared |
| 311 | `Timer:resumeGlobalTimer` | `timer_id` | declared |
| 318 | `Timer:pauseGlobalCountdown` | `countdown_id` | declared |
| 325 | `Timer:resumeGlobalCountdown` | `countdown_id` | declared |
| 332 | `Timer:removeGlobalTimer` | `timer_id` | declared |
| 341 | `Timer:removeGlobalCountdown` | `countdown_id` | declared |
| 350 | `Timer:getGlobalTimer` | `timer_id` | declared |
| 354 | `Timer:getGlobalCountdown` | `countdown_id` | declared |
| 359 | `Timer:syncGlobalTimers` | `player_id` | declared |
| 389 | `Timer:createPlayerTimer` | `player_id, timer_id, duration, callback, loop` | declared |
| 418 | `Timer:createPlayerCountdown` | `player_id, countdown_id, duration, callback, loop` | declared |
| 448 | `Timer:getAllGlobalTimers` | `(none)` | declared |
| 452 | `Timer:getAllGlobalCountdowns` | `(none)` | declared |
| 456 | `Timer:clearAllGlobalTimers` | `(none)` | declared |
| 462 | `Timer:clearAllGlobalCountdowns` | `(none)` | declared |
| 468 | `Timer:getPlayerTimer` | `player_id, timer_id` | declared |
| 475 | `Timer:getPlayerCountdown` | `player_id, countdown_id` | declared |

### Function details

#### 1. `Timer:init()`

- **Location:** source line 6.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 2. `Timer:handlePlayerJoin(player_id)`

- **Location:** source line 47.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 3. `Timer:handlePlayerLeave(player_id)`

- **Location:** source line 62.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 4. `Timer:updateTimers(delta)`

- **Location:** source line 69.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `delta` | Not explicitly documented in adjacent source annotations. |

#### 5. `Timer:emitToAllPlayers(event_name, data)`

- **Location:** source line 209.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Helper function to emit to all connected players (with error protection)
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `event_name` | Not explicitly documented in adjacent source annotations. |
| 2 | `data` | Not explicitly documented in adjacent source annotations. |

#### 6. `Timer:pausePlayerTimer(player_id, timer_id)`

- **Location:** source line 223.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `timer_id` | Not explicitly documented in adjacent source annotations. |

#### 7. `Timer:resumePlayerTimer(player_id, timer_id)`

- **Location:** source line 229.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `timer_id` | Not explicitly documented in adjacent source annotations. |

#### 8. `Timer:pausePlayerCountdown(player_id, countdown_id)`

- **Location:** source line 235.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `countdown_id` | Not explicitly documented in adjacent source annotations. |

#### 9. `Timer:resumePlayerCountdown(player_id, countdown_id)`

- **Location:** source line 241.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `countdown_id` | Not explicitly documented in adjacent source annotations. |

#### 10. `Timer:removePlayerTimer(player_id, timer_id)`

- **Location:** source line 247.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `timer_id` | Not explicitly documented in adjacent source annotations. |

#### 11. `Timer:removePlayerCountdown(player_id, countdown_id)`

- **Location:** source line 252.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `countdown_id` | Not explicitly documented in adjacent source annotations. |

#### 12. `Timer:createGlobalTimer(timer_id, duration, callback, loop)`

- **Location:** source line 258.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Global Timer Methods
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `timer_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `duration` | Not explicitly documented in adjacent source annotations. |
| 3 | `callback` | Not explicitly documented in adjacent source annotations. |
| 4 | `loop` | Not explicitly documented in adjacent source annotations. |

#### 13. `Timer:createGlobalCountdown(countdown_id, duration, callback, loop)`

- **Location:** source line 281.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `countdown_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `duration` | Not explicitly documented in adjacent source annotations. |
| 3 | `callback` | Not explicitly documented in adjacent source annotations. |
| 4 | `loop` | Not explicitly documented in adjacent source annotations. |

#### 14. `Timer:pauseGlobalTimer(timer_id)`

- **Location:** source line 304.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `timer_id` | Not explicitly documented in adjacent source annotations. |

#### 15. `Timer:resumeGlobalTimer(timer_id)`

- **Location:** source line 311.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `timer_id` | Not explicitly documented in adjacent source annotations. |

#### 16. `Timer:pauseGlobalCountdown(countdown_id)`

- **Location:** source line 318.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `countdown_id` | Not explicitly documented in adjacent source annotations. |

#### 17. `Timer:resumeGlobalCountdown(countdown_id)`

- **Location:** source line 325.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `countdown_id` | Not explicitly documented in adjacent source annotations. |

#### 18. `Timer:removeGlobalTimer(timer_id)`

- **Location:** source line 332.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `timer_id` | Not explicitly documented in adjacent source annotations. |

#### 19. `Timer:removeGlobalCountdown(countdown_id)`

- **Location:** source line 341.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `countdown_id` | Not explicitly documented in adjacent source annotations. |

#### 20. `Timer:getGlobalTimer(timer_id)`

- **Location:** source line 350.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `timer_id` | Not explicitly documented in adjacent source annotations. |

#### 21. `Timer:getGlobalCountdown(countdown_id)`

- **Location:** source line 354.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `countdown_id` | Not explicitly documented in adjacent source annotations. |

#### 22. `Timer:syncGlobalTimers(player_id)`

- **Location:** source line 359.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Sync methods for new players
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 23. `Timer:createPlayerTimer(player_id, timer_id, duration, callback, loop)`

- **Location:** source line 389.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `timer_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `duration` | Not explicitly documented in adjacent source annotations. |
| 4 | `callback` | Not explicitly documented in adjacent source annotations. |
| 5 | `loop` | Not explicitly documented in adjacent source annotations. |

#### 24. `Timer:createPlayerCountdown(player_id, countdown_id, duration, callback, loop)`

- **Location:** source line 418.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `countdown_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `duration` | Not explicitly documented in adjacent source annotations. |
| 4 | `callback` | Not explicitly documented in adjacent source annotations. |
| 5 | `loop` | Not explicitly documented in adjacent source annotations. |

#### 25. `Timer:getAllGlobalTimers()`

- **Location:** source line 448.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Additional utility methods
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 26. `Timer:getAllGlobalCountdowns()`

- **Location:** source line 452.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 27. `Timer:clearAllGlobalTimers()`

- **Location:** source line 456.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 28. `Timer:clearAllGlobalCountdowns()`

- **Location:** source line 462.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 29. `Timer:getPlayerTimer(player_id, timer_id)`

- **Location:** source line 468.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `timer_id` | Not explicitly documented in adjacent source annotations. |

#### 30. `Timer:getPlayerCountdown(player_id, countdown_id)`

- **Location:** source line 475.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `countdown_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 14 | `event` | `layer_data = {} -- Track player states -- Handle player joining Net:on("player_join",` |
| 15 | `(none)` | `Handle player joining Net:on("player_join", function(event) local ok, err = pcall(` |
| 24 | `event` | `r_join:", err) end end) -- Handle timer updates every tick Net:on("tick",` |
| 25 | `(none)` | `ndle timer updates every tick Net:on("tick", function(event) local ok, err = pcall(` |
| 35 | `event` | `ick:", err) end end) -- Handle player leaving Net:on("player_disconnect",` |
| 36 | `(none)` | `e player leaving Net:on("player_disconnect", function(event) local ok, err = pcall(` |

## 📦 Tables and data

The following **7** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Timer` — line 3

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `self.timers` — line 7

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `self.countdowns` — line 8

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `self.global_timers` — line 9

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `self.global_countdowns` — line 10

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `self.player_data` — line 11

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `event_data` — line 211

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.emit` | 15 |
| `Net.on` | 3 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
