# `net-games/npcs/prog_vert_prompt_red.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/prog_vert_prompt_red.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== prog_vert_prompt_red.lua Max-condensed example: - no Net:on in this file - no TalkVertMenu.open in this file - no SFX table in this file - no exit_index math in this file - full content control remains here =====================================================

## Module location

- **Source:** `net-games/npcs/prog_vert_prompt_red.lua`
- **Reference:** `script-reference/net-games/npcs/prog_vert_prompt_red.lua.md`
- **Source SHA-256 prefix:** `1d1c28fd6054`

## Source header notes

- prog_vert_prompt_red.lua
- Max-condensed example:
- - no Net:on in this file
- - no TalkVertMenu.open in this file
- - no SFX table in this file
- - no exit_index math in this file

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/npcs/talk` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `on_interact` | `player_id, _bot_id, bot_name` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ow/prog/prog_ow_red.png` |
| `/server/assets/ow/prog/prog_ow.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
