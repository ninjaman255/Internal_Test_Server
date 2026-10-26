# `ezlibs-scripts/eznpcs/eznpcs.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/eznpcs/eznpcs.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Eznpcs source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/eznpcs/eznpcs.lua`
- **Reference:** `script-reference/ezlibs-scripts/eznpcs/eznpcs.lua.md`
- **Source SHA-256 prefix:** `e5a5ccc4aa46`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/direction` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/ezcache` |
| `scripts/ezlibs-scripts/object_registry` |
| `math` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/ezquests` |
| `scripts/ezlibs-scripts/utils/eztiledutils` |
| `scripts/ezlibs-scripts/eznpcs/dialogue_types` |
| `scripts/ezlibs-scripts/ezcutscenes/ezcutscenes` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `set_npc_animation` | `npc, animation, loop, source` |
| `printd` | `...` |
| `validate_npc_object` | `area_id, object` |
| `get_all_players` | `` |
| `exclude_except_for` | `owner_id, bot_id` |
| `include_for_all` | `bot_id` |
| `emit_bot_created` | `bot_id, area_id, extra` |
| `emit_bot_removed` | `bot_id` |
| `emit_bot_moved` | `bot_id, area_id, x, y, z` |
| `eznpcs.get_dialogue_mugshot` | `npc,player_id,dialogue` |
| `do_dialogue` | `npc,player_id,dialogue,relay_object` |
| `create_bot_from_object` | `area_id, object, player_id, options` |
| `create_npc` | `area_id,asset_name,x,y,z,direction,bot_name,animation_name,mug_animation_name,npc_turns_to_talk` |
| `add_behaviour` | `npc,behaviour` |
| `clear_player_conversation` | `player_id` |
| `chat_behaviour` | `` |
| `waypoint_follow_behaviour` | `first_waypoint_id, options` |
| `do_actor_interaction` | `player_id,actor_id,relay_object` |
| `is_anyone_talking_to_npc` | `npc_id` |
| `start_scripted_waypoint_move` | `npc, waypoint, move_anim, move_loop, move_duration` |
| `move_npc` | `npc,delta_time` |
| `on_npc_reached_waypoint` | `npc,waypoint` |
| `count_and_prune_live_bots` | `spawner` |
| `warp_out_spawner_npc` | `spawner, npc` |
| `make_spawner_path_complete_cb` | `spawner` |
| `spawn_from_spawner` | `spawner` |
| `register_npc_spawner` | `area_id, object` |
| `update_spawner_triggers` | `delta_time` |
| `update_quest_exclusive_for_player` | `player_id` |
| `register_npc_object` | `area_id, object` |
| `eznpcs.get_bot_for_placeholder` | `area_id, object_id` |
| `eznpcs.load_npcs` | `` |
| `eznpcs.add_npcs_to_area` | `area_id` |
| `eznpcs.add_event` | `event_object` |
| `eznpcs.create_npc_from_object` | `area_id,object_id` |
| `eznpcs.handle_actor_interaction` | `player_id,actor_id` |
| `eznpcs.on_tick` | `delta_time` |
| `eznpcs.create_npc` | `area_id,asset_name,x,y,z,direction,bot_name,animation_name,mug_animation_name,dont_face_player` |
| `eznpcs.handle_player_transfer` | `player_id` |
| `eznpcs.handle_player_join` | `player_id` |
| `eznpcs.handle_player_disconnect` | `player_id` |
| `eznpcs.handle_object_interaction` | `player_id, object_id` |
| `eznpcs.remove_exclusive_npc` | `player_id, placeholder_id` |
| `eznpcs.prepare_battle_exit_wait` | `player_id` |
| `eznpcs.cancel_battle_exit_wait` | `player_id` |
| `eznpcs.handle_battle_exit` | `player_id, battle_results, exit_event` |
| `eznpcs.wait_for_battle_exit` | `player_id` |
| `eznpcs.handle_battle_results` | `player_id, stats` |
| `eznpcs.remove_quest_exclusive_npc` | `player_id, placeholder_id` |
| `eznpcs.get_bot_id_for_placeholder` | `area_id, placeholder_id` |
| `_resolve_bot_id` | `bot_or_npc` |
| `_apply_bot_animation` | `bot_id, state, loop` |
| `_apply_bot_direction` | `bot_id, direction` |
| `_bump_hold_generation` | `bot_id` |
| `_claim_pose` | `bot_id` |
| `_release_pose` | `bot_id` |
| `eznpcs.get_bot_record` | `bot_id` |
| `eznpcs.resolve_bot` | `area_id, object_id, player_id` |
| `eznpcs.cancel_bot_hold` | `bot_or_npc` |
| `_apply_pose_with_reassert` | `bot_id, animation, loop, reassert_interval` |
| `eznpcs.move_bot_to_spot` | `bot_or_npc, target, options` |
| `eznpcs.set_bot_pose` | `bot_or_npc, options` |
| `eznpcs.attach_waypoint_follow` | `npc, first_waypoint_id, options` |
| `eznpcs.attach_chat` | `npc, first_dialogue` |
| `eznpcs.remove_npc` | `npc_or_bot_id` |
| `action` | `npc,player_id,relay_object` |
| `initialize` | `npc` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`animate_bot`, `list_areas`, `list_players`, `exclude_actor_for_player`, `include_actor_for_player`, `get_player_mugshot`, `get_player_area`, `create_bot`, `unlock_player_input`, `set_bot_direction`, `get_player_position`, `lock_player_input`, `move_bot`, `animate_bot_properties`, `get_bot_area`, `remove_bot`, `list_objects`, `get_bot_position`

## Engine `Async` calls

`sleep`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/eznpcs/` |
| `/server/assets/avatars/...` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
