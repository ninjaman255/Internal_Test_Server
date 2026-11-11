# 📁 assets/bosses/com_louise_mob_HeelNavi/allies/Boomer/Boomer

[🏠 Documentation home](../../../../../../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📂 Folder | `PanelGrab/` | 1 | 5 | 2 | — | [Open folder index](PanelGrab/index.md) |
| 📄 Script | `battle_helpers.lua` | 1 | 6 | 2 | 144 | [Open script reference](battle_helpers/index.md) |
| 📄 Script | `character.lua` | 1 | 18 | 2 | 317 | [Open script reference](character/index.md) |
| 📄 Script | `entry.lua` | 1 | 1 | 1 | 47 | [Open script reference](entry/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `battle_helpers.lua` | `battle_helpers.spawn_visual_artifact(field, tile, texture, animation_path, animation_state, position_x, position_y)` | 15 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.can_move_to_func(tile, entity)` | 30 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.can_move_to_func_front_row(tile)` | 56 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.can_move_to_func_target_enemy(tile)` | 79 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.find_target(self)` | 106 | [Details](battle_helpers/index.md) |
| `battle_helpers.lua` | `battle_helpers.jump_to_target_row(character, jump_speed)` | 120 | [Details](battle_helpers/index.md) |
| `character.lua` | `self.defense_rule.can_block_func(judge, attacker, defender)` | 58 | [Details](character/index.md) |
| `character.lua` | `self.action_idle(frame)` | 87 | [Details](character/index.md) |
| `character.lua` | `self.turn()` | 97 | [Details](character/index.md) |
| `character.lua` | `self.action_move(frame)` | 105 | [Details](character/index.md) |
| `character.lua` | `self.action_wait(frame)` | 145 | [Details](character/index.md) |
| `character.lua` | `self.set_state(state)` | 162 | [Details](character/index.md) |
| `character.lua` | `self.update_func()` | 169 | [Details](character/index.md) |
| `character.lua` | `self.throw_boomerang()` | 184 | [Details](character/index.md) |
| `character.lua` | `spell.update_func(self, dt)` | 239 | [Details](character/index.md) |
| `character.lua` | `spell.collision_func(self, other)` | 266 | [Details](character/index.md) |
| `character.lua` | `spell.attack_func(self, other)` | 268 | [Details](character/index.md) |
| `character.lua` | `spell.delete_func(self)` | 272 | [Details](character/index.md) |
| `character.lua` | `spell.can_move_to_func(tile)` | 275 | [Details](character/index.md) |

## 📊 Collection summary

This folder subtree contains **4 Lua source files**, **30 named/assigned function detections**, and **7 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.
