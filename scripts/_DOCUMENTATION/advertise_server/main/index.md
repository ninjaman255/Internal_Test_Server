# 📄 `main.lua`

> ⚠️ **Archive-only reference:** The source file `scripts/advertise_server/main.lua` is absent from the current server archive; the extracted functions/tables below are retained solely as historical reference, not as current runtime API.

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Historical source:** `scripts/advertise_server/main.lua` (not present in the current server ZIP).  
> **Source lines:** 222  
> **SHA-256 (UTF-8):** `711748ef55540c…`  
> **Declared/assigned functions detected:** 15  
> **Anonymous closures detected:** 8  
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

Source-based reference for `scripts/advertise_server/main.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 1 | `scripts/advertise_server/json` |
| 2 | `scripts/advertise_server/base64` |
| 3 | `scripts/advertise_server/urlencode` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 39 | `Net:on` | `player_connect` |
| 44 | `Net:on` | `player_disconnect` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 19 | `async` | `p` | local |
| 23 | `await` | `v` | local |
| 24 | `load_image_data` | `path` | local |
| 31 | `save_image_data` | `path,data` | local |
| 49 | `set_pending_field_for_all_servers` | `field_name,value` | declared |
| 55 | `set_pending_field` | `server_id,field_name,value` | declared |
| 63 | `clear_pending_fields` | `server_id` | declared |
| 67 | `build_payload` | `server_id` | declared |
| 79 | `get_secret_key` | `server_id,listserver_name` | declared |
| 89 | `save_secret_key` | `file_path,server_id,listserver_name,secret_key` | declared |
| 102 | `sync_to_servers` | `server_id` | declared |
| 127 | `read_json` | `file_path` | local |
| 140 | `load_all_images_for_advertisements` | `advertisements` | local |
| 152 | `initialize_pending_fields_from_advertisements` | `advertisements` | local |
| 163 | `build_server_map` | `(none)` | local |

### Function details

#### 1. `async(p)`

- **Location:** source line 19.
- **Declaration style:** `local`.
- **Adjacent source comment:** shorthands for async stuff.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |

#### 2. `await(v)`

- **Location:** source line 23.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `v` | Not explicitly documented in adjacent source annotations. |

#### 3. `load_image_data(path)`

- **Location:** source line 24.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `path` | Not explicitly documented in adjacent source annotations. |

#### 4. `save_image_data(path,data)`

- **Location:** source line 31.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `path` | Not explicitly documented in adjacent source annotations. |
| 2 | `data` | Not explicitly documented in adjacent source annotations. |

#### 5. `set_pending_field_for_all_servers(field_name,value)`

- **Location:** source line 49.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `field_name` | Not explicitly documented in adjacent source annotations. |
| 2 | `value` | Not explicitly documented in adjacent source annotations. |

#### 6. `set_pending_field(server_id,field_name,value)`

- **Location:** source line 55.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `server_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `field_name` | Not explicitly documented in adjacent source annotations. |
| 3 | `value` | Not explicitly documented in adjacent source annotations. |

#### 7. `clear_pending_fields(server_id)`

- **Location:** source line 63.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `server_id` | Not explicitly documented in adjacent source annotations. |

#### 8. `build_payload(server_id)`

- **Location:** source line 67.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `server_id` | Not explicitly documented in adjacent source annotations. |

#### 9. `get_secret_key(server_id,listserver_name)`

- **Location:** source line 79.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `server_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `listserver_name` | Not explicitly documented in adjacent source annotations. |

#### 10. `save_secret_key(file_path,server_id,listserver_name,secret_key)`

- **Location:** source line 89.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `file_path` | Not explicitly documented in adjacent source annotations. |
| 2 | `server_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `listserver_name` | Not explicitly documented in adjacent source annotations. |
| 4 | `secret_key` | Not explicitly documented in adjacent source annotations. |

#### 11. `sync_to_servers(server_id)`

- **Location:** source line 102.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `server_id` | Not explicitly documented in adjacent source annotations. |

#### 12. `read_json(file_path)`

- **Location:** source line 127.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `file_path` | Not explicitly documented in adjacent source annotations. |

#### 13. `load_all_images_for_advertisements(advertisements)`

- **Location:** source line 140.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `advertisements` | Not explicitly documented in adjacent source annotations. |

#### 14. `initialize_pending_fields_from_advertisements(advertisements)`

- **Location:** source line 152.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `advertisements` | Not explicitly documented in adjacent source annotations. |

#### 15. `build_server_map()`

- **Location:** source line 163.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 39 | `event` | `f:write(data) f:flush() f:close() end --Event handlers Net:on("player_connect",` |
| 44 | `event` | `ng_field_for_all_servers("online_players",online_players) end) Net:on("player_discon…` |
| 90 | `(none)` | `function save_secret_key(file_path,server_id,listserver_name,secret_key) return asyn…` |
| 103 | `(none)` | `.encode(secret_keys))) end) end function sync_to_servers(server_id) return async(` |
| 128 | `(none)` | `st_sync[server_id] = 0 end) end local function read_json(file_path) return async(` |
| 130 | `(none)` | `ion read_json(file_path) return async(function () local data = {} pcall(` |
| 141 | `(none)` | `d) end local function load_all_images_for_advertisements(advertisements) return asyn…` |
| 193 | `(none)` | `end end end return server_map end --load configuration async(` |

## 📦 Tables and data

The following **14** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `public_info` — line 10

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `pending_fields` | nested table | `{}` |
| `time_since_last_sync` | nested table | `{}` |

### 2. `pending_fields` — line 11

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `time_since_last_sync` — line 12

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `listservers` — line 14

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `secret_keys` — line 15

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `server_ids` — line 16

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `payload` — line 68

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `server_id` | expression/reference | `server_id` |
| `fields` | nested table | `{}` |

### 8. `fields` — line 70

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `headers` — line 106

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `data` — line 129

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `data` — line 133

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `server_map` — line 164

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `l` — line 171

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 14. `r` — line 172

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.await` | 1 |
| `Async.promisify` | 1 |
| `Async.read_file` | 1 |
| `Async.request` | 1 |
| `Async.sleep` | 1 |
| `Async.write_file` | 1 |
| `Net.get_area_custom_properties` | 1 |
| `Net.get_object_by_id` | 1 |
| `Net.list_areas` | 1 |
| `Net.list_objects` | 1 |
| `Net.on` | 2 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
