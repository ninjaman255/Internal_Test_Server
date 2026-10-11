# FootBomb Ref NPC

This custom ezlibs plugin adds the `FootBomb Ref` Tiled object type to `areas/footbomb.tmx`.

## Interaction flow

1. The `FootBomb Ref` object is registered by the object registry and creates a visible bot directly with `Net.create_bot(...)`, following the spawn and actor-interaction pattern used by `scripts/simon-says.lua`. The Tiled object is a point reference; the spawned bot is positioned at that point.
2. Interacting with the reference sends the configured intro message.
3. The NPC asks whether the player wants to join a FootBomb party.
4. Choosing **Yes** creates a private area instance from the configured `Instance Map` (default: `footbomb`) using `ezmapinstance.lua`.
5. If the player is already in a Nebulous Liberations party, available members of that party are included. Otherwise, a one-player FootBomb party is created for the instance.
6. The instance record tracks its host, party ID, members, and game metadata. Members are transferred to the map spawn position when available, with a safe fallback beside the NPC.
7. When all tracked players leave or disconnect, the empty instance area is removed.

Choosing **No** sends the declined message and does not create an instance.

## Tiled properties

The custom type reuses the standard `NPC` properties from `scripts/ezlibs-types.json`, including `Direction`, `Asset Name`, `Animation Name`, `Mug Animation Name`, `Dont Face Player`, and the standard dialogue-related properties. The FootBomb-specific properties are:

| Property | Default | Purpose |
|---|---|---|
| `Instance Map` | `footbomb` | Source area cloned by `ezmapinstance`. |
| `Intro Message` | `Hey! Want to play a round of FootBomb?` | Message shown before the question. |
| `Question` | `Would you like to join a FootBomb party and enter the field?` | Yes/no prompt. |
| `Declined Message` | `No problem. Come back when you're ready.` | Message after declining. |
| `Started Message` | `All right! I'll get your party onto the field.` | Message shown after accepting and before the transfer. |
| `Spawn X`, `Spawn Y`, `Spawn Z` | `26`, `21`, `0` | Fallback spawn coordinates if the engine does not report a spawn position for the cloned or source map. |

`Direction` defaults to `Down`. `Asset Name` defaults to `male-navi-exe6_teal` and should correspond to an NPC sprite in `/server/assets/ezlibs-assets/eznpcs/sheet/`. `Mugshot` should correspond to an image in `/server/assets/ezlibs-assets/eznpcs/mug/` when set.

## Integration

- `scripts/ezlibs-scripts/ezmapinstance.lua` owns instance creation, membership, host tracking, transfers, and removal.
- `scripts/simon-says.lua` is the reference pattern for direct bot creation and `actor_interaction` handling.
- `scripts/ezlibs-scripts/object_registry.lua` registers and caches the `FootBomb Ref` map object.
- `scripts/ezlibs-custom/custom.lua` fans events out to the Nebulous Liberations plugin and this FootBomb plugin.

The instance is a cloned map and party-membership record; this plugin does not implement the actual FootBomb match rules, scoring, or end-of-match flow.
