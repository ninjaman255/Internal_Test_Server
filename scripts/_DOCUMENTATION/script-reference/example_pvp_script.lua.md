# `example_pvp_script.lua`

> **Source reference**
>
> Refreshed from the current `example_pvp_script.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Example pvp script source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `example_pvp_script.lua`
- **Reference:** `script-reference/example_pvp_script.lua.md`
- **Source SHA-256 prefix:** `ad40c6d18b01`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/persistence/logger` |

## `Net:on` subscriptions

| Event |
|---|
| `player_connect` |
| `tile_interaction` |
| `player_disconnect` |
| `actor_interaction` |
| `textbox_response` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`, `animate_player`, `get_player_mugshot`, `question_player`, `initiate_pvp`, `exclusive_player_emote`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
