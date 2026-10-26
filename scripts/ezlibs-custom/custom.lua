-- Custom plugin aggregator.
-- Keep custom gameplay modules here so ezlibs' main dispatcher can fan out
-- event callbacks to each module without duplicate Net:on subscriptions.

local ezbus = require("scripts/ezlibs-scripts/ezbus")

-- =========================================================================
-- Endless Runner
-- =========================================================================

local EndlessRunner = require("scripts/ezlibs-custom/endless-runner/endless-runner")

local ENDLESS_RUNNER_BASE_AREA = "endless-runner"

-- A floor plan defining the run's structure.
-- Each floor is created by cloning its `area_id` into a fresh instance.
-- `encounters` = number of encounter wins required to advance.
-- `is_reward` = true → no encounters, rewards applied on entry; the
--   module will auto-advance after `auto_advance_after` seconds if set.
-- `special` = true → just a marker you can read in ezbus events.
-- `rewards` = array of reward tables; `hp` rewards are applied inline,
--   other types fire `endless_runner_reward` for your game to handle.
-- `heal` = HP restored on floor entry.
-- `on_enter` / `on_complete` = optional callbacks.
local ENDLESS_RUNNER_FLOOR_PLAN = {
    -- Floor 1: warmup, 2 encounters, no reward
    { area_id = "endless-runner", encounters = 2, heal = 20 },
    -- Floor 2: normal, 3 encounters
    { area_id = "endless-runner", encounters = 3, heal = 10 },
    -- Floor 3: boss encounter
    { area_id = "endless-runner", encounters = 1, special = true },
    -- Floor 4: reward break (no encounters, auto-advance after 2s)
    {
        area_id             = "endless-runner",
        is_reward           = true,
        rewards             = {
            { type = "hp",   amount = 30 },
            { type = "chip", id = "speed_boost" },
            { type = "chip", id = "spread_shot" },
        },
        auto_advance_after  = 2.0,
    },
    -- Floor 5: final gauntlet
    { area_id = "endless-runner", encounters = 5 },
}

local ENDLESS_RUNNER_ENTER_OPTIONS = {
    loop            = true,
    lock_input      = true,
    max_hp          = 100,
    starting_hp     = 100,
    heal_per_floor  = 15,
    floor_plan      = ENDLESS_RUNNER_FLOOR_PLAN,
    -- Optional: override how encounters are started. If omitted, the module
    -- uses ezencounters.begin_encounter_by_name(pid, name, trigger_obj).
    -- encounter_starter = function(player_id, encounter_name, trigger_obj)
    --     return ezencounters.begin_encounter_by_name(player_id, encounter_name, trigger_obj)
    -- end,
}

EndlessRunner.setup({
    base_area_id  = ENDLESS_RUNNER_BASE_AREA,
    enter_options = ENDLESS_RUNNER_ENTER_OPTIONS,
})

-- Intercept custom warps into the base area so the run starts cleanly.
ezbus:on("custom_warp", function(event)
    EndlessRunner.handle_custom_warp(event, {
        base_area_ids       = { ENDLESS_RUNNER_BASE_AREA },
        enter_options       = ENDLESS_RUNNER_ENTER_OPTIONS,
        fallback_to_vanilla = true,
    })
end)

-- Observe (but do NOT re-dispatch) the encounter event. The module's
-- built-in start_encounter() already drives the fade → battle → counter →
-- floor-advance lifecycle using its encounter_starter. Calling
-- start_encounter here again would be a duplicate.
ezbus:on("endless_runner_encounter_triggered", function(payload)
    print("[runner] encounter triggered for " .. tostring(payload.player_id)
        .. ": " .. tostring(payload.encounter_name))
end)

-- Deliver non-HP rewards (chips, items, buffs). HP rewards are handled
-- inline by the module (runner_heal); everything else routes here.
ezbus:on("endless_runner_reward", function(payload)
    local pid = payload.player_id
    local r = payload.reward
    print("[runner] " .. tostring(pid) .. " floor "
        .. tostring(payload.floor_index) .. " reward: " .. tostring(r.type))
    -- TODO: wire to your inventory/chip system. Examples:
    --   if r.type == "chip" then inventory:grant_chip(pid, r.id) end
    --   if r.type == "item" then inventory:grant_item(pid, r.id, r.amount or 1) end
    --   if r.type == "buff" then status_effects:add(pid, r.id, r.duration) end
end)

-- Optional: life-cycle logging for debug/telemetry
ezbus:on("endless_runner_encounter_started", function(payload)
    print("[runner] encounter started: " .. tostring(payload.encounter_name))
end)

ezbus:on("endless_runner_encounter_finished", function(payload)
    print("[runner] encounter " .. (payload.won and "won" or "lost")
        .. " hp=" .. tostring(payload.hp))
end)

ezbus:on("endless_runner_floor_started", function(payload)
    print("[runner] " .. tostring(payload.player_id) .. " entered floor "
        .. tostring(payload.floor_index))
end)

ezbus:on("endless_runner_floor_completed", function(payload)
    print("[runner] " .. tostring(payload.player_id) .. " cleared floor "
        .. tostring(payload.floor_index))
end)

ezbus:on("endless_runner_run_completed", function(payload)
    print("[runner] " .. tostring(payload.player_id) .. " completed run! "
        .. tostring(payload.floors_cleared) .. " floors cleared, final hp "
        .. tostring(payload.final_hp))
end)

ezbus:on("endless_runner_run_ended", function(payload)
    print("[runner] " .. tostring(payload.player_id) .. " run ended ("
        .. tostring(payload.reason) .. ") at floor "
        .. tostring(payload.floor_index) .. ", hp=" .. tostring(payload.final_hp))
end)

ezbus:on("endless_runner_hp_changed", function(payload)
    print("[runner] " .. tostring(payload.player_id) .. " hp "
        .. tostring(payload.previous_hp) .. " -> " .. tostring(payload.hp)
        .. " / " .. tostring(payload.max_hp))
end)

-- =========================================================================
-- Plugin fan-out
-- =========================================================================

local plugins = {
    require("scripts/ezlibs-custom/nebulous-liberations/main"),
    require("scripts/ezlibs-custom/footbomb/main"),
    EndlessRunner,
}

local custom = {}

local function dispatch(method_name, ...)
    local results = nil
    for _, plugin in ipairs(plugins) do
        local handler = plugin and plugin[method_name]
        if type(handler) == "function" then
            local result = handler(...)
            if result ~= nil then results = result end
        end
    end
    return results
end

-- handle_custom_warp is intentionally omitted: it needs the second `options`
-- argument the generic dispatcher does not pass, and it's wired explicitly
-- via ezbus:on("custom_warp", ...) above.
local forwarded_methods = {
    "on_tick",
    "handle_tile_interaction",
    "handle_object_interaction",
    "handle_actor_interaction",
    "handle_textbox_response",
    "handle_battle_results",
    "handle_battle_exit",
    "handle_player_avatar_change",
    "handle_player_transfer",
    "handle_player_request",
    "handle_player_disconnect",
    "handle_player_move",
    "handle_player_join",
    "handle_post_selection",
    "handle_board_close",
    "handle_shop_purchase",
    "handle_shop_close",
}

for _, method_name in ipairs(forwarded_methods) do
    custom[method_name] = function(...)
        return dispatch(method_name, ...)
    end
end

return custom