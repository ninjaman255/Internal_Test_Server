# `input-controller/d-pad.lua`

> **Source reference**
>
> Refreshed from the current `input-controller/d-pad.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

D pad source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `input-controller/d-pad.lua`
- **Reference:** `script-reference/input-controller/d-pad.lua.md`
- **Source SHA-256 prefix:** `228015c94dc8`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/utils/utility` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `DPad.EmitButtonPressed` | `button, player_id` |
| `getPressedDirectionSet` | `pressedButtons` |
| `getPressedDirections` | `pressedButtons` |
| `DPad.getActiveDirectionWithMemory` | `pressedButtons, player_id` |
| `DPad.resetPlayerState` | `player_id` |
| `DPad.getAllDirectionRawNames` | `` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
