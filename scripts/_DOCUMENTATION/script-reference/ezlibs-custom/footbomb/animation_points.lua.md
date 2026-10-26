# `ezlibs-custom/footbomb/animation_points.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/footbomb/animation_points.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Backwards-compatible FootBomb animation-point helpers. Coordinate conversion is implemented centrally by world-attachment.lua so FootBomb and Net Games cannot drift into separate flip/projection math.

## Module location

- **Source:** `ezlibs-custom/footbomb/animation_points.lua`
- **Reference:** `script-reference/ezlibs-custom/footbomb/animation_points.lua.md`
- **Source SHA-256 prefix:** `ab801b645f04`

## Source header notes

- Backwards-compatible FootBomb animation-point helpers.
- Coordinate conversion is implemented centrally by world-attachment.lua so
- FootBomb and Net Games cannot drift into separate flip/projection math.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/world-attachment` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `AnimationPoints.offset` | `frame, point` |
| `AnimationPoints.to_map_offset` | `screen_offset, tile_width, tile_height` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
