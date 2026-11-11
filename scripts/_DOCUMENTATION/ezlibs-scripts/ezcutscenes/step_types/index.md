# 📄 `step_types.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezcutscenes/step_types.lua`](../../../../ezlibs-scripts/ezcutscenes/step_types.lua)  
> **Source lines:** 322  
> **SHA-256 (UTF-8):** `2690889e2a81a3e30141eda191adc50642b740cf7eaa235d9d5166cef1b3c920`  
> **Named/assigned functions detected:** 14  
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

Current source inventory for `scripts/ezlibs-scripts/ezcutscenes/step_types.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 17 | `scripts/logger/logger` |
| 18 | `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| 19 | `scripts/ezlibs-scripts/ezbus` |
| 20 | `scripts/ezlibs-scripts/utils/eztiledutils` |

## Event hooks

No literal `:on` event registration detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 28 | `resolve_actor_bot` | `context, actor_ref` | local |
| 52 | `resolve_point` | `context, target_ref` | local |
| 64 | `resolve_target` | `context, props, step_object` | local |
| 89 | `resolve_speaker_mugshot` | `context, props` | local |
| 110 | `StepTypes.wait` | `context, props` | assigned/declared |
| 120 | `StepTypes.move_actor` | `context, props, step_object` | assigned/declared |
| 154 | `StepTypes.set_pose` | `context, props` | assigned/declared |
| 180 | `StepTypes.show_message` | `context, props` | assigned/declared |
| 197 | `StepTypes.ask_quiz` | `context, props` | assigned/declared |
| 225 | `StepTypes.prompt_player` | `context, props` | assigned/declared |
| 248 | `StepTypes.play_sound` | `context, props` | assigned/declared |
| 257 | `StepTypes.fade_camera` | `context, props` | assigned/declared |
| 273 | `StepTypes.move_camera` | `context, props, step_object` | assigned/declared |
| 296 | `StepTypes.emit_event` | `context, props` | assigned/declared |

### Detailed parameter inventory

#### 1. `resolve_actor_bot(context, actor_ref)`

- **Line:** 28
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `actor_ref` | Declared in this function; type not inferred. |

#### 2. `resolve_point(context, target_ref)`

- **Line:** 52
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `target_ref` | Declared in this function; type not inferred. |

#### 3. `resolve_target(context, props, step_object)`

- **Line:** 64
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `props` | Declared in this function; type not inferred. |
| 3 | `step_object` | Declared in this function; type not inferred. |

#### 4. `resolve_speaker_mugshot(context, props)`

- **Line:** 89
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `props` | Declared in this function; type not inferred. |

#### 5. `StepTypes.wait(context, props)`

- **Line:** 110
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `props` | Declared in this function; type not inferred. |

#### 6. `StepTypes.move_actor(context, props, step_object)`

- **Line:** 120
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `props` | Declared in this function; type not inferred. |
| 3 | `step_object` | Declared in this function; type not inferred. |

#### 7. `StepTypes.set_pose(context, props)`

- **Line:** 154
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `props` | Declared in this function; type not inferred. |

#### 8. `StepTypes.show_message(context, props)`

- **Line:** 180
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `props` | Declared in this function; type not inferred. |

#### 9. `StepTypes.ask_quiz(context, props)`

- **Line:** 197
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `props` | Declared in this function; type not inferred. |

#### 10. `StepTypes.prompt_player(context, props)`

- **Line:** 225
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `props` | Declared in this function; type not inferred. |

#### 11. `StepTypes.play_sound(context, props)`

- **Line:** 248
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `props` | Declared in this function; type not inferred. |

#### 12. `StepTypes.fade_camera(context, props)`

- **Line:** 257
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `props` | Declared in this function; type not inferred. |

#### 13. `StepTypes.move_camera(context, props, step_object)`

- **Line:** 273
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `props` | Declared in this function; type not inferred. |
| 3 | `step_object` | Declared in this function; type not inferred. |

#### 14. `StepTypes.emit_event(context, props)`

- **Line:** 296
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `context` | Declared in this function; type not inferred. |
| 2 | `props` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 22 | `StepTypes` |
| 100 | `fake_dialogue` |
| 135 | `options` |
| 168 | `options` |
| 309 | `StepTypes.DISPATCH` |

## Net API calls

No direct `Net.method(...)` call expression matched.
