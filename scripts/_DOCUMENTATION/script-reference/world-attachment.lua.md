# `world-attachment.lua`

> **Source reference**
>
> Generated from `world-attachment.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

Shared world-attachment coordinate helpers for NetGames and FootBomb. This module intentionally contains only coordinate math. It does not create bots, move actors, subscribe to events, or animate properties. Projection modes: "isometric"  - invert the standard screen/map projection used by FootBomb. "net_games"  - reproduce NetGames' legacy convertOffsets convention. Z correction: The Z correction shifts BOTH map x and map y by the SAME amount so the resulting screen displacement is purely vertical. The engine already handles a bot's absolute Z; the correction here only compensates for a *delta* above the parent (typically `RESULT_BALL_Z_LIFT`). Scale derivation (per-map, dynamic): 1. If `z

## Module location

- **Source:** `world-attachment.lua`
- **Relative reference:** `script-reference/world-attachment.lua.md`

## Functions defined in this file

| Function | Notes |
|---|---|
| `WorldAttachment.follow_position` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `WorldAttachment.pixel_offset_to_map` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `WorldAttachment.point_to_map_offset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `WorldAttachment.point_to_pixel_offset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `WorldAttachment.quantize_map_offset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `WorldAttachment.target_position` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `is_flipped` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `number_or_nil` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `round_fraction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 428 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
