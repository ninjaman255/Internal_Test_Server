# `ezlibs-scripts/eznpcs/eznpcs.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/eznpcs/eznpcs.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-scripts/eznpcs/eznpcs.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/eznpcs/eznpcs.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `math` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/direction` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezcache` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezcutscenes/ezcutscenes` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eznpcs/dialogue_types` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezquests` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/object_registry` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/utils/eztiledutils` | Import string found in source; runtime resolution depends on the server package layout. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `bot_created` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `bot_moved` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `bot_removed` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `dialogue_ended` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `npc_spawned_from_spawner` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `quest_event` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `_apply_bot_animation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_apply_bot_direction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_apply_pose_with_reassert` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_bump_hold_generation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_claim_pose` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_release_pose` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_resolve_bot_id` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `action` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `add_behaviour` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `chat_behaviour` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `clear_player_conversation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `count_and_prune_live_bots` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `create_bot_from_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `create_npc` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `do_actor_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `do_dialogue` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `emit_bot_created` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `emit_bot_moved` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `emit_bot_removed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `exclude_except_for` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.add_event` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.add_npcs_to_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.cancel_battle_exit_wait` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.cancel_bot_hold` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.create_npc` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.create_npc_from_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.get_bot_for_placeholder` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.get_bot_id_for_placeholder` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.get_bot_record` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.get_dialogue_mugshot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.handle_actor_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.handle_battle_exit` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.handle_battle_results` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.handle_object_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.handle_player_join` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.load_npcs` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.move_bot_to_spot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.on_tick` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.prepare_battle_exit_wait` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.remove_exclusive_npc` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.remove_quest_exclusive_npc` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.resolve_bot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.set_bot_pose` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eznpcs.wait_for_battle_exit` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_all_players` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `include_for_all` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `initialize` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `is_anyone_talking_to_npc` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `make_spawner_path_complete_cb` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `move_npc` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_npc_reached_waypoint` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `printd` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `register_npc_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `register_npc_spawner` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_npc_animation` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `spawn_from_spawner` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `start_scripted_waypoint_move` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `update_quest_exclusive_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `update_spawner_triggers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `validate_npc_object` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `warp_out_spawner_npc` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `waypoint_follow_behaviour` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 1810 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
