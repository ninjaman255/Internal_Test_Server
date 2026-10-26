# `ezlibs-scripts/ezcutscenes/step_types.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezcutscenes/step_types.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezcutscenes/step_types.lua Step implementations. Each handler is function(context, props, step_object) -> async<result> where step_object is the resolved Cutscene Step object in Tiled. The runner awaits the returned promise, inspects `result`, and chooses the next step from the step's `Next Step` / `Next N` / `Fail Next` properties. Engine bug workaround: Async.quiz_player, Async.question_player, and Async.prompt_player corrupt their choices when a message/option text is passed inline. Every interactive dialog step here therefore: 1. Sends the prompt text via Async.message_player first (modal, awaits the player closing it). 2. Invokes the dialog API with an EMPTY message and only the options

## Module location

- **Source:** `ezlibs-scripts/ezcutscenes/step_types.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezcutscenes/step_types.lua.md`
- **Source SHA-256 prefix:** `cf649395ee23`

## Source header notes

- ezcutscenes/step_types.lua
- Step implementations. Each handler is
- function(context, props, step_object) -> async<result>
- where step_object is the resolved Cutscene Step object in Tiled. The
- runner awaits the returned promise, inspects `result`, and chooses the
- next step from the step's `Next Step` / `Next N` / `Fail Next` properties.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/utils/eztiledutils` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `resolve_actor_bot` | `context, actor_ref` |
| `resolve_point` | `context, target_ref` |
| `resolve_target` | `context, props, step_object` |
| `resolve_speaker_mugshot` | `context, props` |
| `StepTypes.wait` | `context, props` |
| `StepTypes.move_actor` | `context, props, step_object` |
| `StepTypes.set_pose` | `context, props` |
| `StepTypes.show_message` | `context, props` |
| `StepTypes.ask_quiz` | `context, props` |
| `StepTypes.prompt_player` | `context, props` |
| `StepTypes.play_sound` | `context, props` |
| `StepTypes.fade_camera` | `context, props` |
| `StepTypes.move_camera` | `context, props, step_object` |
| `StepTypes.emit_event` | `context, props` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`play_sound_for_player`, `fade_player_camera`, `move_player_camera`

## Engine `Async` calls

`quiz_player`, `question_player`, `prompt_player`, `message_player`, `sleep`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
