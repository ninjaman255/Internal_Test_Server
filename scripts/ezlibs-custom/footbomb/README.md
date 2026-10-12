# FootBomb Ref NPC

The `FootBomb Ref` custom object in `areas/footbomb.tmx` starts FootBomb matchmaking. The map object remains a point reference and spawns the visible ref NPC using the standard eznpcs sheet assets.

## Interaction and match modes

1. The NPC says, **“Hey! Would you like to play FootBomb?”**
2. The quiz options are exactly **`VS [NPC]`**, **`VS Player`**, and **`No`**.
3. **No** exits without creating an instance.
4. **VS [NPC]** creates a private clone of the configured `Instance Map`, creates both MegaMan-skin match bots before transferring the player, and assigns the first bot to the player. The second bot is the NPC opponent. The mode does not accept another player.
5. **VS Player** marks the first player as waiting at the ref. The next player to interact with that ref is asked whether they want to join. Accepting creates an instance, spawns both bots before transfer, then transfers both players and assigns one bot per player. Declining leaves the first player waiting.
6. Each player has a consistent bot assignment for the match and two screen-space cursor markers intended to sit above and below the represented bot. The camera is locked/moved toward the bot position on ticks when the server exposes the relevant camera and bot-position APIs.
7. On leaving the instance or disconnecting, the player's cursor UI and camera lock are cleaned up. Empty instances and their match bots are removed.

## Assets

Both match bots use:

- `/server/assets/ezlibs-assets/eznpcs/sheet/megaman.png`
- `/server/assets/ezlibs-assets/eznpcs/sheet/megaman.animation`

The two cursor markers use the existing `/server/assets/net-games/cursors/green_cursor.png` and `orange_cursor.png` assets.

## Tiled properties

The custom type reuses the standard NPC properties from `scripts/ezlibs-types.json`, including `Direction`, `Asset Name`, `Animation Name`, `Mug Animation Name`, `Dont Face Player`, and dialogue-related properties. FootBomb-specific properties:

| Property | Default | Purpose |
|---|---|---|
| `Instance Map` | `footbomb` | Source map cloned for each match. |
| `Intro Message` | NPC default dialogue | The runtime currently uses the requested fixed FootBomb question. |
| `Question` | — | The runtime currently uses the requested fixed three-option quiz. |
| `Spawn X`, `Spawn Y`, `Spawn Z` | Object-relative fallback | Fallback coordinates if the server doesn't report a spawn point. |

The instance spawn is resolved through `Net.get_spawn_position` first. No Tiled map edits are required for the current interaction/matchmaking pass. The two player bots are placed one world unit to either side of the resolved spawn.

## Integration and current scope

- `scripts/ezlibs-scripts/ezmapinstance.lua` owns cloned instance tracking and player transfers.
- `scripts/ezlibs-scripts/object_registry.lua` registers the `FootBomb Ref` object handler.
- `scripts/ezlibs-custom/custom.lua` dispatches actor interaction, player transfer, and disconnect events to this module.
- `scripts/net-games/main.lua` provides the UI element methods.

This implements the NPC choice flow, private-vs-NPC and two-player matchmaking, bot spawning/assignment, cursor markers, and best-effort camera tracking. It does **not** yet forward movement/input from the hidden player actor to their bot, and it does not implement FootBomb rules, scoring, or end-of-match flow. The engine's `net-games` wrapper documents `detach_camera()` as unsupported; camera tracking here therefore uses the lower-level `Net.move_player_camera` API if available and must be verified in the running server.
