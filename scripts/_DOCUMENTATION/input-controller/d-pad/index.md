# 📄 `d-pad.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/input-controller/d-pad.lua`](../../../input-controller/d-pad.lua)  
> **Source lines:** 190  
> **SHA-256 (UTF-8):** `228015c94dc888…`  
> **Declared/assigned functions detected:** 6  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 23

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

Source-based reference for `scripts/input-controller/d-pad.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/utils/utility` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 7 | `DPad.EmitButtonPressed` | `button, player_id` | declared |
| 39 | `getPressedDirectionSet` | `pressedButtons` | local |
| 51 | `getPressedDirections` | `pressedButtons` | local |
| 65 | `DPad.getActiveDirectionWithMemory` | `pressedButtons, player_id` | declared |
| 171 | `DPad.resetPlayerState` | `player_id` | declared |
| 180 | `DPad.getAllDirectionRawNames` | `(none)` | declared |

### Function details

#### 1. `DPad.EmitButtonPressed(button, player_id)`

- **Location:** source line 7.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `button` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 2. `getPressedDirectionSet(pressedButtons)`

- **Location:** source line 39.
- **Declaration style:** `local`.
- **Adjacent source comment:** Helper: get set of currently pressed direction names

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pressedButtons` | Not explicitly documented in adjacent source annotations. |

#### 3. `getPressedDirections(pressedButtons)`

- **Location:** source line 51.
- **Declaration style:** `local`.
- **Adjacent source comment:** Helper: get array of pressed direction names

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pressedButtons` | Not explicitly documented in adjacent source annotations. |

#### 4. `DPad.getActiveDirectionWithMemory(pressedButtons, player_id)`

- **Location:** source line 65.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Main stateful direction detection

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pressedButtons` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 5. `DPad.resetPlayerState(player_id)`

- **Location:** source line 171.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Reset player state

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 6. `DPad.getAllDirectionRawNames()`

- **Location:** source line 180.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Get all raw direction button names (for filtering in InputController)

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **23** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `DPad` — line 2

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `DPad.Directions` — line 12

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `Left` | nested table | `{ "Move Left", "UI Left" }` |
| `Right` | nested table | `{ "Move Right", "UI Right" }` |
| `Up` | nested table | `{ "Move Up", "UI Up" }` |
| `Down` | nested table | `{ "Move Down", "UI Down" }` |

### 3. `Left` — line 13

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Move Left"` |
| `[2]` | string literal | `"UI Left"` |

### 4. `Right` — line 14

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Move Right"` |
| `[2]` | string literal | `"UI Right"` |

### 5. `Up` — line 15

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Move Up"` |
| `[2]` | string literal | `"UI Up"` |

### 6. `Down` — line 16

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Move Down"` |
| `[2]` | string literal | `"UI Down"` |

### 7. `DPad.ComboDirections` — line 20

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `DownLeft` | nested table | `{ "Down", "Left" }` |
| `UpLeft` | nested table | `{ "Up", "Left" }` |
| `UpRight` | nested table | `{ "Up", "Right" }` |
| `DownRight` | nested table | `{ "Down", "Right" }` |

### 8. `DownLeft` — line 21

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Down"` |
| `[2]` | string literal | `"Left"` |

### 9. `UpLeft` — line 22

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Up"` |
| `[2]` | string literal | `"Left"` |

### 10. `UpRight` — line 23

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Up"` |
| `[2]` | string literal | `"Right"` |

### 11. `DownRight` — line 24

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Down"` |
| `[2]` | string literal | `"Right"` |

### 12. `buttonToDirection` — line 28

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `DPad.PlayerState` — line 36

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 14. `dirSet` — line 40

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 15. `dirs` — line 52

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 16. `seen` — line 53

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 17. `lastComboDirs` — line 76

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 18. `state.lastComboDirs` — line 86

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 19. `state.lastComboDirs` — line 109

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 20. `state.lastComboDirs` — line 142

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 21. `state.lastComboDirs` — line 155

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 22. `DPad.PlayerState` — line 175

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 23. `names` — line 181

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
