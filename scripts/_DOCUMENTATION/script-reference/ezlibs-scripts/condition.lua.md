# `ezlibs-scripts/condition.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/condition.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Condition source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/condition.lua`
- **Reference:** `script-reference/ezlibs-scripts/condition.lua.md`
- **Source SHA-256 prefix:** `8f622dfa0863`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/ezquests` |
| `scripts/ezlibs-scripts/helpers` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `condition.date_before` | `date_string` |
| `condition.date_after` | `date_string` |
| `condition.item` | `player_id, item_name, amount, consume` |
| `condition.money` | `player_id, amount, consume` |
| `condition.fragments` | `player_id, amount, consume` |
| `condition.tokens` | `player_id, amount, consume` |
| `condition.quest_flag` | `player_id, quest_name, flag_name, expected, op` |
| `condition.evaluate` | `player_id, cond` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
