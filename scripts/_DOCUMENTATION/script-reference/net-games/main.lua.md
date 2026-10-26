# `net-games/main.lua`

> **Source reference**
>
> Refreshed from the current `net-games/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `net-games/main.lua`
- **Reference:** `script-reference/net-games/main.lua.md`
- **Source SHA-256 prefix:** `7797159ae87c`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/displayer/displayer` |
| `scripts/animation-engine/animation-engine` |
| `scripts/boom/main` |
| `scripts/input-controller/main` |

## `Net:on` subscriptions

| Event |
|---|
| `player_request` |
| `virtual_input` |
| `tick` |
| `cursor_move` |
| `player_join` |
| `player_disconnect` |
| `player_move` |
| `player_area_transfer` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `round_fraction` | `value, denominator` |
| `convertOffsets` | `horizontalOffset, verticalOffset, Z` |
| `fixOffsets` | `a, b` |
| `normalize_color` | `color` |
| `async` | `p` |
| `await` | `v` |
| `table_has_value` | `tab, val` |
| `exclude_except_for` | `player_id, bot_id` |
| `try_move_player` | `player_id, area_id, x, y, z` |
| `try_animate_player` | `player_id, anim_state` |
| `frame.move_frozen_player` | `player_id, x, y, z` |
| `frame.animate_frozen_player` | `player_id, anim_state` |
| `frame.set_cosmetic` | `cosmetic_id, player_id, texture, animation, state, x, y, visible, player_xoffset, player_yoffset, anim_duration, scale, bot_scale` |
| `frame.remove_cosmetic` | `cosmetic_id, player_id` |
| `frame.add_map_element` | `name, player_id, texture, animation, animation_state, x, y, z, exclude` |
| `frame.change_map_element` | `name, player_id, animation_state, loop` |
| `frame.move_map_element` | `name, player_id, x, y, z` |
| `frame.remove_map_element` | `name, player_id` |
| `compute_aligned_position` | `element` |
| `frame.update_ui_element` | `sprite_id, player_id, properties` |
| `frame.set_ui_animation` | `sprite_id, player_id, animation_state` |
| `frame.remove_ui_element` | `sprite_id, player_id` |
| `frame.get_ui_element_proxy` | `sprite_id, player_id` |
| `frame.slide_ui_element` | `sprite_id, player_id, target_x, target_y, duration, easing, on_complete` |
| `frame.relative_slide_ui_element` | `sprite_id, player_id, offset_x, offset_y, duration, easing, on_complete` |
| `frame.set_slide_ui_element` | `sprite_id, player_id, start_x, start_y, target_x, target_y, duration, easing, on_complete` |
| `frame.move_ui_element` | `sprite_id, player_id, offset_x, offset_y, duration, easing, on_complete` |
| `frame.scale_ui_element` | `sprite_id, player_id, target_scale, duration, easing, on_complete` |
| `frame.relative_scale_ui_element` | `sprite_id, player_id, offset_scale, duration, easing, on_complete` |
| `frame.rotate_ui_element` | `sprite_id, player_id, target_rotation, duration, easing, on_complete` |
| `frame.relative_rotate_ui_element` | `sprite_id, player_id, offset_rotation, duration, easing, on_complete` |
| `frame.transform_ui_element` | `sprite_id, player_id, properties, duration, easing, on_complete` |
| `frame.relative_transform_ui_element` | `sprite_id, player_id, offset_properties, duration, easing, on_complete` |
| `frame.bob_ui_element` | `sprite_id, player_id, distance, duration, easing, loop, ping_pong` |
| `frame.pulse_scale_ui_element` | `sprite_id, player_id, min_scale, max_scale, pulse_duration, easing, loops, on_complete` |
| `frame.color_pulse_from_current` | `sprite_id, player_id, target_color` |
| `frame.summon_ui_element_relative` | `sprite_id, player_id, end_x, end_y, end_scale, duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete` |
| `frame.set_opacity_ui_element` | `sprite_id, player_id, target_opacity, duration, easing, on_complete` |
| `frame.relative_set_opacity_ui_element` | `sprite_id, player_id, offset_opacity, duration, easing, on_complete` |
| `frame.set_ui_element_color` | `sprite_id, player_id, r, g, b, duration, easing, on_complete` |
| `frame.relative_set_ui_element_color` | `sprite_id, player_id, offset_r, offset_g, offset_b, duration, easing, on_complete` |
| `frame.color_pulse_ui_element` | `sprite_id, player_id, start_color, target_color` |
| `frame.menu_cursor_ui_element` | `sprite_id, player_id, bob_distance, pulse_scale, bob_duration, pulse_duration, orientation, easing, back_easing, on_complete` |
| `frame.shake_ui_element` | `sprite_id, player_id, intensity, duration, frequency, on_complete` |
| `frame.set_ui_element_instant` | `sprite_id, player_id, properties` |
| `frame.reset_ui_element` | `sprite_id, player_id, initial_values` |
| `frame.stop_ui_animation` | `sprite_id, player_id, anim_id` |
| `frame.has_active_animations` | `sprite_id, player_id` |
| `frame.is_animation_running` | `sprite_id, player_id, anim_id` |
| `frame.get_ui_element_properties` | `sprite_id, player_id` |
| `frame.spawn_cursor` | `sprite_id, player_id, options` |
| `frame.remove_cursor` | `cursor_id, player_id` |
| `frame.move_cursor_to_selection` | `cursor_id, player_id, selection_name` |
| `frame.get_current_cursor_selection` | `cursor_id, player_id` |
| `frame.lock_cursor` | `cursor_id, player_id, locked` |
| `frame.is_cursor_locked` | `cursor_id, player_id` |
| `frame.update_cursor_options` | `cursor_id, player_id, new_options` |
| `frame.detach_camera` | `player_id` |
| `frame.draw_text` | `text_id, player_id, text, x, y, z, font, scale` |
| `frame.update_text` | `text_id, player_id, text` |
| `frame.remove_text` | `text_id, player_id` |
| `frame.draw_advanced_text` | `player_id, text, opts` |
| `frame.draw_marquee_text` | `marquee_id, player_id, text, y, font, scale, z_order, speed, backdrop` |
| `frame.set_marquee_position` | `player_id, marquee_id, x, y` |
| `frame.set_marquee_speed` | `player_id, marquee_id, speed` |
| `frame.spawn_timer` | `timer_id, player_id, x, y, duration, loop` |
| `frame.resume_timer` | `timer_id, player_id` |
| `frame.pause_timer` | `timer_id, player_id` |
| `frame.remove_timer` | `timer_id, player_id` |
| `frame.update_timer` | `timer_id, player_id, duration` |
| `frame.spawn_countdown` | `countdown_id, player_id, x, y, duration, loop` |
| `frame.resume_countdown` | `countdown_id, player_id` |
| `frame.pause_countdown` | `countdown_id, player_id` |
| `frame.remove_countdown` | `countdown_id, player_id` |
| `frame.update_countdown` | `countdown_id, player_id, duration` |
| `splitter` | `inputstr, sep` |
| `setPosition` | `self, x, y` |
| `setScale` | `self, sx, sy` |
| `setRotation` | `self, ro` |
| `setOpacity` | `self, opacity` |
| `setColor` | `self, r, g, b, a` |
| `setRo` | `self, ro` |
| `on_update` | `values` |
| `on_complete` | `values, interrupted` |
| `setAlpha` | `self, alpha` |
| `stop` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`exclude_actor_for_player`, `on`, `provide_asset_for_player`, `transfer_player`, `move_player`, `set_player_position`, `animate_player_properties`, `set_player_animation`, `get_player_area`, `get_player_position`, `player_alloc_sprite`, `player_draw_sprite`, `create_bot`, `animate_bot`, `animate_bot_properties`, `is_bot`, `remove_bot`, `player_erase_sprite`, `player_dealloc_sprite`, `transfer_bot`, `lock_player_input`, `unlock_player_input`, `emit`, `get_bot_position`, `move_bot`

## Engine `Async` calls

`promisify`, `await`, `sleep`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/fonts/fonts_compressed.png` |
| `/server/assets/net-games/fonts/fonts_wide.animation` |
| `/server/assets/net-games/fonts/fonts_gradient.animation` |
| `/server/assets/net-games/fonts/fonts_thick.animation` |
| `/server/assets/net-games/fonts/fonts_battle.animation` |
| `/server/assets/net-games/fonts/fonts_thin.animation` |
| `/server/assets/net-games/fonts/fonts_tiny.animation` |
| `/server/assets/net-games/fonts/fonts_compressed.animation` |
| `/server/assets/net-games/fonts/fonts_dark_compressed.png` |
| `/server/assets/net-games/fonts/fonts_dark_compressed.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
