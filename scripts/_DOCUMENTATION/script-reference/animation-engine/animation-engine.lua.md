# `animation-engine/animation-engine.lua`

> **Source reference**
>
> Refreshed from the current `animation-engine/animation-engine.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Reusable animation and interpolation engine. Hardened for server UI use: all timing is driven by Net tick delta_time. No visible animation timing depends on os.clock().

## Module location

- **Source:** `animation-engine/animation-engine.lua`
- **Reference:** `script-reference/animation-engine/animation-engine.lua.md`
- **Source SHA-256 prefix:** `d841a22db32c`

## Source header notes

- Reusable animation and interpolation engine.
- Hardened for server UI use: all timing is driven by Net tick delta_time.
- No visible animation timing depends on os.clock().

## Direct `require` dependencies

| Import path |
|---|
| `scripts/animation-engine/animation-enums` |
| `scripts/animation-engine/math-utils` |
| `scripts/animation-engine/animation-sequences` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `now` | `` |
| `copy_table` | `src` |
| `log` | `message` |
| `generate_animation_id` | `` |
| `generate_sequence_id` | `` |
| `remove_from_tag_sets` | `collection, id` |
| `owner_tag` | `owner` |
| `add_tag` | `collection, tag, id` |
| `AnimationEngine.get_time` | `` |
| `AnimationEngine.interpolate` | `start, target, t, easing, discrete` |
| `normalized_loop` | `loop_value` |
| `AnimationEngine.animate` | `start_values, target_values, duration, options` |
| `complete_animation` | `id, anim, interrupted` |
| `AnimationEngine.update` | `_dt` |
| `AnimationEngine.stop_animation` | `id` |
| `AnimationEngine.stop_animations_by_tag` | `tag` |
| `AnimationEngine.tween` | `object, target_props, duration, options` |
| `read_prop` | `key` |
| `apply_prop` | `key, value` |
| `resolve_sequence_value` | `seq, step_index, value` |
| `AnimationEngine.create_sequence` | `steps, options` |
| `AnimationEngine.start_sequence` | `id` |
| `resolve_step_table` | `seq, step_index, source` |
| `AnimationEngine._execute_sequence_step` | `seq_id` |
| `done` | `` |
| `AnimationEngine._sequence_step_complete` | `seq_id` |
| `AnimationEngine.update_sequences` | `_dt` |
| `AnimationEngine.stop_sequence` | `id` |
| `AnimationEngine.stop_sequences_by_tag` | `tag` |
| `AnimationEngine.animate_discrete_first` | `start_values, target_values, duration, options` |
| `AnimationEngine.set_to` | `object, values` |
| `AnimationEngine.delay` | `duration, callback` |
| `AnimationEngine.cancel_delay` | `id` |
| `AnimationEngine.update_callbacks` | `` |
| `AnimationEngine.get_active_count` | `` |
| `AnimationEngine.get_sequence_count` | `` |
| `AnimationEngine.stop_by_owner` | `owner` |
| `AnimationEngine.clear_all` | `` |
| `AnimationEngine.tick` | `dt` |
| `AnimationEngine.set_debug` | `enabled` |
| `AnimationEngine.set_max_tick_dt` | `seconds` |
| `AnimationEngine.set_interpolation_speeds` | `position, ro, color, scale` |
| `AnimationEngine.add_easing_function` | `name, func` |
| `on_update` | `values, t, phase` |
| `on_complete` | `_, interrupted` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
