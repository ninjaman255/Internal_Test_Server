# `libs/direction.lua`

> **Source reference**
>
> Refreshed from the current `libs/direction.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Direction source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `libs/direction.lua`
- **Reference:** `script-reference/libs/direction.lua.md`
- **Source SHA-256 prefix:** `9bf79ffbcf29`

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `Direction.reverse` | `direction` |
| `Direction.from_points` | `point_a, point_b` |
| `Direction.diagonal_from_points` | `point_a, point_b` |
| `Direction.from_offset` | `x, y` |
| `Direction.diagonal_from_offset` | `x, y` |

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `LEFT` | `"Left",` |
| `DOWN` | `"Down",` |
| `RIGHT` | `"Right",` |
| `UP_LEFT` | `"Up Left",` |
| `UP_RIGHT` | `"Up Right",` |
| `DOWN_LEFT` | `"Down Left",` |
| `DOWN_RIGHT` | `"Down Right",` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
