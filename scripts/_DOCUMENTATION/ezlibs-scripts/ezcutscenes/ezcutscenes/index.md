# 📄 `ezcutscenes.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezcutscenes/ezcutscenes.lua`](../../../../ezlibs-scripts/ezcutscenes/ezcutscenes.lua)  
> **Source lines:** 350  
> **SHA-256 (UTF-8):** `7c5821ec12d591479c01dc1001e3dc0d779e99a011897b1e009efaa3b8c04e48`  
> **Named functions detected:** 12  
> **Table initializers detected:** 7

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
| 1 | `scripts/player-control/main` |
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

## Functions and parameters

| Line | Function | Arguments | Declaration |
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

### Parameter inventory

#### 1. `get_props(object)`

- **Line:** 50
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared directly in the current Lua. Type not inferred. |

#### 2. `resolve_object_cached(area_id, object_id)`

- **Line:** 54
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |

#### 3. `choose_next_step_ref(step_props, step_type_name, result)`

- **Line:** 66
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `step_props` | Declared directly in the current Lua. Type not inferred. |
| 2 | `step_type_name` | Declared directly in the current Lua. Type not inferred. |
| 3 | `result` | Declared directly in the current Lua. Type not inferred. |

#### 4. `run_step_chain(context, first_step_ref)`

- **Line:** 89
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared directly in the current Lua. Type not inferred. |
| 2 | `first_step_ref` | Declared directly in the current Lua. Type not inferred. |

#### 5. `run_cutscene(player_id, area_id, cutscene_object, trigger_context)`

- **Line:** 133
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `cutscene_object` | Declared directly in the current Lua. Type not inferred. |
| 4 | `trigger_context` | Declared directly in the current Lua. Type not inferred. |

#### 6. `resolve_object(id)`

- **Line:** 151
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared directly in the current Lua. Type not inferred. |

#### 7. `ezcutscenes.start(player_id, area_id, cutscene_ref, trigger_context)`

- **Line:** 206
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `cutscene_ref` | Declared directly in the current Lua. Type not inferred. |
| 4 | `trigger_context` | Declared directly in the current Lua. Type not inferred. |

#### 8. `ezcutscenes.cancel(player_id)`

- **Line:** 241
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 9. `ezcutscenes.is_active(player_id)`

- **Line:** 246
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 10. `ezcutscenes.get_cutscene(area_id, name)`

- **Line:** 250
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `name` | Declared directly in the current Lua. Type not inferred. |

#### 11. `ezcutscenes.handle_player_disconnect(player_id)`

- **Line:** 331
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 12. `ezcutscenes.handle_player_transfer(player_id)`

- **Line:** 339
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 42 | `ezcutscenes` |
| 44 | `registered_cutscenes` |
| 45 | `active_cutscenes` |
| 46 | `once_state` |
| 144 | `context` |
| 152 | `variables` |
| 157 | `cleanup_bot_ids` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.is_player` | 2 | 207 |
| `Net.on` | 1 | 322 |
