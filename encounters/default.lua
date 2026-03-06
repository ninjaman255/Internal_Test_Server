-- Example encounter table for a specific area.
-- Save this as something like encounters/area_name.lua
-- Then require it in your area configuration.

-- Helper function to persist health after battle (optional)
local function persist_health_and_emotion(player_id, encounter_info, final_stats)
    -- Implement your own persistence logic here, e.g., using ezmemory
    print("Player", player_id, "ended with health", final_stats.health, "emotion", final_stats.emotion)
end

-- Example rewards callback
local function give_result_awards(player_id, encounter_info, stats)
    -- stats table contains: health, score, time, ran, emotion, turns, enemies
    if stats.ran then
        -- Player ran away, maybe no rewards or penalty
        print("Player ran away, no rewards.")
        return
    end

    if stats.health <= 0 then
        -- Player lost, maybe deduct something or give nothing
        print("Player lost the battle.")
        return
    end

    -- Player won: give rewards
    -- Example: give 100 zenny and 10 bug fragments
    -- Note: you need access to ezmemory or appropriate APIs
    -- ezmemory.add_player_money(player_id, 100)
    -- ezmemory.add_player_fragments(player_id, 10)
    print("Player won! Giving 100 zenny and 10 fragments.")

    -- Persist health and emotion if needed
    persist_health_and_emotion(player_id, encounter_info, stats)
end

-- Define encounters
local Encounter1 = {
    name = "Encounter1",
    path = "/server/assets/ezlibs-assets/ezencounters/ezencounters.zip",
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
    results_callback = give_result_awards,
}

-- Define Encounter2 through Encounter10 similarly (as in the provided list)
-- For brevity, I'll include only a couple, but you can add all.

local Encounter2 = {
    name = "Encounter2",
    path = "/server/assets/ezlibs-assets/ezencounters/ezencounters.zip",
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
    results_callback = give_result_awards,
}

-- ... (add all other encounters as needed)

-- Return the encounter table for this area
return {
    minimum_steps_before_encounter = 40,
    encounter_chance_per_step = 0.10,
    encounters = {
        Encounter1,
        Encounter2,
        -- Encounter3, Encounter4, ... add them all
    },
}