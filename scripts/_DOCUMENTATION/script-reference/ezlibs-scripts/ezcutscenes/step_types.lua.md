# `ezlibs-scripts/ezcutscenes/step_types.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezcutscenes/step_types.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

ezcutscenes/step_types.lua Step implementations. Each handler is function(context, props, step_object) -> async<result> where step_object is the resolved Cutscene Step object in Tiled. The runner awaits the returned promise, inspects `result`, and chooses the next step from the step's `Next Step` / `Next N` / `Fail Next` properties. Engine bug workaround: Async.quiz_player, Async.question_player, and Async.prompt_player corrupt their choices when a message/option text is passed inline. Every interactive dialog step here therefore: 1. Sends the prompt text via Async.message_player first (modal, awaits the player closing it). 2. Invokes the dialog API with an EMPTY message and only the options

## Module location

- **Source:** `ezlibs-scripts/ezcutscenes/step_types.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezcutscenes/step_types.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/utils/eztiledutils` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `StepTypes.ask_quiz` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `StepTypes.emit_event` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `StepTypes.fade_camera` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `StepTypes.move_actor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `StepTypes.move_camera` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `StepTypes.play_sound` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `StepTypes.prompt_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `StepTypes.set_pose` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `StepTypes.show_message` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `StepTypes.wait` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_actor_bot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_point` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_speaker_mugshot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_target` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 322 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
