-- tournament-flow.lua
local TournamentFlow = {}

local constants = require("scripts/net-game-tourney/tournament-constants")
local TournamentCore = require("scripts/net-game-tourney/tournament-core")
local TournamentUI = require("scripts/net-game-tourney/tournament-ui")
local State = require("scripts/net-game-tourney/tournament-state")

local async = function(fn)
    local co = coroutine.create(fn)
    return Async.promisify(co)
end

local await = function(value)
    return Async.await(value)
end

local BATTLE_TIMEOUT_SECONDS = 10 * 60
local TOURNAMENT_PVP_HP = 1000
local FADE_SECONDS = 0.3

local presentation_state = {}

local function for_each_viewer(tournament, callback)
    if not tournament or type(callback) ~= "function" then return end

    local seen = {}

    for _, participant in ipairs(tournament.participants or {}) do
        if participant.type == "player"
            and participant.wants_updates ~= false
            and Net.is_player(participant.id)
        then
            seen[participant.id] = true
            callback(participant.id, participant)
        end
    end

    for player_id, spectator in pairs(tournament.spectators or {}) do
        if not seen[player_id]
            and spectator.wants_updates ~= false
            and Net.is_player(player_id)
        then
            callback(player_id, spectator)
        end
    end
end

local function viewer_is_in_active_match(tournament, player_id)
    for _, match in pairs(tournament.active_spectator_matches or {}) do
        if match then
            if match.player1 and match.player1.type == "player" and match.player1.id == player_id then
                return true
            end
            if match.player2 and match.player2.type == "player" and match.player2.id == player_id then
                return true
            end
        end
    end
    return false
end

local function participant_for_player(tournament, player_id)
    for _, participant in ipairs(tournament.participants or {}) do
        if participant.type == "player" and participant.id == player_id then
            return participant
        end
    end
    return nil
end

local function open_board_for_player(player_id, tournament)
    return async(function()
        if not tournament or not Net.is_player(player_id) then return false end

        local existing = presentation_state[player_id]
        if existing and existing.tournament_id == tournament.id then
            TournamentUI.show_board(player_id, tournament)
            return true
        end

        if existing then
            await(TournamentFlow.close_board_for_player(player_id, false))
        end

        local area_id = Net.get_player_area(player_id)
        local music_area = TournamentUI.acquire_tournament_music(area_id)
        local visual_epoch = TournamentUI.get_visual_epoch(player_id)

        presentation_state[player_id] = {
            tournament_id = tournament.id,
            music_area = music_area,
            visual_epoch = visual_epoch,
        }

        pcall(Net.lock_player_input, player_id)
        if Net.toggle_player_hud then
            pcall(Net.toggle_player_hud, player_id)
        end

        TournamentUI.fade_to_black(player_id, FADE_SECONDS)
        await(Async.sleep(FADE_SECONDS))

        if not TournamentUI.visual_job_is_valid(player_id, visual_epoch) then
            return false
        end

        TournamentUI.show_board(player_id, tournament)
        TournamentUI.fade_from_black(player_id, FADE_SECONDS)
        await(Async.sleep(FADE_SECONDS))
        return TournamentUI.visual_job_is_valid(player_id, visual_epoch)
    end)
end

function TournamentFlow.close_board_for_player(player_id, keep_locked)
    return async(function()
        local state = presentation_state[player_id]
        if not state then
            if Net.is_player(player_id) and not keep_locked then
                pcall(Net.unlock_player_input, player_id)
            end
            return true
        end

        presentation_state[player_id] = nil

        if not Net.is_player(player_id) then
            TournamentUI.release_tournament_music(state.music_area)
            return true
        end

        TournamentUI.fade_to_black(player_id, FADE_SECONDS)
        await(Async.sleep(FADE_SECONDS))

        if Net.is_player(player_id) then
            TournamentUI.cleanup_ui_elements(player_id)

            if Net.toggle_player_hud then
                pcall(Net.toggle_player_hud, player_id)
            end

            TournamentUI.release_tournament_music(state.music_area)
            TournamentUI.fade_from_black(player_id, FADE_SECONDS)

            if keep_locked then
                pcall(Net.lock_player_input, player_id)
            else
                pcall(Net.unlock_player_input, player_id)
            end
        else
            TournamentUI.release_tournament_music(state.music_area)
        end

        return true
    end)
end

function TournamentFlow.show_board_to_all(tournament_id)
    return async(function()
        local tournament = State.get_tournament(tournament_id)
        if not tournament then return false end

        local jobs = {}
        for_each_viewer(tournament, function(player_id)
            jobs[#jobs + 1] = open_board_for_player(player_id, tournament)
        end)

        for _, job in ipairs(jobs) do
            await(job)
        end

        return true
    end)
end

function TournamentFlow.hide_board_from_all(tournament_id, keep_locked)
    return async(function()
        local tournament = State.get_tournament(tournament_id)
        if not tournament then return false end

        local jobs = {}
        for player_id, state in pairs(presentation_state) do
            if state.tournament_id == tournament_id then
                jobs[#jobs + 1] = TournamentFlow.close_board_for_player(player_id, keep_locked == true)
            end
        end

        for _, job in ipairs(jobs) do
            await(job)
        end

        return true
    end)
end

local function refresh_open_boards(tournament)
    if not tournament then return end

    for player_id, state in pairs(presentation_state) do
        if state.tournament_id == tournament.id and Net.is_player(player_id) then
            TournamentUI.update_battling_frames(player_id, tournament)
        end
    end
end

local function open_live_boards_for_waiting_viewers(tournament)
    return async(function()
        if not tournament then return end

        local jobs = {}

        for_each_viewer(tournament, function(player_id, viewer)
            local should_watch = viewer.type == "spectator"

            if viewer.type == "player" and viewer.eliminated and viewer.spectating ~= false then
                should_watch = true
            end

            if viewer_is_in_active_match(tournament, player_id) then
                should_watch = false
            end

            if Net.is_player_battling then
                local ok, battling = pcall(Net.is_player_battling, player_id)
                if ok and battling == true then
                    should_watch = false
                end
            end

            if should_watch then
                local state = presentation_state[player_id]
                if not state or state.tournament_id ~= tournament.id then
                    jobs[#jobs + 1] = open_board_for_player(player_id, tournament)
                else
                    TournamentUI.update_battling_frames(player_id, tournament)
                end
            end
        end)

        for _, job in ipairs(jobs) do
            await(job)
        end
    end)
end

local function close_live_boards_for_tournament(tournament_id)
    local jobs = {}

    for player_id, state in pairs(presentation_state) do
        if state.tournament_id == tournament_id then
            jobs[#jobs + 1] = TournamentFlow.close_board_for_player(player_id, false)
        end
    end

    return async(function()
        for _, job in ipairs(jobs) do
            await(job)
        end
    end)
end

local function message_viewers(tournament, message)
    for_each_viewer(tournament, function(player_id)
        pcall(Net.message_player, player_id, tostring(message or ""))
    end)
end

local function round_key(round)
    if round == 1 then return "round1" end
    if round == 2 then return "round2" end
    return "round3"
end

local function format_round_matches(tournament, round)
    local lines = { "Round " .. tostring(round) .. ":" }

    for i, match in ipairs(tournament.matches[round_key(round)] or {}) do
        lines[#lines + 1] = string.format(
            "M%d: %s vs %s",
            i,
            tostring(match.player1.name),
            tostring(match.player2.name)
        )
    end

    return table.concat(lines, "\n")
end

local function await_with_timeout(promise, timeout_seconds)
    return async(function()
        local completed = false
        local value = nil

        if not promise or not promise.and_then then
            return { timed_out = false, value = nil }
        end

        promise.and_then(function(result)
            value = result
            completed = true
        end)

        timeout_seconds = tonumber(timeout_seconds or 0) or 0

        if timeout_seconds <= 0 then
            while not completed do
                await(Async.sleep(0.25))
            end
            return { timed_out = false, value = value }
        end

        local elapsed = 0
        while not completed and elapsed < timeout_seconds do
            local step = math.min(1.0, timeout_seconds - elapsed)
            await(Async.sleep(step))
            elapsed = elapsed + step
        end

        return {
            timed_out = not completed,
            value = value,
        }
    end)
end

local function enemy_survived(stats)
    if not stats or type(stats.enemies) ~= "table" then return false end

    for _, enemy in ipairs(stats.enemies) do
        if tonumber(enemy.health or 0) > 0 then
            return true
        end
    end

    return false
end

local function stats_says_player_won_encounter(stats)
    if not stats then return false end

    if stats.ran or stats.fled or stats.escape then
        return false
    end

    local reason = tonumber(stats.reason or 0) or 0
    if reason == 1 then
        return true
    elseif reason == 2 or reason == 3 or reason == 4 then
        return false
    end

    local hp = tonumber(stats.health or stats.player_hp or stats.hp or 0) or 0
    if hp <= 0 then return false end
    if enemy_survived(stats) then return false end

    return true
end

local function get_hp_state(player_id)
    local max_hp = 0
    local hp = 0

    pcall(function()
        max_hp = tonumber(Net.get_player_max_health(player_id) or 0) or 0
    end)

    pcall(function()
        if Net.get_player_health then
            hp = tonumber(Net.get_player_health(player_id) or 0) or 0
        else
            hp = max_hp
        end
    end)

    if hp <= 0 then hp = max_hp end
    return { hp = hp, max = max_hp }
end

local function restore_hp(player_id, state)
    if not state or not state.max or state.max <= 0 or not Net.is_player(player_id) then
        return
    end

    local hp = math.min(tonumber(state.hp or state.max) or state.max, state.max)
    pcall(Net.set_player_max_health, player_id, state.max)
    pcall(Net.set_player_health, player_id, hp)

    if Net.get_area_custom_property then
        local area_id = Net.get_player_area(player_id)
        if area_id and Net.get_area_custom_property(area_id, "Honor Saved HP") == "true" then
            print("UNIMPLEMENTED")
        end
    end
end

local function force_pvp_hp(player_id)
    pcall(Net.set_player_max_health, player_id, TOURNAMENT_PVP_HP)
    pcall(Net.set_player_health, player_id, TOURNAMENT_PVP_HP)
end

local function tournament_should_force_pvp_hp(tournament)
    if tournament.config.force_pvp_hp ~= nil then
        return tournament.config.force_pvp_hp == true
    end

    local mode = tostring(tournament.config.pvp_mode or "auto"):lower()
    return mode ~= "wcity"
end

local function wait_until_players_ready(player_ids)
    return async(function()
        while true do
            local busy = false

            if Net.is_player_battling then
                for _, player_id in ipairs(player_ids or {}) do
                    if Net.is_player(player_id) then
                        local ok, battling = pcall(Net.is_player_battling, player_id)
                        if ok and battling == true then
                            busy = true
                            break
                        end
                    end
                end
            end

            if not busy then return true end
            await(Async.sleep(0.5))
        end
    end)
end

local function close_board_if_open(player_id)
    local state = presentation_state[player_id]
    if state then
        return TournamentFlow.close_board_for_player(player_id, false)
    end

    return async(function() return true end)
end

local function run_player_vs_player(tournament, match)
    return async(function()
        local p1 = match.player1.id
        local p2 = match.player2.id

        if not Net.is_player(p1) or match.player1.disconnected then
            return match.player2.id, match.player1.id
        end
        if not Net.is_player(p2) or match.player2.disconnected then
            return match.player1.id, match.player2.id
        end

        await(wait_until_players_ready({ p1, p2 }))
        await(close_board_if_open(p1))
        await(close_board_if_open(p2))

        local force_hp = tournament_should_force_pvp_hp(tournament)
        local hp1 = get_hp_state(p1)
        local hp2 = get_hp_state(p2)

        if force_hp then
            force_pvp_hp(p1)
            force_pvp_hp(p2)
        end

        pcall(Net.lock_player_input, p1)
        pcall(Net.lock_player_input, p2)

        local cleanup_done = false
        local function cleanup()
            if cleanup_done then return end
            cleanup_done = true

            if Net.is_player(p1) then
                pcall(Net.unlock_player_input, p1)
                if force_hp then restore_hp(p1, hp1) end
            end

            if Net.is_player(p2) then
                pcall(Net.unlock_player_input, p2)
                if force_hp then restore_hp(p2, hp2) end
            end
        end

        local battle_promise = Async.initiate_pvp(p1, p2)
        if battle_promise and battle_promise.and_then then
            battle_promise.and_then(function()
                cleanup()
            end)
        end

        local timeout = await(await_with_timeout(
            battle_promise,
            tournament.config.battle_timeout_seconds or BATTLE_TIMEOUT_SECONDS
        ))

        if timeout.timed_out then
            local winner_id, loser_id
            if math.random(1, 2) == 1 then
                winner_id, loser_id = p1, p2
            else
                winner_id, loser_id = p2, p1
            end

            print(string.format(
                "[Flow] PvP timeout: %s vs %s; random winner=%s",
                tostring(match.player1.name),
                tostring(match.player2.name),
                tostring(winner_id)
            ))

            return winner_id, loser_id
        end

        cleanup()

        local result = timeout.value
        if result and result.ran then
            if result.player_id == p1 then
                return p2, p1
            elseif result.player_id == p2 then
                return p1, p2
            end
        end

        if result and tonumber(result.health or 0) > 0 then
            return p1, p2
        end

        return p2, p1
    end)
end

local function run_player_vs_npc(tournament, player, npc)
    return async(function()
        local player_id = player.id

        if not Net.is_player(player_id) or player.disconnected then
            return npc.id, player.id
        end

        await(wait_until_players_ready({ player_id }))
        await(close_board_if_open(player_id))
        pcall(Net.lock_player_input, player_id)

        local cleanup_done = false
        local function cleanup()
            if cleanup_done then return end
            cleanup_done = true
            if Net.is_player(player_id) then
                pcall(Net.unlock_player_input, player_id)
            end
        end

        -- ShaDis validates optimized wrappers through ezencounters package_registry.
        -- That dependency is intentionally excluded from this conversion.
        print("UNIMPLEMENTED")

        local battle_promise = Async.initiate_encounter(player_id, npc.id)
        if battle_promise and battle_promise.and_then then
            battle_promise.and_then(function()
                cleanup()
            end)
        end

        local timeout = await(await_with_timeout(
            battle_promise,
            tournament.config.battle_timeout_seconds or BATTLE_TIMEOUT_SECONDS
        ))

        if timeout.timed_out then
            print(string.format(
                "[Flow] PvE timeout: %s vs %s; NPC advances",
                tostring(player.name),
                tostring(npc.name)
            ))
            return npc.id, player.id
        end

        cleanup()

        if stats_says_player_won_encounter(timeout.value) then
            return player.id, npc.id
        end

        return npc.id, player.id
    end)
end

function TournamentFlow.resolve_npc_battle(tournament_id, round, match_index, match)
    return async(function()
        local tournament = State.get_tournament(tournament_id)
        if not tournament then return end

        local result = TournamentCore.get_npc_battle_result(
            tournament_id,
            round,
            match_index,
            match.player1.id,
            match.player2.id
        )

        if not result then return end

        local wait_seconds = 0.25
        if tournament.config.npc_only == true then
            local min_tenths = math.floor(8 * 10 + 0.5)
            local max_tenths = math.floor(12 * 10 + 0.5)
            wait_seconds = math.random(min_tenths, max_tenths) / 10
        end

        await(Async.sleep(wait_seconds))

        TournamentCore.record_battle_result(
            tournament_id,
            round,
            match_index,
            result.winner_id,
            result.loser_id
        )
    end)
end

function TournamentFlow.start_player_battle(tournament_id, round, match_index, match)
    return async(function()
        local tournament = State.get_tournament(tournament_id)
        if not tournament then return end

        local winner_id, loser_id

        if match.player1.type == "player" and match.player2.type == "player" then
            winner_id, loser_id = await(run_player_vs_player(tournament, match))
        elseif match.player1.type == "player" and match.player2.type ~= "player" then
            winner_id, loser_id = await(run_player_vs_npc(tournament, match.player1, match.player2))
        elseif match.player2.type == "player" and match.player1.type ~= "player" then
            winner_id, loser_id = await(run_player_vs_npc(tournament, match.player2, match.player1))
        else
            await(TournamentFlow.resolve_npc_battle(tournament_id, round, match_index, match))
            return
        end

        if winner_id and loser_id then
            TournamentCore.record_battle_result(
                tournament_id,
                round,
                match_index,
                winner_id,
                loser_id
            )
        end
    end)
end

local function match_should_show_battle_progress(match, tournament)
    if not match then return false end
    if tournament.config.npc_only == true then return true end

    return match.player1.type == "player" or match.player2.type == "player"
end

function TournamentFlow.run_round_battles(tournament_id, round)
    return async(function()
        local tournament = State.get_tournament(tournament_id)
        if not tournament then return end

        local matches = tournament.matches[round_key(round)]
        if not matches then return end

        tournament.active_spectator_matches = {}

        for match_index, match in ipairs(matches) do
            if match_should_show_battle_progress(match, tournament) then
                tournament.active_spectator_matches[match_index] = match
            end
        end

        await(open_live_boards_for_waiting_viewers(tournament))
        refresh_open_boards(tournament)

        local jobs = {}

        for match_index, match in ipairs(matches) do
            jobs[#jobs + 1] = async(function()
                if match.player1.type == "player" or match.player2.type == "player" then
                    await(TournamentFlow.start_player_battle(
                        tournament_id,
                        round,
                        match_index,
                        match
                    ))
                else
                    await(TournamentFlow.resolve_npc_battle(
                        tournament_id,
                        round,
                        match_index,
                        match
                    ))
                end

                tournament.active_spectator_matches[match_index] = nil

                if match.loser and match.loser.type == "player" and round < 3 then
                    match.loser.spectating = true
                    match.loser.wants_updates = true
                end

                await(open_live_boards_for_waiting_viewers(tournament))
                refresh_open_boards(tournament)
            end)
        end

        for _, job in ipairs(jobs) do
            await(job)
        end

        tournament.active_spectator_matches = {}
        await(close_live_boards_for_tournament(tournament_id))
    end)
end

local function current_viewer_jobs(tournament, fn)
    local jobs = {}

    for_each_viewer(tournament, function(player_id)
        local state = presentation_state[player_id]
        if state and state.tournament_id == tournament.id then
            jobs[#jobs + 1] = fn(player_id, state)
        end
    end)

    return jobs
end

function TournamentFlow.squash_winner_before_move(tournament_id, round, match_index)
    return async(function()
        local tournament = State.get_tournament(tournament_id)
        if not tournament then return end

        local match = tournament.matches[round_key(round)]
            and tournament.matches[round_key(round)][match_index]
        if not match or not match.winner then return end

        local index = TournamentUI.get_participant_original_index(tournament, match.winner.id)
        if not index then return end

        local jobs = current_viewer_jobs(tournament, function(player_id, state)
            return TournamentUI.squash_mugshot(
                player_id,
                tournament_id,
                index,
                state.visual_epoch
            )
        end)

        for _, job in ipairs(jobs) do
            await(job)
        end
    end)
end

function TournamentFlow.unsquash_winner_after_move(tournament_id, round, match_index)
    return async(function()
        local tournament = State.get_tournament(tournament_id)
        if not tournament then return end

        local match = tournament.matches[round_key(round)]
            and tournament.matches[round_key(round)][match_index]
        if not match or not match.winner then return end

        local index = TournamentUI.get_participant_original_index(tournament, match.winner.id)
        if not index then return end

        local jobs = current_viewer_jobs(tournament, function(player_id, state)
            return TournamentUI.unsquash_mugshot(
                player_id,
                tournament_id,
                index,
                state.visual_epoch
            )
        end)

        for _, job in ipairs(jobs) do
            await(job)
        end
    end)
end

function TournamentFlow.greyscale_specific_loser(tournament_id, round, match_index)
    return async(function()
        local tournament = State.get_tournament(tournament_id)
        if not tournament then return end

        local match = tournament.matches[round_key(round)]
            and tournament.matches[round_key(round)][match_index]
        if not match or not match.loser then return end

        for_each_viewer(tournament, function(player_id)
            local state = presentation_state[player_id]
            if state and state.tournament_id == tournament.id then
                TournamentUI.tint_loser(player_id, tournament, match.loser.id)
            end
        end)
    end)
end

function TournamentFlow.move_winner_for_match(tournament_id, round, match_index)
    return async(function()
        local tournament = State.get_tournament(tournament_id)
        if not tournament then return end

        local match = tournament.matches[round_key(round)]
            and tournament.matches[round_key(round)][match_index]
        if not match or not match.winner then return end

        local new_positions = TournamentCore.calculate_round_positions(tournament_id, round)
        if not new_positions then return end

        local new_pos = nil
        for _, pos in ipairs(new_positions) do
            if pos.participant_id == match.winner.id then
                new_pos = pos
                break
            end
        end
        if not new_pos then return end

        for i, pos in ipairs(tournament.ui_state.positions or {}) do
            if pos.participant_id == match.winner.id then
                tournament.ui_state.positions[i] = {
                    participant_id = match.winner.id,
                    x = new_pos.x,
                    y = new_pos.y,
                    z = new_pos.z,
                }
                break
            end
        end
        tournament.ui_state.round = round

        for_each_viewer(tournament, function(player_id)
            local state = presentation_state[player_id]
            if state and state.tournament_id == tournament.id then
                TournamentUI.move_participant(
                    player_id,
                    tournament,
                    match.winner.id,
                    new_pos
                )
            end
        end)
    end)
end

function TournamentFlow.spawn_progress_bar_for_match(tournament_id, round, match_index)
    return async(function()
        local tournament = State.get_tournament(tournament_id)
        if not tournament then return {} end

        local overlays = {}
        for_each_viewer(tournament, function(player_id)
            local state = presentation_state[player_id]
            if state and state.tournament_id == tournament.id then
                local overlay_id = TournamentUI.add_progress_bar_with_overlay(
                    player_id,
                    tournament,
                    round,
                    match_index
                )
                if overlay_id then
                    overlays[player_id] = overlay_id
                end
            end
        end)

        return overlays
    end)
end

function TournamentFlow.remove_progress_bar_overlays(overlays)
    for player_id, overlay_id in pairs(overlays or {}) do
        if Net.is_player(player_id) then
            TournamentUI.remove_progress_bar_overlay(player_id, overlay_id)
        end
    end
end

function TournamentFlow.process_round_one_by_one(tournament_id, round)
    return async(function()
        local tournament = State.get_tournament(tournament_id)
        if not tournament then return end

        local matches = tournament.matches[round_key(round)]
        if not matches then return end

        for match_index, match in ipairs(matches) do
            if match.completed then
                if match.loser then
                    await(TournamentFlow.greyscale_specific_loser(
                        tournament_id,
                        round,
                        match_index
                    ))
                end

                if match.winner then
                    -- Required order: squash → move → show overlay → remove overlay → unsquash
                    await(TournamentFlow.squash_winner_before_move(
                        tournament_id,
                        round,
                        match_index
                    ))
                    await(Async.sleep(0.3))

                    await(TournamentFlow.move_winner_for_match(
                        tournament_id,
                        round,
                        match_index
                    ))

                    -- Spawn overlay while mug is still squashed
                    local overlays = await(TournamentFlow.spawn_progress_bar_for_match(
                        tournament_id,
                        round,
                        match_index
                    ))
                    await(Async.sleep(0.6))
                    TournamentFlow.remove_progress_bar_overlays(overlays)

                    -- Now unsquash after overlay is gone
                    await(TournamentFlow.unsquash_winner_after_move(
                        tournament_id,
                        round,
                        match_index
                    ))
                    await(Async.sleep(0.3))
                end

                if match_index < #matches then
                    await(Async.sleep(0.5))
                end
            end
        end

        tournament.revealed_rounds[round] = true
    end)
end

function TournamentFlow.announce_champion(tournament_id)
    return async(function()
        local tournament = State.get_tournament(tournament_id)
        if not tournament then return end

        local winner = TournamentCore.get_winner(tournament_id)
        if not winner then return end

        tournament.champion = winner

        for_each_viewer(tournament, function(player_id)
            local state = presentation_state[player_id]
            if state and state.tournament_id == tournament.id then
                TournamentUI.show_champion_indicator(player_id, tournament)
            end
            pcall(Net.message_player, player_id, "Tournament Complete! Champion: " .. tostring(winner.name))
        end)
    end)
end

function TournamentFlow.run_tournament(tournament_id)
    return async(function()
        local tournament = State.get_tournament(tournament_id)
        if not tournament then return end

        tournament.current_round = 0
        tournament.status = "starting"
        TournamentCore.update_positions(tournament_id, 0)

        message_viewers(tournament, tostring(tournament.config.name or tournament.config.title or "Tournament") .. " is starting!")
        await(TournamentFlow.show_board_to_all(tournament_id))
        await(Async.sleep(2.0))
        await(TournamentFlow.hide_board_from_all(tournament_id, false))

        for round = 1, 3 do
            tournament.current_round = round
            tournament.status = "round_" .. tostring(round)

            message_viewers(tournament, format_round_matches(tournament, round))
            await(Async.sleep(0.75))

            await(TournamentFlow.run_round_battles(tournament_id, round))

            if not TournamentCore.is_round_complete(tournament_id, round) then
                print("[Flow] ERROR: Round " .. tostring(round) .. " did not complete")
                await(TournamentFlow.hide_board_from_all(tournament_id, false))
                if type(tournament.config.on_complete) == "function" then
                    tournament.config.on_complete(tournament_id, nil, "round_incomplete")
                end
                TournamentCore.cleanup_tournament(tournament_id)
                return
            end

            await(TournamentFlow.show_board_to_all(tournament_id))
            await(Async.sleep(1.0))
            await(TournamentFlow.process_round_one_by_one(tournament_id, round))
            await(Async.sleep(1.0))

            if round < 3 then
                await(TournamentFlow.hide_board_from_all(tournament_id, false))

                if not TournamentCore.advance_round(tournament_id) then
                    print("[Flow] ERROR: Failed to advance after round " .. tostring(round))
                    if type(tournament.config.on_complete) == "function" then
                        tournament.config.on_complete(tournament_id, nil, "advance_failed")
                    end
                    TournamentCore.cleanup_tournament(tournament_id)
                    return
                end
            end
        end

        local champion = TournamentCore.get_winner(tournament_id)
        tournament.champion = champion
        tournament.status = "finished"

        await(TournamentFlow.announce_champion(tournament_id))
        await(Async.sleep(3.0))
        await(TournamentFlow.hide_board_from_all(tournament_id, false))

        if type(tournament.config.on_complete) == "function" then
            tournament.config.on_complete(tournament_id, champion, nil)
        end

        TournamentCore.cleanup_tournament(tournament_id)
    end)
end

function TournamentFlow.handle_player_disconnect(player_id)
    local state = presentation_state[player_id]
    presentation_state[player_id] = nil

    if state then
        TournamentUI.release_tournament_music(state.music_area)
    end
end

return TournamentFlow