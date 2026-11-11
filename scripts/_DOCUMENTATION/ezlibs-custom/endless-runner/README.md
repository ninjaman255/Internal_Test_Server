> **Centralized authored guide:** Relocated from `scripts/ezlibs-custom/endless-runner/README.md` in the current server. Preserved without rewriting the author’s content.

# Endless Runner — Shared Encounter Tables

The runner uses the same **base-area encounter-definition format** as `ezencounters` and Nebulous Liberations. Native rewards are resolved by `ezencounters` during managed battles' `battle_results` events and persistent money is recorded through `ezmemory`.

**Nebulous Liberations is explicitly excluded from battle rewards.** Its `PlayerSession` keeps initiating and resolving battles itself, without registering for the reward processor. It still receives its existing liberation-panel rewards, keys, trap handling and money discovered from Item Panels after successful liberations. No changes to `nebulous-liberations/liberations/player_session.lua` are required.

## Files

| File | Purpose |
|---|---|
| `encounters/endless-runner.lua` | Defines named, full battle entries under `encounters`, `bosses`, and `special_encounters`. |
| `scripts/ezlibs-custom/endless-runner/endless-runner.lua` | Selects the correct encounter and sends its floor reward override to `ezencounters` before battle. |
| `scripts/ezlibs-custom/custom.lua` | Configures each floor's `encounter_section`, wins required, and money rewards. |
| `scripts/ezlibs-scripts/ezmemory.lua` | Previous patch: persistent money grant API and runner instance memory cleanup. |

## Encounter table contract

Use exactly the sections registered by `ezencounters`:

```lua
return {
    minimum_steps_before_encounter = 40,
    encounter_chance_per_step = 0.10,
    encounters = {
        { name = "Encounter1", path = "/server/assets/.../ezencounters.zip",
          weight = 10, enemies = { { name = "Boomer", rank = 1 } },
          positions = { /* 3x6 grid */ }, tiles = { /* 3x6 */ },
          teams = { /* 3x6 */ }, player_positions = { /* 3x6 */ } },
    },
    bosses = { -- Named boss fights, not part of walking encounter rolls
        { name = "BossTest", path = "/server/assets/.../ezencounters.zip",
          enemies = { { name = "Boomer", rank = 1 } },
          positions = { /* 3x6 */ }, tiles = { /* 3x6 */ },
          teams = { /* 3x6 */ }, player_positions = { /* 3x6 */ } },
    },
    special_encounters = { -- Named special fights, not random walking rolls
        { name = "SpecialTest", path = "/server/assets/.../ezencounters.zip",
          enemies = { { name = "Fishy", rank = 2 } },
          positions = { /* 3x6 */ }, tiles = { /* 3x6 */ },
          teams = { /* 3x6 */ }, player_positions = { /* 3x6 */ } },
    },
}
```

The example above is schematic: `/* ... */` placeholders are explanatory, **not valid Lua**. The shipped `encounters/endless-runner.lua` contains valid, complete 3×6 grids and retains your existing enemy and map layout values.

`ezencounters` registers names from all three sections but only considers `encounters` for automatic walking encounters. `BossTest` was moved from the random `encounters` list to `bosses`. A new `SpecialTest` demonstrates the third section.

## Selecting a category by floor

```lua
floor_plan = {
    { area_id = "endless-runner", encounters = 2, encounter_section = "encounters" },
    { area_id = "endless-runner", encounters = 1, encounter_section = "bosses" },
    { area_id = "endless-runner", encounters = 2, encounter_section = "special_encounters" },
}
```

`encounters` is the default. Legacy `special = true` now selects `bosses` unless an explicit `encounter_section` is supplied. A missing or empty `bosses`/`special_encounters` section falls back to regular `encounters`, matching the current Nebulous Liberations selection behavior. The runner logs this fallback.

## Tiled trigger properties

Continue using a `Runner Rectangle Encounter` or `Runner Radius Encounter` object.

| Property | Meaning |
|---|---|
| `Encounter Category` | Optional section override: `encounters`, `bosses`, or `special_encounters`. `Encounter Section` also works. |
| `Encounter 1`, `Encounter 2`, ... | Optional names in the selected section. They filter the candidates **only if they match**. |
| `Encounters` | Alternative list of names, if the runtime provides it as a table. |
| `Encounter` / `Name` | Legacy single-name fallback. |
| `Pick Mode` | `random` (weighted by entry `weight`), `first`, or `cycle`. |
| `Once` | One trigger per floor instance when set to `true`. |

**Your existing map's trigger ID 212 lists `BossTest` three times.** On normal floors, those entries don't match `encounters`, so a normal encounter is chosen instead. On boss floors, `BossTest` is valid and used. On special floors, `SpecialTest` is selected from `special_encounters`. You may remove the hardcoded names entirely to make the trigger purely category-driven.

When named candidates are valid in the selected section, they take precedence over the full section. `random` respects the definitions' `weight` fields (default weight `1`; zero-weight entries aren't picked unless the total weight is zero). No names are ever pulled from another non-empty section.

## Starting an encounter

```lua
-- Choose a weighted encounter in the active floor's section:
EndlessRunner.start_encounter(player_id)

-- Explicit named start (the name must resolve in the BASE area's table):
EndlessRunner.start_encounter(player_id, "BossTest")
```

The existing optional custom starter signature `(player_id, encounter_name, trigger_obj)` is unchanged. The built-in starter resolves the canonical table through `ezencounters.get_encounter_by_name(name, base_area_id)` and passes it to `ezencounters.begin_encounter`. No separate encounter payload or registration system is created by the runner.

## Rewards and emitted events

The **encounter victory** money reward is now sent as a single native battle reward packet inside `battle_results` by `ezencounters`, then reconciled with persistent `ezmemory`. It is no longer paid again after the runner awaits the result. The configured `encounter_monies` amount becomes a runtime `rewards = { money = { base = amount } }` override. Use `encounter_rewards` on a floor for full custom reward configurations. A run that loses, draws or escapes cannot receive a battle reward. A reward-only floor still grants its standalone bonus after entering the floor; those bonuses are not battle packets.

Custom `encounter_starter` functions may accept a **fourth** `runtime_data` argument, and should forward it into `ezencounters.begin_encounter(player_id, definition, trigger_obj, runtime_data)`. Legacy three-argument functions still run, but a starter that completely bypasses `ezencounters` must explicitly opt into `ezencounters.register_external_battle` if it wants shared battle rewards. **Do not register Nebulous Liberations battles.** The runner will not double-pay custom starters.

The existing `endless_runner_encounter_triggered`, `endless_runner_encounter_started`, and `endless_runner_encounter_finished` payloads now include `encounter_section`. The triggered payload also includes `encounter_source` (`trigger_names` or `area_section`).

## Verification

Mocked integration tests cover Lua parsing; base-area lookup; normal/boss/special selection; native battle reward packet delivery; no duplicate post-battle payment; runtime money overrides; custom starter compatibility; reward-only floor bonuses; escapes; and instance cleanup. A live engine test is still required to verify native reward-screen timing and the server build's wallet update semantics.

Live ONB server integration is **not** confirmed by these mocks. Restart the server after replacing the Lua files so `ezencounters` reloads its cached encounter table at startup.
