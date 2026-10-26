# `net-games/dialogue/constants.lua`

> **Source reference**
>
> Refreshed from the current `net-games/dialogue/constants.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

scripts/net-games/dialogue/constants.lua

## Module location

- **Source:** `net-games/dialogue/constants.lua`
- **Reference:** `script-reference/net-games/dialogue/constants.lua.md`
- **Source SHA-256 prefix:** `6c0ee9d1d4af`

## Source header notes

- scripts/net-games/dialogue/constants.lua

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `INPUT` | `"input",  -- BN style: wait for confirm` |
| `TIMER` | `"timer",  -- legacy/auto: delay then advance` |
| `WAIT_FOR_CONFIRM` | `"wait_for_confirm",` |
| `AUTO_ADVANCE` | `"auto_advance",` |
| `AUTO_ADVANCE_OR_CONFIRM` | `"auto_advance_or_confirm",` |
| `DIALOGUE_OWNS_INPUT` | `"dialogue_owns_input",` |
| `OVERLAY_ONLY` | `"overlay_only",` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
