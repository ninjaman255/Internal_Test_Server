# `net-games/main.lua`

> **Source reference**
>
> Generated from `net-games/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `net-games/main.lua`
- **Relative reference:** `script-reference/net-games/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/animation-engine/animation-engine` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/boom/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/displayer` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input-controller/main` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `cursor_move` | `Net:on(...)` subscription found in source. |
| `player_area_transfer` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |
| `player_move` | `Net:on(...)` subscription found in source. |
| `player_request` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |
| `virtual_input` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `callback` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `compute_aligned_position` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `convertOffsets` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `exclude_except_for` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `fixOffsets` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.add_map_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.add_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.animate_frozen_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.bob_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.change_map_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.color_pulse_from_current` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.color_pulse_rgb` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.color_pulse_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.complex_summon_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.complex_summon_ui_element_relative` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.detach_camera` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.draw_advanced_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.draw_marquee_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.draw_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.get_current_cursor_selection` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.get_ui_element_properties` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.get_ui_element_proxy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.has_active_animations` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.is_animation_running` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.is_cursor_locked` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.lock_cursor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.menu_cursor_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.move_cursor_to_selection` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.move_frozen_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.move_map_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.move_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.pause_countdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.pause_timer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.pulse_scale_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.relative_rotate_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.relative_scale_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.relative_set_opacity_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.relative_set_ui_element_color` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.relative_slide_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.relative_transform_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.remove_cosmetic` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.remove_countdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.remove_cursor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.remove_map_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.remove_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.remove_timer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.remove_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.reset_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.resume_countdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.resume_timer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.rotate_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.scale_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.set_cosmetic` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.set_marquee_position` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.set_marquee_speed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.set_opacity_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.set_slide_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.set_ui_animation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.set_ui_element_color` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.set_ui_element_instant` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.shake_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.slide_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.spawn_countdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.spawn_cursor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.spawn_timer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.stop_ui_animation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.summon_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.summon_ui_element_relative` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.transform_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.update_countdown` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.update_cursor_options` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.update_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.update_timer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `frame.update_ui_element` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_color` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_complete` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_update` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `round_fraction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setAlpha` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setColor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setOpacity` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setPosition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setRo` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setRotation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setScale` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `splitter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `stop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `table_has_value` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `try_animate_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `try_move_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 2664 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
