# 📄 `layout-manager.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/layout-manager.lua`](../../../net-games/layout-manager.lua)  
> **Source lines:** 1233  
> **SHA-256 (UTF-8):** `ef14b279e3168e…`  
> **Declared/assigned functions detected:** 45  
> **Anonymous closures detected:** 7  
> **Table initializers detected:** 34

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

A comprehensive layout system for managing sprites, resources, and animations. Integrates with Net Games framework, AnimationEngine, and sound effects.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 9 | `scripts/animation-engine/animation-engine` |
| 11 | `scripts/animation-engine/animation-sequences` |
| 12 | `scripts/boom/main` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 1210 | `Net:on` | `tick` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 38 | `get_layout` | `player_id, layout_id` | local |
| 47 | `get_sprite` | `player_id, layout_id, object_id` | local |
| 57 | `ensure_resource` | `player_id, resource_id, texture_path, anim_path, anim_state` | local |
| 111 | `update_sprite_instance` | `player_id, instance_id, resource_id, properties, layout_properties` | local |
| 202 | `remove_sprite_instance` | `player_id, instance_id` | local |
| 207 | `compute_position` | `layout, index, use_order` | local |
| 271 | `recompute_layout` | `layout` | local |
| 304 | `mark_dirty` | `player_id, layout_id` | local |
| 311 | `process_dirty_layouts` | `(none)` | local |
| 328 | `LayoutManager.create_layout` | `player_id, layout_id, options` | declared |
| 375 | `LayoutManager.add_sprite` | `player_id, layout_id, resource_id, object_id, properties` | declared |
| 440 | `LayoutManager.remove_sprite` | `player_id, layout_id, object_id, properties` | declared |
| 458 | `LayoutManager.remove_layout` | `player_id, layout_id` | declared |
| 470 | `LayoutManager.arrange_layout` | `player_id, layout_id` | declared |
| 476 | `LayoutManager.set_layout_property` | `player_id, layout_id, property, value, mode, duration, easing, sound` | declared |
| 493 | `on_update` | `values` | assigned |
| 497 | `on_complete` | `(none)` | assigned |
| 514 | `LayoutManager.set_sprite_property` | `player_id, layout_id, object_id, property, value, mode, duration, easing, sound` | declared |
| 544 | `on_update` | `values` | assigned |
| 556 | `on_complete` | `(none)` | assigned |
| 573 | `LayoutManager.get_sprite_proxy` | `player_id, layout_id, object_id` | declared |
| 599 | `LayoutManager.animate_layout_property` | `player_id, layout_id, property, target, duration, options` | declared |
| 610 | `on_update` | `values` | assigned |
| 619 | `LayoutManager.animate_sprite_property` | `player_id, layout_id, object_id, property, target, duration, options` | declared |
| 636 | `on_update` | `values` | assigned |
| 659 | `LayoutManager.reorder_sprite` | `player_id, layout_id, object_id, new_index` | declared |
| 693 | `LayoutManager.swap_sprites` | `player_id, layout_id, object_id_a, object_id_b, swap_properties` | declared |
| 722 | `LayoutManager.move_sprite_before` | `player_id, layout_id, object_id_to_move, reference_object_id` | declared |
| 751 | `LayoutManager.move_sprite_after` | `player_id, layout_id, object_id_to_move, reference_object_id` | declared |
| 784 | `capture_positions` | `layout` | local |
| 793 | `apply_positions` | `layout, positions` | local |
| 805 | `compute_final_positions` | `layout, new_order` | local |
| 815 | `animate_sprites_to_positions` | `layout, old_positions, new_positions, duration, easing, on_complete` | local |
| 830 | `on_complete` | `(none)` | assigned |
| 848 | `LayoutManager.add_sprite_animated` | `player_id, layout_id, resource_id, object_id, properties, anim_options` | declared |
| 933 | `on_complete` | `(none)` | assigned |
| 955 | `on_complete` | `(none)` | assigned |
| 973 | `LayoutManager.remove_sprite_animated` | `player_id, layout_id, object_id, anim_options` | declared |
| 1040 | `on_complete` | `(none)` | assigned |
| 1061 | `LayoutManager.swap_sprites_animated` | `player_id, layout_id, object_id_a, object_id_b, swap_properties, anim_options` | declared |
| 1096 | `LayoutManager.reorder_sprite_animated` | `player_id, layout_id, object_id, new_index, anim_options` | declared |
| 1130 | `LayoutManager.move_sprite_before_animated` | `player_id, layout_id, object_id_to_move, reference_object_id, anim_options` | declared |
| 1165 | `LayoutManager.move_sprite_after_animated` | `player_id, layout_id, object_id_to_move, reference_object_id, anim_options` | declared |
| 1204 | `LayoutManager.on_tick` | `delta_time` | declared |
| 1217 | `LayoutManager.clear_player` | `player_id` | declared |

### Function details

#### 1. `get_layout(player_id, layout_id)`

- **Location:** source line 38.
- **Declaration style:** `local`.
- **Adjacent source comment:** Validate that a player has a layout with given id

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |

#### 2. `get_sprite(player_id, layout_id, object_id)`

- **Location:** source line 47.
- **Declaration style:** `local`.
- **Adjacent source comment:** Validate that a sprite exists in a layout

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id` | Not explicitly documented in adjacent source annotations. |

#### 3. `ensure_resource(player_id, resource_id, texture_path, anim_path, anim_state)`

- **Location:** source line 57.
- **Declaration style:** `local`.
- **Adjacent source comment:** Allocate a sprite resource if not already allocated for the player

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `resource_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `texture_path` | Not explicitly documented in adjacent source annotations. |
| 4 | `anim_path` | Not explicitly documented in adjacent source annotations. |
| 5 | `anim_state` | Not explicitly documented in adjacent source annotations. |

#### 4. `update_sprite_instance(player_id, instance_id, resource_id, properties, layout_properties)`

- **Location:** source line 111.
- **Declaration style:** `local`.
- **Adjacent source comment:** Create or update a sprite instance

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `instance_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `resource_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `properties` | Not explicitly documented in adjacent source annotations. |
| 5 | `layout_properties` | Not explicitly documented in adjacent source annotations. |

#### 5. `remove_sprite_instance(player_id, instance_id)`

- **Location:** source line 202.
- **Declaration style:** `local`.
- **Adjacent source comment:** Remove a sprite instance

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `instance_id` | Not explicitly documented in adjacent source annotations. |

#### 6. `compute_position(layout, index, use_order)`

- **Location:** source line 207.
- **Declaration style:** `local`.
- **Adjacent source comment:** Compute the position of a sprite based on layout mode and index

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `layout` | Not explicitly documented in adjacent source annotations. |
| 2 | `index` | Not explicitly documented in adjacent source annotations. |
| 3 | `use_order` | Not explicitly documented in adjacent source annotations. |

#### 7. `recompute_layout(layout)`

- **Location:** source line 271.
- **Declaration style:** `local`.
- **Adjacent source comment:** Recompute positions for all sprites in a layout and update instances

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `layout` | Not explicitly documented in adjacent source annotations. |

#### 8. `mark_dirty(player_id, layout_id)`

- **Location:** source line 304.
- **Declaration style:** `local`.
- **Adjacent source comment:** Mark a layout as dirty so it will be recomputed on next tick

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |

#### 9. `process_dirty_layouts()`

- **Location:** source line 311.
- **Declaration style:** `local`.
- **Adjacent source comment:** Process all dirty layouts

#### 10. `LayoutManager.create_layout(player_id, layout_id, options)`

- **Location:** source line 328.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Create a new layout for a player

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `options` | Not explicitly documented in adjacent source annotations. |

#### 11. `LayoutManager.add_sprite(player_id, layout_id, resource_id, object_id, properties)`

- **Location:** source line 375.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Add a sprite to a layout

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `resource_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `object_id` | Not explicitly documented in adjacent source annotations. |
| 5 | `properties` | Not explicitly documented in adjacent source annotations. |

#### 12. `LayoutManager.remove_sprite(player_id, layout_id, object_id, properties)`

- **Location:** source line 440.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Remove a sprite from a layout

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `properties` | Not explicitly documented in adjacent source annotations. |

#### 13. `LayoutManager.remove_layout(player_id, layout_id)`

- **Location:** source line 458.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Remove an entire layout (and all its sprites)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |

#### 14. `LayoutManager.arrange_layout(player_id, layout_id)`

- **Location:** source line 470.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Arrange layout (recompute positions) immediately

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |

#### 15. `LayoutManager.set_layout_property(player_id, layout_id, property, value, mode, duration, easing, sound)`

- **Location:** source line 476.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Set a global property on the layout (with optional animation)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `property` | Not explicitly documented in adjacent source annotations. |
| 4 | `value` | Not explicitly documented in adjacent source annotations. |
| 5 | `mode` | Not explicitly documented in adjacent source annotations. |
| 6 | `duration` | Not explicitly documented in adjacent source annotations. |
| 7 | `easing` | Not explicitly documented in adjacent source annotations. |
| 8 | `sound` | Not explicitly documented in adjacent source annotations. |

#### 16. `on_update(values)`

- **Location:** source line 493.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 17. `on_complete()`

- **Location:** source line 497.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 18. `LayoutManager.set_sprite_property(player_id, layout_id, object_id, property, value, mode, duration, easing, sound)`

- **Location:** source line 514.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Set a property on a specific sprite

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `property` | Not explicitly documented in adjacent source annotations. |
| 5 | `value` | Not explicitly documented in adjacent source annotations. |
| 6 | `mode` | Not explicitly documented in adjacent source annotations. |
| 7 | `duration` | Not explicitly documented in adjacent source annotations. |
| 8 | `easing` | Not explicitly documented in adjacent source annotations. |
| 9 | `sound` | Not explicitly documented in adjacent source annotations. |

#### 19. `on_update(values)`

- **Location:** source line 544.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 20. `on_complete()`

- **Location:** source line 556.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 21. `LayoutManager.get_sprite_proxy(player_id, layout_id, object_id)`

- **Location:** source line 573.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Get a proxy object for a sprite (to be used with AnimationEngine.tween)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id` | Not explicitly documented in adjacent source annotations. |

#### 22. `LayoutManager.animate_layout_property(player_id, layout_id, property, target, duration, options)`

- **Location:** source line 599.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Animate a layout property using AnimationEngine.tween (convenience)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `property` | Not explicitly documented in adjacent source annotations. |
| 4 | `target` | Not explicitly documented in adjacent source annotations. |
| 5 | `duration` | Not explicitly documented in adjacent source annotations. |
| 6 | `options` | Not explicitly documented in adjacent source annotations. |

#### 23. `on_update(values)`

- **Location:** source line 610.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 24. `LayoutManager.animate_sprite_property(player_id, layout_id, object_id, property, target, duration, options)`

- **Location:** source line 619.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Animate a sprite property using AnimationEngine.tween

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `property` | Not explicitly documented in adjacent source annotations. |
| 5 | `target` | Not explicitly documented in adjacent source annotations. |
| 6 | `duration` | Not explicitly documented in adjacent source annotations. |
| 7 | `options` | Not explicitly documented in adjacent source annotations. |

#### 25. `on_update(values)`

- **Location:** source line 636.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 26. `LayoutManager.reorder_sprite(player_id, layout_id, object_id, new_index)`

- **Location:** source line 659.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Reorder a sprite to a new position (index) in the layout's ordering. The layout's arrangement order is based on the order in which sprites were added. This function changes that order without affecting existing sprite properties.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `new_index` | Not explicitly documented in adjacent source annotations. |

#### 27. `LayoutManager.swap_sprites(player_id, layout_id, object_id_a, object_id_b, swap_properties)`

- **Location:** source line 693.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Swap the positions of two sprites in the layout (by object_id). This swaps their order and optionally swaps their stored properties.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id_a` | Not explicitly documented in adjacent source annotations. |
| 4 | `object_id_b` | Not explicitly documented in adjacent source annotations. |
| 5 | `swap_properties` | Not explicitly documented in adjacent source annotations. |

#### 28. `LayoutManager.move_sprite_before(player_id, layout_id, object_id_to_move, reference_object_id)`

- **Location:** source line 722.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Move a sprite to a new position (object_id) within the layout, inserting before another sprite.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id_to_move` | Not explicitly documented in adjacent source annotations. |
| 4 | `reference_object_id` | Not explicitly documented in adjacent source annotations. |

#### 29. `LayoutManager.move_sprite_after(player_id, layout_id, object_id_to_move, reference_object_id)`

- **Location:** source line 751.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Move a sprite to a new position (object_id) within the layout, inserting after another sprite.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id_to_move` | Not explicitly documented in adjacent source annotations. |
| 4 | `reference_object_id` | Not explicitly documented in adjacent source annotations. |

#### 30. `capture_positions(layout)`

- **Location:** source line 784.
- **Declaration style:** `local`.
- **Adjacent source comment:** Helper: capture current positions of sprites in a layout

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `layout` | Not explicitly documented in adjacent source annotations. |

#### 31. `apply_positions(layout, positions)`

- **Location:** source line 793.
- **Declaration style:** `local`.
- **Adjacent source comment:** Helper: apply positions to sprites (updates properties and redraws)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `layout` | Not explicitly documented in adjacent source annotations. |
| 2 | `positions` | Not explicitly documented in adjacent source annotations. |

#### 32. `compute_final_positions(layout, new_order)`

- **Location:** source line 805.
- **Declaration style:** `local`.
- **Adjacent source comment:** Helper: compute final positions after a structural change (without modifying layout)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `layout` | Not explicitly documented in adjacent source annotations. |
| 2 | `new_order` | Not explicitly documented in adjacent source annotations. |

#### 33. `animate_sprites_to_positions(layout, old_positions, new_positions, duration, easing, on_complete)`

- **Location:** source line 815.
- **Declaration style:** `local`.
- **Adjacent source comment:** Helper: animate sprites from old positions to new positions

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `layout` | Not explicitly documented in adjacent source annotations. |
| 2 | `old_positions` | Not explicitly documented in adjacent source annotations. |
| 3 | `new_positions` | Not explicitly documented in adjacent source annotations. |
| 4 | `duration` | Not explicitly documented in adjacent source annotations. |
| 5 | `easing` | Not explicitly documented in adjacent source annotations. |
| 6 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 34. `on_complete()`

- **Location:** source line 830.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 35. `LayoutManager.add_sprite_animated(player_id, layout_id, resource_id, object_id, properties, anim_options)`

- **Location:** source line 848.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Add a sprite with an entrance animation

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `resource_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `object_id` | Not explicitly documented in adjacent source annotations. |
| 5 | `properties` | Not explicitly documented in adjacent source annotations. |
| 6 | `anim_options` | Not explicitly documented in adjacent source annotations. |

#### 36. `on_complete()`

- **Location:** source line 933.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 37. `on_complete()`

- **Location:** source line 955.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 38. `LayoutManager.remove_sprite_animated(player_id, layout_id, object_id, anim_options)`

- **Location:** source line 973.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Remove a sprite with an exit animation

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `anim_options` | Not explicitly documented in adjacent source annotations. |

#### 39. `on_complete()`

- **Location:** source line 1040.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 40. `LayoutManager.swap_sprites_animated(player_id, layout_id, object_id_a, object_id_b, swap_properties, anim_options)`

- **Location:** source line 1061.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Swap sprites with animation

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id_a` | Not explicitly documented in adjacent source annotations. |
| 4 | `object_id_b` | Not explicitly documented in adjacent source annotations. |
| 5 | `swap_properties` | Not explicitly documented in adjacent source annotations. |
| 6 | `anim_options` | Not explicitly documented in adjacent source annotations. |

#### 41. `LayoutManager.reorder_sprite_animated(player_id, layout_id, object_id, new_index, anim_options)`

- **Location:** source line 1096.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Reorder sprite with animation

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id` | Not explicitly documented in adjacent source annotations. |
| 4 | `new_index` | Not explicitly documented in adjacent source annotations. |
| 5 | `anim_options` | Not explicitly documented in adjacent source annotations. |

#### 42. `LayoutManager.move_sprite_before_animated(player_id, layout_id, object_id_to_move, reference_object_id, anim_options)`

- **Location:** source line 1130.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Move sprite before another with animation

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id_to_move` | Not explicitly documented in adjacent source annotations. |
| 4 | `reference_object_id` | Not explicitly documented in adjacent source annotations. |
| 5 | `anim_options` | Not explicitly documented in adjacent source annotations. |

#### 43. `LayoutManager.move_sprite_after_animated(player_id, layout_id, object_id_to_move, reference_object_id, anim_options)`

- **Location:** source line 1165.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Move sprite after another with animation

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `layout_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `object_id_to_move` | Not explicitly documented in adjacent source annotations. |
| 4 | `reference_object_id` | Not explicitly documented in adjacent source annotations. |
| 5 | `anim_options` | Not explicitly documented in adjacent source annotations. |

#### 44. `LayoutManager.on_tick(delta_time)`

- **Location:** source line 1204.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Tick handler to process dirty layouts

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `delta_time` | Not explicitly documented in adjacent source annotations. |

#### 45. `LayoutManager.clear_player(player_id)`

- **Location:** source line 1217.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Clear all data for a player (on disconnect)

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 580 | `(none)` | `, prop in ipairs(properties) do proxy["get" .. prop:sub(1,1):upper() .. prop:sub(2)]…` |
| 583 | `self, value` | `te.properties[prop] end proxy["set" .. prop:sub(1,1):upper() .. prop:sub(2)] =` |
| 1088 | `(none)` | `tions animate_sprites_to_positions(layout, old_positions, new_positions, duration, e…` |
| 1122 | `(none)` | `tions animate_sprites_to_positions(layout, old_positions, new_positions, duration, e…` |
| 1157 | `(none)` | `tions animate_sprites_to_positions(layout, old_positions, new_positions, duration, e…` |
| 1192 | `(none)` | `tions animate_sprites_to_positions(layout, old_positions, new_positions, duration, e…` |
| 1210 | `event` | `d -- Register tick handler if not already done if not tick_registered then Net:on("t…` |

## 📦 Tables and data

The following **34** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `LayoutManager` — line 5

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `resources` — line 19

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `instances` — line 22

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `layouts` — line 25

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `dirty_layouts` — line 28

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `state_dimensions` — line 74

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `final` — line 119

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `layout` — line 335

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `id` | expression/reference | `layout_id` |
| `player_id` | expression/reference | `player_id` |
| `mode` | expression/reference | `options.mode or "grid"` |
| `options` | nested table | `{ rows = options.rows, columns = options.columns, spacing_x = options.spacing_x or 0, spacing_y = options.spacing_y or 0, stagger = options.stagger, wrap …` |
| `global_properties` | nested table | `{ scale = { value = options.global_scale or 1, mode = options.global_scale_mode or "relative" }, rotation = { value = options.global_rotation or 0, mode =…` |
| `sprites` | nested table | `{}` |
| `order` | nested table | `{}` |
| `origin_x` | expression/reference | `options.origin_x or 0` |
| `origin_y` | expression/reference | `options.origin_y or 0` |
| `suppress_dirty` | boolean literal | `false` |
| `[11]` | expression/reference | `-- when set to true, dirty flag won't cause recompute` |

### 9. `options` — line 339

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `rows` | expression/reference | `options.rows` |
| `columns` | expression/reference | `options.columns` |
| `spacing_x` | expression/reference | `options.spacing_x or 0` |
| `spacing_y` | expression/reference | `options.spacing_y or 0` |
| `stagger` | expression/reference | `options.stagger` |
| `wrap` | expression/reference | `options.wrap` |
| `restrict_to_bounds` | expression/reference | `options.restrict_to_bounds or false` |
| `scrollable` | expression/reference | `options.scrollable or false` |
| `viewport_offset` | expression/reference | `options.viewport_offset or { x = 0, y = 0 }` |
| `radius` | expression/reference | `options.radius` |
| `offset_x` | expression/reference | `options.offset_x` |
| `offset_y` | expression/reference | `options.offset_y` |

### 10. `global_properties` — line 353

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `scale` | nested table | `{ value = options.global_scale or 1, mode = options.global_scale_mode or "relative" }` |
| `rotation` | nested table | `{ value = options.global_rotation or 0, mode = options.global_rotation_mode or "relative" }` |
| `opacity` | nested table | `{ value = options.global_opacity or 255, mode = options.global_opacity_mode or "relative" }` |
| `color` | nested table | `{ value = options.global_color or { r=255, g=255, b=255 }, mode = options.global_color_mode or "relative" }` |
| `z` | nested table | `{ value = options.global_z or 0, mode = options.global_z_mode or "relative" }` |

### 11. `scale` — line 354

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `value` | expression/reference | `options.global_scale or 1` |
| `mode` | expression/reference | `options.global_scale_mode or "relative"` |

### 12. `rotation` — line 355

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `value` | expression/reference | `options.global_rotation or 0` |
| `mode` | expression/reference | `options.global_rotation_mode or "relative"` |

### 13. `opacity` — line 356

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `value` | expression/reference | `options.global_opacity or 255` |
| `mode` | expression/reference | `options.global_opacity_mode or "relative"` |

### 14. `color` — line 357

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `value` | expression/reference | `options.global_color or { r=255, g=255, b=255 }` |
| `mode` | expression/reference | `options.global_color_mode or "relative"` |

### 15. `z` — line 358

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `value` | expression/reference | `options.global_z or 0` |
| `mode` | expression/reference | `options.global_z_mode or "relative"` |

### 16. `sprites` — line 360

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 17. `order` — line 361

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 18. `sprite_props` — line 400

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `properties.x or 0` |
| `y` | expression/reference | `properties.y or 0` |
| `z` | expression/reference | `properties.z or 0` |
| `sx` | expression/reference | `properties.sx or 1` |
| `sy` | expression/reference | `properties.sy or 1` |
| `ro` | expression/reference | `properties.ro or 0` |
| `ox` | expression/reference | `properties.ox or 0` |
| `oy` | expression/reference | `properties.oy or 0` |
| `a` | expression/reference | `properties.a or 255` |
| `r` | expression/reference | `properties.r or 255` |
| `g` | expression/reference | `properties.g or 255` |
| `b` | expression/reference | `properties.b or 255` |
| `color_mode` | expression/reference | `properties.color_mode or 0` |
| `anim_state` | expression/reference | `current_state` |
| `opacity` | expression/reference | `properties.opacity or 255` |
| `sprite_width` | expression/reference | `sprite_width` |
| `sprite_height` | expression/reference | `sprite_height` |

### 19. `sprite_data` — line 421

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `resource_id` | expression/reference | `resource_id` |
| `object_id` | expression/reference | `object_id` |
| `instance_id` | expression/reference | `instance_id` |
| `properties` | expression/reference | `sprite_props` |

### 20. `target` — line 489

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `value` | expression/reference | `value` |

### 21. `start` — line 490

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `value` | expression/reference | `old_value` |

### 22. `start` — line 530

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 23. `target` — line 532

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 24. `discrete` — line 536

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 25. `proxy` — line 575

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 26. `properties` — line 578

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"x"` |
| `[2]` | string literal | `"y"` |
| `[3]` | string literal | `"z"` |
| `[4]` | string literal | `"sx"` |
| `[5]` | string literal | `"sy"` |
| `[6]` | string literal | `"ro"` |
| `[7]` | string literal | `"ox"` |
| `[8]` | string literal | `"oy"` |
| `[9]` | string literal | `"a"` |
| `[10]` | string literal | `"r"` |
| `[11]` | string literal | `"g"` |
| `[12]` | string literal | `"b"` |
| `[13]` | string literal | `"opacity"` |
| `[14]` | string literal | `"anim_state"` |

### 27. `start` — line 605

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `value` | expression/reference | `prop.value` |

### 28. `target_tbl` — line 606

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `value` | expression/reference | `target` |

### 29. `start` — line 621

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 30. `target_tbl` — line 623

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 31. `positions` — line 785

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 32. `positions` — line 806

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 33. `target` — line 941

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 34. `target` — line 1024

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 1 |
| `Net.play_sound_for_player` | 8 |
| `Net.player_alloc_sprite` | 1 |
| `Net.player_draw_sprite` | 1 |
| `Net.player_erase_sprite` | 1 |
| `Net.provide_asset_for_player` | 2 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
