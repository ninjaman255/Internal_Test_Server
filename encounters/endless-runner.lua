-- Canonical ezencounters table for the base area "endless-runner".
-- The runner and Nebulous Liberations both resolve encounter definitions
-- from their BASE area; neither writes entries for cloned area IDs.
--
-- Do not grant money in results_callback. ezencounters sends native battle
-- reward packets and persists the corresponding currency exactly once.
-- The runner supplies floor-specific overrides; outside the runner, enemy
-- defaults below can provide rewards without changing battle definitions.
local function log_encounter_results(player_id, encounter_info, stats)
    -- stats table contains: health, score, time, ran, emotion, turns, enemies
    if stats.ran then
        print("Player ran away.")
        return
    end
    if type(stats.health) ~= "number" or stats.health <= 0 then
        print("Player lost the battle.")
        return
    end
    print("Player won encounter " .. tostring(encounter_info.name) .. ".")
end

-- Define encounters
local Encounter1 = {
    name = "Encounter1",
    path = "/server/assets/ezlibs-assets/ezencounters/ezencounters-runner.zip",
    weight = 10,
    enemies = {
        { name = "Boomer", rank = 1 },
        { name = "WindBox", rank = 1 },
        { name = "Quaker", rank = 2 },
    },
    obstacles = {},
    positions = {
        { 0,0,0,0,0,2 },
        { 0,0,0,0,1,0 },
        { 0,0,0,0,0,3 },
    },
    obstacle_positions = {
        { 0,0,0,0,0,0 },
        { 0,0,0,0,0,0 },
        { 0,0,0,0,0,0 },
    },
    player_positions = {
        { 0,0,0,0,0,0 },
        { 0,1,0,0,0,0 },
        { 0,0,0,0,0,0 },
    },
    tiles = {
        { 1,1,1,1,1,1 },
        { 1,1,1,1,1,1 },
        { 1,1,1,1,1,1 },
    },
    teams = {
        { 2,2,2,1,1,1 },
        { 2,2,2,1,1,1 },
        { 2,2,2,1,1,1 },
    },
    results_callback = log_encounter_results,
}

-- Named boss encounter, explicitly selected from .bosses.
local BossTest = {
    name = "BossTest",
    path = "/server/assets/ezlibs-assets/ezencounters/ezencounters-runner.zip",
    weight = 0,
    enemies = {
        { name = "Boomer", rank = 1 },
    },
    obstacles = {},
    positions = {
        { 0,0,0,0,0,0 },
        { 0,0,0,0,1,0 },
        { 0,0,0,0,0,0 },
    },
    obstacle_positions = {
        { 0,0,0,0,0,0 },
        { 0,0,0,0,0,0 },
        { 0,0,0,0,0,0 },
    },
    player_positions = {
        { 0,0,0,0,0,0 },
        { 0,1,0,0,0,0 },
        { 0,0,0,0,0,0 },
    },
    tiles = {
        { 1,1,1,1,1,1 },
        { 1,1,1,1,1,1 },
        { 1,1,1,1,1,1 },
    },
    teams = {
        { 2,2,2,1,1,1 },
        { 2,2,2,1,1,1 },
        { 2,2,2,1,1,1 },
    },
    results_callback = log_encounter_results,
}

-- Second regular encounter, included in the weighted .encounters pool.
local Encounter2 = {
    name = "Encounter2",
    path = "/server/assets/ezlibs-assets/ezencounters/ezencounters-runner.zip",
    weight = 10,
    enemies = {
        { name = "Fishy", rank = 1 },
        { name = "Fishy", rank = 2 },
    },
    obstacles = {},
    positions = {
        { 0,0,0,0,1,0 },
        { 0,0,0,0,0,0 },
        { 0,0,0,0,0,2 },
    },
    obstacle_positions = {
        { 0,0,0,0,0,0 },
        { 0,0,0,0,0,0 },
        { 0,0,0,0,0,0 },
    },
    player_positions = {
        { 0,0,0,0,0,0 },
        { 0,1,0,0,0,0 },
        { 0,0,0,0,0,0 },
    },
    tiles = {
        { 1,1,8,1,1,1 },
        { 1,1,1,1,1,1 },
        { 8,1,1,1,1,1 },
    },
    teams = {
        { 2,2,2,1,1,1 },
        { 2,2,2,1,1,1 },
        { 2,2,2,1,1,1 },
    },
    results_callback = log_encounter_results,
}

-- Dedicated special pool. Uses the same complete ezencounters payload format
-- as normal and boss encounters; none of these are random overworld battles.
local SpecialTest = {
    name = "SpecialTest",
    path = "/server/assets/ezlibs-assets/ezencounters/ezencounters-runner.zip",
    weight = 1,
    enemies = {
        { name = "Fishy", rank = 2 },
        { name = "Quaker", rank = 2 },
    },
    obstacles = {},
    positions = {
        { 0,0,0,0,1,0 },
        { 0,0,0,0,0,0 },
        { 0,0,0,0,0,2 },
    },
    obstacle_positions = {
        { 0,0,0,0,0,0 },
        { 0,0,0,0,0,0 },
        { 0,0,0,0,0,0 },
    },
    player_positions = {
        { 0,0,0,0,0,0 },
        { 0,1,0,0,0,0 },
        { 0,0,0,0,0,0 },
    },
    tiles = {
        { 1,1,1,1,1,1 },
        { 1,1,1,1,1,1 },
        { 1,1,1,1,1,1 },
    },
    teams = {
        { 2,2,2,1,1,1 },
        { 2,2,2,1,1,1 },
        { 2,2,2,1,1,1 },
    },
    results_callback = log_encounter_results,
}

-- Canonical encounter table shared with ezencounters and Nebulous Liberations.
-- ezencounters rolls only from .encounters for ordinary walking battles.
-- Bosses and special encounters are explicit-only, but all three sections
-- are registered by name for scripted battles in the base area.
return {
    minimum_steps_before_encounter = 40,
    encounter_chance_per_step = 0.10,
    -- Optional enemy fallback: used ONLY when no runtime, encounter, or area
    -- rewards configuration is present. Combined for each configured enemy.
    -- This also gives standalone area battles a native reward screen.
    enemy_rewards = {
        Boomer  = { money = { base = 25, score_multiplier = 2 } },
        WindBox = { money = { base = 20, score_multiplier = 2 } },
        Quaker  = { money = { base = 30, score_multiplier = 2 } },
        Fishy   = { money = { base = 15, score_multiplier = 2 } },
    },
    encounters = {
        Encounter1,
        Encounter2,
    },
    bosses = {
        BossTest,
    },
    special_encounters = {
        SpecialTest,
    },
}
