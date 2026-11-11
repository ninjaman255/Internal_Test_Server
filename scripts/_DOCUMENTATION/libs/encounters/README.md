# Encounter Tables

Encounter tables are Lua modules stored at `encounters/<area_id>.lua`. Ordinary maps and Nebulous Liberation base areas use the same area-level structure.

The loader registers `encounters`, `bosses`, and `special_encounters` for every area. **Only `encounters` participates in random step-based selection.** Bosses and special encounters are explicit-only categories and are available on non-liberation maps too.

## 1. Area-level table

```lua
return {
    minimum_steps_before_encounter = 8,
    encounter_chance_per_step = 0.04,

    encounters = {
        -- ordinary random encounters
    },

    bosses = {
        -- explicit-only boss battles
    },

    special_encounters = {
        -- explicit-only map-specific encounters
    },
}
```

`bosses` and `special_encounters` are optional for old area files. Include them in new area files even when empty so map-specific special cases have a clear home.

## 2. Encounter entry format

```lua
local StreetEncounter = {
    name = "StreetEncounter",
    path = "/server/assets/ezlibs-assets/ezencounters/ezencounters.zip",
    weight = 10,

    enemies = {
        { name = "Mettaur", rank = 1 },
        { name = "Cannodumb", rank = 1 },
    },
    obstacles = {},

    -- Enemy index per cell; 0 means no enemy.
    positions = {
        {0, 0, 0, 1, 0, 0},
        {0, 0, 0, 0, 0, 2},
        {0, 0, 0, 0, 0, 0},
    },

    -- Player ID per cell; 0 means no player spawn.
    player_positions = {
        {0, 0, 0, 0, 0, 0},
        {0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0},
    },

    -- Obstacle index per cell; 0 means no obstacle.
    obstacle_positions = {
        {0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0},
    },

    -- Tile-state indexes. 1 is the normal tile state.
    tiles = {
        {1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1},
    },

    -- Team 1 = enemy territory; team 2 = player territory.
    teams = {
        {2, 2, 2, 1, 1, 1},
        {2, 2, 2, 1, 1, 1},
        {2, 2, 2, 1, 1, 1},
    },

    -- Optional. Basename only; no `music/` prefix or `.mid` extension.
    music = {
        path = "bn4_battle",
        loop_start = 0,
        loop_end = 0,
    },

    -- Optional; omit when no Freedom Mission is wanted.
    freedom_mission = {
        enabled = true,
        turn_count = 3,
        player_can_flip = false,
    },
}
```

Each matrix is exactly three rows by six columns. The package uses one-based tile-state indexes. `tiles` value `1` maps to the engine's normal tile state. Position matrices use `0` for an empty cell.

### Terrain is runtime-only

Do **not** add `terrain` to an encounter definition. The caller supplies terrain when starting a battle. The shared encounter package reads `data.terrain` from the `initiate_encounter` data payload and applies the formation to the 6×3 battlefield.

For a direct start, the payload shape is:

```lua
local encounter_data = {
    enemies = {
        { name = "Mettaur", rank = 1 },
        { name = "Cannodumb", rank = 1 },
    },
    terrain = "advantage",
    -- Other encounter data (music, matrices, obstacles, etc.)
}

Net.initiate_encounter(player_id, encounter_path, encounter_data)
```

When using the ezencounters helper, pass runtime-only context as its fourth argument. The third argument remains the optional trigger object:

```lua
local runtime_data = { terrain = "surrounded" }
await(ezencounters.begin_encounter(player_id, encounter_definition, trigger_object, runtime_data))
```

For a named encounter:

```lua
await(ezencounters.begin_encounter_by_name(
    player_id,
    "StreetBossBattle",
    trigger_object,
    { terrain = "even" }
))
```

Runtime data is merged into a fresh payload and does not mutate the cached area encounter definition.

## 3. Terrain-generated formations

The shared `ezencounters` package uses these team layouts when `data.terrain` is one of the four recognized values and `teams` is omitted:

| Runtime terrain | Player team 2 | Enemy team 1 |
|---|---|---|
| `advantage` | columns 1–4 | columns 5–6 |
| `disadvantage` | columns 1–2 | columns 3–6 |
| `even` | columns 1–3 | columns 4–6 |
| `surrounded` | columns 3–4 | columns 1–2 and 5–6 |

The shared package then normalizes placements:

- A player already on team 2 stays where they are. A player on another team's tile is moved to the nearest available team-2 tile, preferring the same row.
- An enemy already on team 1 stays where possible. An enemy on another team's tile is moved to an available team-1 tile.
- If `positions` is absent, enemy spawn positions are generated from the enemy list.
- In `surrounded`, enemies are split as evenly as possible between the two flanks. Existing valid flank positions are retained where possible, and enemies face inward toward the nearest player position.
- If `teams` is authored, it remains authoritative and is used when validating and relocating positions.
- If `tiles` is absent, the whole field is filled with tile matrix value `1` (normal). Authored `tiles` are never rewritten by terrain generation.

The package cannot invent a player ID. Supply `player_positions` when the encounter package needs to explicitly spawn players. If there are more enemies or players than available owned cells, the package logs a warning for entries it cannot place.

## 4. Regular map example with runtime terrain

Regular encounters can use the same automatic formation behavior as liberation battles. The difference is only where terrain comes from: the regular encounter caller supplies it at battle start rather than storing it in the area encounter table.

```lua
local RegularEncounter = {
    name = "StreetEncounter",
    path = "/server/assets/ezlibs-assets/ezencounters/ezencounters.zip",
    enemies = {
        { name = "Mettaur", rank = 1 },
        { name = "Rabiree", rank = 1 },
    },
    -- Omit teams/positions to let runtime terrain generate them.
    -- Omit tiles to use a full field of normal tiles.
}

-- Stored in the area file without a terrain field.
```

When the map logic starts this encounter, it supplies `{ terrain = "advantage" }` in the runtime data payload. If a map needs full manual control instead, author `teams`, `positions`, and `player_positions` in the encounter entry. Any manually authored `teams` matrix remains authoritative even when terrain is supplied.

## 5. Liberation encounter setup

Liberation uses the exact same encounter entry structure and shared formation logic. The liberation runtime calculates terrain from the panels surrounding the player and passes it in the `initiate_encounter` data payload. No `terrain` property belongs in the encounter Lua table.

```lua
local LiberationVirusEncounter = {
    name = "LiberationVirusEncounter",
    path = "/server/assets/ezlibs-assets/ezencounters/ezencounters.zip",
    enemies = {
        { name = "Mettaur", rank = 1 },
        { name = "Rabiree", rank = 1 },
    },
    obstacles = {},

    -- Optional manual overrides. Omit matrices to let the runtime terrain
    -- create them. Existing placements are preserved when they fit the teams.
    -- positions = { ... },
    -- player_positions = { ... },
    -- teams = { ... },

    -- Authored tile states are independent of terrain and are retained.
    tiles = {
        {1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1},
        {1, 1, 1, 1, 1, 1},
    },

    freedom_mission = {
        enabled = true,
        turn_count = 3,
        player_can_flip = false,
    },
}
```

### Liberation music in Tiled

1. Place a Tiled object with class/type **Music Definition** in the liberation base area.
2. Set `Path` to a song basename without `.mid`, relative to the encounter package's `music/` folder.
3. Set `Loop Start` and `Loop End`; both default to `0`.
4. On the area's **Liberation Config** object, set **Encounter Music** to reference that Music Definition object.

The runtime resolves the reference in the base area, validates the referenced object's type, and passes the resulting `music` table to every liberation encounter. A valid Liberation Config music definition overrides the encounter entry's own `music` table. An empty `Path` suppresses playback. If no valid reference is configured, the encounter's own music table is retained.

## 6. Bosses and special encounters on every map

Both sections are available on non-liberation maps and liberation base areas. They are explicit-only; they are never added to random step encounters.

```lua
return {
    minimum_steps_before_encounter = 8,
    encounter_chance_per_step = 0.04,
    encounters = { StreetEncounter },
    bosses = {
        {
            name = "StreetBossBattle",
            path = "/server/assets/ezlibs-assets/ezencounters/ezencounters.zip",
            enemies = { { name = "BigBrute", rank = 1 } },
            obstacles = {},
        },
    },
    special_encounters = {
        {
            name = "StreetSpecialBattle",
            path = "/server/assets/ezlibs-assets/ezencounters/ezencounters.zip",
            enemies = { { name = "Shademan", rank = 3 } },
            obstacles = {},
        },
    },
}
```

Use the existing `ezencounters.begin_encounter_by_name(player_id, name, ...)` path to explicitly start a registered named entry. The same categories are also used by the liberation runtime when an enemy is marked as a boss or special encounter.

## 7. Music table rules

```lua
music = {
    path = "bn4_battle", -- basename only
    loop_start = 0,
    loop_end = 0,
}
```

The shared package resolves a non-empty path to `<package>/music/<path>.mid` and calls `mob:stream_music(path, loop_start, loop_end)`. Do not include the `music/` prefix or `.mid` extension. Missing loop values default to `0`. An empty string is valid and disables music playback for that encounter. Shademan and HeelNavi packages use the same data contract while retaining their existing default tracks when no `music` table is supplied.

## 8. Backward compatibility

- Missing `bosses` and `special_encounters` sections remain valid.
- `freedom_mission.turn_count` and `freedom_mission.player_can_flip` remain supported; the package also accepts the older `turns` spelling.
- Existing manual matrices and obstacle definitions remain supported.
- `weight` remains an entry-level selection weight.
- `terrain` is runtime context only and must not be added to encounter definitions.
