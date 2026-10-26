# `world-attachment.lua`

> **Source reference**
>
> Refreshed from the current `world-attachment.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Shared world-attachment coordinate helpers for NetGames and FootBomb. This module intentionally contains only coordinate math. It does not create bots, move actors, subscribe to events, or animate properties. Projection modes: "isometric"  - invert the standard screen/map projection used by FootBomb. "net_games"  - reproduce NetGames' legacy convertOffsets convention. Z correction: The Z correction shifts BOTH map x and map y by the SAME amount so the resulting screen displacement is purely vertical. The engine already handles a bot's absolute Z; the correction here only compensates for a *delta* above the parent (typically `RESULT_BALL_Z_LIFT`). Scale derivation (per-map, dynamic): 1. If `z

## Module location

- **Source:** `world-attachment.lua`
- **Reference:** `script-reference/world-attachment.lua.md`
- **Source SHA-256 prefix:** `9afdb7cf1d25`

## Source header notes

- Shared world-attachment coordinate helpers for NetGames and FootBomb.
- This module intentionally contains only coordinate math. It does not create
- bots, move actors, subscribe to events, or animate properties.
- Projection modes:
- "isometric"  - invert the standard screen/map projection used by FootBomb.
- "net_games"  - reproduce NetGames' legacy convertOffsets convention.

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `number_or_nil` | `value` |
| `is_flipped` | `value` |
| `round_fraction` | `value, denominator` |
| `WorldAttachment.quantize_map_offset` | `offset, options` |
| `WorldAttachment.point_to_pixel_offset` | `frame, point` |
| `WorldAttachment.pixel_offset_to_map` | `screen_offset, options` |
| `WorldAttachment.point_to_map_offset` | `frame, point, options` |
| `WorldAttachment.target_position` | `parent_position, map_offset, options` |
| `WorldAttachment.follow_position` | `parent_position, screen_offset, options` |

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DEFAULT_TILE_WIDTH` | `64` |
| `DEFAULT_TILE_HEIGHT` | `32` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
