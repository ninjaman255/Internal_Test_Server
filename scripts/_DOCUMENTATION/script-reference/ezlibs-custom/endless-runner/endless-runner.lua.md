# `ezlibs-custom/endless-runner/endless-runner.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/endless-runner/endless-runner.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `ezlibs-custom/endless-runner/endless-runner.lua`
- **Reference:** `script-reference/ezlibs-custom/endless-runner/endless-runner.lua.md`
- **Source SHA-256 prefix:** `9d136be465b9`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezmapinstance` |
| `scripts/ezlibs-scripts/eznpcs/eznpcs` |
| `scripts/ezlibs-scripts/eztriggers/ezbottriggers` |
| `scripts/avatar_registry/main` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |
| `player_disconnect` |
| `battle_exit` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `log_for` | `player_id, message` |
| `clear_log_for` | `player_id` |
| `emit_bus` | `event_name, payload` |
| `ensure_input_locked` | `player_id, runner, reason` |
| `find_object_by_type` | `area_id, type_name` |
| `find_object_by_name` | `area_id, name` |
| `find_object_by_id` | `area_id, object_id` |
| `is_choice_waypoint` | `obj` |
| `resolve_object_ref` | `ref_str, runner` |
| `extract_encounter_list` | `props` |
| `extract_choice_options` | `waypoint, area_id` |
| `seamless_warp` | `player_id, target_area_id, x, y, z` |
| `try_position_only` | `player_id, x, y, z` |
| `exclude_bot_from_other_players` | `bot_id, owner_player_id` |
| `wait_for_spawn` | `area_id, max_ticks` |
| `camera_follow_actor` | `player_id, actor_id` |
| `camera_follow_player` | `player_id` |
| `fade_to_black` | `player_id` |
| `fade_to_clear` | `player_id` |
| `defend_camera_for` | `player_id, runner, ticks` |
| `runner_apply_hp` | `runner, new_hp` |
| `runner_heal` | `runner, amount` |
| `emit_choice_event` | `event_name, runner, extra` |
| `choice_ui_id` | `player_id, kind, index` |
| `measure_text_width` | `text, font, scale` |
| `draw_cursor_at` | `player_id, cursor_id, x, y, scale` |
| `draw_text_centered` | `player_id, text_id, text, y, scale` |
| `cursor_centered_x` | `scale` |
| `render_choice_ui` | `runner` |
| `render_selected_cursor` | `runner` |
| `cleanup_choice_ui` | `runner` |
| `begin_choice` | `runner, waypoint_id` |
| `handle_choice_action` | `runner, action` |
| `resolve_choice` | `runner, index, reason` |
| `get_floor_def` | `runner, index` |
| `current_floor` | `runner` |
| `update_instance_metadata` | `runner` |
| `apply_floor_rewards` | `runner, floor_def` |
| `make_on_path_complete` | `runner, record` |
| `advance_floor` | `player_id, options` |
| `EndlessRunner.start_encounter` | `player_id, encounter_name, trigger_obj` |
| `register_warp_trigger` | `runner, trigger_obj` |
| `register_encounter_trigger` | `runner, trigger_obj, is_ellipse` |
| `unregister_runner_triggers` | `runner` |
| `do_enter` | `player_id, base_area_id, options` |
| `fail` | `msg` |
| `EndlessRunner.enter` | `player_id, base_area_id, options` |
| `EndlessRunner.stop` | `player_id, options` |
| `EndlessRunner.is_active` | `player_id` |
| `EndlessRunner.get` | `player_id` |
| `EndlessRunner.list` | `` |
| `EndlessRunner.get_state` | `player_id` |
| `EndlessRunner.get_hp` | `player_id` |
| `EndlessRunner.set_hp` | `player_id, hp` |
| `EndlessRunner.heal` | `player_id, amount` |
| `EndlessRunner.pause_bot` | `player_id` |
| `EndlessRunner.resume_bot` | `player_id` |
| `EndlessRunner.choose_option` | `player_id, index` |
| `EndlessRunner.cancel_choice` | `player_id` |
| `EndlessRunner.get_choice_state` | `player_id` |
| `pick` | `...` |
| `EndlessRunner.handle_custom_warp` | `event, options` |
| `EndlessRunner.register_custom_warp` | `wire_fn, options` |
| `normalize_watch_targets` | `base_area_ids` |
| `EndlessRunner.watch_areas` | `base_area_ids, options` |
| `EndlessRunner.setup` | `options` |
| `registered` | `id` |
| `EndlessRunner.dump_net_functions` | `filter` |
| `EndlessRunner.diagnose` | `player_id` |
| `get` | `pid` |
| `set` | `pid, hp` |
| `get_max` | `pid` |
| `set_max` | `pid, hp` |
| `claim_choice_input` | `runner` |
| `release_choice_input` | `runner` |
| `EndlessRunner.advance_floor` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`lock_player_input`, `get_player_health`, `set_player_health`, `get_player_max_health`, `set_player_max_health`, `list_objects`, `get_object_by_id`, `get_player_area`, `transfer_player`, `list_areas`, `list_players`, `exclude_actor_for_player`, `track_with_player_camera`, `fade_player_camera`, `is_player_battling`, `on`, `play_sound_for_player`, `move_bot`, `get_player_position`, `unlock_player_input`

## Engine `Async` calls

`sleep`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DEFAULT_BASE_AREA_ID` | `"endless-runner"` |
| `SPAWN_TYPE` | `"Endless Runner Spawn"` |
| `TRIGGER_TYPE` | `"Endless Runner Trigger"` |
| `RECT_ENCOUNTER_TYPE` | `"Runner Rectangle Encounter"` |
| `RADIUS_ENCOUNTER_TYPE` | `"Runner Radius Encounter"` |
| `CHOICE_WAYPOINT_TYPE` | `"Choice Waypoint"   -- legacy type name` |
| `POSITION_APIS` | `{` |
| `CAMERA_REAPPLY_INTERVAL` | `60` |
| `CAMERA_DEFEND_TICKS` | `60` |
| `CHOICE_INPUT_RELOCK_TICKS` | `30` |
| `CHOICE_HARD_TIMEOUT` | `35` |
| `ENCOUNTER_FADE_DURATION` | `0.8` |
| `ENCOUNTER_FADE_WAIT` | `0.85` |
| `CHOICE_UI` | `{` |
| `SCREEN_WIDTH` | `240,` |
| `SCREEN_HEIGHT` | `160,` |
| `PROMPT_Y` | `15,` |
| `OPTION_START_Y` | `55,` |
| `OPTION_SPACING` | `32,` |
| `CURSOR_Y_ABOVE` | `18,` |
| `CURSOR_SCALE` | `1.0,` |
| `TEXT_SCALE` | `2.0,` |
| `PROMPT_TEXT_SCALE` | `2.0,` |
| `CURSOR_STATE` | `"CURSOR_DOWN",` |
| `CURSOR_TEXTURE` | `"/server/assets/net-games/cursors/vibrant_text_cursor.png",` |
| `CURSOR_ANIMATION` | `"/server/assets/net-games/cursors/text_cursor.animation",` |
| `CURSOR_SFX` | `"/server/assets/net-games/sfx/cursor_move.ogg",` |
| `CURSOR_BOB_TICKS` | `2,` |
| `CURSOR_BOB_OFFSET` | `3,` |
| `CURSOR_SPRITE_W` | `16,` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/cursors/vibrant_text_cursor.png` |
| `/server/assets/net-games/cursors/text_cursor.animation` |
| `/server/assets/net-games/sfx/cursor_move.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
