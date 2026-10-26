# World Attachment — Coordinate Helpers

> **Scope and accuracy**
>
> Refreshed from `scripts/world-attachment.lua` on 2026-10-25. This module is math-only; source inspection does not imply live engine validation.

## Purpose and boundaries

`require("scripts/world-attachment")` returns `WorldAttachment`, a set of coordinate-conversion helpers used by Net Games and FootBomb to place a child sprite/actor at a point relative to a parent. The module intentionally does **not** create actors, move bots, subscribe to events, or animate properties. Callers own those lifecycle and rendering responsibilities.

The module supports `isometric` projection and the legacy `net_games` projection convention. Standard isometric dimensions default to tile width 64 and tile height 32. Supply current map dimensions when the target map differs.

## Coordinate pipeline

1. `point_to_pixel_offset(frame, point)` converts an animation frame's named point to a pixel offset relative to the frame origin/pivot. Horizontal and vertical flips are accounted for.
2. `pixel_offset_to_map(screen_offset, options)` converts that pixel offset into a map-space delta using the selected projection, optional Z correction, and optional anti-jitter quantization.
3. The caller adds the returned delta to the parent map position to get the child's target position. The result is a **delta**, not an absolute map coordinate.
4. `quantize_map_offset(offset, options)` can snap fractional map deltas to a grid to reduce shimmering for slow/static attachments. Avoid it for fast-moving objects because quantization can create visible stepping.

## Public functions

### `WorldAttachment.point_to_pixel_offset(frame, point)`

Requires a frame table and point table with numeric `x` and `y`. Uses `frame.w`, `frame.h`, `frame.originx`, `frame.originy`, `frame.flipx`, and `frame.flipy`. Returns the pixel delta, or `nil, error`; a third return value provides diagnostic metadata.

### `WorldAttachment.pixel_offset_to_map(screen_offset, options)`

Requires numeric `x` and `y` in `screen_offset`. Relevant options include `projection`, `tile_width`, `tile_height`, `z_correction`, and anti-jitter settings. The isometric projection uses both tile dimensions; the legacy `net_games` projection retains its fixed 64-pixel convention. Returns a map delta, or `nil, error`, and may return metadata describing dimensions and Z correction.

Z correction adds the same correction to map X and map Y, producing a purely vertical screen displacement. `child_z` is the **delta above the parent**, not the parent's absolute Z; the engine already accounts for the parent's own depth. A scale can be supplied explicitly or derived from `tile_height / tile_width`; `scale_multiplier` adjusts it. Sprite callers can derive a multiplier from frame origin/height so the correction follows the sprite's anchor.

### `WorldAttachment.quantize_map_offset(offset, options)`

Requires numeric map-space `x` and `y`. Defaults to `denominator = 32` and `difference_steps = 16`; non-positive values return an error. Returns a quantized map delta or `nil, error`.

## Ownership and anti-jitter guidance

- Give each attached sprite one authoritative position writer. Do not have a second tick handler independently update the same position.
- Use quantization for static/resting items or poses only when needed; leave fast ball-flight paths unquantized.
- Keep the chosen projection consistent with the parent system's coordinate convention. `net_games` is intentionally a compatibility projection, not interchangeable with isometric conversion in every context.
- Pair any attachment setup with caller-owned cleanup when the sprite, actor, or instance is removed.
- FootBomb's configured result-ball Z lift is currently `4`; this is a caller-side setting, not a module-global constant.

See [the per-script reference](script-reference/world-attachment.lua.md) for current declarations and call-site details.
