# `animation-engine/math-utils.lua`

> **Source reference**
>
> Refreshed from the current `animation-engine/math-utils.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

math-utils.lua Reusable mathematical and easing functions

## Module location

- **Source:** `animation-engine/math-utils.lua`
- **Reference:** `script-reference/animation-engine/math-utils.lua.md`
- **Source SHA-256 prefix:** `40c354c43bc1`

## Source header notes

- math-utils.lua
- Reusable mathematical and easing functions

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `MathUtils.clamp01` | `t` |
| `MathUtils.lerp` | `a, b, t` |
| `MathUtils.quadratic_bezier` | `p0, p1, p2, t` |
| `MathUtils.cubic_bezier` | `p0, p1, p2, p3, t` |
| `MathUtils.map` | `value, in_min, in_max, out_min, out_max` |
| `MathUtils.normalize` | `value, min, max` |
| `MathUtils.round` | `num, numDecimalPlaces` |
| `MathUtils.approximately` | `a, b, epsilon` |
| `MathUtils.deg_to_rad` | `degrees` |
| `MathUtils.rad_to_deg` | `radians` |
| `MathUtils.sign` | `x` |
| `MathUtils.ease` | `t, easing_name` |
| `MathUtils.ease_clamped` | `t, easing_name` |
| `MathUtils.calculate_progress` | `elapsed_time, duration` |
| `MathUtils.interpolate_with_easing` | `start, target, t, easing_name` |
| `MathUtils.calculate_shake_offset` | `time, frequency, intensity, decay` |
| `MathUtils.calculate_pulse` | `time, frequency, min_value, max_value` |
| `MathUtils.distance` | `x1, y1, x2, y2` |
| `MathUtils.distance_squared` | `x1, y1, x2, y2` |
| `MathUtils.angle_between` | `x1, y1, x2, y2` |
| `MathUtils.angle_between_degrees` | `x1, y1, x2, y2` |
| `MathUtils.midpoint` | `x1, y1, x2, y2` |
| `MathUtils.point_in_rect` | `px, py, rect_x, rect_y, rect_width, rect_height` |
| `MathUtils.random_float` | `min, max` |
| `MathUtils.random_int` | `min, max` |
| `MathUtils.random_sign` | `` |
| `MathUtils.random_element` | `array` |
| `MathUtils.deep_copy` | `original` |
| `MathUtils.merge_tables` | `t1, t2` |
| `instant` | `t` |
| `linear` | `t` |
| `square` | `t` |
| `cubic` | `t` |
| `ease_in` | `t` |
| `ease_out` | `t` |
| `ease_in_out` | `t` |
| `smoothstep` | `t` |
| `smootherstep` | `t` |
| `elastic_in` | `t` |
| `elastic_out` | `t` |
| `bounce_out` | `t` |
| `bounce_in` | `t` |
| `elastic_in_out` | `t` |
| `sine_in` | `t` |
| `sine_out` | `t` |
| `sine_in_out` | `t` |
| `circ_in` | `t` |
| `circ_out` | `t` |
| `circ_in_out` | `t` |
| `back_in` | `t` |
| `back_out` | `t` |
| `back_in_out` | `t` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
