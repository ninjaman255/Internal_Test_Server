-- tournament-core.lua
local TournamentCore = {}
local State = require("scripts/net-game-tourney/tournament-state")

-- -------------------------------------------------------------------------
-- Helpers (no state)
-- -------------------------------------------------------------------------

local function shuffle_table(values)
    local shuffled = {}
    for i = 1, #values do shuffled[i] = values[i] end
    for i = #shuffled, 2, -1 do
        local j = math.random(i)
        shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
    end
    return shuffled
end

local function normalize_config(config)
    config = config or {}
    config.pvp_mode = config.pvp_mode or "auto"
    config.battle_timeout_seconds = tonumber(config.battle_timeout_seconds) or (10 * 60)
    config.npc_only = config.npc_only == true
    config.winner_money_reward = math.max(0, math.floor(tonumber(config.winner_money_reward) or 0))
    config.winner_gp_reward = math.max(0, math.floor(tonumber(config.winner_gp_reward) or 0))
    config.deduct_opposing_team_gp = config.deduct_opposing_team_gp == true
    config.best_of = math.max(1, math.floor(tonumber(config.best_of) or 1))
    return config
end

-- -------------------------------------------------------------------------
-- Core API (uses State)
-- -------------------------------------------------------------------------

function TournamentCore.create_tournament(config)
    config = normalize_config(config)
    return State.create_tournament(config)
end

function TournamentCore.add_participant(tournament_id, participant)
    return State.add_participant(tournament_id, participant)
end

function TournamentCore.initialize_tournament(tournament_id)
    local tournament = State.get_tournament(tournament_id)
    if not tournament then
        print("[Core] Tournament not found: " .. tostring(tournament_id))
        return false
    end

    if #tournament.participants ~= 8 then
        print(string.format("[Core] Need 8 participants, have %d", #tournament.participants))
        return false
    end

    tournament.participants = shuffle_table(tournament.participants)
    for i, p in ipairs(tournament.participants) do
        p.original_index = i
    end

    local best_of = tournament.config.best_of or 1
    tournament.matches.round1 = {}
    for i = 1, 4 do
        local p1 = tournament.participants[(i * 2) - 1]
        local p2 = tournament.participants[i * 2]
        tournament.matches.round1[i] = {
            player1 = p1,
            player2 = p2,
            winner = nil,
            loser = nil,
            completed = false,
            best_of = best_of,
            battles = {},
            wins = { p1 = 0, p2 = 0 },
        }
        print(string.format("[Core] Round 1 Match %d: %s vs %s", i, p1.name, p2.name))
    end

    tournament.current_round = 0
    tournament.status = "created"
    State.initialize_positions(tournament_id)
    return true
end

function TournamentCore.initialize_positions(tournament_id)
    return State.initialize_positions(tournament_id)
end

function TournamentCore.calculate_round_positions(tournament_id, round)
    return State.calculate_round_positions(tournament_id, round)
end

function TournamentCore.update_positions(tournament_id, round)
    return State.update_positions(tournament_id, round)
end

-- New: record a single battle within a match series
function TournamentCore.record_battle(tournament_id, round, match_index, winner_id, loser_id, battle_index)
    return State.record_battle(tournament_id, round, match_index, winner_id, loser_id, battle_index)
end

-- Legacy: single battle (for backward compatibility)
function TournamentCore.record_battle_result(tournament_id, round, match_index, winner_id, loser_id)
    return State.record_battle_result(tournament_id, round, match_index, winner_id, loser_id)
end

function TournamentCore.get_npc_battle_result(tournament_id, round, match_index, npc1_id, npc2_id, battle_index)
    return State.get_npc_battle_result(tournament_id, round, match_index, npc1_id, npc2_id, battle_index)
end

function TournamentCore.is_round_complete(tournament_id, round)
    return State.is_round_complete(tournament_id, round)
end

function TournamentCore.advance_round(tournament_id)
    return State.advance_round(tournament_id)
end

function TournamentCore.complete_round(tournament_id)
    local tournament = State.get_tournament(tournament_id)
    if tournament then
        tournament.status = "round_complete"
        return true
    end
    return false
end

function TournamentCore.get_winner(tournament_id)
    return State.get_winner(tournament_id)
end

function TournamentCore.add_spectator(tournament_id, player_id, name)
    return State.add_spectator(tournament_id, player_id, name)
end

function TournamentCore.remove_spectator(tournament_id, player_id)
    return State.remove_spectator(tournament_id, player_id)
end

function TournamentCore.for_each_human_viewer(tournament_id, callback)
    local tournament = State.get_tournament(tournament_id)
    if not tournament or type(callback) ~= "function" then return end

    local seen = {}
    for _, p in ipairs(tournament.participants) do
        if p.type == "player" and p.wants_updates ~= false then
            seen[p.id] = true
            callback(p.id, p)
        end
    end

    for player_id, spectator in pairs(tournament.spectators or {}) do
        if not seen[player_id] and spectator.wants_updates ~= false then
            callback(player_id, spectator)
        end
    end
end

function TournamentCore.cleanup_tournament(tournament_id)
    State.delete_tournament(tournament_id)
end

function TournamentCore.handle_player_disconnect(player_id)
    -- Mark as disconnected in active tournament
    local tournament_id = State.get_player_tournament(player_id)
    if tournament_id then
        local tournament = State.get_tournament(tournament_id)
        if tournament then
            for _, p in ipairs(tournament.participants) do
                if p.type == "player" and p.id == player_id then
                    p.disconnected = true
                    break
                end
            end
        end
    end

    -- Remove spectator from any tournament
    for _, t in pairs(State.get_all_tournaments()) do
        if t.spectators then
            t.spectators[player_id] = nil
        end
    end

    State.remove_player_from_tournament(player_id) -- also clears player_tournaments
end

function TournamentCore.cleanup_orphaned_tournaments()
    State.cleanup_orphaned_tournaments()
end

function TournamentCore.get_tournament(tournament_id)
    return State.get_tournament(tournament_id)
end

function TournamentCore.get_player_tournament(player_id)
    return State.get_player_tournament(player_id)
end

function TournamentCore.is_player_in_tournament(player_id)
    return State.is_player_in_tournament(player_id)
end

return TournamentCore