# `ezlibs-scripts/ezcutscenes/ezcutscenes.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezcutscenes/ezcutscenes.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezcutscenes.lua Tiled-authored cutscene system. A Cutscene object names a chain of Cutscene Step objects. Each step performs one action (move an actor, show a message, ask a quiz, etc.). Steps chain via `Next Step` refs; branching steps use `Next 1/2/3` and `Fail Next`. Interactive vs non-interactive: Show Message / Ask Quiz / Prompt Player are interactive. They run through Async.message_player / quiz_player / prompt_player, which are modal dialogs. Net.lock_player_input only blocks world interaction and movement; those dialog APIs run their own input path, so the cutscene works while input is locked. Wait / Set Pose / Move Actor / Play Sound / Fade Camera / Move Camera / Emit Event are non-

## Module location

- **Source:** `ezlibs-scripts/ezcutscenes/ezcutscenes.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezcutscenes/ezcutscenes.lua.md`
- **Source SHA-256 prefix:** `178228af4874`

## Source header notes

- ezcutscenes.lua
- Tiled-authored cutscene system.
- A Cutscene object names a chain of Cutscene Step objects. Each step
- performs one action (move an actor, show a message, ask a quiz, etc.).
- Steps chain via `Next Step` refs; branching steps use `Next 1/2/3` and
- `Fail Next`.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/object_registry` |
| `scripts/ezlibs-scripts/ezcache` |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| `scripts/ezlibs-scripts/utils/eztiledutils` |
| `scripts/ezlibs-scripts/ezcutscenes/step_types` |

## `Net:on` subscriptions

| Event |
|---|
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `get_props` | `object` |
| `resolve_object_cached` | `area_id, object_id` |
| `choose_next_step_ref` | `step_props, step_type_name, result` |
| `run_step_chain` | `context, first_step_ref` |
| `run_cutscene` | `player_id, area_id, cutscene_object, trigger_context` |
| `ezcutscenes.start` | `player_id, area_id, cutscene_ref, trigger_context` |
| `ezcutscenes.cancel` | `player_id` |
| `ezcutscenes.is_active` | `player_id` |
| `ezcutscenes.get_cutscene` | `area_id, name` |
| `ezcutscenes.handle_player_disconnect` | `player_id` |
| `ezcutscenes.handle_player_transfer` | `player_id` |
| `resolve_object` | `id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`lock_player_input`, `get_object_by_id`, `unlock_player_input`, `is_player`, `on`

## Engine `Async` calls

`message_player`, `await`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `MAX_STEPS_PER_RUN` | `250` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
