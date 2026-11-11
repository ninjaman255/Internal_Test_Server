# 📄 `parties.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/utils/parties.lua`](../../../../../ezlibs-custom/nebulous-liberations/utils/parties.lua)  
> **Source lines:** 148  
> **SHA-256 (UTF-8):** `63a330050002d4…`  
> **Declared/assigned functions detected:** 9  
> **Anonymous closures detected:** 0  
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

Source-based reference for `scripts/ezlibs-custom/nebulous-liberations/utils/parties.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/libs/emotes` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 11 | `internal_find` | `player_id` | local |
| 26 | `Parties.find` | `player_id` | declared |
| 36 | `Parties.is_in_same_party` | `player_a, player_b` | declared |
| 54 | `Parties.on_tick` | `elapsed` | declared |
| 82 | `Parties.request` | `requester, recruit` | declared |
| 91 | `internal_find_request` | `requester, recruit` | local |
| 100 | `Parties.has_request` | `recruit, requester` | declared |
| 104 | `Parties.accept` | `recruit, requester` | declared |
| 131 | `Parties.leave` | `player_id` | declared |

### Function details

#### 1. `internal_find(player_id)`

- **Location:** source line 11.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 2. `Parties.find(player_id)`

- **Location:** source line 26.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 3. `Parties.is_in_same_party(player_a, player_b)`

- **Location:** source line 36.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_a` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_b` | Not explicitly documented in adjacent source annotations. |

#### 4. `Parties.on_tick(elapsed)`

- **Location:** source line 54.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `elapsed` | Not explicitly documented in adjacent source annotations. |

#### 5. `Parties.request(requester, recruit)`

- **Location:** source line 82.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `requester` | Not explicitly documented in adjacent source annotations. |
| 2 | `recruit` | Not explicitly documented in adjacent source annotations. |

#### 6. `internal_find_request(requester, recruit)`

- **Location:** source line 91.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `requester` | Not explicitly documented in adjacent source annotations. |
| 2 | `recruit` | Not explicitly documented in adjacent source annotations. |

#### 7. `Parties.has_request(recruit, requester)`

- **Location:** source line 100.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `recruit` | Not explicitly documented in adjacent source annotations. |
| 2 | `requester` | Not explicitly documented in adjacent source annotations. |

#### 8. `Parties.accept(recruit, requester)`

- **Location:** source line 104.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `recruit` | Not explicitly documented in adjacent source annotations. |
| 2 | `requester` | Not explicitly documented in adjacent source annotations. |

#### 9. `Parties.leave(player_id)`

- **Location:** source line 131.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **6** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Parties` — line 3

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `parties` — line 5

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `pending_requests` — line 6

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `return` — line 15

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `party_index` | expression/reference | `party_index` |
| `player_index` | expression/reference | `i` |

### 5. `dead_requests` — line 60

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `members` — line 120

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `requester` |
| `[2]` | expression/reference | `recruit` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.exclusive_player_emote` | 6 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
