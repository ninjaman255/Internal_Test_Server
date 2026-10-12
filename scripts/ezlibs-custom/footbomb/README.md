# FootBomb Ref NPC

The `FootBomb Ref` custom object in `areas/footbomb.tmx` starts FootBomb matchmaking. The ref NPC uses the standard eznpcs assets for its appearance and dialogue mug.

## Interaction and match modes

1. The ref asks, **“Hey! Would you like to play FootBomb?”**
2. The quiz options are exactly **`VS [NPC]`**, **`VS Player`**, and **`No`**.
3. **No** exits without creating an instance.
4. **VS [NPC]** creates a private clone of the configured `Instance Map`, spawns both match bots before transferring the human player, and assigns the human to Player 1. The Player 2 bot is a fixed MegaMan opponent, and the instance does not offer player matchmaking.
5. **VS Player** lets the first player wait at the ref. The next player to interact is asked to join. Accepting creates an instance and spawns both bots before transferring either player. The waiting player is assigned Player 1; the joining player is assigned Player 2.
6. Each human player receives their own consistent bot assignment, camera follow, top/bottom screen-space cursor markers, and a selected-Navi name label. The cursors are visual indicators; pressing **Up** or **Down** changes that player's assigned bot's Navi skin and updates the label. Available skins are MegaMan, Roll, and ProtoMan. The NPC opponent remains MegaMan.
7. On leaving the instance or disconnecting, the player's cursor UI and camera lock are cleaned up. Empty instances and their match bots are removed.

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
- `scripts/input-controller/main.lua` provides logical Up/Down press edges and exclusive input ownership. Entering FootBomb force-claims the shared controller for that player's match representation; the camera controller releases its input handling on the ownership-change event. While an owner holds the controller, legacy polling calls without that owner are denied so they cannot consume its press edges. Leaving the instance releases only FootBomb's own claim.
- `scripts/net-games/main.lua` provides per-player UI elements and the `draw_text`, `update_text`, and `remove_text` methods used for the selected Navi label.
- FootBomb moves the real player actor off-map, explicitly unlocks that player's camera, then positions and continuously updates the camera at the assigned bot with `Net.move_player_camera`. The camera editor cannot claim input while FootBomb owns the shared controller, so activating the camera controller is not required for Navi selection or camera follow. MenuAPI also claims the shared controller while its menu stack is open and only polls input while it owns the lease.

This implements the dialogue choice flow, private VS NPC and two-player matchmaking, named spawn-point placement, human bot assignment, skin cycling, cursor markers, and camera following. It does **not** yet forward gameplay movement/input from the hidden player actor to their bot, and it does not implement FootBomb rules, scoring, or end-of-match flow. Camera follow and bot skin recreation still need a live-server test.
