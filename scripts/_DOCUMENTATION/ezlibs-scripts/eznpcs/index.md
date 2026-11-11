# 📁 ezlibs-scripts/eznpcs

[🏠 Documentation home](../../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `dialogue_types.lua` | 1 | 22 | 21 | 651 | [Open script reference](dialogue_types/index.md) |
| 📄 Script | `eznpcs.lua` | 1 | 69 | 29 | 1945 | [Open script reference](eznpcs/index.md) |
| 📄 Script | `ezpushback.lua` | 1 | 33 | 17 | 858 | [Open script reference](ezpushback/index.md) |
| 📄 Script | `npc_behaviors.lua` | 1 | 6 | 5 | 202 | [Open script reference](npc_behaviors/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `eznpcs.lua` | `eznpcs.get_dialogue_mugshot(npc,player_id,dialogue)` | 173 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.get_bot_for_placeholder(area_id, object_id)` | 1225 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.load_npcs()` | 1231 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.add_npcs_to_area(area_id)` | 1238 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.add_event(event_object)` | 1275 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.create_npc_from_object(area_id,object_id)` | 1287 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.handle_actor_interaction(player_id,actor_id)` | 1292 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.on_tick(delta_time)` | 1296 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.create_npc(area_id,asset_name,x,y,z,direction,bot_name,animation_name,mug_animation_name,dont_face_player)` | 1309 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.handle_player_transfer(player_id)` | 1318 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.handle_player_join(player_id)` | 1322 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.handle_player_disconnect(player_id)` | 1357 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.handle_object_interaction(player_id, object_id)` | 1382 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.remove_exclusive_npc(player_id, placeholder_id)` | 1444 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.prepare_battle_exit_wait(player_id)` | 1457 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.cancel_battle_exit_wait(player_id)` | 1462 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.handle_battle_exit(player_id, battle_results, exit_event)` | 1469 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.wait_for_battle_exit(player_id)` | 1483 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.handle_battle_results(player_id, stats)` | 1498 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.remove_quest_exclusive_npc(player_id, placeholder_id)` | 1504 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.get_bot_id_for_placeholder(area_id, placeholder_id)` | 1518 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.get_bot_record(bot_id)` | 1605 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.resolve_bot(area_id, object_id, player_id)` | 1612 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.cancel_bot_hold(bot_or_npc)` | 1633 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.move_bot_to_spot(bot_or_npc, target, options)` | 1684 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.set_bot_pose(bot_or_npc, options)` | 1779 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.create_npc_from_paths(area_id, texture_path, animation_path, x, y, z, direction, options)` | 1854 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.attach_waypoint_follow(npc, first_waypoint_id, options)` | 1909 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.attach_chat(npc, first_dialogue)` | 1923 | [Details](eznpcs/index.md) |
| `eznpcs.lua` | `eznpcs.remove_npc(npc_or_bot_id)` | 1935 | [Details](eznpcs/index.md) |
| `ezpushback.lua` | `ezpushback.attach_behavior(area_id, object_id, props, bot_id, x, y, z, name)` | 663 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.get_emitter(area_id, object_id)` | 777 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.get_emitter_for_bot(bot_id)` | 784 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.set_collision_enabled(area_id, object_id, enabled)` | 794 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.handle_player_move(player_id, x, y, z)` | 802 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.on_tick(delta_time)` | 807 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.handle_player_join(player_id)` | 829 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.handle_player_transfer(player_id)` | 836 | [Details](ezpushback/index.md) |
| `ezpushback.lua` | `ezpushback.handle_player_disconnect(player_id)` | 843 | [Details](ezpushback/index.md) |
| `npc_behaviors.lua` | `npc_behaviors.register(name, implementation)` | 30 | [Details](npc_behaviors/index.md) |
| `npc_behaviors.lua` | `npc_behaviors.attach_all()` | 125 | [Details](npc_behaviors/index.md) |

## 📊 Collection summary

This folder subtree contains **4 Lua source files**, **130 named/assigned function detections**, and **72 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.
