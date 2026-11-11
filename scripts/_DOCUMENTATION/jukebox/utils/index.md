# 📄 `utils.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/jukebox/utils.lua`](../../../jukebox/utils.lua)  
> **Source lines:** 69  
> **SHA-256 (UTF-8):** `dc439c04e2015e4f252b3b9c944356847f838e03cc3e602c9c015d494e342b4d`  
> **Named/assigned functions detected:** 3  
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

Current source inventory for `scripts/jukebox/utils.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/logger/logger` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 5 | `utils.get_os` | `(none)` | assigned/declared |
| 15 | `utils.listFiles` | `directory` | assigned/declared |
| 39 | `utils.listDirectories` | `directory` | assigned/declared |

### Detailed parameter inventory

#### 1. `utils.get_os()`

- **Line:** 5
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 2. `utils.listFiles(directory)`

- **Line:** 15
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `directory` | Declared in this function; type not inferred. |

#### 3. `utils.listDirectories(directory)`

- **Line:** 39
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `directory` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 2 | `utils` |
| 17 | `songTable` |
| 40 | `directories` |

## Net API calls

No direct `Net.method(...)` call expression matched.
