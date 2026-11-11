# 📄 `animation-sequences.lua` — Refreshed Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/animation-engine/animation-sequences.lua`](../../../animation-engine/animation-sequences.lua)  
> **Source lines:** 1250  
> **SHA-256 (UTF-8):** `cf9a104363e47d5d00fb5824baa8b3cb5120896056b98eda8df7c683fa196efa`  
> **Named/assigned functions detected:** 49  
> **Table initializers detected (simple pattern):** 23

> **Static reference:** All function signatures and argument names come directly from the current Lua. Syntax detection does not prove a function is exported, reachable, or called at runtime. Review source and authored guides for semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/animation-engine/animation-sequences.lua` from the latest overlaid server archive.

## Dependencies

No statically identified literal `require` module strings.

## Event hooks

No named `.on`/`:on` events detected by the simple source pattern.

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 148 | `on_update` | `values, t, phase` | assigned/declared |
| 212 | `on_update` | `values, t, phase` | assigned/declared |
| 279 | `on_update` | `values, t, phase` | assigned/declared |
| 311 | `AnimationSequences.attack` | `object, recoil_offset, lunge_offset, options` | assigned/declared |
| 332 | `on_update` | `values, t, phase` | assigned/declared |
| 377 | `AnimationSequences.slideIn` | `object, start_x, start_y, end_x, end_y, options` | assigned/declared |
| 394 | `on_update` | `values` | assigned/declared |
| 411 | `AnimationSequences.bob` | `object, options` | assigned/declared |
| 437 | `on_update` | `values` | assigned/declared |
| 449 | `AnimationSequences.pulse` | `object, options` | assigned/declared |
| 482 | `on_update` | `values` | assigned/declared |
| 495 | `AnimationSequences.color_pulse` | `object, start_color, target_color, options` | assigned/declared |
| 529 | `on_update` | `values` | assigned/declared |
| 557 | `AnimationSequences.color_pulse_from_current` | `object, target_color, options` | assigned/declared |
| 572 | `AnimationSequences.shake` | `object, options` | assigned/declared |
| 593 | `on_update` | `values, t, phase` | assigned/declared |
| 628 | `AnimationSequences.fade` | `object, target_alpha, options` | assigned/declared |
| 646 | `on_update` | `values` | assigned/declared |
| 665 | `AnimationSequences.tint` | `object, target_r, target_g, target_b, options` | assigned/declared |
| 682 | `on_update` | `values` | assigned/declared |
| 715 | `on_update` | `values, t, phase` | assigned/declared |
| 749 | `on_update` | `values, t, phase` | assigned/declared |
| 765 | `on_update` | `values, t, phase` | assigned/declared |
| 781 | `AnimationSequences.menuCursor` | `object, options` | assigned/declared |
| 811 | `AnimationSequences.highlightCard` | `object, options` | assigned/declared |
| 829 | `on_update` | `values` | assigned/declared |
| 841 | `AnimationSequences.tween` | `object, target_props, duration, options` | assigned/declared |
| 850 | `AnimationSequences.move_to` | `object, target_x, target_y, duration, options` | assigned/declared |
| 858 | `AnimationSequences.scale_to` | `object, target_scale, duration, options` | assigned/declared |
| 866 | `AnimationSequences.rotate_to` | `object, target_angle, duration, options` | assigned/declared |
| 874 | `AnimationSequences.fade_to` | `object, target_alpha, duration, options` | assigned/declared |
| 882 | `AnimationSequences.tint_to` | `object, target_r, target_g, target_b, duration, options` | assigned/declared |
| 890 | `AnimationSequences.color_pulse_to` | `object, target_r, target_g, target_b, target_a, duration, easing, on_complete, loop, ping_pong, easing_back, discrete, tag` | assigned/declared |
| 921 | `AnimationSequences.move_to_discrete_first` | `object, target_x, target_y, duration, options` | assigned/declared |
| 934 | `on_update` | `values` | assigned/declared |
| 957 | `AnimationSequences.series` | `objects, animator, options` | assigned/declared |
| 1002 | `run` | `done` | assigned/declared |
| 1004 | `safe_done` | `(none)` | local |
| 1028 | `anim_opts.on_complete` | `...` | assigned/declared |
| 1076 | `AnimationSequences.marquee` | `object, distance, duration, options` | assigned/declared |
| 1105 | `on_update` | `values, t, phase` | assigned/declared |
| 1111 | `on_complete` | `values, interrupted` | assigned/declared |
| 1129 | `AnimationSequences.typewriter` | `sprites, options` | assigned/declared |
| 1155 | `on_update` | `v` | assigned/declared |
| 1169 | `run` | `done` | assigned/declared |
| 1205 | `on_complete` | `(none)` | assigned/declared |
| 1219 | `AnimationSequences.stopAll` | `tag` | assigned/declared |
| 1229 | `AnimationSequences.isAnimating` | `tag` | assigned/declared |
| 1235 | `AnimationSequences.reset` | `object, initial_values` | assigned/declared |

### Detailed parameter inventory

#### 1. `on_update(values, t, phase)`

- **Line:** 148
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |
| 2 | `t` | Declared by this function; type not inferred. |
| 3 | `phase` | Declared by this function; type not inferred. |

#### 2. `on_update(values, t, phase)`

- **Line:** 212
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |
| 2 | `t` | Declared by this function; type not inferred. |
| 3 | `phase` | Declared by this function; type not inferred. |

#### 3. `on_update(values, t, phase)`

- **Line:** 279
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |
| 2 | `t` | Declared by this function; type not inferred. |
| 3 | `phase` | Declared by this function; type not inferred. |

#### 4. `AnimationSequences.attack(object, recoil_offset, lunge_offset, options)`

- **Line:** 311
- **Declaration:** table/global or assignment
- **Nearby code comment:** Create an attack animation (recoil then lunge)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `recoil_offset` | Declared by this function; type not inferred. |
| 3 | `lunge_offset` | Declared by this function; type not inferred. |
| 4 | `options` | Declared by this function; type not inferred. |

#### 5. `on_update(values, t, phase)`

- **Line:** 332
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |
| 2 | `t` | Declared by this function; type not inferred. |
| 3 | `phase` | Declared by this function; type not inferred. |

#### 6. `AnimationSequences.slideIn(object, start_x, start_y, end_x, end_y, options)`

- **Line:** 377
- **Declaration:** table/global or assignment
- **Nearby code comment:** Create a slide animation (move from offscreen to position)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `start_x` | Declared by this function; type not inferred. |
| 3 | `start_y` | Declared by this function; type not inferred. |
| 4 | `end_x` | Declared by this function; type not inferred. |
| 5 | `end_y` | Declared by this function; type not inferred. |
| 6 | `options` | Declared by this function; type not inferred. |

#### 7. `on_update(values)`

- **Line:** 394
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |

#### 8. `AnimationSequences.bob(object, options)`

- **Line:** 411
- **Declaration:** table/global or assignment
- **Nearby code comment:** Create a bob animation (up and down movement)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `options` | Declared by this function; type not inferred. |

#### 9. `on_update(values)`

- **Line:** 437
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |

#### 10. `AnimationSequences.pulse(object, options)`

- **Line:** 449
- **Declaration:** table/global or assignment
- **Nearby code comment:** Create a pulse animation (scale and alpha pulsing)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `options` | Declared by this function; type not inferred. |

#### 11. `on_update(values)`

- **Line:** 482
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |

#### 12. `AnimationSequences.color_pulse(object, start_color, target_color, options)`

- **Line:** 495
- **Declaration:** table/global or assignment
- **Nearby code comment:** Create a color pulse animation (transition between two color sets)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `start_color` | Declared by this function; type not inferred. |
| 3 | `target_color` | Declared by this function; type not inferred. |
| 4 | `options` | Declared by this function; type not inferred. |

#### 13. `on_update(values)`

- **Line:** 529
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |

#### 14. `AnimationSequences.color_pulse_from_current(object, target_color, options)`

- **Line:** 557
- **Declaration:** table/global or assignment
- **Nearby code comment:** Alternative version that uses the object's current color as starting point

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `target_color` | Declared by this function; type not inferred. |
| 3 | `options` | Declared by this function; type not inferred. |

#### 15. `AnimationSequences.shake(object, options)`

- **Line:** 572
- **Declaration:** table/global or assignment
- **Nearby code comment:** Create a shake animation (screen shake effect)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `options` | Declared by this function; type not inferred. |

#### 16. `on_update(values, t, phase)`

- **Line:** 593
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |
| 2 | `t` | Declared by this function; type not inferred. |
| 3 | `phase` | Declared by this function; type not inferred. |

#### 17. `AnimationSequences.fade(object, target_alpha, options)`

- **Line:** 628
- **Declaration:** table/global or assignment
- **Nearby code comment:** Create a fade animation (fade in/out)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `target_alpha` | Declared by this function; type not inferred. |
| 3 | `options` | Declared by this function; type not inferred. |

#### 18. `on_update(values)`

- **Line:** 646
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |

#### 19. `AnimationSequences.tint(object, target_r, target_g, target_b, options)`

- **Line:** 665
- **Declaration:** table/global or assignment
- **Nearby code comment:** Create a color tint animation

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `target_r` | Declared by this function; type not inferred. |
| 3 | `target_g` | Declared by this function; type not inferred. |
| 4 | `target_b` | Declared by this function; type not inferred. |
| 5 | `options` | Declared by this function; type not inferred. |

#### 20. `on_update(values)`

- **Line:** 682
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |

#### 21. `on_update(values, t, phase)`

- **Line:** 715
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |
| 2 | `t` | Declared by this function; type not inferred. |
| 3 | `phase` | Declared by this function; type not inferred. |

#### 22. `on_update(values, t, phase)`

- **Line:** 749
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |
| 2 | `t` | Declared by this function; type not inferred. |
| 3 | `phase` | Declared by this function; type not inferred. |

#### 23. `on_update(values, t, phase)`

- **Line:** 765
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |
| 2 | `t` | Declared by this function; type not inferred. |
| 3 | `phase` | Declared by this function; type not inferred. |

#### 24. `AnimationSequences.menuCursor(object, options)`

- **Line:** 781
- **Declaration:** table/global or assignment
- **Nearby code comment:** Create a menu cursor animation (bob + pulse)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `options` | Declared by this function; type not inferred. |

#### 25. `AnimationSequences.highlightCard(object, options)`

- **Line:** 811
- **Declaration:** table/global or assignment
- **Nearby code comment:** Create a card highlight animation (lift + glow)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `options` | Declared by this function; type not inferred. |

#### 26. `on_update(values)`

- **Line:** 829
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |

#### 27. `AnimationSequences.tween(object, target_props, duration, options)`

- **Line:** 841
- **Declaration:** table/global or assignment
- **Nearby code comment:** --------------------------------------------------------------------------- Tween: Simple property animation for any object ---------------------------------------------------------------------------

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `target_props` | Declared by this function; type not inferred. |
| 3 | `duration` | Declared by this function; type not inferred. |
| 4 | `options` | Declared by this function; type not inferred. |

#### 28. `AnimationSequences.move_to(object, target_x, target_y, duration, options)`

- **Line:** 850
- **Declaration:** table/global or assignment
- **Nearby code comment:** Simple move animation with looping support

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `target_x` | Declared by this function; type not inferred. |
| 3 | `target_y` | Declared by this function; type not inferred. |
| 4 | `duration` | Declared by this function; type not inferred. |
| 5 | `options` | Declared by this function; type not inferred. |

#### 29. `AnimationSequences.scale_to(object, target_scale, duration, options)`

- **Line:** 858
- **Declaration:** table/global or assignment
- **Nearby code comment:** Scale animation with looping support

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `target_scale` | Declared by this function; type not inferred. |
| 3 | `duration` | Declared by this function; type not inferred. |
| 4 | `options` | Declared by this function; type not inferred. |

#### 30. `AnimationSequences.rotate_to(object, target_angle, duration, options)`

- **Line:** 866
- **Declaration:** table/global or assignment
- **Nearby code comment:** Rotation animation with looping support

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `target_angle` | Declared by this function; type not inferred. |
| 3 | `duration` | Declared by this function; type not inferred. |
| 4 | `options` | Declared by this function; type not inferred. |

#### 31. `AnimationSequences.fade_to(object, target_alpha, duration, options)`

- **Line:** 874
- **Declaration:** table/global or assignment
- **Nearby code comment:** Fade animation with looping support

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `target_alpha` | Declared by this function; type not inferred. |
| 3 | `duration` | Declared by this function; type not inferred. |
| 4 | `options` | Declared by this function; type not inferred. |

#### 32. `AnimationSequences.tint_to(object, target_r, target_g, target_b, duration, options)`

- **Line:** 882
- **Declaration:** table/global or assignment
- **Nearby code comment:** Color tint animation with looping support

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `target_r` | Declared by this function; type not inferred. |
| 3 | `target_g` | Declared by this function; type not inferred. |
| 4 | `target_b` | Declared by this function; type not inferred. |
| 5 | `duration` | Declared by this function; type not inferred. |
| 6 | `options` | Declared by this function; type not inferred. |

#### 33. `AnimationSequences.color_pulse_to(object, target_r, target_g, target_b, target_a, duration, easing, on_complete, loop, ping_pong, easing_back, discrete, tag)`

- **Line:** 890
- **Declaration:** table/global or assignment
- **Nearby code comment:** Color pulse animation with looping support (convenience wrapper)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `target_r` | Declared by this function; type not inferred. |
| 3 | `target_g` | Declared by this function; type not inferred. |
| 4 | `target_b` | Declared by this function; type not inferred. |
| 5 | `target_a` | Declared by this function; type not inferred. |
| 6 | `duration` | Declared by this function; type not inferred. |
| 7 | `easing` | Declared by this function; type not inferred. |
| 8 | `on_complete` | Declared by this function; type not inferred. |
| 9 | `loop` | Declared by this function; type not inferred. |
| 10 | `ping_pong` | Declared by this function; type not inferred. |
| 11 | `easing_back` | Declared by this function; type not inferred. |
| 12 | `discrete` | Declared by this function; type not inferred. |
| 13 | `tag` | Declared by this function; type not inferred. |

#### 34. `AnimationSequences.move_to_discrete_first(object, target_x, target_y, duration, options)`

- **Line:** 921
- **Declaration:** table/global or assignment
- **Nearby code comment:** Discrete-first move animation

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `target_x` | Declared by this function; type not inferred. |
| 3 | `target_y` | Declared by this function; type not inferred. |
| 4 | `duration` | Declared by this function; type not inferred. |
| 5 | `options` | Declared by this function; type not inferred. |

#### 35. `on_update(values)`

- **Line:** 934
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |

#### 36. `AnimationSequences.series(objects, animator, options)`

- **Line:** 957
- **Declaration:** table/global or assignment
- **Nearby code comment:** Apply an animation to many objects in series (one after another).

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `objects` | Declared by this function; type not inferred. |
| 2 | `animator` | Declared by this function; type not inferred. |
| 3 | `options` | Declared by this function; type not inferred. |

#### 37. `run(done)`

- **Line:** 1002
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `done` | Declared by this function; type not inferred. |

#### 38. `safe_done()`

- **Line:** 1004
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 39. `anim_opts.on_complete(...)`

- **Line:** 1028
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `...` | Declared by this function; type not inferred. |

#### 40. `AnimationSequences.marquee(object, distance, duration, options)`

- **Line:** 1076
- **Declaration:** table/global or assignment
- **Nearby code comment:** Move an object horizontally, optionally looping (ping‑pong).

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `distance` | Declared by this function; type not inferred. |
| 3 | `duration` | Declared by this function; type not inferred. |
| 4 | `options` | Declared by this function; type not inferred. |

#### 41. `on_update(values, t, phase)`

- **Line:** 1105
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |
| 2 | `t` | Declared by this function; type not inferred. |
| 3 | `phase` | Declared by this function; type not inferred. |

#### 42. `on_complete(values, interrupted)`

- **Line:** 1111
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared by this function; type not inferred. |
| 2 | `interrupted` | Declared by this function; type not inferred. |

#### 43. `AnimationSequences.typewriter(sprites, options)`

- **Line:** 1129
- **Declaration:** table/global or assignment
- **Nearby code comment:** Reveal a list of sprite objects in sequence (like a typewriter).

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprites` | Declared by this function; type not inferred. |
| 2 | `options` | Declared by this function; type not inferred. |

#### 44. `on_update(v)`

- **Line:** 1155
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `v` | Declared by this function; type not inferred. |

#### 45. `run(done)`

- **Line:** 1169
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `done` | Declared by this function; type not inferred. |

#### 46. `on_complete()`

- **Line:** 1205
- **Declaration:** table/global or assignment
- **Parameters:** none explicitly declared.

#### 47. `AnimationSequences.stopAll(tag)`

- **Line:** 1219
- **Declaration:** table/global or assignment
- **Nearby code comment:** Stop all animations for an object (by tag)

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tag` | Declared by this function; type not inferred. |

#### 48. `AnimationSequences.isAnimating(tag)`

- **Line:** 1229
- **Declaration:** table/global or assignment
- **Nearby code comment:** Check if any animations are running for a tag

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tag` | Declared by this function; type not inferred. |

#### 49. `AnimationSequences.reset(object, initial_values)`

- **Line:** 1235
- **Declaration:** table/global or assignment
- **Nearby code comment:** Reset object to its initial state

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared by this function; type not inferred. |
| 2 | `initial_values` | Declared by this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 5 | `AnimationSequences` |
| 21 | `AnimationSequences.config` |
| 27 | `summon` |
| 36 | `position_change` |
| 44 | `attack` |
| 54 | `slide` |
| 60 | `bob` |
| 69 | `pulse` |
| 81 | `shake` |
| 89 | `fade` |
| 95 | `color_pulse` |
| 103 | `marquee` |
| 112 | `typewriter` |
| 390 | `start` |
| 391 | `target` |
| 561 | `current_color` |
| 707 | `sequence_steps` |
| 891 | `options` |
| 903 | `current_color` |
| 910 | `target_color` |
| 981 | `list` |
| 994 | `steps` |
| 1164 | `steps` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.play_sound_for_player` | 5 | 1092 |
