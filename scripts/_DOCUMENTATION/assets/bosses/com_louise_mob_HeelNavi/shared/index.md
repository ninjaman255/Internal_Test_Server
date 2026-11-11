# 📁 assets/bosses/com_louise_mob_HeelNavi/shared

[🏠 Documentation home](../../../../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📂 Folder | `chipattacks/` | 4 | 30 | 11 | — | [Open folder index](chipattacks/index.md) |
| 📄 Script | `battle_helpers.lua` | 1 | 9 | 5 | 212 | [Open script reference](battle_helpers/index.md) |
| 📄 Script | `character.lua` | 1 | 15 | 7 | 292 | [Open script reference](character/index.md) |
| 📄 Script | `fx_helper.lua` | 1 | 2 | 1 | 44 | [Open script reference](fx_helper/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `battle_helpers.lua` | `battle_helpers.spawn_visual_artifact(field, tile, texture, animation_path, animation_state, position_x, position_y)` | 15 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.can_move_to_func(tile, entity)` | 30 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.can_move_to_func_front_row(tile)` | 56 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.can_move_to_func_target_enemy(tile)` | 79 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.choose_random_tile(character, column)` | 110 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.find_target(self)` | 130 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.move_to_back_col(character)` | 144 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.move_to_front_col(character)` | 166 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.jump_to_target_row(character, jump_speed)` | 188 | [Details](battle_helpers/index.md) |
| `character.lua` | `self.action_idle(frame)` | 81 | [Details](character/index.md) |
| `character.lua` | `self.prepare_close_attack_action(frame)` | 108 | [Details](character/index.md) |
| `character.lua` | `action.action_end_func()` | 117 | [Details](character/index.md) |
| `character.lua` | `self.prepare_range_attack_action(frame)` | 128 | [Details](character/index.md) |
| `character.lua` | `action.action_end_func()` | 142 | [Details](character/index.md) |
| `character.lua` | `self.set_state(state)` | 153 | [Details](character/index.md) |
| `character.lua` | `self.update_func()` | 161 | [Details](character/index.md) |
| `character.lua` | `self.delete_func()` | 177 | [Details](character/index.md) |
| `fx_helper.lua` | `fx_helper.create_hit_effect(field, tile, fx_texture, fx_anim_path, fx_anim_state, sfx)` | 14 | [Details](fx_helper/index.md) |
| `fx_helper.lua` | `fx_helper.create_basic_effect(field, tile, hit_texture, hit_anim_path, hit_anim_state)` | 28 | [Details](fx_helper/index.md) |

## 📊 Collection summary

This folder subtree contains **7 Lua source files**, **56 named/assigned function detections**, and **24 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.
