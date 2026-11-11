# 📄 `option_menu.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/option_menu.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/option_menu.lua)  
> **Source lines:** 448  
> **SHA-256 (UTF-8):** `8fc64af0269dee…`  
> **Declared/assigned functions detected:** 12  
> **Anonymous closures detected:** 6  
> **Table initializers detected:** 12

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

Controller-driven option menu for Nebulous Liberations mission interactions. The title and option list use separate 9-slice panels: options-header: title options-body: option rows Both panels share a width while keeping independently measured heights.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 8 | `scripts/displayer/displayer` |
| 9 | `scripts/input-controller/main` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 286 | `Net:on` | `tick` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 62 | `is_menu_up_pressed` | `controller, owner` | local |
| 68 | `is_menu_down_pressed` | `controller, owner` | local |
| 74 | `make_header_children` | `title` | local |
| 85 | `make_body_children` | `options, selected` | local |
| 104 | `remove_panel` | `player_id, panel_id` | local |
| 110 | `position_panels` | `menu` | local |
| 142 | `find_cancel_option` | `options` | local |
| 152 | `refresh_body` | `menu` | local |
| 162 | `cleanup` | `player_id, menu, result` | local |
| 185 | `apply_shared_width` | `menu` | local |
| 212 | `create_panels` | `player_id, menu` | local |
| 345 | `OptionMenu.select` | `player_id, options, title` | declared |

### Function details

#### 1. `is_menu_up_pressed(controller, owner)`

- **Location:** source line 62.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `controller` | Not explicitly documented in adjacent source annotations. |
| 2 | `owner` | Not explicitly documented in adjacent source annotations. |

#### 2. `is_menu_down_pressed(controller, owner)`

- **Location:** source line 68.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `controller` | Not explicitly documented in adjacent source annotations. |
| 2 | `owner` | Not explicitly documented in adjacent source annotations. |

#### 3. `make_header_children(title)`

- **Location:** source line 74.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `title` | Not explicitly documented in adjacent source annotations. |

#### 4. `make_body_children(options, selected)`

- **Location:** source line 85.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `options` | Not explicitly documented in adjacent source annotations. |
| 2 | `selected` | Not explicitly documented in adjacent source annotations. |

#### 5. `remove_panel(player_id, panel_id)`

- **Location:** source line 104.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `panel_id` | Not explicitly documented in adjacent source annotations. |

#### 6. `position_panels(menu)`

- **Location:** source line 110.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `menu` | Not explicitly documented in adjacent source annotations. |

#### 7. `find_cancel_option(options)`

- **Location:** source line 142.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `options` | Not explicitly documented in adjacent source annotations. |

#### 8. `refresh_body(menu)`

- **Location:** source line 152.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `menu` | Not explicitly documented in adjacent source annotations. |

#### 9. `cleanup(player_id, menu, result)`

- **Location:** source line 162.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `menu` | Not explicitly documented in adjacent source annotations. |
| 3 | `result` | Not explicitly documented in adjacent source annotations. |

#### 10. `apply_shared_width(menu)`

- **Location:** source line 185.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `menu` | Not explicitly documented in adjacent source annotations. |

#### 11. `create_panels(player_id, menu)`

- **Location:** source line 212.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `menu` | Not explicitly documented in adjacent source annotations. |

#### 12. `OptionMenu.select(player_id, options, title)`

- **Location:** source line 345.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `options` | Not explicitly documented in adjacent source annotations. |
| 3 | `title` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 286 | `event` | `return true end -- Process all active menus from one engine tick listener. Net:on("t…` |
| 347 | `resolve` | `r_id, options, title) if type(options) ~= "table" then return Async.create_promise(` |
| 366 | `resolve` | `#menu_options end if active_menus[player_id] then return Async.create_promise(` |
| 375 | `resolve` | `I.create_controller(player_id) if not controller then return Async.create_promise(` |
| 384 | `resolve` | `l body_id = PANEL_ID_PREFIX .. tostring(player_id) .. ":body" return Async.create_pr…` |
| 424 | `(none)` | `interval and require a fresh release/press. Async.sleep(INPUT_SETTLE_SECONDS).and_th…` |

## 📦 Tables and data

The following **12** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `OptionMenu` — line 11

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `PANEL_PADDING` — line 37

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `horizontal` | numeric literal | `9` |
| `vertical` | numeric literal | `8` |

### 3. `CHILD_PADDING` — line 38

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `horizontal` | numeric literal | `3` |
| `vertical` | numeric literal | `2` |

### 4. `active_menus` — line 51

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `MENU_ACTIONS` — line 55

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Up"` |
| `[2]` | string literal | `"Down"` |
| `[3]` | string literal | `"Left"` |
| `[4]` | string literal | `"Right"` |
| `[5]` | string literal | `"UpLeft"` |
| `[6]` | string literal | `"UpRight"` |
| `[7]` | string literal | `"DownLeft"` |
| `[8]` | string literal | `"DownRight"` |
| `[9]` | string literal | `"Confirm"` |
| `[10]` | string literal | `"Cancel"` |

### 6. `return` — line 75

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `Displayer.Builder.panelTextChild(title or "Select an option", { font = "THICK", scale = TEXT_SCALE, color = { r = 0, g = 0, b = 0, a = 255 }, align = "cen…` |

### 7. `color` — line 79

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `0` |
| `g` | numeric literal | `0` |
| `b` | numeric literal | `0` |
| `a` | numeric literal | `255` |

### 8. `children` — line 86

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `color` — line 95

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | numeric literal | `0` |
| `g` | numeric literal | `0` |
| `b` | numeric literal | `0` |
| `a` | numeric literal | `255` |

### 10. `initial_options` — line 213

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `auto_size` | boolean literal | `true` |
| `max_width` | expression/reference | `MENU_MAX_WIDTH` |
| `padding` | expression/reference | `PANEL_PADDING` |
| `child_padding` | expression/reference | `CHILD_PADDING` |
| `slice_scale` | expression/reference | `SLICE_SCALE` |
| `z` | numeric literal | `220` |

### 11. `menu_options` — line 354

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `menu` — line 385

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `player_id` | expression/reference | `player_id` |
| `controller` | expression/reference | `controller` |
| `owner` | expression/reference | `owner` |
| `header_id` | expression/reference | `header_id` |
| `body_id` | expression/reference | `body_id` |
| `title` | expression/reference | `title` |
| `options` | expression/reference | `menu_options` |
| `cancel_index` | expression/reference | `cancel_index` |
| `selected` | numeric literal | `1` |
| `active` | boolean literal | `false` |
| `finished` | boolean literal | `false` |
| `header_panel` | nil | `nil` |
| `body_panel` | nil | `nil` |
| `resolve` | expression/reference | `resolve` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.create_promise` | 4 |
| `Async.sleep` | 1 |
| `Net.is_player` | 2 |
| `Net.on` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
