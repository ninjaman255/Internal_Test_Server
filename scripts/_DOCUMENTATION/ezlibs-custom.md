# ezlibs-custom — Complete Documentation

> **Documentation scope and accuracy**
>
> This document consolidates the custom modules in `ezlibs-custom.zip`: FootBomb Ref and Nebulous Liberations. Details are based on the included source and README files. Runtime APIs supplied by the host server are not independently specified here, and static documentation does not imply live integration testing.

## 🗂️ Table of Contents

- [🧭 Part 1 — FootBomb Ref NPC](#footbomb-ref-npc)
- [🌌 Part 2 — Nebulous Liberations](#nebulous-liberations)

---

<a id="footbomb-ref-npc"></a>
## 🧭 Part 1 — FootBomb Ref NPC

### FootBomb Ref NPC

The `FootBomb Ref` custom object in `areas/footbomb.tmx` starts FootBomb matchmaking. The ref NPC uses the standard eznpcs assets for its appearance and dialogue mug.

## Interaction and match modes

1. The ref asks, **“Hey! Would you like to play FootBomb?”**
2. The quiz options are exactly **`VS [NPC]`**, **`VS Player`**, and **`No`**.
3. **No** exits without creating an instance.
4. **VS [NPC]** creates a private clone of the configured `Instance Map`, spawns both match bots before transferring the human player, and assigns the human to Player 1. The Player 2 bot is a fixed MegaMan opponent, and the instance does not offer player matchmaking.
5. **VS Player** lets the first player wait at the ref. The next player to interact is asked to join. Accepting creates an instance and spawns both bots before transferring either player. The waiting player is assigned Player 1; the joining player is assigned Player 2.
6. Each human player receives their own consistent bot assignment, camera follow, top/bottom screen-space cursor markers, and a selected-Navi name label. The label is horizontally centered using the actual rendered font width and placed below the bot's screen-centered sprite, so longer names do not drift left or overlap the bot. The cursors are visual indicators; pressing **Up** or **Down** changes that player's assigned bot's Navi skin and updates the label. Pressing **Confirm** announces the selected Navi and asks whether to use it. **Yes** confirms the choice and displays a confirmation message; **No** (or cancelling the quiz) returns to the existing selector so the player can choose another Navi. Available skins are MegaMan, Roll, ProtoMan, and Prog. The NPC opponent remains MegaMan. Prog uses `/server/assets/ezlibs-assets/eznpcs/sheet/prog.png` and `/server/assets/ezlibs-assets/eznpcs/sheet/prog.animation`, with its animation state set to `FOOTBOMB_IDLE_DEFENSE`; the other selector skins keep their existing `IDLE_DL` state.
7. FootBomb hides the standard player HUD with `Net.toggle_player_hud(player_id)` while the player's FootBomb representation is active. On leaving the instance or disconnecting, the player's cursor UI, selector text, HUD visibility, camera follow state, shared-controller ownership, and engine input lock are cleaned up. Empty instances and their match bots are removed.

## Required Tiled objects

The source map configured by `Instance Map` must contain these two **point objects**, with names spelled exactly as shown:

- `Player 1 Spawn`
- `Player 2 Spawn`

The Player 1 bot is created at the first point and the Player 2 bot at the second point. For a two-human match, the server's matchmaking order assigns the waiting player to Player 1 and the joining player to Player 2. In VS NPC mode, the human bot uses Player 1 Spawn and the fixed MegaMan opponent uses Player 2 Spawn.

The current `areas/footbomb.tmx` in the reviewed archive already contains both point objects (IDs 157 and 158). If the map is moved or replaced, preserve these names and their point coordinates.

## Assets

Match bots use the FootBomb-specific sprite sheets and animations:

- `/server/assets/net-game-footbomb/bots/megaman.png`
- `/server/assets/net-game-footbomb/bots/megaman.animation`
- `/server/assets/net-game-footbomb/bots/roll.png`
- `/server/assets/net-game-footbomb/bots/roll.animation`
- `/server/assets/net-game-footbomb/bots/protoman-bn5.png`
- `/server/assets/net-game-footbomb/bots/protoman-bn5.animation`
- `/server/assets/ezlibs-assets/eznpcs/sheet/prog.png`
- `/server/assets/ezlibs-assets/eznpcs/sheet/prog.animation` (selector state: `FOOTBOMB_IDLE_DEFENSE`)

The two cursor markers use `/server/assets/net-games/cursors/green_cursor.png` and `/server/assets/net-games/cursors/orange_cursor.png`.

## Tiled properties

The custom type reuses standard NPC properties from `scripts/ezlibs-types.json`, including `Direction`, `Asset Name`, `Animation Name`, `Mug Animation Name`, `Dont Face Player`, and dialogue-related properties. FootBomb-specific property:

| Property | Default | Purpose |
|---|---|---|
| `Instance Map` | `footbomb` | Source map cloned for each match. |

The runtime currently uses the fixed FootBomb prompt and three-option quiz requested for this interaction, rather than the legacy `Intro Message`, `Question`, `Started Message`, and `Declined Message` values.

## Integration and current scope

- `scripts/ezlibs-scripts/ezmapinstance.lua` owns cloned instance tracking and player transfers.
- `scripts/ezlibs-scripts/object_registry.lua` registers the `FootBomb Ref` object handler.
- `scripts/ezlibs-custom/custom.lua` dispatches actor interaction, player transfer, and disconnect events to this module.
- `scripts/input-controller/main.lua` provides one shared per-player controller registry, logical Up/Down press edges, and exclusive input ownership. The versioned `_G` singleton prevents duplicate controller registries/event subscriptions when this module is evaluated more than once in the same Lua global environment. All consumers should require the canonical path `scripts/input-controller/main`.
- The Navi selector calls `Net.lock_player_input(player_id)` when the FootBomb representation is set up. This is required for the same locked-input/`virtual_input` pattern used by Simon Says. The selector force-claims the shared controller, clears stale input edges when selection starts, and requires Up/Down/Confirm/Cancel to be released before accepting fresh presses. Opening the Navi confirmation dialogue suspends selector input, consumes the Confirm edge that opened the textbox, and requires release again when returning to selection; this prevents a textbox confirm/dismiss press from also triggering the selector. On cleanup it releases only FootBomb's own controller claim and calls `Net.unlock_player_input(player_id)`; controller ownership and the engine input lock are separate mechanisms.
- The camera controller shares the same InputAPI instance and listens for ownership changes. FootBomb intentionally does not activate the free-camera controller: it moves the real player actor off-map, unlocks the player camera, and follows the assigned bot using `Net.move_player_camera`. `scripts/camera/main.lua` also refuses to activate the free camera from tile interactions inside areas whose IDs begin with `footbomb_` or `footbomb-`. MenuAPI also claims the shared controller while its menu stack is open and only polls input while it owns the lease.
- `Net.toggle_player_hud(player_id)` hides the standard HUD during the FootBomb selector/game view and is toggled back during representation cleanup. This is the same engine API used by `scripts/simon-says.lua`.
- `scripts/net-games/main.lua` provides per-player UI elements and the `draw_text`, `update_text`, and `remove_text` methods used for the selected Navi label. The selector also displays `Press A To Confirm Navi` at the top center of the 240×160 virtual screen, using the THICK font at scale 2.0; its horizontal position is calculated from the displayer font metrics, and it is removed during representation cleanup. The selected-Navi name uses the same font metrics at scale 1.5 to stay horizontally centered and is drawn at virtual-screen y=112, below the bot while the camera follows it. The current displayer API accepts one uniform `scale` value rather than independent ScaleX/ScaleY values.
- FootBomb moves the real player actor off-map, explicitly unlocks that player's camera, then positions and continuously updates the camera at the assigned bot with `Net.move_player_camera`. The camera editor cannot claim input while FootBomb owns the shared controller, so activating the camera controller is not required for Navi selection or camera follow. MenuAPI also claims the shared controller while its menu stack is open and only polls input while it owns the lease.

This implements the dialogue choice flow, private VS NPC and two-player matchmaking, named spawn-point placement, human bot assignment, skin cycling, cursor markers, and camera following. After every human player confirms their Navi, FootBomb assigns one bot as Kicker and the other as Defender, messages each human with their role and a short-start notice, then calls `fadePlayerCamera({ r = 0, g = 0, b = 0, a = 255 }, 0.8)` on that player's camera controller to fade the camera to black; no overlay texture is used. In VS NPC matches, the NPC selects a random available Navi skin when the match bots are created and keeps that skin. It does **not** yet forward gameplay movement/input from the hidden player actor to their bot, and it does not implement FootBomb rules, scoring, or end-of-match flow. The selector input-lock lifecycle was verified in a live server after adding `Net.lock_player_input` to selector setup. Camera follow and bot skin recreation should still be tested when making future changes.

---

<a id="nebulous-liberations"></a>
## 🌌 Part 2 — Nebulous Liberations

### 🌌 Nebulous Liberations — Complete Documentation

> 📝 **Documentation note**
>
> This document describes the source contained in the `nebulous-liberations` custom ezlibs submodule. It follows the structure and formatting conventions of the ezlibs-scripts reference README: shared integration contracts first, followed by module-specific Parts, setup details, APIs, dependencies, and limitations.
>
> The implementation was reviewed statically. The host game's `Net`, `Async`, battle, map, asset, and transfer APIs are runtime-provided; this document does not claim that the module has been integration-tested in a live server.

## 🗂️ Table of Contents

- [🔗 Shared Systems & Cross-Module Dependencies](#shared-systems--cross-module-dependencies)
- [Part 1 — Overview & Integration](#part-1)
- [Part 2 — Installation & Load Order](#part-2)
- [Part 3 — main.lua — ezlibs Plugin Entry Point](#part-3)
- [Part 4 — player.lua — Player Wrapper](#part-4)
- [Part 5 — liberations/constants.lua — Constants & Map Properties](#part-5)
- [Part 6 — liberations/instance.lua — Mission Runtime](#part-6)
- [Part 7 — liberations/player_session.lua — Turn & Player State](#part-7)
- [Part 8 — liberations/ability.lua — Liberation Abilities](#part-8)
- [Part 9 — liberations/selection.lua — Tile Selection](#part-9)
- [Part 10 — liberations/player_selection.lua — Player Selection](#part-10)
- [Part 11 — liberations/panel_registry.lua — Panel GID Registry](#part-11)
- [Part 12 — liberations/panel_encounters.lua — Encounter Terrain](#part-12)
- [Part 13 — liberations/loot.lua — Loot & Reward Bots](#part-13)
- [Part 14 — liberations/enemy.lua — Enemy Lifecycle](#part-14)
- [Part 15 — liberations/enemy_helpers.lua — Enemy Utilities](#part-15)
- [Part 16 — liberations/enemy_templates.lua — Enemy Templates & AI](#part-16)
- [Part 17 — liberations/enemies/ — Concrete Enemies](#part-17)
- [Part 18 — liberations/preloader.lua — Asset Provisioning](#part-18)
- [Part 19 — liberations/validation.lua — Map Validation](#part-19)
- [Part 20 — liberations/camera_sequence.lua — Camera Timing](#part-20)
- [Part 21 — utils/parties.lua — Party Management](#part-21)
- [Part 22 — utils/*_effect.lua — Visual Effects](#part-22)
- [Part 23 — Map Authoring Reference](#part-23)
- [Part 24 — Asset Requirements](#part-24)
- [Part 25 — Runtime Flow & Event Routing](#part-25)
- [Part 26 — Known Constraints & Operational Notes](#part-26)
- [🔎 Final Combined Cross-Reference](#final-combined-cross-reference)

---

<a id="shared-systems--cross-module-dependencies"></a>
## 🔗 Shared Systems & Cross-Module Dependencies

### Shared responsibility boundaries

| Concern | Owner | How Nebulous Liberations uses it |
|---|---|---|
| ezlibs plugin event fan-out | `scripts/ezlibs-scripts/main.lua` | The root ezlibs dispatcher owns `Net:on(...)` subscriptions and invokes this module's `handle_*` hooks. |
| Player persistence and health | `scripts/ezlibs-scripts/ezmemory.lua` | Reads/writes player memory, max health, current health, and player-area memory when booting players back to a lobby. |
| Shared helpers | `scripts/ezlibs-scripts/helpers.lua` | Uses `helpers.get_safe_player_secret(...)` and helper functions from the host ezlibs installation. |
| Direction constants | `scripts/libs/direction.lua` | Used for selection orientation and enemy movement. This is a separate host library, not a file in this archive. |
| Emote constants | `scripts/libs/emotes.lua` | Used for party requests, player emotes, and player-state animations. This is a separate host library. |
| Compression | `scripts/ezlibs-custom/compression` | An import is commented out in `instance.lua`; the compression calls in that file are also commented out. It is not an active dependency in the provided implementation. |
| Battle/encounter runtime | Host `Net` and `Async` APIs | Player wrappers start encounters and wait for the `battle_results` event routed by ezlibs. |
| Asset provisioning | Host `Net.provide_asset(...)` | `preloader.lua` provisions configured bot textures, animations, and sound effects into mission areas. |

### Direct dependency map

| File | Direct source dependencies |
|---|---|
| `main.lua` | `player`, `liberations/instance`, `utils/parties`, `liberations/constants`, `liberations/validation`, `liberations/panel_registry` |
| `player.lua` | `ezmemory`, `helpers` |
| `liberations/ability.lua` | `panel_encounters`, `helpers`, `ezmemory`, `constants` |
| `liberations/instance.lua` | `scripts/libs/direction`, `player_session`, `enemy`, `enemy_helpers`, `panel_encounters`, `loot`, `preloader`, `constants`, `panel_registry`, `camera_sequence`, `scripts/libs/emotes`, `ezmemory`, `helpers` |
| `liberations/player_session.lua` | `ability`, `player_selection`, `loot`, `enemy_helpers`, `paralyze_effect`, `recover_effect`, `constants`, `ezmemory`, `scripts/libs/emotes` |
| `liberations/selection.lua` | `scripts/libs/direction` |
| `liberations/player_selection.lua` | `selection`, `scripts/libs/direction` |
| `liberations/panel_registry.lua` | `constants` |
| `liberations/panel_encounters.lua` | No explicit `require`; reads area metadata at module initialization using `Net` |
| `liberations/loot.lua` | `enemy` |
| `liberations/enemy.lua` | `enemy_templates`, `utils/exploding_effect` |
| `liberations/enemy_helpers.lua` | `utils/recover_effect`, `scripts/libs/direction` |
| `liberations/enemy_templates.lua` | `enemy_selection`, `enemy_helpers`, `preloader`, `constants` |
| `liberations/enemy_selection.lua` | `selection` |
| `liberations/enemies/bigbrute.lua` | `enemy_helpers`, `enemy_selection`, `preloader`, `scripts/libs/direction` |
| `liberations/enemies/blizzardman.lua` | `enemy_selection`, `enemy_helpers`, `preloader` |
| `liberations/enemies/shademan.lua` | `enemy_selection`, `enemy_helpers`, `preloader`, `scripts/libs/direction` |
| `liberations/preloader.lua` | `constants` |
| `liberations/validation.lua` | `constants` |
| `liberations/panel_registry.lua` | `constants` |
| `utils/parties.lua` | `scripts/libs/emotes` |
| `utils/exploding_effect.lua` | No explicit module dependencies |
| `utils/paralyze_effect.lua` | No explicit module dependencies |
| `utils/recover_effect.lua` | No explicit module dependencies |
| `liberations/camera_sequence.lua` | No explicit module dependencies |

### Integration rules

1. **Load this module as a plugin, not as an independent event listener.** `main.lua` returns a plugin table with `handle_*` functions. It intentionally does not register separate `Net:on(...)` handlers, avoiding duplicate handling alongside ezlibs' root dispatcher.
2. **The host must load `scripts/ezlibs-custom/nebulous-liberations/main`.** The documented ezlibs custom hook is `scripts/ezlibs-custom/custom`; the exact integration depends on how that local custom entry point is written. Add the returned module to the root ezlibs `plugins` array if it is not already included by the custom-plugin mechanism.
3. **Load after ezlibs shared dependencies.** `ezmemory` and `helpers` must be available before this module is required. The host `scripts/libs/direction` and `scripts/libs/emotes` files must also exist.
4. **The plugin dispatcher owns event parameters.** Hooks use the `handle_<event>(...)` signature documented by ezlibs. They do not accept the original event table unless that is the event contract.
5. **Panel metadata is initialized when `main.lua` is required.** Load it after `Net` and map/area APIs are available.
6. **The `ezmemory` module owns persistence.** This module should not create a parallel player-memory schema or write player-memory files directly.

---

<a id="part-1"></a>
## Part 1 — Overview & Integration

### Overview

Nebulous Liberations is a custom Lua game module that implements a panel-liberation mission loop inspired by grid-based action RPGs. It provides:

- Mission instances created from configured liberation maps.
- Player wrappers for dialogue, questions, quizzes, battle results, and disconnect handling.
- Multiplayer parties and mission starts from configured gates.
- Panel selection indicators and shape-based tile targeting.
- Enemy spawning, movement, attacks, boss behavior, and health synchronization.
- Battle/encounter initiation for panels and Dark Holes.
- Panel liberation, traps, bonus panels, loot drops, gates, and reward interactions.
- Camera sequencing, mission music/background setup, and return-to-lobby handling.
- Asset preloading and map validation.

The module is not a standalone server bootstrap. It expects the server's `Net` and `Async` APIs and the ezlibs shared modules to be present.

### Directory layout

Install the contents under `scripts/ezlibs-custom/nebulous-liberations/`:

```text
scripts/
  ezlibs-custom/
    nebulous-liberations/
      main.lua
      player.lua
      README.md
      liberations/
        ability.lua
        camera_sequence.lua
        constants.lua
        enemy.lua
        enemy_helpers.lua
        enemy_selection.lua
        enemy_templates.lua
        instance.lua
        loot.lua
        panel_encounters.lua
        panel_registry.lua
        player_selection.lua
        player_session.lua
        preloader.lua
        selection.lua
        validation.lua
        enemies/
          bigbrute.lua
          blizzardman.lua
          shademan.lua
      utils/
        exploding_effect.lua
        paralyze_effect.lua
        parties.lua
        recover_effect.lua
```

All internal imports use the canonical prefix `scripts/ezlibs-custom/nebulous-liberations/...`.

---

<a id="part-2"></a>
## Part 2 — Installation & Load Order

### Required placement

The archive's top-level folder is `nebulous-liberations`. Its contents should end up at:

```text
scripts/ezlibs-custom/nebulous-liberations/
```

Do not place another extra `nebulous-liberations/` folder between the custom directory and `main.lua`, or the import paths will not resolve.

### Required modules and host APIs

| Dependency | Required? | Reason |
|---|---|---|
| `scripts/ezlibs-scripts/ezmemory` | Yes | Player memory, health, and persistent hidden-gate state. |
| `scripts/ezlibs-scripts/helpers` | Yes | Safe player-secret helper used by `Player:boot_to_lobby`. |
| `scripts/libs/direction` | Yes | Direction constants and direction conversion helpers. |
| `scripts/libs/emotes` | Yes | Emote constants for party and player animation behavior. |
| Global `Net` | Yes | Areas, objects, tilesets, bots, players, assets, cameras, transfers, and object interaction. |
| Global `Async` | Yes | Promise creation, coroutine execution, and sleeps used throughout the mission logic. |
| `scripts/ezlibs-custom/compression` | No, currently inactive | The require and compression calls are commented out in the provided `instance.lua`. |

### Plugin registration

The ezlibs README describes a plugin fan-out where the root `main.lua` invokes methods such as `plugin.handle_player_request(player_id, data)`, `plugin.handle_tile_interaction(player_id, x, y, z, button)`, and `plugin.on_tick(delta_time)`.

This module now follows that contract. The custom integration should require the module once and make the returned table available to the plugin dispatcher. A minimal custom entry point may look like:

```lua
-- scripts/ezlibs-custom/custom.lua
local NebulousLiberations =
    require("scripts/ezlibs-custom/nebulous-liberations/main")

return NebulousLiberations
```

That wrapper only returns the plugin. If your local `scripts/ezlibs-scripts/main.lua` expects a differently shaped custom plugin or does not add the returned module to its `plugins` list, adapt the integration there rather than adding a second set of `Net:on(...)` handlers inside Nebulous Liberations.

### Load order

Recommended order:

1. Load ezlibs shared infrastructure and `ezmemory`.
2. Load `scripts/libs/direction` and `scripts/libs/emotes` as available host libraries.
3. Require `scripts/ezlibs-custom/nebulous-liberations/main`.
4. Ensure the returned plugin is included in ezlibs event fan-out.
5. Allow its initialization to inspect map metadata and configure panel GIDs.

### Important initialization behavior

Requiring `main.lua` immediately:

- Seeds Lua's random-number generator using `os.time()`.
- Lists areas and reads area custom properties.
- Builds the waiting-area and respawn metadata tables.
- Registers known panel object GIDs and falls back to classifying unregistered GIDs from configured liberation tilesets as `Dark Panel`.
- Validates areas that declare a `Liberation Tileset`.
- Builds a gate-object-ID to destination-map-name table.

This means `Net.list_areas`, area properties, object lists, and tileset lookup must be usable at module-load time. If maps are loaded later by the host, initialization would need to be moved into an explicit startup hook.

---

<a id="part-3"></a>
## Part 3 — main.lua — ezlibs Plugin Entry Point

### Public API

| Function | Parameters | Returns | Notes |
|---|---|---|---|
| `start_game_for_player(player_id, liberation_id)` | player ID, destination liberation area/name | — | Starts an instance for the player alone or for the player's current party. |
| `on_tick(delta_time)` | elapsed seconds | — | Ticks party request timers and mission instances, disposes empty instances, and resets per-player movement flags. |
| `handle_tile_interaction(player_id, x, y, z, button)` | player ID, tile coordinates, button | — | In a waiting area, opens the leave-party prompt; in an instance, forwards to the mission. |
| `handle_object_interaction(player_id, object_id, button)` | player ID, object ID, button | — | In a waiting area, checks whether the object starts a mission; otherwise forwards to the instance. |
| `handle_actor_interaction(player_id, actor_id, button)` | player ID, actor ID, button | — | Processes party recruitment interactions in waiting areas. |
| `handle_textbox_response(player_id, response)` | player ID, textbox response | — | Resolves the next queued player dialogue promise. |
| `handle_battle_results(player_id, stats)` | player ID, battle result stats | — | Resolves the player's pending encounter promise. |
| `handle_player_avatar_change(player_id, details)` | player ID, avatar details | — | Stores avatar details and forwards the change to the active instance. |
| `handle_player_transfer(player_id)` | player ID | — | Refreshes the tracked position and notifies the active instance. |
| `handle_player_request(player_id, data)` | player ID, request data | — | Creates the `Player` wrapper if one does not already exist. `data` is currently unused. |
| `handle_player_disconnect(player_id)` | player ID | — | Resolves outstanding interactions, notifies the active mission, leaves the party, and removes the player wrapper. |
| `handle_player_move(player_id, x, y, z)` | player ID, coordinates | — | Updates tracked position and marks the player as having moved this tick. |

### Event ownership

The module does **not** call `Net:on(...)`. It relies on the ezlibs root dispatcher to call these hooks. This is intentional: if both the root dispatcher and this module subscribe to the same event directly, a single interaction could be handled twice.

### Mission start flow

1. A configured gate object is interacted with using button `0`.
2. The module prompts `Start mission?`.
3. If the response is `1`, `start_game_for_player` collects the player or their party members.
4. An `Instance` is created from the destination liberation area.
5. Players are transferred to the instance and assigned to it as their current `activity`.
6. `instance:begin()` starts mission initialization.

The module ignores missing player wrappers and missing destination names rather than trying to start a mission with incomplete data.

### Instance cleanup

Each tick, instances are checked for zero players. Empty instances are scheduled for cleanup, then their players (if any remain in the instance's tracked list) are transferred to a configured respawn area or the `default` spawn. The instance is cleaned up and removed from the instance table when its cleanup promise completes.

---

<a id="part-4"></a>
## Part 4 — player.lua — Player Wrapper

`Player` adapts player-oriented engine interactions into methods used by the mission and player-session code. It tracks the player ID, position, movement state, avatar details, dialogue promises, battle promises, current activity, and disconnect state.

### Public API

| Method | Parameters | Returns | Notes |
|---|---|---|---|
| `Player:new(player_id)` | player ID | Player instance | Initializes wrapper state for the player. |
| `:message(message, texture_path?, animation_path?)` | text and optional mugshot assets | Promise | Sends a textbox message and resolves when a response arrives. |
| `:message_with_mug(message)` | text | Promise | Message using the module's configured/default mugshot behavior. |
| `:question(question, texture_path?, animation_path?)` | question and optional mugshot assets | Promise | Sends a question and resolves with the player's response. |
| `:question_with_mug(question)` | text | Promise | Question using the configured/default mugshot behavior. |
| `:quiz(a, b, c?, texture_path?, animation_path?)` | answer labels and optional mugshot assets | Promise | Presents a choice prompt. Call sites commonly use two choices. |
| `:is_battling()` | — | boolean | Checks the host's battle state for this player. |
| `:initiate_encounter(asset_path, data)` | encounter asset path, encounter data | Promise | Starts an encounter and returns a promise resolved by battle results. |
| `:handle_textbox_response(response)` | response | — | Resolves the next pending textbox promise, if one exists. |
| `:handle_battle_results(stats)` | result table | — | Resolves and clears the current encounter promise. |
| `:handle_disconnect()` | — | — | Marks the wrapper disconnected, resolves outstanding waits, and informs its active instance. |
| `:boot_to_lobby(isVictory, mapName)` | boolean, map name | — | Returns the player to a respawn area and applies post-victory gate hiding when applicable. |

### Promise behavior

Textbox calls queue resolver functions. A textbox response resolves the oldest pending resolver. Encounter startup stores a battle resolver that is fulfilled by the `battle_results` plugin hook.

A disconnect resolves pending textbox promises and completes a pending battle with default failure-like results so an awaiting coroutine does not remain indefinitely blocked. Callers should still check whether a player has disconnected before performing later player-specific effects.

### Persistence integration

`boot_to_lobby` uses `helpers.get_safe_player_secret(player_id)` and `ezmemory.get_player_area_memory(...)` to persist the hidden state of the completed mission gate after victory. It uses `ezmemory` to refresh health. Nebulous Liberations does not own a separate player-memory file.

---

<a id="part-5"></a>
## Part 5 — liberations/constants.lua — Constants & Map Properties

This module centralizes custom-property names, panel type names, panel classification lists, loot animation names, ability IDs, and preloaded asset paths.

### Area custom properties

| Property key | Purpose in source |
|---|---|
| `Respawn Area` | Configures the area used to return players after a mission. Also identifies areas that are considered mission/waiting configuration points. |
| `Waiting Area` | Optional waiting-area key associated with a respawn configuration. If absent, the configured `Respawn Area` value is used as the waiting-area key. |
| `Liberation Map File Name` | Used on a gate object to map that object's ID to a destination liberation area/name. |
| `Liberation Tileset` | Tileset path used to identify the panel GID range and enable validation for a liberation area. |
| `Liberation Encounters` | Used by `panel_encounters.lua` to associate an area name with an encounter asset path. |
| `Target Phase Count` | Declared mission tuning property. |
| `Target Player Count` | Declared mission tuning property. |
| `Minimum Target Phase Count` | Declared mission tuning property. |
| `Background Texture` | Background texture applied during/after liberation. |
| `Background Animation` | Background animation applied during/after liberation. |
| `Background Vel X` | Background horizontal velocity. |
| `Background Vel Y` | Background vertical velocity. |
| `Song` | Area song restored/applied after liberation. |
| `Victory Lap Song` | Optional song used during the victory-lap/boss conversion sequence. |
| `Honor HPMem` | Declared health/memory behavior property. |
| `Compress` | Declared compression-related property; the related calls are currently commented out in `instance.lua`. |
| `Decompress` | Declared compression-related property; the related calls are currently commented out in `instance.lua`. |

Some of these properties are read by other files only in specific mission flows. The existence of a constant does not prove that every mission path consumes it.

### Object custom properties

| Property key | Source use |
|---|---|
| `Boss` | Marks a boss-related object for validation/mission behavior. |
| `Spawns` | Enemy template/name used by a Dark Hole. |
| `Direction` | Enemy or boss facing direction. |
| `Gate Key` | Gate requirement metadata. |
| `Gate ID` | Gate/cutscene linkage metadata. |
| `isBoss` | Used by the mission's point-of-interest checks. |
| `Message` | Optional custom message shown when interacting with a panel. |
| `Encounter Path` | Optional encounter asset path overriding the area's default encounter. |
| `Specific Loot` | Declared specific-loot metadata. |
| `Damage Trap` | Trap configuration flag. |
| `Stun Trap` | Trap configuration flag. |
| `Trap Message` | Optional trap message. |
| `Damage Dealt` | Declared damage metadata. |
| `Money` | Declared money metadata. |
| `Next Spawn` | Spawn-point ordering metadata. |
| `Gate To Remove` | Declared gate-removal metadata. |
| `Liberation Map Name` | Used when finding a gate to hide after a successful mission. |

### Panel types

| Type name | Role |
|---|---|
| `Dark Panel` | Ordinary liberatable panel and a walkable panel for enemy movement. |
| `Dark Hole` | Special panel that spawns/hosts an enemy and can generate another enemy after its current one is defeated. |
| `Indestructible Panel` | Panel that is converted after all Dark Holes are cleared in the relevant sequence. |
| `Item Panel` | Liberatable panel with item/loot behavior. |
| `Panel Gate` | Gate panel with a `Gate Key` property. |
| `Bonus Panel` | Special panel that grants bonus loot. |
| `Trap Panel` | Panel with damage/paralysis trap behavior. |

`LiberatablePanelTypes`, `WalkablePanelTypes`, and `ShadowstepPanelTypes` are exported arrays used by the registry and selection logic.

### Ability IDs

The ability IDs declared in source are `LongSwrd`, `WideSwrd`, `OldSaber`, `HevyShld`, `HexScyth`, `NumGadgt`, `GutsHamr`, and `ShdwShoe`. `ability.lua` resolves a player's available ability based on player state and the configured ability IDs.

### Asset paths

`Constants.PreloadAssets` lists the blur, explosion, paralysis, recovery, and item bot textures/animations, plus hurt, explode, paralyze, and recover sounds. See [Part 24 — Asset Requirements](#part-24).

---

<a id="part-6"></a>
## Part 6 — liberations/instance.lua — Mission Runtime

The `Mission`/`Instance` object owns one active liberation run. It creates a mission area instance, tracks players, panels, enemies, Dark Holes, points of interest, spawn points, target/actual phase values, boss state, and player sessions.

### Public API

| Method | Parameters | Returns | Notes |
|---|---|---|---|
| `Mission:new(base_area_id, new_area_id, players)` | source area/name, instance area ID, player wrapper array | Mission instance | Initializes the instance, map objects, panel state, enemies, spawn points, and player sessions. |
| `:begin()` | — | — | Starts the mission after players are transferred. |
| `:on_tick(elapsed)` | elapsed seconds | — | Advances mission-side timers/state. |
| `:clean_up()` | — | Promise | Removes temporary panels/bots and cleans up mission state. |
| `:cleaning_up()` | — | boolean | Indicates cleanup is already in progress. |
| `:handle_tile_interaction(player_id, x, y, z, button)` | player ID, tile coordinates, button | — | Forwards tile interactions into the active player session/selection flow. |
| `:handle_object_interaction(player_id, object_id, button)` | player ID, object ID, button | — | Handles mission objects and related interaction behavior. |
| `:handle_player_avatar_change(player_id)` | player ID | — | Refreshes mission-side player presentation/state. |
| `:handle_player_transfer(player_id)` | player ID | — | Handles a player's transfer while in the instance. |
| `:handle_player_disconnect(player_id)` | player ID | — | Removes/disconnects the player from active mission state. |
| `:get_players()` | — | player wrapper array | Returns the tracked player list. |
| `:get_spawn_position()` | — | spawn object or `nil` | Finds the mission's initial spawn position. |
| `:get_next_spawn_from_object(object_id)` | spawn object ID | spawn object or `nil` | Finds the next configured spawn point. |
| `:get_panel_at(x, y, z)` | tile coordinates | panel or `nil` | Looks up a panel at the requested position. |
| `:remove_panel(panel)` | panel | — | Removes the panel's visual/state representation. |
| `:get_enemy_at(x, y, z)` | tile coordinates | enemy or `nil` | Finds an enemy occupying the specified tile. |

### Mission lifecycle

1. A mission is constructed from the configured liberation map and a unique instance identifier.
2. Map objects and tile GIDs are interpreted as panels, spawns, Dark Holes, gates, points of interest, and other mission markers.
3. Player sessions are created and mission assets are provided.
4. Players enter the instance and the mission begins.
5. Tile/object interactions invoke the appropriate player-session action.
6. Battles resolve asynchronously through the `Player` wrapper.
7. Panel and enemy state updates occur after battle results.
8. When the mission ends, the mission restores background/song state, cleans temporary panels/bots, and returns players to a lobby/respawn area.

### Panel liberation behavior

The core panel action branches by panel type:

- **Bonus Panel:** displays a configured/default message, removes the panel, and runs bonus loot.
- **Dark Hole:** resolves terrain, starts the enemy encounter, liberates the associated shape, loots panels, destroys the enemy, and checks whether indestructible panels can be converted.
- **Other liberatable panel:** chooses an enemy-specific encounter, a panel-specific `Encounter Path`, or the area's default encounter. It then resolves the battle, updates enemy health if the battle fails/ends without a win, liberates selected panels when appropriate, and processes loot.

### Enemy turn behavior

The mission coordinates enemy turns, camera movement, boss healing, Dark Hole respawns, and the end-of-turn state. Enemy actions are asynchronous and use `Async.await(Async.sleep(...))` to sequence movement and visual timing without blocking the server's event loop synchronously.

### Operational note

Mission code uses many map-derived values and engine object lookups. Map validation can detect a few common missing properties, but it is not a complete schema validator. Correct tileset GIDs, spawn markers, encounter assets, and object properties remain essential.

---

<a id="part-7"></a>
## Part 7 — liberations/player_session.lua — Turn & Player State

A `PlayerSession` tracks one player's state during a mission, including current turn status, health/paralysis, selection state, and panel liberation permissions.

### Public API

| Method | Purpose |
|---|---|
| `PlayerSession:new(instance, player)` | Creates a session tied to a mission and `Player` wrapper. |
| `:emote_state()` | Updates player emote/presentation state. |
| `:message_with_points(message)` | Sends a message with mission-point context. |
| `:question_with_points(question)` | Asks a question with mission-point context. |
| `:quiz_with_points(a, b, c)` | Presents a choice prompt with mission-point context. |
| `:get_ability_permission()` | Checks whether the player can use the current ability action. |
| `:get_pass_turn_permission()` | Checks whether the player can pass the current turn. |
| `:initiate_encounter(encounter_path, data)` | Starts a battle and returns its result promise. |
| `:heal(amount)` / `:hurt(amount)` | Changes session/player health. |
| `:paralyze()` | Applies the paralysis effect. |
| `:pass_turn()` | Passes the player's current turn when permitted. |
| `:complete_turn()` | Marks the player's turn complete and advances mission turn flow. |
| `:give_turn()` | Gives the player a turn. |
| `:find_matching_gates()` | Finds gates matching the current gate requirements. |
| `:find_gate_points(id)` | Finds point-of-interest markers associated with a gate ID. |
| `:find_closest_guardian()` | Finds the closest relevant Guardian enemy. |
| `:liberate_panels(panels, results)` | Applies liberation effects to selected panels based on battle results. |
| `:get_cash(panel, destroy_items)` | Calculates/awards panel cash where configured. |
| `:loot_panels(panels, remove_traps, destroy_items)` | Applies loot/trap processing to panels. |
| `:liberate_and_loot_panels(panels, results, remove_traps, destroy_items)` | Combines panel liberation and loot processing. |
| `:handle_disconnect()` | Handles session cleanup for a disconnecting player. |

### Battle results

Battle results are supplied through the ezlibs `battle_results` fan-out. The player wrapper resolves the pending encounter promise; the player session interprets the result table to determine success, turns, damage, retreat/running, and subsequent liberation behavior.

Because host result payloads can vary by encounter implementation, callers should avoid assuming optional fields always exist unless the relevant code path has already validated them.

---

<a id="part-8"></a>
## Part 8 — liberations/ability.lua — Liberation Abilities

`Ability.resolve_for_player(player)` is the module's exported entry point. It resolves the ability associated with the player/session state and composes a targeting shape or a battle/liberation operation.

### Internal operations

| Operation | Role |
|---|---|
| `static_shape_generator(offset_x, offset_y, shape)` | Produces a targeting shape with configured offsets. |
| `liberate_and_loot(...)` | Applies a combined liberation/loot action. |
| `panel_search(...)` | Searches a selection for matching panels. |
| `initiate_encounter(...)` | Starts the ability's encounter behavior. |
| `battle_to_liberate_and_loot(...)` | Uses a battle result to determine the resulting liberation and loot flow. |

### Dependencies

- `panel_encounters` for terrain advantage.
- `helpers` and `ezmemory` for shared helper/persistent player data access.
- `constants` for ability identifiers and panel types.

### Important note

The exact ability effect depends on the player's resolved ability and the corresponding implementation branch. The list of ability IDs in `constants.lua` is the canonical spelling used by this module.

---

<a id="part-9"></a>
## Part 9 — liberations/selection.lua — Tile Selection

`Selection` is a generic shape-based tile selector. It tracks a world position, facing direction, selection shape, offsets, filter callback, indicator tile metadata, and the visual objects created to indicate selected tiles.

### Public API

| Method | Parameters | Returns | Notes |
|---|---|---|---|
| `Selection:new(instance)` | mission instance | selector | Creates a selector tied to the instance area. |
| `:set_filter(filter)` | callback `(x, y, z)` | — | Callback decides whether a tile can be selected. |
| `:set_indicator(indicator)` | `{gid, width, height, offset_x, offset_y}` | — | Defines the visual indicator tile. |
| `:set_shape(shape, shape_offset_x?, shape_offset_y?)` | 2D array, optional offsets | — | Uses a row-based shape; truthy/nonzero cells are selected. |
| `:move(position, direction)` | position, direction | — | Stores a floored tile position and facing direction. |
| `:is_within(x, y, z)` | coordinates | boolean | Checks whether a coordinate falls inside the current shape and passes the filter. |
| `:indicate()` | — | — | Creates temporary indicator objects for valid selected cells. |
| `:remove_indicators()` | — | — | Removes created indicator objects from the mission area. |

### Shape convention

The shape is a 2D array. Each row is a list of cells; a cell that is false or `0` is ignored. The selector applies directional transforms for supported diagonal directions. Shape offsets adjust the position relative to the player.

Indicator width/height and offsets are treated as pixel values and converted to tile units by dividing by 32.

### Limitations

- The selector assumes a filter callback and indicator definition have been configured before calling selection methods that use them.
- It creates temporary map objects for indicators; callers should clear them when selection ends.
- Selection direction behavior depends on the host `scripts/libs/direction` representation.

---

<a id="part-10"></a>
## Part 10 — liberations/player_selection.lua — Player Selection

`PlayerSelection` adapts `Selection` to the current player's position and the mission's panel rules.

### Public API

| Method | Purpose |
|---|---|
| `PlayerSelection:new(instance, player_id)` | Creates a selection controller and loads the selected-tile tileset's first GID. |
| `:select_panel(panel_object)` | Sets the root panel and creates a one-cell indicator facing toward the panel. |
| `:set_shape(shape, shape_offset_x?, shape_offset_y?)` | Changes the active selection shape and refreshes indicators. |
| `:get_panels()` | Returns panel records for the currently indicated objects. |
| `:clear()` | Removes indicator objects and clears the root panel. |
| `:count_panels()` | Returns the number of active indicator objects. |

### Selection filter

The filter rejects missing panels and enemy-occupied tiles (except the root panel). It allows panels whose visual GIDs belong to the mission's basic or item panel GID lists.

### Asset dependency

The constructor requests `/server/assets/tiles/selected tile.tsx` through `Net.get_tileset(...)` and uses its `first_gid` as the indicator base. The source assumes this tileset exists and contains the required selected/active indicator tiles. If it is absent, selection initialization may fail; ensure the asset path and GID layout match the implementation.

---

<a id="part-11"></a>
## Part 11 — liberations/panel_registry.lua — Panel GID Registry

The panel registry maps panel type names to tile GIDs and maps GIDs back to panel type names.

### Public API

| Function/Field | Purpose |
|---|---|
| `PanelRegistry.register(type_name, definition)` | Registers a panel type and one or more `definition.gids`. |
| `PanelRegistry.get_type_by_gid(gid)` | Returns the registered panel type or `nil`. |
| `PanelRegistry.get_definition(type_name)` | Returns the registered type definition or `nil`. |
| `PanelRegistry.is_type(gid, type_name)` | Checks whether a GID belongs to a specific type. |
| `PanelRegistry.is_liberatable(gid)` | Checks against `Constants.LiberatablePanelTypes`. |
| `PanelRegistry.is_walkable(gid)` | Checks against `Constants.WalkablePanelTypes`. |
| `PanelRegistry.is_shadowstep(gid)` | Checks against `Constants.ShadowstepPanelTypes`. |
| `by_type` | Type-name to definition table. |
| `gid_to_type` | GID to type-name table. |
| `type_gids` | Type-name to accumulated GID array. |

### Registration behavior

The registry retains previously registered GIDs when the map bootstrap registers tiles individually. Existing GID ownership is preserved: a later registration does not replace a GID already assigned to another type. This allows explicit panel-object types to be registered first, then unclassified GIDs from the configured liberation tileset to fall back to `Dark Panel`.

---

<a id="part-12"></a>
## Part 12 — liberations/panel_encounters.lua — Encounter Terrain

`panel_encounters.lua` builds a lookup from area names to encounter asset paths by scanning area custom properties for `Liberation Encounters` when the module is first required.

### Public API

| Function | Parameters | Returns | Notes |
|---|---|---|---|
| `PanelEncounters.resolve_terrain(instance, player)` | mission instance, player wrapper | terrain string | Determines encounter terrain based on neighboring panel placement. |
| `PanelEncounters[area_name]` | area name key | encounter path or `nil` | Populated at module initialization from area custom properties. |

### Terrain classification

The resolver inspects adjacent and diagonal panels around the player. It returns one of these strings:

- `surrounded` — panels exist on both sides of an axis.
- `disadvantage` — at least one horizontal and one vertical adjacent panel exist.
- `even` — no preceding condition matched, but a diagonal panel exists.
- `advantage` — no relevant adjacent/diagonal panel was found.

The module checks for Dark Panel, Dark Hole, Indestructible Panel, Item Panel, and Trap Panel when deciding whether a neighboring tile counts as a panel.

### Initialization caveat

Because the lookup is built at require time, changing an area's `Liberation Encounters` property after this module is loaded will not automatically refresh the table.

---

<a id="part-13"></a>
## Part 13 — liberations/loot.lua — Loot & Reward Bots

`Loot` handles item/reward bot creation and the animation/action sequences associated with item and bonus panels.

### Public API

| Function | Parameters | Returns | Notes |
|---|---|---|---|
| `Loot.spawn_item_bot(item, area_id, x, y, z)` | item metadata, area, coordinates | Promise/result from bot spawn | Creates a reward bot for the supplied item definition. |
| `Loot.spawn_randomized_item_bot(loot_pool, item_index, area_id, x, y, z)` | pool, index, area, coordinates | Promise/result | Creates a reward from a randomized loot pool. |
| `Loot.loot_item_panel(instance, player_session, panel, destroy_items)` | mission, session, panel, boolean | Promise/async result | Runs the item-panel reward flow. |
| `Loot.loot_bonus_panel(instance, player_session, panel)` | mission, session, panel | Promise/async result | Runs the bonus-panel reward flow. |

### Internal behavior

The module contains the item-bot construction helper and several asynchronous reward sequences. Loot flows may:

- Spawn and animate an item bot.
- Move the camera to the reward.
- Play reward animations/sounds.
- Ask the player to choose or acknowledge a reward.
- Destroy an item when a battle/reward flow says it was destroyed.
- Resolve reward outcomes through the player session and shared memory systems.

The actual available reward content depends on the item/loot definitions passed by the mission and the bot assets configured on the server.

---

<a id="part-14"></a>
## Part 14 — liberations/enemy.lua — Enemy Lifecycle

`Enemy` provides the common enemy creation, liveness, and destruction entry points.

| Function | Parameters | Returns | Notes |
|---|---|---|---|
| `Enemy.from(instance, position, direction, name)` | mission, spawn position, direction, template/enemy name | enemy object | Creates an enemy through the enemy-template registry. |
| `Enemy.is_alive(enemy)` | enemy | boolean | Checks whether the enemy remains alive. |
| `Enemy.destroy(instance, enemy)` | mission, enemy | Promise/async result | Runs the enemy destruction/removal sequence, including visual effects. |

Enemy instances are associated with their mission and coordinates. Mission code is responsible for tracking enemies in the instance's enemy list and removing defeated enemies from active state.

---

<a id="part-15"></a>
## Part 15 — liberations/enemy_helpers.lua — Enemy Utilities

`EnemyHelpers` groups shared enemy presentation, health, movement, distance, and target-selection behavior.

| Function | Parameters | Purpose |
|---|---|---|
| `play_attack_animation(enemy)` | enemy | Plays the enemy's attack animation. |
| `update_name(enemy)` | enemy | Updates the visible enemy name/state. |
| `heal(enemy, amount)` | enemy, health amount | Heals an enemy. |
| `face_position(enemy, x, y)` | enemy, target coordinates | Faces an enemy toward a target position. |
| `can_move_to(instance, x, y, z)` | mission, coordinates | Checks whether the destination is traversable. |
| `move(instance, enemy, x, y, z, direction?)` | mission, enemy, destination, optional direction | Moves an enemy with animation/timing. |
| `offset_position_with_direction(position, direction)` | position, direction | Computes a directional position offset. |
| `chebyshev_tile_distance(enemy, x, y)` | enemy, coordinates | Computes grid distance using the maximum axis delta. |
| `find_closest_player_session(instance, enemy)` | mission, enemy | Selects the nearest tracked player session. |
| `sync_health(enemy, results)` | enemy, encounter result | Synchronizes enemy health from battle results. |

These helpers are shared by concrete enemy implementations and templates so enemy AI does not need to duplicate movement, health, and target-selection logic.

---

<a id="part-16"></a>
## Part 16 — liberations/enemy_templates.lua — Enemy Templates & AI

`EnemyTemplates` stores named enemy definitions and provides common AI routines.

| Function | Parameters | Returns | Notes |
|---|---|---|---|
| `EnemyTemplates.register(name, template)` | name, template table | — | Registers a named template. |
| `EnemyTemplates.create(instance, position, direction, template_name)` | mission, position, direction, template name | enemy object | Instantiates a registered template. |
| `EnemyTemplates.ai.simple_charge(self)` | enemy instance | —/async behavior | Common approach-and-attack behavior. |
| `EnemyTemplates.ai.ranged(self)` | enemy instance | —/async behavior | Common ranged attack behavior. |

Templates use `enemy_selection`, `enemy_helpers`, `preloader`, and `constants`. The concrete classes in `liberations/enemies/` provide additional specialized behavior.

---

<a id="part-17"></a>
## Part 17 — liberations/enemies/ — Concrete Enemies

### `enemies/bigbrute.lua`

`BigBrute:new(instance, position, direction)` creates a BigBrute enemy. Public methods:

- `:spawn(direction)` — spawns/presents the enemy.
- `:get_death_message()` — returns its death message.
- `:take_turn()` — performs the enemy's AI turn.

Its private AI helpers calculate directional steps, attempt axis movement, choose a movement attempt, and attempt an attack. The implementation uses the shared enemy movement/selection helpers and the host direction constants.

### `enemies/blizzardman.lua`

`BlizzardMan:new(instance, position, direction)` creates a BlizzardMan enemy. Public methods:

- `:spawn(direction)`
- `:get_death_message()`
- `:take_turn()`

Its turn logic includes timed attack and movement sequences using `Async.sleep`.

### `enemies/shademan.lua`

`ShadeMan:new(instance, position, direction)` creates a ShadeMan enemy. Public methods:

- `:spawn(direction)`
- `:get_death_message()`
- `:take_turn()`

Its AI uses the host direction helpers, enemy movement helpers, and timed movement/attack sequences.

### Adding an enemy

The current template architecture uses `EnemyTemplates.register(...)` and `EnemyTemplates.create(...)`. A new enemy should follow the shape of existing templates/classes and register its required bot assets with `Preloader.add_asset(...)` where needed. The new module must be placed under the same custom submodule path and its `require` path must match that location.

---

<a id="part-18"></a>
## Part 18 — liberations/preloader.lua — Asset Provisioning

`Preloader` provisions the standard assets and any additional registered asset paths into a mission area.

| Function | Parameters | Returns | Notes |
|---|---|---|---|
| `Preloader.add_asset(asset_path)` | asset path string | — | Adds an extra path to the internal preload list. |
| `Preloader.update(area_id)` | area ID | — | Calls `Net.provide_asset(area_id, path)` for all base and extra paths. |

### Base assets

Every `Preloader.update(area_id)` call provides all paths listed in `Constants.PreloadAssets`, followed by all custom paths added through `add_asset`.

Repeated calls provide the base paths again; this module does not deduplicate the custom path list.

---

<a id="part-19"></a>
## Part 19 — liberations/validation.lua — Map Validation

`Validation` performs a lightweight scan of area objects and prints warnings/errors for a small set of common configuration problems.

| Function | Parameters | Returns | Notes |
|---|---|---|---|
| `Validation.validate_area(area_id)` | area ID | boolean | Returns `true` when no checked validation errors were found. |
| `Validation.report(area_id)` | area ID | boolean | Prints a header, runs validation, prints pass/fail, and returns the result. |

### Checks performed

- A `Spawn Point` without `Next Spawn` generates a warning; the code notes that default spawn ordering will be used.
- A Dark Hole without `Spawns` generates an error.
- A Dark Hole without `Direction` generates an error.
- An object marked with the configured `Boss` property but without `Direction` generates an error.
- A `Panel Gate` without `Gate Key` generates an error.
- A liberation area with no `Spawn Point` generates an error.

### Limitations

- Validation runs only for areas that declare `Liberation Tileset` in the current bootstrap.
- It is not a full Tiled schema validator and does not validate every property declared in `constants.lua`.
- Some checks depend on the exact custom-property representation returned by the host engine.
- The validator logs to `print`; it is not currently routed through ezlibs `ezlogger`.

---

<a id="part-20"></a>
## Part 20 — liberations/camera_sequence.lua — Camera Timing

`camera_sequence.lua` contains the module's camera-sequence timing helper. It is a small utility used by the mission flow to coordinate camera movement and waits.

The file has no explicit `require` dependencies. Its behavior is driven by the values passed by callers and the host camera/sleep APIs used by the sequence. It is not a separate event plugin.

---

<a id="part-21"></a>
## Part 21 — utils/parties.lua — Party Management

`Parties` stores temporary party membership and recruitment requests in Lua tables. It does not persist parties to `ezmemory`.

### Public API

| Function | Parameters | Returns | Notes |
|---|---|---|---|
| `Parties.find(player_id)` | player ID | party table or `nil` | Returns `{ members = { player_id, ... } }` if the player belongs to a party. |
| `Parties.is_in_same_party(player_a, player_b)` | two player IDs | boolean or `nil` | Returns `nil` if the first player is not in a party; otherwise true/false. |
| `Parties.on_tick(elapsed)` | elapsed seconds | — | Advances pending recruitment request timers and refreshes request emotes. |
| `Parties.request(requester, recruit)` | two player IDs | — | Creates a pending request and displays the request emote. |
| `Parties.has_request(recruit, requester)` | recruit ID, requester ID | boolean | Checks for a pending request in the expected requester/recruit direction. |
| `Parties.accept(recruit, requester)` | recruit ID, requester ID | — | Accepts a pending request and adds the recruit to the requester's party. |
| `Parties.leave(player_id)` | player ID | — | Removes the player from their party and removes a one-member party record. |

### Party behavior

- Party state is in-memory only and is reset when the server restarts.
- Recruitment requests expire after approximately five seconds, checked on a one-second tick cadence.
- A recruit leaves any existing party before joining another party.
- The module uses `scripts/libs/emotes` for request/accept visual feedback.
- Mission gates start a mission for all members returned by `Parties.find(player_id)`.

### Integration note

The `main.lua` plugin calls `Parties.on_tick(delta_time)` from its `on_tick` hook. If the plugin is not included in ezlibs' event fan-out, neither party timers nor mission hooks will advance.

---

<a id="part-22"></a>
## Part 22 — utils/*_effect.lua — Visual Effects

### `utils/exploding_effect.lua`

Provides the explosion visual-effect sequence used by enemy destruction. It uses `Async.sleep` to sequence effects over time and relies on the host `Net` bot/object and sound APIs. The public implementation should be treated as an internal effect helper called by `enemy.lua`, rather than as a standalone plugin.

### `utils/paralyze_effect.lua`

Provides the paralysis visual effect used by player-session trap/status logic. It sequences the relevant visual/sound behavior using the host runtime.

### `utils/recover_effect.lua`

Provides the recovery/heal visual effect used by enemy/player helper logic. It includes an asynchronous delay and uses host runtime presentation APIs.

### Effect dependencies

The effect files do not explicitly require other Lua modules in the supplied source. They still depend on host globals and the configured assets. See [Part 24 — Asset Requirements](#part-24).

---

<a id="part-23"></a>
## Part 23 — Map Authoring Reference

This module does not include a Tiled type-generator script or a formal JSON schema for every map object. The following table is derived from the constants, validator, and map-loading code.

### Area-level properties

| Property | Expected use |
|---|---|
| `Respawn Area` | Area name used as the return location after a mission. The module uses this property to identify areas with liberation/waiting configuration. |
| `Waiting Area` | Optional name/key for the lobby/waiting area where party and gate interactions are enabled. |
| `Liberation Tileset` | Path to the panel tileset used by a liberation area. Enables panel GID fallback registration and map validation. |
| `Liberation Encounters` | Encounter asset path associated with an area. |
| `Background Texture` | Background texture path. |
| `Background Animation` | Background animation path. |
| `Background Vel X` / `Background Vel Y` | Background velocity components. |
| `Song` | Area music path. |
| `Victory Lap Song` | Optional music path for the post-Dark-Hole/victory sequence. |
| `Target Phase Count` / `Target Player Count` / `Minimum Target Phase Count` | Declared mission tuning properties; confirm actual gameplay use in the current mission code before relying on them. |

### Object types and properties

| Object type/property | Requirements or behavior |
|---|---|
| `Spawn Point` | A spawn marker. `Next Spawn` is optional but recommended for deterministic spawn ordering. |
| `Dark Hole` | Must have `Spawns` and `Direction` according to validation. |
| Boss marker | An object carrying the `Boss` property must also have `Direction`. |
| `Panel Gate` | Must have `Gate Key`. |
| `Point of Interest` | May use `Gate ID` and `isBoss` for gate/cutscene/boss-related flow. |
| Gate object | Uses `Liberation Map File Name` to map the gate object ID to the destination liberation area/name. |
| Any supported panel object | Its `type` and `data.gid` are used to register the corresponding panel type. |

### Recommended authoring workflow

1. Confirm that the destination liberation area exists and the gate's `Liberation Map File Name` exactly matches the name expected by the server.
2. Set `Liberation Tileset` on the liberation area to the correct tileset path.
3. Confirm that the tileset is present and its tile GIDs match the map.
4. Add a `Spawn Point`; use `Next Spawn` when more than one spawn position needs a defined order.
5. Add the appropriate panel objects/GIDs and ensure explicit special panel types are registered before relying on the Dark Panel fallback.
6. Give every Dark Hole its `Spawns` and `Direction` properties.
7. Give each Panel Gate its `Gate Key`.
8. Set `Liberation Encounters` on areas that need a default encounter.
9. Confirm all bot, animation, sound, and selected-tile assets exist at the exact configured paths.
10. Review startup validation output and then test the full mission in the host server.

### Coordinate and GID cautions

- Selection indicator dimensions use 32-pixel tile units.
- Panel classification depends on GIDs. A visually correct tile can still behave incorrectly if its GID is registered as the wrong panel type.
- GIDs are stored in the module-level registry. If separate tilesets reuse GIDs for different meanings, they can conflict; ensure the runtime's GID scheme is consistent.
- The source uses the configured liberation tileset's GID range as a fallback for unregistered GIDs. Explicit object panel types should take precedence.

---

<a id="part-24"></a>
## Part 24 — Asset Requirements

### Nebulous Liberations base assets

The following paths are hard-coded in `Constants.PreloadAssets`:

```text
/server/assets/NebuLibsAssets/bots/blur.png
/server/assets/NebuLibsAssets/bots/blur.animation
/server/assets/NebuLibsAssets/bots/explosion.png
/server/assets/NebuLibsAssets/bots/explosion.animation
/server/assets/NebuLibsAssets/bots/paralyze.png
/server/assets/NebuLibsAssets/bots/paralyze.animation
/server/assets/NebuLibsAssets/bots/recover.png
/server/assets/NebuLibsAssets/bots/recover.animation
/server/assets/NebuLibsAssets/bots/item.png
/server/assets/NebuLibsAssets/bots/item.animation
/server/assets/NebuLibsAssets/sound effects/hurt.ogg
/server/assets/NebuLibsAssets/sound effects/explode.ogg
/server/assets/NebuLibsAssets/sound effects/paralyze.ogg
/server/assets/NebuLibsAssets/sound effects/recover.ogg
```

### Additional known asset dependency

`player_selection.lua` requests:

```text
/server/assets/tiles/selected tile.tsx
```

The implementation uses the tileset's `first_gid` and the next GID as selection indicator GIDs. Ensure the tileset contains the intended tile images/metadata in the expected order.

Enemy classes and loot code may also refer to additional encounter assets, bot assets, animations, and sounds. Search the source for exact asset paths before packaging a deployment; the base preloader list is not an exhaustive asset manifest for every encounter.

### Asset deployment checklist

- Verify paths and capitalization exactly match the server filesystem.
- Ensure the server can load each texture, animation, sound, tileset, and encounter asset.
- Confirm any additional assets registered with `Preloader.add_asset(...)` are added before `Preloader.update(area_id)` runs.
- Check that the selected-tile tileset GIDs do not conflict with panel GIDs in the target runtime.
- Confirm that `Net.provide_asset` is supported for every listed path in the host version.

---

<a id="part-25"></a>
## Part 25 — Runtime Flow & Event Routing

### Event routing cross-reference

| ezlibs hook | Nebulous Liberations behavior |
|---|---|
| `on_tick(delta_time)` | Updates party request expiration, ticks instances, removes empty instances, resets player movement flags. |
| `handle_player_request(player_id, data)` | Creates a `Player` wrapper if missing. |
| `handle_player_move(player_id, x, y, z)` | Updates the wrapper's tracked position and movement flag. |
| `handle_tile_interaction(player_id, x, y, z, button)` | Opens the leave-party prompt in waiting areas or forwards to a mission instance. |
| `handle_object_interaction(player_id, object_id, button)` | Starts the configured mission from a waiting-area gate or forwards to the mission. |
| `handle_actor_interaction(player_id, actor_id, button)` | Handles party request/recruitment interactions in waiting areas. |
| `handle_textbox_response(player_id, response)` | Resolves the queued dialogue prompt. |
| `handle_battle_results(player_id, stats)` | Resolves the active encounter promise. |
| `handle_player_avatar_change(player_id, details)` | Stores avatar details and refreshes mission state. |
| `handle_player_transfer(player_id)` | Refreshes tracked position and informs the active mission. |
| `handle_player_disconnect(player_id)` | Cleans up player/session state and party membership. |

### Typical mission timeline

```text
Player request
    ↓
Player wrapper created
    ↓
Waiting area gate interaction
    ↓
Mission-start question accepted
    ↓
Party members gathered
    ↓
Mission instance created and players transferred
    ↓
Player session / panel selection
    ↓
Panel interaction → encounter/battle
    ↓
Battle result routed through ezlibs
    ↓
Panel liberation and loot
    ↓
Mission victory/defeat or empty-instance cleanup
    ↓
Players returned to respawn/lobby
```

### Async conventions

The module uses the host's `Async.await`, `Async.sleep`, `Async.create_promise`, and `Async.promisify` APIs. These are not interchangeable with the global `async` helper described in ezlibs `helpers.lua`. Preserve the runtime's promise/coroutine conventions when extending the code.

---

<a id="part-26"></a>
## Part 26 — Known Constraints & Operational Notes

1. **Runtime behavior has not been live-tested here.** Static inspection cannot prove the host server's exact behavior for area instancing, encounter payloads, asset provisioning, or camera/bot APIs.
2. **Custom plugin wiring is required.** Returning a plugin table alone does not make hooks run; the server's ezlibs dispatcher must call the returned methods.
3. **Initialization occurs during `require`.** Area and tileset metadata is scanned at module load. If maps are unavailable then, the module needs an explicit initialization hook.
4. **Some property constants are declarations only.** A key in `constants.lua` may be used by only one path or not yet be consumed in the current source.
5. **Panel GIDs must be consistent.** A GID cannot safely represent two different panel types within the same registry.
6. **Selected-tile asset is assumed to exist.** `PlayerSelection:new` dereferences the result of `Net.get_tileset(...)`; ensure the path resolves.
7. **Party state is transient.** Parties and pending requests live in module tables and are not persisted.
8. **Player memory remains ezmemory-owned.** Avoid directly editing its files or duplicating its schema.
9. **The compression integration is inactive.** `instance.lua` has commented-out compression imports/calls. `Compress` and `Decompress` constants alone do not activate compression.
10. **The validator is intentionally limited.** A successful validation report means only that the implemented checks passed.
11. **Map names and object properties must match exactly.** Destination area names, tileset paths, custom-property names, and encounter paths are string-based.
12. **`panel_encounters.lua` caches area configuration at require time.** Restart/reload or add an explicit refresh method if encounter properties change dynamically.
13. **No Tiled type generator is included in this archive.** The object names and properties in this README are source-derived; editor metadata must be maintained separately if needed.
14. **Use ezlibs' own diagnostics conventions when expanding the module.** The current validator uses `print`; if file-backed diagnostics are desired, integrate `scripts/ezlibs-scripts/ezlogger.lua` explicitly rather than assuming console output is persisted.

### Changes made during this review

- Reworked `main.lua` to expose ezlibs-compatible `handle_*` and `on_tick` hooks instead of registering duplicate `Net:on(...)` listeners.
- Added guards for player wrappers that may not exist during disconnect, movement, transfer, or delayed prompt callbacks.
- Changed panel initialization to register explicitly typed panel objects before applying the Dark Panel fallback to remaining tileset GIDs.
- Updated `panel_registry.lua` so repeated per-GID registrations accumulate a type's GID list instead of replacing it on each call.
- Made the terrain helper's `includes` function local rather than writing a global.
- Corrected `PlayerSelection:count_panels()` to count its selection indicator objects.

These are source-level corrections. They still require validation in the target server runtime.

---

<a id="final-combined-cross-reference"></a>
## 🔎 Final Combined Cross-Reference

| Need | File/API |
|---|---|
| Root plugin entry point | `main.lua` |
| Player dialogue and battle promises | `player.lua` |
| Mission creation, tick, interactions, cleanup | `liberations/instance.lua` |
| Player turns, status, battle, panel liberation | `liberations/player_session.lua` |
| Ability resolution | `liberations/ability.lua` |
| Panel targeting shapes | `liberations/selection.lua` |
| Player-specific selection | `liberations/player_selection.lua` |
| Panel type/GID mapping | `liberations/panel_registry.lua` |
| Encounter terrain advantage | `liberations/panel_encounters.lua` |
| Reward bots and loot flows | `liberations/loot.lua` |
| Enemy lifecycle | `liberations/enemy.lua` |
| Enemy movement/health/targeting | `liberations/enemy_helpers.lua` |
| Named enemy templates and shared AI | `liberations/enemy_templates.lua` |
| Concrete enemies | `liberations/enemies/*.lua` |
| Asset provisioning | `liberations/preloader.lua` |
| Map validation | `liberations/validation.lua` |
| Party state and recruitment | `utils/parties.lua` |
| Explosion/paralysis/recovery effects | `utils/*_effect.lua` |
| Shared player memory and health | `scripts/ezlibs-scripts/ezmemory.lua` |
| Shared helper functions | `scripts/ezlibs-scripts/helpers.lua` |
