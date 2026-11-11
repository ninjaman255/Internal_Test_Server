# 📄 `main.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/net-games/main.lua`](../../../net-games/main.lua)  
> **Source lines:** 2605  
> **SHA-256 (UTF-8):** `071c9f19dd36f2…`  
> **Declared/assigned functions detected:** 123  
> **Anonymous closures detected:** 19  
> **Table initializers detected:** 57

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

Source-based reference for `scripts/net-games/main.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 11 | `scripts/displayer/displayer` |
| 12 | `scripts/animation-engine/animation-engine` |
| 13 | `scripts/boom/main` |
| 14 | `scripts/input-controller/main` |

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 134 | `Net:on` | `player_request` |
| 2309 | `Net:on` | `virtual_input` |
| 2398 | `Net:on` | `tick` |
| 2434 | `Net:on` | `cursor_move` |
| 2473 | `Net:on` | `player_join` |
| 2491 | `Net:on` | `player_disconnect` |
| 2536 | `Net:on` | `player_move` |
| 2585 | `Net:on` | `player_area_transfer` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 56 | `round_fraction` | `value, denominator` | local |
| 63 | `convertOffsets` | `horizontalOffset, verticalOffset, Z` | local |
| 69 | `fixOffsets` | `a, b` | local |
| 89 | `normalize_color` | `color` | local |
| 105 | `async` | `p` | local |
| 110 | `await` | `v` | local |
| 114 | `table_has_value` | `tab, val` | local |
| 123 | `exclude_except_for` | `player_id, bot_id` | local |
| 143 | `try_move_player` | `player_id, area_id, x, y, z` | local |
| 175 | `try_animate_player` | `player_id, anim_state` | local |
| 197 | `frame.move_frozen_player` | `player_id, x, y, z` | declared |
| 205 | `frame.animate_frozen_player` | `player_id, anim_state` | declared |
| 229 | `frame.set_cosmetic` | `cosmetic_id, player_id, texture, animation, state, x, y, visible, player_xoffset, player_yoffset, anim_duration, scale, bot_scale, owner_sprite_state, owner_sprite_enabled, movement_duration` | declared |
| 385 | `frame.remove_cosmetic` | `cosmetic_id, player_id` | declared |
| 417 | `frame.add_map_element` | `name, player_id, texture, animation, animation_state, x, y, z, exclude` | declared |
| 450 | `frame.change_map_element` | `name, player_id, animation_state, loop` | declared |
| 459 | `frame.move_map_element` | `name, player_id, x, y, z` | declared |
| 478 | `frame.remove_map_element` | `name, player_id` | declared |
| 489 | `compute_aligned_position` | `element` | local |
| 510 | `frame.add_ui_element` | `sprite_id, player_id, texture_path, animation_path, animation_state, x, y, z, sx, sy, box_width, box_height, halign, valign` | declared |
| 635 | `frame.update_ui_element` | `sprite_id, player_id, properties` | declared |
| 692 | `frame.set_ui_animation` | `sprite_id, player_id, animation_state` | declared |
| 724 | `frame.remove_ui_element` | `sprite_id, player_id` | declared |
| 733 | `frame.get_ui_element_proxy` | `sprite_id, player_id` | declared |
| 755 | `setPosition` | `self, x, y` | assigned |
| 761 | `setScale` | `self, sx, sy` | assigned |
| 767 | `setRotation` | `self, ro` | assigned |
| 772 | `setOpacity` | `self, opacity` | assigned |
| 777 | `setColor` | `self, r, g, b, a` | assigned |
| 785 | `setRo` | `self, ro` | assigned |
| 795 | `frame.slide_ui_element` | `sprite_id, player_id, target_x, target_y, duration, easing, on_complete` | declared |
| 817 | `on_update` | `values` | assigned |
| 823 | `on_complete` | `values, interrupted` | assigned |
| 846 | `frame.relative_slide_ui_element` | `sprite_id, player_id, offset_x, offset_y, duration, easing, on_complete` | declared |
| 857 | `frame.set_slide_ui_element` | `sprite_id, player_id, start_x, start_y, target_x, target_y, duration, easing, on_complete` | declared |
| 878 | `on_update` | `values` | assigned |
| 884 | `on_complete` | `values, interrupted` | assigned |
| 914 | `frame.move_ui_element` | `sprite_id, player_id, offset_x, offset_y, duration, easing, on_complete` | declared |
| 933 | `frame.scale_ui_element` | `sprite_id, player_id, target_scale, duration, easing, on_complete` | declared |
| 954 | `on_update` | `values` | assigned |
| 960 | `on_complete` | `values, interrupted` | assigned |
| 990 | `frame.relative_scale_ui_element` | `sprite_id, player_id, offset_scale, duration, easing, on_complete` | declared |
| 1000 | `frame.rotate_ui_element` | `sprite_id, player_id, target_rotation, duration, easing, on_complete` | declared |
| 1021 | `on_update` | `values` | assigned |
| 1026 | `on_complete` | `values, interrupted` | assigned |
| 1055 | `frame.relative_rotate_ui_element` | `sprite_id, player_id, offset_rotation, duration, easing, on_complete` | declared |
| 1065 | `frame.transform_ui_element` | `sprite_id, player_id, properties, duration, easing, on_complete` | declared |
| 1098 | `on_update` | `values` | assigned |
| 1108 | `on_complete` | `values, interrupted` | assigned |
| 1135 | `frame.relative_transform_ui_element` | `sprite_id, player_id, offset_properties, duration, easing, on_complete` | declared |
| 1155 | `frame.bob_ui_element` | `sprite_id, player_id, distance, duration, easing, loop, ping_pong` | declared |
| 1171 | `setPosition` | `self, x, y` | assigned |
| 1183 | `on_update` | `values` | assigned |
| 1200 | `frame.pulse_scale_ui_element` | `sprite_id, player_id, min_scale, max_scale, pulse_duration, easing, loops, on_complete` | declared |
| 1218 | `on_update` | `values` | assigned |
| 1235 | `frame.color_pulse_from_current` | `sprite_id, player_id, target_color` | declared |
| 1252 | `frame.summon_ui_element` | `sprite_id, player_id, start_x, start_y, start_scale, end_x, end_y, end_scale, duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete` | declared |
| 1283 | `on_update` | `values` | assigned |
| 1306 | `on_complete` | `values, interrupted` | assigned |
| 1336 | `frame.complex_summon_ui_element` | `sprite_id, player_id, start_x, start_y, start_scale, end_x, end_y, end_scale, arc_duration, wobble_duration, settle_duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete, on_update_step1, on_update_step2, on_update_step3` | declared |
| 1368 | `on_update` | `values, t, phase` | assigned |
| 1396 | `on_update` | `values, t, phase` | assigned |
| 1411 | `on_update` | `values, t, phase` | assigned |
| 1423 | `on_complete` | `values, interrupted` | assigned |
| 1442 | `on_complete` | `(none)` | assigned |
| 1458 | `frame.summon_ui_element_relative` | `sprite_id, player_id, end_x, end_y, end_scale, duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete` | declared |
| 1477 | `frame.complex_summon_ui_element_relative` | `sprite_id, player_id, end_x, end_y, end_scale, arc_duration, wobble_duration, settle_duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete, on_update_step1, on_update_step2, on_update_step3` | declared |
| 1501 | `frame.set_opacity_ui_element` | `sprite_id, player_id, target_opacity, duration, easing, on_complete` | declared |
| 1522 | `on_update` | `values` | assigned |
| 1525 | `on_complete` | `values, interrupted` | assigned |
| 1552 | `frame.relative_set_opacity_ui_element` | `sprite_id, player_id, offset_opacity, duration, easing, on_complete` | declared |
| 1562 | `frame.set_ui_element_color` | `sprite_id, player_id, r, g, b, duration, easing, on_complete` | declared |
| 1588 | `on_update` | `values` | assigned |
| 1595 | `on_complete` | `values, interrupted` | assigned |
| 1622 | `frame.relative_set_ui_element_color` | `sprite_id, player_id, offset_r, offset_g, offset_b, duration, easing, on_complete` | declared |
| 1634 | `frame.color_pulse_ui_element` | `sprite_id, player_id, start_color, target_color` | declared |
| 1658 | `setColor` | `self, r, g, b` | assigned |
| 1664 | `setAlpha` | `self, alpha` | assigned |
| 1668 | `setOpacity` | `self,opacity` | assigned |
| 1684 | `frame.color_pulse_rgb` | `sprite_id, player_id, start_r, start_g, start_b, start_a, target_r, target_g, target_b, target_a` | declared |
| 1703 | `frame.menu_cursor_ui_element` | `sprite_id, player_id, bob_distance, pulse_scale, bob_duration, pulse_duration, orientation, easing, back_easing, on_complete` | declared |
| 1731 | `on_update` | `values` | assigned |
| 1745 | `on_update` | `values` | assigned |
| 1763 | `stop` | `(none)` | assigned |
| 1777 | `frame.shake_ui_element` | `sprite_id, player_id, intensity, duration, frequency, on_complete` | declared |
| 1795 | `setPosition` | `self, x, y` | assigned |
| 1798 | `setRotation` | `self, rotation` | assigned |
| 1808 | `on_complete` | `(none)` | assigned |
| 1817 | `on_update` | `value` | assigned |
| 1831 | `frame.set_ui_element_instant` | `sprite_id, player_id, properties` | declared |
| 1848 | `frame.reset_ui_element` | `sprite_id, player_id, initial_values` | declared |
| 1877 | `frame.stop_ui_animation` | `sprite_id, player_id, anim_id` | declared |
| 1906 | `frame.has_active_animations` | `sprite_id, player_id` | declared |
| 1915 | `frame.is_animation_running` | `sprite_id, player_id, anim_id` | declared |
| 1924 | `frame.get_ui_element_properties` | `sprite_id, player_id` | declared |
| 1959 | `frame.spawn_cursor` | `sprite_id, player_id, options` | declared |
| 1993 | `frame.remove_cursor` | `cursor_id, player_id` | declared |
| 2002 | `frame.move_cursor_to_selection` | `cursor_id, player_id, selection_name` | declared |
| 2040 | `frame.get_current_cursor_selection` | `cursor_id, player_id` | declared |
| 2055 | `frame.lock_cursor` | `cursor_id, player_id, locked` | declared |
| 2065 | `frame.is_cursor_locked` | `cursor_id, player_id` | declared |
| 2074 | `frame.update_cursor_options` | `cursor_id, player_id, new_options` | declared |
| 2100 | `frame.detach_camera` | `player_id` | declared |
| 2108 | `frame.draw_text` | `text_id, player_id, text, x, y, z, font, scale` | declared |
| 2125 | `frame.update_text` | `text_id, player_id, text` | declared |
| 2134 | `frame.remove_text` | `text_id, player_id` | declared |
| 2141 | `frame.draw_advanced_text` | `player_id, text, opts` | declared |
| 2158 | `frame.draw_marquee_text` | `marquee_id, player_id, text, y, font, scale, z_order, speed, backdrop` | declared |
| 2176 | `frame.set_marquee_position` | `player_id, marquee_id, x, y` | declared |
| 2193 | `frame.set_marquee_speed` | `player_id, marquee_id, speed` | declared |
| 2212 | `frame.spawn_timer` | `timer_id, player_id, x, y, duration, loop` | declared |
| 2214 | `callback` | `_, timer_id, value` | assigned |
| 2221 | `frame.resume_timer` | `timer_id, player_id` | declared |
| 2225 | `frame.pause_timer` | `timer_id, player_id` | declared |
| 2229 | `frame.remove_timer` | `timer_id, player_id` | declared |
| 2237 | `frame.update_timer` | `timer_id, player_id, duration` | declared |
| 2250 | `frame.spawn_countdown` | `countdown_id, player_id, x, y, duration, loop` | declared |
| 2252 | `callback` | `_, countdown_id, value` | assigned |
| 2263 | `frame.resume_countdown` | `countdown_id, player_id` | declared |
| 2267 | `frame.pause_countdown` | `countdown_id, player_id` | declared |
| 2271 | `frame.remove_countdown` | `countdown_id, player_id` | declared |
| 2279 | `frame.update_countdown` | `countdown_id, player_id, duration` | declared |
| 2292 | `splitter` | `inputstr, sep` | local |

### Function details

#### 1. `round_fraction(value, denominator)`

- **Location:** source line 56.
- **Declaration style:** `local`.
- **Adjacent source comment:** HELPER FUNCTIONS

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |
| 2 | `denominator` | Not explicitly documented in adjacent source annotations. |

#### 2. `convertOffsets(horizontalOffset, verticalOffset, Z)`

- **Location:** source line 63.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `horizontalOffset` | Not explicitly documented in adjacent source annotations. |
| 2 | `verticalOffset` | Not explicitly documented in adjacent source annotations. |
| 3 | `Z` | Not explicitly documented in adjacent source annotations. |

#### 3. `fixOffsets(a, b)`

- **Location:** source line 69.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |

#### 4. `normalize_color(color)`

- **Location:** source line 89.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `color` | Not explicitly documented in adjacent source annotations. |

#### 5. `async(p)`

- **Location:** source line 105.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `p` | Not explicitly documented in adjacent source annotations. |

#### 6. `await(v)`

- **Location:** source line 110.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `v` | Not explicitly documented in adjacent source annotations. |

#### 7. `table_has_value(tab, val)`

- **Location:** source line 114.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `tab` | Not explicitly documented in adjacent source annotations. |
| 2 | `val` | Not explicitly documented in adjacent source annotations. |

#### 8. `exclude_except_for(player_id, bot_id)`

- **Location:** source line 123.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `bot_id` | Not explicitly documented in adjacent source annotations. |

#### 9. `try_move_player(player_id, area_id, x, y, z)`

- **Location:** source line 143.
- **Declaration style:** `local`.
- **Adjacent source comment:** PLAYER MOVEMENT FUNCTIONS

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `area_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `z` | Not explicitly documented in adjacent source annotations. |

#### 10. `try_animate_player(player_id, anim_state)`

- **Location:** source line 175.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `anim_state` | Not explicitly documented in adjacent source annotations. |

#### 11. `frame.move_frozen_player(player_id, x, y, z)`

- **Location:** source line 197.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |
| 4 | `z` | Not explicitly documented in adjacent source annotations. |

#### 12. `frame.animate_frozen_player(player_id, anim_state)`

- **Location:** source line 205.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `anim_state` | Not explicitly documented in adjacent source annotations. |

#### 13. `frame.set_cosmetic(cosmetic_id, player_id, texture, animation, state, x, y, visible, player_xoffset, player_yoffset, anim_duration, scale, bot_scale, owner_sprite_state, owner_sprite_enabled, movement_duration)`

- **Location:** source line 229.
- **Declaration style:** `declared`.
- **Adjacent source comment:** Purpose: Show a cosmetic as a native animated sprite for its owner and as an animated world bot for every other player. Animation states: * `state` (caller-provided, typically "IDLE_DR") is used by the WORLD BOT. animate_bot(..., true) forces looping regardless of the .anim file's own loop flag, so the bot animates fine for other clients. * The OWNER SPRITE uses "cosmetic" -- the overlay state designed to sit on top of the player. The engine's sprite path (player_draw_sprite) obeys the .anim file's loop flag, and boom v2.0 states have loop har…

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cosmetic_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `texture` | Not explicitly documented in adjacent source annotations. |
| 4 | `animation` | Not explicitly documented in adjacent source annotations. |
| 5 | `state` | Not explicitly documented in adjacent source annotations. |
| 6 | `x` | Not explicitly documented in adjacent source annotations. |
| 7 | `y` | Not explicitly documented in adjacent source annotations. |
| 8 | `visible` | Not explicitly documented in adjacent source annotations. |
| 9 | `player_xoffset` | Not explicitly documented in adjacent source annotations. |
| 10 | `player_yoffset` | Not explicitly documented in adjacent source annotations. |
| 11 | `anim_duration` | Not explicitly documented in adjacent source annotations. |
| 12 | `scale` | Not explicitly documented in adjacent source annotations. |
| 13 | `bot_scale` | Not explicitly documented in adjacent source annotations. |
| 14 | `owner_sprite_state` | Not explicitly documented in adjacent source annotations. |
| 15 | `owner_sprite_enabled` | Not explicitly documented in adjacent source annotations. |
| 16 | `movement_duration` | Not explicitly documented in adjacent source annotations. |

#### 14. `frame.remove_cosmetic(cosmetic_id, player_id)`

- **Location:** source line 385.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cosmetic_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 15. `frame.add_map_element(name, player_id, texture, animation, animation_state, x, y, z, exclude)`

- **Location:** source line 417.
- **Declaration style:** `declared`.
- **Adjacent source comment:** MAP ELEMENT FUNCTIONS

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `name` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `texture` | Not explicitly documented in adjacent source annotations. |
| 4 | `animation` | Not explicitly documented in adjacent source annotations. |
| 5 | `animation_state` | Not explicitly documented in adjacent source annotations. |
| 6 | `x` | Not explicitly documented in adjacent source annotations. |
| 7 | `y` | Not explicitly documented in adjacent source annotations. |
| 8 | `z` | Not explicitly documented in adjacent source annotations. |
| 9 | `exclude` | Not explicitly documented in adjacent source annotations. |

#### 16. `frame.change_map_element(name, player_id, animation_state, loop)`

- **Location:** source line 450.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `name` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `animation_state` | Not explicitly documented in adjacent source annotations. |
| 4 | `loop` | Not explicitly documented in adjacent source annotations. |

#### 17. `frame.move_map_element(name, player_id, x, y, z)`

- **Location:** source line 459.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `name` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `z` | Not explicitly documented in adjacent source annotations. |

#### 18. `frame.remove_map_element(name, player_id)`

- **Location:** source line 478.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `name` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 19. `compute_aligned_position(element)`

- **Location:** source line 489.
- **Declaration style:** `local`.
- **Adjacent source comment:** UI ELEMENT FUNCTIONS

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `element` | Not explicitly documented in adjacent source annotations. |

#### 20. `frame.add_ui_element(sprite_id, player_id, texture_path, animation_path, animation_state, x, y, z, sx, sy, box_width, box_height, halign, valign)`

- **Location:** source line 510.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `texture_path` | Not explicitly documented in adjacent source annotations. |
| 4 | `animation_path` | Not explicitly documented in adjacent source annotations. |
| 5 | `animation_state` | Not explicitly documented in adjacent source annotations. |
| 6 | `x` | Not explicitly documented in adjacent source annotations. |
| 7 | `y` | Not explicitly documented in adjacent source annotations. |
| 8 | `z` | Not explicitly documented in adjacent source annotations. |
| 9 | `sx` | Not explicitly documented in adjacent source annotations. |
| 10 | `sy` | Not explicitly documented in adjacent source annotations. |
| 11 | `box_width` | Not explicitly documented in adjacent source annotations. |
| 12 | `box_height` | Not explicitly documented in adjacent source annotations. |
| 13 | `halign` | Not explicitly documented in adjacent source annotations. |
| 14 | `valign` | Not explicitly documented in adjacent source annotations. |

#### 21. `frame.update_ui_element(sprite_id, player_id, properties)`

- **Location:** source line 635.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `properties` | Not explicitly documented in adjacent source annotations. |

#### 22. `frame.set_ui_animation(sprite_id, player_id, animation_state)`

- **Location:** source line 692.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `animation_state` | Not explicitly documented in adjacent source annotations. |

#### 23. `frame.remove_ui_element(sprite_id, player_id)`

- **Location:** source line 724.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 24. `frame.get_ui_element_proxy(sprite_id, player_id)`

- **Location:** source line 733.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 25. `setPosition(self, x, y)`

- **Location:** source line 755.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |

#### 26. `setScale(self, sx, sy)`

- **Location:** source line 761.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `sx` | Not explicitly documented in adjacent source annotations. |
| 3 | `sy` | Not explicitly documented in adjacent source annotations. |

#### 27. `setRotation(self, ro)`

- **Location:** source line 767.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `ro` | Not explicitly documented in adjacent source annotations. |

#### 28. `setOpacity(self, opacity)`

- **Location:** source line 772.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `opacity` | Not explicitly documented in adjacent source annotations. |

#### 29. `setColor(self, r, g, b, a)`

- **Location:** source line 777.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `r` | Not explicitly documented in adjacent source annotations. |
| 3 | `g` | Not explicitly documented in adjacent source annotations. |
| 4 | `b` | Not explicitly documented in adjacent source annotations. |
| 5 | `a` | Not explicitly documented in adjacent source annotations. |

#### 30. `setRo(self, ro)`

- **Location:** source line 785.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `ro` | Not explicitly documented in adjacent source annotations. |

#### 31. `frame.slide_ui_element(sprite_id, player_id, target_x, target_y, duration, easing, on_complete)`

- **Location:** source line 795.
- **Declaration style:** `declared`.
- **Adjacent source comment:** UI ANIMATION FUNCTIONS

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `target_x` | Not explicitly documented in adjacent source annotations. |
| 4 | `target_y` | Not explicitly documented in adjacent source annotations. |
| 5 | `duration` | Not explicitly documented in adjacent source annotations. |
| 6 | `easing` | Not explicitly documented in adjacent source annotations. |
| 7 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 32. `on_update(values)`

- **Location:** source line 817.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 33. `on_complete(values, interrupted)`

- **Location:** source line 823.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |
| 2 | `interrupted` | Not explicitly documented in adjacent source annotations. |

#### 34. `frame.relative_slide_ui_element(sprite_id, player_id, offset_x, offset_y, duration, easing, on_complete)`

- **Location:** source line 846.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `offset_x` | Not explicitly documented in adjacent source annotations. |
| 4 | `offset_y` | Not explicitly documented in adjacent source annotations. |
| 5 | `duration` | Not explicitly documented in adjacent source annotations. |
| 6 | `easing` | Not explicitly documented in adjacent source annotations. |
| 7 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 35. `frame.set_slide_ui_element(sprite_id, player_id, start_x, start_y, target_x, target_y, duration, easing, on_complete)`

- **Location:** source line 857.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `start_x` | Not explicitly documented in adjacent source annotations. |
| 4 | `start_y` | Not explicitly documented in adjacent source annotations. |
| 5 | `target_x` | Not explicitly documented in adjacent source annotations. |
| 6 | `target_y` | Not explicitly documented in adjacent source annotations. |
| 7 | `duration` | Not explicitly documented in adjacent source annotations. |
| 8 | `easing` | Not explicitly documented in adjacent source annotations. |
| 9 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 36. `on_update(values)`

- **Location:** source line 878.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 37. `on_complete(values, interrupted)`

- **Location:** source line 884.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |
| 2 | `interrupted` | Not explicitly documented in adjacent source annotations. |

#### 38. `frame.move_ui_element(sprite_id, player_id, offset_x, offset_y, duration, easing, on_complete)`

- **Location:** source line 914.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `offset_x` | Not explicitly documented in adjacent source annotations. |
| 4 | `offset_y` | Not explicitly documented in adjacent source annotations. |
| 5 | `duration` | Not explicitly documented in adjacent source annotations. |
| 6 | `easing` | Not explicitly documented in adjacent source annotations. |
| 7 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 39. `frame.scale_ui_element(sprite_id, player_id, target_scale, duration, easing, on_complete)`

- **Location:** source line 933.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `target_scale` | Not explicitly documented in adjacent source annotations. |
| 4 | `duration` | Not explicitly documented in adjacent source annotations. |
| 5 | `easing` | Not explicitly documented in adjacent source annotations. |
| 6 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 40. `on_update(values)`

- **Location:** source line 954.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 41. `on_complete(values, interrupted)`

- **Location:** source line 960.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |
| 2 | `interrupted` | Not explicitly documented in adjacent source annotations. |

#### 42. `frame.relative_scale_ui_element(sprite_id, player_id, offset_scale, duration, easing, on_complete)`

- **Location:** source line 990.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `offset_scale` | Not explicitly documented in adjacent source annotations. |
| 4 | `duration` | Not explicitly documented in adjacent source annotations. |
| 5 | `easing` | Not explicitly documented in adjacent source annotations. |
| 6 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 43. `frame.rotate_ui_element(sprite_id, player_id, target_rotation, duration, easing, on_complete)`

- **Location:** source line 1000.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `target_rotation` | Not explicitly documented in adjacent source annotations. |
| 4 | `duration` | Not explicitly documented in adjacent source annotations. |
| 5 | `easing` | Not explicitly documented in adjacent source annotations. |
| 6 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 44. `on_update(values)`

- **Location:** source line 1021.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 45. `on_complete(values, interrupted)`

- **Location:** source line 1026.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |
| 2 | `interrupted` | Not explicitly documented in adjacent source annotations. |

#### 46. `frame.relative_rotate_ui_element(sprite_id, player_id, offset_rotation, duration, easing, on_complete)`

- **Location:** source line 1055.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `offset_rotation` | Not explicitly documented in adjacent source annotations. |
| 4 | `duration` | Not explicitly documented in adjacent source annotations. |
| 5 | `easing` | Not explicitly documented in adjacent source annotations. |
| 6 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 47. `frame.transform_ui_element(sprite_id, player_id, properties, duration, easing, on_complete)`

- **Location:** source line 1065.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `properties` | Not explicitly documented in adjacent source annotations. |
| 4 | `duration` | Not explicitly documented in adjacent source annotations. |
| 5 | `easing` | Not explicitly documented in adjacent source annotations. |
| 6 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 48. `on_update(values)`

- **Location:** source line 1098.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 49. `on_complete(values, interrupted)`

- **Location:** source line 1108.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |
| 2 | `interrupted` | Not explicitly documented in adjacent source annotations. |

#### 50. `frame.relative_transform_ui_element(sprite_id, player_id, offset_properties, duration, easing, on_complete)`

- **Location:** source line 1135.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `offset_properties` | Not explicitly documented in adjacent source annotations. |
| 4 | `duration` | Not explicitly documented in adjacent source annotations. |
| 5 | `easing` | Not explicitly documented in adjacent source annotations. |
| 6 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 51. `frame.bob_ui_element(sprite_id, player_id, distance, duration, easing, loop, ping_pong)`

- **Location:** source line 1155.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `distance` | Not explicitly documented in adjacent source annotations. |
| 4 | `duration` | Not explicitly documented in adjacent source annotations. |
| 5 | `easing` | Not explicitly documented in adjacent source annotations. |
| 6 | `loop` | Not explicitly documented in adjacent source annotations. |
| 7 | `ping_pong` | Not explicitly documented in adjacent source annotations. |

#### 52. `setPosition(self, x, y)`

- **Location:** source line 1171.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |

#### 53. `on_update(values)`

- **Location:** source line 1183.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 54. `frame.pulse_scale_ui_element(sprite_id, player_id, min_scale, max_scale, pulse_duration, easing, loops, on_complete)`

- **Location:** source line 1200.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `min_scale` | Not explicitly documented in adjacent source annotations. |
| 4 | `max_scale` | Not explicitly documented in adjacent source annotations. |
| 5 | `pulse_duration` | Not explicitly documented in adjacent source annotations. |
| 6 | `easing` | Not explicitly documented in adjacent source annotations. |
| 7 | `loops` | Not explicitly documented in adjacent source annotations. |
| 8 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 55. `on_update(values)`

- **Location:** source line 1218.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 56. `frame.color_pulse_from_current(sprite_id, player_id, target_color)`

- **Location:** source line 1235.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `target_color` | Not explicitly documented in adjacent source annotations. |

#### 57. `frame.summon_ui_element(sprite_id, player_id, start_x, start_y, start_scale, end_x, end_y, end_scale, duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete)`

- **Location:** source line 1252.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `start_x` | Not explicitly documented in adjacent source annotations. |
| 4 | `start_y` | Not explicitly documented in adjacent source annotations. |
| 5 | `start_scale` | Not explicitly documented in adjacent source annotations. |
| 6 | `end_x` | Not explicitly documented in adjacent source annotations. |
| 7 | `end_y` | Not explicitly documented in adjacent source annotations. |
| 8 | `end_scale` | Not explicitly documented in adjacent source annotations. |
| 9 | `duration` | Not explicitly documented in adjacent source annotations. |
| 10 | `arc_height` | Not explicitly documented in adjacent source annotations. |
| 11 | `peak_scale_mul` | Not explicitly documented in adjacent source annotations. |
| 12 | `wobble_deg` | Not explicitly documented in adjacent source annotations. |
| 13 | `easing` | Not explicitly documented in adjacent source annotations. |
| 14 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 58. `on_update(values)`

- **Location:** source line 1283.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 59. `on_complete(values, interrupted)`

- **Location:** source line 1306.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |
| 2 | `interrupted` | Not explicitly documented in adjacent source annotations. |

#### 60. `frame.complex_summon_ui_element(sprite_id, player_id, start_x, start_y, start_scale, end_x, end_y, end_scale, arc_duration, wobble_duration, settle_duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete, on_update_step1, on_update_step2, on_update_step3)`

- **Location:** source line 1336.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `start_x` | Not explicitly documented in adjacent source annotations. |
| 4 | `start_y` | Not explicitly documented in adjacent source annotations. |
| 5 | `start_scale` | Not explicitly documented in adjacent source annotations. |
| 6 | `end_x` | Not explicitly documented in adjacent source annotations. |
| 7 | `end_y` | Not explicitly documented in adjacent source annotations. |
| 8 | `end_scale` | Not explicitly documented in adjacent source annotations. |
| 9 | `arc_duration` | Not explicitly documented in adjacent source annotations. |
| 10 | `wobble_duration` | Not explicitly documented in adjacent source annotations. |
| 11 | `settle_duration` | Not explicitly documented in adjacent source annotations. |
| 12 | `arc_height` | Not explicitly documented in adjacent source annotations. |
| 13 | `peak_scale_mul` | Not explicitly documented in adjacent source annotations. |
| 14 | `wobble_deg` | Not explicitly documented in adjacent source annotations. |
| 15 | `easing` | Not explicitly documented in adjacent source annotations. |
| 16 | `on_complete` | Not explicitly documented in adjacent source annotations. |
| 17 | `on_update_step1` | Not explicitly documented in adjacent source annotations. |
| 18 | `on_update_step2` | Not explicitly documented in adjacent source annotations. |
| 19 | `on_update_step3` | Not explicitly documented in adjacent source annotations. |

#### 61. `on_update(values, t, phase)`

- **Location:** source line 1368.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |
| 2 | `t` | Not explicitly documented in adjacent source annotations. |
| 3 | `phase` | Not explicitly documented in adjacent source annotations. |

#### 62. `on_update(values, t, phase)`

- **Location:** source line 1396.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |
| 2 | `t` | Not explicitly documented in adjacent source annotations. |
| 3 | `phase` | Not explicitly documented in adjacent source annotations. |

#### 63. `on_update(values, t, phase)`

- **Location:** source line 1411.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |
| 2 | `t` | Not explicitly documented in adjacent source annotations. |
| 3 | `phase` | Not explicitly documented in adjacent source annotations. |

#### 64. `on_complete(values, interrupted)`

- **Location:** source line 1423.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |
| 2 | `interrupted` | Not explicitly documented in adjacent source annotations. |

#### 65. `on_complete()`

- **Location:** source line 1442.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 66. `frame.summon_ui_element_relative(sprite_id, player_id, end_x, end_y, end_scale, duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete)`

- **Location:** source line 1458.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `end_x` | Not explicitly documented in adjacent source annotations. |
| 4 | `end_y` | Not explicitly documented in adjacent source annotations. |
| 5 | `end_scale` | Not explicitly documented in adjacent source annotations. |
| 6 | `duration` | Not explicitly documented in adjacent source annotations. |
| 7 | `arc_height` | Not explicitly documented in adjacent source annotations. |
| 8 | `peak_scale_mul` | Not explicitly documented in adjacent source annotations. |
| 9 | `wobble_deg` | Not explicitly documented in adjacent source annotations. |
| 10 | `easing` | Not explicitly documented in adjacent source annotations. |
| 11 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 67. `frame.complex_summon_ui_element_relative(sprite_id, player_id, end_x, end_y, end_scale, arc_duration, wobble_duration, settle_duration, arc_height, peak_scale_mul, wobble_deg, easing, on_complete, on_update_step1, on_update_step2, on_update_step3)`

- **Location:** source line 1477.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `end_x` | Not explicitly documented in adjacent source annotations. |
| 4 | `end_y` | Not explicitly documented in adjacent source annotations. |
| 5 | `end_scale` | Not explicitly documented in adjacent source annotations. |
| 6 | `arc_duration` | Not explicitly documented in adjacent source annotations. |
| 7 | `wobble_duration` | Not explicitly documented in adjacent source annotations. |
| 8 | `settle_duration` | Not explicitly documented in adjacent source annotations. |
| 9 | `arc_height` | Not explicitly documented in adjacent source annotations. |
| 10 | `peak_scale_mul` | Not explicitly documented in adjacent source annotations. |
| 11 | `wobble_deg` | Not explicitly documented in adjacent source annotations. |
| 12 | `easing` | Not explicitly documented in adjacent source annotations. |
| 13 | `on_complete` | Not explicitly documented in adjacent source annotations. |
| 14 | `on_update_step1` | Not explicitly documented in adjacent source annotations. |
| 15 | `on_update_step2` | Not explicitly documented in adjacent source annotations. |
| 16 | `on_update_step3` | Not explicitly documented in adjacent source annotations. |

#### 68. `frame.set_opacity_ui_element(sprite_id, player_id, target_opacity, duration, easing, on_complete)`

- **Location:** source line 1501.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `target_opacity` | Not explicitly documented in adjacent source annotations. |
| 4 | `duration` | Not explicitly documented in adjacent source annotations. |
| 5 | `easing` | Not explicitly documented in adjacent source annotations. |
| 6 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 69. `on_update(values)`

- **Location:** source line 1522.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 70. `on_complete(values, interrupted)`

- **Location:** source line 1525.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |
| 2 | `interrupted` | Not explicitly documented in adjacent source annotations. |

#### 71. `frame.relative_set_opacity_ui_element(sprite_id, player_id, offset_opacity, duration, easing, on_complete)`

- **Location:** source line 1552.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `offset_opacity` | Not explicitly documented in adjacent source annotations. |
| 4 | `duration` | Not explicitly documented in adjacent source annotations. |
| 5 | `easing` | Not explicitly documented in adjacent source annotations. |
| 6 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 72. `frame.set_ui_element_color(sprite_id, player_id, r, g, b, duration, easing, on_complete)`

- **Location:** source line 1562.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `r` | Not explicitly documented in adjacent source annotations. |
| 4 | `g` | Not explicitly documented in adjacent source annotations. |
| 5 | `b` | Not explicitly documented in adjacent source annotations. |
| 6 | `duration` | Not explicitly documented in adjacent source annotations. |
| 7 | `easing` | Not explicitly documented in adjacent source annotations. |
| 8 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 73. `on_update(values)`

- **Location:** source line 1588.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 74. `on_complete(values, interrupted)`

- **Location:** source line 1595.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |
| 2 | `interrupted` | Not explicitly documented in adjacent source annotations. |

#### 75. `frame.relative_set_ui_element_color(sprite_id, player_id, offset_r, offset_g, offset_b, duration, easing, on_complete)`

- **Location:** source line 1622.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `offset_r` | Not explicitly documented in adjacent source annotations. |
| 4 | `offset_g` | Not explicitly documented in adjacent source annotations. |
| 5 | `offset_b` | Not explicitly documented in adjacent source annotations. |
| 6 | `duration` | Not explicitly documented in adjacent source annotations. |
| 7 | `easing` | Not explicitly documented in adjacent source annotations. |
| 8 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 76. `frame.color_pulse_ui_element(sprite_id, player_id, start_color, target_color)`

- **Location:** source line 1634.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `start_color` | Not explicitly documented in adjacent source annotations. |
| 4 | `target_color` | Not explicitly documented in adjacent source annotations. |

#### 77. `setColor(self, r, g, b)`

- **Location:** source line 1658.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `r` | Not explicitly documented in adjacent source annotations. |
| 3 | `g` | Not explicitly documented in adjacent source annotations. |
| 4 | `b` | Not explicitly documented in adjacent source annotations. |

#### 78. `setAlpha(self, alpha)`

- **Location:** source line 1664.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `alpha` | Not explicitly documented in adjacent source annotations. |

#### 79. `setOpacity(self,opacity)`

- **Location:** source line 1668.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `opacity` | Not explicitly documented in adjacent source annotations. |

#### 80. `frame.color_pulse_rgb(sprite_id, player_id, start_r, start_g, start_b, start_a, target_r, target_g, target_b, target_a)`

- **Location:** source line 1684.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `start_r` | Not explicitly documented in adjacent source annotations. |
| 4 | `start_g` | Not explicitly documented in adjacent source annotations. |
| 5 | `start_b` | Not explicitly documented in adjacent source annotations. |
| 6 | `start_a` | Not explicitly documented in adjacent source annotations. |
| 7 | `target_r` | Not explicitly documented in adjacent source annotations. |
| 8 | `target_g` | Not explicitly documented in adjacent source annotations. |
| 9 | `target_b` | Not explicitly documented in adjacent source annotations. |
| 10 | `target_a` | Not explicitly documented in adjacent source annotations. |

#### 81. `frame.menu_cursor_ui_element(sprite_id, player_id, bob_distance, pulse_scale, bob_duration, pulse_duration, orientation, easing, back_easing, on_complete)`

- **Location:** source line 1703.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `bob_distance` | Not explicitly documented in adjacent source annotations. |
| 4 | `pulse_scale` | Not explicitly documented in adjacent source annotations. |
| 5 | `bob_duration` | Not explicitly documented in adjacent source annotations. |
| 6 | `pulse_duration` | Not explicitly documented in adjacent source annotations. |
| 7 | `orientation` | Not explicitly documented in adjacent source annotations. |
| 8 | `easing` | Not explicitly documented in adjacent source annotations. |
| 9 | `back_easing` | Not explicitly documented in adjacent source annotations. |
| 10 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 82. `on_update(values)`

- **Location:** source line 1731.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 83. `on_update(values)`

- **Location:** source line 1745.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `values` | Not explicitly documented in adjacent source annotations. |

#### 84. `stop()`

- **Location:** source line 1763.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 85. `frame.shake_ui_element(sprite_id, player_id, intensity, duration, frequency, on_complete)`

- **Location:** source line 1777.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `intensity` | Not explicitly documented in adjacent source annotations. |
| 4 | `duration` | Not explicitly documented in adjacent source annotations. |
| 5 | `frequency` | Not explicitly documented in adjacent source annotations. |
| 6 | `on_complete` | Not explicitly documented in adjacent source annotations. |

#### 86. `setPosition(self, x, y)`

- **Location:** source line 1795.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `x` | Not explicitly documented in adjacent source annotations. |
| 3 | `y` | Not explicitly documented in adjacent source annotations. |

#### 87. `setRotation(self, rotation)`

- **Location:** source line 1798.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `rotation` | Not explicitly documented in adjacent source annotations. |

#### 88. `on_complete()`

- **Location:** source line 1808.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 89. `on_update(value)`

- **Location:** source line 1817.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `value` | Not explicitly documented in adjacent source annotations. |

#### 90. `frame.set_ui_element_instant(sprite_id, player_id, properties)`

- **Location:** source line 1831.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `properties` | Not explicitly documented in adjacent source annotations. |

#### 91. `frame.reset_ui_element(sprite_id, player_id, initial_values)`

- **Location:** source line 1848.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `initial_values` | Not explicitly documented in adjacent source annotations. |

#### 92. `frame.stop_ui_animation(sprite_id, player_id, anim_id)`

- **Location:** source line 1877.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `anim_id` | Not explicitly documented in adjacent source annotations. |

#### 93. `frame.has_active_animations(sprite_id, player_id)`

- **Location:** source line 1906.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 94. `frame.is_animation_running(sprite_id, player_id, anim_id)`

- **Location:** source line 1915.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `anim_id` | Not explicitly documented in adjacent source annotations. |

#### 95. `frame.get_ui_element_properties(sprite_id, player_id)`

- **Location:** source line 1924.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 96. `frame.spawn_cursor(sprite_id, player_id, options)`

- **Location:** source line 1959.
- **Declaration style:** `declared`.
- **Adjacent source comment:** CURSOR FUNCTIONS

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sprite_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `options` | Not explicitly documented in adjacent source annotations. |

#### 97. `frame.remove_cursor(cursor_id, player_id)`

- **Location:** source line 1993.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cursor_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 98. `frame.move_cursor_to_selection(cursor_id, player_id, selection_name)`

- **Location:** source line 2002.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cursor_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `selection_name` | Not explicitly documented in adjacent source annotations. |

#### 99. `frame.get_current_cursor_selection(cursor_id, player_id)`

- **Location:** source line 2040.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cursor_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 100. `frame.lock_cursor(cursor_id, player_id, locked)`

- **Location:** source line 2055.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cursor_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `locked` | Not explicitly documented in adjacent source annotations. |

#### 101. `frame.is_cursor_locked(cursor_id, player_id)`

- **Location:** source line 2065.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cursor_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 102. `frame.update_cursor_options(cursor_id, player_id, new_options)`

- **Location:** source line 2074.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `cursor_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `new_options` | Not explicitly documented in adjacent source annotations. |

#### 103. `frame.detach_camera(player_id)`

- **Location:** source line 2100.
- **Declaration style:** `declared`.
- **Adjacent source comment:** CAMERA FUNCTIONS

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 104. `frame.draw_text(text_id, player_id, text, x, y, z, font, scale)`

- **Location:** source line 2108.
- **Declaration style:** `declared`.
- **Adjacent source comment:** TEXT FUNCTIONS

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `x` | Not explicitly documented in adjacent source annotations. |
| 5 | `y` | Not explicitly documented in adjacent source annotations. |
| 6 | `z` | Not explicitly documented in adjacent source annotations. |
| 7 | `font` | Not explicitly documented in adjacent source annotations. |
| 8 | `scale` | Not explicitly documented in adjacent source annotations. |

#### 105. `frame.update_text(text_id, player_id, text)`

- **Location:** source line 2125.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |

#### 106. `frame.remove_text(text_id, player_id)`

- **Location:** source line 2134.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `text_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 107. `frame.draw_advanced_text(player_id, text, opts)`

- **Location:** source line 2141.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `text` | Not explicitly documented in adjacent source annotations. |
| 3 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 108. `frame.draw_marquee_text(marquee_id, player_id, text, y, font, scale, z_order, speed, backdrop)`

- **Location:** source line 2158.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `marquee_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `text` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `font` | Not explicitly documented in adjacent source annotations. |
| 6 | `scale` | Not explicitly documented in adjacent source annotations. |
| 7 | `z_order` | Not explicitly documented in adjacent source annotations. |
| 8 | `speed` | Not explicitly documented in adjacent source annotations. |
| 9 | `backdrop` | Not explicitly documented in adjacent source annotations. |

#### 109. `frame.set_marquee_position(player_id, marquee_id, x, y)`

- **Location:** source line 2176.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `marquee_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |

#### 110. `frame.set_marquee_speed(player_id, marquee_id, speed)`

- **Location:** source line 2193.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `marquee_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `speed` | Not explicitly documented in adjacent source annotations. |

#### 111. `frame.spawn_timer(timer_id, player_id, x, y, duration, loop)`

- **Location:** source line 2212.
- **Declaration style:** `declared`.
- **Adjacent source comment:** TIMER FUNCTIONS

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `timer_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `duration` | Not explicitly documented in adjacent source annotations. |
| 6 | `loop` | Not explicitly documented in adjacent source annotations. |

#### 112. `callback(_, timer_id, value)`

- **Location:** source line 2214.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `_` | Not explicitly documented in adjacent source annotations. |
| 2 | `timer_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `value` | Not explicitly documented in adjacent source annotations. |

#### 113. `frame.resume_timer(timer_id, player_id)`

- **Location:** source line 2221.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `timer_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 114. `frame.pause_timer(timer_id, player_id)`

- **Location:** source line 2225.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `timer_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 115. `frame.remove_timer(timer_id, player_id)`

- **Location:** source line 2229.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `timer_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 116. `frame.update_timer(timer_id, player_id, duration)`

- **Location:** source line 2237.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `timer_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `duration` | Not explicitly documented in adjacent source annotations. |

#### 117. `frame.spawn_countdown(countdown_id, player_id, x, y, duration, loop)`

- **Location:** source line 2250.
- **Declaration style:** `declared`.
- **Adjacent source comment:** COUNTDOWN FUNCTIONS

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `countdown_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `x` | Not explicitly documented in adjacent source annotations. |
| 4 | `y` | Not explicitly documented in adjacent source annotations. |
| 5 | `duration` | Not explicitly documented in adjacent source annotations. |
| 6 | `loop` | Not explicitly documented in adjacent source annotations. |

#### 118. `callback(_, countdown_id, value)`

- **Location:** source line 2252.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `_` | Not explicitly documented in adjacent source annotations. |
| 2 | `countdown_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `value` | Not explicitly documented in adjacent source annotations. |

#### 119. `frame.resume_countdown(countdown_id, player_id)`

- **Location:** source line 2263.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `countdown_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 120. `frame.pause_countdown(countdown_id, player_id)`

- **Location:** source line 2267.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `countdown_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 121. `frame.remove_countdown(countdown_id, player_id)`

- **Location:** source line 2271.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `countdown_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |

#### 122. `frame.update_countdown(countdown_id, player_id, duration)`

- **Location:** source line 2279.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `countdown_id` | Not explicitly documented in adjacent source annotations. |
| 2 | `player_id` | Not explicitly documented in adjacent source annotations. |
| 3 | `duration` | Not explicitly documented in adjacent source annotations. |

#### 123. `splitter(inputstr, sep)`

- **Location:** source line 2292.
- **Declaration style:** `local`.
- **Adjacent source comment:** UTILITY FUNCTIONS

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `inputstr` | Not explicitly documented in adjacent source annotations. |
| 2 | `sep` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 134 | `event` | `VISION -- =========================================================== Net:on("player…` |
| 144 | `(none)` | `============= local function try_move_player(player_id, area_id, x, y, z) local ok =…` |
| 151 | `(none)` | `end end) if ok and Net.transfer_player then return true end ok = pcall(` |
| 158 | `(none)` | `end end) if ok and Net.transfer_player then return true end ok = pcall(` |
| 165 | `(none)` | `z) end end) if ok and Net.move_player then return true end ok = pcall(` |
| 176 | `(none)` | `eturn false end local function try_animate_player(player_id, anim_state) local ok = …` |
| 187 | `(none)` | `end) if ok and Net.animate_player_properties then return true end ok = pcall(` |
| 198 | `(none)` | `return false end function frame.move_frozen_player(player_id, x, y, z) return async(` |
| 206 | `(none)` | `0)) end) end function frame.animate_frozen_player(player_id, anim_state) return asyn…` |
| 230 | `(none)` | `cale, bot_scale, owner_sprite_state, owner_sprite_enabled, movement_duration) return…` |
| 2020 | `(none)` | `selection.y, 0.15, "ease_out_quad",` |
| 2309 | `event` | `ANDLING -- =========================================================== Net:on("virtu…` |
| 2398 | `event` | `-- TICK HANDLER -- =========================================================== Net:o…` |
| 2434 | `event` | `HANDLERS -- =========================================================== Net:on("curs…` |
| 2451 | `(none)` | `election.y, 0.1, "ease_out_back",` |
| 2473 | `event` | `print("[games] No cursor found for player " .. player_id) end end) Net:on("player_jo…` |
| 2491 | `event` | `event.player_id, bot_id) end end end end) Net:on("player_disconnect",` |
| 2536 | `event` | `= nil end InputSystem.destroy_controller(event.player_id) end) Net:on("player_move",` |
| 2585 | `event` | `bot_id, target_x, target_y, target_z) end end end) Net:on("player_area_transfer",` |

## 📦 Tables and data

The following **57** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `assets` — line 16

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"/server/assets/net-games/fonts/fonts_compressed.png"` |
| `[2]` | string literal | `"/server/assets/net-games/fonts/fonts_wide.animation"` |
| `[3]` | string literal | `"/server/assets/net-games/fonts/fonts_gradient.animation"` |
| `[4]` | string literal | `"/server/assets/net-games/fonts/fonts_thick.animation"` |
| `[5]` | string literal | `"/server/assets/net-games/fonts/fonts_battle.animation"` |
| `[6]` | string literal | `"/server/assets/net-games/fonts/fonts_thin.animation"` |
| `[7]` | string literal | `"/server/assets/net-games/fonts/fonts_tiny.animation"` |
| `[8]` | string literal | `"/server/assets/net-games/fonts/fonts_compressed.animation"` |
| `[9]` | string literal | `"/server/assets/net-games/fonts/fonts_dark_compressed.png"` |
| `[10]` | string literal | `"/server/assets/net-games/fonts/fonts_dark_compressed.animation"` |

### 2. `frame` — line 37

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 3. `last_position_cache` — line 38

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `cosmetic_cache` — line 39

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 5. `avatar_cache` — line 41

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `ui_cache` — line 42

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `map_elements` — line 43

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 8. `ui_update` — line 44

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `online_players` — line 45

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `text_cache` — line 47

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `marquee_cache` — line 48

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `timer_cache` — line 49

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `countdown_cache` — line 50

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 14. `repeat_state` — line 51

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 15. `return` — line 94

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `color.r or color[1] or 255` |
| `g` | expression/reference | `color.g or color[2] or 255` |
| `b` | expression/reference | `color.b or color[3] or 255` |
| `a` | expression/reference | `color.a or color[4] or 255` |

### 16. `keyframes` — line 178

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ properties = {{property = "Animation", value = anim_state}}, duration = 0 }` |

### 17. `properties` — line 179

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{property = "Animation", value = anim_state}` |

### 18. `keyframes` — line 365

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ properties = { { property = "ScaleX", ease = "Linear", value = world_bot_scale }, { property = "ScaleY", ease = "Linear", value = world_bot_scale }, }, …` |

### 19. `properties` — line 366

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ property = "ScaleX", ease = "Linear", value = world_bot_scale }` |
| `[2]` | nested table | `{ property = "ScaleY", ease = "Linear", value = world_bot_scale }` |

### 20. `animations` — line 622

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 21. `children` — line 624

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 22. `sprite_data` — line 641

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `id` | expression/reference | `sprite_id .. "_obj"` |

### 23. `return` — line 740

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `element.x` |
| `y` | expression/reference | `element.y` |
| `z` | expression/reference | `element.z` |
| `sx` | expression/reference | `element.sx` |
| `sy` | expression/reference | `element.sy` |
| `ox` | expression/reference | `element.ox` |
| `oy` | expression/reference | `element.oy` |
| `ro` | expression/reference | `element.ro` |
| `opacity` | expression/reference | `element.opacity` |
| `r` | expression/reference | `element.r` |
| `g` | expression/reference | `element.g` |
| `b` | expression/reference | `element.b` |
| `a` | expression/reference | `element.a` |
| `setPosition` | function | `function(self, x, y) element.x = x element.y = y frame.update_ui_element(sprite_id, player_id, {x = x, y = y}) end` |
| `setScale` | function | `function(self, sx, sy) element.sx = sx element.sy = sy or sx frame.update_ui_element(sprite_id, player_id, {sx = sx, sy = sy or sx}) end` |
| `setRotation` | function | `function(self, ro) element.ro = ro frame.update_ui_element(sprite_id, player_id, {ro = ro}) end` |
| `setOpacity` | function | `function(self, opacity) element.opacity = opacity frame.update_ui_element(sprite_id, player_id, {opacity = opacity}) end` |
| `setColor` | function | `function(self, r, g, b, a) element.r = r or element.r element.g = g or element.g element.b = b or element.b element.a = a or element.a frame.update_ui_ele…` |
| `setRo` | function | `function(self, ro) element.ro = ro frame.update_ui_element(sprite_id, player_id, {ro = ro}) end` |

### 24. `element.animations` — line 839

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 25. `element.animations` — line 907

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 26. `element.animations` — line 983

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 27. `element.animations` — line 1048

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 28. `current_props` — line 1075

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `element.x` |
| `y` | expression/reference | `element.y` |
| `sx` | expression/reference | `element.sx` |
| `sy` | expression/reference | `element.sy` |
| `ro` | expression/reference | `element.ro` |
| `opacity` | expression/reference | `element.opacity` |

### 29. `target_props` — line 1084

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 30. `element.animations` — line 1128

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 31. `target_props` — line 1141

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 32. `proxy` — line 1169

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `y` | expression/reference | `start_y` |
| `setPosition` | function | `function(self, x, y) element.y = y frame.update_ui_element(sprite_id, player_id, {y = y}) end` |

### 33. `element.animations` — line 1193

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 34. `element.animations` — line 1228

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 35. `current_color` — line 1242

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `element.r or 255` |
| `g` | expression/reference | `element.g or 255` |
| `b` | expression/reference | `element.b or 255` |
| `a` | expression/reference | `element.a or 255` |

### 36. `element.animations` — line 1329

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 37. `sequence_steps` — line 1362

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 38. `element.animations` — line 1450

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 39. `element.animations` — line 1545

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 40. `element.animations` — line 1615

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 41. `start_color` — line 1645

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `element.r or 255` |
| `g` | expression/reference | `element.g or 255` |
| `b` | expression/reference | `element.b or 255` |
| `a` | expression/reference | `element.a or 255` |

### 42. `proxy` — line 1653

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `element.r or 255` |
| `g` | expression/reference | `element.g or 255` |
| `b` | expression/reference | `element.b or 255` |
| `a` | expression/reference | `element.a or 255` |
| `setColor` | function | `function(self, r, g, b) element.r = r element.g = g element.b = b frame.update_ui_element(sprite_id, player_id, {r = r, g = g, b = b}) end` |
| `setAlpha` | function | `function(self, alpha) element.a = alpha frame.update_ui_element(sprite_id, player_id, {a = alpha}) end` |
| `setOpacity` | function | `function(self,opacity) element.opacity = opacity frame.update_ui_element(sprite_id, player_id, {o = opacity}) end` |

### 43. `element.animations` — line 1677

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 44. `start_color` — line 1686

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `start_r or 255` |
| `g` | expression/reference | `start_g or 255` |
| `b` | expression/reference | `start_b or 255` |
| `a` | expression/reference | `start_a or 255` |

### 45. `target_color` — line 1693

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `r` | expression/reference | `target_r or 255` |
| `g` | expression/reference | `target_g or 255` |
| `b` | expression/reference | `target_b or 255` |
| `a` | expression/reference | `target_a or start_color.a` |

### 46. `element.animations` — line 1755

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 47. `return` — line 1760

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `bob` | expression/reference | `bob_id` |
| `pulse` | expression/reference | `pulse_id` |
| `stop` | function | `function() AnimationEngine.stop_animation(bob_id) AnimationEngine.stop_animation(pulse_id) if element.animations then element.animations[bob_id] = nil ele…` |

### 48. `shake_object` — line 1791

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `proxy.x` |
| `y` | expression/reference | `proxy.y` |
| `rotation` | expression/reference | `proxy.ro` |
| `setPosition` | function | `function(self, x, y) proxy:setPosition(x, y) end` |
| `setRotation` | function | `function(self, rotation) proxy:setRo(rotation) end` |

### 49. `element.animations` — line 1824

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 50. `element.animations` — line 1900

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 51. `return` — line 1930

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `element.x` |
| `y` | expression/reference | `element.y` |
| `z` | expression/reference | `element.z` |
| `ox` | expression/reference | `element.ox` |
| `oy` | expression/reference | `element.oy` |
| `sx` | expression/reference | `element.sx` |
| `sy` | expression/reference | `element.sy` |
| `ro` | expression/reference | `element.ro` |
| `opacity` | expression/reference | `element.opacity` |
| `a` | expression/reference | `element.a` |
| `r` | expression/reference | `element.r` |
| `g` | expression/reference | `element.g` |
| `b` | expression/reference | `element.b` |
| `color_mode` | expression/reference | `element.color_mode` |
| `animation_state` | expression/reference | `element.animation_state` |
| `has_animations` | expression/reference | `element.animations and next(element.animations) ~= nil` |
| `box_width` | expression/reference | `element.box_width` |
| `box_height` | expression/reference | `element.box_height` |
| `halign` | expression/reference | `element.halign` |
| `valign` | expression/reference | `element.valign` |
| `sprite_width` | expression/reference | `element.sprite_width` |
| `sprite_height` | expression/reference | `element.sprite_height` |

### 52. `obj_cache.cursor_options` — line 1983

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `selections` | expression/reference | `options.selections` |
| `movement` | expression/reference | `options.movement or "vertical"` |
| `current_index` | numeric literal | `1` |
| `locked` | boolean literal | `false` |
| `name` | expression/reference | `sprite_id` |

### 53. `opts` — line 2159

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `font` | expression/reference | `font or "THICK"` |
| `scale` | expression/reference | `scale or 2.0` |
| `z` | expression/reference | `z_order or 100` |
| `speed` | expression/reference | `speed or 60` |
| `loops` | nil | `nil` |

### 54. `t` — line 2299

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 55. `keyframes` — line 2554

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ properties = { { property = "X", value = tonumber(bot_position.x) or target_x }, { property = "Y", value = tonumber(bot_position.y) or target_y }, { pro…` |
| `[2]` | nested table | `{ properties = { { property = "X", ease = "Linear", value = target_x }, { property = "Y", ease = "Linear", value = target_y }, { property = "Z", ease = "L…` |

### 56. `properties` — line 2556

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ property = "X", value = tonumber(bot_position.x) or target_x }` |
| `[2]` | nested table | `{ property = "Y", value = tonumber(bot_position.y) or target_y }` |
| `[3]` | nested table | `{ property = "Z", value = tonumber(bot_position.z) or target_z }` |

### 57. `properties` — line 2564

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ property = "X", ease = "Linear", value = target_x }` |
| `[2]` | nested table | `{ property = "Y", ease = "Linear", value = target_y }` |
| `[3]` | nested table | `{ property = "Z", ease = "Linear", value = target_z }` |

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Async.await` | 1 |
| `Async.promisify` | 1 |
| `Async.sleep` | 2 |
| `Net.animate_bot` | 2 |
| `Net.animate_player_properties` | 1 |
| `Net.create_bot` | 2 |
| `Net.emit` | 5 |
| `Net.exclude_actor_for_player` | 1 |
| `Net.get_player_area` | 5 |
| `Net.get_player_position` | 1 |
| `Net.is_bot` | 5 |
| `Net.lock_player_input` | 1 |
| `Net.move_bot` | 1 |
| `Net.move_player` | 1 |
| `Net.on` | 8 |
| `Net.player_alloc_sprite` | 2 |
| `Net.player_draw_sprite` | 5 |
| `Net.player_erase_sprite` | 2 |
| `Net.provide_asset_for_player` | 5 |
| `Net.remove_bot` | 4 |
| `Net.set_player_animation` | 1 |
| `Net.set_player_position` | 1 |
| `Net.transfer_bot` | 2 |
| `Net.transfer_player` | 2 |
| `Net.unlock_player_input` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
