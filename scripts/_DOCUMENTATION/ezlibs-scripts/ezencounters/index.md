# 📁 ezlibs-scripts/ezencounters

[🏠 Documentation home](../../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `main.lua` | 1 | 17 | 20 | 446 | [Open script reference](main/index.md) |
| 📄 Script | `rewards.lua` | 1 | 12 | 8 | 261 | [Open script reference](rewards/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `main.lua` | `ezencounters.get_encounter_by_name(encounter_name, area_id)` | 89 | [Details](main/index.md) |
| `main.lua` | `ezencounters.register_external_battle(player_id, encounter_data, options)` | 109 | [Details](main/index.md) |
| `main.lua` | `ezencounters.clear_external_battle(player_id, token)` | 124 | [Details](main/index.md) |
| `main.lua` | `ezencounters.resolve_encounter(encounter_reference, area_id)` | 135 | [Details](main/index.md) |
| `main.lua` | `ezencounters.increment_steps_since_encounter(player_id)` | 171 | [Details](main/index.md) |
| `main.lua` | `ezencounters.handle_player_move(player_id, x, y, z)` | 190 | [Details](main/index.md) |
| `main.lua` | `ezencounters.pick_encounter_from_table(encounter_table)` | 212 | [Details](main/index.md) |
| `main.lua` | `ezencounters.try_random_encounter(player_id,encounter_table)` | 236 | [Details](main/index.md) |
| `main.lua` | `ezencounters.begin_encounter_by_name(player_id,encounter_name,trigger_object,runtime_data)` | 252 | [Details](main/index.md) |
| `main.lua` | `ezencounters.begin_encounter(player_id,encounter_info,trigger_object,runtime_data)` | 271 | [Details](main/index.md) |
| `main.lua` | `ezencounters.clear_tiles_since_encounter(player_id)` | 304 | [Details](main/index.md) |
| `main.lua` | `ezencounters.clear_last_position(player_id)` | 308 | [Details](main/index.md) |
| `main.lua` | `ezencounters.handle_player_disconnect(player_id)` | 402 | [Details](main/index.md) |
| `rewards.lua` | `Rewards.is_victory(stats)` | 33 | [Details](rewards/index.md) |
| `rewards.lua` | `Rewards.collect(area_table, encounter_info, runtime_data, stats, options)` | 133 | [Details](rewards/index.md) |
| `rewards.lua` | `Rewards.finish(player_id, area_table, encounter_info, runtime_data, stats, options, callbacks)` | 189 | [Details](rewards/index.md) |

## 📊 Collection summary

This folder subtree contains **2 Lua source files**, **29 named/assigned function detections**, and **28 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.
