# `animation-engine/animation-sequences.lua`

> **Source reference**
>
> Refreshed from the current `animation-engine/animation-sequences.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

animation-sequences.lua General purpose animation sequences that mimic duels.lua behaviors Works with any sprite_id and object properties

## Module location

- **Source:** `animation-engine/animation-sequences.lua`
- **Reference:** `script-reference/animation-engine/animation-sequences.lua.md`
- **Source SHA-256 prefix:** `cf9a104363e4`

## Source header notes

- animation-sequences.lua
- General purpose animation sequences that mimic duels.lua behaviors
- Works with any sprite_id and object properties

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `AnimationSequences.attack` | `object, recoil_offset, lunge_offset, options` |
| `AnimationSequences.slideIn` | `object, start_x, start_y, end_x, end_y, options` |
| `AnimationSequences.bob` | `object, options` |
| `AnimationSequences.pulse` | `object, options` |
| `AnimationSequences.color_pulse` | `object, start_color, target_color, options` |
| `AnimationSequences.color_pulse_from_current` | `object, target_color, options` |
| `AnimationSequences.shake` | `object, options` |
| `AnimationSequences.fade` | `object, target_alpha, options` |
| `AnimationSequences.tint` | `object, target_r, target_g, target_b, options` |
| `AnimationSequences.menuCursor` | `object, options` |
| `AnimationSequences.highlightCard` | `object, options` |
| `AnimationSequences.tween` | `object, target_props, duration, options` |
| `AnimationSequences.move_to` | `object, target_x, target_y, duration, options` |
| `AnimationSequences.scale_to` | `object, target_scale, duration, options` |
| `AnimationSequences.rotate_to` | `object, target_angle, duration, options` |
| `AnimationSequences.fade_to` | `object, target_alpha, duration, options` |
| `AnimationSequences.tint_to` | `object, target_r, target_g, target_b, duration, options` |
| `AnimationSequences.color_pulse_to` | `object, target_r, target_g, target_b, target_a, duration, easing, on_complete, loop, ping_pong, easing_back, discrete, tag` |
| `AnimationSequences.move_to_discrete_first` | `object, target_x, target_y, duration, options` |
| `AnimationSequences.series` | `objects, animator, options` |
| `safe_done` | `` |
| `AnimationSequences.marquee` | `object, distance, duration, options` |
| `AnimationSequences.typewriter` | `sprites, options` |
| `AnimationSequences.stopAll` | `tag` |
| `AnimationSequences.isAnimating` | `tag` |
| `AnimationSequences.reset` | `object, initial_values` |
| `on_update` | `values, t, phase` |
| `run` | `done` |
| `anim_opts.on_complete` | `...` |
| `on_complete` | `values, interrupted` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`play_sound_for_player`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
