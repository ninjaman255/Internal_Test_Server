# ⚔️ Encounter Lua — Source Field Inventory

[🏠 Documentation home](index.md) · [⚔️ Browse encounter files](encounters/index.md)

## About this inventory

This is a **static inventory of authored keys**, not a normative schema. Keys can occur in nested tables and are not necessarily accepted by `ezencounters` or the battle engine. For authoritative behavior, inspect the current [`ezencounters/main.lua`](ezlibs-scripts/ezencounters/main/index.md), [`ezencounters/rewards.lua`](ezlibs-scripts/ezencounters/rewards/index.md) and [`panel_encounters.lua`](ezlibs-custom/nebulous-liberations/liberations/panel_encounters/index.md) references.

## Observed keys in multiple encounter files

| Key | Source files | Example source file | Example source initializer |
|---|---|---|---|
| `encounter_chance_per_step` | 23 | `encounters/Chichi.lua` | 0.05 |
| `encounters` | 23 | `encounters/Chichi.lua` | {Encounter1,Encounter2,Encounter3,Encounter4} |
| `minimum_steps_before_encounter` | 23 | `encounters/Chichi.lua` | 80 |
| `enemies` | 18 | `encounters/Chichi.lua` | { {name="Swordy",rank=3}, {name="Zomon",rank=5}, } |
| `name` | 18 | `encounters/Chichi.lua` | "Chichi_Encounter1" |
| `obstacle_positions` | 18 | `encounters/Chichi.lua` | { {0,0,0,0,0,0}, {0,0,0,0,1,0}, {0,0,0,0,0,0}, } |
| `obstacles` | 18 | `encounters/Chichi.lua` | { {name="Rock"}, } |
| `path` | 18 | `encounters/Chichi.lua` | "/server/assets/ezlibs-assets/ezencounters/ezencounters.zip" |
| `player_positions` | 18 | `encounters/Chichi.lua` | { {0,0,0,0,0,0}, {0,1,0,0,0,0}, {0,0,0,0,0,0}, } |
| `positions` | 18 | `encounters/Chichi.lua` | { {0,0,0,2,0,0}, {0,0,0,0,0,0}, {0,0,0,1,0,0}, } |
| `teams` | 18 | `encounters/Chichi.lua` | { {2,2,2,1,1,1}, {2,2,2,1,1,1}, {2,2,2,1,1,1}, } |
| `tiles` | 18 | `encounters/Chichi.lua` | { {1,1,1,1,1,1}, {11,11,11,11,11,11}, {1,1,1,1,1,1}, } |
| `weight` | 18 | `encounters/Chichi.lua` | 10 |
| `bosses` | 17 | `encounters/Chichi.lua` | {} |
| `special_encounters` | 17 | `encounters/Chichi.lua` | {} |
| `enabled` | 7 | `encounters/DEBUGLIB.lua` | true |
| `player_can_flip` | 7 | `encounters/DEBUGLIB.lua` | false |
| `turn_count` | 7 | `encounters/DEBUGLIB.lua` | 3 |
| `freedom_mission` | 4 | `encounters/example liberation friendly.lua` | { enabled=true, turn_count=3, player_can_flip=false } |

## Additional source-backed navigation

- The `encounters/` index links to **every Lua encounter definition in this snapshot**, including `DEBUGLIB.lua` and `NewLiberation1.lua`.
- Field presence in an encounter file does not establish compatibility with every caller, reward handler, or special encounter mode.
