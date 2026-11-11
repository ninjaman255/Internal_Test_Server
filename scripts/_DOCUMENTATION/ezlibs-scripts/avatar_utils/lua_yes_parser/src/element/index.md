# 📄 `element.lua`

[🏠 Documentation home](../../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/element.lua`](../../../../../../ezlibs-scripts/avatar_utils/lua_yes_parser/src/element.lua)  
> **Source lines:** 419  
> **SHA-256 (UTF-8):** `4f05a8dba6fea7…`  
> **Declared/assigned functions detected:** 18  
> **Anonymous closures detected:** 1  
> **Table initializers detected:** 9

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

Source-based reference for `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/element.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums` |
| 2 | `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/keyval` |
| 3 | `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/utils/trim` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 6 | `Element.new` | `(none)` | assigned |
| 14 | `__tostring` | `self` | assigned |
| 23 | `this.setAttributes` | `attrs` | assigned |
| 36 | `findKey` | `key` | assigned |
| 49 | `this.upsert` | `keyval` | assigned |
| 62 | `this.hasKey` | `key` | assigned |
| 66 | `this.hasKeys` | `keyList` | assigned |
| 76 | `this.getKeyValue` | `key, orValue` | assigned |
| 87 | `this.getKeyValueAsInt` | `key, orValue` | assigned |
| 95 | `this.getKeyValueAsBool` | `key, orValue` | assigned |
| 107 | `this.getKeyValueAsNumber` | `key, orValue` | assigned |
| 116 | `this.printArgs` | `(none)` | assigned |
| 137 | `ElementParser.new` | `(none)` | assigned |
| 145 | `setDelimiterType` | `type` | assigned |
| 154 | `evaluateDelimiter` | `input, start` | assigned |
| 268 | `evaluateToken` | `input, start, nd` | assigned |
| 287 | `parseTokenStep` | `input, start` | assigned |
| 313 | `self.parseTokens` | `input, start` | assigned |

### Function details

#### 1. `Element.new()`

- **Location:** source line 6.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 2. `__tostring(self)`

- **Location:** source line 14.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 3. `this.setAttributes(attrs)`

- **Location:** source line 23.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `attrs` | Not explicitly documented in adjacent source annotations. |

#### 4. `findKey(key)`

- **Location:** source line 36.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** helper func

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |

#### 5. `this.upsert(keyval)`

- **Location:** source line 49.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `keyval` | Not explicitly documented in adjacent source annotations. |

#### 6. `this.hasKey(key)`

- **Location:** source line 62.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |

#### 7. `this.hasKeys(keyList)`

- **Location:** source line 66.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `keyList` | Not explicitly documented in adjacent source annotations. |

#### 8. `this.getKeyValue(key, orValue)`

- **Location:** source line 76.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |
| 2 | `orValue` | Not explicitly documented in adjacent source annotations. |

#### 9. `this.getKeyValueAsInt(key, orValue)`

- **Location:** source line 87.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |
| 2 | `orValue` | Not explicitly documented in adjacent source annotations. |

#### 10. `this.getKeyValueAsBool(key, orValue)`

- **Location:** source line 95.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |
| 2 | `orValue` | Not explicitly documented in adjacent source annotations. |

#### 11. `this.getKeyValueAsNumber(key, orValue)`

- **Location:** source line 107.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key` | Not explicitly documented in adjacent source annotations. |
| 2 | `orValue` | Not explicitly documented in adjacent source annotations. |

#### 12. `this.printArgs()`

- **Location:** source line 116.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 13. `ElementParser.new()`

- **Location:** source line 137.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 14. `setDelimiterType(type)`

- **Location:** source line 145.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `type` | Not explicitly documented in adjacent source annotations. |

#### 15. `evaluateDelimiter(input, start)`

- **Location:** source line 154.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `input` | Not explicitly documented in adjacent source annotations. |
| 2 | `start` | Not explicitly documented in adjacent source annotations. |

#### 16. `evaluateToken(input, start, nd)`

- **Location:** source line 268.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `input` | Not explicitly documented in adjacent source annotations. |
| 2 | `start` | Not explicitly documented in adjacent source annotations. |
| 3 | `nd` | Not explicitly documented in adjacent source annotations. |

#### 17. `parseTokenStep(input, start)`

- **Location:** source line 287.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `input` | Not explicitly documented in adjacent source annotations. |
| 2 | `start` | Not explicitly documented in adjacent source annotations. |

#### 18. `self.parseTokens(input, start)`

- **Location:** source line 313.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `input` | Not explicitly documented in adjacent source annotations. |
| 2 | `start` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 324 | `line` | `elf.error ~= nil then break end end end return self end local read <const> =` |

## 📦 Tables and data

The following **9** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `Element` — line 5

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `this` — line 7

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `attributes` | nested table | `{}` |
| `text` | string literal | `''` |
| `args` | nested table | `{}` |
| `type` | expression/reference | `enums.ElementTypes.STANDARD` |

### 3. `attributes` — line 8

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `args` — line 10

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `this.attributes` — line 24

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `mt` — line 129

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `__tostring` | expression/reference | `__tostring` |

### 7. `ElementParser` — line 136

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `self` — line 138

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `delimiter` | expression/reference | `enums.Delimiters.UNSET` |
| `element` | nil | `nil` |
| `error` | nil | `nil` |
| `lineNumber` | numeric literal | `-1` |

### 9. `return` — line 419

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `read` | expression/reference | `read` |
| `Element` | expression/reference | `Element` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
