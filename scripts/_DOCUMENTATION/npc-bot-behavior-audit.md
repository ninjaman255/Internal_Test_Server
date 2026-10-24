# NPC, Bot, and Spawn-Pattern Inventory

## Scope

This inventory was assembled from the uploaded `scripts/ezlibs-scripts`, `scripts/ezlibs-custom`, and `_DOCUMENTATION` trees. It distinguishes reusable NPC behavior from a bot lifecycle that belongs to a minigame, encounter, effect, or world system.

## Recommended Tiled-composable behaviors

| Behavior | Existing implementation | Status / recommendation |
|---|---|---|
| Pushback collision | `ezlibs-scripts/eznpcs/ezpushback.lua` | Implemented as the first `NPC Behavior` adapter. Uses the existing moving rectangle trigger, push movement, cooldown, animation, and cleanup logic. |
| Patrol / waypoint movement | `eznpcs/eznpcs.lua`, waypoint objects | Existing native NPC capability. Keep native initially because scripted movement and pose ownership are coupled to the NPC record. A future adapter can expose it without duplicating the movement implementation. |
| Dialogue / interaction | `eznpcs/eznpcs.lua`, `eznpcs/dialogue_types.lua`, separate `Dialogue` objects | Already modular at the data layer. Keep as an NPC capability; don't create a second dialogue engine. |
| Battle interaction | `DialogueType = battle_npc`, encounter/battle result handlers | Keep as dialogue/encounter integration. A future behavior may select an encounter, but it should call the existing encounter API. |
| Cutscene interaction | `ezcutscenes/ezcutscenes.lua`, `Cutscene`, `Cutscene Step` | Separate reusable sequence system already exists. NPC interaction can invoke it; avoid duplicating cutscene state inside an NPC behavior. |
| Detection / bot enter-depart | `eztriggers.lua`, `ezbottriggers.lua` | Existing shared trigger services. Could become a configurable NPC behavior later if a concrete map-authoring use case appears. |
| NPC spawning | `NPC Spawner` in `eznpcs.lua` | Spawn pattern, not a behavior attached to a live NPC. Supports Once/Interval, trigger radius, Max Alive, waypoint completion, warp-out. |
| Player / quest exclusivity | `eznpcs.lua` | Spawn/visibility policy, not an attached behavior. Must stay per-player and respect join, transfer, quest-state and disconnect cleanup. |
| Rush-road representation bots | `ezrushroads.lua` | Specialized world-system lifecycle. Includes permanent road bots and temporary player-avatar bots; retain road grouping and transfer semantics. |
| Explosion / warp / checkpoint effect bots | `ezexplosions.lua`, `ezwarps/`, `ezcheckpoints.lua` | Short-lived effects and transitions, not NPC archetypes. Share low-level bot utilities in a future `ezbots` foundation if desired. |
| Button bots | `ezbuttons.lua` and `Button Bot Details` | Button/group-owned actors whose state follows activation and deactivation. Keep tied to button lifecycle. |
| FootBomb actors and bombs | `ezlibs-custom/footbomb/` | Game-instance-owned actors. The controller owns match instance, roles, Navi/bomb selection, animation state, camera, input, and cleanup. Not world NPC behaviors. |
| Nebulous Liberations enemies | `ezlibs-custom/nebulous-liberations/liberations/enemy.lua`, `enemy_templates.lua`, `enemies/*.lua` | Combat entities with instance state, AI, abilities, projectiles, loot, and encounter cleanup. Keep the enemy abstraction rather than forcing it through `eznpcs`. |
| Nebulous Liberations projectiles and effects | enemy files and `utils/*_effect.lua` | Auxiliary combat bots with ability-specific lifetimes. Can use a shared bot utility layer later; they should not be NPC behavior objects. |

## Spawn patterns identified

1. **Static map NPC** — `NPC` object is loaded and registered to a bot placeholder.
2. **Player-exclusive NPC** — created per player and excluded from other players.
3. **Quest-exclusive NPC** — created per player when quest state matches.
4. **Template-only NPC** — reusable NPC definition that does not create its own standalone bot.
5. **NPC Spawner instance** — one-shot or interval spawning from a template, with live count, trigger radius, max-alive cap, waypoint completion and optional warp-out.
6. **Temporary auxiliary bot** — created for a short effect or animation and removed on completion.
7. **Player representation bot** — temporarily represents or moves a player in a specialized world mechanic or minigame.
8. **Instance-owned game actor** — bot lifecycle belongs to a FootBomb or Liberations instance and ends when that instance/round/encounter is cleaned up.
9. **Group-linked world bot** — multiple bots/objects are coordinated by a system such as Rush Roads.

## New Tiled `NPC Behavior` format

- `Attached NPC`: object reference to the NPC or template.
- `Behavior`: registered implementation key; currently `Pushback`.
- `Enabled`: lets a map disable the behavior without deleting it.
- Pushback settings: collision width/height, push distance/duration/cooldown, movement animation state.

The runtime registers behavior objects during object preload and attaches after ordinary NPCs have been created. It also handles NPC instances created later for exclusive/quest NPCs and records NPC Spawner events so behavior objects work even if the spawner is encountered earlier in Tiled's object iteration order.

## Safety / compatibility rules

- Do not attach `Pushback` to a legacy `Pushback NPC`; the legacy type already registers its own collision behavior.
- Attach behavior objects to the template, not the spawner, when each spawned NPC instance should receive the behavior.
- Keep each behavior's resources bot-scoped and remove them on `bot_removed`.
- A behavior must not assume that an NPC template has one global live bot; a template can produce multiple bot IDs.
- `NPC Behavior` currently supports Pushback only. Other catalog entries above are an inventory and migration plan, not a claim that they have already been converted to behavior objects.
