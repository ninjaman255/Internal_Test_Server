# `animation-engine/animation-engine.lua`

> **Source reference**
>
> Generated from `animation-engine/animation-engine.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

Reusable animation and interpolation engine. Hardened for server UI use: all timing is driven by Net tick delta_time. No visible animation timing depends on os.clock().

## Module location

- **Source:** `animation-engine/animation-engine.lua`
- **Relative reference:** `script-reference/animation-engine/animation-engine.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/animation-engine/animation-enums` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/animation-engine/animation-sequences` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/animation-engine/math-utils` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `AnimationEngine._execute_sequence_step` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine._sequence_step_complete` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.add_easing_function` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.animate` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.animate_discrete_first` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.cancel_delay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.clear_all` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.create_sequence` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.delay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.get_active_count` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.get_sequence_count` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.get_time` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.interpolate` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.set_debug` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.set_interpolation_speeds` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.set_max_tick_dt` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.set_to` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.start_sequence` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.stop_animation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.stop_animations_by_tag` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.stop_by_owner` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.stop_sequence` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.stop_sequences_by_tag` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.tick` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.tween` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.update` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.update_callbacks` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationEngine.update_sequences` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `add_tag` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `apply_prop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `complete_animation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `copy_table` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `done` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `generate_animation_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `generate_sequence_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `log` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalized_loop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `now` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_complete` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_update` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `owner_tag` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `read_prop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remove_from_tag_sets` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_sequence_value` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_step_table` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 647 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
