# `ezlibs-scripts/eznpcs/npc_behaviors.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/eznpcs/npc_behaviors.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

npc_behaviors.lua Composable behavior objects for eznpcs. Tiled object type: NPC Behavior

## Module location

- **Source:** `ezlibs-scripts/eznpcs/npc_behaviors.lua`
- **Reference:** `script-reference/ezlibs-scripts/eznpcs/npc_behaviors.lua.md`
- **Source SHA-256 prefix:** `92a37875aac3`

## Source header notes

- npc_behaviors.lua
- Composable behavior objects for eznpcs.
- Tiled object type: NPC Behavior
- Attached NPC: object reference to an NPC or NPC template
- Behavior: registered behavior key (currently Pushback)
- This module intentionally does not create bots. It attaches behavior to bots

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/ezcache` |
| `scripts/ezlibs-scripts/object_registry` |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| `scripts/ezlibs-scripts/eznpcs/ezpushback` |
| `scripts/ezlibs-scripts/utils/eztiledutils` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `key` | `area_id, behavior_object_id, bot_id` |
| `npc_behaviors.register` | `name, implementation` |
| `attach_one` | `area_id, behavior_object, bot_id, context` |
| `attach_for_target` | `area_id, target_object_id, bot_id, context` |
| `npc_behaviors.attach_all` | `` |
| `attach` | `args` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
