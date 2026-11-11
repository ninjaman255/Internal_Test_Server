# 📄 `ui-suppression-examples.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/ui-suppression-examples.lua`](../../../net-games/ui-suppression-examples.lua)  
> **Source lines:** 36  
> **SHA-256 (UTF-8):** `2ec9b410ab584ba8021a7fcb9d0ec341b3e2d4d9bf9aadfd3d1d1e74c5964dad`  
> **Named functions detected:** 2  
> **Table initializers detected:** 0

> **Static reference:** Function signatures, dependency paths, and event names are extracted from current Lua. The listing does not establish runtime reachability or public API exposure. See the authored guide for semantics.

## Contents
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Dependencies

| Line | `require` path |
|---:|---|
| 3 | `scripts/player-control/resources/ui-suppression` |

## Event hooks

No static literal subscriptions detected.

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 25 | `acquire` | `pid, owner, options` | assigned/declared |
| 30 | `release` | `pid, token` | assigned/declared |

### Parameter inventory

#### 1. `acquire(pid, owner, options)`

- **Line:** 25
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |
| 3 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 2. `release(pid, token)`

- **Line:** 30
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `token` | Declared directly in the current Lua. Type not inferred. |


## Tables

No simple table assignments matched.

## Net API calls

No direct Net API calls matched.
