# 📄 `lib.lua` — Refreshed Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/avatar_utils/lua_yes_parser/lib.lua`](../../../../avatar_utils/lua_yes_parser/lib.lua)  
> **Source lines:** 53  
> **SHA-256 (UTF-8):** `a707d6885f02cec857ad71a56175b9e560ec1a3ae1efc2fa4c82479d1247fc55`  
> **Named/assigned functions detected:** 3  
> **Table initializers detected (simple pattern):** 6

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/avatar_utils/lua_yes_parser/lib.lua` from the latest overlaid server archive.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/avatar_utils/lua_yes_parser/src/enums` |
| 2 | `scripts/avatar_utils/lua_yes_parser/src/element` |

## Event hooks

No named `.on`/`:on` events detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 6 | `Collector.new` | `(none)` | assigned/declared |
| 14 | `self.handleLine` | `line` | assigned/declared |
| 40 | `parse` | `path` | local |

### Detailed parameter inventory

#### 1. `Collector.new()`

- **Line:** 6
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 2. `self.handleLine(line)`

- **Line:** 14
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `line` | Declared by this function; type not inferred. |

#### 3. `parse(path)`

- **Line:** 40
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 4 | `Collector` |
| 7 | `self` |
| 9 | `pendingAttrs` |
| 10 | `elements` |
| 11 | `errors` |
| 31 | `self.pendingAttrs` |

## Net API calls

No direct `Net.method(...)` call expression matched.
