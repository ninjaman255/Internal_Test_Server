# `ezlibs-scripts/ezquests.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezquests.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Ezquests source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezquests.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezquests.lua.md`
- **Source SHA-256 prefix:** `e42cdc525c71`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/helpers` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ezquests.add_quest` | `quest` |
| `ezquests.set_player_quest_flag` | `player_id,quest_name,flag_name,flag_state` |
| `ezquests.get_player_quest_flag` | `player_id,quest_name,flag_name,flag_state` |
| `ezquests.clear_player_quest_flags` | `player_id,quest_name` |
| `ezquests.get_quest` | `quest_name` |
| `ezquests.get_player_quest_state` | `player_id, quest_name` |
| `ezquests.quest_event` | `player_id,quest_name,event_value` |
| `handle_event_async` | `self,player_id,event_value` |
| `determine_state` | `self,player_id` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
