# 📁 ezlibs-custom/nebulous-liberations

[🏠 Documentation home](../../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents
- [📖 Guides & reference material](#guides--reference-material)
- [📂 Additional documentation folders](#additional-documentation-folders)

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📂 Folder | `liberations/` | 32 | 295 | 281 | — | [Open folder index](liberations/index.md) |
| 📂 Folder | `utils/` | 4 | 18 | 12 | — | [Open folder index](utils/index.md) |
| 📄 Script | `main.lua` | 1 | 22 | 13 | 731 | [Open script reference](main/index.md) |
| 📄 Script | `player.lua` | 1 | 21 | 7 | 328 | [Open script reference](player/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `main.lua` | `LibPlugin.spawn_boss(instance_area_id, boss_id)` | 200 | [Details](main/index.md) |
| `main.lua` | `LibPlugin.start_game_for_player(player_id, liberation_id)` | 212 | [Details](main/index.md) |
| `main.lua` | `LibPlugin.on_tick(delta_time)` | 320 | [Details](main/index.md) |
| `main.lua` | `LibPlugin.handle_tile_interaction(player_id, x, y, z, button)` | 339 | [Details](main/index.md) |
| `main.lua` | `LibPlugin.handle_object_interaction(player_id, object_id, button)` | 355 | [Details](main/index.md) |
| `main.lua` | `LibPlugin.handle_actor_interaction(player_id, actor_id, button)` | 373 | [Details](main/index.md) |
| `main.lua` | `LibPlugin.handle_textbox_response(player_id, response)` | 405 | [Details](main/index.md) |
| `main.lua` | `LibPlugin.handle_battle_results(...)` | 412 | [Details](main/index.md) |
| `main.lua` | `LibPlugin.handle_battle_exit(...)` | 439 | [Details](main/index.md) |
| `main.lua` | `LibPlugin.handle_player_avatar_change(player_id, details)` | 466 | [Details](main/index.md) |
| `main.lua` | `LibPlugin.handle_player_transfer(player_id)` | 475 | [Details](main/index.md) |
| `main.lua` | `LibPlugin.handle_player_request(player_id, data)` | 509 | [Details](main/index.md) |
| `main.lua` | `LibPlugin.handle_player_disconnect(player_id)` | 515 | [Details](main/index.md) |
| `main.lua` | `LibPlugin.handle_player_move(player_id, x, y, z)` | 527 | [Details](main/index.md) |
| `player.lua` | `Player:new(player_id)` | 68 | [Details](player/index.md) |
| `player.lua` | `Player:message(message, texture_path, animation_path)` | 93 | [Details](player/index.md) |
| `player.lua` | `Player:message_with_mug(message)` | 98 | [Details](player/index.md) |
| `player.lua` | `Player:say(message, texture_path, animation_path)` | 105 | [Details](player/index.md) |
| `player.lua` | `Player:say_with_mug(message)` | 110 | [Details](player/index.md) |
| `player.lua` | `Player:question(question, texture_path, animation_path)` | 114 | [Details](player/index.md) |
| `player.lua` | `Player:question_with_mug(question)` | 119 | [Details](player/index.md) |
| `player.lua` | `Player:quiz(a, b, c, texture_path, animation_path)` | 123 | [Details](player/index.md) |
| `player.lua` | `Player:quiz_with_mug(a, b, c)` | 131 | [Details](player/index.md) |
| `player.lua` | `Player:select_mission_option(options, title)` | 137 | [Details](player/index.md) |
| `player.lua` | `Player:is_battling()` | 141 | [Details](player/index.md) |
| `player.lua` | `Player:initiate_encounter(asset_path, data)` | 157 | [Details](player/index.md) |
| `player.lua` | `Player:handle_textbox_response(response)` | 175 | [Details](player/index.md) |
| `player.lua` | `Player:handle_battle_results(stats)` | 194 | [Details](player/index.md) |
| `player.lua` | `Player:handle_battle_exit(stats)` | 240 | [Details](player/index.md) |
| `player.lua` | `Player:handle_disconnect()` | 271 | [Details](player/index.md) |
| `player.lua` | `Player:boot_to_lobby(isVictory, mapName)` | 295 | [Details](player/index.md) |

## 📊 Collection summary

This folder subtree contains **38 Lua source files**, **356 named/assigned function detections**, and **313 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `README.md`](README.md) | 🌌 Nebulous Liberations — Complete Documentation |

## 📂 Additional documentation folders

| Folder | Index |
|---|---|
| `spirits/` | [Open folder index](spirits/index.md) |

## Asset organization and fixes

- [Asset layout, map tilesets, and HP Manager fixes](ASSET_PATHS.md)

- [Install and validation report](INSTALL.md)
