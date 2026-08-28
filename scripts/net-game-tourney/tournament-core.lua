-- tournament-core.lua
local TournamentCore = {}

local tournaments = {}
local player_tournaments = {}
local npc_results = {}
local next_tournament_id = 1

local function shuffle_table(values)
    local shuffled = {}
    for i = 1, #values do
        shuffled[i] = values[i]
    end

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

    return config
end

function TournamentCore.create_tournament(config)
    config = normalize_config(config)

    local tournament_id = next_tournament_id
    next_tournament_id = next_tournament_id + 1

    local tournament = {
        id = tournament_id,
        config = config,
        participants = {},
        spectators = {},
        matches = {
            round1 = {},
            round2 = {},
            round3 = {},
        },
        status = "created",
        current_round = 0,
        host_id = config.host_id,
        winners = {},
        champion = nil,
        ui_state = {
            positions = {},
            round = 0,
        },
        revealed_rounds = {},
        active_spectator_matches = {},
        created_time = os.time(),
    }

    tournaments[tournament_id] = tournament
    print(string.format(
        "[Core] Created tournament %d for host %s",
        tournament_id,
        tostring(config.host_id or "unknown")
    ))

    return tournament_id
end

local function participant_exists_in_tournament(tournament, participant_id)
    for _, participant in ipairs(tournament.participants) do
        if participant.id == participant_id then
            return true
        end
    end
    return false
end

function TournamentCore.add_participant(tournament_id, participant)
    local tournament = tournaments[tournament_id]
    if not tournament then
        print("[Core] Tournament not found: " .. tostring(tournament_id))
        return false
    end

    if #tournament.participants >= 8 then
        print("[Core] Tournament is full (8/8)")
        return false
    end

    if not participant or not participant.id or not participant.type then
        print("[Core] Invalid participant")
        return false
    end

    if participant_exists_in_tournament(tournament, participant.id) then
        print("[Core] Participant already in tournament: " .. tostring(participant.id))
        return false
    end

    if participant.type == "player" and player_tournaments[participant.id] then
        print("[Core] Player already in tournament: " .. tostring(participant.id))
        return false
    end

    local stored = {
        id = participant.id,
        type = participant.type,
        name = participant.name or tostring(participant.id),
        mugshot = participant.mugshot,
        weight = tonumber(participant.weight) or 50,
        original_index = #tournament.participants + 1,
        eliminated = participant.eliminated == true,
        eliminated_round = participant.eliminated_round,
        disconnected = participant.disconnected == true,
        wants_updates = participant.wants_updates ~= false,
        spectating = participant.spectating == true,
    }

    table.insert(tournament.participants, stored)

    if stored.type == "player" then
        player_tournaments[stored.id] = tournament_id
        print(string.format("[Core] Added player %s to tournament %d", tostring(stored.id), tournament_id))
    else
        print(string.format("[Core] Added NPC %s to tournament %d", tostring(stored.name), tournament_id))
    end

    return true
end

function TournamentCore.initialize_tournament(tournament_id)
    local tournament = tournaments[tournament_id]
    if not tournament then
        print("[Core] Tournament not found: " .. tostring(tournament_id))
        return false
    end

    if #tournament.participants ~= 8 then
        print(string.format("[Core] Need 8 participants, have %d", #tournament.participants))
        return false
    end

    tournament.participants = shuffle_table(tournament.participants)

    for i, participant in ipairs(tournament.participants) do
        participant.original_index = i
    end

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
        }

        print(string.format("[Core] Round 1 Match %d: %s vs %s", i, p1.name, p2.name))
    end

    tournament.current_round = 0
    tournament.status = "created"
    TournamentCore.initialize_positions(tournament_id)

    return true
end

function TournamentCore.initialize_positions(tournament_id)
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

function TournamentCore.calculate_round_positions(tournament_id, round)
    local tournament = tournaments[tournament_id]
    if not tournament then return nil end

    local ui_positions = require("scripts/net-game-tourney/ui-pos")
    local new_positions = {}

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

function TournamentCore.update_positions(tournament_id, round)
    local tournament = tournaments[tournament_id]
    if not tournament then return false end

    local positions = TournamentCore.calculate_round_positions(tournament_id, round)
    if not positions then return false end

    tournament.ui_state.positions = positions
    tournament.ui_state.round = round
    return true
end

function TournamentCore.record_battle_result(tournament_id, round, match_index, winner_id, loser_id)
    local tournament = tournaments[tournament_id]
    if not tournament then
        print("[Core] Tournament not found: " .. tostring(tournament_id))
        return false
    end

    local round_key = round == 1 and "round1" or (round == 2 and "round2" or "round3")
    local match = tournament.matches[round_key] and tournament.matches[round_key][match_index]
    if not match then
        print(string.format("[Core] Invalid match: round %d, index %d", round, match_index))
        return false
    end

    local winner = nil
    local loser = nil
    for _, participant in ipairs(tournament.participants) do
        if participant.id == winner_id then winner = participant end
        if participant.id == loser_id then loser = participant end
        if winner and loser then break end
    end

    if not winner or not loser then
        print("[Core] Could not find participants for result")
        return false
    end

    match.winner = winner
    match.loser = loser
    match.completed = true

    loser.eliminated = true
    loser.eliminated_round = round

    table.insert(tournament.winners, winner)

    print(string.format(
        "[Core] Recorded result: %s defeated %s in round %d match %d",
        winner.name,
        loser.name,
        round,
        match_index
    ))

    return true
end

function TournamentCore.get_npc_battle_result(tournament_id, round, match_index, npc1_id, npc2_id)
    local key = string.format("%d_%d_%d", tournament_id, round, match_index)
    if npc_results[key] then
        return npc_results[key]
    end

    local tournament = tournaments[tournament_id]
    if not tournament then return nil end

    local npc1 = nil
    local npc2 = nil
    for _, participant in ipairs(tournament.participants) do
        if participant.id == npc1_id then npc1 = participant end
        if participant.id == npc2_id then npc2 = participant end
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

function TournamentCore.is_round_complete(tournament_id, round)
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

function TournamentCore.advance_round(tournament_id)
    local tournament = tournaments[tournament_id]
    if not tournament then return false end

    local current_round = tournament.current_round or 0

    if current_round == 1 then
        if not TournamentCore.is_round_complete(tournament_id, 1) then return false end

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
    end

    if current_round == 2 then
        if not TournamentCore.is_round_complete(tournament_id, 2) then return false end

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

function TournamentCore.complete_round(tournament_id)
    local tournament = tournaments[tournament_id]
    if not tournament then return false end
    tournament.status = "round_complete"
    return true
end

function TournamentCore.get_winner(tournament_id)
    local tournament = tournaments[tournament_id]
    if not tournament then return nil end

    local final_match = tournament.matches.round3 and tournament.matches.round3[1]
    if final_match and final_match.completed then
        tournament.champion = final_match.winner
        return final_match.winner
    end

    return nil
end

function TournamentCore.add_spectator(tournament_id, player_id, name)
    local tournament = tournaments[tournament_id]
    if not tournament or not player_id then return false end

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

function TournamentCore.remove_spectator(tournament_id, player_id)
    local tournament = tournaments[tournament_id]
    if not tournament then return false end
    tournament.spectators[player_id] = nil
    return true
end

function TournamentCore.for_each_human_viewer(tournament_id, callback)
    local tournament = tournaments[tournament_id]
    if not tournament or type(callback) ~= "function" then return end

    local seen = {}

    for _, participant in ipairs(tournament.participants) do
        if participant.type == "player" and participant.wants_updates ~= false then
            seen[participant.id] = true
            callback(participant.id, participant)
        end
    end

    for player_id, spectator in pairs(tournament.spectators or {}) do
        if not seen[player_id] and spectator.wants_updates ~= false then
            callback(player_id, spectator)
        end
    end
end

function TournamentCore.cleanup_tournament(tournament_id)
    local tournament = tournaments[tournament_id]
    if not tournament then return end

    for _, participant in ipairs(tournament.participants) do
        if participant.type == "player" then
            player_tournaments[participant.id] = nil
        end
    end

    for key in pairs(npc_results) do
        if string.find(key, "^" .. tostring(tournament_id) .. "_") then
            npc_results[key] = nil
        end
    end

    local tournament_npcs = require("scripts/net-game-tourney/tournament-npcs")
    tournament_npcs.cleanup_tournament_npcs(tournament_id)

    tournaments[tournament_id] = nil
    print("[Core] Cleaned up tournament " .. tostring(tournament_id))
end

function TournamentCore.handle_player_disconnect(player_id)
    local tournament_id = player_tournaments[player_id]
    local tournament = tournament_id and tournaments[tournament_id] or nil

    if tournament then
        for _, participant in ipairs(tournament.participants) do
            if participant.type == "player" and participant.id == player_id then
                participant.disconnected = true
                break
            end
        end
    end

    player_tournaments[player_id] = nil

    for _, active in pairs(tournaments) do
        if active.spectators then
            active.spectators[player_id] = nil
        end
    end
end

function TournamentCore.cleanup_orphaned_tournaments()
    local now = os.time()
    for tournament_id, tournament in pairs(tournaments) do
        if now - tournament.created_time > 1800 then
            TournamentCore.cleanup_tournament(tournament_id)
        end
    end
end

function TournamentCore.get_tournament(tournament_id)
    return tournaments[tournament_id]
end

function TournamentCore.get_player_tournament(player_id)
    return player_tournaments[player_id]
end

function TournamentCore.is_player_in_tournament(player_id)
    return player_tournaments[player_id] ~= nil
end

return TournamentCore
