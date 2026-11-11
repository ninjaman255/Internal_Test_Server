# 📄 `panel_registry.lua`

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/nebulous-liberations/liberations/panel_registry.lua`](../../../../../ezlibs-custom/nebulous-liberations/liberations/panel_registry.lua)  
> **Source lines:** 98  
> **SHA-256 (UTF-8):** `d6a830cd3aff13…`  
> **Declared/assigned functions detected:** 7  
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

Source-based reference for `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_registry.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 2 | `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 12 | `PanelRegistry.register` | `type_name, definition` | declared |
| 53 | `PanelRegistry.get_type_by_gid` | `gid` | declared |
| 58 | `PanelRegistry.get_definition` | `type_name` | declared |
| 63 | `PanelRegistry.is_type` | `gid, type_name` | declared |
| 69 | `PanelRegistry.is_liberatable` | `gid` | declared |
| 79 | `PanelRegistry.is_walkable` | `gid` | declared |
| 89 | `PanelRegistry.is_shadowstep` | `gid` | declared |

### Function details

#### 1. `PanelRegistry.register(type_name, definition)`

- **Location:** source line 12.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Register a panel type

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `type_name` | Not explicitly documented in adjacent source annotations. |
| 2 | `definition` | Not explicitly documented in adjacent source annotations. |

#### 2. `PanelRegistry.get_type_by_gid(gid)`

- **Location:** source line 53.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Get panel type by GID

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `gid` | Not explicitly documented in adjacent source annotations. |

#### 3. `PanelRegistry.get_definition(type_name)`

- **Location:** source line 58.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Get definition by type name

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `type_name` | Not explicitly documented in adjacent source annotations. |

#### 4. `PanelRegistry.is_type(gid, type_name)`

- **Location:** source line 63.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Check if a GID corresponds to a specific panel type

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `gid` | Not explicitly documented in adjacent source annotations. |
| 2 | `type_name` | Not explicitly documented in adjacent source annotations. |

#### 5. `PanelRegistry.is_liberatable(gid)`

- **Location:** source line 69.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Check if a panel is liberatable

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `gid` | Not explicitly documented in adjacent source annotations. |

#### 6. `PanelRegistry.is_walkable(gid)`

- **Location:** source line 79.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Check if a panel is walkable (for enemies)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `gid` | Not explicitly documented in adjacent source annotations. |

#### 7. `PanelRegistry.is_shadowstep(gid)`

- **Location:** source line 89.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Check if a panel triggers shadowstep

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `gid` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **6** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `PanelRegistry` — line 4

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `PanelRegistry.by_type` — line 7

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `PanelRegistry.gid_to_type` — line 8

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `PanelRegistry.type_gids` — line 9

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `registered` — line 18

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `type` | expression/reference | `type_name` |
| `gids` | nested table | `{}` |

### 6. `gids` — line 18

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
