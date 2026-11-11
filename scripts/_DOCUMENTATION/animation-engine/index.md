# 📁 animation-engine

[🏠 Documentation home](../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents
- [📖 Guides & reference material](#guides--reference-material)

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `animation-engine.lua` | 1 | 44 | 23 | 612 | [Open script reference](animation-engine/index.md) |
| 📄 Script | `animation-enums.lua` | 1 | 0 | 7 | 80 | [Open script reference](animation-enums/index.md) |
| 📄 Script | `animation-sequences.lua` | 1 | 53 | 24 | 1248 | [Open script reference](animation-sequences/index.md) |
| 📄 Script | `math-utils.lua` | 1 | 53 | 3 | 375 | [Open script reference](math-utils/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `animation-engine.lua` | `AnimationEngine.get_time()` | 63 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.interpolate(start, target, t, easing, discrete)` | 67 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.animate(start_values, target_values, duration, options)` | 110 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.update(_dt)` | 178 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.stop_animation(id)` | 231 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.stop_animations_by_tag(tag)` | 239 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.tween(object, target_props, duration, options)` | 249 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.create_sequence(steps, options)` | 297 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.start_sequence(id)` | 320 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine._execute_sequence_step(seq_id)` | 354 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine._sequence_step_complete(seq_id)` | 409 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.update_sequences(_dt)` | 431 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.stop_sequence(id)` | 446 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.stop_sequences_by_tag(tag)` | 456 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.animate_discrete_first(start_values, target_values, duration, options)` | 466 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.set_to(object, values)` | 494 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.delay(duration, callback)` | 518 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.cancel_delay(id)` | 527 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.update_callbacks()` | 532 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.get_active_count()` | 548 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.get_sequence_count()` | 554 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.clear_all()` | 560 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.tick(dt)` | 574 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.set_debug(enabled)` | 584 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.set_max_tick_dt(seconds)` | 588 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.set_interpolation_speeds(position, ro, color, scale)` | 593 | [Details](animation-engine/index.md) |
| `animation-engine.lua` | `AnimationEngine.add_easing_function(name, func)` | 600 | [Details](animation-engine/index.md) |
| `animation-sequences.lua` | `AnimationSequences.summon(object, start_x, start_y, start_scale, end_x, end_y, end_scale, options)` | 124 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.set(object, start_x, start_y, start_scale, start_rotation, end_x, end_y, end_scale, end_rotation, options)` | 193 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.positionChange(object, start_rotation, end_rotation, options)` | 257 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.attack(object, recoil_offset, lunge_offset, options)` | 311 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.slideIn(object, start_x, start_y, end_x, end_y, options)` | 377 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.bob(object, options)` | 411 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.pulse(object, options)` | 448 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.color_pulse(object, start_color, target_color, options)` | 494 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.color_pulse_from_current(object, target_color, options)` | 555 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.shake(object, options)` | 570 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.fade(object, target_alpha, options)` | 626 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.tint(object, target_r, target_g, target_b, options)` | 663 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.complexSummon(object, start_x, start_y, start_scale, end_x, end_y, end_scale, options)` | 701 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.menuCursor(object, options)` | 779 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.highlightCard(object, options)` | 809 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.tween(object, target_props, duration, options)` | 839 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.move_to(object, target_x, target_y, duration, options)` | 848 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.scale_to(object, target_scale, duration, options)` | 856 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.rotate_to(object, target_angle, duration, options)` | 864 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.fade_to(object, target_alpha, duration, options)` | 872 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.tint_to(object, target_r, target_g, target_b, duration, options)` | 880 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.color_pulse_to(object, target_r, target_g, target_b, target_a, duration, easing, on_complete, loop, ping_pong, easing_back, discrete, tag)` | 888 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.move_to_discrete_first(object, target_x, target_y, duration, options)` | 919 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.series(objects, animator, options)` | 955 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `anim_opts.on_complete(...)` | 1026 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.marquee(object, distance, duration, options)` | 1074 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.typewriter(sprites, options)` | 1127 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.stopAll(tag)` | 1217 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.isAnimating(tag)` | 1227 | [Details](animation-sequences/index.md) |
| `animation-sequences.lua` | `AnimationSequences.reset(object, initial_values)` | 1233 | [Details](animation-sequences/index.md) |
| `math-utils.lua` | `MathUtils.clamp01(t)` | 13 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.lerp(a, b, t)` | 18 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.quadratic_bezier(p0, p1, p2, t)` | 23 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.cubic_bezier(p0, p1, p2, p3, t)` | 30 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.map(value, in_min, in_max, out_min, out_max)` | 37 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.normalize(value, min, max)` | 42 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.round(num, numDecimalPlaces)` | 47 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.approximately(a, b, epsilon)` | 53 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.deg_to_rad(degrees)` | 59 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.rad_to_deg(radians)` | 64 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.sign(x)` | 69 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.ease(t, easing_name)` | 223 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.ease_clamped(t, easing_name)` | 232 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.calculate_progress(elapsed_time, duration)` | 241 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.interpolate_with_easing(start, target, t, easing_name)` | 247 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.interpolate_color(start_r, start_g, start_b, start_a, target_r, target_g, target_b, target_a, t, easing_name)` | 253 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.calculate_shake_offset(time, frequency, intensity, decay)` | 264 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.calculate_pulse(time, frequency, min_value, max_value)` | 273 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.distance(x1, y1, x2, y2)` | 283 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.distance_squared(x1, y1, x2, y2)` | 290 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.angle_between(x1, y1, x2, y2)` | 297 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.angle_between_degrees(x1, y1, x2, y2)` | 302 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.midpoint(x1, y1, x2, y2)` | 307 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.point_in_rect(px, py, rect_x, rect_y, rect_width, rect_height)` | 312 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.random_float(min, max)` | 322 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.random_int(min, max)` | 327 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.random_sign()` | 332 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.random_element(array)` | 337 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.deep_copy(original)` | 347 | [Details](math-utils/index.md) |
| `math-utils.lua` | `MathUtils.merge_tables(t1, t2)` | 359 | [Details](math-utils/index.md) |

## 📊 Collection summary

This folder subtree contains **4 Lua source files**, **150 named/assigned function detections**, and **57 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `README.md`](README.md) | 🎬 Animation Engine Documentation |
