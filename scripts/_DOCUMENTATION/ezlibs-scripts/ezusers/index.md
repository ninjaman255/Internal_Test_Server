# 📄 `ezusers.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezusers.lua`](../../../ezlibs-scripts/ezusers.lua)  
> **Source lines:** 346  
> **SHA-256 (UTF-8):** `a99532b17326369c5e5a090509d48b0853f773055eb39517c215ec3f8372b3b7`  
> **Named/assigned functions detected:** 15  
> **Table initializers detected:** 10

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezusers.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 8 | `scripts/logger/logger` |
| 9 | `scripts/ezlibs-scripts/helpers` |
| 10 | `scripts/ezlibs-scripts/ezmemory` |
| 11 | `scripts/ezlibs-scripts/sha256` |
| 12 | `scripts/ezlibs-scripts/ezconfig` |
| 302 | `scripts/ezlibs-scripts/object_registry` |
| 303 | `scripts/ezlibs-scripts/eztriggers/eztriggers` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 309 | `emitter` | `interaction` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 65 | `async` | `p` | local |
| 70 | `await` | `v` | local |
| 75 | `deep_copy` | `orig` | local |
| 91 | `get_safe_secret` | `player_id` | local |
| 100 | `get_role` | `player_id` | assigned/declared |
| 115 | `assign_role` | `player_id, role` | assigned/declared |
| 135 | `get_user_permissions` | `player_id` | assigned/declared |
| 151 | `set_user_permission` | `player_id, permission_path, value` | assigned/declared |
| 187 | `reset_user_permissions` | `player_id` | assigned/declared |
| 201 | `has_permission` | `player_id, permission_path` | assigned/declared |
| 232 | `check_password_and_grant_admin` | `player_id, password_attempt` | assigned/declared |
| 245 | `add_role` | `role_name, permission_table` | assigned/declared |
| 252 | `update_permissions` | `role_name, permission_updates` | assigned/declared |
| 270 | `handle_player_join` | `player_id` | assigned/declared |
| 295 | `handle_player_disconnect` | `player_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `async(p)`

- **Line:** 65
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `p` | Declared in this function; type not inferred. |

#### 2. `await(v)`

- **Line:** 70
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `v` | Declared in this function; type not inferred. |

#### 3. `deep_copy(orig)`

- **Line:** 75
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `orig` | Declared in this function; type not inferred. |

#### 4. `get_safe_secret(player_id)`

- **Line:** 91
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 5. `get_role(player_id)`

- **Line:** 100
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 6. `assign_role(player_id, role)`

- **Line:** 115
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `role` | Declared in this function; type not inferred. |

#### 7. `get_user_permissions(player_id)`

- **Line:** 135
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 8. `set_user_permission(player_id, permission_path, value)`

- **Line:** 151
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `permission_path` | Declared in this function; type not inferred. |
| 3 | `value` | Declared in this function; type not inferred. |

#### 9. `reset_user_permissions(player_id)`

- **Line:** 187
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 10. `has_permission(player_id, permission_path)`

- **Line:** 201
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `permission_path` | Declared in this function; type not inferred. |

#### 11. `check_password_and_grant_admin(player_id, password_attempt)`

- **Line:** 232
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `password_attempt` | Declared in this function; type not inferred. |

#### 12. `add_role(role_name, permission_table)`

- **Line:** 245
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `role_name` | Declared in this function; type not inferred. |
| 2 | `permission_table` | Declared in this function; type not inferred. |

#### 13. `update_permissions(role_name, permission_updates)`

- **Line:** 252
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `role_name` | Declared in this function; type not inferred. |
| 2 | `permission_updates` | Declared in this function; type not inferred. |

#### 14. `handle_player_join(player_id)`

- **Line:** 270
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 15. `handle_player_disconnect(player_id)`

- **Line:** 295
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 29 | `permissions` |
| 30 | `user` |
| 31 | `BBS` |
| 38 | `Commands` |
| 42 | `admin` |
| 43 | `BBS` |
| 50 | `Commands` |
| 79 | `copy` |
| 163 | `path` |
| 208 | `path` |

## Net API calls

No direct `Net.method(...)` call expression matched.
