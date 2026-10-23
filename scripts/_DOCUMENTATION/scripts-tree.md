# Scripts Directory — Comprehensive Tree Reference

> **Scope and accuracy**

> This reference is based on the `scripts/` tree in `internal_test_server.zip` from the Library (archive inspected 2026-10-23). Directory and file roles are described from filenames, source comments, imports, and included READMEs. It does not claim live runtime testing.

## Table of Contents

- [How to use this reference](#how-to-use-this-reference)
- [Top-level scripts](#top-level-scripts)
- [Directory-by-directory reference](#directory-by-directory-reference)
- [Cross-module notes](#cross-module-notes)
- [Maintenance notes](#maintenance-notes)

## How to use this reference

- Paths are relative to `scripts/` unless shown with a leading `/server/assets/` or another explicit root.
- `README.md`/`readme.md` files inside a module are its local guide; `scripts/_DOCUMENTATION/` is the consolidated documentation bundle.
- A folder can contain source, vendored code, examples, generated diagnostics, backups, or assets. The reference calls those out separately where identifiable.
- Every Lua file now also has an individual page in the [Per-Script Reference Library](script-reference/README.md). Existing subsystem references remain authoritative for deeper API details: [Animation Engine](animation-engine.md), [Displayer](displayer.md), [Enum](enum.md), [ezlibs Custom](ezlibs-custom.md), [ezlibs Scripts](ezlibs-scripts.md), [Net Games Tournament](net-games-tourney.md), and [Net Games](net-games.md).

## Top-level scripts

| Path | Role |
|---|---|
| `example_pvp_script.lua` | Example pvp script Lua module/script; see imports and callers for its concrete integration role. |
| `ezlibs-types.json` | JSON data/configuration file. |
| `run-gen.lua` | Run gen Lua module/script; see imports and callers for its concrete integration role. |
| `run-tests.lua` | Name of files to run. These should be the file name (without the extension) The scripts in the test_list must be located in "scripts/test-runner/tests/" "test-save-game", "test-inheritence-table-examp. |
| `simon-says.lua` | [[. |

## Directory-by-directory reference

### `scripts/_DEBUGGING/`

Runtime diagnostic output. Contains top-level example-PVP and Simon-Says logs; ezlibs module logs live under ezlibs-scripts/_DEBUGGING/<module>/. These are generated artifacts, not source APIs.

**Contents**

- `Example-PVP/` — subdirectory; see its own section below.
- `Simon-Says/` — subdirectory; see its own section below.

### `scripts/_DOCUMENTATION/`

Consolidated Markdown references for major script subsystems. The index links subsystem references; this directory now also contains the full script-tree and asset/path references.

**Contents**

- `animation-engine.md` — Module documentation / usage notes.
- `assets-and-file-paths.md` — Module documentation / usage notes.
- `displayer.md` — Module documentation / usage notes.
- `enum.md` — Module documentation / usage notes.
- `ezlibs-custom.md` — Module documentation / usage notes.
- `ezlibs-scripts.md` — Module documentation / usage notes.
- `index.md` — Module documentation / usage notes.
- `net-games-tourney.md` — Module documentation / usage notes.
- `net-games.md` — Module documentation / usage notes.
- `scripts-tree.md` — Module documentation / usage notes.

### `scripts/animation-engine/`

Reusable animation/interpolation engine, animation sequences, animation enums, and math/easing helpers. README.md documents its usage; the implementation states timing is driven by Net tick delta_time.

**Contents**

- `README.md` — Module documentation / usage notes.
- `animation-engine.lua` — Reusable animation and interpolation engine. Hardened for server UI use: all timing is driven by Net tick delta_time. No visible animation timing depends on os.clock().
- `animation-enums.lua` — animation-enums.lua (enhanced).
- `animation-sequences.lua` — animation-sequences.lua General purpose animation sequences that mimic duels.lua behaviors Works with any sprite_id and object properties Use the already‑loaded AnimationEngine from global.
- `math-utils.lua` — math-utils.lua Reusable mathematical and easing functions --------------------------------------------------------------------------- Core Math Functions ----------------------------------------------.

### `scripts/avatar_utils/`

Avatar utilities and base64 support, plus the bundled lua_yes_parser dependency (examples, legal/license text, parser source, specs, and small string utilities). There is a separate copy of avatar_utils under ezlibs-scripts.

**Contents**

- `lua_yes_parser/` — subdirectory; see its own section below.
- `avatar_utils.lua` — avatar_utils.lua Utility functions for handling player avatars and mugshots Helper: parse duration from .animation file (e.g., "10f" → 166ms).
- `base64.lua` — [[.
- `main.lua` — NaviSpot.lua Module to cache player and bot avatar/mugshot assets. For players: copies assets from engine to local files on avatar change. For bots: registers existing local asset paths (no copying). .

### `scripts/boom/`

Small shared effects/boom module used by the display stack; displayer requires scripts/boom/main.

**Contents**

- `main.lua` — [[.

### `scripts/camera/`

Camera controller/manager and initialization entry point. README describes the subsystem; FootBomb also imports camera-manager.

**Contents**

- `README.md` — Module documentation / usage notes.
- `camera-controller.lua` — camera-controller.lua Unified camera controller with mode-based input handling. Subscribes to the shared per-player InputController's emitter.  The camera applies its own repeat cadence to the shared .
- `camera-manager.lua` — CameraManager.lua.
- `main.lua` — main.lua (Entry Point).

### `scripts/color-picker/`

Color-picker UI/interaction module.

**Contents**

- `color-picker.lua` — Color picker Lua module/script; see imports and callers for its concrete integration role.

### `scripts/displayer/`

Shared display layer: fonts, text layout/display, timers, nameplates, scrolling text/sprite lists, sliced sprites, and facade. Its readme.md is the module-specific reference.

**Contents**

- `displayer.lua` — [[.
- `font-system.lua` — [[.
- `nameplate.lua` — [[.
- `readme.md` — Module documentation / usage notes.
- `scrolling-sprite-list.lua` — [[.
- `scrolling-text-list.lua` — [[.
- `sliced-sprite.lua` — scripts/displayer/sliced-sprite.lua  Reusable 3-slice, configurable 5-slice, and 9-slice sprite rendering. Also provides a text panel that combines slices with automatic text layout.  This module only.
- `text-display.lua` — Unified text renderer for static text, marquee text, and BN-style typewriter boxes. Public coordinates are virtual 240x160 coordinates. Hardened with deterministic marquee IDs, pixel-snapped updates, .
- `text-layout.lua` — Public text measurement/layout helper for Displayer. All input and output coordinates are virtual 240x160 coordinates.
- `timer-display.lua` — [[.
- `timer-system.lua` — Timer System with Global and Player-specific Timers.

### `scripts/enum/`

Enum, enum-set, predefined enums, and module entry point. Includes an enum.zip archive in the source tree.

**Contents**

- `enum.lua` — enum.lua A reusable Lua 5.2 module for creating enum-like tables. Supports custom key-value definitions, active value validation, and copying for independent instances. No external dependencies. Creat.
- `enum.zip` — Bundled archive present in the source tree; inspect before treating it as a runtime dependency.
- `enumset.lua` — enumset.lua A container that holds multiple enums and returns a fresh copy of an enum when accessed by key. Requires enum.lua Create a new EnumSet from a table of enums.
- `main.lua` — main.lua Example of how to use the modules. Create a set from the predefined enums.
- `predefined-enums.lua` — predefined_enums.lua Central place to define your enums for easy reuse. You can add as many as you like.

### `scripts/events/`

Large eznpcs once-item event script; event-oriented integration code rather than a directory-wide framework.

**Contents**

- `eznpcs_onceitem.lua` — scripts/events/eznpcs_onceitem.lua Dialogue Type "onceitem": unique, server-wide rental with renewals Dialogue Type "oncepass": renter sets/clears a visitor password for the HP checkpoint Dialogue Typ.

### `scripts/ezlibs-custom/`

Custom ezlibs plugin aggregator and custom game modules. custom.lua loads Nebulous Liberations and FootBomb for the ezlibs dispatcher.

**Contents**

- `footbomb/` — subdirectory; see its own section below.
- `nebulous-liberations/` — subdirectory; see its own section below.
- `custom.lua` — Custom plugin aggregator. Keep custom gameplay modules here so ezlibs' main dispatcher can fan out event callbacks to each module without duplicate Net:on subscriptions.

### `scripts/ezlibs-scripts/`

ezlibs shared server systems and plugin dispatcher: configuration, memory, objects, events, NPCs, triggers/buttons/checkpoints, warps, announcements, mail, farms, encounters, weather, logging, utilities, Tiled generation, and map instances. readme.md is the extensive module reference.

**Contents**

- `_DEBUGGING/` — subdirectory; see its own section below.
- `avatar_utils/` — subdirectory; see its own section below.
- `ezannounce/` — subdirectory; see its own section below.
- `ezencounters/` — subdirectory; see its own section below.
- `eznpcs/` — subdirectory; see its own section below.
- `ezwarps/` — subdirectory; see its own section below.
- `tests/` — subdirectory; see its own section below.
- `utils/` — subdirectory; see its own section below.
- `.gitignore` — Git ignore rules.
- `announcements_feed.lua` — Announcements feed Lua module/script; see imports and callers for its concrete integration role.
- `condition.lua` — Condition Lua module/script; see imports and callers for its concrete integration role.
- `direction.lua` — Direction Lua module/script; see imports and callers for its concrete integration role.
- `ezannounce.lua` — Ezannounce Lua module/script; see imports and callers for its concrete integration role.
- `ezbbs.lua` — ezbbs.lua - Bulletin Board System for ezlibs Handles board interaction, posting, pinning, deleting. Uses ezusers for permission checks. Board data stored in memory/board/<board_name>.json (path from e.
- `ezbus.lua` — ezbus.lua - Global event bus.
- `ezbuttons.lua` — ezbuttons.lua Creates trigger-based buttons (non-solid NPCs). Logical relationships are defined with groups and button/group effects. Supports five interaction behaviors: Pressure Plate, One-Time, Tog.
- `ezcache.lua` — Add a type to the cacheable set Check if an object type should be cached.
- `ezcheckpoints.lua` — Helper that actually unlocks the checkpoint (exposed as public API).
- `ezchristmas.lua` — Ezchristmas Lua module/script; see imports and callers for its concrete integration role.
- `ezconfig.lua` — Ezconfig Lua module/script; see imports and callers for its concrete integration role.
- `ezemail.lua` — tweak these.
- `ezemitter.lua` — EventEmitter.lua A flexible event system with async capabilities Create a new EventEmitter instance.
- `ezexplosions.lua` — Ezexplosions Lua module/script; see imports and callers for its concrete integration role.
- `ezfarms.lua` — Ezfarms Lua module/script; see imports and callers for its concrete integration role.
- `ezlocks.lua` — ezlocks.lua - Reusable lock/unlock behaviors Password check.
- `ezlogger.lua` — ezlogger.lua Shared append-only JSONL logging for ezlibs modules. Lua 5.2 compatible. Log files are written below: scripts/ezlibs-scripts/_DEBUGGING/<module>/  Default module log: debugging.log Player.
- `ezmail.lua` — tweak these.
- `ezmapinstance.lua` — ezmapinstance.lua Reusable map cloning, instance ownership, host/party metadata, and lifecycle.  This module intentionally does not register Net event handlers. Call its API from a plugin or game modu.
- `ezmemory.lua` — Ezmemory Lua module/script; see imports and callers for its concrete integration role.
- `ezmenus.lua` — Ezmenus Lua module/script; see imports and callers for its concrete integration role.
- `ezmystery.lua` — Ezmystery Lua module/script; see imports and callers for its concrete integration role.
- `ezpress.lua` — ezpress.lua Compression/decompression using eztriggers and area property "Minish Mode". Objects with "Compress" = true cause player to shrink on entry. Objects with "Decompress" = true restore normal .
- `ezquests.lua` — Ezquests Lua module/script; see imports and callers for its concrete integration role.
- `ezrushroads.lua` — ezrushroads.lua Rush Roads minigame integrated with ezlibs Uses eztriggers for tile detection and ezmemory for persistence ezrushroads.lua Rush Roads minigame integrated with ezlibs Uses eztriggers fo.
- `eztriggers.lua` — Geometry diagnostics are disabled in normal operation.
- `ezusers.lua` — ezusers.lua A flexible user/role/permission system for your server. Stores each player's role and a full copy of their permissions in ezmemory. Permissions are defined per role in the global `permissi.
- `ezweather.lua` — On server start, record the default custom properties for each area that might be overwritten if the weather changes TODO, support areas being added during server runtime.
- `generate-ezlibs-tiled.lua` — generate_tiled_types_json.lua Generates a Tiled-compatible JSON file containing all custom object types used by ezlibs. Output file: ezlibs-tiled-types.json (or specify path as argument) Run with: lua.
- `helpers.lua` — Helpers Lua module/script; see imports and callers for its concrete integration role.
- `json.lua` —  json.lua  Copyright (c) 2020 rxi  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Sof.
- `main.lua` — Main Lua module/script; see imports and callers for its concrete integration role.
- `object_registry.lua` — Register a handler for an object type. @param object_type: string, the type of object (e.g., "Custom Warp").
- `readme.md` — Module documentation / usage notes.
- `sha256.lua` —  sha2.lua  VERSION: 12 (2022-02-23) AUTHOR:  Egor Skriptunoff LICENSE: MIT (the same license as Lua itself) URL:     https://github.com/Egor-Skriptunoff/pure_lua_SHA  DESCRIPTION: This module contains.
- `urlencode.lua` — Module table URL encode a string. Ensure all newlines are in CRLF form.

### `scripts/input-controller/`

Unified input controller, d-pad mapping, button names, and public main API. README.md explains its sticky state/release/repeat edges and UI handoff guards.

**Contents**

- `README.md` — Module documentation / usage notes.
- `buttons.lua` — Buttons Lua module/script; see imports and callers for its concrete integration role.
- `d-pad.lua` — D pad Lua module/script; see imports and callers for its concrete integration role.
- `input-controller.lua` — input-controller.lua Unified sticky-state input controller with release/repeat edges and UI handoff guards. Timing is driven only by tick(delta_time); missing packet keys never imply release.  Lifecyc.
- `input-controller.zip` — Bundled archive present in the source tree; inspect before treating it as a runtime dependency.
- `main.lua` — main.lua – Unified input API Keep one API registry and one set of Net event handlers if this module is evaluated more than once in the same Lua global environment.

### `scripts/libs/`

Shared utility modules (direction, emotes, emotions, encounters, enums, JSON) plus the bundled Stardust implementation and its license/readme.

**Contents**

- `stardust/` — subdirectory; see its own section below.
- `direction.lua` — Direction Lua module/script; see imports and callers for its concrete integration role.
- `emotes.lua` — Emotes Lua module/script; see imports and callers for its concrete integration role.
- `emotions.lua` — Emotions Lua module/script; see imports and callers for its concrete integration role.
- `encounters.lua` — Encounters Lua module/script; see imports and callers for its concrete integration role.
- `enums.lua` — Enums Lua module/script; see imports and callers for its concrete integration role.
- `json.lua` —  json.lua  Copyright (c) 2020 rxi  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Sof.

### `scripts/logger/`

File/console logger implementation.

**Contents**

- `logger.lua` — logger.lua – Flexible logging module with per‑logger configuration. Uses append‑only JSON Lines format – each entry is written as a new line. Supports buffering, periodic writes, and optional deduplic.

### `scripts/net-game-tourney/`

Tournament orchestration, state, flow, match/core logic, NPC setup, UI, layout constants, entry point, and README. UI and battle tracking are separate from tournament state/flow.

**Contents**

- `main.lua` — main.lua Requiring the current net-games module initializes the current Displayer/input stack.
- `readme.md` — Module documentation / usage notes.
- `tournament-constants.lua` — tournament-constants.lua.
- `tournament-core.lua` — tournament-core.lua ------------------------------------------------------------------------- Helpers (no state) -------------------------------------------------------------------------.
- `tournament-flow.lua` — tournament-flow.lua.
- `tournament-manager.lua` — tournament-manager.lua.
- `tournament-npcs.lua` — tournament-npcs.lua.
- `tournament-state.lua` — tournament-state.lua Central state store for all tournament data. All mutation of tournament state must go through this module. Core tables.
- `tournament-ui.lua` — tournament-ui.lua.
- `ui-pos.lua` — ui-pos.lua.

### `scripts/net-games/`

Core net-game framework and reusable BN-style UI, safe-area helpers, layout manager, textbox, dialogue, prompt, menu API, NPC examples, emotes, and utilities. readme.md is the module guide.

**Contents**

- `dialogue/` — subdirectory; see its own section below.
- `helpers/` — subdirectory; see its own section below.
- `menuAPI/` — subdirectory; see its own section below.
- `navi-emotes/` — subdirectory; see its own section below.
- `npcs/` — subdirectory; see its own section below.
- `utilities/` — subdirectory; see its own section below.
- `bn-textbox.lua` — bn_textbox.lua Simple BN-style text box with typewriter, optional nameplate, mugshot, and backdrop. Uses the existing Dialogue.start system for reliable behavior and input handling. Small helper to co.
- `layout-manager.lua` — layout_manager.lua A comprehensive layout system for managing sprites, resources, and animations. Integrates with Net Games framework, AnimationEngine, and sound effects. Dependencies.
- `main.lua` — [[ =========================================================== DEPENDENCIES ===========================================================.
- `readme.md` — Module documentation / usage notes.
- `ui-safe.lua` — scripts/net-games/ui-safe.lua Small hardened sprite helper for reusable net-games UI. Public coordinates are virtual 240x160 coordinates.  Production lessons captured here: * arbitrary assets are chec.

### `scripts/persistence/`

Persistence API, save-game support, and persistence logger; README describes the package.

**Contents**

- `README.md` — Module documentation / usage notes.
- `logger.lua` — logger.lua – Flexible logging module with per‑logger configuration. Uses append‑only JSON Lines format – each entry is written as a new line. Supports buffering, periodic writes, and optional deduplic.
- `persistence.lua` — persistence.lua Persistent JSON file storage with automatic debounced saving and per‑file instance management. Supports chained updates and waiting for save completion via promise‑returning save(). Au.
- `save-game.lua` — game_save.lua Extension of persistence.lua that provides a staging area for changes. Allows you to make multiple edits, then either commit them (save) or discard them (revert) back to the last saved s.

### `scripts/test-runner/`

Small Lua test runner and assertion helper.

**Contents**

- `tests/` — subdirectory; see its own section below.
- `expect.lua` — expect.lua A minimal assertion library for use with the test runner. Example: local expect = require("scripts.test-runner.expect") return function() expect(2 + 2).toBe(4) expect({a = 1}).toEqual({a = .
- `main.lua` — test-runner.lua Simple test runner for scripts in "scripts/tests/". Usage: local runner = require("scripts.tests.test-runner")  -- adjust path as needed runner.run({"math_test", "string_test"})  -- ru.

### `scripts/utils/`

Shared async, event-emitter, and general utility modules with README. async.lua is separate from engine Async APIs and should not be assumed interchangeable.

**Contents**

- `README.md` — Module documentation / usage notes.
- `async.lua` — Async.lua Async/await and Promise utilities for Lua Promise states.
- `event-emitter.lua` — EventEmitter.lua A flexible event system with async capabilities Create a new EventEmitter instance.
- `utility.lua` — Net.lua Main module that integrates EventEmitter and Async Load sub-modules Shortcut methods.

### `scripts/_DEBUGGING/Example-PVP/`

Contains the files listed below. The role of each file is inferred from its name and available source comments; inspect callers before changing behavior.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/_DEBUGGING/Simon-Says/`

Contains the files listed below. The role of each file is inferred from its name and available source comments; inspect callers before changing behavior.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/avatar_utils/lua_yes_parser/`

Vendored Lua YES parser package with README, examples, license, parser library, source modules, specs, and utility helpers.

**Contents**

- `example/` — subdirectory; see its own section below.
- `legal/` — subdirectory; see its own section below.
- `spec/` — subdirectory; see its own section below.
- `src/` — subdirectory; see its own section below.
- `.gitignore` — Git ignore rules.
- `README.md` — Module documentation / usage notes.
- `lib.lua` — Lib Lua module/script; see imports and callers for its concrete integration role.

### `scripts/ezlibs-custom/footbomb/`

FootBomb Ref and match flow. Constants, animation state names, Navi roster, and bomb skin options are split into companion modules; README.md describes the current design and configuration.

**Contents**

- `README.md` — Module documentation / usage notes.
- `animation_states.lua` — Animation states shared by FootBomb's Navi assets. These names are intentionally centralized: update the roster animation files and this list together when the game adds or renames a state.
- `bomb_options.lua` — Ball skins currently used by the selection UI (gameplay wiring is pending).
- `constants.lua` — Shared FootBomb configuration and tuning values. Keep paths and UI layout values here so they can be adjusted without touching match lifecycle or input logic.
- `main.lua` — FootBomb Ref NPC and match-instance entry point. Loaded by scripts/ezlibs-scripts/main.lua through custom.lua.
- `navi_options.lua` — Selectable Navi roster. Each entry references shared paths and state names.

### `scripts/ezlibs-custom/nebulous-liberations/`

Nebulous Liberations plugin, player-facing entry module, README, liberation runtime, enemies, and effect/party utilities.

**Contents**

- `liberations/` — subdirectory; see its own section below.
- `spirits/` — subdirectory; see its own section below.
- `utils/` — subdirectory; see its own section below.
- `.git` — Git metadata entry.
- `README.md` — Module documentation / usage notes.
- `main.lua` — main.lua Nebulous Liberations ezlibs custom plugin entry point.  This module follows scripts/ezlibs-scripts/main.lua's plugin contract: it returns a table of handle_* functions and does not register i.
- `player.lua` — private functions.

### `scripts/ezlibs-scripts/_DEBUGGING/`

File-backed diagnostic logs grouped by ezlibs module and, where applicable, player/object identifiers. Treat these as runtime output, not configuration.

**Contents**

- `avatar_utils/` — subdirectory; see its own section below.
- `ezannounce/` — subdirectory; see its own section below.
- `ezbbs/` — subdirectory; see its own section below.
- `ezbuttons/` — subdirectory; see its own section below.
- `ezconfig/` — subdirectory; see its own section below.
- `ezencounters/` — subdirectory; see its own section below.
- `ezfarms/` — subdirectory; see its own section below.
- `ezlibs-main/` — subdirectory; see its own section below.
- `ezmemory/` — subdirectory; see its own section below.
- `ezmystery/` — subdirectory; see its own section below.
- `eznpcs/` — subdirectory; see its own section below.
- `ezpress/` — subdirectory; see its own section below.
- `ezrushroads/` — subdirectory; see its own section below.
- `eztriggers/` — subdirectory; see its own section below.
- `ezusers/` — subdirectory; see its own section below.
- `ezwarps/` — subdirectory; see its own section below.
- `ezweather/` — subdirectory; see its own section below.
- `footbomb/` — subdirectory; see its own section below.
- `helpers/` — subdirectory; see its own section below.
- `object_registry/` — subdirectory; see its own section below.

### `scripts/ezlibs-scripts/avatar_utils/`

Bundled/copy of avatar utilities and lua_yes_parser support as used by ezlibs scripts.

**Contents**

- `lua_yes_parser/` — subdirectory; see its own section below.
- `avatar_utils.lua` — avatar_utils.lua Utility functions for handling player avatars and mugshots Helper: parse duration from .animation file (e.g., "10f" → 166ms).
- `base64.lua` — [[.
- `main.lua` — NaviSpot.lua Module to cache player and bot avatar/mugshot assets. For players: copies assets from engine to local files on avatar change. For bots: registers existing local asset paths (no copying). .

### `scripts/ezlibs-scripts/ezannounce/`

Announcement feed and announcement APIs.

**Contents**

- `announcements_feed.lua` — Announcements feed Lua module/script; see imports and callers for its concrete integration role.
- `ezannounce.lua` — Ezannounce Lua module/script; see imports and callers for its concrete integration role.

### `scripts/ezlibs-scripts/ezencounters/`

Encounter startup/runtime wrapper.

**Contents**

- `main.lua` — Main Lua module/script; see imports and callers for its concrete integration role.

### `scripts/ezlibs-scripts/eznpcs/`

NPC object handling and dialogue type definitions.

**Contents**

- `dialogue_types.lua` — Helper for boolean properties (copied from eznpcs.lua to avoid circular dependency).
- `eznpcs.lua` — Eznpcs Lua module/script; see imports and callers for its concrete integration role.

### `scripts/ezlibs-scripts/ezwarps/`

Warp module and individual warp transition/animation modules.

**Contents**

- `arrow_animation_factory.lua` — Arrow animation factory Lua module/script; see imports and callers for its concrete integration role.
- `fall_in_animation.lua` — these offsets will modify the warp landing location so that the player can animate from their spawn location nicely.
- `fall_off_2.lua` — these offsets will modify the warp landing location so that the player can animate from their spawn location nicely.
- `lev_beast_in_animation.lua` — these offsets will modify the warp landing location so that the player can animate from their spawn location nicely.
- `lev_beast_out_animation.lua` — these offsets will modify the warp landing location so that the player can animate from their spawn location nicely.
- `log_in_animation.lua` — these offsets will modify the warp landing location so that the player can animate from their spawn location nicely.
- `main.lua` — Main Lua module/script; see imports and callers for its concrete integration role.

### `scripts/ezlibs-scripts/tests/`

Small utility-focused test modules; not the same layout as scripts/test-runner/tests.

**Contents**

- `test_utilities.lua` — Run from the package root with: lua tests/test_utilities.lua.

### `scripts/ezlibs-scripts/utils/`

Reusable ezlibs utilities: debug output, table/list utilities, and validation helpers; README.md covers them.

**Contents**

- `README.md` — Module documentation / usage notes.
- `ezdebug.lua` — ezdebug.lua Small logger wrapper. By default it writes to standard output. Host-specific logging can be supplied as a callback.
- `ezutil.lua` — ezutil.lua Small, dependency-free helpers for Lua 5.2. This module does not depend on ezlibs host APIs.
- `ezvalidate.lua` — ezvalidate.lua Dependency-free validation helpers for Lua 5.2.

### `scripts/libs/stardust/`

Vendored Stardust core implementation, README, and license.

**Contents**

- `LICENSE.md` — Module documentation / usage notes.
- `README.md` — Module documentation / usage notes.
- `core.lua` — [[.

### `scripts/net-games/dialogue/`

Dialogue startup, dialogue runtime, prompt helpers, vertical prompt implementation, and shared constants.

**Contents**

- `constants.lua` — scripts/net-games/dialogue/constants.lua.
- `dialogue.lua` — scripts/net-games/dialogue/dialogue.lua Hardened net-games dialogue lifecycle. Keeps the creator-side Displayer architecture while preserving production behavior learned from shadis_hp: held-input han.
- `prompt.lua` — scripts/net-games/dialogue/prompt.lua Hardened YES/NO prompt using the public TextLayout service.
- `prompt_vertical.lua` — scripts/net-games/dialogue/prompt_vertical.lua Vertical menu prompt helper for net-games Dialogue (adapted to new displayer) NOTE: This version preserves the original logic but marks areas where the n.
- `startup.lua` — server/scripts/net-games/dialogue/startup.lua print("[net-games dialogue/startup] LOADING...") _G.NG_TEXTBOX_DEBUG = false _G.NG_TEXTBOX_DEBUG_TRACE = false  local Displayer = require("scripts/display.

### `scripts/net-games/helpers/`

Compatibility/helper APIs for net-games.

**Contents**

- `net-helpers.lua` — ===================================================== scripts/net-games/helpers/net-helpers.lua EZLIBS compatibility helpers for net-games  Adds: Net:create_timer(seconds, callback) -> handle handle:c.

### `scripts/net-games/menuAPI/`

Reusable Battle Network-style menu layer with its README.

**Contents**

- `README.md` — Module documentation / usage notes.
- `main.lua` — scripts/net-games/menuAPI/main.lua Reusable BN-style menu layer for net-games.  This is a creator-side rewrite inspired by the production MenuAPI used by shadis_hp. It intentionally depends only on ne.

### `scripts/net-games/navi-emotes/`

Navi-emote configuration and integration.

**Contents**

- `constants.lua` — Constants Lua module/script; see imports and callers for its concrete integration role.
- `navi-emotes.lua` — Navi emotes Lua module/script; see imports and callers for its concrete integration role.

### `scripts/net-games/npcs/`

Creator-facing NPC APIs, presets, dialogue/menu examples, PROG variants, shop and talk examples; README documents this example set.

**Contents**

- `menu_options.lua` — scripts/net-games/npcs/menu_options.lua Purpose: Build PromptVertical option tables without loops/math in each NPC file.
- `npc_api.lua` — scripts/net-games/npcs/npc_api.lua Purpose: Remove NPC boilerplate (interaction wiring, busy guards, face-player, SFX helper). This does NOT contain dialogue/menu content defaults.
- `prog_banner_dialogue.lua` — ===================================================== prog_banner_dialogue.lua Tiled-spawned NPC that triggers net-games Marquee =====================================================.
- `prog_basic_dialogue.lua` — ===================================================== prog_basic_dialogue.lua Tiled-spawned NPC that triggers net-games Dialogue (BLACK BOX style + normal THICK font) =================================.
- `prog_basic_freedraw.lua` — ===================================================== prog_basic_freedraw.lua Tiled-spawned NPC that draws ALL available fonts on screen WITHOUT using Dialogue / textbox pipeline. ====================.
- `prog_basic_nameplate.lua` — ===================================================== prog_basic_nameplate_dialogue.lua Like prog_basic_dialogue.lua, but with a BN-style nameplate. ===================================================.
- `prog_dramatic_dialogue.lua` — ===================================================== prog_dramatic_dialogue.lua Tiled-spawned NPC that triggers net-games Dialogue (BLACK BOX style + normal THICK font) ==============================.
- `prog_dyed_dialogue(bak).lua` — ===================================================== prog_dyed_dialogue.lua Tiled-spawned NPC that triggers net-games Dialogue Uses textbox_panel_frame_tint (base textbox untouched + tinted frame ove.
- `prog_dyed_dialogue.lua` — Prog dyed dialogue Lua module/script; see imports and callers for its concrete integration role.
- `prog_prompt_dialogue.lua` — ===================================================== prog_prompt_dialogue_shared_box.lua Tiled-spawned NPC that shows a YES/NO prompt, then follows up with Dialogue.start, reusing the same textbox UI.
- `prog_prompt_dialogue_2.lua` — ===================================================== prog_prompt_dialogue_2.lua Tiled-spawned NPC that shows a YES/NO prompt, then follows up with Dialogue.start. ====================================.
- `prog_shop.lua` — ===================================================== prog_shop.lua Default PROG shop NPC: - Default OW sprite + default mug - No frame dye (uses default look) - Uses shop UI skin for the vertical men.
- `prog_talk_colors.lua` — ===================================================== prog_talk_colors.lua PROG talk NPCs: one per frame dye color Tiled object names must be: prog_{color} ============================================.
- `prog_talk_dialogue.lua` — ===================================================== prog_talk_dialogue.lua Example: PROG-style prompt that branches into dialogue Uses NEW Talk.npc + presets + purple frame dye =====================.
- `prog_vert_prompt.lua` — ===================================================== prog_vert_prompt.lua Vertical prompt demo PROG (basic style, like prog_basic_nameplate)  Adds: - Mugshot support in the vertical prompt UI - Mugsh.
- `prog_vert_prompt_2.lua` — ===================================================== prog_vert_prompt_2.lua Vertical prompt demo PROG (basic style, like prog_basic_nameplate)  Adds: - Mugshot support in the vertical prompt UI - Mug.
- `prog_vert_prompt_charcoal_grey.lua` — ===================================================== prog_vert_prompt_charcoal_grey.lua  New NPC that mirrors Lime/Pink vertical menu flow, but uses the new helpers: - npc_api.lua (bind interaction +.
- `prog_vert_prompt_emerald.lua` — ===================================================== prog_vert_prompt_emerald_shop.lua Shop-themed variant of ProgVertPromptRed: - identical flow + option generator - overrides PromptVertical assets .
- `prog_vert_prompt_lime.lua` — ===================================================== prog_vert_prompt_lime.lua  LIME variant of prog_vert_prompt_pink.lua.  Key requirement: identical in-game flow, but implemented using Talk.lua + T.
- `prog_vert_prompt_pink.lua` — ===================================================== prog_vert_prompt_pink.lua Pink PROG vertical menu demo using Talk.vert_menu =====================================================.
- `prog_vert_prompt_red.lua` — ===================================================== prog_vert_prompt_red.lua Max-condensed example: - no Net:on in this file - no TalkVertMenu.open in this file - no SFX table in this file - no exit.
- `prog_vert_prompt_sapphire.lua` — ===================================================== prog_vert_prompt_sapphire.lua Flow: Interact -> YES/NO prompt: "Do you wanna check out the vertical menu?" YES -> SAME textbox becomes: "Awesome. .
- `readme.md` — Module documentation / usage notes.
- `talk.lua` — ===================================================== talk.lua Minimal author API for Dialogue NPCs with PROG-default UI =====================================================.
- `talk_presets.lua` — ===================================================== talk_presets.lua Creator-facing presets for Dialogue NPCs (PROG-defaulted) ===================================================== -----------------.
- `talk_vert_menu.lua` — ===================================================== talk_vert_menu.lua Talk-mode wrapper for PromptVertical =====================================================.

### `scripts/net-games/utilities/`

Reusable utility structures such as lockable-table; README documents the utilities.

**Contents**

- `README.md` — Module documentation / usage notes.
- `lockable-table.lua` — lockable_table.lua Internal data storage.

### `scripts/test-runner/tests/`

Demo/test script collection used by the runner.

**Contents**

- `backups/` — subdirectory; see its own section below.
- `demo.lua` — [[.

### `scripts/avatar_utils/lua_yes_parser/example/`

Example input and Lua usage for the bundled parser.

**Contents**

- `doc.cut` — Supporting source or data file.
- `main.lua` — print all elements.

### `scripts/avatar_utils/lua_yes_parser/legal/`

License material for the bundled parser.

**Contents**

- `LICENSE.md` — Module documentation / usage notes.

### `scripts/avatar_utils/lua_yes_parser/spec/`

Parser specification/behavior documentation.

**Contents**

- `README.md` — Module documentation / usage notes.

### `scripts/avatar_utils/lua_yes_parser/src/`

Parser implementation modules for elements, enums, and key/value parsing.

**Contents**

- `utils/` — subdirectory; see its own section below.
- `element.lua` — Element Lua module/script; see imports and callers for its concrete integration role.
- `enums.lua` — Enums Lua module/script; see imports and callers for its concrete integration role.
- `keyval.lua` — Keyval Lua module/script; see imports and callers for its concrete integration role.

### `scripts/ezlibs-custom/nebulous-liberations/liberations/`

Core liberation session/instance, player sessions/selections, enemy and template logic, abilities, loot, panel encounters/registry, preloading, camera sequences, constants, and validation.

**Contents**

- `enemies/` — subdirectory; see its own section below.
- `ability.lua` — ability.lua.
- `camera_sequence.lua` — camera_sequence.lua Play a camera sequence for a player, using points of interest as waypoints. If a point has custom properties "CameraDuration" and "CameraEase", they will be used. fallback: just sh.
- `constants.lua` — constants.lua Centralised definitions for custom properties and constants used in liberations. Map custom property keys.
- `enemy.lua` — enemy.lua Use the template system.
- `enemy_helpers.lua` — Enemy helpers Lua module/script; see imports and callers for its concrete integration role.
- `enemy_selection.lua` — Enemy selection Lua module/script; see imports and callers for its concrete integration role.
- `enemy_templates.lua` — enemy_templates.lua Register a template.
- `instance.lua` — instance.lua.
- `loot.lua` — Loot Lua module/script; see imports and callers for its concrete integration role.
- `panel_encounters.lua` — Panel encounters Lua module/script; see imports and callers for its concrete integration role.
- `panel_registry.lua` — panel_registry.lua Registry tables.
- `player_selection.lua` — Player selection Lua module/script; see imports and callers for its concrete integration role.
- `player_session.lua` — player_session.lua.
- `preloader.lua` — preloader.lua.
- `selection.lua` — private functions.
- `validation.lua` — validation.lua Log a warning or error (replace with proper logging).

### `scripts/ezlibs-custom/nebulous-liberations/spirits/`

Spirit-related work area; current tree contains a TODO note.

**Contents**

- `todo.md` — Module documentation / usage notes.

### `scripts/ezlibs-custom/nebulous-liberations/utils/`

Status/effect helpers and party-related utility code used by Nebulous Liberations.

**Contents**

- `exploding_effect.lua` — Exploding effect Lua module/script; see imports and callers for its concrete integration role.
- `paralyze_effect.lua` — Paralyze effect Lua module/script; see imports and callers for its concrete integration role.
- `parties.lua` — Parties Lua module/script; see imports and callers for its concrete integration role.
- `recover_effect.lua` — Recover effect Lua module/script; see imports and callers for its concrete integration role.

### `scripts/ezlibs-scripts/_DEBUGGING/avatar_utils/`

Avatar utility diagnostics.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezannounce/`

Announcement module diagnostics.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezbbs/`

Bulletin-board system diagnostics.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezbuttons/`

Button logic diagnostics, including default and per-player/object logs.

**Contents**

- `PCRtbl9CVMQ1jv%2FVq4zS389DMcXR51p.log` — Runtime diagnostic output; not executable source.
- `debugging.log` — Runtime diagnostic output; not executable source.
- `default.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezconfig/`

Configuration diagnostics.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezencounters/`

Encounter integration diagnostics.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezfarms/`

Farming system diagnostics.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezlibs-main/`

Main dispatcher diagnostics.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezmemory/`

Persistent-memory diagnostics.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezmystery/`

Mystery Data diagnostics.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/eznpcs/`

NPC system diagnostics.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezpress/`

Pressure/press interaction diagnostics, including per-player logs.

**Contents**

- `PCRtbl9CVMQ1jv%2FVq4zS389DMcXR51p.log` — Runtime diagnostic output; not executable source.
- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezrushroads/`

Rush-road diagnostics.

**Contents**

- `PCRtbl9CVMQ1jv%2FVq4zS389DMcXR51p.log` — Runtime diagnostic output; not executable source.
- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/eztriggers/`

Trigger diagnostics.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezusers/`

User utilities diagnostics.

**Contents**

- `PCRtbl9CVMQ1jv%2FVq4zS389DMcXR51p.log` — Runtime diagnostic output; not executable source.
- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezwarps/`

Warp diagnostics.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/ezweather/`

Weather diagnostics.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/footbomb/`

Contains the files listed below. The role of each file is inferred from its name and available source comments; inspect callers before changing behavior.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/helpers/`

Contains the files listed below. The role of each file is inferred from its name and available source comments; inspect callers before changing behavior.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/_DEBUGGING/object_registry/`

Contains the files listed below. The role of each file is inferred from its name and available source comments; inspect callers before changing behavior.

**Contents**

- `debugging.log` — Runtime diagnostic output; not executable source.

### `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/`

Bundled YES parser files used by avatar utility parsing.

**Contents**

- `src/` — subdirectory; see its own section below.
- `README.md` — Module documentation / usage notes.
- `lib.lua` — Lib Lua module/script; see imports and callers for its concrete integration role.

### `scripts/test-runner/tests/backups/`

Archived test/demo scripts; retained as backups rather than the primary active test entry.

**Contents**

- `test-inheritence-table-example.demo-lua` — Supporting source or data file.
- `test-locking-tables-example.demo-lua` — Supporting source or data file.
- `test-save-game.demo-lua` — Supporting source or data file.
- `test.lua` — [[.
- `tests.demo-lua` — Supporting source or data file.

### `scripts/avatar_utils/lua_yes_parser/src/utils/`

Small parser utility functions, including trimming.

**Contents**

- `trim.lua` — Trim Lua module/script; see imports and callers for its concrete integration role.
- `trim.luaZone.Identifier` — Supporting source or data file.

### `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/`

Concrete enemy definitions: BigBrute, BlizzardMan, and ShadeMan.

**Contents**

- `bigbrute.lua` — Bigbrute Lua module/script; see imports and callers for its concrete integration role.
- `blizzardman.lua` — Blizzardman Lua module/script; see imports and callers for its concrete integration role.
- `shademan.lua` — Shademan Lua module/script; see imports and callers for its concrete integration role.

### `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/`

Parser source modules.

**Contents**

- `utils/` — subdirectory; see its own section below.
- `element.lua` — Element Lua module/script; see imports and callers for its concrete integration role.
- `enums.lua` — Enums Lua module/script; see imports and callers for its concrete integration role.
- `keyval.lua` — Keyval Lua module/script; see imports and callers for its concrete integration role.

### `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/src/utils/`

Parser helper functions.

**Contents**

- `trim.lua` — Trim Lua module/script; see imports and callers for its concrete integration role.
- `trim.luaZone.Identifier` — Supporting source or data file.

## Cross-module notes

- `scripts/ezlibs-scripts/main.lua` is the ezlibs dispatcher entry point; `scripts/ezlibs-custom/custom.lua` aggregates custom plugins, currently FootBomb and Nebulous Liberations. See [ezlibs Scripts](ezlibs-scripts.md) and [ezlibs Custom](ezlibs-custom.md).
- `scripts/net-games/main.lua` is imported by the tournament manager and several UI/dialogue modules; it is a shared UI/game framework rather than one standalone game.
- `scripts/displayer/` provides text/sprite/timer display primitives used by net-games and other custom systems.
- `scripts/input-controller/` and `scripts/utils/async.lua` are separate systems. Do not assume the local `async` helper and engine `Async` global are interchangeable.
- `scripts/net-game-tourney/` separates state, flow, UI, and NPC wiring.
- `scripts/ezlibs-custom/footbomb/` separates roster/configuration modules from the larger `main.lua` lifecycle implementation.
- The tree contains duplicate or vendored modules (notably `avatar_utils`, parser support, JSON, and direction helpers). Before consolidating copies, compare require paths and callers; similarly named files are not automatically interchangeable.
- `scripts/_DEBUGGING/` and `scripts/ezlibs-scripts/_DEBUGGING/` contain logs, not source of truth for API contracts.

## Maintenance notes

1. Update this reference whenever directories are added, removed, or moved.
2. Keep API claims grounded in the current Lua implementation and local README files.
3. Keep asset details in [Assets and File Paths](assets-and-file-paths.md), rather than duplicating path inventories throughout subsystem documents.
4. Do not treat backups, vendored libraries, or `.zip` files as active runtime modules unless a caller actually loads them.

---

## Current archive coverage (2026-10-23)

This documentation bundle was refreshed against the supplied `scripts_internal_test_server.zip` snapshot. For exact per-file imports, event subscriptions, function declarations, and source location, use the linked [per-script reference library](script-reference/README.md). These references supplement rather than replace the subsystem explanations above.
