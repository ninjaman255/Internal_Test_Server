# 📄 `animation-engine.lua` — Refreshed Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/animation-engine/animation-engine.lua`](../../../animation-engine/animation-engine.lua)  
> **Source lines:** 647  
> **SHA-256 (UTF-8):** `d841a22db32c3ffafde8612167d49dd6b5e97a7b5e983ee95f9cf1846795da3b`  
> **Named/assigned functions detected:** 47  
> **Table initializers detected (simple pattern):** 25

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/animation-engine/animation-engine.lua` from the latest overlaid server archive.

## Dependencies

| Line | `require` module |
|---:|---|
| 9 | `scripts/animation-engine/animation-enums` |
| 10 | `scripts/animation-engine/math-utils` |
| 644 | `scripts/animation-engine/animation-sequences` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 640 | `Net` | `tick` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 33 | `now` | `(none)` | local |
| 37 | `copy_table` | `src` | local |
| 43 | `log` | `message` | local |
| 49 | `generate_animation_id` | `(none)` | local |
| 54 | `generate_sequence_id` | `(none)` | local |
| 59 | `remove_from_tag_sets` | `collection, id` | local |
| 63 | `owner_tag` | `owner` | local |
| 68 | `add_tag` | `collection, tag, id` | local |
| 74 | `AnimationEngine.get_time` | `(none)` | assigned/declared |
| 78 | `AnimationEngine.interpolate` | `start, target, t, easing, discrete` | assigned/declared |
| 113 | `normalized_loop` | `loop_value` | local |
| 121 | `AnimationEngine.animate` | `start_values, target_values, duration, options` | assigned/declared |
| 180 | `complete_animation` | `id, anim, interrupted` | local |
| 189 | `AnimationEngine.update` | `_dt` | assigned/declared |
| 242 | `AnimationEngine.stop_animation` | `id` | assigned/declared |
| 250 | `AnimationEngine.stop_animations_by_tag` | `tag` | assigned/declared |
| 260 | `AnimationEngine.tween` | `object, target_props, duration, options` | assigned/declared |
| 263 | `read_prop` | `key` | local |
| 269 | `apply_prop` | `key, value` | local |
| 288 | `on_update` | `values, t, phase` | assigned/declared |
| 292 | `on_complete` | `_, interrupted` | assigned/declared |
| 298 | `resolve_sequence_value` | `seq, step_index, value` | local |
| 308 | `AnimationEngine.create_sequence` | `steps, options` | assigned/declared |
| 330 | `AnimationEngine.start_sequence` | `id` | assigned/declared |
| 342 | `resolve_step_table` | `seq, step_index, source` | local |
| 364 | `AnimationEngine._execute_sequence_step` | `seq_id` | assigned/declared |
| 385 | `on_complete` | `values, interrupted` | assigned/declared |
| 396 | `done` | `(none)` | local |
| 419 | `AnimationEngine._sequence_step_complete` | `seq_id` | assigned/declared |
| 441 | `AnimationEngine.update_sequences` | `_dt` | assigned/declared |
| 456 | `AnimationEngine.stop_sequence` | `id` | assigned/declared |
| 466 | `AnimationEngine.stop_sequences_by_tag` | `tag` | assigned/declared |
| 476 | `AnimationEngine.animate_discrete_first` | `start_values, target_values, duration, options` | assigned/declared |
| 488 | `on_update` | `values, t, phase` | assigned/declared |
| 504 | `AnimationEngine.set_to` | `object, values` | assigned/declared |
| 528 | `AnimationEngine.delay` | `duration, callback` | assigned/declared |
| 537 | `AnimationEngine.cancel_delay` | `id` | assigned/declared |
| 542 | `AnimationEngine.update_callbacks` | `(none)` | assigned/declared |
| 558 | `AnimationEngine.get_active_count` | `(none)` | assigned/declared |
| 564 | `AnimationEngine.get_sequence_count` | `(none)` | assigned/declared |
| 572 | `AnimationEngine.stop_by_owner` | `owner` | assigned/declared |
| 595 | `AnimationEngine.clear_all` | `(none)` | assigned/declared |
| 609 | `AnimationEngine.tick` | `dt` | assigned/declared |
| 619 | `AnimationEngine.set_debug` | `enabled` | assigned/declared |
| 623 | `AnimationEngine.set_max_tick_dt` | `seconds` | assigned/declared |
| 628 | `AnimationEngine.set_interpolation_speeds` | `position, ro, color, scale` | assigned/declared |
| 635 | `AnimationEngine.add_easing_function` | `name, func` | assigned/declared |

### Detailed parameter inventory

#### 1. `now()`

- **Line:** 33
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 2. `copy_table(src)`

- **Line:** 37
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `src` | Declared by this function; type not inferred. |

#### 3. `log(message)`

- **Line:** 43
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `message` | Declared by this function; type not inferred. |

#### 4. `generate_animation_id()`

- **Line:** 49
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 5. `generate_sequence_id()`

- **Line:** 54
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 6. `remove_from_tag_sets(collection, id)`

- **Line:** 59
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `collection` | Declared by this function; type not inferred. |
| 2 | `id` | Declared by this function; type not inferred. |

#### 7. `owner_tag(owner)`

- **Line:** 63
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `owner` | Declared by this function; type not inferred. |

#### 8. `add_tag(collection, tag, id)`

- **Line:** 68
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `collection` | Declared by this function; type not inferred. |
| 2 | `tag` | Declared by this function; type not inferred. |
| 3 | `id` | Declared by this function; type not inferred. |

#### 9. `AnimationEngine.get_time()`

- **Line:** 74
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 10. `AnimationEngine.interpolate(start, target, t, easing, discrete)`

- **Line:** 78
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `start` | Declared by this function; type not inferred. |
| 2 | `target` | Declared by this function; type not inferred. |
| 3 | `t` | Declared by this function; type not inferred. |
| 4 | `easing` | Declared by this function; type not inferred. |
| 5 | `discrete` | Declared by this function; type not inferred. |

#### 11. `normalized_loop(loop_value)`

- **Line:** 113
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `loop_value` | Declared by this function; type not inferred. |

#### 12. `AnimationEngine.animate(start_values, target_values, duration, options)`

- **Line:** 121
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `start_values` | Declared by this function; type not inferred. |
| 2 | `target_values` | Declared by this function; type not inferred. |
| 3 | `duration` | Declared by this function; type not inferred. |
| 4 | `options` | Declared by this function; type not inferred. |

#### 13. `complete_animation(id, anim, interrupted)`

- **Line:** 180
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared by this function; type not inferred. |
| 2 | `anim` | Declared by this function; type not inferred. |
| 3 | `interrupted` | Declared by this function; type not inferred. |

#### 14. `AnimationEngine.update(_dt)`

- **Line:** 189
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `_dt` | Declared by this function; type not inferred. |

#### 15. `AnimationEngine.stop_animation(id)`

- **Line:** 242
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared by this function; type not inferred. |

#### 16. `AnimationEngine.stop_animations_by_tag(tag)`

- **Line:** 250
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tag` | Declared by this function; type not inferred. |

#### 17. `AnimationEngine.tween(object, target_props, duration, options)`

- **Line:** 260
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `target_props` | Declared by this function; type not inferred. |
| 3 | `duration` | Declared by this function; type not inferred. |
| 4 | `options` | Declared by this function; type not inferred. |

#### 18. `read_prop(key)`

- **Line:** 263
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |

#### 19. `apply_prop(key, value)`

- **Line:** 269
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `key` | Declared by this function; type not inferred. |
| 2 | `value` | Declared by this function; type not inferred. |

#### 20. `on_update(values, t, phase)`

- **Line:** 288
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |
| 2 | `t` | Declared by this function; type not inferred. |
| 3 | `phase` | Declared by this function; type not inferred. |

#### 21. `on_complete(_, interrupted)`

- **Line:** 292
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `_` | Declared by this function; type not inferred. |
| 2 | `interrupted` | Declared by this function; type not inferred. |

#### 22. `resolve_sequence_value(seq, step_index, value)`

- **Line:** 298
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `seq` | Declared by this function; type not inferred. |
| 2 | `step_index` | Declared by this function; type not inferred. |
| 3 | `value` | Declared by this function; type not inferred. |

#### 23. `AnimationEngine.create_sequence(steps, options)`

- **Line:** 308
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `steps` | Declared by this function; type not inferred. |
| 2 | `options` | Declared by this function; type not inferred. |

#### 24. `AnimationEngine.start_sequence(id)`

- **Line:** 330
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared by this function; type not inferred. |

#### 25. `resolve_step_table(seq, step_index, source)`

- **Line:** 342
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `seq` | Declared by this function; type not inferred. |
| 2 | `step_index` | Declared by this function; type not inferred. |
| 3 | `source` | Declared by this function; type not inferred. |

#### 26. `AnimationEngine._execute_sequence_step(seq_id)`

- **Line:** 364
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `seq_id` | Declared by this function; type not inferred. |

#### 27. `on_complete(values, interrupted)`

- **Line:** 385
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |
| 2 | `interrupted` | Declared by this function; type not inferred. |

#### 28. `done()`

- **Line:** 396
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 29. `AnimationEngine._sequence_step_complete(seq_id)`

- **Line:** 419
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `seq_id` | Declared by this function; type not inferred. |

#### 30. `AnimationEngine.update_sequences(_dt)`

- **Line:** 441
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `_dt` | Declared by this function; type not inferred. |

#### 31. `AnimationEngine.stop_sequence(id)`

- **Line:** 456
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared by this function; type not inferred. |

#### 32. `AnimationEngine.stop_sequences_by_tag(tag)`

- **Line:** 466
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tag` | Declared by this function; type not inferred. |

#### 33. `AnimationEngine.animate_discrete_first(start_values, target_values, duration, options)`

- **Line:** 476
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `start_values` | Declared by this function; type not inferred. |
| 2 | `target_values` | Declared by this function; type not inferred. |
| 3 | `duration` | Declared by this function; type not inferred. |
| 4 | `options` | Declared by this function; type not inferred. |

#### 34. `on_update(values, t, phase)`

- **Line:** 488
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |
| 2 | `t` | Declared by this function; type not inferred. |
| 3 | `phase` | Declared by this function; type not inferred. |

#### 35. `AnimationEngine.set_to(object, values)`

- **Line:** 504
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `values` | Declared by this function; type not inferred. |

#### 36. `AnimationEngine.delay(duration, callback)`

- **Line:** 528
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `duration` | Declared by this function; type not inferred. |
| 2 | `callback` | Declared by this function; type not inferred. |

#### 37. `AnimationEngine.cancel_delay(id)`

- **Line:** 537
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `id` | Declared by this function; type not inferred. |

#### 38. `AnimationEngine.update_callbacks()`

- **Line:** 542
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 39. `AnimationEngine.get_active_count()`

- **Line:** 558
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 40. `AnimationEngine.get_sequence_count()`

- **Line:** 564
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 41. `AnimationEngine.stop_by_owner(owner)`

- **Line:** 572
- **Declaration:** table/global or assignment
- **Nearby code comment:** Stop only work registered to a specific owner. Owners are independent of ordinary tags, so an animation may belong to both a feature tag and a player.

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `owner` | Declared by this function; type not inferred. |

#### 42. `AnimationEngine.clear_all()`

- **Line:** 595
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 43. `AnimationEngine.tick(dt)`

- **Line:** 609
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `dt` | Declared by this function; type not inferred. |

#### 44. `AnimationEngine.set_debug(enabled)`

- **Line:** 619
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `enabled` | Declared by this function; type not inferred. |

#### 45. `AnimationEngine.set_max_tick_dt(seconds)`

- **Line:** 623
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `seconds` | Declared by this function; type not inferred. |

#### 46. `AnimationEngine.set_interpolation_speeds(position, ro, color, scale)`

- **Line:** 628
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `position` | Declared by this function; type not inferred. |
| 2 | `ro` | Declared by this function; type not inferred. |
| 3 | `color` | Declared by this function; type not inferred. |
| 4 | `scale` | Declared by this function; type not inferred. |

#### 47. `AnimationEngine.add_easing_function(name, func)`

- **Line:** 635
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared by this function; type not inferred. |
| 2 | `func` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 5 | `AnimationEngine` |
| 13 | `cfg` |
| 24 | `animations` |
| 25 | `sequences` |
| 26 | `callbacks` |
| 27 | `tagged_animations` |
| 28 | `tagged_sequences` |
| 38 | `out` |
| 83 | `discrete_set` |
| 91 | `result` |
| 191 | `ids` |
| 253 | `ids` |
| 274 | `start_props` |
| 320 | `step_data` |
| 343 | `out` |
| 443 | `ready` |
| 469 | `ids` |
| 544 | `ready` |
| 578 | `ids` |
| 586 | `ids` |
| 596 | `anim_ids` |
| 600 | `seq_ids` |
| 604 | `callbacks` |
| 605 | `tagged_animations` |
| 606 | `tagged_sequences` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.on` | 1 | 640 |
