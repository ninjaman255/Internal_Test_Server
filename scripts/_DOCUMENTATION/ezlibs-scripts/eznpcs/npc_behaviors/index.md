# 📄 `npc_behaviors.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/eznpcs/npc_behaviors.lua`](../../../../ezlibs-scripts/eznpcs/npc_behaviors.lua)  
> **Source lines:** 202  
> **SHA-256 (UTF-8):** `e39be4aa5da1a494e75e2a3b4b6d06382041d8b0765176ae9756520ae3b7373d`  
> **Named/assigned functions detected:** 6  
> **Table initializers detected:** 5

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/eznpcs/npc_behaviors.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 11 | `scripts/logger/logger` |
| 12 | `scripts/ezlibs-scripts/ezbus` |
| 13 | `scripts/ezlibs-scripts/ezcache` |
| 14 | `scripts/ezlibs-scripts/object_registry` |
| 15 | `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| 16 | `scripts/ezlibs-scripts/eznpcs/ezpushback` |
| 17 | `scripts/ezlibs-scripts/utils/eztiledutils` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 165 | `ezbus` | `npc_created_from_object` |
| 175 | `ezbus` | `npc_spawned_from_spawner` |
| 192 | `ezbus` | `bot_removed` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 26 | `key` | `area_id, behavior_object_id, bot_id` | local |
| 30 | `npc_behaviors.register` | `name, implementation` | assigned/declared |
| 40 | `attach_one` | `area_id, behavior_object, bot_id, context` | local |
| 76 | `attach_for_target` | `area_id, target_object_id, bot_id, context` | local |
| 97 | `attach` | `args` | assigned/declared |
| 125 | `npc_behaviors.attach_all` | `(none)` | assigned/declared |

### Detailed parameter inventory

#### 1. `key(area_id, behavior_object_id, bot_id)`

- **Line:** 26
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `behavior_object_id` | Declared in this function; type not inferred. |
| 3 | `bot_id` | Declared in this function; type not inferred. |

#### 2. `npc_behaviors.register(name, implementation)`

- **Line:** 30
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared in this function; type not inferred. |
| 2 | `implementation` | Declared in this function; type not inferred. |

#### 3. `attach_one(area_id, behavior_object, bot_id, context)`

- **Line:** 40
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `behavior_object` | Declared in this function; type not inferred. |
| 3 | `bot_id` | Declared in this function; type not inferred. |
| 4 | `context` | Declared in this function; type not inferred. |

#### 4. `attach_for_target(area_id, target_object_id, bot_id, context)`

- **Line:** 76
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `target_object_id` | Declared in this function; type not inferred. |
| 3 | `bot_id` | Declared in this function; type not inferred. |
| 4 | `context` | Declared in this function; type not inferred. |

#### 5. `attach(args)`

- **Line:** 97
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `args` | Declared in this function; type not inferred. |

#### 6. `npc_behaviors.attach_all()`

- **Line:** 125
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.


## Tables

| Source line | Assignment |
|---:|---|
| 19 | `npc_behaviors` |
| 20 | `implementations` |
| 21 | `objects_by_area` |
| 22 | `attached` |
| 23 | `spawned_instances` |

## Net API calls

No direct `Net.method(...)` call expression matched.
