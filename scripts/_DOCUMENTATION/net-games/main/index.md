# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/main.lua`](../../../net-games/main.lua)  
> **Source lines:** 2605  
> **SHA-256 (UTF-8):** `306677c995c7a02faf96d7390a9124884a04126ed0e187f5d22404d9a5c34835`  
> **Named functions detected:** 118  
> **Table initializers detected:** 53

> **Static reference:** Function signatures, dependency paths, and event names are extracted from current Lua. The listing does not establish runtime reachability or public API exposure. See the authored guide for semantics.

## Contents
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Dependencies

| Line | `require` path |
|---:|---|
| 1 | `scripts/player-control/main` |
| 12 | `scripts/displayer/displayer` |
| 13 | `scripts/animation-engine/animation-engine` |
| 14 | `scripts/boom/main` |
| 15 | `scripts/input-controller/main` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 135 | `Net` | `player_request` |
| 2310 | `Net` | `virtual_input` |
| 2399 | `Net` | `tick` |
| 2435 | `Net` | `cursor_move` |
| 2474 | `Net` | `player_join` |
| 2492 | `Net` | `player_disconnect` |
| 2537 | `Net` | `player_move` |
| 2586 | `Net` | `player_area_transfer` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 57 | `round_fraction` | `value, denominator` | local |
| 64 | `convertOffsets` | `horizontalOffset, verticalOffset, Z` | local |
| 70 | `fixOffsets` | `a, b` | local |
| 90 | `normalize_color` | `color` | local |
| 106 | `async` | `p` | local |
| 111 | `await` | `v` | local |
| 115 | `table_has_value` | `tab, val` | local |
| 124 | `exclude_except_for` | `player_id, bot_id` | local |
| 144 | `try_move_player` | `player_id, area_id, x, y, z` | local |
| 176 | `try_animate_player` | `player_id, anim_state` | local |
| 198 | `frame.move_frozen_player` | `player_id, x, y, z` | assigned/declared |
| 206 | `frame.animate_frozen_player` | `player_id, anim_state` | assigned/declared |
| 230 | `frame.set_cosmetic` | `cosmetic_id, player_id, texture, animation, state, x, y, visible, player_xoffset, player_yoffset, anim_duration, scale, bot_scale, owner_sprite_state, owner_sprite_enabled, movement_duration` | assigned/declared |
| 386 | `frame.remove_cosmetic` | `cosmetic_id, player_id` | assigned/declared |
| 418 | `frame.add_map_element` | `name, player_id, texture, animation, animation_state, x, y, z, exclude` | assigned/declared |
| 451 | `frame.change_map_element` | `name, player_id, animation_state, loop` | assigned/declared |
| 460 | `frame.move_map_element` | `name, player_id, x, y, z` | assigned/declared |
| 479 | `frame.remove_map_element` | `name, player_id` | assigned/declared |
| 490 | `compute_aligned_position` | `element` | local |
| 636 | `frame.update_ui_element` | `sprite_id, player_id, properties` | assigned/declared |
| 693 | `frame.set_ui_animation` | `sprite_id, player_id, animation_state` | assigned/declared |
| 725 | `frame.remove_ui_element` | `sprite_id, player_id` | assigned/declared |
| 734 | `frame.get_ui_element_proxy` | `sprite_id, player_id` | assigned/declared |
| 756 | `setPosition` | `self, x, y` | assigned/declared |
| 762 | `setScale` | `self, sx, sy` | assigned/declared |
| 768 | `setRotation` | `self, ro` | assigned/declared |
| 773 | `setOpacity` | `self, opacity` | assigned/declared |
| 778 | `setColor` | `self, r, g, b, a` | assigned/declared |
| 786 | `setRo` | `self, ro` | assigned/declared |
| 796 | `frame.slide_ui_element` | `sprite_id, player_id, target_x, target_y, duration, easing, on_complete` | assigned/declared |
| 818 | `on_update` | `values` | assigned/declared |
| 824 | `on_complete` | `values, interrupted` | assigned/declared |
| 847 | `frame.relative_slide_ui_element` | `sprite_id, player_id, offset_x, offset_y, duration, easing, on_complete` | assigned/declared |
| 858 | `frame.set_slide_ui_element` | `sprite_id, player_id, start_x, start_y, target_x, target_y, duration, easing, on_complete` | assigned/declared |
| 879 | `on_update` | `values` | assigned/declared |
| 885 | `on_complete` | `values, interrupted` | assigned/declared |
| 915 | `frame.move_ui_element` | `sprite_id, player_id, offset_x, offset_y, duration, easing, on_complete` | assigned/declared |
| 934 | `frame.scale_ui_element` | `sprite_id, player_id, target_scale, duration, easing, on_complete` | assigned/declared |
| 955 | `on_update` | `values` | assigned/declared |
| 961 | `on_complete` | `values, interrupted` | assigned/declared |
| 991 | `frame.relative_scale_ui_element` | `sprite_id, player_id, offset_scale, duration, easing, on_complete` | assigned/declared |
| 1001 | `frame.rotate_ui_element` | `sprite_id, player_id, target_rotation, duration, easing, on_complete` | assigned/declared |
| 1022 | `on_update` | `values` | assigned/declared |
| 1027 | `on_complete` | `values, interrupted` | assigned/declared |
| 1056 | `frame.relative_rotate_ui_element` | `sprite_id, player_id, offset_rotation, duration, easing, on_complete` | assigned/declared |
| 1066 | `frame.transform_ui_element` | `sprite_id, player_id, properties, duration, easing, on_complete` | assigned/declared |
| 1099 | `on_update` | `values` | assigned/declared |
| 1109 | `on_complete` | `values, interrupted` | assigned/declared |
| 1136 | `frame.relative_transform_ui_element` | `sprite_id, player_id, offset_properties, duration, easing, on_complete` | assigned/declared |
| 1156 | `frame.bob_ui_element` | `sprite_id, player_id, distance, duration, easing, loop, ping_pong` | assigned/declared |
| 1172 | `setPosition` | `self, x, y` | assigned/declared |
| 1184 | `on_update` | `values` | assigned/declared |
| 1201 | `frame.pulse_scale_ui_element` | `sprite_id, player_id, min_scale, max_scale, pulse_duration, easing, loops, on_complete` | assigned/declared |
| 1219 | `on_update` | `values` | assigned/declared |
| 1236 | `frame.color_pulse_from_current` | `sprite_id, player_id, target_color` | assigned/declared |
| 1284 | `on_update` | `values` | assigned/declared |
| 1307 | `on_complete` | `values, interrupted` | assigned/declared |
| 1369 | `on_update` | `values, t, phase` | assigned/declared |
| 1397 | `on_update` | `values, t, phase` | assigned/declared |
| 1412 | `on_update` | `values, t, phase` | assigned/declared |
| 1424 | `on_complete` | `values, interrupted` | assigned/declared |
| 1443 | `on_complete` | `(none)` | assigned/declared |
| 1459 | `frame.summon_ui_element_relative` | `sprite_id, player_id, end_x, end_y, end_scale, duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete` | assigned/declared |
| 1502 | `frame.set_opacity_ui_element` | `sprite_id, player_id, target_opacity, duration, easing, on_complete` | assigned/declared |
| 1523 | `on_update` | `values` | assigned/declared |
| 1526 | `on_complete` | `values, interrupted` | assigned/declared |
| 1553 | `frame.relative_set_opacity_ui_element` | `sprite_id, player_id, offset_opacity, duration, easing, on_complete` | assigned/declared |
| 1563 | `frame.set_ui_element_color` | `sprite_id, player_id, r, g, b, duration, easing, on_complete` | assigned/declared |
| 1589 | `on_update` | `values` | assigned/declared |
| 1596 | `on_complete` | `values, interrupted` | assigned/declared |
| 1623 | `frame.relative_set_ui_element_color` | `sprite_id, player_id, offset_r, offset_g, offset_b, duration, easing, on_complete` | assigned/declared |
| 1635 | `frame.color_pulse_ui_element` | `sprite_id, player_id, start_color, target_color` | assigned/declared |
| 1659 | `setColor` | `self, r, g, b` | assigned/declared |
| 1665 | `setAlpha` | `self, alpha` | assigned/declared |
| 1669 | `setOpacity` | `self,opacity` | assigned/declared |
| 1704 | `frame.menu_cursor_ui_element` | `sprite_id, player_id, bob_distance, pulse_scale, bob_duration, pulse_duration, orientation, easing, back_easing, on_complete` | assigned/declared |
| 1732 | `on_update` | `values` | assigned/declared |
| 1746 | `on_update` | `values` | assigned/declared |
| 1764 | `stop` | `(none)` | assigned/declared |
| 1778 | `frame.shake_ui_element` | `sprite_id, player_id, intensity, duration, frequency, on_complete` | assigned/declared |
| 1796 | `setPosition` | `self, x, y` | assigned/declared |
| 1799 | `setRotation` | `self, rotation` | assigned/declared |
| 1809 | `on_complete` | `(none)` | assigned/declared |
| 1818 | `on_update` | `value` | assigned/declared |
| 1832 | `frame.set_ui_element_instant` | `sprite_id, player_id, properties` | assigned/declared |
| 1849 | `frame.reset_ui_element` | `sprite_id, player_id, initial_values` | assigned/declared |
| 1878 | `frame.stop_ui_animation` | `sprite_id, player_id, anim_id` | assigned/declared |
| 1907 | `frame.has_active_animations` | `sprite_id, player_id` | assigned/declared |
| 1916 | `frame.is_animation_running` | `sprite_id, player_id, anim_id` | assigned/declared |
| 1925 | `frame.get_ui_element_properties` | `sprite_id, player_id` | assigned/declared |
| 1960 | `frame.spawn_cursor` | `sprite_id, player_id, options` | assigned/declared |
| 1994 | `frame.remove_cursor` | `cursor_id, player_id` | assigned/declared |
| 2003 | `frame.move_cursor_to_selection` | `cursor_id, player_id, selection_name` | assigned/declared |
| 2041 | `frame.get_current_cursor_selection` | `cursor_id, player_id` | assigned/declared |
| 2056 | `frame.lock_cursor` | `cursor_id, player_id, locked` | assigned/declared |
| 2066 | `frame.is_cursor_locked` | `cursor_id, player_id` | assigned/declared |
| 2075 | `frame.update_cursor_options` | `cursor_id, player_id, new_options` | assigned/declared |
| 2101 | `frame.detach_camera` | `player_id` | assigned/declared |
| 2109 | `frame.draw_text` | `text_id, player_id, text, x, y, z, font, scale` | assigned/declared |
| 2126 | `frame.update_text` | `text_id, player_id, text` | assigned/declared |
| 2135 | `frame.remove_text` | `text_id, player_id` | assigned/declared |
| 2142 | `frame.draw_advanced_text` | `player_id, text, opts` | assigned/declared |
| 2159 | `frame.draw_marquee_text` | `marquee_id, player_id, text, y, font, scale, z_order, speed, backdrop` | assigned/declared |
| 2177 | `frame.set_marquee_position` | `player_id, marquee_id, x, y` | assigned/declared |
| 2194 | `frame.set_marquee_speed` | `player_id, marquee_id, speed` | assigned/declared |
| 2213 | `frame.spawn_timer` | `timer_id, player_id, x, y, duration, loop` | assigned/declared |
| 2215 | `callback` | `_, timer_id, value` | local |
| 2222 | `frame.resume_timer` | `timer_id, player_id` | assigned/declared |
| 2226 | `frame.pause_timer` | `timer_id, player_id` | assigned/declared |
| 2230 | `frame.remove_timer` | `timer_id, player_id` | assigned/declared |
| 2238 | `frame.update_timer` | `timer_id, player_id, duration` | assigned/declared |
| 2251 | `frame.spawn_countdown` | `countdown_id, player_id, x, y, duration, loop` | assigned/declared |
| 2253 | `callback` | `_, countdown_id, value` | local |
| 2264 | `frame.resume_countdown` | `countdown_id, player_id` | assigned/declared |
| 2268 | `frame.pause_countdown` | `countdown_id, player_id` | assigned/declared |
| 2272 | `frame.remove_countdown` | `countdown_id, player_id` | assigned/declared |
| 2280 | `frame.update_countdown` | `countdown_id, player_id, duration` | assigned/declared |
| 2293 | `splitter` | `inputstr, sep` | local |

### Parameter inventory

#### 1. `round_fraction(value, denominator)`

- **Line:** 57
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared directly in the current Lua. Type not inferred. |
| 2 | `denominator` | Declared directly in the current Lua. Type not inferred. |

#### 2. `convertOffsets(horizontalOffset, verticalOffset, Z)`

- **Line:** 64
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `horizontalOffset` | Declared directly in the current Lua. Type not inferred. |
| 2 | `verticalOffset` | Declared directly in the current Lua. Type not inferred. |
| 3 | `Z` | Declared directly in the current Lua. Type not inferred. |

#### 3. `fixOffsets(a, b)`

- **Line:** 70
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `a` | Declared directly in the current Lua. Type not inferred. |
| 2 | `b` | Declared directly in the current Lua. Type not inferred. |

#### 4. `normalize_color(color)`

- **Line:** 90
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `color` | Declared directly in the current Lua. Type not inferred. |

#### 5. `async(p)`

- **Line:** 106
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `p` | Declared directly in the current Lua. Type not inferred. |

#### 6. `await(v)`

- **Line:** 111
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `v` | Declared directly in the current Lua. Type not inferred. |

#### 7. `table_has_value(tab, val)`

- **Line:** 115
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `tab` | Declared directly in the current Lua. Type not inferred. |
| 2 | `val` | Declared directly in the current Lua. Type not inferred. |

#### 8. `exclude_except_for(player_id, bot_id)`

- **Line:** 124
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `bot_id` | Declared directly in the current Lua. Type not inferred. |

#### 9. `try_move_player(player_id, area_id, x, y, z)`

- **Line:** 144
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 10. `try_animate_player(player_id, anim_state)`

- **Line:** 176
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `anim_state` | Declared directly in the current Lua. Type not inferred. |

#### 11. `frame.move_frozen_player(player_id, x, y, z)`

- **Line:** 198
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `x` | Declared directly in the current Lua. Type not inferred. |
| 3 | `y` | Declared directly in the current Lua. Type not inferred. |
| 4 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 12. `frame.animate_frozen_player(player_id, anim_state)`

- **Line:** 206
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `anim_state` | Declared directly in the current Lua. Type not inferred. |

#### 13. `frame.set_cosmetic(cosmetic_id, player_id, texture, animation, state, x, y, visible, player_xoffset, player_yoffset, anim_duration, scale, bot_scale, owner_sprite_state, owner_sprite_enabled, movement_duration)`

- **Line:** 230
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `cosmetic_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `texture` | Declared directly in the current Lua. Type not inferred. |
| 4 | `animation` | Declared directly in the current Lua. Type not inferred. |
| 5 | `state` | Declared directly in the current Lua. Type not inferred. |
| 6 | `x` | Declared directly in the current Lua. Type not inferred. |
| 7 | `y` | Declared directly in the current Lua. Type not inferred. |
| 8 | `visible` | Declared directly in the current Lua. Type not inferred. |
| 9 | `player_xoffset` | Declared directly in the current Lua. Type not inferred. |
| 10 | `player_yoffset` | Declared directly in the current Lua. Type not inferred. |
| 11 | `anim_duration` | Declared directly in the current Lua. Type not inferred. |
| 12 | `scale` | Declared directly in the current Lua. Type not inferred. |
| 13 | `bot_scale` | Declared directly in the current Lua. Type not inferred. |
| 14 | `owner_sprite_state` | Declared directly in the current Lua. Type not inferred. |
| 15 | `owner_sprite_enabled` | Declared directly in the current Lua. Type not inferred. |
| 16 | `movement_duration` | Declared directly in the current Lua. Type not inferred. |

#### 14. `frame.remove_cosmetic(cosmetic_id, player_id)`

- **Line:** 386
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `cosmetic_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 15. `frame.add_map_element(name, player_id, texture, animation, animation_state, x, y, z, exclude)`

- **Line:** 418
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `texture` | Declared directly in the current Lua. Type not inferred. |
| 4 | `animation` | Declared directly in the current Lua. Type not inferred. |
| 5 | `animation_state` | Declared directly in the current Lua. Type not inferred. |
| 6 | `x` | Declared directly in the current Lua. Type not inferred. |
| 7 | `y` | Declared directly in the current Lua. Type not inferred. |
| 8 | `z` | Declared directly in the current Lua. Type not inferred. |
| 9 | `exclude` | Declared directly in the current Lua. Type not inferred. |

#### 16. `frame.change_map_element(name, player_id, animation_state, loop)`

- **Line:** 451
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `animation_state` | Declared directly in the current Lua. Type not inferred. |
| 4 | `loop` | Declared directly in the current Lua. Type not inferred. |

#### 17. `frame.move_map_element(name, player_id, x, y, z)`

- **Line:** 460
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 18. `frame.remove_map_element(name, player_id)`

- **Line:** 479
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `name` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 19. `compute_aligned_position(element)`

- **Line:** 490
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `element` | Declared directly in the current Lua. Type not inferred. |

#### 20. `frame.update_ui_element(sprite_id, player_id, properties)`

- **Line:** 636
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `properties` | Declared directly in the current Lua. Type not inferred. |

#### 21. `frame.set_ui_animation(sprite_id, player_id, animation_state)`

- **Line:** 693
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `animation_state` | Declared directly in the current Lua. Type not inferred. |

#### 22. `frame.remove_ui_element(sprite_id, player_id)`

- **Line:** 725
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 23. `frame.get_ui_element_proxy(sprite_id, player_id)`

- **Line:** 734
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 24. `setPosition(self, x, y)`

- **Line:** 756
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `x` | Declared directly in the current Lua. Type not inferred. |
| 3 | `y` | Declared directly in the current Lua. Type not inferred. |

#### 25. `setScale(self, sx, sy)`

- **Line:** 762
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `sx` | Declared directly in the current Lua. Type not inferred. |
| 3 | `sy` | Declared directly in the current Lua. Type not inferred. |

#### 26. `setRotation(self, ro)`

- **Line:** 768
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `ro` | Declared directly in the current Lua. Type not inferred. |

#### 27. `setOpacity(self, opacity)`

- **Line:** 773
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `opacity` | Declared directly in the current Lua. Type not inferred. |

#### 28. `setColor(self, r, g, b, a)`

- **Line:** 778
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `r` | Declared directly in the current Lua. Type not inferred. |
| 3 | `g` | Declared directly in the current Lua. Type not inferred. |
| 4 | `b` | Declared directly in the current Lua. Type not inferred. |
| 5 | `a` | Declared directly in the current Lua. Type not inferred. |

#### 29. `setRo(self, ro)`

- **Line:** 786
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `ro` | Declared directly in the current Lua. Type not inferred. |

#### 30. `frame.slide_ui_element(sprite_id, player_id, target_x, target_y, duration, easing, on_complete)`

- **Line:** 796
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `target_x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `target_y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 6 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 7 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 31. `on_update(values)`

- **Line:** 818
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |

#### 32. `on_complete(values, interrupted)`

- **Line:** 824
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |
| 2 | `interrupted` | Declared directly in the current Lua. Type not inferred. |

#### 33. `frame.relative_slide_ui_element(sprite_id, player_id, offset_x, offset_y, duration, easing, on_complete)`

- **Line:** 847
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `offset_x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `offset_y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 6 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 7 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 34. `frame.set_slide_ui_element(sprite_id, player_id, start_x, start_y, target_x, target_y, duration, easing, on_complete)`

- **Line:** 858
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `start_x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `start_y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `target_x` | Declared directly in the current Lua. Type not inferred. |
| 6 | `target_y` | Declared directly in the current Lua. Type not inferred. |
| 7 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 8 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 9 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 35. `on_update(values)`

- **Line:** 879
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |

#### 36. `on_complete(values, interrupted)`

- **Line:** 885
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |
| 2 | `interrupted` | Declared directly in the current Lua. Type not inferred. |

#### 37. `frame.move_ui_element(sprite_id, player_id, offset_x, offset_y, duration, easing, on_complete)`

- **Line:** 915
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `offset_x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `offset_y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 6 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 7 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 38. `frame.scale_ui_element(sprite_id, player_id, target_scale, duration, easing, on_complete)`

- **Line:** 934
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `target_scale` | Declared directly in the current Lua. Type not inferred. |
| 4 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 5 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 6 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 39. `on_update(values)`

- **Line:** 955
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |

#### 40. `on_complete(values, interrupted)`

- **Line:** 961
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |
| 2 | `interrupted` | Declared directly in the current Lua. Type not inferred. |

#### 41. `frame.relative_scale_ui_element(sprite_id, player_id, offset_scale, duration, easing, on_complete)`

- **Line:** 991
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `offset_scale` | Declared directly in the current Lua. Type not inferred. |
| 4 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 5 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 6 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 42. `frame.rotate_ui_element(sprite_id, player_id, target_rotation, duration, easing, on_complete)`

- **Line:** 1001
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `target_rotation` | Declared directly in the current Lua. Type not inferred. |
| 4 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 5 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 6 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 43. `on_update(values)`

- **Line:** 1022
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |

#### 44. `on_complete(values, interrupted)`

- **Line:** 1027
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |
| 2 | `interrupted` | Declared directly in the current Lua. Type not inferred. |

#### 45. `frame.relative_rotate_ui_element(sprite_id, player_id, offset_rotation, duration, easing, on_complete)`

- **Line:** 1056
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `offset_rotation` | Declared directly in the current Lua. Type not inferred. |
| 4 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 5 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 6 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 46. `frame.transform_ui_element(sprite_id, player_id, properties, duration, easing, on_complete)`

- **Line:** 1066
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `properties` | Declared directly in the current Lua. Type not inferred. |
| 4 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 5 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 6 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 47. `on_update(values)`

- **Line:** 1099
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |

#### 48. `on_complete(values, interrupted)`

- **Line:** 1109
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |
| 2 | `interrupted` | Declared directly in the current Lua. Type not inferred. |

#### 49. `frame.relative_transform_ui_element(sprite_id, player_id, offset_properties, duration, easing, on_complete)`

- **Line:** 1136
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `offset_properties` | Declared directly in the current Lua. Type not inferred. |
| 4 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 5 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 6 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 50. `frame.bob_ui_element(sprite_id, player_id, distance, duration, easing, loop, ping_pong)`

- **Line:** 1156
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `distance` | Declared directly in the current Lua. Type not inferred. |
| 4 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 5 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 6 | `loop` | Declared directly in the current Lua. Type not inferred. |
| 7 | `ping_pong` | Declared directly in the current Lua. Type not inferred. |

#### 51. `setPosition(self, x, y)`

- **Line:** 1172
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `x` | Declared directly in the current Lua. Type not inferred. |
| 3 | `y` | Declared directly in the current Lua. Type not inferred. |

#### 52. `on_update(values)`

- **Line:** 1184
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |

#### 53. `frame.pulse_scale_ui_element(sprite_id, player_id, min_scale, max_scale, pulse_duration, easing, loops, on_complete)`

- **Line:** 1201
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `min_scale` | Declared directly in the current Lua. Type not inferred. |
| 4 | `max_scale` | Declared directly in the current Lua. Type not inferred. |
| 5 | `pulse_duration` | Declared directly in the current Lua. Type not inferred. |
| 6 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 7 | `loops` | Declared directly in the current Lua. Type not inferred. |
| 8 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 54. `on_update(values)`

- **Line:** 1219
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |

#### 55. `frame.color_pulse_from_current(sprite_id, player_id, target_color)`

- **Line:** 1236
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `target_color` | Declared directly in the current Lua. Type not inferred. |

#### 56. `on_update(values)`

- **Line:** 1284
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |

#### 57. `on_complete(values, interrupted)`

- **Line:** 1307
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |
| 2 | `interrupted` | Declared directly in the current Lua. Type not inferred. |

#### 58. `on_update(values, t, phase)`

- **Line:** 1369
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |
| 2 | `t` | Declared directly in the current Lua. Type not inferred. |
| 3 | `phase` | Declared directly in the current Lua. Type not inferred. |

#### 59. `on_update(values, t, phase)`

- **Line:** 1397
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |
| 2 | `t` | Declared directly in the current Lua. Type not inferred. |
| 3 | `phase` | Declared directly in the current Lua. Type not inferred. |

#### 60. `on_update(values, t, phase)`

- **Line:** 1412
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |
| 2 | `t` | Declared directly in the current Lua. Type not inferred. |
| 3 | `phase` | Declared directly in the current Lua. Type not inferred. |

#### 61. `on_complete(values, interrupted)`

- **Line:** 1424
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |
| 2 | `interrupted` | Declared directly in the current Lua. Type not inferred. |

#### 62. `on_complete()`

- **Line:** 1443
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 63. `frame.summon_ui_element_relative(sprite_id, player_id, end_x, end_y, end_scale, duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete)`

- **Line:** 1459
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `end_x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `end_y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `end_scale` | Declared directly in the current Lua. Type not inferred. |
| 6 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 7 | `arc_height` | Declared directly in the current Lua. Type not inferred. |
| 8 | `peak_scale_mul` | Declared directly in the current Lua. Type not inferred. |
| 9 | `wobble_deg` | Declared directly in the current Lua. Type not inferred. |
| 10 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 11 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 64. `frame.set_opacity_ui_element(sprite_id, player_id, target_opacity, duration, easing, on_complete)`

- **Line:** 1502
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `target_opacity` | Declared directly in the current Lua. Type not inferred. |
| 4 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 5 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 6 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 65. `on_update(values)`

- **Line:** 1523
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |

#### 66. `on_complete(values, interrupted)`

- **Line:** 1526
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |
| 2 | `interrupted` | Declared directly in the current Lua. Type not inferred. |

#### 67. `frame.relative_set_opacity_ui_element(sprite_id, player_id, offset_opacity, duration, easing, on_complete)`

- **Line:** 1553
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `offset_opacity` | Declared directly in the current Lua. Type not inferred. |
| 4 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 5 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 6 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 68. `frame.set_ui_element_color(sprite_id, player_id, r, g, b, duration, easing, on_complete)`

- **Line:** 1563
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `r` | Declared directly in the current Lua. Type not inferred. |
| 4 | `g` | Declared directly in the current Lua. Type not inferred. |
| 5 | `b` | Declared directly in the current Lua. Type not inferred. |
| 6 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 7 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 8 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 69. `on_update(values)`

- **Line:** 1589
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |

#### 70. `on_complete(values, interrupted)`

- **Line:** 1596
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |
| 2 | `interrupted` | Declared directly in the current Lua. Type not inferred. |

#### 71. `frame.relative_set_ui_element_color(sprite_id, player_id, offset_r, offset_g, offset_b, duration, easing, on_complete)`

- **Line:** 1623
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `offset_r` | Declared directly in the current Lua. Type not inferred. |
| 4 | `offset_g` | Declared directly in the current Lua. Type not inferred. |
| 5 | `offset_b` | Declared directly in the current Lua. Type not inferred. |
| 6 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 7 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 8 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 72. `frame.color_pulse_ui_element(sprite_id, player_id, start_color, target_color)`

- **Line:** 1635
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `start_color` | Declared directly in the current Lua. Type not inferred. |
| 4 | `target_color` | Declared directly in the current Lua. Type not inferred. |

#### 73. `setColor(self, r, g, b)`

- **Line:** 1659
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `r` | Declared directly in the current Lua. Type not inferred. |
| 3 | `g` | Declared directly in the current Lua. Type not inferred. |
| 4 | `b` | Declared directly in the current Lua. Type not inferred. |

#### 74. `setAlpha(self, alpha)`

- **Line:** 1665
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `alpha` | Declared directly in the current Lua. Type not inferred. |

#### 75. `setOpacity(self,opacity)`

- **Line:** 1669
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `opacity` | Declared directly in the current Lua. Type not inferred. |

#### 76. `frame.menu_cursor_ui_element(sprite_id, player_id, bob_distance, pulse_scale, bob_duration, pulse_duration, orientation, easing, back_easing, on_complete)`

- **Line:** 1704
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `bob_distance` | Declared directly in the current Lua. Type not inferred. |
| 4 | `pulse_scale` | Declared directly in the current Lua. Type not inferred. |
| 5 | `bob_duration` | Declared directly in the current Lua. Type not inferred. |
| 6 | `pulse_duration` | Declared directly in the current Lua. Type not inferred. |
| 7 | `orientation` | Declared directly in the current Lua. Type not inferred. |
| 8 | `easing` | Declared directly in the current Lua. Type not inferred. |
| 9 | `back_easing` | Declared directly in the current Lua. Type not inferred. |
| 10 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 77. `on_update(values)`

- **Line:** 1732
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |

#### 78. `on_update(values)`

- **Line:** 1746
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `values` | Declared directly in the current Lua. Type not inferred. |

#### 79. `stop()`

- **Line:** 1764
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 80. `frame.shake_ui_element(sprite_id, player_id, intensity, duration, frequency, on_complete)`

- **Line:** 1778
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `intensity` | Declared directly in the current Lua. Type not inferred. |
| 4 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 5 | `frequency` | Declared directly in the current Lua. Type not inferred. |
| 6 | `on_complete` | Declared directly in the current Lua. Type not inferred. |

#### 81. `setPosition(self, x, y)`

- **Line:** 1796
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `x` | Declared directly in the current Lua. Type not inferred. |
| 3 | `y` | Declared directly in the current Lua. Type not inferred. |

#### 82. `setRotation(self, rotation)`

- **Line:** 1799
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `self` | Declared directly in the current Lua. Type not inferred. |
| 2 | `rotation` | Declared directly in the current Lua. Type not inferred. |

#### 83. `on_complete()`

- **Line:** 1809
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 84. `on_update(value)`

- **Line:** 1818
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared directly in the current Lua. Type not inferred. |

#### 85. `frame.set_ui_element_instant(sprite_id, player_id, properties)`

- **Line:** 1832
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `properties` | Declared directly in the current Lua. Type not inferred. |

#### 86. `frame.reset_ui_element(sprite_id, player_id, initial_values)`

- **Line:** 1849
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `initial_values` | Declared directly in the current Lua. Type not inferred. |

#### 87. `frame.stop_ui_animation(sprite_id, player_id, anim_id)`

- **Line:** 1878
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `anim_id` | Declared directly in the current Lua. Type not inferred. |

#### 88. `frame.has_active_animations(sprite_id, player_id)`

- **Line:** 1907
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 89. `frame.is_animation_running(sprite_id, player_id, anim_id)`

- **Line:** 1916
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `anim_id` | Declared directly in the current Lua. Type not inferred. |

#### 90. `frame.get_ui_element_properties(sprite_id, player_id)`

- **Line:** 1925
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 91. `frame.spawn_cursor(sprite_id, player_id, options)`

- **Line:** 1960
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `sprite_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 92. `frame.remove_cursor(cursor_id, player_id)`

- **Line:** 1994
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `cursor_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 93. `frame.move_cursor_to_selection(cursor_id, player_id, selection_name)`

- **Line:** 2003
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `cursor_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `selection_name` | Declared directly in the current Lua. Type not inferred. |

#### 94. `frame.get_current_cursor_selection(cursor_id, player_id)`

- **Line:** 2041
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `cursor_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 95. `frame.lock_cursor(cursor_id, player_id, locked)`

- **Line:** 2056
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `cursor_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `locked` | Declared directly in the current Lua. Type not inferred. |

#### 96. `frame.is_cursor_locked(cursor_id, player_id)`

- **Line:** 2066
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `cursor_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 97. `frame.update_cursor_options(cursor_id, player_id, new_options)`

- **Line:** 2075
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `cursor_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `new_options` | Declared directly in the current Lua. Type not inferred. |

#### 98. `frame.detach_camera(player_id)`

- **Line:** 2101
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 99. `frame.draw_text(text_id, player_id, text, x, y, z, font, scale)`

- **Line:** 2109
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `text_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `text` | Declared directly in the current Lua. Type not inferred. |
| 4 | `x` | Declared directly in the current Lua. Type not inferred. |
| 5 | `y` | Declared directly in the current Lua. Type not inferred. |
| 6 | `z` | Declared directly in the current Lua. Type not inferred. |
| 7 | `font` | Declared directly in the current Lua. Type not inferred. |
| 8 | `scale` | Declared directly in the current Lua. Type not inferred. |

#### 100. `frame.update_text(text_id, player_id, text)`

- **Line:** 2126
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `text_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `text` | Declared directly in the current Lua. Type not inferred. |

#### 101. `frame.remove_text(text_id, player_id)`

- **Line:** 2135
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `text_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 102. `frame.draw_advanced_text(player_id, text, opts)`

- **Line:** 2142
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `text` | Declared directly in the current Lua. Type not inferred. |
| 3 | `opts` | Declared directly in the current Lua. Type not inferred. |

#### 103. `frame.draw_marquee_text(marquee_id, player_id, text, y, font, scale, z_order, speed, backdrop)`

- **Line:** 2159
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `marquee_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `text` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `font` | Declared directly in the current Lua. Type not inferred. |
| 6 | `scale` | Declared directly in the current Lua. Type not inferred. |
| 7 | `z_order` | Declared directly in the current Lua. Type not inferred. |
| 8 | `speed` | Declared directly in the current Lua. Type not inferred. |
| 9 | `backdrop` | Declared directly in the current Lua. Type not inferred. |

#### 104. `frame.set_marquee_position(player_id, marquee_id, x, y)`

- **Line:** 2177
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `marquee_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |

#### 105. `frame.set_marquee_speed(player_id, marquee_id, speed)`

- **Line:** 2194
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `marquee_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `speed` | Declared directly in the current Lua. Type not inferred. |

#### 106. `frame.spawn_timer(timer_id, player_id, x, y, duration, loop)`

- **Line:** 2213
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `timer_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 6 | `loop` | Declared directly in the current Lua. Type not inferred. |

#### 107. `callback(_, timer_id, value)`

- **Line:** 2215
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `_` | Declared directly in the current Lua. Type not inferred. |
| 2 | `timer_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `value` | Declared directly in the current Lua. Type not inferred. |

#### 108. `frame.resume_timer(timer_id, player_id)`

- **Line:** 2222
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `timer_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 109. `frame.pause_timer(timer_id, player_id)`

- **Line:** 2226
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `timer_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 110. `frame.remove_timer(timer_id, player_id)`

- **Line:** 2230
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `timer_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 111. `frame.update_timer(timer_id, player_id, duration)`

- **Line:** 2238
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `timer_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `duration` | Declared directly in the current Lua. Type not inferred. |

#### 112. `frame.spawn_countdown(countdown_id, player_id, x, y, duration, loop)`

- **Line:** 2251
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `countdown_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `duration` | Declared directly in the current Lua. Type not inferred. |
| 6 | `loop` | Declared directly in the current Lua. Type not inferred. |

#### 113. `callback(_, countdown_id, value)`

- **Line:** 2253
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `_` | Declared directly in the current Lua. Type not inferred. |
| 2 | `countdown_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `value` | Declared directly in the current Lua. Type not inferred. |

#### 114. `frame.resume_countdown(countdown_id, player_id)`

- **Line:** 2264
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `countdown_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 115. `frame.pause_countdown(countdown_id, player_id)`

- **Line:** 2268
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `countdown_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 116. `frame.remove_countdown(countdown_id, player_id)`

- **Line:** 2272
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `countdown_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 117. `frame.update_countdown(countdown_id, player_id, duration)`

- **Line:** 2280
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `countdown_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `duration` | Declared directly in the current Lua. Type not inferred. |

#### 118. `splitter(inputstr, sep)`

- **Line:** 2293
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `inputstr` | Declared directly in the current Lua. Type not inferred. |
| 2 | `sep` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 17 | `assets` |
| 38 | `frame` |
| 39 | `last_position_cache` |
| 40 | `cosmetic_cache` |
| 42 | `avatar_cache` |
| 43 | `ui_cache` |
| 44 | `map_elements` |
| 45 | `ui_update` |
| 46 | `online_players` |
| 48 | `text_cache` |
| 49 | `marquee_cache` |
| 50 | `timer_cache` |
| 51 | `countdown_cache` |
| 52 | `repeat_state` |
| 179 | `keyframes` |
| 180 | `properties` |
| 366 | `keyframes` |
| 367 | `properties` |
| 623 | `animations` |
| 625 | `children` |
| 642 | `sprite_data` |
| 840 | `element.animations` |
| 908 | `element.animations` |
| 984 | `element.animations` |
| 1049 | `element.animations` |
| 1076 | `current_props` |
| 1085 | `target_props` |
| 1129 | `element.animations` |
| 1142 | `target_props` |
| 1170 | `proxy` |
| 1194 | `element.animations` |
| 1229 | `element.animations` |
| 1243 | `current_color` |
| 1330 | `element.animations` |
| 1363 | `sequence_steps` |
| 1451 | `element.animations` |
| 1546 | `element.animations` |
| 1616 | `element.animations` |
| 1646 | `start_color` |
| 1654 | `proxy` |
| 1678 | `element.animations` |
| 1687 | `start_color` |
| 1694 | `target_color` |
| 1756 | `element.animations` |
| 1792 | `shake_object` |
| 1825 | `element.animations` |
| 1901 | `element.animations` |
| 1984 | `obj_cache.cursor_options` |
| 2160 | `opts` |
| 2300 | `t` |
| 2555 | `keyframes` |
| 2557 | `properties` |
| 2565 | `properties` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.animate_bot` | 2 | 438 |
| `Net.animate_player_properties` | 1 | 183 |
| `Net.create_bot` | 2 | 347 |
| `Net.emit` | 5 | 2026 |
| `Net.exclude_actor_for_player` | 1 | 127 |
| `Net.get_player_area` | 5 | 200 |
| `Net.get_player_position` | 1 | 259 |
| `Net.is_bot` | 5 | 397 |
| `Net.move_bot` | 1 | 473 |
| `Net.move_player` | 1 | 161 |
| `Net.on` | 8 | 135 |
| `Net.player_alloc_sprite` | 2 | 326 |
| `Net.player_draw_sprite` | 5 | 331 |
| `Net.player_erase_sprite` | 2 | 727 |
| `Net.provide_asset_for_player` | 5 | 137 |
| `Net.remove_bot` | 4 | 398 |
| `Net.set_player_animation` | 1 | 190 |
| `Net.set_player_position` | 1 | 168 |
| `Net.transfer_bot` | 2 | 475 |
| `Net.transfer_player` | 2 | 147 |
