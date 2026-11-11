# 📄 `ezbuttons.lua` — Current Lua reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/ezbuttons.lua`](../../../ezlibs-scripts/ezbuttons.lua)  
> **Source lines:** 1980  
> **SHA-256 (UTF-8):** `ef606ebacc70e1039b9a8647b36c11ac1287ab9fad6e213c54044e0d6f7c4756`  
> **Named functions detected:** 62  
> **Table initializers detected:** 28

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
| 35 | `scripts/logger/logger` |
| 36 | `scripts/ezlibs-scripts/object_registry` |
| 37 | `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| 38 | `scripts/ezlibs-scripts/eztriggers/eztriggers` |
| 39 | `scripts/ezlibs-scripts/ezmemory` |
| 40 | `scripts/ezlibs-scripts/ezbus` |
| 41 | `scripts/ezlibs-scripts/helpers` |
| 42 | `scripts/ezlibs-scripts/ezcheckpoints` |
| 43 | `scripts/ezlibs-scripts/utils/eztiledutils` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 412 | `Net` | `player_join` |
| 428 | `Net` | `player_area_transfer` |
| 484 | `Net` | `player_disconnect` |
| 1383 | `emitter` | `entered` |
| 1384 | `emitter` | `departed` |
| 1387 | `bot_emitter` | `entered` |
| 1388 | `bot_emitter` | `departed` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 60 | `async` | `p` | assigned/declared |
| 65 | `await` | `v` | assigned/declared |
| 81 | `player_is_alive` | `player_id` | local |
| 89 | `validate_button_object` | `area_id, object` | local |
| 106 | `object_to_tile_pos` | `object` | local |
| 143 | `normalize_ids` | `ids` | local |
| 158 | `find_live_contributor` | `area_id, group` | local |
| 159 | `first_live_from` | `ids` | local |
| 181 | `resolve_transition_player` | `area_id, group, event_player_id` | local |
| 201 | `combo_is_satisfied` | `area_id, combo` | local |
| 223 | `group_is_satisfied` | `area_id, group` | local |
| 253 | `apply_logic_action` | `area_id, target_id, action, player_id, was_bot` | local |
| 289 | `process_logic_event` | `event` | local |
| 333 | `enqueue_logic_event` | `area_id, object_id, active, player_id, was_bot` | local |
| 358 | `hide_button_placeholder_for_player` | `player_id, area_id, object_id` | local |
| 365 | `hide_button_placeholders_for_player` | `player_id` | local |
| 376 | `set_button_animation` | `bot_id, anim_state, loop` | local |
| 385 | `sync_button_animations_for_player` | `player_id` | local |
| 402 | `apply_area_wide_unlocks` | `player_id, area_id` | local |
| 447 | `cleanup_player_state` | `player_id` | local |
| 493 | `ezbuttons.handle_player_disconnect` | `player_id` | assigned/declared |
| 548 | `is_button_active` | `area_id, object_id` | assigned/declared |
| 554 | `set_button_active_state` | `area_id, object_id, bot_id, active_anim, inactive_anim, active` | assigned/declared |
| 564 | `create_button_trigger` | `area_id, object, width_px, height_px, trigger_id` | local |
| 588 | `ezbuttons.camera_release` | `player_id` | assigned/declared |
| 592 | `ezbuttons.camera_move` | `player_id, x, y, z` | assigned/declared |
| 596 | `ezbuttons.camera_reattach` | `player_id` | assigned/declared |
| 601 | `smooth_camera_pan` | `player_id, from_pos, to_pos, duration` | local |
| 721 | `perform_activation` | `area_id, object_id, player_id, info` | assigned/declared |
| 811 | `perform_deactivation` | `area_id, object_id, info` | assigned/declared |
| 875 | `reconcile_pending_button_state` | `area_id, object_id, info` | local |
| 896 | `deactivate_button_internal` | `area_id, object_id, info` | assigned/declared |
| 923 | `finish_deactivation` | `(none)` | local |
| 943 | `start_timed_deactivation` | `area_id, object_id, info` | local |
| 967 | `activate_button` | `area_id, object_id, player_id, was_bot` | assigned/declared |
| 1006 | `deactivate_button` | `area_id, object_id` | assigned/declared |
| 1017 | `load_custom_script` | `script_path` | local |
| 1039 | `register_button_object` | `area_id, object, group_member` | local |
| 1275 | `resolve_actor_id` | `event, actor_type` | local |
| 1280 | `mark_actor_present` | `actor_id, actor_type` | local |
| 1288 | `clear_actor_present` | `actor_id, actor_type` | local |
| 1296 | `on_button_entered` | `event, actor_type` | local |
| 1350 | `on_button_departed` | `event, actor_type` | local |
| 1418 | `ezbuttons.is_button_active` | `area_id, object_id` | assigned/declared |
| 1422 | `ezbuttons.activate_button` | `area_id, object_id, player_id, was_bot` | assigned/declared |
| 1426 | `ezbuttons.deactivate_button` | `area_id, object_id` | assigned/declared |
| 1430 | `ezbuttons.reset_button` | `area_id, object_id` | assigned/declared |
| 1442 | `ezbuttons.define_group` | `area_id, group_id, button_ids, mode, options` | assigned/declared |
| 1469 | `ezbuttons.on_group_change` | `area_id, group_id, callback` | assigned/declared |
| 1477 | `ezbuttons.add_button_effect` | `area_id, source_id, event_name, target_id, action` | assigned/declared |
| 1489 | `ezbuttons.add_group_effect` | `area_id, group_id, event_name, target_id, action` | assigned/declared |
| 1501 | `ezbuttons.refresh_groups` | `area_id, player_id` | assigned/declared |
| 1511 | `ezbuttons.get_group_state` | `area_id, group_id` | assigned/declared |
| 1519 | `property_ids` | `props, prefix` | local |
| 1680 | `configure_group_object` | `area_id, object` | local |
| 1715 | `on_change` | `changed_area_id, changed_group_id, satisfied, player_id, was_bot` | assigned/declared |
| 1758 | `try_configure_pending_groups` | `area_id` | assigned/declared |
| 1775 | `configure_button_combo_object` | `area_id, object` | local |
| 1818 | `try_configure_pending_combos` | `area_id` | assigned/declared |
| 1835 | `configure_combo_button_group_object` | `area_id, object` | local |
| 1877 | `callback` | `changed_area_id, changed_group_id, satisfied, player_id, was_bot` | assigned/declared |
| 1928 | `try_configure_pending_combo_groups` | `area_id` | assigned/declared |

### Parameter inventory

#### 1. `async(p)`

- **Line:** 60
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `p` | Declared directly in the current Lua. Type not inferred. |

#### 2. `await(v)`

- **Line:** 65
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `v` | Declared directly in the current Lua. Type not inferred. |

#### 3. `player_is_alive(player_id)`

- **Line:** 81
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 4. `validate_button_object(area_id, object)`

- **Line:** 89
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object` | Declared directly in the current Lua. Type not inferred. |

#### 5. `object_to_tile_pos(object)`

- **Line:** 106
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `object` | Declared directly in the current Lua. Type not inferred. |

#### 6. `normalize_ids(ids)`

- **Line:** 143
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ids` | Declared directly in the current Lua. Type not inferred. |

#### 7. `find_live_contributor(area_id, group)`

- **Line:** 158
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `group` | Declared directly in the current Lua. Type not inferred. |

#### 8. `first_live_from(ids)`

- **Line:** 159
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `ids` | Declared directly in the current Lua. Type not inferred. |

#### 9. `resolve_transition_player(area_id, group, event_player_id)`

- **Line:** 181
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `group` | Declared directly in the current Lua. Type not inferred. |
| 3 | `event_player_id` | Declared directly in the current Lua. Type not inferred. |

#### 10. `combo_is_satisfied(area_id, combo)`

- **Line:** 201
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `combo` | Declared directly in the current Lua. Type not inferred. |

#### 11. `group_is_satisfied(area_id, group)`

- **Line:** 223
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `group` | Declared directly in the current Lua. Type not inferred. |

#### 12. `apply_logic_action(area_id, target_id, action, player_id, was_bot)`

- **Line:** 253
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `target_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `action` | Declared directly in the current Lua. Type not inferred. |
| 4 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 5 | `was_bot` | Declared directly in the current Lua. Type not inferred. |

#### 13. `process_logic_event(event)`

- **Line:** 289
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `event` | Declared directly in the current Lua. Type not inferred. |

#### 14. `enqueue_logic_event(area_id, object_id, active, player_id, was_bot)`

- **Line:** 333
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `active` | Declared directly in the current Lua. Type not inferred. |
| 4 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 5 | `was_bot` | Declared directly in the current Lua. Type not inferred. |

#### 15. `hide_button_placeholder_for_player(player_id, area_id, object_id)`

- **Line:** 358
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `object_id` | Declared directly in the current Lua. Type not inferred. |

#### 16. `hide_button_placeholders_for_player(player_id)`

- **Line:** 365
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 17. `set_button_animation(bot_id, anim_state, loop)`

- **Line:** 376
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `anim_state` | Declared directly in the current Lua. Type not inferred. |
| 3 | `loop` | Declared directly in the current Lua. Type not inferred. |

#### 18. `sync_button_animations_for_player(player_id)`

- **Line:** 385
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 19. `apply_area_wide_unlocks(player_id, area_id)`

- **Line:** 402
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |

#### 20. `cleanup_player_state(player_id)`

- **Line:** 447
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 21. `ezbuttons.handle_player_disconnect(player_id)`

- **Line:** 493
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 22. `is_button_active(area_id, object_id)`

- **Line:** 548
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |

#### 23. `set_button_active_state(area_id, object_id, bot_id, active_anim, inactive_anim, active)`

- **Line:** 554
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `bot_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `active_anim` | Declared directly in the current Lua. Type not inferred. |
| 5 | `inactive_anim` | Declared directly in the current Lua. Type not inferred. |
| 6 | `active` | Declared directly in the current Lua. Type not inferred. |

#### 24. `create_button_trigger(area_id, object, width_px, height_px, trigger_id)`

- **Line:** 564
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object` | Declared directly in the current Lua. Type not inferred. |
| 3 | `width_px` | Declared directly in the current Lua. Type not inferred. |
| 4 | `height_px` | Declared directly in the current Lua. Type not inferred. |
| 5 | `trigger_id` | Declared directly in the current Lua. Type not inferred. |

#### 25. `ezbuttons.camera_release(player_id)`

- **Line:** 588
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 26. `ezbuttons.camera_move(player_id, x, y, z)`

- **Line:** 592
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `x` | Declared directly in the current Lua. Type not inferred. |
| 3 | `y` | Declared directly in the current Lua. Type not inferred. |
| 4 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 27. `ezbuttons.camera_reattach(player_id)`

- **Line:** 596
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 28. `smooth_camera_pan(player_id, from_pos, to_pos, duration)`

- **Line:** 601
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `from_pos` | Declared directly in the current Lua. Type not inferred. |
| 3 | `to_pos` | Declared directly in the current Lua. Type not inferred. |
| 4 | `duration` | Declared directly in the current Lua. Type not inferred. |

#### 29. `perform_activation(area_id, object_id, player_id, info)`

- **Line:** 721
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `info` | Declared directly in the current Lua. Type not inferred. |

#### 30. `perform_deactivation(area_id, object_id, info)`

- **Line:** 811
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `info` | Declared directly in the current Lua. Type not inferred. |

#### 31. `reconcile_pending_button_state(area_id, object_id, info)`

- **Line:** 875
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `info` | Declared directly in the current Lua. Type not inferred. |

#### 32. `deactivate_button_internal(area_id, object_id, info)`

- **Line:** 896
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `info` | Declared directly in the current Lua. Type not inferred. |

#### 33. `finish_deactivation()`

- **Line:** 923
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 34. `start_timed_deactivation(area_id, object_id, info)`

- **Line:** 943
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `info` | Declared directly in the current Lua. Type not inferred. |

#### 35. `activate_button(area_id, object_id, player_id, was_bot)`

- **Line:** 967
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `was_bot` | Declared directly in the current Lua. Type not inferred. |

#### 36. `deactivate_button(area_id, object_id)`

- **Line:** 1006
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |

#### 37. `load_custom_script(script_path)`

- **Line:** 1017
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `script_path` | Declared directly in the current Lua. Type not inferred. |

#### 38. `register_button_object(area_id, object, group_member)`

- **Line:** 1039
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object` | Declared directly in the current Lua. Type not inferred. |
| 3 | `group_member` | Declared directly in the current Lua. Type not inferred. |

#### 39. `resolve_actor_id(event, actor_type)`

- **Line:** 1275
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `event` | Declared directly in the current Lua. Type not inferred. |
| 2 | `actor_type` | Declared directly in the current Lua. Type not inferred. |

#### 40. `mark_actor_present(actor_id, actor_type)`

- **Line:** 1280
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `actor_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `actor_type` | Declared directly in the current Lua. Type not inferred. |

#### 41. `clear_actor_present(actor_id, actor_type)`

- **Line:** 1288
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `actor_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `actor_type` | Declared directly in the current Lua. Type not inferred. |

#### 42. `on_button_entered(event, actor_type)`

- **Line:** 1296
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `event` | Declared directly in the current Lua. Type not inferred. |
| 2 | `actor_type` | Declared directly in the current Lua. Type not inferred. |

#### 43. `on_button_departed(event, actor_type)`

- **Line:** 1350
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `event` | Declared directly in the current Lua. Type not inferred. |
| 2 | `actor_type` | Declared directly in the current Lua. Type not inferred. |

#### 44. `ezbuttons.is_button_active(area_id, object_id)`

- **Line:** 1418
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |

#### 45. `ezbuttons.activate_button(area_id, object_id, player_id, was_bot)`

- **Line:** 1422
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `was_bot` | Declared directly in the current Lua. Type not inferred. |

#### 46. `ezbuttons.deactivate_button(area_id, object_id)`

- **Line:** 1426
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |

#### 47. `ezbuttons.reset_button(area_id, object_id)`

- **Line:** 1430
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |

#### 48. `ezbuttons.define_group(area_id, group_id, button_ids, mode, options)`

- **Line:** 1442
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `group_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `button_ids` | Declared directly in the current Lua. Type not inferred. |
| 4 | `mode` | Declared directly in the current Lua. Type not inferred. |
| 5 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 49. `ezbuttons.on_group_change(area_id, group_id, callback)`

- **Line:** 1469
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `group_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `callback` | Declared directly in the current Lua. Type not inferred. |

#### 50. `ezbuttons.add_button_effect(area_id, source_id, event_name, target_id, action)`

- **Line:** 1477
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `source_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `event_name` | Declared directly in the current Lua. Type not inferred. |
| 4 | `target_id` | Declared directly in the current Lua. Type not inferred. |
| 5 | `action` | Declared directly in the current Lua. Type not inferred. |

#### 51. `ezbuttons.add_group_effect(area_id, group_id, event_name, target_id, action)`

- **Line:** 1489
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `group_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `event_name` | Declared directly in the current Lua. Type not inferred. |
| 4 | `target_id` | Declared directly in the current Lua. Type not inferred. |
| 5 | `action` | Declared directly in the current Lua. Type not inferred. |

#### 52. `ezbuttons.refresh_groups(area_id, player_id)`

- **Line:** 1501
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 53. `ezbuttons.get_group_state(area_id, group_id)`

- **Line:** 1511
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `group_id` | Declared directly in the current Lua. Type not inferred. |

#### 54. `property_ids(props, prefix)`

- **Line:** 1519
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `props` | Declared directly in the current Lua. Type not inferred. |
| 2 | `prefix` | Declared directly in the current Lua. Type not inferred. |

#### 55. `configure_group_object(area_id, object)`

- **Line:** 1680
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object` | Declared directly in the current Lua. Type not inferred. |

#### 56. `on_change(changed_area_id, changed_group_id, satisfied, player_id, was_bot)`

- **Line:** 1715
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `changed_area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `changed_group_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `satisfied` | Declared directly in the current Lua. Type not inferred. |
| 4 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 5 | `was_bot` | Declared directly in the current Lua. Type not inferred. |

#### 57. `try_configure_pending_groups(area_id)`

- **Line:** 1758
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |

#### 58. `configure_button_combo_object(area_id, object)`

- **Line:** 1775
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object` | Declared directly in the current Lua. Type not inferred. |

#### 59. `try_configure_pending_combos(area_id)`

- **Line:** 1818
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |

#### 60. `configure_combo_button_group_object(area_id, object)`

- **Line:** 1835
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object` | Declared directly in the current Lua. Type not inferred. |

#### 61. `callback(changed_area_id, changed_group_id, satisfied, player_id, was_bot)`

- **Line:** 1877
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `changed_area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `changed_group_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `satisfied` | Declared directly in the current Lua. Type not inferred. |
| 4 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 5 | `was_bot` | Declared directly in the current Lua. Type not inferred. |

#### 62. `try_configure_pending_combo_groups(area_id)`

- **Line:** 1928
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 68 | `ezbuttons` |
| 73 | `custom_script_cache` |
| 74 | `button_triggers` |
| 114 | `button_placeholders` |
| 115 | `button_bots` |
| 127 | `button_groups` |
| 128 | `button_effects` |
| 129 | `group_effects` |
| 130 | `pending_group_objects` |
| 131 | `group_object_ids` |
| 132 | `pending_group_effect_objects` |
| 133 | `combo_object_definitions` |
| 134 | `pending_combo_objects` |
| 135 | `pending_combo_group_objects` |
| 139 | `logic_queue` |
| 202 | `required` |
| 353 | `logic_queue` |
| 450 | `plates_to_deactivate` |
| 511 | `npc_data` |
| 658 | `from_pos` |
| 659 | `to_pos` |
| 1167 | `info` |
| 1186 | `trigger_players` |
| 1187 | `trigger_bots` |
| 1520 | `numbered` |
| 1530 | `ids` |
| 1859 | `combos` |
| 1865 | `combo` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.create_bot` | 1 | 539 |
| `Net.get_object_by_id` | 5 | 635 |
| `Net.get_player_position` | 1 | 651 |
| `Net.list_players` | 8 | 191 |
| `Net.on` | 3 | 412 |
