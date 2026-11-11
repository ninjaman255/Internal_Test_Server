# 📄 `ui-suppression.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/player-control/resources/ui-suppression.lua`](../../../../player-control/resources/ui-suppression.lua)  
> **Source lines:** 128  
> **SHA-256 (UTF-8):** `b1f0e2efffc89d22a191b2f446ff3ce420165f84a23e35d60b981113f2d223e7`  
> **Named functions detected:** 14  
> **Table initializers detected:** 11

> **Static reference:** Function signatures, dependency paths, and event names are extracted from current Lua. The listing does not establish runtime reachability or public API exposure. See the authored guide for semantics.

## Contents
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Dependencies

No literal `require` calls detected.

## Event hooks

No static literal subscriptions detected.

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 6 | `state_for` | `store, pid` | local |
| 10 | `net_call` | `name, pid` | local |
| 17 | `acquire_engine` | `store, pid, owner, kind, fn_name` | local |
| 30 | `M.acquire_engine_hud` | `pid, owner` | assigned/declared |
| 35 | `M.acquire_input_lock` | `pid, owner` | assigned/declared |
| 38 | `M.register_handler` | `name, handler` | assigned/declared |
| 42 | `M.acquire_element` | `pid, name, owner, options` | assigned/declared |
| 52 | `M.release` | `h` | assigned/declared |
| 88 | `M.register_profile` | `name, entries` | assigned/declared |
| 92 | `M.acquire_profile` | `pid, name, owner, options` | assigned/declared |
| 109 | `M.release_profile` | `b` | assigned/declared |
| 116 | `M.cleanup_player` | `pid` | assigned/declared |
| 121 | `M.get_debug_state` | `pid` | assigned/declared |
| 122 | `summary` | `s` | local |

### Parameter inventory

#### 1. `state_for(store, pid)`

- **Line:** 6
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `store` | Declared directly in the current Lua. Type not inferred. |
| 2 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 2. `net_call(name, pid)`

- **Line:** 10
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared directly in the current Lua. Type not inferred. |
| 2 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 3. `acquire_engine(store, pid, owner, kind, fn_name)`

- **Line:** 17
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `store` | Declared directly in the current Lua. Type not inferred. |
| 2 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 3 | `owner` | Declared directly in the current Lua. Type not inferred. |
| 4 | `kind` | Declared directly in the current Lua. Type not inferred. |
| 5 | `fn_name` | Declared directly in the current Lua. Type not inferred. |

#### 4. `M.acquire_engine_hud(pid, owner)`

- **Line:** 30
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |

#### 5. `M.acquire_input_lock(pid, owner)`

- **Line:** 35
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `owner` | Declared directly in the current Lua. Type not inferred. |

#### 6. `M.register_handler(name, handler)`

- **Line:** 38
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared directly in the current Lua. Type not inferred. |
| 2 | `handler` | Declared directly in the current Lua. Type not inferred. |

#### 7. `M.acquire_element(pid, name, owner, options)`

- **Line:** 42
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `name` | Declared directly in the current Lua. Type not inferred. |
| 3 | `owner` | Declared directly in the current Lua. Type not inferred. |
| 4 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 8. `M.release(h)`

- **Line:** 52
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `h` | Declared directly in the current Lua. Type not inferred. |

#### 9. `M.register_profile(name, entries)`

- **Line:** 88
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared directly in the current Lua. Type not inferred. |
| 2 | `entries` | Declared directly in the current Lua. Type not inferred. |

#### 10. `M.acquire_profile(pid, name, owner, options)`

- **Line:** 92
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |
| 2 | `name` | Declared directly in the current Lua. Type not inferred. |
| 3 | `owner` | Declared directly in the current Lua. Type not inferred. |
| 4 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 11. `M.release_profile(b)`

- **Line:** 109
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `b` | Declared directly in the current Lua. Type not inferred. |

#### 12. `M.cleanup_player(pid)`

- **Line:** 116
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 13. `M.get_debug_state(pid)`

- **Line:** 121
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `pid` | Declared directly in the current Lua. Type not inferred. |

#### 14. `summary(s)`

- **Line:** 122
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `s` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 3 | `M` |
| 26 | `h` |
| 48 | `h` |
| 82 | `profiles` |
| 83 | `menu` |
| 84 | `cinematic` |
| 85 | `engine_hud_only` |
| 86 | `input_locked` |
| 95 | `b` |
| 117 | `list` |
| 123 | `r` |

## Net API calls

No direct Net API calls matched.
