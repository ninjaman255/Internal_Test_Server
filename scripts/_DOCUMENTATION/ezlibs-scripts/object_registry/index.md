# 📄 `object_registry.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/object_registry.lua`](../../../ezlibs-scripts/object_registry.lua)  
> **Source lines:** 58  
> **SHA-256 (UTF-8):** `4f1f27ef75dd8555c50841674cbfa38303b3dfcf5efcdfd5148f2b712e4e9466`  
> **Named/assigned functions detected:** 2  
> **Table initializers detected:** 3

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/object_registry.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |
| 2 | `scripts/ezlibs-scripts/ezcache` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 13 | `object_registry.register_handler` | `object_type, callback, cache` | assigned/declared |
| 30 | `object_registry.load_all` | `(none)` | assigned/declared |

### Detailed parameter inventory

#### 1. `object_registry.register_handler(object_type, callback, cache)`

- **Line:** 13
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object_type` | Declared in this function; type not inferred. |
| 2 | `callback` | Declared in this function; type not inferred. |
| 3 | `cache` | Declared in this function; type not inferred. |

#### 2. `object_registry.load_all()`

- **Line:** 30
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.


## Tables

| Source line | Assignment |
|---:|---|
| 4 | `object_registry` |
| 5 | `handlers` |
| 6 | `types_to_cache` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.get_object_by_id` | 1 | 38 |
| `Net.list_areas` | 1 | 34 |
| `Net.list_objects` | 1 | 36 |
