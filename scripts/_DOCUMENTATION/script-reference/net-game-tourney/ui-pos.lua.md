# `net-game-tourney/ui-pos.lua`

> **Source reference**
>
> Refreshed from the current `net-game-tourney/ui-pos.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ui-pos.lua

## Module location

- **Source:** `net-game-tourney/ui-pos.lua`
- **Reference:** `script-reference/net-game-tourney/ui-pos.lua.md`
- **Source SHA-256 prefix:** `082dff734b96`

## Source header notes

- ui-pos.lua

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `UIPositions.get_mugshot_positions` | `round` |
| `UIPositions.get_progress_bar_positions` | `tier` |
| `UIPositions.get_progress_bar_index` | `round, match_index, winner_is_player1` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
