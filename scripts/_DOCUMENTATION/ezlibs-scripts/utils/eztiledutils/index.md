# 📄 `eztiledutils.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/utils/eztiledutils.lua`](../../../../ezlibs-scripts/utils/eztiledutils.lua)  
> **Source lines:** 316  
> **SHA-256 (UTF-8):** `e842ed7591a00b…`  
> **Declared/assigned functions detected:** 15  
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

Shared helpers for Tiled property access. Replaces local helpers in: * eznpcs.lua / eznpcs/dialogue_types.lua (is_property_true) * FootBomb (as_string / as_number) * ezpushback.lua (truthy / number_property)

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 33 | `M.is_true` | `value, default` | declared |
| 51 | `M.to_number` | `value, default` | declared |
| 65 | `M.to_string` | `value, default` | declared |
| 80 | `raw_lookup` | `obj, name` | local |
| 121 | `M.get_property` | `obj, name, default` | declared |
| 127 | `M.get_string` | `obj, name, default` | declared |
| 131 | `M.get_number` | `obj, name, default` | declared |
| 135 | `M.get_boolean` | `obj, name, default` | declared |
| 148 | `M.get_object_reference` | `obj, name, resolver, default` | declared |
| 160 | `M.get_class_or_type` | `obj` | declared |
| 174 | `M.get_string_from` | `props, name, default` | declared |
| 179 | `M.get_number_from` | `props, name, default` | declared |
| 184 | `M.get_boolean_from` | `props, name, default` | declared |
| 194 | `M.normalize_properties` | `obj` | declared |
| 240 | `M.validate_properties` | `obj, schema_props, enums` | declared |

### Function details

#### 1. `M.is_true(value, default)`

- **Location:** source line 33.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Canonical boolean normalizer.  true / "true" / "1" / "yes" / "on" / non-zero number -> true false / "false" / "0" / "no" / "off" / "" / 0        -> false nil                                                  -> default (false if omitted)  After validate_properties() succeeds against a class schema, booleans are guaranteed to be real booleans or the string forms above, so the liberal handling here is a safety net for optional properties and for call sites that bypass validation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `default` | Not explicitly documented in adjacent source annotations. |

#### 2. `M.to_number(value, default)`

- **Location:** source line 51.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Strict number parsing. Matches FootBomb as_number and ezpushback number_property: returns default on non-numbers and unparseable strings.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `default` | Not explicitly documented in adjacent source annotations. |

#### 3. `M.to_string(value, default)`

- **Location:** source line 65.
- **Declaration style:** `declared`.
- **Adjacent source comment:** String normalization. Numbers and booleans become their string form; tables and nil return default.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `default` | Not explicitly documented in adjacent source annotations. |

#### 4. `raw_lookup(obj, name)`

- **Location:** source line 80.
- **Declaration style:** `local`.
- **Adjacent source comment:** Return the runtime value for `name` on `obj`, or nil. custom_properties wins when it has the field; otherwise falls through to the older .properties shape (array-of-entries or map-of-{value=,type=}).

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `obj` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |

#### 5. `M.get_property(obj, name, default)`

- **Location:** source line 121.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `obj` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |
| 3 | `default` | Not explicitly documented in adjacent source annotations. |

#### 6. `M.get_string(obj, name, default)`

- **Location:** source line 127.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `obj` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |
| 3 | `default` | Not explicitly documented in adjacent source annotations. |

#### 7. `M.get_number(obj, name, default)`

- **Location:** source line 131.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `obj` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |
| 3 | `default` | Not explicitly documented in adjacent source annotations. |

#### 8. `M.get_boolean(obj, name, default)`

- **Location:** source line 135.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `obj` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |
| 3 | `default` | Not explicitly documented in adjacent source annotations. |

#### 9. `M.get_object_reference(obj, name, resolver, default)`

- **Location:** source line 148.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Resolve an object reference stored as an ID.  resolver: function(id) -> object\|nil  (typically function(id) return ezcache.get_object_by_id_cached(area_id, id) end)  Returns (resolved_object, true) on success. Returns (default, false) if the property is nil or "" (Tiled convention for "no reference" — matches prop("X", "object", "") in the generator). Returns (raw_id, false) if a resolver was not given or the resolver missed.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `obj` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |
| 3 | `resolver` | Not explicitly documented in adjacent source annotations. |
| 4 | `default` | Not explicitly documented in adjacent source annotations. |

#### 10. `M.get_class_or_type(obj)`

- **Location:** source line 160.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Tiled 1.9+ uses .class; older Tiled data and various loaders use .type.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `obj` | Not explicitly documented in adjacent source annotations. |

#### 11. `M.get_string_from(props, name, default)`

- **Location:** source line 174.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `props` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |
| 3 | `default` | Not explicitly documented in adjacent source annotations. |

#### 12. `M.get_number_from(props, name, default)`

- **Location:** source line 179.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `props` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |
| 3 | `default` | Not explicitly documented in adjacent source annotations. |

#### 13. `M.get_boolean_from(props, name, default)`

- **Location:** source line 184.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `props` | Not explicitly documented in adjacent source annotations. |
| 2 | `name` | Not explicitly documented in adjacent source annotations. |
| 3 | `default` | Not explicitly documented in adjacent source annotations. |

#### 14. `M.normalize_properties(obj)`

- **Location:** source line 194.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Normalize an object's properties into a flat name -> value map.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `obj` | Not explicitly documented in adjacent source annotations. |

#### 15. `M.validate_properties(obj, schema_props, enums)`

- **Location:** source line 240.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Validate an object against an array of schema property definitions (the .members array from ezlibs-tiled-schema.lua).  schema_props: { {name=, type=, value=, propertyType=, required=, ...}, ... } enums:        optional { [name] = { values = {...} } }  Returns (ok, report). report = { errors  = { {name, issue, expected, got}, ... }, values  = { name -> coerced value },   -- includes defaults missing = { name, ... }, }

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `obj` | Not explicitly documented in adjacent source annotations. |
| 2 | `schema_props` | Not explicitly documented in adjacent source annotations. |
| 3 | `enums` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **6** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `M` — line 17

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `out` — line 195

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `report` — line 241

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `errors` | nested table | `{}` |
| `values` | nested table | `{}` |
| `missing` | nested table | `{}` |

### 4. `errors` — line 241

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `values` — line 241

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `missing` — line 241

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
