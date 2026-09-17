-- main.lua
print("[Tournament System] Initializing...")

-- Requiring the current net-games module initializes the current Displayer/input stack.
require("scripts/net-games/main")

local TournamentManager = require("scripts/net-game-tourney/tournament-manager")
local TournamentUI = require("scripts/net-game-tourney/tournament-ui")

TournamentManager.init()

print("[Tournament System] Loaded and ready!")

Net:on("player_join", function(event)
    if event and event.player_id then
        TournamentUI.prewarm_player(event.player_id)
    end
end)

Net:on("object_interaction", function(event)
    if not event or not event.player_id or not event.object_id then return end
    if event.button ~= nil and event.button ~= 0 then return end

    local player_id = event.player_id
    local area_id = Net.get_player_area(player_id)
    local object = Net.get_object_by_id(area_id, event.object_id)

    if object and (object.type == "Tournament Board" or object.class == "Tournament Board") then
        TournamentManager.handle_board_interaction(player_id, object, area_id)
    end
end)

Net:on("battle_results", function(event)
    if event and event.player_id then
        TournamentManager.handle_battle_result(event.player_id, event)
    end
end)

Net:on("player_area_transfer", function(event)
    if event and event.player_id then
        TournamentManager.handle_player_area_transfer(event.player_id)
    end
end)

Net:on("player_disconnect", function(event)
    if not event or not event.player_id then return end

    -- Invalidate first. Do not call native sprite cleanup after the player object is gone.
    TournamentUI.invalidate_player_visual_jobs(event.player_id)
    TournamentManager.handle_player_disconnect(event.player_id)
end)

local orphan_cleanup_timer = 0
local queue_cleanup_timer = 0

Net:on("tick", function(event)
    local delta = tonumber(event and event.delta_time or 0) or 0
    orphan_cleanup_timer = orphan_cleanup_timer + delta
    queue_cleanup_timer = queue_cleanup_timer + delta

    if orphan_cleanup_timer >= 30 then
        TournamentManager.cleanup_orphaned_tournaments()
        orphan_cleanup_timer = 0
    end

    if queue_cleanup_timer >= 60 then
        TournamentManager.cleanup_expired_queues()
        queue_cleanup_timer = 0
    end
end)
