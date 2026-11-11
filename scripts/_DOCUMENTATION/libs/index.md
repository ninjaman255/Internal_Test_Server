# 📁 libs

[🏠 Documentation home](../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📂 Folder | `stardust/` | 1 | 55 | 15 | — | [Open folder index](stardust/index.md) |
| 📄 Script | `direction.lua` | 1 | 5 | 3 | 86 | [Open script reference](direction/index.md) |
| 📄 Script | `emotes.lua` | 1 | 0 | 1 | 25 | [Open script reference](emotes/index.md) |
| 📄 Script | `emotions.lua` | 1 | 0 | 1 | 14 | [Open script reference](emotions/index.md) |
| 📄 Script | `encounters.lua` | 1 | 6 | 4 | 143 | [Open script reference](encounters/index.md) |
| 📄 Script | `enums.lua` | 1 | 0 | 7 | 85 | [Open script reference](enums/index.md) |
| 📄 Script | `json.lua` | 1 | 19 | 13 | 439 | [Open script reference](json/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `direction.lua` | `Direction.reverse(direction)` | 23 | [Details](direction/index.md) |
| `direction.lua` | `Direction.from_points(point_a, point_b)` | 27 | [Details](direction/index.md) |
| `direction.lua` | `Direction.diagonal_from_points(point_a, point_b)` | 39 | [Details](direction/index.md) |
| `direction.lua` | `Direction.from_offset(x, y)` | 62 | [Details](direction/index.md) |
| `direction.lua` | `Direction.diagonal_from_offset(x, y)` | 68 | [Details](direction/index.md) |
| `encounters.lua` | `lib.track_player(player_id)` | 8 | [Details](encounters/index.md) |
| `encounters.lua` | `lib.drop_player(player_id)` | 16 | [Details](encounters/index.md) |
| `encounters.lua` | `lib.setup(encounter_table)` | 20 | [Details](encounters/index.md) |
| `encounters.lua` | `lib.setup_area(area_id, area_table)` | 26 | [Details](encounters/index.md) |
| `encounters.lua` | `lib.handle_player_move(player_id, x, y, z)` | 47 | [Details](encounters/index.md) |
| `encounters.lua` | `lib.initiate_direct_encounter(player_id, asset_path)` | 104 | [Details](encounters/index.md) |
| `json.lua` | `json.encode(val, pretty)` | 179 | [Details](json/index.md) |
| `json.lua` | `json.decode(str)` | 426 | [Details](json/index.md) |

## 📊 Collection summary

This folder subtree contains **7 Lua source files**, **85 named/assigned function detections**, and **44 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.
