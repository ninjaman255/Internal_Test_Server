# `ezlibs-scripts/ezwarps/arrow_animation_factory.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezwarps/arrow_animation_factory.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Arrow animation factory source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezwarps/arrow_animation_factory.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezwarps/arrow_animation_factory.lua.md`
- **Source SHA-256 prefix:** `979f83bbdd61`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezweather` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `create_arrow_animation` | `is_arriving,direction_str` |
| `animate` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_player_position`, `get_player_area`, `fade_player_camera`, `move_player_camera`, `unlock_player_camera`, `slide_player_camera`, `animate_player_properties`

## Engine `Async` calls

`sleep`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `UP_LEFT` | `"Up Left",` |
| `UP_RIGHT` | `"Up Right",` |
| `DOWN_LEFT` | `"Down Left",` |
| `DOWN_RIGHT` | `"Down Right",` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
