# 📄 `enum.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/enum/enum.lua`](../../../enum/enum.lua)  
> **Source lines:** 184  
> **SHA-256 (UTF-8):** `e3b1e7c9fb5596…`  
> **Declared/assigned functions detected:** 14  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 14

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

A reusable Lua 5.2 module for creating enum-like tables. Supports custom key-value definitions, active value validation, and copying for independent instances. No external dependencies.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 18 | `Enum.new` | `...` | declared |
| 74 | `getName` | `self, value` | assigned |
| 79 | `getValue` | `self, key` | assigned |
| 84 | `isValid` | `self, value` | assigned |
| 89 | `names` | `self` | assigned |
| 99 | `values` | `self` | assigned |
| 108 | `getActive` | `self` | assigned |
| 113 | `setActive` | `self, value` | assigned |
| 120 | `random` | `self` | assigned |
| 126 | `new` | `self` | assigned |
| 131 | `copy` | `self` | assigned |
| 144 | `__index` | `tbl, key` | assigned |
| 159 | `__newindex` | `tbl, key, value` | assigned |
| 170 | `__tostring` | `tbl` | assigned |

### Function details

#### 1. `Enum.new(...)`

- **Location:** source line 18.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create a new enum. Accepts: 1. A list of names (strings) -> values become 1,2,3,... e.g., Enum.new("RED", "GREEN", "BLUE") 2. A table of key-value pairs (old format) e.g., Enum.new({ RED = "red", GREEN = "green", BLUE = 0x0000FF }) 3. A table with 'options' and optional 'active' (new format) e.g., Enum.new({ options = { RED = "red", GREEN = "green" }, active = "green" }) If 'active' is not provided, the first option becomes active.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 2. `getName(self, value)`

- **Location:** source line 74.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Return the key for a given value (requires unique values)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `value` | Not explicitly documented in adjacent source annotations. |

#### 3. `getValue(self, key)`

- **Location:** source line 79.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Return the value for a given key

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |

#### 4. `isValid(self, value)`

- **Location:** source line 84.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Check if a value is valid (exists in enum)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `value` | Not explicitly documented in adjacent source annotations. |

#### 5. `names(self)`

- **Location:** source line 89.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Return a sorted list of all keys (names)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 6. `values(self)`

- **Location:** source line 99.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Return a list of all values in insertion order

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 7. `getActive(self)`

- **Location:** source line 108.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Get the current active value

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 8. `setActive(self, value)`

- **Location:** source line 113.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Set the active value (validated)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `value` | Not explicitly documented in adjacent source annotations. |

#### 9. `random(self)`

- **Location:** source line 120.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Return a random valid value

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 10. `new(self)`

- **Location:** source line 126.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Alias for random

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 11. `copy(self)`

- **Location:** source line 131.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Returns a new independent enum with the same options

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 12. `__index(tbl, key)`

- **Location:** source line 144.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tbl` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |

#### 13. `__newindex(tbl, key, value)`

- **Location:** source line 159.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tbl` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `value` | Not explicitly documented in adjacent source annotations. |

#### 14. `__tostring(tbl)`

- **Location:** source line 170.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tbl` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **14** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Enum` — line 7

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `args` — line 19

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `...` |

### 3. `optionsTable` — line 37

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `keyToValue` — line 44

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `valueToKey` — line 45

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `orderedKeys` — line 46

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `orderedValues` — line 47

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `methods` — line 72

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `-- Return the key for a given value (requires unique values) getName = function(self, value) return valueToKey[value] end` |
| `[2]` | expression/reference | `-- Return the value for a given key getValue = function(self, key) return keyToValue[key] end` |
| `[3]` | expression/reference | `-- Check if a value is valid (exists in enum) isValid = function(self, value) return valueToKey[value] ~= nil end` |
| `[4]` | expression/reference | `-- Return a sorted list of all keys (names) names = function(self) local result = {} for key in pairs(keyToValue) do result[#result + 1] = key end table.s…` |
| `[5]` | expression/reference | `-- Return a list of all values in insertion order values = function(self) local result = {} for i` |
| `[6]` | expression/reference | `v in ipairs(orderedValues) do result[i] = v end return result end` |
| `[7]` | expression/reference | `-- Get the current active value getActive = function(self) return activeValue end` |
| `[8]` | expression/reference | `-- Set the active value (validated) setActive = function(self, value) assert(valueToKey[value] ~= nil, "Invalid active value for enum") activeValue = valu…` |
| `[9]` | expression/reference | `-- Return a random valid value random = function(self) if #orderedValues == 0 then return nil end return orderedValues[math.random(#orderedValues)] end` |
| `[10]` | expression/reference | `-- Alias for random new = function(self) return self:random() end` |
| `[11]` | expression/reference | `-- Returns a new independent enum with the same options copy = function(self) return Enum.new({ options = keyToValue, active = activeValue }) end` |

### 9. `result` — line 90

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `result` — line 100

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `enum` — line 137

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `mt` — line 143

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `__index` | function | `function(tbl, key) if key == "active" then return activeValue elseif key == "options" then -- Return a copy to prevent accidental modification local copy …` |
| `[2]` | expression/reference | `v in pairs(keyToValue) do copy[k] = v end return copy else return methods[key] end end` |
| `__newindex` | function | `function(tbl, key, value) if key == "active" then assert(valueToKey[value] ~= nil, "Invalid active value for enum") activeValue = value elseif key == "opt…` |
| `__tostring` | function | `function(tbl) local parts = {} for i` |
| `[5]` | expression/reference | `key in ipairs(orderedKeys) do parts[#parts + 1] = string.format("%s=%s", key, tostring(keyToValue[key])) end return "Enum(" .. table.concat(parts, ", ") .…` |

### 13. `copy` — line 149

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 14. `parts` — line 171

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
