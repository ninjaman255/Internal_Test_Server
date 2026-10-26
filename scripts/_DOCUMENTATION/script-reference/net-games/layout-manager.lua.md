# `net-games/layout-manager.lua`

> **Source reference**
>
> Refreshed from the current `net-games/layout-manager.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

layout_manager.lua A comprehensive layout system for managing sprites, resources, and animations. Integrates with Net Games framework, AnimationEngine, and sound effects.

## Module location

- **Source:** `net-games/layout-manager.lua`
- **Reference:** `script-reference/net-games/layout-manager.lua.md`
- **Source SHA-256 prefix:** `ef14b279e316`

## Source header notes

- layout_manager.lua
- A comprehensive layout system for managing sprites, resources, and animations.
- Integrates with Net Games framework, AnimationEngine, and sound effects.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/animation-engine/animation-engine` |
| `scripts/animation-engine/animation-sequences` |
| `scripts/boom/main` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `get_layout` | `player_id, layout_id` |
| `get_sprite` | `player_id, layout_id, object_id` |
| `ensure_resource` | `player_id, resource_id, texture_path, anim_path, anim_state` |
| `update_sprite_instance` | `player_id, instance_id, resource_id, properties, layout_properties` |
| `remove_sprite_instance` | `player_id, instance_id` |
| `compute_position` | `layout, index, use_order` |
| `recompute_layout` | `layout` |
| `mark_dirty` | `player_id, layout_id` |
| `process_dirty_layouts` | `` |
| `LayoutManager.create_layout` | `player_id, layout_id, options` |
| `LayoutManager.add_sprite` | `player_id, layout_id, resource_id, object_id, properties` |
| `LayoutManager.remove_sprite` | `player_id, layout_id, object_id, properties` |
| `LayoutManager.remove_layout` | `player_id, layout_id` |
| `LayoutManager.arrange_layout` | `player_id, layout_id` |
| `LayoutManager.set_layout_property` | `player_id, layout_id, property, value, mode, duration, easing, sound` |
| `LayoutManager.set_sprite_property` | `player_id, layout_id, object_id, property, value, mode, duration, easing, sound` |
| `LayoutManager.get_sprite_proxy` | `player_id, layout_id, object_id` |
| `LayoutManager.animate_layout_property` | `player_id, layout_id, property, target, duration, options` |
| `LayoutManager.animate_sprite_property` | `player_id, layout_id, object_id, property, target, duration, options` |
| `LayoutManager.reorder_sprite` | `player_id, layout_id, object_id, new_index` |
| `LayoutManager.swap_sprites` | `player_id, layout_id, object_id_a, object_id_b, swap_properties` |
| `LayoutManager.move_sprite_before` | `player_id, layout_id, object_id_to_move, reference_object_id` |
| `LayoutManager.move_sprite_after` | `player_id, layout_id, object_id_to_move, reference_object_id` |
| `capture_positions` | `layout` |
| `apply_positions` | `layout, positions` |
| `compute_final_positions` | `layout, new_order` |
| `animate_sprites_to_positions` | `layout, old_positions, new_positions, duration, easing, on_complete` |
| `LayoutManager.add_sprite_animated` | `player_id, layout_id, resource_id, object_id, properties, anim_options` |
| `LayoutManager.remove_sprite_animated` | `player_id, layout_id, object_id, anim_options` |
| `LayoutManager.swap_sprites_animated` | `player_id, layout_id, object_id_a, object_id_b, swap_properties, anim_options` |
| `LayoutManager.reorder_sprite_animated` | `player_id, layout_id, object_id, new_index, anim_options` |
| `LayoutManager.move_sprite_before_animated` | `player_id, layout_id, object_id_to_move, reference_object_id, anim_options` |
| `LayoutManager.move_sprite_after_animated` | `player_id, layout_id, object_id_to_move, reference_object_id, anim_options` |
| `LayoutManager.on_tick` | `delta_time` |
| `LayoutManager.clear_player` | `player_id` |
| `on_update` | `values` |
| `on_complete` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`provide_asset_for_player`, `player_alloc_sprite`, `player_draw_sprite`, `player_erase_sprite`, `play_sound_for_player`, `on`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
