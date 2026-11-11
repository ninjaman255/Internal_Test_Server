# 📁 net-games

[🏠 Documentation home](../index.md) · [⬆ Parent folder](../index.md)
> **Current PlayerControl references:** [Input capture notes](UI-SUPPRESSION.md)


## 🗂️ Contents
- [📖 Guides & reference material](#guides--reference-material)

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📂 Folder | `dialogue/` | 5 | 85 | 47 | — | [Open folder index](dialogue/index.md) |
| 📂 Folder | `helpers/` | 1 | 5 | 3 | — | [Open folder index](helpers/index.md) |
| 📂 Folder | `menuAPI/` | 1 | 46 | 45 | — | [Open folder index](menuAPI/index.md) |
| 📂 Folder | `navi-emotes/` | 2 | 1 | 12 | — | [Open folder index](navi-emotes/index.md) |
| 📂 Folder | `npcs/` | 25 | 107 | 175 | — | [Open folder index](npcs/index.md) |
| 📂 Folder | `utilities/` | 1 | 35 | 14 | — | [Open folder index](utilities/index.md) |
| 📄 Script | `bn-textbox.lua` | 1 | 3 | 8 | 141 | [Open script reference](bn-textbox/index.md) |
| 📄 Script | `layout-manager.lua` | 1 | 45 | 34 | 1233 | [Open script reference](layout-manager/index.md) |
| 📄 Script | `main.lua` | 1 | 123 | 57 | 2604 | [Open script reference](main/index.md) |
| 📄 Script | `ui-safe.lua` | 1 | 12 | 5 | 164 | [Open script reference](ui-safe/index.md) |
| 📄 Script | `ui-suppression-examples.lua` | 1 | 2 | 1 | 36 | [Open script reference](ui-suppression-examples/index.md) |
| 📄 Script | `ui-suppression.lua` | 1 | 14 | 16 | 128 | [Open script reference](ui-suppression/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `bn-textbox.lua` | `BNTextbox.show(player_id, text, opts)` | 126 | [Details](bn-textbox/index.md) |
| `layout-manager.lua` | `LayoutManager.create_layout(player_id, layout_id, options)` | 328 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.add_sprite(player_id, layout_id, resource_id, object_id, properties)` | 375 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.remove_sprite(player_id, layout_id, object_id, properties)` | 440 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.remove_layout(player_id, layout_id)` | 458 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.arrange_layout(player_id, layout_id)` | 470 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.set_layout_property(player_id, layout_id, property, value, mode, duration, easing, sound)` | 476 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.set_sprite_property(player_id, layout_id, object_id, property, value, mode, duration, easing, sound)` | 514 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.get_sprite_proxy(player_id, layout_id, object_id)` | 573 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.animate_layout_property(player_id, layout_id, property, target, duration, options)` | 599 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.animate_sprite_property(player_id, layout_id, object_id, property, target, duration, options)` | 619 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.reorder_sprite(player_id, layout_id, object_id, new_index)` | 659 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.swap_sprites(player_id, layout_id, object_id_a, object_id_b, swap_properties)` | 693 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.move_sprite_before(player_id, layout_id, object_id_to_move, reference_object_id)` | 722 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.move_sprite_after(player_id, layout_id, object_id_to_move, reference_object_id)` | 751 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.add_sprite_animated(player_id, layout_id, resource_id, object_id, properties, anim_options)` | 848 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.remove_sprite_animated(player_id, layout_id, object_id, anim_options)` | 973 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.swap_sprites_animated(player_id, layout_id, object_id_a, object_id_b, swap_properties, anim_options)` | 1061 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.reorder_sprite_animated(player_id, layout_id, object_id, new_index, anim_options)` | 1096 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.move_sprite_before_animated(player_id, layout_id, object_id_to_move, reference_object_id, anim_options)` | 1130 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.move_sprite_after_animated(player_id, layout_id, object_id_to_move, reference_object_id, anim_options)` | 1165 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.on_tick(delta_time)` | 1204 | [Details](layout-manager/index.md) |
| `layout-manager.lua` | `LayoutManager.clear_player(player_id)` | 1217 | [Details](layout-manager/index.md) |
| `main.lua` | `frame.move_frozen_player(player_id, x, y, z)` | 197 | [Details](main/index.md) |
| `main.lua` | `frame.animate_frozen_player(player_id, anim_state)` | 205 | [Details](main/index.md) |
| `main.lua` | `frame.set_cosmetic(cosmetic_id, player_id, texture, animation, state, x, y, visible, player_xoffset, player_yoffset, anim_duration, scale, bot_scale, owner_sprite_state, owner_sprite_enabled, movement_duration)` | 229 | [Details](main/index.md) |
| `main.lua` | `frame.remove_cosmetic(cosmetic_id, player_id)` | 385 | [Details](main/index.md) |
| `main.lua` | `frame.add_map_element(name, player_id, texture, animation, animation_state, x, y, z, exclude)` | 417 | [Details](main/index.md) |
| `main.lua` | `frame.change_map_element(name, player_id, animation_state, loop)` | 450 | [Details](main/index.md) |
| `main.lua` | `frame.move_map_element(name, player_id, x, y, z)` | 459 | [Details](main/index.md) |
| `main.lua` | `frame.remove_map_element(name, player_id)` | 478 | [Details](main/index.md) |
| `main.lua` | `frame.add_ui_element(sprite_id, player_id, texture_path, animation_path, animation_state, x, y, z, sx, sy, box_width, box_height, halign, valign)` | 510 | [Details](main/index.md) |
| `main.lua` | `frame.update_ui_element(sprite_id, player_id, properties)` | 635 | [Details](main/index.md) |
| `main.lua` | `frame.set_ui_animation(sprite_id, player_id, animation_state)` | 692 | [Details](main/index.md) |
| `main.lua` | `frame.remove_ui_element(sprite_id, player_id)` | 724 | [Details](main/index.md) |
| `main.lua` | `frame.get_ui_element_proxy(sprite_id, player_id)` | 733 | [Details](main/index.md) |
| `main.lua` | `frame.slide_ui_element(sprite_id, player_id, target_x, target_y, duration, easing, on_complete)` | 795 | [Details](main/index.md) |
| `main.lua` | `frame.relative_slide_ui_element(sprite_id, player_id, offset_x, offset_y, duration, easing, on_complete)` | 846 | [Details](main/index.md) |
| `main.lua` | `frame.set_slide_ui_element(sprite_id, player_id, start_x, start_y, target_x, target_y, duration, easing, on_complete)` | 857 | [Details](main/index.md) |
| `main.lua` | `frame.move_ui_element(sprite_id, player_id, offset_x, offset_y, duration, easing, on_complete)` | 914 | [Details](main/index.md) |
| `main.lua` | `frame.scale_ui_element(sprite_id, player_id, target_scale, duration, easing, on_complete)` | 933 | [Details](main/index.md) |
| `main.lua` | `frame.relative_scale_ui_element(sprite_id, player_id, offset_scale, duration, easing, on_complete)` | 990 | [Details](main/index.md) |
| `main.lua` | `frame.rotate_ui_element(sprite_id, player_id, target_rotation, duration, easing, on_complete)` | 1000 | [Details](main/index.md) |
| `main.lua` | `frame.relative_rotate_ui_element(sprite_id, player_id, offset_rotation, duration, easing, on_complete)` | 1055 | [Details](main/index.md) |
| `main.lua` | `frame.transform_ui_element(sprite_id, player_id, properties, duration, easing, on_complete)` | 1065 | [Details](main/index.md) |
| `main.lua` | `frame.relative_transform_ui_element(sprite_id, player_id, offset_properties, duration, easing, on_complete)` | 1135 | [Details](main/index.md) |
| `main.lua` | `frame.bob_ui_element(sprite_id, player_id, distance, duration, easing, loop, ping_pong)` | 1155 | [Details](main/index.md) |
| `main.lua` | `frame.pulse_scale_ui_element(sprite_id, player_id, min_scale, max_scale, pulse_duration, easing, loops, on_complete)` | 1200 | [Details](main/index.md) |
| `main.lua` | `frame.color_pulse_from_current(sprite_id, player_id, target_color)` | 1235 | [Details](main/index.md) |
| `main.lua` | `frame.summon_ui_element(sprite_id, player_id, start_x, start_y, start_scale, end_x, end_y, end_scale, duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete)` | 1252 | [Details](main/index.md) |
| `main.lua` | `frame.complex_summon_ui_element(sprite_id, player_id, start_x, start_y, start_scale, end_x, end_y, end_scale, arc_duration, wobble_duration, settle_duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete, on_update_step1, on_update_step2, on_update_step3)` | 1336 | [Details](main/index.md) |
| `main.lua` | `frame.summon_ui_element_relative(sprite_id, player_id, end_x, end_y, end_scale, duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete)` | 1458 | [Details](main/index.md) |
| `main.lua` | `frame.complex_summon_ui_element_relative(sprite_id, player_id, end_x, end_y, end_scale, arc_duration, wobble_duration, settle_duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete, on_update_step1, on_update_step2, on_update_step3)` | 1477 | [Details](main/index.md) |
| `main.lua` | `frame.set_opacity_ui_element(sprite_id, player_id, target_opacity, duration, easing, on_complete)` | 1501 | [Details](main/index.md) |
| `main.lua` | `frame.relative_set_opacity_ui_element(sprite_id, player_id, offset_opacity, duration, easing, on_complete)` | 1552 | [Details](main/index.md) |
| `main.lua` | `frame.set_ui_element_color(sprite_id, player_id, r, g, b, duration, easing, on_complete)` | 1562 | [Details](main/index.md) |
| `main.lua` | `frame.relative_set_ui_element_color(sprite_id, player_id, offset_r, offset_g, offset_b, duration, easing, on_complete)` | 1622 | [Details](main/index.md) |
| `main.lua` | `frame.color_pulse_ui_element(sprite_id, player_id, start_color, target_color)` | 1634 | [Details](main/index.md) |
| `main.lua` | `frame.color_pulse_rgb(sprite_id, player_id, start_r, start_g, start_b, start_a, target_r, target_g, target_b, target_a)` | 1684 | [Details](main/index.md) |
| `main.lua` | `frame.menu_cursor_ui_element(sprite_id, player_id, bob_distance, pulse_scale, bob_duration, pulse_duration, orientation, easing, back_easing, on_complete)` | 1703 | [Details](main/index.md) |
| `main.lua` | `frame.shake_ui_element(sprite_id, player_id, intensity, duration, frequency, on_complete)` | 1777 | [Details](main/index.md) |
| `main.lua` | `frame.set_ui_element_instant(sprite_id, player_id, properties)` | 1831 | [Details](main/index.md) |
| `main.lua` | `frame.reset_ui_element(sprite_id, player_id, initial_values)` | 1848 | [Details](main/index.md) |
| `main.lua` | `frame.stop_ui_animation(sprite_id, player_id, anim_id)` | 1877 | [Details](main/index.md) |
| `main.lua` | `frame.has_active_animations(sprite_id, player_id)` | 1906 | [Details](main/index.md) |
| `main.lua` | `frame.is_animation_running(sprite_id, player_id, anim_id)` | 1915 | [Details](main/index.md) |
| `main.lua` | `frame.get_ui_element_properties(sprite_id, player_id)` | 1924 | [Details](main/index.md) |
| `main.lua` | `frame.spawn_cursor(sprite_id, player_id, options)` | 1959 | [Details](main/index.md) |
| `main.lua` | `frame.remove_cursor(cursor_id, player_id)` | 1993 | [Details](main/index.md) |
| `main.lua` | `frame.move_cursor_to_selection(cursor_id, player_id, selection_name)` | 2002 | [Details](main/index.md) |
| `main.lua` | `frame.get_current_cursor_selection(cursor_id, player_id)` | 2040 | [Details](main/index.md) |
| `main.lua` | `frame.lock_cursor(cursor_id, player_id, locked)` | 2055 | [Details](main/index.md) |
| `main.lua` | `frame.is_cursor_locked(cursor_id, player_id)` | 2065 | [Details](main/index.md) |
| `main.lua` | `frame.update_cursor_options(cursor_id, player_id, new_options)` | 2074 | [Details](main/index.md) |
| `main.lua` | `frame.detach_camera(player_id)` | 2100 | [Details](main/index.md) |
| `main.lua` | `frame.draw_text(text_id, player_id, text, x, y, z, font, scale)` | 2108 | [Details](main/index.md) |
| `main.lua` | `frame.update_text(text_id, player_id, text)` | 2125 | [Details](main/index.md) |
| `main.lua` | `frame.remove_text(text_id, player_id)` | 2134 | [Details](main/index.md) |
| `main.lua` | `frame.draw_advanced_text(player_id, text, opts)` | 2141 | [Details](main/index.md) |
| `main.lua` | `frame.draw_marquee_text(marquee_id, player_id, text, y, font, scale, z_order, speed, backdrop)` | 2158 | [Details](main/index.md) |
| `main.lua` | `frame.set_marquee_position(player_id, marquee_id, x, y)` | 2176 | [Details](main/index.md) |
| `main.lua` | `frame.set_marquee_speed(player_id, marquee_id, speed)` | 2193 | [Details](main/index.md) |
| `main.lua` | `frame.spawn_timer(timer_id, player_id, x, y, duration, loop)` | 2212 | [Details](main/index.md) |
| `main.lua` | `frame.resume_timer(timer_id, player_id)` | 2221 | [Details](main/index.md) |
| `main.lua` | `frame.pause_timer(timer_id, player_id)` | 2225 | [Details](main/index.md) |
| `main.lua` | `frame.remove_timer(timer_id, player_id)` | 2229 | [Details](main/index.md) |
| `main.lua` | `frame.update_timer(timer_id, player_id, duration)` | 2237 | [Details](main/index.md) |
| `main.lua` | `frame.spawn_countdown(countdown_id, player_id, x, y, duration, loop)` | 2250 | [Details](main/index.md) |
| `main.lua` | `frame.resume_countdown(countdown_id, player_id)` | 2263 | [Details](main/index.md) |
| `main.lua` | `frame.pause_countdown(countdown_id, player_id)` | 2267 | [Details](main/index.md) |
| `main.lua` | `frame.remove_countdown(countdown_id, player_id)` | 2271 | [Details](main/index.md) |
| `main.lua` | `frame.update_countdown(countdown_id, player_id, duration)` | 2279 | [Details](main/index.md) |
| `ui-safe.lua` | `UISafe.asset_exists(path)` | 30 | [Details](ui-safe/index.md) |
| `ui-safe.lua` | `UISafe.safe_provide(player_id, path)` | 34 | [Details](ui-safe/index.md) |
| `ui-safe.lua` | `UISafe.draw(player_id, logical_id, texture_path, options)` | 86 | [Details](ui-safe/index.md) |
| `ui-safe.lua` | `UISafe.erase(player_id, logical_id)` | 136 | [Details](ui-safe/index.md) |
| `ui-safe.lua` | `UISafe.cleanup_player(player_id)` | 147 | [Details](ui-safe/index.md) |
| `ui-safe.lua` | `UISafe.invalidate(player_id, logical_id)` | 154 | [Details](ui-safe/index.md) |
| `ui-suppression.lua` | `M.acquire_engine_hud(pid, owner)` | 30 | [Details](ui-suppression/index.md) |
| `ui-suppression.lua` | `M.acquire_input_lock(pid, owner)` | 35 | [Details](ui-suppression/index.md) |
| `ui-suppression.lua` | `M.register_handler(name, handler)` | 38 | [Details](ui-suppression/index.md) |
| `ui-suppression.lua` | `M.acquire_element(pid, name, owner, options)` | 42 | [Details](ui-suppression/index.md) |
| `ui-suppression.lua` | `M.release(h)` | 52 | [Details](ui-suppression/index.md) |
| `ui-suppression.lua` | `M.register_profile(name, entries)` | 88 | [Details](ui-suppression/index.md) |
| `ui-suppression.lua` | `M.acquire_profile(pid, name, owner, options)` | 92 | [Details](ui-suppression/index.md) |
| `ui-suppression.lua` | `M.release_profile(b)` | 109 | [Details](ui-suppression/index.md) |
| `ui-suppression.lua` | `M.cleanup_player(pid)` | 116 | [Details](ui-suppression/index.md) |
| `ui-suppression.lua` | `M.get_debug_state(pid)` | 121 | [Details](ui-suppression/index.md) |

## 📊 Collection summary

This folder subtree contains **41 Lua source files**, **478 named/assigned function detections**, and **417 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `UI-SUPPRESSION.md`](UI-SUPPRESSION.md) | UI Suppression Manager |
| [📘 `readme.md`](readme.md) | 🎮 Net-Games Library — Complete Documentation |
