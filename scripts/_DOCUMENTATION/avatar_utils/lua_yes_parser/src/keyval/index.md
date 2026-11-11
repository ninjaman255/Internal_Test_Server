# 📄 `keyval.lua` — Refreshed Lua reference

[🏠 Documentation home](../../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/avatar_utils/lua_yes_parser/src/keyval.lua`](../../../../../avatar_utils/lua_yes_parser/src/keyval.lua)  
> **Source lines:** 22  
> **SHA-256 (UTF-8):** `fba4b30476d2ab11479db59adec7c4860d96aef6e97607a2ef0daee8ec713791`  
> **Named/assigned functions detected:** 2  
> **Table initializers detected (simple pattern):** 3

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/avatar_utils/lua_yes_parser/src/keyval.lua` from the latest overlaid server archive.

## Dependencies

No statically identified literal `require` module strings.

## Event hooks

No named `.on`/`:on` events detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 2 | `KeyVal.new` | `key, val` | assigned/declared |
| 8 | `__tostring` | `self` | local |

### Detailed parameter inventory

#### 1. `KeyVal.new(key, val)`

- **Line:** 2
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |
| 2 | `val` | Declared by this function; type not inferred. |

#### 2. `__tostring(self)`

- **Line:** 8
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 1 | `KeyVal` |
| 3 | `this` |
| 16 | `mt` |

## Net API calls

No direct `Net.method(...)` call expression matched.
