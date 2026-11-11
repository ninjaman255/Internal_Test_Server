# 📄 `main.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/boom/main.lua`](../../../boom/main.lua)  
> **Source lines:** 252  
> **SHA-256 (UTF-8):** `17ef6279a1af15…`  
> **Declared/assigned functions detected:** 16  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 8

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

Source-based reference for `scripts/boom/main.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 10 | `warn` | `message` | local |
| 16 | `cleanstr` | `value` | local |
| 25 | `parse_attributes` | `line, convert_numbers, frame_rate` | local |
| 71 | `valid_state` | `animation, state_name, operation` | local |
| 81 | `make_animation` | `version` | local |
| 83 | `animation.get_state` | `self, name` | declared |
| 89 | `animation.get_frame` | `self, name, frame_index` | declared |
| 97 | `animation.get_point` | `self, name, frame_index, label` | declared |
| 105 | `animation.duration` | `self, name` | declared |
| 115 | `animation.get_duration` | `self, name` | declared |
| 116 | `animation.refresh` | `self, name` | declared |
| 122 | `animation.update` | `self, name, seconds` | declared |
| 143 | `read_lines` | `path` | local |
| 161 | `parse_v20` | `lines, path` | local |
| 196 | `parse_v25` | `lines, path` | local |
| 236 | `boom.load` | `path` | declared |

### Function details

#### 1. `warn(message)`

- **Location:** source line 10.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 2. `cleanstr(value)`

- **Location:** source line 16.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 3. `parse_attributes(line, convert_numbers, frame_rate)`

- **Location:** source line 25.
- **Declaration style:** `local`.
- **Adjacent source comment:** Parse key=value attributes while preserving quoted values containing spaces.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `line` | Not explicitly documented in adjacent source annotations. |
| 2 | `convert_numbers` | Not explicitly documented in adjacent source annotations. |
| 3 | `frame_rate` | Not explicitly documented in adjacent source annotations. |

#### 4. `valid_state(animation, state_name, operation)`

- **Location:** source line 71.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `animation` | Not explicitly documented in adjacent source annotations. |
| 2 | `state_name` | Not explicitly documented in adjacent source annotations. |
| 3 | `operation` | Not explicitly documented in adjacent source annotations. |

#### 5. `make_animation(version)`

- **Location:** source line 81.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `version` | Not explicitly documented in adjacent source annotations. |

#### 6. `animation.get_state(self, name)`

- **Location:** source line 83.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |

#### 7. `animation.get_frame(self, name, frame_index)`

- **Location:** source line 89.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |
| 3 | `frame_index` | Not explicitly documented in adjacent source annotations. |

#### 8. `animation.get_point(self, name, frame_index, label)`

- **Location:** source line 97.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |
| 3 | `frame_index` | Not explicitly documented in adjacent source annotations. |
| 4 | `label` | Not explicitly documented in adjacent source annotations. |

#### 9. `animation.duration(self, name)`

- **Location:** source line 105.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |

#### 10. `animation.get_duration(self, name)`

- **Location:** source line 115.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |

#### 11. `animation.refresh(self, name)`

- **Location:** source line 116.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |

#### 12. `animation.update(self, name, seconds)`

- **Location:** source line 122.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |
| 3 | `seconds` | Not explicitly documented in adjacent source annotations. |

#### 13. `read_lines(path)`

- **Location:** source line 143.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `path` | Not explicitly documented in adjacent source annotations. |

#### 14. `parse_v20(lines, path)`

- **Location:** source line 161.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `lines` | Not explicitly documented in adjacent source annotations. |
| 2 | `path` | Not explicitly documented in adjacent source annotations. |

#### 15. `parse_v25(lines, path)`

- **Location:** source line 196.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `lines` | Not explicitly documented in adjacent source annotations. |
| 2 | `path` | Not explicitly documented in adjacent source annotations. |

#### 16. `boom.load(path)`

- **Location:** source line 236.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `path` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **8** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `boom` — line 8

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `result` — line 26

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `animation` — line 82

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `states` | nested table | `{}` |
| `elapsed` | numeric literal | `0` |
| `imagePath` | string literal | `""` |
| `currFrame` | nested table | `{}` |
| `version` | expression/reference | `version` |
| `format_version` | expression/reference | `version` |
| `frame_rate` | numeric literal | `60` |

### 4. `states` — line 82

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `currFrame` — line 82

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `lines` — line 155

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `framelist` — line 176

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `framelist` — line 213

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
