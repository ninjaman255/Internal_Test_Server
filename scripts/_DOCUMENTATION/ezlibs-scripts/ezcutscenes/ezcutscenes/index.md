# 📄 `ezcutscenes.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezcutscenes/ezcutscenes.lua`](../../../../ezlibs-scripts/ezcutscenes/ezcutscenes.lua)  
> **Source lines:** 350  
> **SHA-256 (UTF-8):** `d517bf76df11ade7adfffcbebc7b271d321b7502d17234ebff2cddc8a8d54165`  
> **Named/assigned functions detected:** 12  
> **Table initializers detected:** 7

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-scripts/ezcutscenes/ezcutscenes.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/player-control/legacy-capture` |
| 33 | `scripts/logger/logger` |
| 34 | `scripts/ezlibs-scripts/object_registry` |
| 35 | `scripts/ezlibs-scripts/ezcache` |
| 36 | `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| 37 | `scripts/ezlibs-scripts/ezbus` |
| 38 | `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| 39 | `scripts/ezlibs-scripts/utils/eztiledutils` |
| 40 | `scripts/ezlibs-scripts/ezcutscenes/step_types` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 308 | `emitter` | `entered` |
| 322 | `Net` | `player_disconnect` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 50 | `get_props` | `object` | local |
| 54 | `resolve_object_cached` | `area_id, object_id` | local |
| 66 | `choose_next_step_ref` | `step_props, step_type_name, result` | local |
| 89 | `run_step_chain` | `context, first_step_ref` | local |
| 133 | `run_cutscene` | `player_id, area_id, cutscene_object, trigger_context` | local |
| 151 | `resolve_object` | `id` | assigned/declared |
| 206 | `ezcutscenes.start` | `player_id, area_id, cutscene_ref, trigger_context` | assigned/declared |
| 241 | `ezcutscenes.cancel` | `player_id` | assigned/declared |
| 246 | `ezcutscenes.is_active` | `player_id` | assigned/declared |
| 250 | `ezcutscenes.get_cutscene` | `area_id, name` | assigned/declared |
| 331 | `ezcutscenes.handle_player_disconnect` | `player_id` | assigned/declared |
| 339 | `ezcutscenes.handle_player_transfer` | `player_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `get_props(object)`

- **Line:** 50
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared in this function; type not inferred. |

#### 2. `resolve_object_cached(area_id, object_id)`

- **Line:** 54
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object_id` | Declared in this function; type not inferred. |

#### 3. `choose_next_step_ref(step_props, step_type_name, result)`

- **Line:** 66
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `step_props` | Declared in this function; type not inferred. |
| 2 | `step_type_name` | Declared in this function; type not inferred. |
| 3 | `result` | Declared in this function; type not inferred. |

#### 4. `run_step_chain(context, first_step_ref)`

- **Line:** 89
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `first_step_ref` | Declared in this function; type not inferred. |

#### 5. `run_cutscene(player_id, area_id, cutscene_object, trigger_context)`

- **Line:** 133
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `cutscene_object` | Declared in this function; type not inferred. |
| 4 | `trigger_context` | Declared in this function; type not inferred. |

#### 6. `resolve_object(id)`

- **Line:** 151
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared in this function; type not inferred. |

#### 7. `ezcutscenes.start(player_id, area_id, cutscene_ref, trigger_context)`

- **Line:** 206
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `cutscene_ref` | Declared in this function; type not inferred. |
| 4 | `trigger_context` | Declared in this function; type not inferred. |

#### 8. `ezcutscenes.cancel(player_id)`

- **Line:** 241
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 9. `ezcutscenes.is_active(player_id)`

- **Line:** 246
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 10. `ezcutscenes.get_cutscene(area_id, name)`

- **Line:** 250
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `name` | Declared in this function; type not inferred. |

#### 11. `ezcutscenes.handle_player_disconnect(player_id)`

- **Line:** 331
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 12. `ezcutscenes.handle_player_transfer(player_id)`

- **Line:** 339
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 42 | `ezcutscenes` |
| 44 | `registered_cutscenes` |
| 45 | `active_cutscenes` |
| 46 | `once_state` |
| 144 | `context` |
| 152 | `variables` |
| 157 | `cleanup_bot_ids` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.is_player` | 2 | 207 |
| `Net.on` | 1 | 322 |
