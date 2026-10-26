# Scripts Directory — Comprehensive Tree Reference

> **Scope and accuracy**

> Regenerated from the current `internal_test_server.zip` Library upload on 2026-10-25. This is an inventory of files under `scripts/`; roles and dependencies are described only where supported by source comments and code. Static inspection is not live runtime testing.

## Contents

- Lua source files: **230**
- Non-documentation files under `scripts/`: **269**
- [Documentation index](index.md)
- [Assets and File Paths](assets-and-file-paths.md)
- [Per-Script Reference Library](script-reference/README.md)

## `./`

- `animation_points_test.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/animation_points_test.lua.md)).
- `cosmo.lua` — [[ ([source reference](script-reference/cosmo.lua.md)).
- `example_pvp_script.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/example_pvp_script.lua.md)).
- `run-gen.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/run-gen.lua.md)).
- `run-tests.lua` — Name of files to run. These should be the file name (without the extension) The scripts in the test_list must be located in "scripts/test-runner/tests/" ([source reference](script-reference/run-tests.lua.md)).
- `simon-says.lua` — [[ ([source reference](script-reference/simon-says.lua.md)).
- `world-attachment.lua` — Shared world-attachment coordinate helpers for NetGames and FootBomb. This module intentionally contains only coordinate math. It does not create ([source reference](script-reference/world-attachment.lua.md)).

## `HP_Manager`

- `HP_Manager/background_manage.lua` — [[ ([source reference](script-reference/HP_Manager/background_manage.lua.md)).
- `HP_Manager/main.lua` — [[ ([source reference](script-reference/HP_Manager/main.lua.md)).
- `HP_Manager/realtime_manage.lua` — [[ ([source reference](script-reference/HP_Manager/realtime_manage.lua.md)).
- `HP_Manager/warp_manage.lua` — [[ ([source reference](script-reference/HP_Manager/warp_manage.lua.md)).

## `HP_Manager/constants`

- `HP_Manager/constants/constants.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/HP_Manager/constants/constants.lua.md)).

## `HP_Manager/data`

- `HP_Manager/data/background_data.dat` — non-Lua source/configuration/resource file.
- `HP_Manager/data/realtime_data.dat` — non-Lua source/configuration/resource file.
- `HP_Manager/data/warp_data.dat` — non-Lua source/configuration/resource file.

## `HP_Manager/extensions`

- `HP_Manager/extensions/extensions.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/HP_Manager/extensions/extensions.lua.md)).

## `animation-engine`

- `animation-engine/README.md` — non-Lua source/configuration/resource file.
- `animation-engine/animation-engine.lua` — Reusable animation and interpolation engine. Hardened for server UI use: all timing is driven by Net tick delta_time. ([source reference](script-reference/animation-engine/animation-engine.lua.md)).
- `animation-engine/animation-enums.lua` — animation-enums.lua (enhanced) ([source reference](script-reference/animation-engine/animation-enums.lua.md)).
- `animation-engine/animation-sequences.lua` — animation-sequences.lua General purpose animation sequences that mimic duels.lua behaviors ([source reference](script-reference/animation-engine/animation-sequences.lua.md)).
- `animation-engine/math-utils.lua` — math-utils.lua Reusable mathematical and easing functions ([source reference](script-reference/animation-engine/math-utils.lua.md)).

## `avatar_registry`

- `avatar_registry/main.lua` — [[ ([source reference](script-reference/avatar_registry/main.lua.md)).

## `avatar_utils`

- `avatar_utils/avatar_utils.lua` — avatar_utils.lua Utility functions for handling player avatars and mugshots ([source reference](script-reference/avatar_utils/avatar_utils.lua.md)).
- `avatar_utils/base64.lua` — [[ ([source reference](script-reference/avatar_utils/base64.lua.md)).
- `avatar_utils/main.lua` — NaviSpot.lua Module to cache player and bot avatar/mugshot assets. ([source reference](script-reference/avatar_utils/main.lua.md)).

## `avatar_utils/lua_yes_parser`

- `avatar_utils/lua_yes_parser/.gitignore` — non-Lua source/configuration/resource file.
- `avatar_utils/lua_yes_parser/README.md` — non-Lua source/configuration/resource file.
- `avatar_utils/lua_yes_parser/lib.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/avatar_utils/lua_yes_parser/lib.lua.md)).

## `avatar_utils/lua_yes_parser/example`

- `avatar_utils/lua_yes_parser/example/doc.cut` — non-Lua source/configuration/resource file.
- `avatar_utils/lua_yes_parser/example/main.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/avatar_utils/lua_yes_parser/example/main.lua.md)).

## `avatar_utils/lua_yes_parser/legal`

- `avatar_utils/lua_yes_parser/legal/LICENSE.md` — non-Lua source/configuration/resource file.

## `avatar_utils/lua_yes_parser/spec`

- `avatar_utils/lua_yes_parser/spec/README.md` — non-Lua source/configuration/resource file.

## `avatar_utils/lua_yes_parser/src`

- `avatar_utils/lua_yes_parser/src/element.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/avatar_utils/lua_yes_parser/src/element.lua.md)).
- `avatar_utils/lua_yes_parser/src/enums.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/avatar_utils/lua_yes_parser/src/enums.lua.md)).
- `avatar_utils/lua_yes_parser/src/keyval.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/avatar_utils/lua_yes_parser/src/keyval.lua.md)).

## `avatar_utils/lua_yes_parser/src/utils`

- `avatar_utils/lua_yes_parser/src/utils/trim.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/avatar_utils/lua_yes_parser/src/utils/trim.lua.md)).
- `avatar_utils/lua_yes_parser/src/utils/trim.luaZone.Identifier` — non-Lua source/configuration/resource file.

## `boom`

- `boom/main.lua` — [[@module boom ([source reference](script-reference/boom/main.lua.md)).

## `camera`

- `camera/README.md` — non-Lua source/configuration/resource file.
- `camera/camera-controller.lua` — camera-controller.lua Unified camera controller with mode-based input handling. ([source reference](script-reference/camera/camera-controller.lua.md)).
- `camera/camera-manager.lua` — CameraManager.lua ([source reference](script-reference/camera/camera-manager.lua.md)).
- `camera/main.lua` — main.lua (Entry Point) ([source reference](script-reference/camera/main.lua.md)).

## `color-picker`

- `color-picker/color-picker.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/color-picker/color-picker.lua.md)).

## `displayer`

- `displayer/displayer.lua` — [[ ([source reference](script-reference/displayer/displayer.lua.md)).
- `displayer/font-system.lua` — [[ ([source reference](script-reference/displayer/font-system.lua.md)).
- `displayer/nameplate.lua` — [[ ([source reference](script-reference/displayer/nameplate.lua.md)).
- `displayer/readme.md` — non-Lua source/configuration/resource file.
- `displayer/scrolling-sprite-list.lua` — [[ ([source reference](script-reference/displayer/scrolling-sprite-list.lua.md)).
- `displayer/scrolling-text-list.lua` — [[ ([source reference](script-reference/displayer/scrolling-text-list.lua.md)).
- `displayer/sliced-sprite.lua` — scripts/displayer/sliced-sprite.lua Reusable 3-slice, configurable 5-slice, and 9-slice sprite rendering. ([source reference](script-reference/displayer/sliced-sprite.lua.md)).
- `displayer/text-display.lua` — Unified text renderer for static text, marquee text, and BN-style typewriter boxes. Public coordinates are virtual 240x160 coordinates. ([source reference](script-reference/displayer/text-display.lua.md)).
- `displayer/text-layout.lua` — Public text measurement/layout helper for Displayer. All input and output coordinates are virtual 240x160 coordinates. ([source reference](script-reference/displayer/text-layout.lua.md)).
- `displayer/timer-display.lua` — [[ ([source reference](script-reference/displayer/timer-display.lua.md)).
- `displayer/timer-system.lua` — Timer System with Global and Player-specific Timers ([source reference](script-reference/displayer/timer-system.lua.md)).

## `enum`

- `enum/enum.lua` — enum.lua A reusable Lua 5.2 module for creating enum-like tables. ([source reference](script-reference/enum/enum.lua.md)).
- `enum/enumset.lua` — enumset.lua A container that holds multiple enums and returns a fresh copy ([source reference](script-reference/enum/enumset.lua.md)).
- `enum/main.lua` — main.lua Example of how to use the modules. ([source reference](script-reference/enum/main.lua.md)).
- `enum/predefined-enums.lua` — predefined_enums.lua Central place to define your enums for easy reuse. ([source reference](script-reference/enum/predefined-enums.lua.md)).

## `events`

- `events/eznpcs_onceitem.lua` — scripts/events/eznpcs_onceitem.lua Dialogue Type "onceitem": unique, server-wide rental with renewals ([source reference](script-reference/events/eznpcs_onceitem.lua.md)).

## `ezlibs-custom`

- `ezlibs-custom/custom.lua` — Custom plugin aggregator. Keep custom gameplay modules here so ezlibs' main dispatcher can fan out ([source reference](script-reference/ezlibs-custom/custom.lua.md)).

## `ezlibs-custom/endless-runner`

- `ezlibs-custom/endless-runner/endless-runner.lua` — [[ ([source reference](script-reference/ezlibs-custom/endless-runner/endless-runner.lua.md)).

## `ezlibs-custom/footbomb`

- `ezlibs-custom/footbomb/README.md` — non-Lua source/configuration/resource file.
- `ezlibs-custom/footbomb/animation_diagnostics.lua` — Startup diagnostics for FootBomb's active v2.0 Navi animations and their optional v2.5 .ani counterparts. This module is read-only: it never changes ([source reference](script-reference/ezlibs-custom/footbomb/animation_diagnostics.lua.md)).
- `ezlibs-custom/footbomb/animation_points.lua` — Backwards-compatible FootBomb animation-point helpers. Coordinate conversion is implemented centrally by world-attachment.lua so ([source reference](script-reference/ezlibs-custom/footbomb/animation_points.lua.md)).
- `ezlibs-custom/footbomb/animation_states.lua` — Animation states shared by FootBomb's Navi assets. These names are intentionally centralized: update the roster animation ([source reference](script-reference/ezlibs-custom/footbomb/animation_states.lua.md)).
- `ezlibs-custom/footbomb/bomb_options.lua` — Ball skins currently used by the selection UI (gameplay wiring is pending). ([source reference](script-reference/ezlibs-custom/footbomb/bomb_options.lua.md)).
- `ezlibs-custom/footbomb/constants.lua` — FootBomb configuration. Keep values grouped by responsibility so UI, assets, input, and match tuning ([source reference](script-reference/ezlibs-custom/footbomb/constants.lua.md)).
- `ezlibs-custom/footbomb/main.lua` — FootBomb Controller and match-instance entry point. Loaded by scripts/ezlibs-scripts/main.lua through custom.lua. ([source reference](script-reference/ezlibs-custom/footbomb/main.lua.md)).
- `ezlibs-custom/footbomb/navi_options.lua` — Selectable Navi roster. Each entry references shared paths and state names. ([source reference](script-reference/ezlibs-custom/footbomb/navi_options.lua.md)).
- `ezlibs-custom/footbomb/result_timeline.lua` — Pure timing helpers for FootBomb's result sequence. This module deliberately does not animate actors or wait on async tasks; ([source reference](script-reference/ezlibs-custom/footbomb/result_timeline.lua.md)).
- `ezlibs-custom/footbomb/sfx_driver.lua` — Sound driver for FootBomb round events. Reacts to semantic round events by playing sounds. All timing lives in the ([source reference](script-reference/ezlibs-custom/footbomb/sfx_driver.lua.md)).
- `ezlibs-custom/footbomb/state.lua` — FootBomb state store. Mutable match/NPC/player registries live here instead of in the entry point. ([source reference](script-reference/ezlibs-custom/footbomb/state.lua.md)).

## `ezlibs-custom/nebulous-liberations`

- `ezlibs-custom/nebulous-liberations/.git` — non-Lua source/configuration/resource file.
- `ezlibs-custom/nebulous-liberations/README.md` — non-Lua source/configuration/resource file.
- `ezlibs-custom/nebulous-liberations/main.lua` — main.lua Nebulous Liberations ezlibs custom plugin entry point. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/main.lua.md)).
- `ezlibs-custom/nebulous-liberations/player.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/player.lua.md)).

## `ezlibs-custom/nebulous-liberations/liberations`

- `ezlibs-custom/nebulous-liberations/liberations/ability.lua` — ability.lua ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/ability.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/camera_sequence.lua` — camera_sequence.lua ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/camera_sequence.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/constants.lua` — constants.lua Centralised definitions for custom properties and constants used in liberations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/constants.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/enemy.lua` — enemy.lua ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemy.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua` — enemy_templates.lua ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/instance.lua` — instance.lua ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/instance.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/loot.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/loot.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/panel_registry.lua` — panel_registry.lua ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/panel_registry.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/player_selection.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/player_selection.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/player_session.lua` — player_session.lua ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/player_session.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/preloader.lua` — preloader.lua ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/preloader.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/selection.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/selection.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/validation.lua` — validation.lua ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/validation.lua.md)).

## `ezlibs-custom/nebulous-liberations/liberations/enemies`

- `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua.md)).
- `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua.md)).

## `ezlibs-custom/nebulous-liberations/spirits`

- `ezlibs-custom/nebulous-liberations/spirits/todo.md` — non-Lua source/configuration/resource file.

## `ezlibs-custom/nebulous-liberations/utils`

- `ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua.md)).
- `ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua.md)).
- `ezlibs-custom/nebulous-liberations/utils/parties.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/utils/parties.lua.md)).
- `ezlibs-custom/nebulous-liberations/utils/recover_effect.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-custom/nebulous-liberations/utils/recover_effect.lua.md)).

## `ezlibs-scripts`

- `ezlibs-scripts/.gitignore` — non-Lua source/configuration/resource file.
- `ezlibs-scripts/announcements_feed.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/announcements_feed.lua.md)).
- `ezlibs-scripts/condition.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/condition.lua.md)).
- `ezlibs-scripts/direction.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/direction.lua.md)).
- `ezlibs-scripts/ezannounce.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezannounce.lua.md)).
- `ezlibs-scripts/ezbattle_results.lua` — Stores the most recent battle_results payload per player so later lifecycle events (such as battle_exit) can inspect or consume it. ([source reference](script-reference/ezlibs-scripts/ezbattle_results.lua.md)).
- `ezlibs-scripts/ezbbs.lua` — ezbbs.lua - Bulletin Board System for ezlibs Handles board interaction, posting, pinning, deleting. ([source reference](script-reference/ezlibs-scripts/ezbbs.lua.md)).
- `ezlibs-scripts/ezbus.lua` — ezbus.lua - Named event-bus registry. Three usage modes are supported: ([source reference](script-reference/ezlibs-scripts/ezbus.lua.md)).
- `ezlibs-scripts/ezbuttons.lua` — ezbuttons.lua Creates trigger-based buttons (non-solid NPCs). ([source reference](script-reference/ezlibs-scripts/ezbuttons.lua.md)).
- `ezlibs-scripts/ezcache.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezcache.lua.md)).
- `ezlibs-scripts/ezcheckpoints.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezcheckpoints.lua.md)).
- `ezlibs-scripts/ezchristmas.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezchristmas.lua.md)).
- `ezlibs-scripts/ezconfig.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezconfig.lua.md)).
- `ezlibs-scripts/ezemail.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezemail.lua.md)).
- `ezlibs-scripts/ezemitter.lua` — EventEmitter.lua A flexible event system with async capabilities. ([source reference](script-reference/ezlibs-scripts/ezemitter.lua.md)).
- `ezlibs-scripts/ezexplosions.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezexplosions.lua.md)).
- `ezlibs-scripts/ezfarms.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezfarms.lua.md)).
- `ezlibs-scripts/ezlibs-tiled-reference.md` — non-Lua source/configuration/resource file.
- `ezlibs-scripts/ezlibs-tiled-schema.lua` — Auto-generated by generate-ezlibs-tiled.lua. Do not edit by hand. ([source reference](script-reference/ezlibs-scripts/ezlibs-tiled-schema.lua.md)).
- `ezlibs-scripts/ezlibs-types.json` — non-Lua source/configuration/resource file.
- `ezlibs-scripts/ezlocks.lua` — ezlocks.lua - Reusable lock/unlock behaviors ([source reference](script-reference/ezlibs-scripts/ezlocks.lua.md)).
- `ezlibs-scripts/ezlogger.lua` — ezlogger.lua Shared append-only JSONL logging for ezlibs modules. ([source reference](script-reference/ezlibs-scripts/ezlogger.lua.md)).
- `ezlibs-scripts/ezmail.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezmail.lua.md)).
- `ezlibs-scripts/ezmapinstance.lua` — ezmapinstance.lua Reusable map cloning, instance ownership, host/party metadata, and lifecycle. ([source reference](script-reference/ezlibs-scripts/ezmapinstance.lua.md)).
- `ezlibs-scripts/ezmemory.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezmemory.lua.md)).
- `ezlibs-scripts/ezmenus.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezmenus.lua.md)).
- `ezlibs-scripts/ezmystery.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezmystery.lua.md)).
- `ezlibs-scripts/ezpress.lua` — ezpress.lua Player compression/decompression driven by Tiled object properties and area ([source reference](script-reference/ezlibs-scripts/ezpress.lua.md)).
- `ezlibs-scripts/ezquests.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezquests.lua.md)).
- `ezlibs-scripts/ezrushroads.lua` — ezrushroads.lua Rush Roads minigame integrated with ezlibs ([source reference](script-reference/ezlibs-scripts/ezrushroads.lua.md)).
- `ezlibs-scripts/ezusers.lua` — ezusers.lua A flexible user/role/permission system for your server. ([source reference](script-reference/ezlibs-scripts/ezusers.lua.md)).
- `ezlibs-scripts/ezweather.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezweather.lua.md)).
- `ezlibs-scripts/generate-ezlibs-tiled.lua` — generate-ezlibs-tiled.lua Generates three artifacts from a single source of truth: ([source reference](script-reference/ezlibs-scripts/generate-ezlibs-tiled.lua.md)).
- `ezlibs-scripts/helpers.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/helpers.lua.md)).
- `ezlibs-scripts/json.lua` — json.lua Copyright (c) 2020 rxi ([source reference](script-reference/ezlibs-scripts/json.lua.md)).
- `ezlibs-scripts/main.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/main.lua.md)).
- `ezlibs-scripts/object_registry.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/object_registry.lua.md)).
- `ezlibs-scripts/readme.md` — non-Lua source/configuration/resource file.
- `ezlibs-scripts/sha256.lua` — ------------------------------------------------------------------------------------------------------------------------ sha2.lua ([source reference](script-reference/ezlibs-scripts/sha256.lua.md)).
- `ezlibs-scripts/urlencode.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/urlencode.lua.md)).

## `ezlibs-scripts/avatar_utils`

- `ezlibs-scripts/avatar_utils/avatar_utils.lua` — avatar_utils.lua Utility functions for handling player avatars and mugshots ([source reference](script-reference/ezlibs-scripts/avatar_utils/avatar_utils.lua.md)).
- `ezlibs-scripts/avatar_utils/base64.lua` — [[ ([source reference](script-reference/ezlibs-scripts/avatar_utils/base64.lua.md)).
- `ezlibs-scripts/avatar_utils/main.lua` — NaviSpot.lua Module to cache player and bot avatar/mugshot assets. ([source reference](script-reference/ezlibs-scripts/avatar_utils/main.lua.md)).

## `ezlibs-scripts/avatar_utils/lua_yes_parser`

- `ezlibs-scripts/avatar_utils/lua_yes_parser/README.md` — non-Lua source/configuration/resource file.
- `ezlibs-scripts/avatar_utils/lua_yes_parser/lib.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/avatar_utils/lua_yes_parser/lib.lua.md)).

## `ezlibs-scripts/avatar_utils/lua_yes_parser/src`

- `ezlibs-scripts/avatar_utils/lua_yes_parser/src/element.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/avatar_utils/lua_yes_parser/src/element.lua.md)).
- `ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/avatar_utils/lua_yes_parser/src/enums.lua.md)).
- `ezlibs-scripts/avatar_utils/lua_yes_parser/src/keyval.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/avatar_utils/lua_yes_parser/src/keyval.lua.md)).

## `ezlibs-scripts/avatar_utils/lua_yes_parser/src/utils`

- `ezlibs-scripts/avatar_utils/lua_yes_parser/src/utils/trim.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/avatar_utils/lua_yes_parser/src/utils/trim.lua.md)).
- `ezlibs-scripts/avatar_utils/lua_yes_parser/src/utils/trim.luaZone.Identifier` — non-Lua source/configuration/resource file.

## `ezlibs-scripts/ezannounce`

- `ezlibs-scripts/ezannounce/announcements_feed.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezannounce/announcements_feed.lua.md)).
- `ezlibs-scripts/ezannounce/ezannounce.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezannounce/ezannounce.lua.md)).

## `ezlibs-scripts/ezcutscenes`

- `ezlibs-scripts/ezcutscenes/ezcutscenes.lua` — ezcutscenes.lua Tiled-authored cutscene system. ([source reference](script-reference/ezlibs-scripts/ezcutscenes/ezcutscenes.lua.md)).
- `ezlibs-scripts/ezcutscenes/step_types.lua` — ezcutscenes/step_types.lua Step implementations. Each handler is ([source reference](script-reference/ezlibs-scripts/ezcutscenes/step_types.lua.md)).

## `ezlibs-scripts/ezencounters`

- `ezlibs-scripts/ezencounters/main.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezencounters/main.lua.md)).

## `ezlibs-scripts/eznpcs`

- `ezlibs-scripts/eznpcs/dialogue_types.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/eznpcs/dialogue_types.lua.md)).
- `ezlibs-scripts/eznpcs/eznpcs.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/eznpcs/eznpcs.lua.md)).
- `ezlibs-scripts/eznpcs/ezpushback.lua` — ezpushback.lua A Pushback NPC uses the regular eznpcs NPC pipeline, with a moving rectangle ([source reference](script-reference/ezlibs-scripts/eznpcs/ezpushback.lua.md)).
- `ezlibs-scripts/eznpcs/npc_behaviors.lua` — npc_behaviors.lua Composable behavior objects for eznpcs. ([source reference](script-reference/ezlibs-scripts/eznpcs/npc_behaviors.lua.md)).

## `ezlibs-scripts/eztriggers`

- `ezlibs-scripts/eztriggers/ezbottriggers.lua` — ezbottriggers.lua Bot-only variant of eztriggers. ([source reference](script-reference/ezlibs-scripts/eztriggers/ezbottriggers.lua.md)).
- `ezlibs-scripts/eztriggers/eztriggers.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/eztriggers/eztriggers.lua.md)).

## `ezlibs-scripts/ezwarps`

- `ezlibs-scripts/ezwarps/arrow_animation_factory.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezwarps/arrow_animation_factory.lua.md)).
- `ezlibs-scripts/ezwarps/fall_in_animation.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezwarps/fall_in_animation.lua.md)).
- `ezlibs-scripts/ezwarps/fall_off_2.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezwarps/fall_off_2.lua.md)).
- `ezlibs-scripts/ezwarps/lev_beast_in_animation.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezwarps/lev_beast_in_animation.lua.md)).
- `ezlibs-scripts/ezwarps/lev_beast_out_animation.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezwarps/lev_beast_out_animation.lua.md)).
- `ezlibs-scripts/ezwarps/log_in_animation.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezwarps/log_in_animation.lua.md)).
- `ezlibs-scripts/ezwarps/main.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/ezlibs-scripts/ezwarps/main.lua.md)).

## `ezlibs-scripts/tests`

- `ezlibs-scripts/tests/test_utilities.lua` — Run from the package root with: lua tests/test_utilities.lua ([source reference](script-reference/ezlibs-scripts/tests/test_utilities.lua.md)).

## `ezlibs-scripts/utils`

- `ezlibs-scripts/utils/README.md` — non-Lua source/configuration/resource file.
- `ezlibs-scripts/utils/ezdebug.lua` — ezdebug.lua Small logger wrapper. By default it writes to standard output. ([source reference](script-reference/ezlibs-scripts/utils/ezdebug.lua.md)).
- `ezlibs-scripts/utils/eztiledutils.lua` — tiled_utils.lua Shared helpers for Tiled property access. ([source reference](script-reference/ezlibs-scripts/utils/eztiledutils.lua.md)).
- `ezlibs-scripts/utils/ezutil.lua` — ezutil.lua Small, dependency-free helpers for Lua 5.2. ([source reference](script-reference/ezlibs-scripts/utils/ezutil.lua.md)).
- `ezlibs-scripts/utils/ezvalidate.lua` — ezvalidate.lua Dependency-free validation helpers for Lua 5.2. ([source reference](script-reference/ezlibs-scripts/utils/ezvalidate.lua.md)).

## `indy-trains`

- `indy-trains/main.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/indy-trains/main.lua.md)).

## `input-controller`

- `input-controller/README.md` — non-Lua source/configuration/resource file.
- `input-controller/buttons.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/input-controller/buttons.lua.md)).
- `input-controller/d-pad.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/input-controller/d-pad.lua.md)).
- `input-controller/input-controller.lua` — input-controller.lua Unified sticky-state input controller with release/repeat edges and UI handoff guards. ([source reference](script-reference/input-controller/input-controller.lua.md)).
- `input-controller/main.lua` — main.lua – Unified input API Keep one API registry and one set of Net event handlers if this module is ([source reference](script-reference/input-controller/main.lua.md)).

## `jukebox`

- `jukebox/main.lua` — [[ ([source reference](script-reference/jukebox/main.lua.md)).
- `jukebox/utils.lua` — utils.lua Helper functions for OS detection, file listing, and string splitting. ([source reference](script-reference/jukebox/utils.lua.md)).

## `jukebox/constants`

- `jukebox/constants/paths.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/jukebox/constants/paths.lua.md)).
- `jukebox/constants/ui-data.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/jukebox/constants/ui-data.lua.md)).

## `libs`

- `libs/direction.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/libs/direction.lua.md)).
- `libs/emotes.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/libs/emotes.lua.md)).
- `libs/emotions.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/libs/emotions.lua.md)).
- `libs/encounters.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/libs/encounters.lua.md)).
- `libs/enums.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/libs/enums.lua.md)).
- `libs/json.lua` — json.lua Copyright (c) 2020 rxi ([source reference](script-reference/libs/json.lua.md)).

## `libs/stardust`

- `libs/stardust/LICENSE.md` — non-Lua source/configuration/resource file.
- `libs/stardust/README.md` — non-Lua source/configuration/resource file.
- `libs/stardust/core.lua` — [[ ([source reference](script-reference/libs/stardust/core.lua.md)).

## `logger`

- `logger/logger.lua` — logger.lua – Flexible logging module with per‑logger configuration. Uses append‑only JSON Lines format – each entry is written as a new line. ([source reference](script-reference/logger/logger.lua.md)).

## `net-game-tourney`

- `net-game-tourney/main.lua` — main.lua ([source reference](script-reference/net-game-tourney/main.lua.md)).
- `net-game-tourney/readme.md` — non-Lua source/configuration/resource file.
- `net-game-tourney/tournament-constants.lua` — tournament-constants.lua ([source reference](script-reference/net-game-tourney/tournament-constants.lua.md)).
- `net-game-tourney/tournament-core.lua` — tournament-core.lua ([source reference](script-reference/net-game-tourney/tournament-core.lua.md)).
- `net-game-tourney/tournament-flow.lua` — tournament-flow.lua ([source reference](script-reference/net-game-tourney/tournament-flow.lua.md)).
- `net-game-tourney/tournament-manager.lua` — tournament-manager.lua ([source reference](script-reference/net-game-tourney/tournament-manager.lua.md)).
- `net-game-tourney/tournament-npcs.lua` — tournament-npcs.lua ([source reference](script-reference/net-game-tourney/tournament-npcs.lua.md)).
- `net-game-tourney/tournament-state.lua` — tournament-state.lua Central state store for all tournament data. ([source reference](script-reference/net-game-tourney/tournament-state.lua.md)).
- `net-game-tourney/tournament-ui.lua` — tournament-ui.lua ([source reference](script-reference/net-game-tourney/tournament-ui.lua.md)).
- `net-game-tourney/ui-pos.lua` — ui-pos.lua ([source reference](script-reference/net-game-tourney/ui-pos.lua.md)).

## `net-games`

- `net-games/UI-SUPPRESSION.md` — non-Lua source/configuration/resource file.
- `net-games/bn-textbox.lua` — bn_textbox.lua Simple BN-style text box with typewriter, optional nameplate, mugshot, and backdrop. ([source reference](script-reference/net-games/bn-textbox.lua.md)).
- `net-games/layout-manager.lua` — layout_manager.lua A comprehensive layout system for managing sprites, resources, and animations. ([source reference](script-reference/net-games/layout-manager.lua.md)).
- `net-games/main.lua` — [[ ([source reference](script-reference/net-games/main.lua.md)).
- `net-games/readme.md` — non-Lua source/configuration/resource file.
- `net-games/ui-safe.lua` — scripts/net-games/ui-safe.lua Small hardened sprite helper for reusable net-games UI. ([source reference](script-reference/net-games/ui-safe.lua.md)).
- `net-games/ui-suppression-examples.lua` — Usage examples for scripts/net-games/ui-suppression.lua. This file is documentation only; it is not required by the framework. ([source reference](script-reference/net-games/ui-suppression-examples.lua.md)).
- `net-games/ui-suppression.lua` — Shared reference-counted suppression for engine HUD, engine input lock, and custom UI handlers. Engine HUD is separate from all sprites/text/panels created by our UI scripts. ([source reference](script-reference/net-games/ui-suppression.lua.md)).

## `net-games/dialogue`

- `net-games/dialogue/constants.lua` — scripts/net-games/dialogue/constants.lua ([source reference](script-reference/net-games/dialogue/constants.lua.md)).
- `net-games/dialogue/dialogue.lua` — scripts/net-games/dialogue/dialogue.lua Hardened net-games dialogue lifecycle. ([source reference](script-reference/net-games/dialogue/dialogue.lua.md)).
- `net-games/dialogue/prompt.lua` — scripts/net-games/dialogue/prompt.lua Hardened YES/NO prompt using the public TextLayout service. ([source reference](script-reference/net-games/dialogue/prompt.lua.md)).
- `net-games/dialogue/prompt_vertical.lua` — scripts/net-games/dialogue/prompt_vertical.lua Vertical menu prompt helper for net-games Dialogue (adapted to new displayer) ([source reference](script-reference/net-games/dialogue/prompt_vertical.lua.md)).
- `net-games/dialogue/startup.lua` — server/scripts/net-games/dialogue/startup.lua print("[net-games dialogue/startup] LOADING...") ([source reference](script-reference/net-games/dialogue/startup.lua.md)).

## `net-games/helpers`

- `net-games/helpers/net-helpers.lua` — ===================================================== scripts/net-games/helpers/net-helpers.lua ([source reference](script-reference/net-games/helpers/net-helpers.lua.md)).

## `net-games/menuAPI`

- `net-games/menuAPI/README.md` — non-Lua source/configuration/resource file.
- `net-games/menuAPI/main.lua` — scripts/net-games/menuAPI/main.lua Reusable BN-style menu layer for net-games. ([source reference](script-reference/net-games/menuAPI/main.lua.md)).

## `net-games/navi-emotes`

- `net-games/navi-emotes/constants.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/net-games/navi-emotes/constants.lua.md)).
- `net-games/navi-emotes/navi-emotes.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/net-games/navi-emotes/navi-emotes.lua.md)).

## `net-games/npcs`

- `net-games/npcs/menu_options.lua` — scripts/net-games/npcs/menu_options.lua Purpose: Build PromptVertical option tables without loops/math in each NPC file. ([source reference](script-reference/net-games/npcs/menu_options.lua.md)).
- `net-games/npcs/npc_api.lua` — scripts/net-games/npcs/npc_api.lua Purpose: Remove NPC boilerplate (interaction wiring, busy guards, face-player, SFX helper). ([source reference](script-reference/net-games/npcs/npc_api.lua.md)).
- `net-games/npcs/prog_banner_dialogue.lua` — ===================================================== prog_banner_dialogue.lua ([source reference](script-reference/net-games/npcs/prog_banner_dialogue.lua.md)).
- `net-games/npcs/prog_basic_dialogue.lua` — ===================================================== prog_basic_dialogue.lua ([source reference](script-reference/net-games/npcs/prog_basic_dialogue.lua.md)).
- `net-games/npcs/prog_basic_freedraw.lua` — ===================================================== prog_basic_freedraw.lua ([source reference](script-reference/net-games/npcs/prog_basic_freedraw.lua.md)).
- `net-games/npcs/prog_basic_nameplate.lua` — ===================================================== prog_basic_nameplate_dialogue.lua ([source reference](script-reference/net-games/npcs/prog_basic_nameplate.lua.md)).
- `net-games/npcs/prog_dramatic_dialogue.lua` — ===================================================== prog_dramatic_dialogue.lua ([source reference](script-reference/net-games/npcs/prog_dramatic_dialogue.lua.md)).
- `net-games/npcs/prog_dyed_dialogue(bak).lua` — ===================================================== prog_dyed_dialogue.lua ([source reference](script-reference/net-games/npcs/prog_dyed_dialogue(bak).lua.md)).
- `net-games/npcs/prog_dyed_dialogue.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/net-games/npcs/prog_dyed_dialogue.lua.md)).
- `net-games/npcs/prog_prompt_dialogue.lua` — ===================================================== prog_prompt_dialogue_shared_box.lua ([source reference](script-reference/net-games/npcs/prog_prompt_dialogue.lua.md)).
- `net-games/npcs/prog_prompt_dialogue_2.lua` — ===================================================== prog_prompt_dialogue_2.lua ([source reference](script-reference/net-games/npcs/prog_prompt_dialogue_2.lua.md)).
- `net-games/npcs/prog_shop.lua` — ===================================================== prog_shop.lua ([source reference](script-reference/net-games/npcs/prog_shop.lua.md)).
- `net-games/npcs/prog_talk_colors.lua` — ===================================================== prog_talk_colors.lua ([source reference](script-reference/net-games/npcs/prog_talk_colors.lua.md)).
- `net-games/npcs/prog_talk_dialogue.lua` — ===================================================== prog_talk_dialogue.lua ([source reference](script-reference/net-games/npcs/prog_talk_dialogue.lua.md)).
- `net-games/npcs/prog_vert_prompt.lua` — ===================================================== prog_vert_prompt.lua ([source reference](script-reference/net-games/npcs/prog_vert_prompt.lua.md)).
- `net-games/npcs/prog_vert_prompt_2.lua` — ===================================================== prog_vert_prompt_2.lua ([source reference](script-reference/net-games/npcs/prog_vert_prompt_2.lua.md)).
- `net-games/npcs/prog_vert_prompt_charcoal_grey.lua` — ===================================================== prog_vert_prompt_charcoal_grey.lua ([source reference](script-reference/net-games/npcs/prog_vert_prompt_charcoal_grey.lua.md)).
- `net-games/npcs/prog_vert_prompt_emerald.lua` — ===================================================== prog_vert_prompt_emerald_shop.lua ([source reference](script-reference/net-games/npcs/prog_vert_prompt_emerald.lua.md)).
- `net-games/npcs/prog_vert_prompt_lime.lua` — ===================================================== prog_vert_prompt_lime.lua ([source reference](script-reference/net-games/npcs/prog_vert_prompt_lime.lua.md)).
- `net-games/npcs/prog_vert_prompt_pink.lua` — ===================================================== prog_vert_prompt_pink.lua ([source reference](script-reference/net-games/npcs/prog_vert_prompt_pink.lua.md)).
- `net-games/npcs/prog_vert_prompt_red.lua` — ===================================================== prog_vert_prompt_red.lua ([source reference](script-reference/net-games/npcs/prog_vert_prompt_red.lua.md)).
- `net-games/npcs/prog_vert_prompt_sapphire.lua` — ===================================================== prog_vert_prompt_sapphire.lua ([source reference](script-reference/net-games/npcs/prog_vert_prompt_sapphire.lua.md)).
- `net-games/npcs/readme.md` — non-Lua source/configuration/resource file.
- `net-games/npcs/talk.lua` — ===================================================== talk.lua ([source reference](script-reference/net-games/npcs/talk.lua.md)).
- `net-games/npcs/talk_presets.lua` — ===================================================== talk_presets.lua ([source reference](script-reference/net-games/npcs/talk_presets.lua.md)).
- `net-games/npcs/talk_vert_menu.lua` — ===================================================== talk_vert_menu.lua ([source reference](script-reference/net-games/npcs/talk_vert_menu.lua.md)).

## `net-games/utilities`

- `net-games/utilities/README.md` — non-Lua source/configuration/resource file.
- `net-games/utilities/lockable-table.lua` — lockable_table.lua ([source reference](script-reference/net-games/utilities/lockable-table.lua.md)).

## `persistence`

- `persistence/README.md` — non-Lua source/configuration/resource file.
- `persistence/logger.lua` — logger.lua – Flexible logging module with per‑logger configuration. Uses append‑only JSON Lines format – each entry is written as a new line. ([source reference](script-reference/persistence/logger.lua.md)).
- `persistence/persistence.lua` — persistence.lua Persistent JSON file storage with automatic debounced saving and per‑file instance management. ([source reference](script-reference/persistence/persistence.lua.md)).
- `persistence/save-game.lua` — game_save.lua Extension of persistence.lua that provides a staging area for changes. ([source reference](script-reference/persistence/save-game.lua.md)).

## `real_daytime`

- `real_daytime/README.md` — non-Lua source/configuration/resource file.
- `real_daytime/main.lua` — [[ ([source reference](script-reference/real_daytime/main.lua.md)).

## `test-runner`

- `test-runner/expect.lua` — expect.lua A minimal assertion library for use with the test runner. ([source reference](script-reference/test-runner/expect.lua.md)).
- `test-runner/main.lua` — test-runner.lua Simple test runner for scripts in "scripts/tests/". ([source reference](script-reference/test-runner/main.lua.md)).

## `test-runner/tests`

- `test-runner/tests/demo.lua` — [[ ([source reference](script-reference/test-runner/tests/demo.lua.md)).

## `test-runner/tests/backups`

- `test-runner/tests/backups/test-inheritence-table-example.demo-lua` — non-Lua source/configuration/resource file.
- `test-runner/tests/backups/test-locking-tables-example.demo-lua` — non-Lua source/configuration/resource file.
- `test-runner/tests/backups/test-save-game.demo-lua` — non-Lua source/configuration/resource file.
- `test-runner/tests/backups/test.lua` — [[ ([source reference](script-reference/test-runner/tests/backups/test.lua.md)).
- `test-runner/tests/backups/tests.demo-lua` — non-Lua source/configuration/resource file.

## `tests`

- `tests/animation_points_test.lua` — Lua source file; see its source reference for dependencies and declarations. ([source reference](script-reference/tests/animation_points_test.lua.md)).

## `utils`

- `utils/README.md` — non-Lua source/configuration/resource file.
- `utils/async.lua` — Async.lua Async/await and Promise utilities for Lua ([source reference](script-reference/utils/async.lua.md)).
- `utils/event-emitter.lua` — EventEmitter.lua A flexible event system with async capabilities ([source reference](script-reference/utils/event-emitter.lua.md)).
- `utils/utility.lua` — Net.lua Main module that integrates EventEmitter and Async ([source reference](script-reference/utils/utility.lua.md)).

## Cross-module maintenance notes

- Import paths shown in per-script references are literal `require(...)` strings from source. Check package-root resolution in the runtime before moving modules.
- Event subscriptions and engine API calls are source inventories, not a guarantee that a particular script is loaded or that an engine member is available in every runtime version.
- Generated logs, test fixtures, backups, vendored libraries, and examples should not be treated as production entry points without checking their callers.
