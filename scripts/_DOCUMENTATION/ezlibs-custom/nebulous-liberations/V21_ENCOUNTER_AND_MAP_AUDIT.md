# ⚔️ Nebulous Liberations — V2.1 encounter and map audit

[🏠 Documentation home](../../index.md) · [⬆ Nebulous Liberations index](index.md)

## Contents

- [Findings](#findings)
- [Map inventory](#map-inventory)
- [V2.1 encounter schema](#v21-encounter-schema)
- [Mission-scoped battle packages](#mission-scoped-battle-packages)
- [Runtime validation](#runtime-validation)
- [Known limitations](#known-limitations)
- [Regression checklist](#regression-checklist)

## Findings

Audited the current imported Golden Prog/Cyan mission maps, the current
`DEBUGLIB.lua`/`DEBUGLIB.tmx` reference, `panel_encounters.lua`, `instance.lua`,
`player_session.lua`, the EZEncounters server loader, and the `entry.lua` inside
the packaged EZEncounters battle ZIP. Both the working Endless Runner path and
the global EZEncounters ZIP are left untouched.

- Converted **80 encounter entries across 9 area files** to direct grouped
  `return { encounters, special_encounters, bosses }` definitions.
- Explicit Freedom Mission defaults are `enabled=true`, `turn_count=3`,
  `player_can_flip=false` for entries that lacked them. Surrounded terrain
  still controls runtime flips in `instance.lua`.
- `no_battle_rewards=true` is authored on every mission entry; the runtime also
  forces it on the per-battle copy. Mission-panel loot remains separate.
- Preserved every preexisting enemy position, team layout, obstacle, tile
  state, and other battle override. `DEBUGLIB` encounters which previously
  omitted positions now use explicit, ordinary 6x3 enemy-side placements.
- Added `Liberation Config` objects to 3 older missions. Corrected bad
  `Next Spawn` links, preserving the existing reverse/forward spawn chains.
- Removed 5 invalid `OW Encounter Pool=157` links from Easy Liberation:
  object 157 is a `Dark Hole Encounter List`, **not** a `Liberation Encounter Pool`.
  The original `OW Bot Encounter=BigBrute` stays in place.
- Added a server-side encounter payload validator before sending any battle to
  the client. The loader now discovers Liberation maps through their config
  objects, rather than an obsolete area-level `Liberation Tileset` property.

## Map inventory

| TMX / encounter file | Normal | Special | Boss | Spawns | Changes to map |
|---|---:|---:|---:|---:|---|
| `DEBUGLIB` | 1 | 6 | 1 | 3 | No TMX changes |
| `LiberationEasyMode` | 8 | 1 | 1 | 3 | Removed invalid OW Encounter Pool ref from 50 to Dark Hole Encounter List #157; Removed invalid OW Encounter Pool ref from... |
| `LiberationNormalMode` | 8 | 4 | 1 | 4 | Corrected Next Spawn 3 2 -> 4; Corrected Next Spawn 4 3 -> 5; Corrected Next Spawn 5 4 -> 6; Corrected Next Spawn 6 1 -> 3 |
| `LiberationHardMode` | 8 | 5 | 1 | 5 | No TMX changes |
| `NewLiberation1` | 9 | 1 | 1 | 4 | Corrected Next Spawn 145 2 -> 146; Corrected Next Spawn 146 3 -> 147; Corrected Next Spawn 147 4 -> 148; Corrected Next Sp... |
| `testlib` | 4 | 1 | 1 | 13 | Set existing default Down facing explicitly on Spawn 1; Set existing default Down facing explicitly on Spawn 62; Set exist... |
| `testground` | 4 | 1 | 1 | 6 | Set existing default Down facing explicitly on Spawn 1; Set existing default Down facing explicitly on Spawn 7; Set existi... |
| `liberation1` | 4 | 1 | 1 | 3 | Corrected Next Spawn 2 2 -> 3; Set existing default Down facing explicitly on Spawn 2; Corrected Next Spawn 3 3 -> 4; Set ... |
| `example liberation friendly` | 4 | 1 | 1 | 3 | Set existing default Down facing explicitly on Spawn 1; Set existing default Down facing explicitly on Spawn 2; Set existi... |

### What the new Liberation Config object contains

For the 3 formerly legacy maps, the properties moved from map-level to the
`Liberation Config` object are `Liberation Tileset`, `Respawn Area`, and
`Waiting Area`. The `Max Order Points` fallback is **9**, from the existing
`Constants.Defaults.MaxOrderPoints`; the older areas did not define their
own higher cap. Optional properties absent from the original maps remain
optional. Neither existing player coordinates nor tile IDs were changed.

## V2.1 encounter schema

```lua
return {
    minimum_steps_before_encounter = 80,
    encounter_chance_per_step = 0.05,
    encounters = {
        {
            name = "Encounter1",
            path = "/server/assets/ezlibs-assets/ezencounters/ezencounters-liberation-<area>.zip",
            weight = 10,
            enemies = { { name = "Mettaur", rank = 1 } },
            positions = {
                { 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 1, 0 },
                { 0, 0, 0, 0, 0, 0 },
            },
            player_positions = {
                { 0, 0, 0, 0, 0, 0 },
                { 0, 1, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0 },
            },
            freedom_mission = {
                enabled = true,
                turn_count = 3,
                player_can_flip = false,
            },
            no_battle_rewards = true,
        },
    },
    special_encounters = {}, -- explicitly selected, never random
    bosses = {},             -- explicitly selected, never random
}
```

The literal `<area>` in the example is a placeholder; every delivered map
contains its own existing, concrete package path. Enemy ranks use the
packaged `enemy_ranks` mapping **0 through 7** (V1, V2, V3, SP, EX, Rare1,
Rare2, Nightmare). Matrices are **3 rows × 6 columns**. `positions` uses
1-based enemy indexes; `player_positions` uses battle player indexes.
`tiles`, `teams`, and `obstacle_positions` remain optional and retain authored
values. `freedom_mission.turn_count` is recognized by the current client
battle package.

## Mission-scoped battle packages

**This is a dependency-isolation change, not a confirmed client-crash fix.**
EZEncounters' global ZIP `package_requires_scripts()` unconditionally requires
every character in its catalog, including Roll. Endless Runner instead uses
a small package. Each delivered Liberation mission ZIP preserves the current
EZEncounters `entry.lua` battle behavior but limits
`Engine.requires_character()` to the aliases actually referenced by that
map, including registered maximum-HP variants for those aliases.

| Mission | Required aliases | Package file |
|---|---:|---|
| `DEBUGLIB` | 9 | `ezencounters-liberation-debuglib.zip` |
| `LiberationEasyMode` | 11 | `ezencounters-liberation-liberationeasymode.zip` |
| `LiberationNormalMode` | 15 | `ezencounters-liberation-liberationnormalmode.zip` |
| `LiberationHardMode` | 23 | `ezencounters-liberation-liberationhardmode.zip` |
| `NewLiberation1` | 25 | `ezencounters-liberation-newliberation1.zip` |
| `testlib` | 5 | `ezencounters-liberation-testlib.zip` |
| `testground` | 5 | `ezencounters-liberation-testground.zip` |
| `liberation1` | 5 | `ezencounters-liberation-liberation1.zip` |
| `example liberation friendly` | 5 | `ezencounters-liberation-example-liberation-friendly.zip` |

If an encounter editor later adds/removes enemy aliases, **regenerate that
mission-scoped package before deploying**. Otherwise the new character mod
will not be required. Other battle mods must remain installed on the server.
Regular `encounters/default.lua`, Endless Runner, and the original
`ezencounters.zip` are deliberately unchanged.

## Runtime validation

`PanelEncounters.validate_encounter_data(definition, package_path)` checks
package path, nonempty enemies, ranks, 6×3 matrices, duplicate or missing
1-based enemy position indexes, collisions with player start tiles, and
Freedom Mission turn values. Call with `package_path` for the already-built
battle payload because `build_encounter_data()` correctly strips `path`
before `Net.initiate_encounter()`.

An invalid battle is **not sent** to the client; an error goes to
`nebulous-liberations` encounter/instance diagnostics. This prevents one
category of malformed-data crashes but cannot guard mod-internal client errors.

## Known limitations

- **`testground` OW boss** is `BlizzardMan`, while its authored boss battle
  contains `ShadeMan`. The existing EZEncounters `enemy_packages` registry
  does not contain a `BlizzardMan` key or packaged battle character. This
  mismatch is left as-is instead of changing the intended overworld boss.
  For exact BlizzardMan battles, add a compatible character mod and update
  both the package's registry and testground's boss encounter.
- Some imported area configs refer to `undernet1`, `ooo`, or `christmas`
  for waiting/respawn. Those original hub maps were delivered in a *separate*
  reference bundle, and were not present in the latest six-map base archive.
  Deploy/merge those hubs or change the respective config destination in
  Tiled to a loaded area such as `default`.
- `DEBUGLIB` retains an **unused** Dark Hole Encounter List object #110
  with a large enemy-alias catalog, not just authored special-encounter names.
  The live lists #109/#111 reference valid special encounters. This unused
  catalog is preserved in the map; it is not validated as an active list.
- The earlier client disconnect was observed after battle dispatch, but no
  client stack trace established the exact crashing character mod. A scoped
  ZIP reduces dependencies; it does not guarantee against faulty mods.
- Replacing a map file overwrites any subsequent edits to that TMX. Merge
  changes if your live maps have advanced since the supplied archive.

## Regression checklist

1. Restart both client and server so old battle-package caching does not
   confuse dependency tests. Verify the installed 9 scoped ZIPs exist.
2. From the Golden Prog, launch **Easy Liberation**, liberate Dark Panel,
   then enter a Dark Hole and the boss battle. Check `_ENCOUNTERS.log` and
   `_INSTANCE.log` for package paths and no validation errors.
3. Repeat one ordinary battle on Normal, Hard, DEBUGLIB, and older missions.
4. Check Next Spawn rotations on Normal, NewLiberation1, and liberation1.
5. Check correct 3-turn Freedom Mission behavior; run from surrounded terrain
   to verify the player-flip logic is unchanged.
6. Verify no battle-result loot and that mission/panel rewards remain intact.
7. Test Endless Runner separately to confirm it still loads its original ZIP.
8. Capture client logs if a crash persists. Character package failures remain
   a separate possibility from malformed encounter tables.

## November 11, 2026 — scoped ZIP lookup regression fixed

**Root cause confirmed by a client Lua stack trace:** The nine mission-scoped
EZEncounters ZIPs in the V2.1 drop-in removed `get_package_id(alias)` while
keeping `select_enemy_character_package()` and `package_build()`, which call it.
The client therefore raised `attempt to call a nil value (global 'get_package_id')`
at `entry.lua:223` when creating enemy spawners, then reported
`Current mob was empty when battle started`.

The corrected ZIPs restore the original EZEncounters alias lookup:

```lua
function get_package_id(alias)
    return encounter_info.enemy_packages[alias]
end
```

No other battle-builder code, package IDs, dependency lists, or packaged artwork
has changed. This patch replaces all nine mission-scoped ZIPs; it does not
modify map XML, server encounter tables, the regular EZEncounters package, or
Endless Runner. Restart the server and client to test the updated packages.

Other client log errors such as duplicated **player-mod package IDs**, missing
player portrait textures, an empty image path, and a shader uniform warning are
separate from this confirmed Lua error. Address them independently if they
persist after battle spawners begin working.
