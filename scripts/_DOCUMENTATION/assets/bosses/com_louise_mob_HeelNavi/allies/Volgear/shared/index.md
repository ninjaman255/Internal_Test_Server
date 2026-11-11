# 📁 assets/bosses/com_louise_mob_HeelNavi/allies/Volgear/shared

[🏠 Documentation home](../../../../../../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `battle_helpers.lua` | 1 | 7 | 2 | 151 | [Open script reference](battle_helpers/index.md) |
| 📄 Script | `entry.lua` | 1 | 25 | 0 | 329 | [Open script reference](entry/index.md) |
| 📄 Script | `mob_tracker.lua` | 1 | 10 | 3 | 76 | [Open script reference](mob_tracker/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `battle_helpers.lua` | `battle_helpers.spawn_visual_artifact(character,tile,texture,animation_path,animation_state,position_x,position_y,dont_flip_offset)` | 7 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.find_all_enemies(user)` | 30 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.find_targets_ahead(user)` | 42 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.get_first_target_ahead(user,ignore_neutral_team)` | 68 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.drop_trace_fx(target_artifact,lifetime_ms)` | 94 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `fx.update_func(self, dt)` | 111 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.is_tile_free_for_movement(tile,character,must_be_walkable)` | 126 | [Details](battle_helpers/index.md) |
| `entry.lua` | `self.update_func(self, dt)` | 92 | [Details](entry/index.md) |
| `entry.lua` | `self.battle_start_func(self)` | 112 | [Details](entry/index.md) |
| `entry.lua` | `self.on_spawn_func(self, spawn_tile)` | 126 | [Details](entry/index.md) |
| `entry.lua` | `self.can_move_to_func(tile)` | 131 | [Details](entry/index.md) |
| `entry.lua` | `self.delete_func(self)` | 134 | [Details](entry/index.md) |
| `entry.lua` | `self.flame_action.action_end_func()` | 168 | [Details](entry/index.md) |
| `entry.lua` | `action.execute_func(self, user)` | 216 | [Details](entry/index.md) |
| `entry.lua` | `spell.collision_func(self, other)` | 287 | [Details](entry/index.md) |
| `entry.lua` | `spell.update_func()` | 319 | [Details](entry/index.md) |
| `mob_tracker.lua` | `MobTracker:new()` | 3 | [Details](mob_tracker/index.md) |
| `mob_tracker.lua` | `MobTracker:add_by_id(mob_id)` | 14 | [Details](mob_tracker/index.md) |
| `mob_tracker.lua` | `MobTracker:print_ids()` | 19 | [Details](mob_tracker/index.md) |
| `mob_tracker.lua` | `MobTracker:sort_turn_order(sort_function,reverse_sorting)` | 25 | [Details](mob_tracker/index.md) |
| `mob_tracker.lua` | `MobTracker:get_index(mob_id)` | 37 | [Details](mob_tracker/index.md) |
| `mob_tracker.lua` | `MobTracker:remove_by_id(mob_id)` | 46 | [Details](mob_tracker/index.md) |
| `mob_tracker.lua` | `MobTracker:clear()` | 58 | [Details](mob_tracker/index.md) |
| `mob_tracker.lua` | `MobTracker:get_active_mob()` | 65 | [Details](mob_tracker/index.md) |
| `mob_tracker.lua` | `MobTracker:advance_a_turn()` | 69 | [Details](mob_tracker/index.md) |

## 📊 Collection summary

This folder subtree contains **3 Lua source files**, **42 named/assigned function detections**, and **5 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.
