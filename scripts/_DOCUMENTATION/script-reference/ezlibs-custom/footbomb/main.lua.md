# `ezlibs-custom/footbomb/main.lua`

> **Source reference**
>
> Generated from `ezlibs-custom/footbomb/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

FootBomb Controller and match-instance entry point. Loaded by scripts/ezlibs-scripts/main.lua through custom.lua.

## Module location

- **Source:** `ezlibs-custom/footbomb/main.lua`
- **Relative reference:** `script-reference/ezlibs-custom/footbomb/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/boom/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/camera/camera-manager` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/displayer/text-layout` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/footbomb/animation_diagnostics` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/footbomb/animation_states` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/footbomb/bomb_options` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/footbomb/constants` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/footbomb/navi_options` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/footbomb/result_timeline` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/footbomb/sfx_driver` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-custom/footbomb/state` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezemitter` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezexplosions` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmapinstance` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/object_registry` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input-controller/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/net-games/ui-safe` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/world-attachment` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `FootBomb.handle_actor_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FootBomb.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FootBomb.handle_player_join` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `FootBomb.handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `add` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `animation_frame_at_elapsed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `as_number` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `as_string` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `assign_bot_role` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await_player_message` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await_player_quiz` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `award_round_point` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `begin_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `begin_next_round` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `begin_role_text_suppression` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `cancel_hold` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `cleanup_empty_instance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `complete_match_and_return` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `confirm_bomb_selection` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `confirm_direction_selection` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `confirm_navi_selection` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `create_match_bots` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `create_ref_npc` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `cycle_bomb_skin` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `cycle_player_skin` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `defender_jump_position_at` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `defender_position_at` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `destroy_role_events` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `destroy_round_events` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `direction_cursor_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_confirm_prompt` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_direction_cursor` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_navi_name` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_npc_direction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_role_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_score_number` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_scoreboard_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `draw_scoreboard_mug` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `emit_async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `end_role_text_suppression` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_area_refs` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_bot_direction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_role_events` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_round_events` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `evaluate_match_point` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `fade_player_in` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `fade_player_to_black` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `fade_player_to_white` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `find_named_spawn_points` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `finish_direction_selection_if_ready` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `focus_player_camera_for_round` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `follow_defender_ball_point` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_animation_movement_end` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_animation_state_duration` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_footbomb_animation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_navi_ball_point_offset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_round_events` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `hide_bomb_selector_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `hide_direction_selector_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `hide_role_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `hide_scoreboard_for_instance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `hide_scoreboard_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `hide_selector_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `hold_pose_for` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `join_waiting_match` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `launch_npc_match` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `launch_player_match` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `log` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `make_instance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `mark_response_actor_done` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `measure_score` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `move_bot_follow_keyframe` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `move_bot_smoothly` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `move_defender_jump_arc` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `move_player_off_map` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `play_sound_for_instance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `player_is_available` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `position_bots_for_round` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `prime_round_bot_animations` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `provide` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `provide_instance_asset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `provide_instance_bot_assets` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `provide_match_assets` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `provide_source_area_assets` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `read_bot_position` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `read_png_dimensions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `refill_npc_direction_bag` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remove_instance_bots` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `remove_representation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `representation_is_current` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_round_winner` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `run` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `run_direction_mapping_test` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `safe_remove_bot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `server_asset_file_exists` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_bot_animation_state` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_defender_animation_for_round` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_kicker_pose_for_round` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_result_animation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setup_player_representation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `setup_representations_for_match` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `show_bomb_selector_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `show_direction_selector_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `show_selector_ui` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `spawn_bomb_bot_for_round` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `start_direction_selection` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `subscribe_bomb_handlers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `subscribe_defender_handlers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `subscribe_kicker_handlers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `transfer_match_players` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `try_begin_match` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `u32` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `update_direction_selector_bob` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `update_scoreboard` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `validate_animation_states` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `world_xy_distance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Uppercase constants

`BOMB_CATCH_CONTACT`, `BOMB_EXPLODING`, `BOMB_LAUNCHED`, `BOMB_TARGET_REACHED`, `DEFENDER_ARC_COMPLETE`, `DEFENDER_HOLD_STARTED`, `DEFENDER_JUMP_LAUNCHED`, `DEFENDER_LANDING_FRAME`, `KICKER_IDLE_STARTED`, `KICKER_STEP_COMPLETE`, `KICKER_STEP_STARTED`, `ROUND_CAMERA_FADED`, `ROUND_CAMERA_FADE_STARTED`, `ROUND_COMPLETE`, `ROUND_HOLD_COMPLETE`, `ROUND_RESPONSE_COMPLETE`

## Source notes

- Approximate source size: 4391 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
