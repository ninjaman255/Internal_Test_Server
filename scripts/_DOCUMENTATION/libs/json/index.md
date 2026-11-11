# 📄 `json.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/libs/json.lua`](../../../libs/json.lua)  
> **Source lines:** 439  
> **SHA-256 (UTF-8):** `3ee318e52d99d8…`  
> **Declared/assigned functions detected:** 19  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 13

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

Copyright (c) 2020 rxi Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 49 | `escape_char` | `c` | local |
| 54 | `encode_nil` | `...` | local |
| 59 | `encode_table` | `val, stack, indent_unit, level` | local |
| 145 | `encode_string` | `val, ...` | local |
| 150 | `encode_number` | `val, ...` | local |
| 168 | `encode` | `val, stack, indent_unit, level` | assigned |
| 179 | `json.encode` | `val, pretty` | declared |
| 196 | `create_set` | `...` | local |
| 216 | `next_char` | `str, idx, set, negate` | local |
| 226 | `decode_error` | `str, idx, msg` | local |
| 240 | `codepoint_to_utf8` | `n` | local |
| 257 | `parse_unicode_escape` | `s` | local |
| 269 | `parse_string` | `str, i` | local |
| 310 | `parse_number` | `str, i` | local |
| 321 | `parse_literal` | `str, i` | local |
| 331 | `parse_array` | `str, i` | local |
| 358 | `parse_object` | `str, i` | local |
| 416 | `parse` | `str, idx` | assigned |
| 426 | `json.decode` | `str` | declared |

### Function details

#### 1. `escape_char(c)`

- **Location:** source line 49.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `c` | Not explicitly documented in adjacent source annotations. |

#### 2. `encode_nil(...)`

- **Location:** source line 54.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 3. `encode_table(val, stack, indent_unit, level)`

- **Location:** source line 59.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `val` | Not explicitly documented in adjacent source annotations. |
| 2 | `stack` | Not explicitly documented in adjacent source annotations. |
| 3 | `indent_unit` | Not explicitly documented in adjacent source annotations. |
| 4 | `level` | Not explicitly documented in adjacent source annotations. |

#### 4. `encode_string(val, ...)`

- **Location:** source line 145.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `val` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 5. `encode_number(val, ...)`

- **Location:** source line 150.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `val` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 6. `encode(val, stack, indent_unit, level)`

- **Location:** source line 168.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `val` | Not explicitly documented in adjacent source annotations. |
| 2 | `stack` | Not explicitly documented in adjacent source annotations. |
| 3 | `indent_unit` | Not explicitly documented in adjacent source annotations. |
| 4 | `level` | Not explicitly documented in adjacent source annotations. |

#### 7. `json.encode(val, pretty)`

- **Location:** source line 179.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `val` | Not explicitly documented in adjacent source annotations. |
| 2 | `pretty` | Not explicitly documented in adjacent source annotations. |

#### 8. `create_set(...)`

- **Location:** source line 196.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 9. `next_char(str, idx, set, negate)`

- **Location:** source line 216.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `idx` | Not explicitly documented in adjacent source annotations. |
| 3 | `set` | Not explicitly documented in adjacent source annotations. |
| 4 | `negate` | Not explicitly documented in adjacent source annotations. |

#### 10. `decode_error(str, idx, msg)`

- **Location:** source line 226.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `idx` | Not explicitly documented in adjacent source annotations. |
| 3 | `msg` | Not explicitly documented in adjacent source annotations. |

#### 11. `codepoint_to_utf8(n)`

- **Location:** source line 240.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `n` | Not explicitly documented in adjacent source annotations. |

#### 12. `parse_unicode_escape(s)`

- **Location:** source line 257.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `s` | Not explicitly documented in adjacent source annotations. |

#### 13. `parse_string(str, i)`

- **Location:** source line 269.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `i` | Not explicitly documented in adjacent source annotations. |

#### 14. `parse_number(str, i)`

- **Location:** source line 310.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `i` | Not explicitly documented in adjacent source annotations. |

#### 15. `parse_literal(str, i)`

- **Location:** source line 321.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `i` | Not explicitly documented in adjacent source annotations. |

#### 16. `parse_array(str, i)`

- **Location:** source line 331.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `i` | Not explicitly documented in adjacent source annotations. |

#### 17. `parse_object(str, i)`

- **Location:** source line 358.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `i` | Not explicitly documented in adjacent source annotations. |

#### 18. `parse(str, idx)`

- **Location:** source line 416.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `idx` | Not explicitly documented in adjacent source annotations. |

#### 19. `json.decode(str)`

- **Location:** source line 426.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **13** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `json` — line 25

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `_version` | string literal | `"0.1.2"` |

### 2. `escape_char_map` — line 33

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `[ "\\" ] = "\\"` |
| `[2]` | expression/reference | `[ "\"" ] = "\""` |
| `[3]` | expression/reference | `[ "\b" ] = "b"` |
| `[4]` | expression/reference | `[ "\f" ] = "f"` |
| `[5]` | expression/reference | `[ "\n" ] = "n"` |
| `[6]` | expression/reference | `[ "\r" ] = "r"` |
| `[7]` | expression/reference | `[ "\t" ] = "t"` |

### 3. `escape_char_map_inv` — line 43

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `[ "/" ] = "/"` |

### 4. `res` — line 61

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `lines` — line 87

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"["` |

### 6. `keys` — line 110

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `lines` — line 118

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"{"` |

### 8. `type_func_map` — line 159

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[ "nil"     ]` | expression/reference | `encode_nil` |
| `[ "table"   ]` | expression/reference | `encode_table` |
| `[ "string"  ]` | expression/reference | `encode_string` |
| `[ "number"  ]` | expression/reference | `encode_number` |
| `[ "boolean" ]` | expression/reference | `tostring` |

### 9. `res` — line 197

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `literal_map` — line 209

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[ "true"  ]` | boolean literal | `true` |
| `[ "false" ]` | boolean literal | `false` |
| `[ "null"  ]` | nil | `nil` |

### 11. `res` — line 332

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `res` — line 359

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `char_func_map` — line 395

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[ '"' ]` | expression/reference | `parse_string` |
| `[ "0" ]` | expression/reference | `parse_number` |
| `[ "1" ]` | expression/reference | `parse_number` |
| `[ "2" ]` | expression/reference | `parse_number` |
| `[ "3" ]` | expression/reference | `parse_number` |
| `[ "4" ]` | expression/reference | `parse_number` |
| `[ "5" ]` | expression/reference | `parse_number` |
| `[ "6" ]` | expression/reference | `parse_number` |
| `[ "7" ]` | expression/reference | `parse_number` |
| `[ "8" ]` | expression/reference | `parse_number` |
| `[ "9" ]` | expression/reference | `parse_number` |
| `[12]` | expression/reference | `[ "-" ] = parse_number` |
| `[ "t" ]` | expression/reference | `parse_literal` |
| `[ "f" ]` | expression/reference | `parse_literal` |
| `[ "n" ]` | expression/reference | `parse_literal` |
| `[16]` | expression/reference | `[ "[" ] = parse_array` |
| `[17]` | expression/reference | `[ "{" ] = parse_object` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
