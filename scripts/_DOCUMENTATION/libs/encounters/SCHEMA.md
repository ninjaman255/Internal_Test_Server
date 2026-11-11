# Encounter Table Schema

The area encounter modules are Lua files at `encounters/<area_id>.lua`. The same area schema is used by ordinary maps and Nebulous Liberation base areas.

## Area module

```lua
return {
    minimum_steps_before_encounter = number,
    encounter_chance_per_step = number,
    encounters = { EncounterDefinition, ... },
    bosses = { EncounterDefinition, ... },          -- optional, explicit only
    special_encounters = { EncounterDefinition, ... }, -- optional, explicit only
}
```

Only `encounters` is eligible for random step encounters. `bosses` and `special_encounters` are registered for explicit starts and map-specific special cases. All three sections work on ordinary maps and liberation maps. Missing optional sections remain backward compatible.

## EncounterDefinition

```lua
{
    name = string,                  -- recommended; used for named starts
    path = string,                  -- encounter package path
    weight = number,                -- optional selection weight
    enemies = { EnemyDefinition, ... },
    obstacles = { ObstacleDefinition, ... },
    positions = Matrix6x3,          -- enemy index per cell; 0 = empty
    obstacle_positions = Matrix6x3, -- obstacle index per cell; 0 = empty
    player_positions = Matrix6x3,   -- player ID per cell; 0 = empty
    tiles = Matrix6x3,              -- tile-state index per cell
    teams = Matrix6x3,              -- team ID per cell; 1 = enemy, 2 = player
    freedom_mission = {
        enabled = boolean,
        turn_count = number,        -- legacy `turns` also accepted
        player_can_flip = boolean,
    },
    music = {
        path = string,              -- basename, no `music/` and no `.mid`
        loop_start = number,        -- optional, defaults to 0
        loop_end = number,          -- optional, defaults to 0
    },
}
```

**`terrain` is deliberately not part of `EncounterDefinition`.** It is runtime context passed to `Net.initiate_encounter(player_id, path, data)` or through the optional `runtime_data` argument of `ezencounters.begin_encounter(player_id, encounter_info, trigger_object, runtime_data)` / `ezencounters.begin_encounter_by_name(player_id, name, trigger_object, runtime_data)`.

Recognized runtime terrain values are `advantage`, `disadvantage`, `even`, and `surrounded`. The shared `ezencounters` package uses this value to generate a missing `teams` matrix and normalize `player_positions` and `positions` so players and enemies stand on their respective team tiles. `tiles` is independent of terrain: if absent, the package fills the 6×3 field with normal tile index `1`; if supplied, the authored matrix is retained.

### EnemyDefinition

```lua
{ name = string, rank = number, nickname = string?, health = number? }
```

`name` is a registered alias in the shared encounter package. Existing fields such as `starting_hp` and `max_hp` are passed through; their effects depend on package support.

### ObstacleDefinition

```lua
{ name = string }
```

### Matrix6x3

Each matrix has three rows and six columns. `positions[y][x]` references `enemies[index]`; `obstacle_positions[y][x]` references `obstacles[index]`; `player_positions[y][x]` contains the player ID to spawn at that cell. `tiles` stores one-based indexes into the shared package's `tile_states` list. `teams` stores team IDs.

The shared package's default tile matrix is all `1` (normal tile). In the tile-state lookup, matrix index `1` maps to engine tile state `0` (normal). Matrix value `0` is the empty marker for position matrices; it is not the normal tile index.

## Runtime terrain formations

| Runtime terrain | Team 2 (player) columns | Team 1 (enemy) columns |
|---|---|---|
| `advantage` | 1–4 | 5–6 |
| `disadvantage` | 1–2 | 3–6 |
| `even` | 1–3 | 4–6 |
| `surrounded` | 3–4 | 1–2 and 5–6 |

When runtime terrain is present:

- Missing `teams` is generated from the selected formation.
- Missing `positions` is generated for the listed enemies.
- Existing enemy positions on enemy-owned tiles are preserved where possible; positions outside enemy territory are relocated to the nearest available enemy-owned tile.
- In `surrounded`, enemies are distributed as evenly as possible between the left and right flanks. Valid flank placements are retained within that balance. Left-flank enemies face right; right-flank enemies face left (toward the nearest player position).
- Existing player positions on player-owned tiles are preserved. Players outside player territory are moved to the nearest available player-owned tile, preferring the same row and then the nearest column.
- Authored `tiles` are never changed by terrain generation.
- Authored `teams` remain authoritative. If `teams` is supplied, the runtime does not replace it with a generated team matrix; placement normalization uses the supplied ownership.

The package does not invent a player ID when `player_positions` is absent. Supply player positions when the package needs to explicitly spawn player IDs onto the field.

## Music Definition (Tiled)

Tiled class/type: **Music Definition**

| Property | Tiled type | Default | Meaning |
|---|---|---|---|
| `Path` | string | `""` | Song basename relative to the encounter package's `music/` folder; omit `.mid` |
| `Loop Start` | number | `0` | Passed to `mob:stream_music()` |
| `Loop End` | number | `0` | Passed to `mob:stream_music()` |

The shared package resolves a non-empty path as `<package>/music/<Path>.mid`, then calls `mob:stream_music(path, loop_start, loop_end)`. An empty path intentionally suppresses playback.

Tiled class/type **Liberation Config** has an `Encounter Music` object property referencing a **Music Definition** object. The liberation runtime resolves that reference in the base area and uses it as the music override for each liberation battle. If no valid reference is configured, the encounter definition's own `music` table remains in effect.
