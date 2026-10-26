# `ezlibs-scripts/ezlocks.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezlocks.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezlocks.lua - Reusable lock/unlock behaviors

## Module location

- **Source:** `ezlibs-scripts/ezlocks.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezlocks.lua.md`
- **Source SHA-256 prefix:** `1cc7aa3a2580`

## Source header notes

- ezlocks.lua - Reusable lock/unlock behaviors

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/ezbus` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ezlocks.check_password` | `player_id, prompt_message, correct_password` |
| `ezlocks.check_money` | `player_id, prompt_message, amount, consume` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_player_money`

## Engine `Async` calls

`message_player`, `prompt_player`, `question_player`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
