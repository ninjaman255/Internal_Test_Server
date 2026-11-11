# 📄 `default_spawn_guard.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezwarps/default_spawn_guard.lua`](../../../../ezlibs-scripts/ezwarps/default_spawn_guard.lua)  
> **Source lines:** 125  
> **SHA-256 (UTF-8):** `27351ce112eaec899ba943abc9c3f47b2d0a079be8d06fdea9059426c5b74380`  
> **Named/assigned functions detected:** 6  
> **Table initializers detected:** 1

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezwarps/default_spawn_guard.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 11 | `scripts/logger/logger` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 18 | `read_net` | `method, ...` | local |
| 27 | `valid_position` | `value` | local |
| 34 | `at_empty_default_origin` | `pos` | local |
| 40 | `fallback_position` | `(none)` | local |
| 52 | `Guard.ensure_default_spawn` | `(none)` | assigned/declared |
| 83 | `Guard.recover_new_arrival` | `player_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `read_net(method, ...)`

- **Line:** 18
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `method` | Declared in this function; type not inferred. |
| 2 | `...` | Declared in this function; type not inferred. |

#### 2. `valid_position(value)`

- **Line:** 27
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |

#### 3. `at_empty_default_origin(pos)`

- **Line:** 34
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pos` | Declared in this function; type not inferred. |

#### 4. `fallback_position()`

- **Line:** 40
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 5. `Guard.ensure_default_spawn()`

- **Line:** 52
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 6. `Guard.recover_new_arrival(player_id)`

- **Line:** 83
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 12 | `Guard` |

## Net API calls

No direct `Net.method(...)` call expression matched.
