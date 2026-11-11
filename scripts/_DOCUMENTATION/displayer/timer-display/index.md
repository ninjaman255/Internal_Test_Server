# 📄 `timer-display.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/displayer/timer-display.lua`](../../../displayer/timer-display.lua)  
> **Source lines:** 527  
> **SHA-256 (UTF-8):** `11e8d17e6252fd…`  
> **Declared/assigned functions detected:** 12  
> **Anonymous closures detected:** 24  
> **Table initializers detected:** 6

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

Source-based reference for `scripts/displayer/timer-display.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 15 | `scripts/displayer/font-system` |
| 16 | `scripts/displayer/timer-system` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 38 | `Net:on` | `timer_update` |
| 49 | `Net:on` | `countdown_update` |
| 60 | `Net:on` | `timer_remove` |
| 71 | `Net:on` | `countdown_remove` |
| 83 | `Net:on` | `timer_global_update` |
| 102 | `Net:on` | `countdown_global_update` |
| 122 | `Net:on` | `timer_global_create` |
| 141 | `Net:on` | `countdown_global_create` |
| 161 | `Net:on` | `timer_global_remove` |
| 177 | `Net:on` | `countdown_global_remove` |
| 193 | `Net:on` | `player_join` |
| 216 | `Net:on` | `player_disconnect` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 19 | `dump` | `o` | local |
| 32 | `TimerDisplay:init` | `(none)` | declared |
| 249 | `TimerDisplay:createPlayerTimerDisplay` | `player_id, display_id, x, y, options` | declared |
| 259 | `TimerDisplay:createPlayerCountdownDisplay` | `player_id, display_id, x, y, options` | declared |
| 268 | `TimerDisplay:createGlobalTimerDisplay` | `display_id, x, y, options` | declared |
| 290 | `TimerDisplay:createGlobalCountdownDisplay` | `display_id, x, y, options` | declared |
| 312 | `TimerDisplay:_createDisplay` | `player_id, display_id, x, y, type, options` | declared |
| 343 | `TimerDisplay:updateTimerDisplay` | `player_id, display_id, seconds` | declared |
| 350 | `TimerDisplay:updateCountdownDisplay` | `player_id, display_id, seconds` | declared |
| 358 | `TimerDisplay:_updateDisplay` | `player_id, display_id, seconds, is_countdown` | declared |
| 481 | `TimerDisplay:removeDisplay` | `player_id, display_id` | declared |
| 500 | `TimerDisplay:setDisplayPosition` | `player_id, display_id, x, y` | declared |

### Function details

#### 1. `dump(o)`

- **Location:** source line 19.
- **Declaration style:** `local`.
- **Adjacent source comment:** Helper to dump a table for logging

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `o` | Not explicitly documented in adjacent source annotations. |

#### 2. `TimerDisplay:init()`

- **Location:** source line 32.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 3. `TimerDisplay:createPlayerTimerDisplay(player_id, display_id, x, y, options)`

- **Location:** source line 249.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param player_id string`, `@param display_id string`, `@param x number        # virtual 240×160 coordinate`, `@param y number        # virtual 240×160 coordinate`, `@param options? TimerDisplayOptions`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `display_id` | `@param display_id string` |
| 3 | `x` | `@param x number        # virtual 240×160 coordinate` |
| 4 | `y` | `@param y number        # virtual 240×160 coordinate` |
| 5 | `options` | `@param options? TimerDisplayOptions` |

#### 4. `TimerDisplay:createPlayerCountdownDisplay(player_id, display_id, x, y, options)`

- **Location:** source line 259.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param player_id string`, `@param display_id string`, `@param x number        # virtual 240×160 coordinate`, `@param y number        # virtual 240×160 coordinate`, `@param options? TimerDisplayOptions`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `display_id` | `@param display_id string` |
| 3 | `x` | `@param x number        # virtual 240×160 coordinate` |
| 4 | `y` | `@param y number        # virtual 240×160 coordinate` |
| 5 | `options` | `@param options? TimerDisplayOptions` |

#### 5. `TimerDisplay:createGlobalTimerDisplay(display_id, x, y, options)`

- **Location:** source line 268.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param display_id string`, `@param x number        # virtual 240×160 coordinate`, `@param y number        # virtual 240×160 coordinate`, `@param options? TimerDisplayOptions`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `display_id` | `@param display_id string` |
| 2 | `x` | `@param x number        # virtual 240×160 coordinate` |
| 3 | `y` | `@param y number        # virtual 240×160 coordinate` |
| 4 | `options` | `@param options? TimerDisplayOptions` |

#### 6. `TimerDisplay:createGlobalCountdownDisplay(display_id, x, y, options)`

- **Location:** source line 290.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param display_id string`, `@param x number        # virtual 240×160 coordinate`, `@param y number        # virtual 240×160 coordinate`, `@param options? TimerDisplayOptions`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `display_id` | `@param display_id string` |
| 2 | `x` | `@param x number        # virtual 240×160 coordinate` |
| 3 | `y` | `@param y number        # virtual 240×160 coordinate` |
| 4 | `options` | `@param options? TimerDisplayOptions` |

#### 7. `TimerDisplay:_createDisplay(player_id, display_id, x, y, type, options)`

- **Location:** source line 312.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param player_id string`, `@param display_id string`, `@param x number        # virtual 240×160 coordinate`, `@param y number        # virtual 240×160 coordinate`, `@param type string`, `@param options TimerDisplayOptions`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `display_id` | `@param display_id string` |
| 3 | `x` | `@param x number        # virtual 240×160 coordinate` |
| 4 | `y` | `@param y number        # virtual 240×160 coordinate` |
| 5 | `type` | `@param type string` |
| 6 | `options` | `@param options TimerDisplayOptions` |

#### 8. `TimerDisplay:updateTimerDisplay(player_id, display_id, seconds)`

- **Location:** source line 343.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param player_id string`, `@param display_id string`, `@param seconds number`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `display_id` | `@param display_id string` |
| 3 | `seconds` | `@param seconds number` |

#### 9. `TimerDisplay:updateCountdownDisplay(player_id, display_id, seconds)`

- **Location:** source line 350.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param player_id string`, `@param display_id string`, `@param seconds number`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `display_id` | `@param display_id string` |
| 3 | `seconds` | `@param seconds number` |

#### 10. `TimerDisplay:_updateDisplay(player_id, display_id, seconds, is_countdown)`

- **Location:** source line 358.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param player_id string`, `@param display_id string`, `@param seconds number`, `@param is_countdown boolean`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `display_id` | `@param display_id string` |
| 3 | `seconds` | `@param seconds number` |
| 4 | `is_countdown` | `@param is_countdown boolean` |

#### 11. `TimerDisplay:removeDisplay(player_id, display_id)`

- **Location:** source line 481.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param player_id string`, `@param display_id string`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `display_id` | `@param display_id string` |

#### 12. `TimerDisplay:setDisplayPosition(player_id, display_id, x, y)`

- **Location:** source line 500.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Lua documentation annotations:** `@param player_id string`, `@param display_id string`, `@param x number        # virtual 240×160 coordinate`, `@param y number        # virtual 240×160 coordinate`
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | `@param player_id string` |
| 2 | `display_id` | `@param display_id string` |
| 3 | `x` | `@param x number        # virtual 240×160 coordinate` |
| 4 | `y` | `@param y number        # virtual 240×160 coordinate` |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 38 | `event` | `, options } (store for new players) -- Player-specific updates Net:on("timer_update",` |
| 39 | `(none)` | `ayer-specific updates Net:on("timer_update", function(event) local ok, err = pcall(` |
| 49 | `event` | `print("Error in timer_update:", err) end end) Net:on("countdown_update",` |
| 50 | `(none)` | `end end) Net:on("countdown_update", function(event) local ok, err = pcall(` |
| 60 | `event` | `print("Error in countdown_update:", err) end end) Net:on("timer_remove",` |
| 61 | `(none)` | `end end) Net:on("timer_remove", function(event) local ok, err = pcall(` |
| 71 | `event` | `print("Error in timer_remove:", err) end end) Net:on("countdown_remove",` |
| 72 | `(none)` | `end end) Net:on("countdown_remove", function(event) local ok, err = pcall(` |
| 83 | `event` | `al timer updates (update all players that have this display) Net:on("timer_global_up…` |
| 85 | `(none)` | `t("timer_global_update handler triggered, event =", dump(event)) local ok, err = pca…` |
| 102 | `event` | `ror in timer_global_update:", err) end end) Net:on("countdown_global_update",` |
| 104 | `(none)` | `ountdown_global_update handler triggered, event =", dump(event)) local ok, err = pca…` |
| 122 | `event` | `s – set initial value for all players that have this display Net:on("timer_global_cr…` |
| 124 | `(none)` | `t("timer_global_create handler triggered, event =", dump(event)) local ok, err = pca…` |
| 141 | `event` | `ror in timer_global_create:", err) end end) Net:on("countdown_global_create",` |
| 143 | `(none)` | `ountdown_global_create handler triggered, event =", dump(event)) local ok, err = pca…` |
| 161 | `event` | `vents – remove from all players and delete global definition Net:on("timer_global_re…` |
| 163 | `(none)` | `t("timer_global_remove handler triggered, event =", dump(event)) local ok, err = pca…` |
| 177 | `event` | `ror in timer_global_remove:", err) end end) Net:on("countdown_global_remove",` |
| 179 | `(none)` | `ountdown_global_remove handler triggered, event =", dump(event)) local ok, err = pca…` |
| 193 | `event` | `rint("Error in countdown_global_remove:", err) end end) Net:on("player_join",` |
| 194 | `(none)` | `end end) Net:on("player_join", function(event) local ok, err = pcall(` |
| 216 | `event` | `r in player_join (timer-display):", err) end end) Net:on("player_disconnect",` |
| 217 | `(none)` | `end end) Net:on("player_disconnect", function(event) local ok, err = pcall(` |

## 📦 Tables and data

The following **6** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `TimerDisplay` — line 12

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `self.displays` — line 34

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `self.global_displays` — line 35

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `glyph_data` — line 335

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `base_opts` — line 394

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `scale` | expression/reference | `disp.scale` |
| `z` | expression/reference | `disp.z` |
| `r` | expression/reference | `disp.color.r` |
| `g` | expression/reference | `disp.color.g` |
| `b` | expression/reference | `disp.color.b` |
| `opacity` | expression/reference | `disp.opacity` |
| `a` | expression/reference | `disp.a` |
| `ro` | expression/reference | `disp.ro` |
| `color_mode` | expression/reference | `disp.color_mode` |

### 6. `new_data` — line 407

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 12 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
