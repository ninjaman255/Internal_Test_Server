# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/camera/main.lua`](../../../camera/main.lua)  
> **Source lines:** 135  
> **SHA-256 (UTF-8):** `54ab6e425d78c29c3bcc8ec2370bf446c5da1275b414a946ff1794d84ea98e43`  
> **Named functions detected:** 3  
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
| 2 | `scripts/camera/camera-manager` |
| 3 | `scripts/camera/camera-controller` |
| 4 | `scripts/enum/predefined-enums` |
| 5 | `scripts/input-controller/main` |
| 6 | `scripts/player-control/main` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 21 | `Net` | `player_join` |
| 48 | `Net` | `tile_interaction` |
| 111 | `Net` | `player_area_transfer` |
| 120 | `Net` | `tick` |
| 126 | `Net` | `player_disconnect` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 10 | `dbg` | `...` | local |
| 20 | `setupPlayerJoin` | `(none)` | local |
| 47 | `setupTileInteraction` | `(none)` | local |

### Parameter inventory

#### 1. `dbg(...)`

- **Line:** 10
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `...` | Declared directly in the current Lua. Type not inferred. |

#### 2. `setupPlayerJoin()`

- **Line:** 20
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 3. `setupTileInteraction()`

- **Line:** 47
- **Declaration:** local
- **Parameters:** none explicitly declared.


## Tables

No simple table assignments matched.

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.on` | 5 | 21 |
