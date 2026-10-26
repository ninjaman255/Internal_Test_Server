# `ezlibs-custom/footbomb/main.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/footbomb/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

FootBomb Controller and match-instance entry point. Loaded by scripts/ezlibs-scripts/main.lua through custom.lua.

## Module location

- **Source:** `ezlibs-custom/footbomb/main.lua`
- **Reference:** `script-reference/ezlibs-custom/footbomb/main.lua.md`
- **Source SHA-256 prefix:** `53f9a718f774`

## Source header notes

- FootBomb Controller and match-instance entry point.
- Loaded by scripts/ezlibs-scripts/main.lua through custom.lua.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/object_registry` |
| `scripts/ezlibs-scripts/ezmapinstance` |
| `scripts/net-games/main` |
| `scripts/net-games/ui-safe` |
| `scripts/ezlibs-scripts/ezexplosions` |
| `scripts/displayer/text-layout` |
| `scripts/input-controller/main` |
| `scripts/boom/main` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/ezemitter` |
| `scripts/ezlibs-custom/footbomb/constants` |
| `scripts/ezlibs-custom/footbomb/animation_states` |
| `scripts/ezlibs-custom/footbomb/navi_options` |
| `scripts/ezlibs-custom/footbomb/bomb_options` |
| `scripts/world-attachment` |
| `scripts/ezlibs-custom/footbomb/result_timeline` |
| `scripts/ezlibs-custom/footbomb/sfx_driver` |
| `scripts/displayer/displayer` |
| `scripts/ezlibs-custom/footbomb/state` |
| `scripts/ezlibs-custom/footbomb/animation_diagnostics` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `log` | `message` |
| `async` | `p` |
| `await` | `v` |
| `get_footbomb_animation` | `path` |
| `ensure_round_events` | `instance_id` |
| `get_round_events` | `instance_id` |
| `destroy_round_events` | `instance_id` |
| `run_direction_mapping_test` | `` |
| `draw_confirm_prompt` | `player_id, text_id` |
| `hide_role_text` | `player_id, rep` |
| `build_role_panel` | `player_id, rep, role` |
| `make_icon_child` | `` |
| `draw_role_text` | `player_id, rep, role` |
| `begin_role_text_suppression` | `player_id` |
| `end_role_text_suppression` | `player_id, rep` |
| `await_player_message` | `player_id, ...` |
| `await_player_quiz` | `player_id, ...` |
| `draw_navi_name` | `player_id, rep, name` |
| `as_string` | `value, fallback` |
| `as_number` | `value, fallback` |
| `ensure_area_refs` | `area_id` |
| `create_ref_npc` | `area_id, object` |
| `player_is_available` | `player_id` |
| `find_named_spawn_points` | `area_id` |
| `safe_remove_bot` | `bot_id` |
| `set_bot_animation_state` | `bot_id, animation_state, should_loop` |
| `ensure_bot_direction` | `bot, direction` |
| `cancel_hold` | `bot, reason` |
| `create_match_bots` | `instance, spawn_points, vs_npc` |
| `provide_match_assets` | `player_id` |
| `provide` | `path` |
| `transfer_match_players` | `instance, player_ids, spawn_points` |
| `remove_instance_bots` | `instance_id` |
| `cleanup_empty_instance` | `instance` |
| `server_asset_file_exists` | `path` |
| `provide_instance_asset` | `area_id, path` |
| `read_png_dimensions` | `path` |
| `u32` | `offset` |
| `validate_animation_states` | `path, required_states, label, texture_path` |
| `provide_instance_bot_assets` | `area_id` |
| `add` | `path` |
| `provide_source_area_assets` | `area_id, reason` |
| `make_instance` | `player_id, source_area_id, object, mode` |
| `move_player_off_map` | `player_id, area_id` |
| `hide_bomb_selector_ui` | `player_id, rep` |
| `direction_cursor_id` | `rep, direction` |
| `draw_direction_cursor` | `player_id, rep, direction, y` |
| `show_direction_selector_ui` | `player_id, rep` |
| `hide_direction_selector_ui` | `player_id, rep` |
| `update_direction_selector_bob` | `player_id, rep` |
| `hide_selector_ui` | `player_id, rep` |
| `show_bomb_selector_ui` | `player_id, rep` |
| `show_selector_ui` | `player_id, rep` |
| `remove_representation` | `player_id` |
| `setup_player_representation` | `player_id, instance, bot_record` |
| `setup_representations_for_match` | `instance, player_ids, bots` |
| `launch_npc_match` | `player_id, source_area_id, object, npc` |
| `launch_player_match` | `waiting, second_player` |
| `cycle_player_skin` | `player_id, direction` |
| `cycle_bomb_skin` | `player_id, direction` |
| `fade_player_to_white` | `player_id` |
| `focus_player_camera_for_round` | `player_id, instance_id` |
| `position_bots_for_round` | `instance_id` |
| `spawn_bomb_bot_for_round` | `instance_id, human_reps` |
| `set_defender_animation_for_round` | `instance_id, animation_state, phase` |
| `set_kicker_pose_for_round` | `instance_id` |
| `apply_round_role_poses` | `instance_id, phase` |
| `reassert_round_start_poses` | `instance_id` |
| `prime_round_bot_animations` | `instance_id` |
| `draw_scoreboard_mug` | `player_id, rep, bot, ui_id, x` |
| `draw_scoreboard_for_player` | `player_id, rep, bots` |
| `measure_score` | `text` |
| `draw_score_number` | `text_id, score_text, x, y, slot` |
| `update_scoreboard` | `instance_id` |
| `hide_scoreboard_for_player` | `player_id, rep` |
| `hide_scoreboard_for_instance` | `instance_id` |
| `play_sound_for_instance` | `instance_id, sound_path, reason` |
| `move_bot_smoothly` | `bot, target, speed, phase, animation_state, duration_override` |
| `set_result_animation` | `bot, animation_state, direction, phase, should_loop` |
| `hold_pose_for` | `bot, state, direction, hold_seconds, phase, should_loop` |
| `award_round_point` | `instance_id, kicker, defender, winner` |
| `evaluate_match_point` | `bots, instance_id` |
| `complete_match_and_return` | `instance_id` |
| `get_animation_state_duration` | `bot, state_name` |
| `get_animation_movement_end` | `bot, state_name` |
| `world_xy_distance` | `a, b` |
| `defender_jump_position_at` | `start_position, target_position, ratio, movement_speed` |
| `move_defender_jump_arc` | `bot, target, duration, phase` |
| `animation_frame_at_elapsed` | `animation, state_name, elapsed` |
| `get_navi_ball_point_offset` | `bot, state_name, elapsed, child_z` |
| `subscribe_kicker_handlers` | `bot, emitter, on` |
| `run` | `` |
| `subscribe_defender_handlers` | `bot, emitter, on` |
| `subscribe_bomb_handlers` | `bot, emitter, on` |
| `on` | `emitter, event, fn` |
| `move_bot_follow_keyframe` | `bot, position, phase, duration` |
| `defender_position_at` | `t` |
| `resolve_round_winner` | `instance_id` |
| `mark_response_actor_done` | `actor, success` |
| `refill_npc_direction_bag` | `bot` |
| `draw_npc_direction` | `bot` |
| `finish_direction_selection_if_ready` | `instance_id` |
| `start_direction_selection` | `instance_id, human_reps` |
| `confirm_direction_selection` | `player_id, rep` |
| `try_begin_match` | `instance_id` |
| `confirm_bomb_selection` | `player_id, rep` |
| `confirm_navi_selection` | `player_id, rep` |
| `representation_is_current` | `` |
| `join_waiting_match` | `player_id, source_area_id, reference` |
| `begin_interaction` | `player_id, area_id, reference` |
| `FootBomb.handle_player_join` | `player_id` |
| `FootBomb.handle_actor_interaction` | `player_id, actor_id, button` |
| `FootBomb.handle_player_transfer` | `player_id` |
| `FootBomb.handle_player_disconnect` | `player_id` |
| `fade_player_to_black` | `player_id` |
| `fade_player_in` | `player_id` |
| `read_bot_position` | `bot` |
| `ensure_role_events` | `instance_id` |
| `destroy_role_events` | `instance_id` |
| `emit_async` | `instance_id, role, event, ...` |
| `assign_bot_role` | `bot, new_role, instance_id` |
| `begin_next_round` | `instance_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`player_draw_sprite`, `create_bot`, `is_player`, `get_player_area`, `list_objects`, `get_object_by_id`, `remove_bot`, `animate_bot`, `set_bot_direction`, `provide_asset_for_player`, `provide_asset`, `move_player`, `transfer_player`, `toggle_player_hud`, `unlock_player_camera`, `track_with_player_camera`, `unlock_player_input`, `lock_player_input`, `get_bot_position`, `move_player_camera`, `play_sound_for_player`, `fade_player_camera`, `move_bot`, `set_bot_avatar`, `animate_bot_properties`, `get_bot_area`, `get_tile_width`, `get_tile_height`, `on`

## Engine `Async` calls

`promisify`, `await`, `message_player`, `quiz_player`, `sleep`, `create_promise`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `NAVI_OPTIONS` | `require("scripts/ezlibs-custom/footbomb/navi_options")` |
| `BOMB_OPTIONS` | `require("scripts/ezlibs-custom/footbomb/bomb_options")` |
| `BOMB_PREVIEW_ANIMATION` | `AnimationStates.BOMB_PREVIEW` |
| `ROUND_EVENT` | `{` |
| `KICKER_STEP_STARTED` | `"kicker_step_started",` |
| `KICKER_STEP_COMPLETE` | `"kicker_step_complete",` |
| `KICKER_IDLE_STARTED` | `"kicker_idle_started",` |
| `DEFENDER_JUMP_LAUNCHED` | `"defender_jump_launched",` |
| `DEFENDER_LANDING_FRAME` | `"defender_landing_frame",` |
| `DEFENDER_ARC_COMPLETE` | `"defender_arc_complete",` |
| `DEFENDER_HOLD_STARTED` | `"defender_hold_started",` |
| `BOMB_LAUNCHED` | `"bomb_launched",` |
| `BOMB_CATCH_CONTACT` | `"bomb_catch_contact",` |
| `BOMB_TARGET_REACHED` | `"bomb_target_reached",` |
| `BOMB_EXPLODING` | `"bomb_exploding",` |
| `ROUND_RESPONSE_COMPLETE` | `"round_response_complete",` |
| `ROUND_HOLD_COMPLETE` | `"round_hold_complete",` |
| `ROUND_CAMERA_FADE_STARTED` | `"round_camera_fade_started",` |
| `ROUND_CAMERA_FADED` | `"round_camera_faded",` |
| `ROUND_COMPLETE` | `"round_complete",` |
| `RESULT_TARGET_BY_DIRECTION` | `{` |
| `DIRECTION_CURSOR_DIRECTIONS` | `{ "Left", "Up", "Right" }` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
