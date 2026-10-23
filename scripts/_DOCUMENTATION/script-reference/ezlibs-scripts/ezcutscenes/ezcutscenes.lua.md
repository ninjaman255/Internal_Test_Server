# `ezlibs-scripts/ezcutscenes/ezcutscenes.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezcutscenes/ezcutscenes.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

ezcutscenes.lua Tiled-authored cutscene system. A Cutscene object names a chain of Cutscene Step objects. Each step performs one action (move an actor, show a message, ask a quiz, etc.). Steps chain via `Next Step` refs; branching steps use `Next 1/2/3` and `Fail Next`. Interactive vs non-interactive: Show Message / Ask Quiz / Prompt Player are interactive. They run through Async.message_player / quiz_player / prompt_player, which are modal dialogs. Net.lock_player_input only blocks world interaction and movement; those dialog APIs run their own input path, so the cutscene works while input is locked. Wait / Set Pose / Move Actor / Play Sound / Fade Camera / Move Camera / Emit Event are non-

## Module location

- **Source:** `ezlibs-scripts/ezcutscenes/ezcutscenes.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezcutscenes/ezcutscenes.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezcache` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezcutscenes/step_types` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/object_registry` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/utils/eztiledutils` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `choose_next_step_ref` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcutscenes.cancel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcutscenes.get_cutscene` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcutscenes.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcutscenes.handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcutscenes.is_active` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezcutscenes.start` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_props` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_object_cached` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `run_cutscene` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `run_step_chain` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 349 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
