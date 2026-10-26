# `ezlibs-custom/footbomb/animation_diagnostics.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/footbomb/animation_diagnostics.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Startup diagnostics for FootBomb's active v2.0 Navi animations and their optional v2.5 .ani counterparts. This module is read-only: it never changes the animation state used by Net.animate_bot.

## Module location

- **Source:** `ezlibs-custom/footbomb/animation_diagnostics.lua`
- **Reference:** `script-reference/ezlibs-custom/footbomb/animation_diagnostics.lua.md`
- **Source SHA-256 prefix:** `71b1236dbd6b`

## Source header notes

- Startup diagnostics for FootBomb's active v2.0 Navi animations and their
- optional v2.5 .ani counterparts. This module is read-only: it never changes
- the animation state used by Net.animate_bot.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/boom/main` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `emit` | `log, message` |
| `sorted_state_names` | `states` |
| `inspect_file` | `option, path, expected_state, log` |
| `Diagnostics.run` | `options, log` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`animate_bot`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
