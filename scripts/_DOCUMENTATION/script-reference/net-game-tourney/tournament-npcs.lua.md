# `net-game-tourney/tournament-npcs.lua`

> **Source reference**
>
> Refreshed from the current `net-game-tourney/tournament-npcs.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

tournament-npcs.lua

## Module location

- **Source:** `net-game-tourney/tournament-npcs.lua`
- **Reference:** `script-reference/net-game-tourney/tournament-npcs.lua.md`
- **Source SHA-256 prefix:** `63f1d374df90`

## Source header notes

- tournament-npcs.lua

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `tournament_npcs.cleanup_tournament_npcs` | `tournament_id` |
| `tournament_npcs.get_unique_random_npc` | `tournament_id` |
| `tournament_npcs.get_unique_random_npcs` | `tournament_id, count` |
| `tournament_npcs.get_random_npc` | `` |
| `tournament_npcs.get_random_npcs` | `count` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/tourney/npc-navis-testing/` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
