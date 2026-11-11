# 📄 `main.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/footbomb/main.lua`](../../../../ezlibs-custom/footbomb/main.lua)  
> **Source lines:** 4675  
> **SHA-256 (UTF-8):** `42b2c2a056ace085d517533b4e8d55b0c8e8c2675ff07bc1d4e897fb509514ba`  
> **Named/assigned functions detected:** 123  
> **Table initializers detected:** 78

> **Static reference:** Function names, parameter names, dependencies and call counts below were regenerated from the current Lua. Not all locals are part of the public API. See the [shared logger guide](../../../logger/README.md) for logging semantics.

## 🧭 Contents
- [Overview](#overview)
- [Dependencies](#dependencies)
- [Event hooks](#event-hooks)
- [Functions](#functions)
- [Tables](#tables)
- [Net API calls](#net-api-calls)

## Overview

Current source inventory for `scripts/ezlibs-custom/footbomb/main.lua` in the shared-logger migration.

## Dependencies

| Line | `require` module |
|---:|---|
| 1 | `scripts/player-control/main` |
| 5 | `scripts/logger/logger` |
| 6 | `scripts/ezlibs-scripts/object_registry` |
| 7 | `scripts/ezlibs-scripts/ezmapinstance` |
| 8 | `scripts/net-games/main` |
| 9 | `scripts/net-games/ui-safe` |
| 10 | `scripts/ezlibs-scripts/ezexplosions` |
| 11 | `scripts/displayer/text-layout` |
| 12 | `scripts/input-controller/main` |
| 13 | `scripts/boom/main` |
| 14 | `scripts/ezlibs-scripts/ezbus` |
| 15 | `scripts/ezlibs-scripts/ezemitter` |
| 17 | `scripts/ezlibs-custom/footbomb/constants` |
| 18 | `scripts/ezlibs-custom/footbomb/animation_states` |
| 19 | `scripts/ezlibs-custom/footbomb/navi_options` |
| 20 | `scripts/ezlibs-custom/footbomb/bomb_options` |
| 21 | `scripts/world-attachment` |
| 22 | `scripts/ezlibs-custom/footbomb/result_timeline` |
| 23 | `scripts/ezlibs-custom/footbomb/sfx_driver` |
| 24 | `scripts/displayer/displayer` |
| 27 | `scripts/ezlibs-custom/footbomb/state` |
| 193 | `scripts/ezlibs-custom/footbomb/animation_diagnostics` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 166 | `EzMapInstance.events` | `created` |
| 170 | `EzMapInstance.events` | `removed` |
| 174 | `EzMapInstance.events` | `player_joined` |
| 179 | `EzMapInstance.events` | `player_left` |
| 184 | `EzMapInstance.events` | `host_changed` |
| 803 | `EzMapInstance.events` | `player_left` |
| 3544 | `response_events` | `actor_done` |
| 4577 | `Net` | `tick` |

## Functions

| Source line | Function | Parameters | Declaration |
|---:|---|---|---|
| 60 | `log` | `message` | local |
| 65 | `async` | `p` | local |
| 69 | `await` | `v` | local |
| 77 | `get_footbomb_animation` | `path` | local |
| 130 | `ensure_round_events` | `instance_id` | local |
| 140 | `get_round_events` | `instance_id` | local |
| 145 | `destroy_round_events` | `instance_id` | local |
| 207 | `run_direction_mapping_test` | `(none)` | local |
| 239 | `draw_confirm_prompt` | `player_id, text_id` | local |
| 254 | `hide_role_text` | `player_id, rep` | local |
| 269 | `build_role_panel` | `player_id, rep, role` | local |
| 289 | `make_icon_child` | `(none)` | local |
| 354 | `draw_role_text` | `player_id, rep, role` | local |
| 406 | `begin_role_text_suppression` | `player_id` | local |
| 421 | `end_role_text_suppression` | `player_id, rep` | local |
| 436 | `await_player_message` | `player_id, ...` | local |
| 443 | `await_player_quiz` | `player_id, ...` | local |
| 450 | `draw_navi_name` | `player_id, rep, name` | local |
| 461 | `as_string` | `value, fallback` | local |
| 466 | `as_number` | `value, fallback` | local |
| 472 | `ensure_area_refs` | `area_id` | local |
| 477 | `create_ref_npc` | `area_id, object` | local |
| 527 | `player_is_available` | `player_id` | local |
| 540 | `find_named_spawn_points` | `area_id` | local |
| 597 | `safe_remove_bot` | `bot_id` | local |
| 601 | `set_bot_animation_state` | `bot_id, animation_state, should_loop` | local |
| 612 | `ensure_bot_direction` | `bot, direction` | local |
| 628 | `cancel_hold` | `bot, reason` | local |
| 637 | `create_match_bots` | `instance, spawn_points, vs_npc` | local |
| 692 | `provide_match_assets` | `player_id` | local |
| 695 | `provide` | `path` | local |
| 734 | `transfer_match_players` | `instance, player_ids, spawn_points` | local |
| 767 | `remove_instance_bots` | `instance_id` | local |
| 785 | `cleanup_empty_instance` | `instance` | local |
| 813 | `server_asset_file_exists` | `path` | local |
| 825 | `provide_instance_asset` | `area_id, path` | local |
| 852 | `read_png_dimensions` | `path` | local |
| 866 | `u32` | `offset` | local |
| 878 | `validate_animation_states` | `path, required_states, label, texture_path` | local |
| 965 | `provide_instance_bot_assets` | `area_id` | local |
| 967 | `add` | `path` | local |
| 1034 | `provide_source_area_assets` | `area_id, reason` | local |
| 1070 | `make_instance` | `player_id, source_area_id, object, mode` | local |
| 1139 | `move_player_off_map` | `player_id, area_id` | local |
| 1162 | `hide_bomb_selector_ui` | `player_id, rep` | local |
| 1175 | `direction_cursor_id` | `rep, direction` | local |
| 1182 | `draw_direction_cursor` | `player_id, rep, direction, y` | local |
| 1209 | `show_direction_selector_ui` | `player_id, rep` | local |
| 1219 | `hide_direction_selector_ui` | `player_id, rep` | local |
| 1231 | `update_direction_selector_bob` | `player_id, rep` | local |
| 1247 | `hide_selector_ui` | `player_id, rep` | local |
| 1261 | `show_bomb_selector_ui` | `player_id, rep` | local |
| 1298 | `show_selector_ui` | `player_id, rep` | local |
| 1329 | `remove_representation` | `player_id` | local |
| 1353 | `setup_player_representation` | `player_id, instance, bot_record` | local |
| 1492 | `setup_representations_for_match` | `instance, player_ids, bots` | local |
| 1502 | `launch_npc_match` | `player_id, source_area_id, object, npc` | local |
| 1533 | `launch_player_match` | `waiting, second_player` | local |
| 1569 | `cycle_player_skin` | `player_id, direction` | local |
| 1659 | `cycle_bomb_skin` | `player_id, direction` | local |
| 1673 | `fade_player_to_black` | `player_id` | assigned/declared |
| 1686 | `fade_player_to_white` | `player_id` | local |
| 1699 | `fade_player_in` | `player_id` | assigned/declared |
| 1712 | `focus_player_camera_for_round` | `player_id, instance_id` | local |
| 1738 | `position_bots_for_round` | `instance_id` | local |
| 1772 | `spawn_bomb_bot_for_round` | `instance_id, human_reps` | local |
| 1878 | `set_defender_animation_for_round` | `instance_id, animation_state, phase` | local |
| 1917 | `set_kicker_pose_for_round` | `instance_id` | local |
| 1948 | `apply_round_role_poses` | `instance_id, phase` | local |
| 1970 | `reassert_round_start_poses` | `instance_id` | local |
| 2004 | `prime_round_bot_animations` | `instance_id` | local |
| 2061 | `draw_scoreboard_mug` | `player_id, rep, bot, ui_id, x` | local |
| 2082 | `draw_scoreboard_for_player` | `player_id, rep, bots` | local |
| 2111 | `measure_score` | `text` | local |
| 2136 | `draw_score_number` | `text_id, score_text, x, y, slot` | local |
| 2164 | `update_scoreboard` | `instance_id` | local |
| 2174 | `hide_scoreboard_for_player` | `player_id, rep` | local |
| 2183 | `hide_scoreboard_for_instance` | `instance_id` | local |
| 2191 | `play_sound_for_instance` | `instance_id, sound_path, reason` | local |
| 2217 | `move_bot_smoothly` | `bot, target, speed, phase, animation_state, duration_override` | local |
| 2316 | `set_result_animation` | `bot, animation_state, direction, phase, should_loop` | local |
| 2330 | `hold_pose_for` | `bot, state, direction, hold_seconds, phase, should_loop` | local |
| 2386 | `award_round_point` | `instance_id, kicker, defender, winner` | local |
| 2405 | `evaluate_match_point` | `bots, instance_id` | local |
| 2472 | `complete_match_and_return` | `instance_id` | local |
| 2545 | `get_animation_state_duration` | `bot, state_name` | local |
| 2563 | `get_animation_movement_end` | `bot, state_name` | local |
| 2584 | `world_xy_distance` | `a, b` | local |
| 2593 | `defender_jump_position_at` | `start_position, target_position, ratio, movement_speed` | local |
| 2625 | `move_defender_jump_arc` | `bot, target, duration, phase` | local |
| 2695 | `animation_frame_at_elapsed` | `animation, state_name, elapsed` | local |
| 2716 | `get_navi_ball_point_offset` | `bot, state_name, elapsed, child_z` | local |
| 2775 | `read_bot_position` | `bot` | assigned/declared |
| 2801 | `ensure_role_events` | `instance_id` | assigned/declared |
| 2815 | `destroy_role_events` | `instance_id` | assigned/declared |
| 2825 | `emit_async` | `instance_id, role, event, ...` | assigned/declared |
| 2853 | `subscribe_kicker_handlers` | `bot, emitter, on` | local |
| 2866 | `run` | `(none)` | local |
| 2916 | `subscribe_defender_handlers` | `bot, emitter, on` | local |
| 2933 | `run` | `(none)` | local |
| 3057 | `subscribe_bomb_handlers` | `bot, emitter, on` | local |
| 3068 | `assign_bot_role` | `bot, new_role, instance_id` | assigned/declared |
| 3079 | `on` | `emitter, event, fn` | local |
| 3102 | `move_bot_follow_keyframe` | `bot, position, phase, duration` | local |
| 3173 | `defender_position_at` | `t` | local |
| 3269 | `resolve_round_winner` | `instance_id` | local |
| 3562 | `mark_response_actor_done` | `actor, success` | local |
| 3884 | `refill_npc_direction_bag` | `bot` | local |
| 3899 | `draw_npc_direction` | `bot` | local |
| 3907 | `finish_direction_selection_if_ready` | `instance_id` | local |
| 3954 | `start_direction_selection` | `instance_id, human_reps` | local |
| 3997 | `begin_next_round` | `instance_id` | assigned/declared |
| 4089 | `confirm_direction_selection` | `player_id, rep` | local |
| 4192 | `try_begin_match` | `instance_id` | local |
| 4302 | `confirm_bomb_selection` | `player_id, rep` | local |
| 4323 | `confirm_navi_selection` | `player_id, rep` | local |
| 4338 | `representation_is_current` | `(none)` | local |
| 4382 | `join_waiting_match` | `player_id, source_area_id, reference` | local |
| 4436 | `begin_interaction` | `player_id, area_id, reference` | local |
| 4504 | `FootBomb.handle_player_join` | `player_id` | assigned/declared |
| 4514 | `FootBomb.handle_actor_interaction` | `player_id, actor_id, button` | assigned/declared |
| 4526 | `FootBomb.handle_player_transfer` | `player_id` | assigned/declared |
| 4555 | `FootBomb.handle_player_disconnect` | `player_id` | assigned/declared |

### Detailed parameter inventory

#### 1. `log(message)`

- **Line:** 60
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `message` | Declared in this function; type not inferred. |

#### 2. `async(p)`

- **Line:** 65
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `p` | Declared in this function; type not inferred. |

#### 3. `await(v)`

- **Line:** 69
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `v` | Declared in this function; type not inferred. |

#### 4. `get_footbomb_animation(path)`

- **Line:** 77
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |

#### 5. `ensure_round_events(instance_id)`

- **Line:** 130
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 6. `get_round_events(instance_id)`

- **Line:** 140
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 7. `destroy_round_events(instance_id)`

- **Line:** 145
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 8. `run_direction_mapping_test()`

- **Line:** 207
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 9. `draw_confirm_prompt(player_id, text_id)`

- **Line:** 239
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `text_id` | Declared in this function; type not inferred. |

#### 10. `hide_role_text(player_id, rep)`

- **Line:** 254
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |

#### 11. `build_role_panel(player_id, rep, role)`

- **Line:** 269
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |
| 3 | `role` | Declared in this function; type not inferred. |

#### 12. `make_icon_child()`

- **Line:** 289
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 13. `draw_role_text(player_id, rep, role)`

- **Line:** 354
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |
| 3 | `role` | Declared in this function; type not inferred. |

#### 14. `begin_role_text_suppression(player_id)`

- **Line:** 406
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 15. `end_role_text_suppression(player_id, rep)`

- **Line:** 421
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |

#### 16. `await_player_message(player_id, ...)`

- **Line:** 436
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `...` | Declared in this function; type not inferred. |

#### 17. `await_player_quiz(player_id, ...)`

- **Line:** 443
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `...` | Declared in this function; type not inferred. |

#### 18. `draw_navi_name(player_id, rep, name)`

- **Line:** 450
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |
| 3 | `name` | Declared in this function; type not inferred. |

#### 19. `as_string(value, fallback)`

- **Line:** 461
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |
| 2 | `fallback` | Declared in this function; type not inferred. |

#### 20. `as_number(value, fallback)`

- **Line:** 466
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `value` | Declared in this function; type not inferred. |
| 2 | `fallback` | Declared in this function; type not inferred. |

#### 21. `ensure_area_refs(area_id)`

- **Line:** 472
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 22. `create_ref_npc(area_id, object)`

- **Line:** 477
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `object` | Declared in this function; type not inferred. |

#### 23. `player_is_available(player_id)`

- **Line:** 527
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 24. `find_named_spawn_points(area_id)`

- **Line:** 540
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 25. `safe_remove_bot(bot_id)`

- **Line:** 597
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |

#### 26. `set_bot_animation_state(bot_id, animation_state, should_loop)`

- **Line:** 601
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared in this function; type not inferred. |
| 2 | `animation_state` | Declared in this function; type not inferred. |
| 3 | `should_loop` | Declared in this function; type not inferred. |

#### 27. `ensure_bot_direction(bot, direction)`

- **Line:** 612
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `direction` | Declared in this function; type not inferred. |

#### 28. `cancel_hold(bot, reason)`

- **Line:** 628
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `reason` | Declared in this function; type not inferred. |

#### 29. `create_match_bots(instance, spawn_points, vs_npc)`

- **Line:** 637
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `spawn_points` | Declared in this function; type not inferred. |
| 3 | `vs_npc` | Declared in this function; type not inferred. |

#### 30. `provide_match_assets(player_id)`

- **Line:** 692
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 31. `provide(path)`

- **Line:** 695
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |

#### 32. `transfer_match_players(instance, player_ids, spawn_points)`

- **Line:** 734
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `player_ids` | Declared in this function; type not inferred. |
| 3 | `spawn_points` | Declared in this function; type not inferred. |

#### 33. `remove_instance_bots(instance_id)`

- **Line:** 767
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 34. `cleanup_empty_instance(instance)`

- **Line:** 785
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |

#### 35. `server_asset_file_exists(path)`

- **Line:** 813
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |

#### 36. `provide_instance_asset(area_id, path)`

- **Line:** 825
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `path` | Declared in this function; type not inferred. |

#### 37. `read_png_dimensions(path)`

- **Line:** 852
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |

#### 38. `u32(offset)`

- **Line:** 866
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `offset` | Declared in this function; type not inferred. |

#### 39. `validate_animation_states(path, required_states, label, texture_path)`

- **Line:** 878
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |
| 2 | `required_states` | Declared in this function; type not inferred. |
| 3 | `label` | Declared in this function; type not inferred. |
| 4 | `texture_path` | Declared in this function; type not inferred. |

#### 40. `provide_instance_bot_assets(area_id)`

- **Line:** 965
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |

#### 41. `add(path)`

- **Line:** 967
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `path` | Declared in this function; type not inferred. |

#### 42. `provide_source_area_assets(area_id, reason)`

- **Line:** 1034
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared in this function; type not inferred. |
| 2 | `reason` | Declared in this function; type not inferred. |

#### 43. `make_instance(player_id, source_area_id, object, mode)`

- **Line:** 1070
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `source_area_id` | Declared in this function; type not inferred. |
| 3 | `object` | Declared in this function; type not inferred. |
| 4 | `mode` | Declared in this function; type not inferred. |

#### 44. `move_player_off_map(player_id, area_id)`

- **Line:** 1139
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |

#### 45. `hide_bomb_selector_ui(player_id, rep)`

- **Line:** 1162
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |

#### 46. `direction_cursor_id(rep, direction)`

- **Line:** 1175
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `rep` | Declared in this function; type not inferred. |
| 2 | `direction` | Declared in this function; type not inferred. |

#### 47. `draw_direction_cursor(player_id, rep, direction, y)`

- **Line:** 1182
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |
| 3 | `direction` | Declared in this function; type not inferred. |
| 4 | `y` | Declared in this function; type not inferred. |

#### 48. `show_direction_selector_ui(player_id, rep)`

- **Line:** 1209
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |

#### 49. `hide_direction_selector_ui(player_id, rep)`

- **Line:** 1219
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |

#### 50. `update_direction_selector_bob(player_id, rep)`

- **Line:** 1231
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |

#### 51. `hide_selector_ui(player_id, rep)`

- **Line:** 1247
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |

#### 52. `show_bomb_selector_ui(player_id, rep)`

- **Line:** 1261
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |

#### 53. `show_selector_ui(player_id, rep)`

- **Line:** 1298
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |

#### 54. `remove_representation(player_id)`

- **Line:** 1329
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 55. `setup_player_representation(player_id, instance, bot_record)`

- **Line:** 1353
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `instance` | Declared in this function; type not inferred. |
| 3 | `bot_record` | Declared in this function; type not inferred. |

#### 56. `setup_representations_for_match(instance, player_ids, bots)`

- **Line:** 1492
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance` | Declared in this function; type not inferred. |
| 2 | `player_ids` | Declared in this function; type not inferred. |
| 3 | `bots` | Declared in this function; type not inferred. |

#### 57. `launch_npc_match(player_id, source_area_id, object, npc)`

- **Line:** 1502
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `source_area_id` | Declared in this function; type not inferred. |
| 3 | `object` | Declared in this function; type not inferred. |
| 4 | `npc` | Declared in this function; type not inferred. |

#### 58. `launch_player_match(waiting, second_player)`

- **Line:** 1533
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `waiting` | Declared in this function; type not inferred. |
| 2 | `second_player` | Declared in this function; type not inferred. |

#### 59. `cycle_player_skin(player_id, direction)`

- **Line:** 1569
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `direction` | Declared in this function; type not inferred. |

#### 60. `cycle_bomb_skin(player_id, direction)`

- **Line:** 1659
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `direction` | Declared in this function; type not inferred. |

#### 61. `fade_player_to_black(player_id)`

- **Line:** 1673
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 62. `fade_player_to_white(player_id)`

- **Line:** 1686
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 63. `fade_player_in(player_id)`

- **Line:** 1699
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 64. `focus_player_camera_for_round(player_id, instance_id)`

- **Line:** 1712
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `instance_id` | Declared in this function; type not inferred. |

#### 65. `position_bots_for_round(instance_id)`

- **Line:** 1738
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 66. `spawn_bomb_bot_for_round(instance_id, human_reps)`

- **Line:** 1772
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |
| 2 | `human_reps` | Declared in this function; type not inferred. |

#### 67. `set_defender_animation_for_round(instance_id, animation_state, phase)`

- **Line:** 1878
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |
| 2 | `animation_state` | Declared in this function; type not inferred. |
| 3 | `phase` | Declared in this function; type not inferred. |

#### 68. `set_kicker_pose_for_round(instance_id)`

- **Line:** 1917
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 69. `apply_round_role_poses(instance_id, phase)`

- **Line:** 1948
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |
| 2 | `phase` | Declared in this function; type not inferred. |

#### 70. `reassert_round_start_poses(instance_id)`

- **Line:** 1970
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 71. `prime_round_bot_animations(instance_id)`

- **Line:** 2004
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 72. `draw_scoreboard_mug(player_id, rep, bot, ui_id, x)`

- **Line:** 2061
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |
| 3 | `bot` | Declared in this function; type not inferred. |
| 4 | `ui_id` | Declared in this function; type not inferred. |
| 5 | `x` | Declared in this function; type not inferred. |

#### 73. `draw_scoreboard_for_player(player_id, rep, bots)`

- **Line:** 2082
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |
| 3 | `bots` | Declared in this function; type not inferred. |

#### 74. `measure_score(text)`

- **Line:** 2111
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `text` | Declared in this function; type not inferred. |

#### 75. `draw_score_number(text_id, score_text, x, y, slot)`

- **Line:** 2136
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `text_id` | Declared in this function; type not inferred. |
| 2 | `score_text` | Declared in this function; type not inferred. |
| 3 | `x` | Declared in this function; type not inferred. |
| 4 | `y` | Declared in this function; type not inferred. |
| 5 | `slot` | Declared in this function; type not inferred. |

#### 76. `update_scoreboard(instance_id)`

- **Line:** 2164
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 77. `hide_scoreboard_for_player(player_id, rep)`

- **Line:** 2174
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |

#### 78. `hide_scoreboard_for_instance(instance_id)`

- **Line:** 2183
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 79. `play_sound_for_instance(instance_id, sound_path, reason)`

- **Line:** 2191
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |
| 2 | `sound_path` | Declared in this function; type not inferred. |
| 3 | `reason` | Declared in this function; type not inferred. |

#### 80. `move_bot_smoothly(bot, target, speed, phase, animation_state, duration_override)`

- **Line:** 2217
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `target` | Declared in this function; type not inferred. |
| 3 | `speed` | Declared in this function; type not inferred. |
| 4 | `phase` | Declared in this function; type not inferred. |
| 5 | `animation_state` | Declared in this function; type not inferred. |
| 6 | `duration_override` | Declared in this function; type not inferred. |

#### 81. `set_result_animation(bot, animation_state, direction, phase, should_loop)`

- **Line:** 2316
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `animation_state` | Declared in this function; type not inferred. |
| 3 | `direction` | Declared in this function; type not inferred. |
| 4 | `phase` | Declared in this function; type not inferred. |
| 5 | `should_loop` | Declared in this function; type not inferred. |

#### 82. `hold_pose_for(bot, state, direction, hold_seconds, phase, should_loop)`

- **Line:** 2330
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `state` | Declared in this function; type not inferred. |
| 3 | `direction` | Declared in this function; type not inferred. |
| 4 | `hold_seconds` | Declared in this function; type not inferred. |
| 5 | `phase` | Declared in this function; type not inferred. |
| 6 | `should_loop` | Declared in this function; type not inferred. |

#### 83. `award_round_point(instance_id, kicker, defender, winner)`

- **Line:** 2386
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |
| 2 | `kicker` | Declared in this function; type not inferred. |
| 3 | `defender` | Declared in this function; type not inferred. |
| 4 | `winner` | Declared in this function; type not inferred. |

#### 84. `evaluate_match_point(bots, instance_id)`

- **Line:** 2405
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bots` | Declared in this function; type not inferred. |
| 2 | `instance_id` | Declared in this function; type not inferred. |

#### 85. `complete_match_and_return(instance_id)`

- **Line:** 2472
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 86. `get_animation_state_duration(bot, state_name)`

- **Line:** 2545
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `state_name` | Declared in this function; type not inferred. |

#### 87. `get_animation_movement_end(bot, state_name)`

- **Line:** 2563
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `state_name` | Declared in this function; type not inferred. |

#### 88. `world_xy_distance(a, b)`

- **Line:** 2584
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `a` | Declared in this function; type not inferred. |
| 2 | `b` | Declared in this function; type not inferred. |

#### 89. `defender_jump_position_at(start_position, target_position, ratio, movement_speed)`

- **Line:** 2593
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `start_position` | Declared in this function; type not inferred. |
| 2 | `target_position` | Declared in this function; type not inferred. |
| 3 | `ratio` | Declared in this function; type not inferred. |
| 4 | `movement_speed` | Declared in this function; type not inferred. |

#### 90. `move_defender_jump_arc(bot, target, duration, phase)`

- **Line:** 2625
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `target` | Declared in this function; type not inferred. |
| 3 | `duration` | Declared in this function; type not inferred. |
| 4 | `phase` | Declared in this function; type not inferred. |

#### 91. `animation_frame_at_elapsed(animation, state_name, elapsed)`

- **Line:** 2695
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `animation` | Declared in this function; type not inferred. |
| 2 | `state_name` | Declared in this function; type not inferred. |
| 3 | `elapsed` | Declared in this function; type not inferred. |

#### 92. `get_navi_ball_point_offset(bot, state_name, elapsed, child_z)`

- **Line:** 2716
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `state_name` | Declared in this function; type not inferred. |
| 3 | `elapsed` | Declared in this function; type not inferred. |
| 4 | `child_z` | Declared in this function; type not inferred. |

#### 93. `read_bot_position(bot)`

- **Line:** 2775
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |

#### 94. `ensure_role_events(instance_id)`

- **Line:** 2801
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 95. `destroy_role_events(instance_id)`

- **Line:** 2815
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 96. `emit_async(instance_id, role, event, ...)`

- **Line:** 2825
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |
| 2 | `role` | Declared in this function; type not inferred. |
| 3 | `event` | Declared in this function; type not inferred. |
| 4 | `...` | Declared in this function; type not inferred. |

#### 97. `subscribe_kicker_handlers(bot, emitter, on)`

- **Line:** 2853
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `emitter` | Declared in this function; type not inferred. |
| 3 | `on` | Declared in this function; type not inferred. |

#### 98. `run()`

- **Line:** 2866
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 99. `subscribe_defender_handlers(bot, emitter, on)`

- **Line:** 2916
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `emitter` | Declared in this function; type not inferred. |
| 3 | `on` | Declared in this function; type not inferred. |

#### 100. `run()`

- **Line:** 2933
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 101. `subscribe_bomb_handlers(bot, emitter, on)`

- **Line:** 3057
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `emitter` | Declared in this function; type not inferred. |
| 3 | `on` | Declared in this function; type not inferred. |

#### 102. `assign_bot_role(bot, new_role, instance_id)`

- **Line:** 3068
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `new_role` | Declared in this function; type not inferred. |
| 3 | `instance_id` | Declared in this function; type not inferred. |

#### 103. `on(emitter, event, fn)`

- **Line:** 3079
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `emitter` | Declared in this function; type not inferred. |
| 2 | `event` | Declared in this function; type not inferred. |
| 3 | `fn` | Declared in this function; type not inferred. |

#### 104. `move_bot_follow_keyframe(bot, position, phase, duration)`

- **Line:** 3102
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |
| 2 | `position` | Declared in this function; type not inferred. |
| 3 | `phase` | Declared in this function; type not inferred. |
| 4 | `duration` | Declared in this function; type not inferred. |

#### 105. `defender_position_at(t)`

- **Line:** 3173
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `t` | Declared in this function; type not inferred. |

#### 106. `resolve_round_winner(instance_id)`

- **Line:** 3269
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 107. `mark_response_actor_done(actor, success)`

- **Line:** 3562
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `actor` | Declared in this function; type not inferred. |
| 2 | `success` | Declared in this function; type not inferred. |

#### 108. `refill_npc_direction_bag(bot)`

- **Line:** 3884
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |

#### 109. `draw_npc_direction(bot)`

- **Line:** 3899
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot` | Declared in this function; type not inferred. |

#### 110. `finish_direction_selection_if_ready(instance_id)`

- **Line:** 3907
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 111. `start_direction_selection(instance_id, human_reps)`

- **Line:** 3954
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |
| 2 | `human_reps` | Declared in this function; type not inferred. |

#### 112. `begin_next_round(instance_id)`

- **Line:** 3997
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 113. `confirm_direction_selection(player_id, rep)`

- **Line:** 4089
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |

#### 114. `try_begin_match(instance_id)`

- **Line:** 4192
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `instance_id` | Declared in this function; type not inferred. |

#### 115. `confirm_bomb_selection(player_id, rep)`

- **Line:** 4302
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |

#### 116. `confirm_navi_selection(player_id, rep)`

- **Line:** 4323
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `rep` | Declared in this function; type not inferred. |

#### 117. `representation_is_current()`

- **Line:** 4338
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 118. `join_waiting_match(player_id, source_area_id, reference)`

- **Line:** 4382
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `source_area_id` | Declared in this function; type not inferred. |
| 3 | `reference` | Declared in this function; type not inferred. |

#### 119. `begin_interaction(player_id, area_id, reference)`

- **Line:** 4436
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `area_id` | Declared in this function; type not inferred. |
| 3 | `reference` | Declared in this function; type not inferred. |

#### 120. `FootBomb.handle_player_join(player_id)`

- **Line:** 4504
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 121. `FootBomb.handle_actor_interaction(player_id, actor_id, button)`

- **Line:** 4514
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |
| 2 | `actor_id` | Declared in this function; type not inferred. |
| 3 | `button` | Declared in this function; type not inferred. |

#### 122. `FootBomb.handle_player_transfer(player_id)`

- **Line:** 4526
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |

#### 123. `FootBomb.handle_player_disconnect(player_id)`

- **Line:** 4555
- **Declaration:** table/global or assignment

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared in this function; type not inferred. |


## Tables

| Source line | Assignment |
|---:|---|
| 26 | `FootBomb` |
| 47 | `role_panel_styles` |
| 76 | `footbomb_animation_cache` |
| 108 | `ROUND_EVENT` |
| 201 | `RESULT_TARGET_BY_DIRECTION` |
| 208 | `directions` |
| 300 | `children` |
| 305 | `color` |
| 508 | `reference` |
| 510 | `npc` |
| 549 | `found` |
| 550 | `required_names` |
| 569 | `missing` |
| 640 | `actor_ids` |
| 641 | `labels` |
| 645 | `created` |
| 677 | `position` |
| 735 | `transferred` |
| 856 | `candidates` |
| 974 | `required_navi_states` |
| 987 | `required_bomb_states` |
| 1032 | `source_area_assets_ready` |
| 1048 | `ui_paths` |
| 1084 | `player_ids` |
| 1086 | `metadata` |
| 1090 | `party` |
| 1123 | `bots.return_position` |
| 1124 | `bots.return_npc_position` |
| 1173 | `DIRECTION_CURSOR_DIRECTIONS` |
| 1188 | `red` |
| 1189 | `blue` |
| 1367 | `rep` |
| 1471 | `position` |
| 1545 | `instance.metadata.party.members` |
| 1765 | `bot.position` |
| 1848 | `bots.bomb_bot` |
| 1859 | `position` |
| 2012 | `required_states` |
| 2110 | `score_text_options` |
| 2238 | `start` |
| 2257 | `keyframes` |
| 2259 | `properties` |
| 2267 | `properties` |
| 2309 | `bot.position` |
| 2343 | `token` |
| 2478 | `players` |
| 2505 | `connected_players` |
| 2641 | `start_position` |
| 2642 | `target_position` |
| 2648 | `keyframes` |
| 2650 | `properties` |
| 2664 | `properties` |
| 2757 | `z_correction` |
| 2804 | `events` |
| 2835 | `varargs` |
| 2840 | `type_list` |
| 3074 | `bot._role_subscriptions` |
| 3117 | `keyframes` |
| 3119 | `properties` |
| 3127 | `properties` |
| 3142 | `bot.position` |
| 3182 | `times` |
| 3192 | `keyframes` |
| 3194 | `properties` |
| 3243 | `properties` |
| 3441 | `target_position` |
| 3446 | `start_position` |
| 3541 | `response_actor_seen` |
| 3542 | `response_results` |
| 3572 | `start_position` |
| 3577 | `target_position` |
| 3735 | `defender.position` |
| 3813 | `humans` |
| 3885 | `bag` |
| 3910 | `humans` |
| 3911 | `human_slots` |
| 4004 | `humans` |
| 4195 | `human_reps` |

## Net API calls

| API | Occurrences | First line |
|---|---:|---:|
| `Net.create_bot` | 1 | 491 |
| `Net.get_player_area` | 13 | 1265 |
| `Net.on` | 1 | 4577 |
