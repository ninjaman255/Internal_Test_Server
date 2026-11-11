# 📄 `eznpcs.lua` — Current Lua reference

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/eznpcs/eznpcs.lua`](../../../../ezlibs-scripts/eznpcs/eznpcs.lua)  
> **Source lines:** 1946  
> **SHA-256 (UTF-8):** `a53a8b3b57ee040289fa05627b7646789f2f411b1ceb8527264af4bd6e113be2`  
> **Named functions detected:** 68  
> **Table initializers detected:** 29

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
| 2 | `scripts/logger/logger` |
| 3 | `scripts/ezlibs-scripts/direction` |
| 4 | `scripts/ezlibs-scripts/helpers` |
| 5 | `scripts/ezlibs-scripts/ezmemory` |
| 6 | `scripts/ezlibs-scripts/ezcache` |
| 7 | `scripts/ezlibs-scripts/object_registry` |
| 8 | `math` |
| 9 | `scripts/ezlibs-scripts/ezbus` |
| 10 | `scripts/ezlibs-scripts/ezquests` |
| 11 | `scripts/ezlibs-scripts/utils/eztiledutils` |
| 49 | `scripts/ezlibs-scripts/eznpcs/dialogue_types` |
| 435 | `scripts/ezlibs-scripts/ezcutscenes/ezcutscenes` |

## Event hooks

| Line | Subscriber | Event |
|---:|---|---|
| 1062 | `ezbus` | `bot_removed` |
| 1527 | `ezbus` | `quest_event` |

## Functions and parameters

| Line | Function | Arguments | Declaration |
|---:|---|---|---|
| 74 | `set_npc_animation` | `npc, animation, loop, source` | local |
| 91 | `printd` | `...` | local |
| 98 | `validate_npc_object` | `area_id, object` | local |
| 114 | `get_all_players` | `(none)` | local |
| 127 | `exclude_except_for` | `owner_id, bot_id` | local |
| 138 | `include_for_all` | `bot_id` | local |
| 148 | `emit_bot_created` | `bot_id, area_id, extra` | local |
| 157 | `emit_bot_removed` | `bot_id` | local |
| 162 | `emit_bot_moved` | `bot_id, area_id, x, y, z` | local |
| 174 | `eznpcs.get_dialogue_mugshot` | `npc,player_id,dialogue` | assigned/declared |
| 191 | `do_dialogue` | `npc,player_id,dialogue,relay_object` | assigned/declared |
| 234 | `create_bot_from_object` | `area_id, object, player_id, options` | assigned/declared |
| 331 | `create_npc` | `area_id,asset_name,x,y,z,direction,bot_name,animation_name,mug_animation_name,npc_turns_to_talk` | assigned/declared |
| 396 | `add_behaviour` | `npc,behaviour` | assigned/declared |
| 405 | `clear_player_conversation` | `player_id` | assigned/declared |
| 422 | `chat_behaviour` | `(none)` | assigned/declared |
| 425 | `action` | `npc,player_id,relay_object` | assigned/declared |
| 485 | `waypoint_follow_behaviour` | `first_waypoint_id, options` | assigned/declared |
| 489 | `initialize` | `npc` | assigned/declared |
| 509 | `action` | `npc,delta_time` | assigned/declared |
| 516 | `do_actor_interaction` | `player_id,actor_id,relay_object` | assigned/declared |
| 523 | `is_anyone_talking_to_npc` | `npc_id` | assigned/declared |
| 547 | `start_scripted_waypoint_move` | `npc, waypoint, move_anim, move_loop, move_duration` | local |
| 640 | `move_npc` | `npc,delta_time` | assigned/declared |
| 708 | `on_npc_reached_waypoint` | `npc,waypoint` | assigned/declared |
| 806 | `count_and_prune_live_bots` | `spawner` | local |
| 826 | `warp_out_spawner_npc` | `spawner, npc` | local |
| 868 | `make_spawner_path_complete_cb` | `spawner` | local |
| 891 | `spawn_from_spawner` | `spawner` | local |
| 940 | `register_npc_spawner` | `area_id, object` | local |
| 1076 | `update_spawner_triggers` | `delta_time` | local |
| 1157 | `update_quest_exclusive_for_player` | `player_id` | local |
| 1189 | `register_npc_object` | `area_id, object` | local |
| 1226 | `eznpcs.get_bot_for_placeholder` | `area_id, object_id` | assigned/declared |
| 1232 | `eznpcs.load_npcs` | `(none)` | assigned/declared |
| 1239 | `eznpcs.add_npcs_to_area` | `area_id` | assigned/declared |
| 1276 | `eznpcs.add_event` | `event_object` | assigned/declared |
| 1288 | `eznpcs.create_npc_from_object` | `area_id,object_id` | assigned/declared |
| 1293 | `eznpcs.handle_actor_interaction` | `player_id,actor_id` | assigned/declared |
| 1297 | `eznpcs.on_tick` | `delta_time` | assigned/declared |
| 1310 | `eznpcs.create_npc` | `area_id,asset_name,x,y,z,direction,bot_name,animation_name,mug_animation_name,dont_face_player` | assigned/declared |
| 1319 | `eznpcs.handle_player_transfer` | `player_id` | assigned/declared |
| 1323 | `eznpcs.handle_player_join` | `player_id` | assigned/declared |
| 1358 | `eznpcs.handle_player_disconnect` | `player_id` | assigned/declared |
| 1383 | `eznpcs.handle_object_interaction` | `player_id, object_id` | assigned/declared |
| 1445 | `eznpcs.remove_exclusive_npc` | `player_id, placeholder_id` | assigned/declared |
| 1458 | `eznpcs.prepare_battle_exit_wait` | `player_id` | assigned/declared |
| 1463 | `eznpcs.cancel_battle_exit_wait` | `player_id` | assigned/declared |
| 1470 | `eznpcs.handle_battle_exit` | `player_id, battle_results, exit_event` | assigned/declared |
| 1484 | `eznpcs.wait_for_battle_exit` | `player_id` | assigned/declared |
| 1499 | `eznpcs.handle_battle_results` | `player_id, stats` | assigned/declared |
| 1505 | `eznpcs.remove_quest_exclusive_npc` | `player_id, placeholder_id` | assigned/declared |
| 1519 | `eznpcs.get_bot_id_for_placeholder` | `area_id, placeholder_id` | assigned/declared |
| 1543 | `_resolve_bot_id` | `bot_or_npc` | local |
| 1554 | `_apply_bot_animation` | `bot_id, state, loop` | local |
| 1561 | `_apply_bot_direction` | `bot_id, direction` | local |
| 1570 | `_bump_hold_generation` | `bot_id` | local |
| 1584 | `_claim_pose` | `bot_id` | local |
| 1596 | `_release_pose` | `bot_id` | local |
| 1606 | `eznpcs.get_bot_record` | `bot_id` | assigned/declared |
| 1613 | `eznpcs.resolve_bot` | `area_id, object_id, player_id` | assigned/declared |
| 1634 | `eznpcs.cancel_bot_hold` | `bot_or_npc` | assigned/declared |
| 1644 | `_apply_pose_with_reassert` | `bot_id, animation, loop, reassert_interval` | local |
| 1685 | `eznpcs.move_bot_to_spot` | `bot_or_npc, target, options` | assigned/declared |
| 1780 | `eznpcs.set_bot_pose` | `bot_or_npc, options` | assigned/declared |
| 1910 | `eznpcs.attach_waypoint_follow` | `npc, first_waypoint_id, options` | assigned/declared |
| 1924 | `eznpcs.attach_chat` | `npc, first_dialogue` | assigned/declared |
| 1936 | `eznpcs.remove_npc` | `npc_or_bot_id` | assigned/declared |

### Parameter inventory

#### 1. `set_npc_animation(npc, animation, loop, source)`

- **Line:** 74
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `animation` | Declared directly in the current Lua. Type not inferred. |
| 3 | `loop` | Declared directly in the current Lua. Type not inferred. |
| 4 | `source` | Declared directly in the current Lua. Type not inferred. |

#### 2. `printd(...)`

- **Line:** 91
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `...` | Declared directly in the current Lua. Type not inferred. |

#### 3. `validate_npc_object(area_id, object)`

- **Line:** 98
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object` | Declared directly in the current Lua. Type not inferred. |

#### 4. `get_all_players()`

- **Line:** 114
- **Declaration:** local
- **Parameters:** none explicitly declared.

#### 5. `exclude_except_for(owner_id, bot_id)`

- **Line:** 127
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `owner_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `bot_id` | Declared directly in the current Lua. Type not inferred. |

#### 6. `include_for_all(bot_id)`

- **Line:** 138
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared directly in the current Lua. Type not inferred. |

#### 7. `emit_bot_created(bot_id, area_id, extra)`

- **Line:** 148
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `extra` | Declared directly in the current Lua. Type not inferred. |

#### 8. `emit_bot_removed(bot_id)`

- **Line:** 157
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared directly in the current Lua. Type not inferred. |

#### 9. `emit_bot_moved(bot_id, area_id, x, y, z)`

- **Line:** 162
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `z` | Declared directly in the current Lua. Type not inferred. |

#### 10. `eznpcs.get_dialogue_mugshot(npc,player_id,dialogue)`

- **Line:** 174
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 11. `do_dialogue(npc,player_id,dialogue,relay_object)`

- **Line:** 191
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `dialogue` | Declared directly in the current Lua. Type not inferred. |
| 4 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 12. `create_bot_from_object(area_id, object, player_id, options)`

- **Line:** 234
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object` | Declared directly in the current Lua. Type not inferred. |
| 3 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 4 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 13. `create_npc(area_id,asset_name,x,y,z,direction,bot_name,animation_name,mug_animation_name,npc_turns_to_talk)`

- **Line:** 331
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `asset_name` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `z` | Declared directly in the current Lua. Type not inferred. |
| 6 | `direction` | Declared directly in the current Lua. Type not inferred. |
| 7 | `bot_name` | Declared directly in the current Lua. Type not inferred. |
| 8 | `animation_name` | Declared directly in the current Lua. Type not inferred. |
| 9 | `mug_animation_name` | Declared directly in the current Lua. Type not inferred. |
| 10 | `npc_turns_to_talk` | Declared directly in the current Lua. Type not inferred. |

#### 14. `add_behaviour(npc,behaviour)`

- **Line:** 396
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `behaviour` | Declared directly in the current Lua. Type not inferred. |

#### 15. `clear_player_conversation(player_id)`

- **Line:** 405
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 16. `chat_behaviour()`

- **Line:** 422
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 17. `action(npc,player_id,relay_object)`

- **Line:** 425
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 18. `waypoint_follow_behaviour(first_waypoint_id, options)`

- **Line:** 485
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `first_waypoint_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 19. `initialize(npc)`

- **Line:** 489
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |

#### 20. `action(npc,delta_time)`

- **Line:** 509
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `delta_time` | Declared directly in the current Lua. Type not inferred. |

#### 21. `do_actor_interaction(player_id,actor_id,relay_object)`

- **Line:** 516
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `actor_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `relay_object` | Declared directly in the current Lua. Type not inferred. |

#### 22. `is_anyone_talking_to_npc(npc_id)`

- **Line:** 523
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc_id` | Declared directly in the current Lua. Type not inferred. |

#### 23. `start_scripted_waypoint_move(npc, waypoint, move_anim, move_loop, move_duration)`

- **Line:** 547
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `waypoint` | Declared directly in the current Lua. Type not inferred. |
| 3 | `move_anim` | Declared directly in the current Lua. Type not inferred. |
| 4 | `move_loop` | Declared directly in the current Lua. Type not inferred. |
| 5 | `move_duration` | Declared directly in the current Lua. Type not inferred. |

#### 24. `move_npc(npc,delta_time)`

- **Line:** 640
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `delta_time` | Declared directly in the current Lua. Type not inferred. |

#### 25. `on_npc_reached_waypoint(npc,waypoint)`

- **Line:** 708
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `waypoint` | Declared directly in the current Lua. Type not inferred. |

#### 26. `count_and_prune_live_bots(spawner)`

- **Line:** 806
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `spawner` | Declared directly in the current Lua. Type not inferred. |

#### 27. `warp_out_spawner_npc(spawner, npc)`

- **Line:** 826
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `spawner` | Declared directly in the current Lua. Type not inferred. |
| 2 | `npc` | Declared directly in the current Lua. Type not inferred. |

#### 28. `make_spawner_path_complete_cb(spawner)`

- **Line:** 868
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `spawner` | Declared directly in the current Lua. Type not inferred. |

#### 29. `spawn_from_spawner(spawner)`

- **Line:** 891
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `spawner` | Declared directly in the current Lua. Type not inferred. |

#### 30. `register_npc_spawner(area_id, object)`

- **Line:** 940
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object` | Declared directly in the current Lua. Type not inferred. |

#### 31. `update_spawner_triggers(delta_time)`

- **Line:** 1076
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `delta_time` | Declared directly in the current Lua. Type not inferred. |

#### 32. `update_quest_exclusive_for_player(player_id)`

- **Line:** 1157
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 33. `register_npc_object(area_id, object)`

- **Line:** 1189
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object` | Declared directly in the current Lua. Type not inferred. |

#### 34. `eznpcs.get_bot_for_placeholder(area_id, object_id)`

- **Line:** 1226
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |

#### 35. `eznpcs.load_npcs()`

- **Line:** 1232
- **Declaration:** assigned/declared
- **Parameters:** none explicitly declared.

#### 36. `eznpcs.add_npcs_to_area(area_id)`

- **Line:** 1239
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |

#### 37. `eznpcs.add_event(event_object)`

- **Line:** 1276
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `event_object` | Declared directly in the current Lua. Type not inferred. |

#### 38. `eznpcs.create_npc_from_object(area_id,object_id)`

- **Line:** 1288
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |

#### 39. `eznpcs.handle_actor_interaction(player_id,actor_id)`

- **Line:** 1293
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `actor_id` | Declared directly in the current Lua. Type not inferred. |

#### 40. `eznpcs.on_tick(delta_time)`

- **Line:** 1297
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `delta_time` | Declared directly in the current Lua. Type not inferred. |

#### 41. `eznpcs.create_npc(area_id,asset_name,x,y,z,direction,bot_name,animation_name,mug_animation_name,dont_face_player)`

- **Line:** 1310
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `asset_name` | Declared directly in the current Lua. Type not inferred. |
| 3 | `x` | Declared directly in the current Lua. Type not inferred. |
| 4 | `y` | Declared directly in the current Lua. Type not inferred. |
| 5 | `z` | Declared directly in the current Lua. Type not inferred. |
| 6 | `direction` | Declared directly in the current Lua. Type not inferred. |
| 7 | `bot_name` | Declared directly in the current Lua. Type not inferred. |
| 8 | `animation_name` | Declared directly in the current Lua. Type not inferred. |
| 9 | `mug_animation_name` | Declared directly in the current Lua. Type not inferred. |
| 10 | `dont_face_player` | Declared directly in the current Lua. Type not inferred. |

#### 42. `eznpcs.handle_player_transfer(player_id)`

- **Line:** 1319
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 43. `eznpcs.handle_player_join(player_id)`

- **Line:** 1323
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 44. `eznpcs.handle_player_disconnect(player_id)`

- **Line:** 1358
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 45. `eznpcs.handle_object_interaction(player_id, object_id)`

- **Line:** 1383
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |

#### 46. `eznpcs.remove_exclusive_npc(player_id, placeholder_id)`

- **Line:** 1445
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `placeholder_id` | Declared directly in the current Lua. Type not inferred. |

#### 47. `eznpcs.prepare_battle_exit_wait(player_id)`

- **Line:** 1458
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 48. `eznpcs.cancel_battle_exit_wait(player_id)`

- **Line:** 1463
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 49. `eznpcs.handle_battle_exit(player_id, battle_results, exit_event)`

- **Line:** 1470
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `battle_results` | Declared directly in the current Lua. Type not inferred. |
| 3 | `exit_event` | Declared directly in the current Lua. Type not inferred. |

#### 50. `eznpcs.wait_for_battle_exit(player_id)`

- **Line:** 1484
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 51. `eznpcs.handle_battle_results(player_id, stats)`

- **Line:** 1499
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `stats` | Declared directly in the current Lua. Type not inferred. |

#### 52. `eznpcs.remove_quest_exclusive_npc(player_id, placeholder_id)`

- **Line:** 1505
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `player_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `placeholder_id` | Declared directly in the current Lua. Type not inferred. |

#### 53. `eznpcs.get_bot_id_for_placeholder(area_id, placeholder_id)`

- **Line:** 1519
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `placeholder_id` | Declared directly in the current Lua. Type not inferred. |

#### 54. `_resolve_bot_id(bot_or_npc)`

- **Line:** 1543
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_or_npc` | Declared directly in the current Lua. Type not inferred. |

#### 55. `_apply_bot_animation(bot_id, state, loop)`

- **Line:** 1554
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `state` | Declared directly in the current Lua. Type not inferred. |
| 3 | `loop` | Declared directly in the current Lua. Type not inferred. |

#### 56. `_apply_bot_direction(bot_id, direction)`

- **Line:** 1561
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `direction` | Declared directly in the current Lua. Type not inferred. |

#### 57. `_bump_hold_generation(bot_id)`

- **Line:** 1570
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared directly in the current Lua. Type not inferred. |

#### 58. `_claim_pose(bot_id)`

- **Line:** 1584
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared directly in the current Lua. Type not inferred. |

#### 59. `_release_pose(bot_id)`

- **Line:** 1596
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared directly in the current Lua. Type not inferred. |

#### 60. `eznpcs.get_bot_record(bot_id)`

- **Line:** 1606
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared directly in the current Lua. Type not inferred. |

#### 61. `eznpcs.resolve_bot(area_id, object_id, player_id)`

- **Line:** 1613
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `area_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `object_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `player_id` | Declared directly in the current Lua. Type not inferred. |

#### 62. `eznpcs.cancel_bot_hold(bot_or_npc)`

- **Line:** 1634
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_or_npc` | Declared directly in the current Lua. Type not inferred. |

#### 63. `_apply_pose_with_reassert(bot_id, animation, loop, reassert_interval)`

- **Line:** 1644
- **Declaration:** local

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_id` | Declared directly in the current Lua. Type not inferred. |
| 2 | `animation` | Declared directly in the current Lua. Type not inferred. |
| 3 | `loop` | Declared directly in the current Lua. Type not inferred. |
| 4 | `reassert_interval` | Declared directly in the current Lua. Type not inferred. |

#### 64. `eznpcs.move_bot_to_spot(bot_or_npc, target, options)`

- **Line:** 1685
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_or_npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `target` | Declared directly in the current Lua. Type not inferred. |
| 3 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 65. `eznpcs.set_bot_pose(bot_or_npc, options)`

- **Line:** 1780
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `bot_or_npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 66. `eznpcs.attach_waypoint_follow(npc, first_waypoint_id, options)`

- **Line:** 1910
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `first_waypoint_id` | Declared directly in the current Lua. Type not inferred. |
| 3 | `options` | Declared directly in the current Lua. Type not inferred. |

#### 67. `eznpcs.attach_chat(npc, first_dialogue)`

- **Line:** 1924
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc` | Declared directly in the current Lua. Type not inferred. |
| 2 | `first_dialogue` | Declared directly in the current Lua. Type not inferred. |

#### 68. `eznpcs.remove_npc(npc_or_bot_id)`

- **Line:** 1936
- **Declaration:** assigned/declared

| # | Parameter | Evidence |
|---:|---|---|
| 1 | `npc_or_bot_id` | Declared directly in the current Lua. Type not inferred. |


## Tables

| Line | Identifier |
|---:|---|
| 24 | `eznpcs` |
| 28 | `battle_exit_generation` |
| 29 | `battle_exit_waiting` |
| 30 | `placeholder_to_botid` |
| 31 | `exclusive_npcs` |
| 32 | `exclusive_placeholders` |
| 35 | `quest_exclusive_placeholders` |
| 36 | `quest_exclusive_npcs` |
| 40 | `npc_spawners` |
| 42 | `npcs` |
| 43 | `current_player_conversation` |
| 50 | `npc_required_properties` |
| 92 | `arg` |
| 115 | `players` |
| 150 | `payload` |
| 177 | `mug` |
| 347 | `npc_data` |
| 423 | `behaviour` |
| 487 | `behaviour` |
| 572 | `keyframes` |
| 574 | `properties` |
| 582 | `properties` |
| 694 | `new_pos` |
| 1011 | `spawner` |
| 1015 | `live_bots` |
| 1714 | `keyframes` |
| 1716 | `properties` |
| 1724 | `properties` |
| 1860 | `npc_data` |

## Net API calls

| API | Count | First line |
|---|---:|---:|
| `Net.create_bot` | 2 | 376 |
| `Net.exclude_actor_for_player` | 3 | 131 |
| `Net.get_bot_area` | 1 | 655 |
| `Net.get_player_area` | 2 | 195 |
| `Net.get_player_mugshot` | 1 | 184 |
| `Net.get_player_position` | 1 | 457 |
| `Net.include_actor_for_player` | 1 | 141 |
| `Net.list_areas` | 2 | 116 |
| `Net.list_objects` | 1 | 1241 |
| `Net.list_players` | 2 | 118 |
| `Net.move_bot` | 1 | 701 |
| `Net.remove_bot` | 5 | 1162 |
| `Net.set_bot_direction` | 4 | 411 |
