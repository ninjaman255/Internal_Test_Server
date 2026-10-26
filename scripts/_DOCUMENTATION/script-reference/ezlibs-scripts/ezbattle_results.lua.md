# `ezlibs-scripts/ezbattle_results.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezbattle_results.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Stores the most recent battle_results payload per player so later lifecycle events (such as battle_exit) can inspect or consume it.

## Module location

- **Source:** `ezlibs-scripts/ezbattle_results.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezbattle_results.lua.md`
- **Source SHA-256 prefix:** `588333dd40d7`

## Source header notes

- Stores the most recent battle_results payload per player so later lifecycle
- events (such as battle_exit) can inspect or consume it.

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ezbattle_results.store` | `player_id, event` |
| `ezbattle_results.peek` | `player_id` |
| `ezbattle_results.consume` | `player_id` |
| `ezbattle_results.clear` | `player_id` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
