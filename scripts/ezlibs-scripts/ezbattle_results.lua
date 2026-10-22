-- Stores the most recent battle_results payload per player so later lifecycle
-- events (such as battle_exit) can inspect or consume it.
local ezbattle_results = {}
local results_by_player = {}

function ezbattle_results.store(player_id, event)
    if player_id == nil or type(event) ~= "table" then
        return nil
    end

    -- Keep the original event payload intact; consumers may need fields that
    -- are not part of the normalized stats table used by existing plugins.
    results_by_player[player_id] = event
    return event
end

function ezbattle_results.peek(player_id)
    return results_by_player[player_id]
end

function ezbattle_results.consume(player_id)
    local event = results_by_player[player_id]
    results_by_player[player_id] = nil
    return event
end

function ezbattle_results.clear(player_id)
    results_by_player[player_id] = nil
end

return ezbattle_results
