# 📄 `base64.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/avatar_utils/base64.lua`](../../../../ezlibs-scripts/avatar_utils/base64.lua)  
> **Source lines:** 201  
> **SHA-256 (UTF-8):** `bce7480e262be4…`  
> **Declared/assigned functions detected:** 6  
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

Source-based reference for `scripts/ezlibs-scripts/avatar_utils/base64.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 31 | `extract` | `v, from, width` | assigned |
| 35 | `extract` | `v, from, width` | assigned |
| 55 | `base64.makeencoder` | `s62, s63, spad` | declared |
| 67 | `base64.makedecoder` | `s62, s63, spad` | declared |
| 80 | `base64.encode` | `str, encoder, usecaching` | declared |
| 112 | `base64.decode` | `b64, decoder, usecaching` | declared |

### Function details

#### 1. `extract(v, from, width)`

- **Location:** source line 31.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `v` | Not explicitly documented in adjacent source annotations. |
| 2 | `from` | Not explicitly documented in adjacent source annotations. |
| 3 | `width` | Not explicitly documented in adjacent source annotations. |

#### 2. `extract(v, from, width)`

- **Location:** source line 35.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `v` | Not explicitly documented in adjacent source annotations. |
| 2 | `from` | Not explicitly documented in adjacent source annotations. |
| 3 | `width` | Not explicitly documented in adjacent source annotations. |

#### 3. `base64.makeencoder(s62, s63, spad)`

- **Location:** source line 55.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `s62` | Not explicitly documented in adjacent source annotations. |
| 2 | `s63` | Not explicitly documented in adjacent source annotations. |
| 3 | `spad` | Not explicitly documented in adjacent source annotations. |

#### 4. `base64.makedecoder(s62, s63, spad)`

- **Location:** source line 67.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `s62` | Not explicitly documented in adjacent source annotations. |
| 2 | `s63` | Not explicitly documented in adjacent source annotations. |
| 3 | `spad` | Not explicitly documented in adjacent source annotations. |

#### 5. `base64.encode(str, encoder, usecaching)`

- **Location:** source line 80.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `encoder` | Not explicitly documented in adjacent source annotations. |
| 3 | `usecaching` | Not explicitly documented in adjacent source annotations. |

#### 6. `base64.decode(b64, decoder, usecaching)`

- **Location:** source line 112.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `b64` | Not explicitly documented in adjacent source annotations. |
| 2 | `decoder` | Not explicitly documented in adjacent source annotations. |
| 3 | `usecaching` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **6** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `base64` — line 25

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `encoder` — line 56

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `decoder` — line 68

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `n` — line 82

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `cache` — line 84

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `k` — line 126

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
