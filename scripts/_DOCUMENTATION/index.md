# 📁 scripts

[🏠 Documentation home](index.md)

## 🗂️ Contents

- [📚 Complete documentation library](#complete-documentation-library)
- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)
- [🧭 Project coverage](#project-coverage)

## 📚 Complete documentation library

Every README, authored guide, project reference, and documentation-only folder is reachable from this index. 
The module indexes below provide detailed Lua function and table references. 
Original runtime files are kept at their existing paths; only documentation files are relocated.

| Collection | Document | Guide |
|---|---|---|
| `logger` | [📖 Shared Logger programmer guide](logger/README.md) | 🪵 System/subsystem logs at `scripts/_DEBUGGING/` |
| `logger` | [📖 Logger migration](logger/MIGRATION.md) | 🔄 Old API adapters and historical log handling |
| `logger` | [📖 Logger tests](logger/TESTING.md) | 🧪 Validation and in-game checklist |
| `Root references` | [📖 `CENTRALIZATION_STATUS.md`](CENTRALIZATION_STATUS.md) | 📂 Original README cleanup |
| `ezlibs-custom/endless-runner` | [📖 `README.md`](ezlibs-custom/endless-runner/README.md) | 🏃 Endless Runner README |
| `net-game-tourney` | [📖 `readme.md`](net-game-tourney/readme.md) | 🏆 Tournament README |
| `Root references` | [📖 `DOCUMENTATION_QA.md`](DOCUMENTATION_QA.md) | 🔎 Link and reference QA |
| `Root references` | [📖 `PLAYERCONTROL_CHANGELOG.md`](PLAYERCONTROL_CHANGELOG.md) | 🧩 PlayerControl change digest |
| `player-control` | [📖 `README.md`](player-control/README.md) | 🎮 PlayerControl v2 programmer guide |
| `player-control` | [📖 `CAMERA_FOCUS.md`](player-control/CAMERA_FOCUS.md) | 📷 Exclusive camera leases |
| `player-control` | [📖 `CAPTURE_SCOPES.md`](player-control/CAPTURE_SCOPES.md) | 🔌 Managed named engine input and HUD capture |
| `player-control` | [📖 `CAPTURE_SCOPES.md`](player-control/CAPTURE_SCOPES.md) | 🧰 Non-focused named captures and HUD scopes |
| `player-control` | [📖 `resources/index.md`](player-control/resources/index.md) | 🧰 Canonical engine input/HUD suppression |
| `player-control` | [📖 `TESTING.md`](player-control/TESTING.md) | 🧪 Test and regression coverage |
| `player-control` | [📖 `V2_UPDATE_REPORT.md`](player-control/V2_UPDATE_REPORT.md) | 🧩 Input/camera v2 implementation report |
| `player-control` | [📖 `CONTROL_FLOW.md`](player-control/CONTROL_FLOW.md) | 🧭 Session lifecycle |
| `player-control` | [📖 `MIGRATION_AUDIT.md`](player-control/MIGRATION_AUDIT.md) | 🛠 Low-level lock migration inventory |
| `simon-says` | [📖 `README.md`](simon-says/README.md) | 🎮 Simon Says movement capture, facing, and sprite-safe jitter |
| `hp_manager` | [📖 `README.md`](hp_manager/README.md) | 🖥️ HP Manager complete guide |
| `jukebox` | [📖 `README.md`](jukebox/README.md) | 🎵 Jukebox complete guide |
| `real_daytime` | [📖 `README.md`](real_daytime/README.md) | 🌤️ Preserved Real Daytime README |
| `real_daytime` | [📖 `INTEGRATION.md`](real_daytime/INTEGRATION.md) | ⏰ Real Time editor integration |
| `areas` | [📖 `HP_MANAGER_TILED.md`](areas/HP_MANAGER_TILED.md) | 🗺️ HP Manager map verification |
| `camera` | [📖 `PLAYERCONTROL_INTEGRATION.md`](camera/PLAYERCONTROL_INTEGRATION.md) | 📷 Camera integration |
| `input-controller` | [📖 `PLAYERCONTROL_INTEGRATION.md`](input-controller/PLAYERCONTROL_INTEGRATION.md) | 🎮 Controller integration |
| `ezlibs-scripts` | [📖 `HP_MANAGER_BOOTSTRAP.md`](ezlibs-scripts/HP_MANAGER_BOOTSTRAP.md) | 🔌 Bootstrap integration |
| `Root references` | [📖 `CURRENT_SYSTEMS.md`](CURRENT_SYSTEMS.md) | 🧭 Current Systems Guide — Internal Test Server |
| `Root references` | [📖 `ENCOUNTER_FIELD_INVENTORY.md`](ENCOUNTER_FIELD_INVENTORY.md) | ⚔️ Encounter Lua — Source Field Inventory |
| `Root references` | [📖 `MIGRATION_REPORT.md`](MIGRATION_REPORT.md) | 📦 Centralized Documentation — Migration Report |
| `Root references` | [📖 `SNAPSHOT_REPORT.md`](SNAPSHOT_REPORT.md) | 🧭 Internal Test Server — Documentation Snapshot |
| `animation-engine` | [📖 `README.md`](animation-engine/README.md) | 🎬 Animation Engine Documentation |
| `assets/ezlibs-assets/ezencounters` | [📖 `MOD_PACKAGE_AUDIT.txt`](assets/ezlibs-assets/ezencounters/MOD_PACKAGE_AUDIT.txt) | MOD_PACKAGE_AUDIT.txt |
| `assets/ezlibs-assets/eznpcs/sheet` | [📖 `readme.md`](assets/ezlibs-assets/eznpcs/sheet/readme.md) | readme.md |
| `assets/ezlibs-assets` | [📖 `readme.md`](assets/ezlibs-assets/readme.md) | ezlibs |
| `assets/tiles` | [📖 `README.md`](assets/tiles/README.md) | Nebulous-Liberations-Tiles |
| `avatar_utils/lua_yes_parser` | [📖 `README.md`](avatar_utils/lua_yes_parser/README.md) | YES Script |
| `avatar_utils/lua_yes_parser/spec` | [📖 `README.md`](avatar_utils/lua_yes_parser/spec/README.md) | YES Script |
| `camera` | [📖 `README.md`](camera/README.md) | Camera Controller |
| `displayer` | [📖 `readme.md`](displayer/readme.md) | 🎮 Displayer Library — Complete Documentation |
| `ezlibs-custom/footbomb` | [📖 `README.md`](ezlibs-custom/footbomb/README.md) | FootBomb animation parser versioning |
| `ezlibs-custom/nebulous-liberations` | [📖 `README.md`](ezlibs-custom/nebulous-liberations/README.md) | 🌌 Nebulous Liberations — Complete Documentation |
| `ezlibs-custom/nebulous-liberations/spirits` | [📖 `todo.md`](ezlibs-custom/nebulous-liberations/spirits/todo.md) | todo.md |
| `ezlibs-scripts` | [📖 `MODULE_DEPENDENCIES.md`](ezlibs-scripts/MODULE_DEPENDENCIES.md) | 🔗 ezlibs-scripts — Current Module Dependencies |
| `ezlibs-scripts` | [📖 `README-UPDATED.md`](ezlibs-scripts/README-UPDATED.md) | ezlibs — Complete Documentation (Formatted for Developers) |
| `ezlibs-scripts/avatar_utils/lua_yes_parser` | [📖 `README.md`](ezlibs-scripts/avatar_utils/lua_yes_parser/README.md) | YES Script |
| `ezlibs-scripts/avatar_utils/lua_yes_parser/spec` | [📖 `README.md`](ezlibs-scripts/avatar_utils/lua_yes_parser/spec/README.md) | YES Script |
| `ezlibs-scripts` | [📖 `ezlibs-tiled-reference.md`](ezlibs-scripts/ezlibs-tiled-reference.md) | Tiled Reference |
| `ezlibs-scripts` | [📖 `readme.md`](ezlibs-scripts/readme.md) | 📚 ezlibs Library — Complete Documentation |
| `ezlibs-scripts/utils` | [📖 `README.md`](ezlibs-scripts/utils/README.md) | Utility modules |
| `input-controller` | [📖 `README.md`](input-controller/README.md) | 🎮 Input Controller Library |
| `hp_manager` | [📖 `index.md`](hp_manager/index.md) | 🖥️ HP Manager — Desktop/child session migration and default.tmx object |
| `jukebox` | [📖 `index.md`](jukebox/index.md) | 🎵 Jukebox — Standalone and desktop-child input management |
| `libs/encounters` | [📖 `README.md`](libs/encounters/README.md) | Encounter Tables |
| `libs/encounters` | [📖 `SCHEMA.md`](libs/encounters/SCHEMA.md) | Encounter Table Schema |
| `libs/stardust` | [📖 `README.md`](libs/stardust/README.md) | ONB Stardust |
| `net-games` | [📖 `UI-SUPPRESSION.md`](net-games/UI-SUPPRESSION.md) | UI Suppression Manager |
| `net-games/menuAPI` | [📖 `README.md`](net-games/menuAPI/README.md) | MenuAPI |
| `net-games/npcs` | [📖 `readme.md`](net-games/npcs/readme.md) | readme.md |
| `net-games` | [📖 `readme.md`](net-games/readme.md) | 🎮 Net-Games Library — Complete Documentation |
| `net-games/utilities` | [📖 `README.md`](net-games/utilities/README.md) | README.md |
| `persistence` | [📖 `README.md`](persistence/README.md) | README.md |
| `player-control` | [📖 `README.md`](player-control/README.md) | 🎮 Scoped engine capture, menu focus and native-dialog handoffs |
| `utils` | [📖 `README.md`](utils/README.md) | Async, EventEmitter & Utility Modules |

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📂 Folder | `advertise_server/` | 4 | 42 | 32 | — | [Open folder index](advertise_server/index.md) |
| 📂 Folder | `animation-engine/` | 4 | 150 | 57 | — | [Open folder index](animation-engine/index.md) |
| 📂 Folder | `assets/` | 23 | 172 | 49 | — | [Open folder index](assets/index.md) |
| 📂 Folder | `avatar_utils/` | 9 | 48 | 41 | — | [Open folder index](avatar_utils/index.md) |
| 📂 Folder | `boom/` | 1 | 16 | 8 | — | [Open folder index](boom/index.md) |
| 📂 Folder | `bot/` | 1 | 8 | 2 | — | [Open folder index](bot/index.md) |
| 📂 Folder | `camera/` | 3 | 43 | 11 | — | [Open folder index](camera/index.md) |
| 📂 Folder | `color-picker/` | 1 | 2 | 44 | — | [Open folder index](color-picker/index.md) |
| 📂 Folder | `displayer/` | 10 | 371 | 250 | — | [Open folder index](displayer/index.md) |
| 📂 Folder | `encounters/` | 24 | 0 | 1734 | — | [Open folder index](encounters/index.md) |
| 📂 Folder | `enum/` | 4 | 20 | 22 | — | [Open folder index](enum/index.md) |
| 📂 Folder | `events/` | 2 | 140 | 65 | — | [Open folder index](events/index.md) |
| 📂 Folder | `ezlibs-custom/` | 49 | 491 | 432 | — | [Open folder index](ezlibs-custom/index.md) |
| 📂 Folder | `ezlibs-scripts/` | 73 | 1047 | 987 | — | [Open folder index](ezlibs-scripts/index.md) |
| 📂 Folder | `indy-trains/` | 1 | 13 | 142 | — | [Open folder index](indy-trains/index.md) |
| 📂 Folder | `input-controller/` | 4 | 66 | 58 | — | [Open folder index](input-controller/index.md) |
| 📂 Folder | `hp_manager/` | — | — | — | — | [Open folder index](hp_manager/index.md) |
| 📂 Folder | `jukebox/` | — | — | — | — | [Open folder index](jukebox/index.md) |
| 📂 Folder | `libs/` | 7 | 85 | 44 | — | [Open folder index](libs/index.md) |
| 📂 Folder | `logger/` | 1 | 56 | 20 | — | [Open folder index](logger/index.md) |
| 📂 Folder | `net-game-tourney/` | — | — | — | — | [Open folder index](net-game-tourney/index.md) |
| 📂 Folder | `net-games/` | 41 | 478 | 417 | — | [Open folder index](net-games/index.md) |
| 📂 Folder | `persistence/` | 3 | 45 | 23 | — | [Open folder index](persistence/index.md) |
| 📂 Folder | `real_daytime/` | — | — | — | — | [Open folder index](real_daytime/index.md) |
| 📂 Folder | `areas/` | — | — | — | — | [Open folder index](areas/index.md) |
| 📂 Folder | `player-control/` | 1 | — | — | — | [Open folder index](player-control/index.md) |
| 📂 Folder | `tests/` | 3 | 1 | 2 | — | [Open folder index](tests/index.md) |
| 📂 Folder | `utils/` | 3 | 33 | 30 | — | [Open folder index](utils/index.md) |
| 📄 Script | `animation_points_test.lua` | 1 | 1 | 2 | 22 | [Open script reference](animation_points_test/index.md) |
| 📄 Script | `example_pvp_script.disabled-lua` | 1 | 0 | 2 | 89 | [Open script reference](example_pvp_script/index.md) |
| 📄 Script | `ezlibs-config.lua` | 1 | 0 | 1 | 15 | [Open script reference](ezlibs-config/index.md) |
| 📄 Script | `flavor_text.lua` | 1 | 1 | 0 | 12 | [Open script reference](flavor_text/index.md) |
| 📄 Script | `run-gen.lua` | 1 | 0 | 0 | 2 | [Open script reference](run-gen/index.md) |
| 📄 Script | `simon-says.lua` | 1 | 12 | 10 | 517 | [Open script reference](simon-says/index.md) |
| 📄 Script | `world-attachment.lua` | 1 | 9 | 13 | 428 | [Open script reference](world-attachment/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `world-attachment.lua` | `WorldAttachment.quantize_map_offset(offset, options)` | 69 | [Details](world-attachment/index.md) |
| `world-attachment.lua` | `WorldAttachment.point_to_pixel_offset(frame, point)` | 120 | [Details](world-attachment/index.md) |
| `world-attachment.lua` | `WorldAttachment.pixel_offset_to_map(screen_offset, options)` | 204 | [Details](world-attachment/index.md) |
| `world-attachment.lua` | `WorldAttachment.point_to_map_offset(frame, point, options)` | 308 | [Details](world-attachment/index.md) |
| `world-attachment.lua` | `WorldAttachment.target_position(parent_position, map_offset, options)` | 369 | [Details](world-attachment/index.md) |
| `world-attachment.lua` | `WorldAttachment.follow_position(parent_position, screen_offset, options)` | 399 | [Details](world-attachment/index.md) |

## 📊 Collection summary

The original generated reference baseline contains **231 Lua source files**, **3132 baseline named/assigned function detections**, and **2701 baseline table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 🧭 Project coverage

The documentation set also covers Lua encounter definitions and battle-mod Lua found in the uploaded ZIP. These sources live outside the server `scripts/` tree.

- [⚔️ Encounter definitions](encounters/index.md)
- [🎮 Asset/battle-mod Lua](assets/index.md)
- [🧭 Current systems guide](CURRENT_SYSTEMS.md)
- [📋 Snapshot and changes](SNAPSHOT_REPORT.md)
- [🧾 Encounter field inventory](ENCOUNTER_FIELD_INVENTORY.md)

### Scope and source precedence

Each reference is regenerated from the uploaded snapshot. All project README files and authored guides are consolidated here under `_DOCUMENTATION/`. `LICENSE.md` notices remain with their original source packages. When an authored guide differs from current code, use the generated source references for exact APIs and fields.

### 2026-11-11 PlayerControl patch source precedence

The general historical static snapshot rows above were originally generated for an earlier archive, before HP Manager, Jukebox, Real Daytime and PlayerControl were added to this documentation library. For the patched source use the **new per-script reference pages** under these modules and the refreshed `camera/`, `input-controller/`, and `ezlibs-scripts/main/` references. The server scripts themselves were not altered by this documentation refresh.
