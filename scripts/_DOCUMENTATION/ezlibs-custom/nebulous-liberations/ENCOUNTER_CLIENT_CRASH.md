# 🧪 Nebulous Liberations — Battle ZIP Provisioning & Client-Crash Diagnostics

[🏠 Nebulous Liberations index](index.md) · [📘 System README](README.md)

## The difference from Endless Runner

`ezencounters/main.lua` registers encounter ZIPs for **base areas** on startup. Endless Runner uses that regular encounter launch flow. Nebulous Liberations creates a **new cloned area per mission** and calls its own `PlayerSession:initiate_encounter()` / `Net.initiate_encounter()` path. Previously, it did not explicitly supply the encounter packages to that newly cloned area.

After this fix:

1. `Mission:new` clones the area and completes the ordinary Liberation preloader.
2. `PanelEncounters.provide_mission_encounter_assets(base_area_id, new_area_id)` loads that base area's `encounters`, `special_encounters`, and `bosses` tables, deduplicates their package paths, and calls the **existing** `Net.provide_asset(mission_area_id, path)` API.
3. Immediately before any panel or Dark Hole battle, `PanelEncounters.ensure_encounter_asset()` verifies the chosen ZIP was requested for the current instance. This also covers custom `Encounter Path` overrides.
4. On mission cleanup, `PanelEncounters.clear_mission_encounter_assets(area_id)` drops the per-instance cache.

These operations **do not** alter enemy selection, terrain formation, persistent enemy HP, battle scale, 3-turn Freedom Missions, or battle rewards. Liberation battles still have no EZEncounters battle rewards.

## Logs to inspect

| Subsystem log | Expected messages |
|---|---|
| `scripts/_DEBUGGING/nebulous-liberations/_ENCOUNTERS.log` | `Liberation encounter package provision requested`, `Liberation mission encounter asset preflight`, or `Could not provision liberation encounter package` |
| `scripts/_DEBUGGING/nebulous-liberations/_INSTANCE.log` | `Dispatching liberation encounter to client`, `Prepared panel encounter data`, and any `Liberation encounter aborted: battle package unavailable` |
| `scripts/_DEBUGGING/nebulous-liberations/_MAIN.log` | Respawn and lifecycle errors (separate from the initial client failure) |

The provision success log confirms that `Net.provide_asset()` was called without throwing on the server; it **does not prove** the client has downloaded and initialized the battle package. A client log is needed to identify a client-side mod error, missing dependency, or crash during spawning.

## November 11, 2026 example

- `16:54:28`: `LiberationEasyMode` instance created and player transferred.
- `16:54:41`: Dark Panel `(37, 10)` selected `Encounter3` with Rabiree, Swordy, and Cannodumb; all three enemy ranks and placement IDs are valid in the supplied encounter table.
- `16:54:59`: Player disconnected. The server received a failed-result fallback after the disconnect; this isn't a battle mod stack trace.
- Also logged: two Dark Hole enemy spawns skipped due to panel validation and no Liberation Respawn point found after disconnect. These are **separate issues**, not an established cause of the initial client disconnect.

## Verification steps

1. Back up and install the two Lua modules from the drop-in. Restart the server.
2. Enter Easy Liberation and check `_ENCOUNTERS.log`: the **instance area ID** (e.g. `liberation_<id>`) should have a successful package preflight before player transfer.
3. Liberate the same Dark Panel. Check `_INSTANCE.log` for a `Dispatching liberation encounter to client` entry.
4. If the client still exits, save the **client** log from that exact attempt. Look for mod ZIP load failures, missing character packages, asset errors, or a Lua error in `entry.lua` or an enemy mod. Do not change the encounter schema based only on the disconnect.
5. The separate missing respawn point / Dark Hole spawn warnings should be investigated independently.

## API signatures

| API | Arguments | Return | Behavior |
|---|---|---|---|
| `PanelEncounters.ensure_encounter_asset` | `area_id`, `package_path` | `boolean` | Sends one ZIP to the named area; deduplicates successful requests; failures are retryable |
| `PanelEncounters.provide_mission_encounter_assets` | `base_area_id`, `mission_area_id` | `success`, `requested`, `failures` | Discovers ZIPs from all three base-area sections and provides unique paths |
| `PanelEncounters.clear_mission_encounter_assets` | `mission_area_id` | none | Clears the per-instance provision cache |

**Testing boundary:** Source and mocked `Net.provide_asset()` tests have passed. OpenNetBattle client loading has not been verified live.


## Updated V2.1 area audit (November 11, 2026)

The follow-up code and map audit found invalid Easy Liberation OW pool links,
legacy Spawn index references, and old mission maps without the now-required
`Liberation Config` object. In addition, missing Freedom Mission fields were
standardized across the encounter definitions.

**The client crash itself is not conclusively resolved:** dependency-isolating
ZIP packages were provided for all 9 areas, modeled on the prior Easy
Liberation isolation test. Consult the [complete V2.1 audit](V21_ENCOUNTER_AND_MAP_AUDIT.md)
for exact encounter counts, map fixes, package regeneration requirements, and
remaining BlizzardMan/hub dependencies.

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
