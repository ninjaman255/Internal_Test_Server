# 📄 `math-utils.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/animation-engine/math-utils.lua`](../../../animation-engine/math-utils.lua)  
> **Source lines:** 375  
> **SHA-256 (UTF-8):** `40c354c43bc122…`  
> **Declared/assigned functions detected:** 53  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 3

## 🗂️ Contents

- [📌 Overview](#overview)
- [🔗 Dependencies](#dependencies)
- [📡 Event subscriptions](#event-subscriptions)
- [🧩 Functions](#functions)
- [🪄 Anonymous closures](#anonymous-closures)
- [📦 Tables and data](#tables-and-data)
- [⚙️ Runtime API calls](#runtime-api-calls)
- [🧪 Static-analysis notes](#static-analysis-notes)

## 📌 Overview

Reusable mathematical and easing functions

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 13 | `MathUtils.clamp01` | `t` | declared |
| 18 | `MathUtils.lerp` | `a, b, t` | declared |
| 23 | `MathUtils.quadratic_bezier` | `p0, p1, p2, t` | declared |
| 30 | `MathUtils.cubic_bezier` | `p0, p1, p2, p3, t` | declared |
| 37 | `MathUtils.map` | `value, in_min, in_max, out_min, out_max` | declared |
| 42 | `MathUtils.normalize` | `value, min, max` | declared |
| 47 | `MathUtils.round` | `num, numDecimalPlaces` | declared |
| 53 | `MathUtils.approximately` | `a, b, epsilon` | declared |
| 59 | `MathUtils.deg_to_rad` | `degrees` | declared |
| 64 | `MathUtils.rad_to_deg` | `radians` | declared |
| 69 | `MathUtils.sign` | `x` | declared |
| 81 | `instant` | `t` | assigned |
| 85 | `linear` | `t` | assigned |
| 87 | `square` | `t` | assigned |
| 89 | `cubic` | `t` | assigned |
| 91 | `ease_in` | `t` | assigned |
| 93 | `ease_out` | `t` | assigned |
| 95 | `ease_in_out` | `t` | assigned |
| 103 | `smoothstep` | `t` | assigned |
| 105 | `smootherstep` | `t` | assigned |
| 108 | `elastic_in` | `t` | assigned |
| 115 | `elastic_out` | `t` | assigned |
| 122 | `bounce_out` | `t` | assigned |
| 137 | `bounce_in` | `t` | assigned |
| 153 | `elastic_in_out` | `t` | assigned |
| 168 | `sine_in` | `t` | assigned |
| 172 | `sine_out` | `t` | assigned |
| 176 | `sine_in_out` | `t` | assigned |
| 180 | `circ_in` | `t` | assigned |
| 184 | `circ_out` | `t` | assigned |
| 189 | `circ_in_out` | `t` | assigned |
| 199 | `back_in` | `t` | assigned |
| 204 | `back_out` | `t` | assigned |
| 210 | `back_in_out` | `t` | assigned |
| 223 | `MathUtils.ease` | `t, easing_name` | declared |
| 232 | `MathUtils.ease_clamped` | `t, easing_name` | declared |
| 241 | `MathUtils.calculate_progress` | `elapsed_time, duration` | declared |
| 247 | `MathUtils.interpolate_with_easing` | `start, target, t, easing_name` | declared |
| 253 | `MathUtils.interpolate_color` | `start_r, start_g, start_b, start_a, target_r, target_g, target_b, target_a, t, easing_name` | declared |
| 264 | `MathUtils.calculate_shake_offset` | `time, frequency, intensity, decay` | declared |
| 273 | `MathUtils.calculate_pulse` | `time, frequency, min_value, max_value` | declared |
| 283 | `MathUtils.distance` | `x1, y1, x2, y2` | declared |
| 290 | `MathUtils.distance_squared` | `x1, y1, x2, y2` | declared |
| 297 | `MathUtils.angle_between` | `x1, y1, x2, y2` | declared |
| 302 | `MathUtils.angle_between_degrees` | `x1, y1, x2, y2` | declared |
| 307 | `MathUtils.midpoint` | `x1, y1, x2, y2` | declared |
| 312 | `MathUtils.point_in_rect` | `px, py, rect_x, rect_y, rect_width, rect_height` | declared |
| 322 | `MathUtils.random_float` | `min, max` | declared |
| 327 | `MathUtils.random_int` | `min, max` | declared |
| 332 | `MathUtils.random_sign` | `(none)` | declared |
| 337 | `MathUtils.random_element` | `array` | declared |
| 347 | `MathUtils.deep_copy` | `original` | declared |
| 359 | `MathUtils.merge_tables` | `t1, t2` | declared |

### Function details

#### 1. `MathUtils.clamp01(t)`

- **Location:** source line 13.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Clamp a value between 0 and 1

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 2. `MathUtils.lerp(a, b, t)`

- **Location:** source line 18.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Linear interpolation between a and b

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |
| 3 | `t` | Not explicitly documented in adjacent source annotations. |

#### 3. `MathUtils.quadratic_bezier(p0, p1, p2, t)`

- **Location:** source line 23.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Quadratic bezier curve calculation

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p0` | Not explicitly documented in adjacent source annotations. |
| 2 | `p1` | Not explicitly documented in adjacent source annotations. |
| 3 | `p2` | Not explicitly documented in adjacent source annotations. |
| 4 | `t` | Not explicitly documented in adjacent source annotations. |

#### 4. `MathUtils.cubic_bezier(p0, p1, p2, p3, t)`

- **Location:** source line 30.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Cubic bezier curve calculation

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p0` | Not explicitly documented in adjacent source annotations. |
| 2 | `p1` | Not explicitly documented in adjacent source annotations. |
| 3 | `p2` | Not explicitly documented in adjacent source annotations. |
| 4 | `p3` | Not explicitly documented in adjacent source annotations. |
| 5 | `t` | Not explicitly documented in adjacent source annotations. |

#### 5. `MathUtils.map(value, in_min, in_max, out_min, out_max)`

- **Location:** source line 37.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Map a value from one range to another

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `in_min` | Not explicitly documented in adjacent source annotations. |
| 3 | `in_max` | Not explicitly documented in adjacent source annotations. |
| 4 | `out_min` | Not explicitly documented in adjacent source annotations. |
| 5 | `out_max` | Not explicitly documented in adjacent source annotations. |

#### 6. `MathUtils.normalize(value, min, max)`

- **Location:** source line 42.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Normalize a value to 0-1 range

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `min` | Not explicitly documented in adjacent source annotations. |
| 3 | `max` | Not explicitly documented in adjacent source annotations. |

#### 7. `MathUtils.round(num, numDecimalPlaces)`

- **Location:** source line 47.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Round a number to specified decimal places

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `num` | Not explicitly documented in adjacent source annotations. |
| 2 | `numDecimalPlaces` | Not explicitly documented in adjacent source annotations. |

#### 8. `MathUtils.approximately(a, b, epsilon)`

- **Location:** source line 53.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Check if two numbers are approximately equal

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |
| 3 | `epsilon` | Not explicitly documented in adjacent source annotations. |

#### 9. `MathUtils.deg_to_rad(degrees)`

- **Location:** source line 59.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Degrees to radians conversion

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `degrees` | Not explicitly documented in adjacent source annotations. |

#### 10. `MathUtils.rad_to_deg(radians)`

- **Location:** source line 64.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Radians to degrees conversion

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `radians` | Not explicitly documented in adjacent source annotations. |

#### 11. `MathUtils.sign(x)`

- **Location:** source line 69.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Get the sign of a number (-1, 0, or 1)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |

#### 12. `instant(t)`

- **Location:** source line 81.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Returns 1 for any t > 0, meaning immediate transition to target

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 13. `linear(t)`

- **Location:** source line 85.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 14. `square(t)`

- **Location:** source line 87.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 15. `cubic(t)`

- **Location:** source line 89.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 16. `ease_in(t)`

- **Location:** source line 91.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 17. `ease_out(t)`

- **Location:** source line 93.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 18. `ease_in_out(t)`

- **Location:** source line 95.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 19. `smoothstep(t)`

- **Location:** source line 103.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 20. `smootherstep(t)`

- **Location:** source line 105.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 21. `elastic_in(t)`

- **Location:** source line 108.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Elastic easing functions

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 22. `elastic_out(t)`

- **Location:** source line 115.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 23. `bounce_out(t)`

- **Location:** source line 122.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 24. `bounce_in(t)`

- **Location:** source line 137.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 25. `elastic_in_out(t)`

- **Location:** source line 153.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 26. `sine_in(t)`

- **Location:** source line 168.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** Additional easing functions

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 27. `sine_out(t)`

- **Location:** source line 172.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 28. `sine_in_out(t)`

- **Location:** source line 176.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 29. `circ_in(t)`

- **Location:** source line 180.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 30. `circ_out(t)`

- **Location:** source line 184.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 31. `circ_in_out(t)`

- **Location:** source line 189.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 32. `back_in(t)`

- **Location:** source line 199.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 33. `back_out(t)`

- **Location:** source line 204.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 34. `back_in_out(t)`

- **Location:** source line 210.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |

#### 35. `MathUtils.ease(t, easing_name)`

- **Location:** source line 223.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Apply easing function by name

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |
| 2 | `easing_name` | Not explicitly documented in adjacent source annotations. |

#### 36. `MathUtils.ease_clamped(t, easing_name)`

- **Location:** source line 232.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Apply easing and clamp between 0 and 1

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t` | Not explicitly documented in adjacent source annotations. |
| 2 | `easing_name` | Not explicitly documented in adjacent source annotations. |

#### 37. `MathUtils.calculate_progress(elapsed_time, duration)`

- **Location:** source line 241.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Calculate progress based on elapsed time and duration

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `elapsed_time` | Not explicitly documented in adjacent source annotations. |
| 2 | `duration` | Not explicitly documented in adjacent source annotations. |

#### 38. `MathUtils.interpolate_with_easing(start, target, t, easing_name)`

- **Location:** source line 247.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Interpolate between two values with easing

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `start` | Not explicitly documented in adjacent source annotations. |
| 2 | `target` | Not explicitly documented in adjacent source annotations. |
| 3 | `t` | Not explicitly documented in adjacent source annotations. |
| 4 | `easing_name` | Not explicitly documented in adjacent source annotations. |

#### 39. `MathUtils.interpolate_color(start_r, start_g, start_b, start_a, target_r, target_g, target_b, target_a, t, easing_name)`

- **Location:** source line 253.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Interpolate between two colors with easing

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `start_r` | Not explicitly documented in adjacent source annotations. |
| 2 | `start_g` | Not explicitly documented in adjacent source annotations. |
| 3 | `start_b` | Not explicitly documented in adjacent source annotations. |
| 4 | `start_a` | Not explicitly documented in adjacent source annotations. |
| 5 | `target_r` | Not explicitly documented in adjacent source annotations. |
| 6 | `target_g` | Not explicitly documented in adjacent source annotations. |
| 7 | `target_b` | Not explicitly documented in adjacent source annotations. |
| 8 | `target_a` | Not explicitly documented in adjacent source annotations. |
| 9 | `t` | Not explicitly documented in adjacent source annotations. |
| 10 | `easing_name` | Not explicitly documented in adjacent source annotations. |

#### 40. `MathUtils.calculate_shake_offset(time, frequency, intensity, decay)`

- **Location:** source line 264.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Calculate shake offset for screen shake effects

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `time` | Not explicitly documented in adjacent source annotations. |
| 2 | `frequency` | Not explicitly documented in adjacent source annotations. |
| 3 | `intensity` | Not explicitly documented in adjacent source annotations. |
| 4 | `decay` | Not explicitly documented in adjacent source annotations. |

#### 41. `MathUtils.calculate_pulse(time, frequency, min_value, max_value)`

- **Location:** source line 273.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Calculate pulse value for pulsing effects

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `time` | Not explicitly documented in adjacent source annotations. |
| 2 | `frequency` | Not explicitly documented in adjacent source annotations. |
| 3 | `min_value` | Not explicitly documented in adjacent source annotations. |
| 4 | `max_value` | Not explicitly documented in adjacent source annotations. |

#### 42. `MathUtils.distance(x1, y1, x2, y2)`

- **Location:** source line 283.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Calculate distance between two points

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x1` | Not explicitly documented in adjacent source annotations. |
| 2 | `y1` | Not explicitly documented in adjacent source annotations. |
| 3 | `x2` | Not explicitly documented in adjacent source annotations. |
| 4 | `y2` | Not explicitly documented in adjacent source annotations. |

#### 43. `MathUtils.distance_squared(x1, y1, x2, y2)`

- **Location:** source line 290.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Calculate squared distance (faster, avoids sqrt)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x1` | Not explicitly documented in adjacent source annotations. |
| 2 | `y1` | Not explicitly documented in adjacent source annotations. |
| 3 | `x2` | Not explicitly documented in adjacent source annotations. |
| 4 | `y2` | Not explicitly documented in adjacent source annotations. |

#### 44. `MathUtils.angle_between(x1, y1, x2, y2)`

- **Location:** source line 297.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Calculate angle between two points in radians

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x1` | Not explicitly documented in adjacent source annotations. |
| 2 | `y1` | Not explicitly documented in adjacent source annotations. |
| 3 | `x2` | Not explicitly documented in adjacent source annotations. |
| 4 | `y2` | Not explicitly documented in adjacent source annotations. |

#### 45. `MathUtils.angle_between_degrees(x1, y1, x2, y2)`

- **Location:** source line 302.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Calculate angle between two points in degrees

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x1` | Not explicitly documented in adjacent source annotations. |
| 2 | `y1` | Not explicitly documented in adjacent source annotations. |
| 3 | `x2` | Not explicitly documented in adjacent source annotations. |
| 4 | `y2` | Not explicitly documented in adjacent source annotations. |

#### 46. `MathUtils.midpoint(x1, y1, x2, y2)`

- **Location:** source line 307.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Calculate midpoint between two points

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x1` | Not explicitly documented in adjacent source annotations. |
| 2 | `y1` | Not explicitly documented in adjacent source annotations. |
| 3 | `x2` | Not explicitly documented in adjacent source annotations. |
| 4 | `y2` | Not explicitly documented in adjacent source annotations. |

#### 47. `MathUtils.point_in_rect(px, py, rect_x, rect_y, rect_width, rect_height)`

- **Location:** source line 312.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Check if point is within rectangle

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `px` | Not explicitly documented in adjacent source annotations. |
| 2 | `py` | Not explicitly documented in adjacent source annotations. |
| 3 | `rect_x` | Not explicitly documented in adjacent source annotations. |
| 4 | `rect_y` | Not explicitly documented in adjacent source annotations. |
| 5 | `rect_width` | Not explicitly documented in adjacent source annotations. |
| 6 | `rect_height` | Not explicitly documented in adjacent source annotations. |

#### 48. `MathUtils.random_float(min, max)`

- **Location:** source line 322.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Random float between min and max

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `min` | Not explicitly documented in adjacent source annotations. |
| 2 | `max` | Not explicitly documented in adjacent source annotations. |

#### 49. `MathUtils.random_int(min, max)`

- **Location:** source line 327.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Random integer between min and max (inclusive)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `min` | Not explicitly documented in adjacent source annotations. |
| 2 | `max` | Not explicitly documented in adjacent source annotations. |

#### 50. `MathUtils.random_sign()`

- **Location:** source line 332.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Random sign (-1 or 1)

#### 51. `MathUtils.random_element(array)`

- **Location:** source line 337.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Random element from array

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `array` | Not explicitly documented in adjacent source annotations. |

#### 52. `MathUtils.deep_copy(original)`

- **Location:** source line 347.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Deep copy a table

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `original` | Not explicitly documented in adjacent source annotations. |

#### 53. `MathUtils.merge_tables(t1, t2)`

- **Location:** source line 359.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Merge two tables (second table overwrites first)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `t1` | Not explicitly documented in adjacent source annotations. |
| 2 | `t2` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **3** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `MathUtils` — line 4

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `MathUtils.easing_functions` — line 79

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `-- Returns 1 for any t > 0, meaning immediate transition to target instant = function(t) return t > 0 and 1 or 0 end` |
| `linear` | function | `function(t) return t end` |
| `square` | function | `function(t) return t*t end` |
| `cubic` | function | `function(t) return t*t*t end` |
| `ease_in` | function | `function(t) return t * t end` |
| `ease_out` | function | `function(t) return t * (2 - t) end` |
| `ease_in_out` | function | `function(t) if t < 0.5 then return 2 * t * t else return -1 + (4 - 2 * t) * t end end` |
| `smoothstep` | function | `function(t) return t * t * (3 - 2 * t) end` |
| `smootherstep` | function | `function(t) return t * t * t * (t * (6 * t - 15) + 10) end` |
| `[10]` | expression/reference | `-- Elastic easing functions elastic_in = function(t) if t == 0 or t == 1 then return t end local p = 0.3 local s = p / 4 return -(2^(10 * (t - 1))) * math…` |
| `elastic_out` | function | `function(t) if t == 0 or t == 1 then return t end local p = 0.3 local s = p / 4 return 2^(-10 * t) * math.sin((t - s) * (2 * math.pi) / p) + 1 end` |
| `bounce_out` | function | `function(t) if t < 1 / 2.75 then return 7.5625 * t * t elseif t < 2 / 2.75 then t = t - 1.5 / 2.75 return 7.5625 * t * t + 0.75 elseif t < 2.5 / 2.75 then…` |
| `bounce_in` | function | `function(t) t = 1 - t if t < 1 / 2.75 then return 1 - 7.5625 * t * t elseif t < 2 / 2.75 then t = t - 1.5 / 2.75 return 1 - (7.5625 * t * t + 0.75) elseif…` |
| `elastic_in_out` | function | `function(t) if t == 0 or t == 1 then return t end local p = 0.3 local s = p / 4 if t < 0.5 then t = t * 2 -- Scale t to [0, 1] return -0.5 * (2^(10 * (t -…` |
| `[15]` | expression/reference | `-- Additional easing functions sine_in = function(t) return 1 - math.cos((t * math.pi) / 2) end` |
| `sine_out` | function | `function(t) return math.sin((t * math.pi) / 2) end` |
| `sine_in_out` | function | `function(t) return -(math.cos(math.pi * t) - 1) / 2 end` |
| `circ_in` | function | `function(t) return 1 - math.sqrt(1 - t * t) end` |
| `circ_out` | function | `function(t) t = t - 1 return math.sqrt(1 - t * t) end` |
| `circ_in_out` | function | `function(t) t = t * 2 if t < 1 then return -(math.sqrt(1 - t * t) - 1) / 2 else t = t - 2 return (math.sqrt(1 - t * t) + 1) / 2 end end` |
| `back_in` | function | `function(t) local s = 1.70158 return t * t * ((s + 1) * t - s) end` |
| `back_out` | function | `function(t) local s = 1.70158 t = t - 1 return t * t * ((s + 1) * t + s) + 1 end` |
| `back_in_out` | function | `function(t) local s = 1.70158 * 1.525 t = t * 2 if t < 1 then return 0.5 * (t * t * ((s + 1) * t - s)) else t = t - 2 return 0.5 * (t * t * ((s + 1) * t +…` |

### 3. `copy` — line 348

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
