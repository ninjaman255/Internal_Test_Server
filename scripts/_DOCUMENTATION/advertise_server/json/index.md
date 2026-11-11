# 📄 `json.lua`

> ⚠️ **Archive-only reference:** The source file `scripts/advertise_server/json.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `scripts/advertise_server/json.lua` (not present in the current server ZIP).  
> **Source lines:** 388  
> **SHA-256 (UTF-8):** `23031288e52888…`  
> **Declared/assigned functions detected:** 19  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 10

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
| 54 | `encode_nil` | `val` | local |
| 59 | `encode_table` | `val, stack` | local |
| 101 | `encode_string` | `val` | local |
| 106 | `encode_number` | `val` | local |
| 124 | `encode` | `val, stack` | assigned |
| 134 | `json.encode` | `val` | declared |
| 145 | `create_set` | `...` | local |
| 165 | `next_char` | `str, idx, set, negate` | local |
| 175 | `decode_error` | `str, idx, msg` | local |
| 189 | `codepoint_to_utf8` | `n` | local |
| 206 | `parse_unicode_escape` | `s` | local |
| 218 | `parse_string` | `str, i` | local |
| 259 | `parse_number` | `str, i` | local |
| 270 | `parse_literal` | `str, i` | local |
| 280 | `parse_array` | `str, i` | local |
| 307 | `parse_object` | `str, i` | local |
| 365 | `parse` | `str, idx` | assigned |
| 375 | `json.decode` | `str` | declared |

### Function details

#### 1. `escape_char(c)`

- **Location:** source line 49.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `c` | Not explicitly documented in adjacent source annotations. |

#### 2. `encode_nil(val)`

- **Location:** source line 54.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `val` | Not explicitly documented in adjacent source annotations. |

#### 3. `encode_table(val, stack)`

- **Location:** source line 59.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `val` | Not explicitly documented in adjacent source annotations. |
| 2 | `stack` | Not explicitly documented in adjacent source annotations. |

#### 4. `encode_string(val)`

- **Location:** source line 101.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `val` | Not explicitly documented in adjacent source annotations. |

#### 5. `encode_number(val)`

- **Location:** source line 106.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `val` | Not explicitly documented in adjacent source annotations. |

#### 6. `encode(val, stack)`

- **Location:** source line 124.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `val` | Not explicitly documented in adjacent source annotations. |
| 2 | `stack` | Not explicitly documented in adjacent source annotations. |

#### 7. `json.encode(val)`

- **Location:** source line 134.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `val` | Not explicitly documented in adjacent source annotations. |

#### 8. `create_set(...)`

- **Location:** source line 145.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 9. `next_char(str, idx, set, negate)`

- **Location:** source line 165.
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

- **Location:** source line 175.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `idx` | Not explicitly documented in adjacent source annotations. |
| 3 | `msg` | Not explicitly documented in adjacent source annotations. |

#### 11. `codepoint_to_utf8(n)`

- **Location:** source line 189.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `n` | Not explicitly documented in adjacent source annotations. |

#### 12. `parse_unicode_escape(s)`

- **Location:** source line 206.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `s` | Not explicitly documented in adjacent source annotations. |

#### 13. `parse_string(str, i)`

- **Location:** source line 218.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `i` | Not explicitly documented in adjacent source annotations. |

#### 14. `parse_number(str, i)`

- **Location:** source line 259.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `i` | Not explicitly documented in adjacent source annotations. |

#### 15. `parse_literal(str, i)`

- **Location:** source line 270.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `i` | Not explicitly documented in adjacent source annotations. |

#### 16. `parse_array(str, i)`

- **Location:** source line 280.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `i` | Not explicitly documented in adjacent source annotations. |

#### 17. `parse_object(str, i)`

- **Location:** source line 307.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `i` | Not explicitly documented in adjacent source annotations. |

#### 18. `parse(str, idx)`

- **Location:** source line 365.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `idx` | Not explicitly documented in adjacent source annotations. |

#### 19. `json.decode(str)`

- **Location:** source line 375.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **10** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

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

### 4. `res` — line 60

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `type_func_map` — line 115

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[ "nil"     ]` | expression/reference | `encode_nil` |
| `[ "table"   ]` | expression/reference | `encode_table` |
| `[ "string"  ]` | expression/reference | `encode_string` |
| `[ "number"  ]` | expression/reference | `encode_number` |
| `[ "boolean" ]` | expression/reference | `tostring` |

### 6. `res` — line 146

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `literal_map` — line 158

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[ "true"  ]` | boolean literal | `true` |
| `[ "false" ]` | boolean literal | `false` |
| `[ "null"  ]` | nil | `nil` |

### 8. `res` — line 281

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `res` — line 308

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `char_func_map` — line 344

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
