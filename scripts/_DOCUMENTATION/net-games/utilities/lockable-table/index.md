# 📄 `lockable-table.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/utilities/lockable-table.lua`](../../../../net-games/utilities/lockable-table.lua)  
> **Source lines:** 352  
> **SHA-256 (UTF-8):** `8696b797cd35f7…`  
> **Declared/assigned functions detected:** 35  
> **Anonymous closures detected:** 1  
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

Source-based reference for `scripts/net-games/utilities/lockable-table.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 4 | `is_lockable` | `t` | local |
| 8 | `create_lockable_table` | `t` | local |
| 19 | `can_modify` | `key, new_value` | local |
| 44 | `__index` | `tbl, key` | assigned |
| 54 | `__newindex` | `tbl, key, value` | assigned |
| 73 | `__pairs` | `(none)` | assigned |
| 79 | `__len` | `(none)` | assigned |
| 91 | `methods:add` | `key, value, recursive` | declared |
| 109 | `methods:remove` | `key, recursive` | declared |
| 128 | `methods:addMany` | `pairs, recursive` | declared |
| 138 | `methods:removeMany` | `keys, recursive` | declared |
| 148 | `methods:canAdd` | `key` | declared |
| 152 | `methods:canRemove` | `key` | declared |
| 156 | `methods:update` | `key, value, recursive` | declared |
| 170 | `methods:replace` | `new_data, recursive` | declared |
| 197 | `methods:clear` | `recursive` | declared |
| 202 | `methods:getRaw` | `key` | declared |
| 206 | `methods:setRaw` | `key, value` | declared |
| 211 | `methods:lockKey` | `key, recursive` | declared |
| 220 | `methods:unlockKey` | `key, recursive` | declared |
| 229 | `methods:lockValue` | `value, recursive` | declared |
| 240 | `methods:unlockValue` | `value, recursive` | declared |
| 251 | `methods:lockAll` | `recursive` | declared |
| 264 | `methods:unlockAll` | `recursive` | declared |
| 279 | `methods:isKeyLocked` | `key` | declared |
| 283 | `methods:isValueLocked` | `value` | declared |
| 287 | `methods:isFullyLocked` | `(none)` | declared |
| 291 | `methods:getLockedKeys` | `(none)` | declared |
| 299 | `methods:getLockedValues` | `(none)` | declared |
| 307 | `methods:size` | `(none)` | declared |
| 315 | `methods:keys` | `(none)` | declared |
| 323 | `methods:values` | `(none)` | declared |
| 335 | `LockableTable.new` | `t` | declared |
| 340 | `LockableTable.isLockable` | `t` | declared |
| 345 | `LockableTable.wrap` | `t` | declared |

### Function details

#### 1. `is_lockable(t)`

- **Location:** source line 4.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 2. `create_lockable_table(t)`

- **Location:** source line 8.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 3. `can_modify(key, new_value)`

- **Location:** source line 19.
- **Declaration style:** `local`.
- **Adjacent source comment:** Helper function to check if we can modify

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |
| 2 | `new_value` | Not explicitly documented in adjacent source annotations. |

#### 4. `__index(tbl, key)`

- **Location:** source line 44.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tbl` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |

#### 5. `__newindex(tbl, key, value)`

- **Location:** source line 54.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tbl` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `value` | Not explicitly documented in adjacent source annotations. |

#### 6. `__pairs()`

- **Location:** source line 73.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 7. `__len()`

- **Location:** source line 79.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 8. `methods:add(key, value, recursive)`

- **Location:** source line 91.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Define methods
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |
| 2 | `value` | Not explicitly documented in adjacent source annotations. |
| 3 | `recursive` | Not explicitly documented in adjacent source annotations. |

#### 9. `methods:remove(key, recursive)`

- **Location:** source line 109.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |
| 2 | `recursive` | Not explicitly documented in adjacent source annotations. |

#### 10. `methods:addMany(pairs, recursive)`

- **Location:** source line 128.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `pairs` | Not explicitly documented in adjacent source annotations. |
| 2 | `recursive` | Not explicitly documented in adjacent source annotations. |

#### 11. `methods:removeMany(keys, recursive)`

- **Location:** source line 138.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `keys` | Not explicitly documented in adjacent source annotations. |
| 2 | `recursive` | Not explicitly documented in adjacent source annotations. |

#### 12. `methods:canAdd(key)`

- **Location:** source line 148.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |

#### 13. `methods:canRemove(key)`

- **Location:** source line 152.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |

#### 14. `methods:update(key, value, recursive)`

- **Location:** source line 156.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |
| 2 | `value` | Not explicitly documented in adjacent source annotations. |
| 3 | `recursive` | Not explicitly documented in adjacent source annotations. |

#### 15. `methods:replace(new_data, recursive)`

- **Location:** source line 170.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `new_data` | Not explicitly documented in adjacent source annotations. |
| 2 | `recursive` | Not explicitly documented in adjacent source annotations. |

#### 16. `methods:clear(recursive)`

- **Location:** source line 197.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `recursive` | Not explicitly documented in adjacent source annotations. |

#### 17. `methods:getRaw(key)`

- **Location:** source line 202.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |

#### 18. `methods:setRaw(key, value)`

- **Location:** source line 206.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |
| 2 | `value` | Not explicitly documented in adjacent source annotations. |

#### 19. `methods:lockKey(key, recursive)`

- **Location:** source line 211.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |
| 2 | `recursive` | Not explicitly documented in adjacent source annotations. |

#### 20. `methods:unlockKey(key, recursive)`

- **Location:** source line 220.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |
| 2 | `recursive` | Not explicitly documented in adjacent source annotations. |

#### 21. `methods:lockValue(value, recursive)`

- **Location:** source line 229.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `recursive` | Not explicitly documented in adjacent source annotations. |

#### 22. `methods:unlockValue(value, recursive)`

- **Location:** source line 240.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `recursive` | Not explicitly documented in adjacent source annotations. |

#### 23. `methods:lockAll(recursive)`

- **Location:** source line 251.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `recursive` | Not explicitly documented in adjacent source annotations. |

#### 24. `methods:unlockAll(recursive)`

- **Location:** source line 264.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `recursive` | Not explicitly documented in adjacent source annotations. |

#### 25. `methods:isKeyLocked(key)`

- **Location:** source line 279.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |

#### 26. `methods:isValueLocked(value)`

- **Location:** source line 283.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 27. `methods:isFullyLocked()`

- **Location:** source line 287.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 28. `methods:getLockedKeys()`

- **Location:** source line 291.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 29. `methods:getLockedValues()`

- **Location:** source line 299.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 30. `methods:size()`

- **Location:** source line 307.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 31. `methods:keys()`

- **Location:** source line 315.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 32. `methods:values()`

- **Location:** source line 323.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.
- **Method invocation:** Uses Lua colon-method syntax (`self` is implicit at call sites).

#### 33. `LockableTable.new(t)`

- **Location:** source line 335.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Module function

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 34. `LockableTable.isLockable(t)`

- **Location:** source line 340.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Check if a table is lockable

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 35. `LockableTable.wrap(t)`

- **Location:** source line 345.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Make a regular table lockable (shallow)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 74 | `tbl, k` | `data[key] = value end, __pairs = function() return` |

## 📦 Tables and data

The following **14** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `LockableTable` — line 2

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `locked_keys` — line 11

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `locked_values` — line 12

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `methods` — line 16

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `public` — line 37

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `mt` — line 43

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `__index` | function | `function(tbl, key) -- First check if it's a method local method = methods[key] if method then return method end -- Then return data return data[key] end` |
| `__newindex` | function | `function(tbl, key, value) -- Check if trying to overwrite a method if methods[key] then error("Cannot overwrite method: " .. tostring(key)) end local ok` |
| `err` | expression/reference | `can_modify(key, value) if not ok then error(err) end -- Handle nested lockable tables if is_lockable(value) then value._parent = public end data[key] = va…` |
| `__pairs` | function | `function() return function(tbl, k) return next(data, k) end` |
| `[5]` | nil | `nil` |
| `[6]` | expression/reference | `nil end` |
| `__len` | function | `function() local count = 0 for _ in pairs(data) do count = count + 1 end return count end` |

### 7. `results` — line 130

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `results` — line 140

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `locked_keys` — line 267

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `locked_values` — line 268

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `keys` — line 292

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `values` — line 300

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `keys` — line 316

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 14. `values` — line 324

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
