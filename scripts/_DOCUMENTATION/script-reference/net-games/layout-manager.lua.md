# `net-games/layout-manager.lua`

> **Source reference**
>
> Generated from `net-games/layout-manager.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

layout_manager.lua A comprehensive layout system for managing sprites, resources, and animations. Integrates with Net Games framework, AnimationEngine, and sound effects.

## Module location

- **Source:** `net-games/layout-manager.lua`
- **Relative reference:** `script-reference/net-games/layout-manager.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/animation-engine/animation-engine` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/animation-engine/animation-sequences` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/boom/main` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `LayoutManager.add_sprite` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.add_sprite_animated` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.animate_layout_property` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.animate_sprite_property` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.arrange_layout` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.clear_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.create_layout` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.get_sprite_proxy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.move_sprite_after` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.move_sprite_after_animated` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.move_sprite_before` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.move_sprite_before_animated` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.on_tick` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.remove_layout` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.remove_sprite` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.remove_sprite_animated` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.reorder_sprite` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.reorder_sprite_animated` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.set_layout_property` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.set_sprite_property` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.swap_sprites` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `LayoutManager.swap_sprites_animated` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `animate_sprites_to_positions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `apply_positions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `capture_positions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `compute_final_positions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `compute_position` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_resource` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_layout` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_sprite` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `mark_dirty` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_complete` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_update` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `process_dirty_layouts` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `recompute_layout` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remove_sprite_instance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `update_sprite_instance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 1233 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
