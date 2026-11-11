# 📄 `ezdebug.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/utils/ezdebug.lua`](../../../../ezlibs-scripts/utils/ezdebug.lua)  
> **Source lines:** 47  
> **SHA-256 (UTF-8):** `bfba714f54929e…`  
> **Declared/assigned functions detected:** 6  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 2

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

Small logger wrapper. By default it writes to standard output. Host-specific logging can be supplied as a callback.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 11 | `ezdebug.configure` | `options` | declared |
| 28 | `write` | `level, ...` | local |
| 39 | `ezdebug.info` | `...` | declared |
| 40 | `ezdebug.warn` | `...` | declared |
| 41 | `ezdebug.error` | `...` | declared |
| 43 | `ezdebug.traceback` | `message, level` | declared |

### Function details

#### 1. `ezdebug.configure(options)`

- **Location:** source line 11.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `options` | Not explicitly documented in adjacent source annotations. |

#### 2. `write(level, ...)`

- **Location:** source line 28.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `level` | Not explicitly documented in adjacent source annotations. |
| 2 | `...` | Not explicitly documented in adjacent source annotations. |

#### 3. `ezdebug.info(...)`

- **Location:** source line 39.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 4. `ezdebug.warn(...)`

- **Location:** source line 40.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 5. `ezdebug.error(...)`

- **Location:** source line 41.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `...` | Not explicitly documented in adjacent source annotations. |

#### 6. `ezdebug.traceback(message, level)`

- **Location:** source line 43.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |
| 2 | `level` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **2** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `ezdebug` — line 5

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `enabled` | boolean literal | `true` |
| `prefix` | string literal | `"[ezlibs]"` |
| `sink` | expression/reference | `print` |

### 2. `parts` — line 31

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
