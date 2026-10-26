# `net-game-tourney/main.lua`

> **Source reference**
>
> Refreshed from the current `net-game-tourney/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

main.lua

## Module location

- **Source:** `net-game-tourney/main.lua`
- **Reference:** `script-reference/net-game-tourney/main.lua.md`
- **Source SHA-256 prefix:** `34893ff63dff`

## Source header notes

- main.lua

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/main` |
| `scripts/net-game-tourney/tournament-manager` |
| `scripts/net-game-tourney/tournament-ui` |

## `Net:on` subscriptions

| Event |
|---|
| `player_join` |
| `object_interaction` |
| `battle_results` |
| `player_area_transfer` |
| `player_disconnect` |
| `tick` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`, `get_player_area`, `get_object_by_id`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
