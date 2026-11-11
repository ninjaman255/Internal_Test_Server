# 📄 `enumset.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/enum/enumset.lua`](../../../enum/enumset.lua)  
> **Source lines:** 72  
> **SHA-256 (UTF-8):** `fff751babf8ccb…`  
> **Declared/assigned functions detected:** 6  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 5

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

A container that holds multiple enums and returns a fresh copy of an enum when accessed by key. Requires enum.lua

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 6 | `scripts/enum/enum` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 14 | `EnumSet.new` | `definitions` | declared |
| 29 | `keys` | `self` | assigned |
| 39 | `getOriginal` | `self, key` | assigned |
| 44 | `get` | `self, key` | assigned |
| 54 | `__index` | `tbl, key` | assigned |
| 64 | `__newindex` | `tbl, key, value` | assigned |

### Function details

#### 1. `EnumSet.new(definitions)`

- **Location:** source line 14.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create a new EnumSet from a table of enums. The input `definitions` is a table mapping string keys to enum objects created by Enum.new(). Accessing a key in the returned set returns a fresh copy of that enum.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `definitions` | Not explicitly documented in adjacent source annotations. |

#### 2. `keys(self)`

- **Location:** source line 29.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Returns a list of all keys in the set

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 3. `getOriginal(self, key)`

- **Location:** source line 39.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Returns the original enum (without copying) – use with caution

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |

#### 4. `get(self, key)`

- **Location:** source line 44.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Returns a copy of the enum for the given key (same as set[key])

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |

#### 5. `__index(tbl, key)`

- **Location:** source line 54.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tbl` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |

#### 6. `__newindex(tbl, key, value)`

- **Location:** source line 64.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Prevent modification of the set's enum definitions via assignment

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tbl` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `value` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **5** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `EnumSet` — line 8

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `set` — line 16

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `internalEnums` — line 17

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `methods` — line 27

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `-- Returns a list of all keys in the set keys = function(self) local result = {} for key in pairs(internalEnums) do result[#result + 1] = key end table.so…` |
| `[2]` | expression/reference | `-- Returns the original enum (without copying) – use with caution getOriginal = function(self, key) return internalEnums[key] end` |
| `[3]` | expression/reference | `-- Returns a copy of the enum for the given key (same as set[key]) get = function(self, key) local enum = internalEnums[key] if enum then return enum:copy…` |

### 5. `result` — line 30

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
