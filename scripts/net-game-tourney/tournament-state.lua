-- tournament-state.lua
-- Central state store for all tournament data.
-- All mutation of tournament state must go through this module.

local State = {}

-- Core tables
local tournaments = {}             -- tournament_id -> tournament table
local player_tournaments = {}      -- player_id -> tournament_id (active participants)
local npc_results = {}             -- cache keyed by "tournamentId_round_matchIndex"
local next_tournament_id = 1

-- -------------------------------------------------------------------------
-- Tournament lifecycle
-- -------------------------------------------------------------------------

function State.create_tournament(config)
    local id = next_tournament_id
    next_tournament_id = next_tournament_id + 1

    local tournament = {
        id = id,
        config = config,
        participants = {},
        spectators = {},
        matches = { round1 = {}, round2 = {}, round3 = {} },
        status = "created",
        current_round = 0,
        host_id = config.host_id,
        winners = {},
        champion = nil,
        ui_state = { positions = {}, round = 0 },
        revealed_rounds = {},
        active_spectator_matches = {},
        created_time = os.time(),
    }

    tournaments[id] = tournament
    return id, tournament
end

function State.get_tournament(id)
    return tournaments[id]
end

function State.delete_tournament(id)
    local tournament = tournaments[id]
    if not tournament then return end

    -- Remove player associations
    for _, p in ipairs(tournament.participants or {}) do
        if p.type == "player" then
            player_tournaments[p.id] = nil
        end
    end

    -- Clear NPC results for this tournament
    local prefix = tostring(id) .. "_"
    for key in pairs(npc_results) do
        if string.find(key, "^" .. prefix) then
            npc_results[key] = nil
        end
    end

    -- Notify NPC module to clean its per‑tournament used list
    local tournament_npcs = require("scripts/net-game-tourney/tournament-npcs")
    tournament_npcs.cleanup_tournament_npcs(id)

    tournaments[id] = nil
end

function State.get_all_tournaments()
    return tournaments
end

-- -------------------------------------------------------------------------
-- Participant management
-- -------------------------------------------------------------------------

function State.add_participant(tournament_id, participant_data)
    local tournament = tournaments[tournament_id]
    if not tournament then return false, "Tournament not found" end

    if #tournament.participants >= 8 then
        return false, "Tournament is full"
    end

    if not participant_data or not participant_data.id then
        return false, "Invalid participant"
    end

    -- Check duplicates
    for _, p in ipairs(tournament.participants) do
        if p.id == participant_data.id then
            return false, "Participant already in tournament"
        end
    end

    if participant_data.type == "player" and player_tournaments[participant_data.id] then
        return false, "Player already in a tournament"
    end

    local stored = {
        id = participant_data.id,
        type = participant_data.type,
        name = participant_data.name or tostring(participant_data.id),
        mugshot = participant_data.mugshot,
        weight = tonumber(participant_data.weight) or 50,
        original_index = #tournament.participants + 1,
        eliminated = participant_data.eliminated == true,
        eliminated_round = participant_data.eliminated_round,
        disconnected = participant_data.disconnected == true,
        wants_updates = participant_data.wants_updates ~= false,
        spectating = participant_data.spectating == true,
    }

    table.insert(tournament.participants, stored)

    if stored.type == "player" then
        player_tournaments[stored.id] = tournament_id
    end

    return true
end

function State.remove_player_from_tournament(player_id)
    local tournament_id = player_tournaments[player_id]
    if not tournament_id then return false end

    local tournament = tournaments[tournament_id]
    if not tournament then
        player_tournaments[player_id] = nil
        return false
    end

    -- Remove participant from list
    for i, p in ipairs(tournament.participants) do
        if p.id == player_id and p.type == "player" then
            table.remove(tournament.participants, i)
            break
        end
    end

    player_tournaments[player_id] = nil
    return true
end

function State.get_player_tournament(player_id)
    return player_tournaments[player_id]
end

function State.is_player_in_tournament(player_id)
    return player_tournaments[player_id] ~= nil
end

-- -------------------------------------------------------------------------
-- Match results and round management
-- -------------------------------------------------------------------------

function State.record_battle_result(tournament_id, round, match_index, winner_id, loser_id)
    local tournament = tournaments[tournament_id]
    if not tournament then return false end

    local round_key = round == 1 and "round1" or (round == 2 and "round2" or "round3")
    local match = tournament.matches[round_key] and tournament.matches[round_key][match_index]
    if not match then return false end

    local winner, loser
    for _, p in ipairs(tournament.participants) do
        if p.id == winner_id then winner = p end
        if p.id == loser_id then loser = p end
        if winner and loser then break end
    end

    if not winner or not loser then return false end

    match.winner = winner
    match.loser = loser
    match.completed = true

    loser.eliminated = true
    loser.eliminated_round = round

    table.insert(tournament.winners, winner)

    return true
end

function State.get_npc_battle_result(tournament_id, round, match_index, npc1_id, npc2_id)
    local key = string.format("%d_%d_%d", tournament_id, round, match_index)
    if npc_results[key] then
        return npc_results[key]
    end

    local tournament = tournaments[tournament_id]
    if not tournament then return nil end

    local npc1, npc2
    for _, p in ipairs(tournament.participants) do
        if p.id == npc1_id then npc1 = p end
        if p.id == npc2_id then npc2 = p end
    end

    if not npc1 or not npc2 then return nil end

    local w1 = math.max(1, tonumber(npc1.weight or 50) or 50)
    local w2 = math.max(1, tonumber(npc2.weight or 50) or 50)
    local roll = math.random(1, w1 + w2)

    local result
    if roll <= w1 then
        result = { winner_id = npc1.id, loser_id = npc2.id }
    else
        result = { winner_id = npc2.id, loser_id = npc1.id }
    end

    npc_results[key] = result
    return result
end

function State.is_round_complete(tournament_id, round)
    local tournament = tournaments[tournament_id]
    if not tournament then return false end

    local round_key = round == 1 and "round1" or (round == 2 and "round2" or "round3")
    local matches = tournament.matches[round_key]
    if not matches or #matches == 0 then return false end

    for _, match in ipairs(matches) do
        if not match.completed then return false end
    end
    return true
end

function State.advance_round(tournament_id)
    local tournament = tournaments[tournament_id]
    if not tournament then return false end

    local current = tournament.current_round or 0

    if current == 0 then
        -- No advancement from round 0; must be done manually.
        return false
    end

    if current == 1 then
        if not State.is_round_complete(tournament_id, 1) then return false end

        local winners = {}
        for _, match in ipairs(tournament.matches.round1) do
            winners[#winners + 1] = match.winner
        end
        if #winners ~= 4 then return false end

        tournament.matches.round2 = {
            { player1 = winners[1], player2 = winners[2], winner = nil, loser = nil, completed = false },
            { player1 = winners[3], player2 = winners[4], winner = nil, loser = nil, completed = false },
        }
        tournament.current_round = 2
        tournament.status = "battling"
        return true

    elseif current == 2 then
        if not State.is_round_complete(tournament_id, 2) then return false end

        local winners = {}
        for _, match in ipairs(tournament.matches.round2) do
            winners[#winners + 1] = match.winner
        end
        if #winners ~= 2 then return false end

        tournament.matches.round3 = {
            { player1 = winners[1], player2 = winners[2], winner = nil, loser = nil, completed = false },
        }
        tournament.current_round = 3
        tournament.status = "battling"
        return true
    end

    return false
end

function State.get_winner(tournament_id)
    local tournament = tournaments[tournament_id]
    if not tournament then return nil end

    local final = tournament.matches.round3 and tournament.matches.round3[1]
    if final and final.completed then
        tournament.champion = final.winner
        return final.winner
    end
    return nil
end

-- -------------------------------------------------------------------------
-- Spectator management
-- -------------------------------------------------------------------------

function State.add_spectator(tournament_id, player_id, name)
    local tournament = tournaments[tournament_id]
    if not tournament then return false end

    tournament.spectators[player_id] = {
        id = "spectator:" .. tostring(player_id),
        type = "spectator",
        player_id = player_id,
        name = name or tostring(player_id),
        wants_updates = true,
        spectating = true,
    }
    return true
end

function State.remove_spectator(tournament_id, player_id)
    local tournament = tournaments[tournament_id]
    if not tournament then return false end
    tournament.spectators[player_id] = nil
    return true
end

-- -------------------------------------------------------------------------
-- UI state (positions)
-- -------------------------------------------------------------------------

function State.initialize_positions(tournament_id)
    local tournament = tournaments[tournament_id]
    if not tournament then return false end

    local ui_positions = require("scripts/net-game-tourney/ui-pos")
    local base_positions = ui_positions.get_mugshot_positions(0)

    tournament.ui_state.positions = {}
    tournament.ui_state.round = 0

    for i, participant in ipairs(tournament.participants) do
        local pos = base_positions[i]
        tournament.ui_state.positions[i] = {
            participant_id = participant.id,
            x = pos.x,
            y = pos.y,
            z = pos.z,
        }
    end
    return true
end

function State.calculate_round_positions(tournament_id, round)
    local tournament = tournaments[tournament_id]
    if not tournament then return nil end

    local ui_positions = require("scripts/net-game-tourney/ui-pos")
    local new_positions = {}

    -- Copy existing positions as baseline
    for i, pos in ipairs(tournament.ui_state.positions or {}) do
        new_positions[i] = {
            participant_id = pos.participant_id,
            x = pos.x,
            y = pos.y,
            z = pos.z,
        }
    end

    if round == 0 then
        local base_positions = ui_positions.get_mugshot_positions(0)
        for i, participant in ipairs(tournament.participants) do
            local pos = base_positions[i]
            new_positions[i] = {
                participant_id = participant.id,
                x = pos.x,
                y = pos.y,
                z = pos.z,
            }
        end
        return new_positions
    end

    local round_key = round == 1 and "round1" or (round == 2 and "round2" or "round3")
    local target_positions = ui_positions.get_mugshot_positions(round)
    local matches = tournament.matches[round_key] or {}

    for match_index, match in ipairs(matches) do
        if match.completed and match.winner then
            local target = round == 3 and target_positions[1] or target_positions[match_index]
            if target then
                for i, current in ipairs(new_positions) do
                    if current.participant_id == match.winner.id then
                        new_positions[i] = {
                            participant_id = match.winner.id,
                            x = target.x,
                            y = target.y,
                            z = target.z,
                        }
                        break
                    end
                end
            end
        end
    end

    return new_positions
end

function State.update_positions(tournament_id, round)
    local tournament = tournaments[tournament_id]
    if not tournament then return false end

    local positions = State.calculate_round_positions(tournament_id, round)
    if not positions then return false end

    tournament.ui_state.positions = positions
    tournament.ui_state.round = round
    return true
end

-- -------------------------------------------------------------------------
-- Cleanup
-- -------------------------------------------------------------------------

function State.cleanup_orphaned_tournaments(max_age_seconds)
    max_age_seconds = max_age_seconds or 1800
    local now = os.time()
    for id, tournament in pairs(tournaments) do
        if now - tournament.created_time > max_age_seconds then
            State.delete_tournament(id)
        end
    end
end

return State