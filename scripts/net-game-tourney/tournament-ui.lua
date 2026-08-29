-- tournament-ui.lua
local TournamentUI = {}

local constants = require("scripts/net-game-tourney/tournament-constants")
local ui_positions = require("scripts/net-game-tourney/ui-pos")
local games = require("scripts/net-games/main")
local Displayer = require("scripts/displayer/displayer")

local async = function(fn)
    local co = coroutine.create(fn)
    return Async.promisify(co)
end

local await = function(value)
    return Async.await(value)
end

local tracked_visual_ids = {}
local tracked_text_ids = {}
local player_visual_epoch = {}
local tournament_area_music = {}

local function current_visual_epoch(player_id)
    return tonumber(player_visual_epoch[player_id] or 0) or 0
end

function TournamentUI.invalidate_player_visual_jobs(player_id)
    player_visual_epoch[player_id] = current_visual_epoch(player_id) + 1
end

function TournamentUI.visual_job_is_valid(player_id, expected_epoch)
    if not player_id or not Net.is_player(player_id) then
        return false
    end

    if expected_epoch ~= nil and current_visual_epoch(player_id) ~= expected_epoch then
        return false
    end

    return true
end

function TournamentUI.get_visual_epoch(player_id)
    return current_visual_epoch(player_id)
end

local function safe_has_asset(path)
    if not path or path == "" then return false end
    if not Net.has_asset then return true end

    local ok, exists = pcall(Net.has_asset, path)
    return ok and exists == true
end

local function safe_provide(player_id, path)
    if not player_id or not path or path == "" then return end
    if not Net.provide_asset_for_player then return end
    if not safe_has_asset(path) then return end
    pcall(Net.provide_asset_for_player, player_id, path)
end

local function visual_id(tournament_id, base_id)
    return "TOURNEY_" .. tostring(tournament_id or "none") .. "_" .. tostring(base_id)
end

function TournamentUI.visual_id(tournament_id, base_id)
    return visual_id(tournament_id, base_id)
end

local function remember_visual_id(player_id, id)
    tracked_visual_ids[player_id] = tracked_visual_ids[player_id] or {}
    tracked_visual_ids[player_id][id] = true
end

local function remember_text_id(player_id, id)
    tracked_text_ids[player_id] = tracked_text_ids[player_id] or {}
    tracked_text_ids[player_id][id] = true
end

local function draw_ui(player_id, id, texture, animation, state, x, y, z, sx, sy)
    if not player_id or not Net.is_player(player_id) then return false end
    if not texture or texture == "" or not safe_has_asset(texture) then return false end
    if animation and animation ~= "" and not safe_has_asset(animation) then return false end

    -- Ensure state is lowercase for animation compatibility
    local final_state = state and state:lower() or ""

    local ok = pcall(
        games.add_ui_element,
        id,
        player_id,
        texture,
        animation or "",
        final_state,
        x or 0,
        y or 0,
        z or 0,
        sx,
        sy
    )

    if ok then
        remember_visual_id(player_id, id)
        return true
    end

    if animation and animation ~= "" then
        ok = pcall(
            games.add_ui_element,
            id,
            player_id,
            texture,
            "",
            "",
            x or 0,
            y or 0,
            z or 0,
            sx,
            sy
        )

        if ok then
            remember_visual_id(player_id, id)
            return true
        end
    end

    return false
end

local function remove_ui(player_id, id)
    if not player_id or not Net.is_player(player_id) or not id then return end
    pcall(games.remove_ui_element, id, player_id)

    if tracked_visual_ids[player_id] then
        tracked_visual_ids[player_id][id] = nil
    end
end

local function remove_text(player_id, id)
    if not player_id or not Net.is_player(player_id) or not id then return end

    if Displayer and Displayer.Text and Displayer.Text.removeStatic then
        pcall(Displayer.Text.removeStatic, player_id, id)
    end

    if tracked_text_ids[player_id] then
        tracked_text_ids[player_id][id] = nil
    end
end

local function resolve_mug_texture(texture)
    if texture and texture ~= "" and safe_has_asset(texture) then
        return texture
    end

    if safe_has_asset(constants.fallback_mug_texture) then
        return constants.fallback_mug_texture
    end

    if safe_has_asset(constants.last_resort_mug_texture) then
        return constants.last_resort_mug_texture
    end

    return nil
end

local function normalize_title_banner(value)
    local key = tostring(value or ""):lower()
    key = key:gsub("^%s+", "")
    key = key:gsub("%s+$", "")
    key = key:gsub("[_%s]+", "-")

    if constants.title_banner_paths and constants.title_banner_paths[key] then
        return key
    end

    return constants.title_banner_default or "free-tourney"
end

function TournamentUI.get_participant_original_index(tournament_data, participant_id)
    for i, participant in ipairs(tournament_data and tournament_data.participants or {}) do
        if participant.id == participant_id then
            return i
        end
    end

    return nil
end

local function get_current_position(tournament_data, participant_id)
    for _, pos in ipairs(tournament_data and tournament_data.ui_state and tournament_data.ui_state.positions or {}) do
        if pos.participant_id == participant_id then
            return pos
        end
    end

    return nil
end

local function add_mugshot(player_id, tournament_data, participant, index, pos)
    if not participant or not pos then return false end

    local texture = resolve_mug_texture(participant.mugshot)
    if not texture then return false end

    local frame_id = visual_id(tournament_data.id, "MUG_FRAME_" .. tostring(index))
    local mug_id = visual_id(tournament_data.id, "MUG_" .. tostring(index))

    draw_ui(
        player_id,
        frame_id,
        constants.mug_frame_texture_path,
        constants.mug_frame_anim_path,
        "ACTIVE",
        pos.x,
        pos.y,
        (pos.z or 3) + 1,
        2.0,
        2.0
    )

    draw_ui(
        player_id,
        mug_id,
        texture,
        constants.default_mug_anim,
        "UI",
        pos.x,
        pos.y,
        pos.z or 3,
        1.0,
        1.0
    )

    return true
end

local function setup_background(player_id, tournament_data)
    local theme = tournament_data.config.theme or "red_orange_bn4"
    local background = constants.bracket_background_path[theme]
        or constants.bracket_background_path.red_orange_bn4

    local bg_pos = ui_positions.ui_element_positions.background
    local grid_pos = ui_positions.ui_element_positions.grid

    draw_ui(
        player_id,
        visual_id(tournament_data.id, "BOARD_BG"),
        background.gradient_texture,
        constants.default_background_anim_path_bn4,
        "BG",
        bg_pos.x,
        bg_pos.y,
        bg_pos.z
    )

    draw_ui(
        player_id,
        visual_id(tournament_data.id, "BOARD_GRID"),
        background.grid_texture,
        constants.default_grid_anim_path_bn4,
        "UI",
        grid_pos.x,
        grid_pos.y,
        grid_pos.z
    )
end

local function setup_title(player_id, tournament_data)
    local banner_pos = ui_positions.ui_element_positions.title_banner
    local title_key = normalize_title_banner(tournament_data.config.title_banner_key)
    local texture = constants.title_banner_paths and constants.title_banner_paths[title_key]

    if texture then
        draw_ui(
            player_id,
            visual_id(tournament_data.id, "TITLE_BANNER"),
            texture,
            constants.title_banner_anim_path,
            constants.title_banner_state or "TITLE",
            banner_pos.x,
            banner_pos.y,
            banner_pos.z
        )
    end

    local title_text = tournament_data.config.title
    if title_text and title_text ~= "" and Displayer and Displayer.Text and Displayer.Text.draw then
        local title_id = visual_id(tournament_data.id, "TITLE_BANNER_TEXT")

        pcall(
            Displayer.Text.draw,
            player_id,
            title_id,
            title_text,
            0,
            6,
            {
                mode = "static",
                width = 240,
                halign = "center",
                font = "THICK",
                scale = 2.0,
                z = 5,
            }
        )

        remember_text_id(player_id, title_id)
    end
end

local function setup_bracket(player_id, tournament_data)
    local tree_pos = ui_positions.ui_element_positions.tournament_tree
    local topper_pos = ui_positions.ui_element_positions.champion_topper
    local crown1_pos = ui_positions.ui_element_positions.crown_1
    local crown2_pos = ui_positions.ui_element_positions.crown_2

    draw_ui(
        player_id,
        visual_id(tournament_data.id, "TOURNEY_TREE"),
        constants.bracket_bm_bn4,
        constants.default_bracket_anim_path_bn4,
        "UI",
        tree_pos.x,
        tree_pos.y,
        tree_pos.z
    )

    draw_ui(
        player_id,
        visual_id(tournament_data.id, "CHAMPION_TOPPER"),
        constants.champion_topper_bn4,
        constants.champion_topper_bn4_anim,
        "UI",
        topper_pos.x,
        topper_pos.y,
        topper_pos.z
    )

    draw_ui(
        player_id,
        visual_id(tournament_data.id, "CROWN_1"),
        constants.crown_texture_path,
        constants.crown_anim_path,
        "INACTIVE",
        crown1_pos.x,
        crown1_pos.y,
        crown1_pos.z
    )

    draw_ui(
        player_id,
        visual_id(tournament_data.id, "CROWN_2"),
        constants.crown_texture_path,
        constants.crown_anim_path,
        "INACTIVE",
        crown2_pos.x,
        crown2_pos.y,
        crown2_pos.z
    )
end

local function progress_info(round)
    if round == 1 then
        return "bottom", "bottom_tier", "L1_MOVE", "R1_MOVE", "L1_MOVE", "R1_MOVE", "TIER1_"
    elseif round == 2 then
        return "middle", "middle_tier", "L2_MOVE", "R2_MOVE", "L2_MOVE", "R2_MOVE", "TIER2_"
    elseif round == 3 then
        return "top", "top_tier", "L3_MOVE", "R3_MOVE", "L3_MOVE", "R3_MOVE", "TIER3_"
    end

    return nil
end

local function draw_progress_bar(player_id, tournament_data, round, match_index, with_overlay)
    local round_key = round == 1 and "round1" or (round == 2 and "round2" or "round3")
    local match = tournament_data.matches[round_key] and tournament_data.matches[round_key][match_index]
    if not match or not match.completed or not match.winner then return nil end

    local tier_name, tier_key, base_left, base_right, overlay_left, overlay_right, prefix = progress_info(round)
    if not tier_name then return nil end

    local winner_is_player1 = match.winner.id == match.player1.id
    local index = ui_positions.get_progress_bar_index(round, match_index, winner_is_player1)
    local base_positions = ui_positions.get_progress_bar_positions(tier_name)
    local overlay_positions = ui_positions.progress_bar_overlays[tier_key]
    local base_def = constants.progress_bar_path[tier_key]
    local overlay_def = constants.progress_bar_overlay
        and constants.progress_bar_overlay.blue_moon
        and constants.progress_bar_overlay.blue_moon[tier_key]

    local base_pos = base_positions[index]
    if not base_pos or not base_def then return nil end

    local base_id = visual_id(tournament_data.id, prefix .. tostring(index))
    local state = winner_is_player1 and base_left or base_right
    state = state:lower()  -- ensure lowercase for animation

    draw_ui(
        player_id,
        base_id,
        base_def.texture,
        base_def.anim,
        state,
        base_pos.x,
        base_pos.y,
        base_pos.z,
        2.0,
        2.0
    )

    -- Store this bar for the winner so we can later change it to ELIM when they lose
    if not tournament_data.ui_state.bar_ids then
        tournament_data.ui_state.bar_ids = {}
    end
    if not tournament_data.ui_state.bar_ids[match.winner.id] then
        tournament_data.ui_state.bar_ids[match.winner.id] = {}
    end
    table.insert(tournament_data.ui_state.bar_ids[match.winner.id], { id = base_id, state = state })

    if not with_overlay or not overlay_def or not overlay_positions or not overlay_positions[index] then
        return nil
    end

    local overlay_pos = overlay_positions[index]
    local overlay_id = visual_id(tournament_data.id, prefix .. tostring(index) .. "_OVERLAY")
    local overlay_state = winner_is_player1 and overlay_left or overlay_right
    overlay_state = overlay_state:lower()

    draw_ui(
        player_id,
        overlay_id,
        overlay_def.texture,
        overlay_def.anim,
        overlay_state,
        overlay_pos.x,
        overlay_pos.y,
        overlay_pos.z,
        2.0,
        2.0
    )

    return overlay_id
end

function TournamentUI.eliminate_participant_bars(player_id, tournament_data, participant_id)
    if not player_id or not Net.is_player(player_id) then return end
    if not tournament_data or not tournament_data.ui_state or not tournament_data.ui_state.bar_ids then return end

    local bars = tournament_data.ui_state.bar_ids[participant_id]
    if not bars then return end

    for _, entry in ipairs(bars) do
        -- Replace "_move" with "_elim" (case-insensitive) and ensure lowercase
        local elim_state = entry.state:gsub("_move$", "_elim")
        elim_state = elim_state:lower()
        pcall(games.update_ui_element, entry.id, player_id, { animation_state = elim_state })
    end
end

local function draw_revealed_paths(player_id, tournament_data)
    for round = 1, 3 do
        if tournament_data.revealed_rounds and tournament_data.revealed_rounds[round] then
            local round_key = round == 1 and "round1" or (round == 2 and "round2" or "round3")
            for match_index, match in ipairs(tournament_data.matches[round_key] or {}) do
                if match.completed and match.winner then
                    draw_progress_bar(player_id, tournament_data, round, match_index, false)
                end
            end
        end
    end
end

local function apply_revealed_eliminations(player_id, tournament_data)
    for index, participant in ipairs(tournament_data.participants or {}) do
        if participant.eliminated
            and participant.eliminated_round
            and tournament_data.revealed_rounds
            and tournament_data.revealed_rounds[participant.eliminated_round]
        then
            pcall(
                games.update_ui_element,
                visual_id(tournament_data.id, "MUG_" .. tostring(index)),
                player_id,
                constants.sepia_properties
            )
            -- Also eliminate their bars
            TournamentUI.eliminate_participant_bars(player_id, tournament_data, participant.id)
        end
    end
end

function TournamentUI.show_board(player_id, tournament_data)
    if not player_id or not Net.is_player(player_id) or not tournament_data then
        return false
    end

    TournamentUI.cleanup_ui_elements(player_id)
    setup_background(player_id, tournament_data)
    setup_title(player_id, tournament_data)
    setup_bracket(player_id, tournament_data)
    draw_revealed_paths(player_id, tournament_data)

    for index, participant in ipairs(tournament_data.participants or {}) do
        local pos = get_current_position(tournament_data, participant.id)
        add_mugshot(player_id, tournament_data, participant, index, pos)
    end

    apply_revealed_eliminations(player_id, tournament_data)
    TournamentUI.update_battling_frames(player_id, tournament_data)

    if tournament_data.champion then
        TournamentUI.show_champion_indicator(player_id, tournament_data)
    end

    return true
end

function TournamentUI.cleanup_ui_elements(player_id)
    if not player_id or not Net.is_player(player_id) then
        tracked_visual_ids[player_id] = nil
        tracked_text_ids[player_id] = nil
        return
    end

    local ids = {}
    for id in pairs(tracked_visual_ids[player_id] or {}) do
        ids[#ids + 1] = id
    end

    for _, id in ipairs(ids) do
        pcall(games.remove_ui_element, id, player_id)
    end
    tracked_visual_ids[player_id] = {}

    local text_ids = {}
    for id in pairs(tracked_text_ids[player_id] or {}) do
        text_ids[#text_ids + 1] = id
    end

    for _, id in ipairs(text_ids) do
        remove_text(player_id, id)
    end
    tracked_text_ids[player_id] = {}
end

function TournamentUI.cleanup(player_id)
    TournamentUI.cleanup_ui_elements(player_id)
end

function TournamentUI.tint_loser(player_id, tournament_data, participant_id)
    if not player_id or not Net.is_player(player_id) then return false end

    local index = TournamentUI.get_participant_original_index(tournament_data, participant_id)
    if not index then return false end

    pcall(
        games.update_ui_element,
        visual_id(tournament_data.id, "MUG_" .. tostring(index)),
        player_id,
        constants.sepia_properties
    )

    -- Also eliminate all progress bars associated with this participant
    TournamentUI.eliminate_participant_bars(player_id, tournament_data, participant_id)

    return true
end

function TournamentUI.squash_mugshot(player_id, tournament_id, index, visual_epoch)
    return async(function()
        local mug_steps = { 0.8, 0.6, 0.4, 0.2, 0.0 }
        local frame_steps = { 1.7, 1.3, 0.9, 0.5, 0.0 }
        local mug_id = visual_id(tournament_id, "MUG_" .. tostring(index))
        local frame_id = visual_id(tournament_id, "MUG_FRAME_" .. tostring(index))

        for i = 1, #mug_steps do
            if not TournamentUI.visual_job_is_valid(player_id, visual_epoch) then return false end
            pcall(games.update_ui_element, mug_id, player_id, { sy = mug_steps[i] })
            pcall(games.update_ui_element, frame_id, player_id, { sy = frame_steps[i] })
            await(Async.sleep(0.05))
        end

        return TournamentUI.visual_job_is_valid(player_id, visual_epoch)
    end)
end

function TournamentUI.unsquash_mugshot(player_id, tournament_id, index, visual_epoch)
    return async(function()
        local mug_steps = { 0.2, 0.4, 0.6, 0.8, 1.0 }
        local frame_steps = { 0.5, 0.9, 1.3, 1.7, 2.0 }
        local mug_id = visual_id(tournament_id, "MUG_" .. tostring(index))
        local frame_id = visual_id(tournament_id, "MUG_FRAME_" .. tostring(index))

        for i = 1, #mug_steps do
            if not TournamentUI.visual_job_is_valid(player_id, visual_epoch) then return false end
            pcall(games.update_ui_element, mug_id, player_id, { sy = mug_steps[i] })
            pcall(games.update_ui_element, frame_id, player_id, { sy = frame_steps[i] })
            await(Async.sleep(0.05))
        end

        return TournamentUI.visual_job_is_valid(player_id, visual_epoch)
    end)
end

function TournamentUI.move_participant(player_id, tournament_data, participant_id, to_pos)
    if not player_id or not Net.is_player(player_id) or not to_pos then return false end

    local index = TournamentUI.get_participant_original_index(tournament_data, participant_id)
    if not index then return false end

    pcall(games.update_ui_element, visual_id(tournament_data.id, "MUG_" .. tostring(index)), player_id, {
        x = to_pos.x,
        y = to_pos.y,
        z = to_pos.z or 3,
    })

    pcall(games.update_ui_element, visual_id(tournament_data.id, "MUG_FRAME_" .. tostring(index)), player_id, {
        x = to_pos.x,
        y = to_pos.y,
        z = (to_pos.z or 3) + 1,
    })

    return true
end

function TournamentUI.add_progress_bar_with_overlay(player_id, tournament_data, round, match_index)
    return draw_progress_bar(player_id, tournament_data, round, match_index, true)
end

function TournamentUI.remove_progress_bar_overlay(player_id, overlay_id)
    remove_ui(player_id, overlay_id)
end

function TournamentUI.update_battling_frames(player_id, tournament_data)
    if not player_id or not Net.is_player(player_id) or not tournament_data then return end

    local battling = {}
    for _, match in pairs(tournament_data.active_spectator_matches or {}) do
        if match then
            if match.player1 then battling[match.player1.id] = true end
            if match.player2 then battling[match.player2.id] = true end
        end
    end

    for index, participant in ipairs(tournament_data.participants or {}) do
        pcall(games.update_ui_element, visual_id(tournament_data.id, "MUG_FRAME_" .. tostring(index)), player_id, {
            animation_state = battling[participant.id] and "MOVING" or "ACTIVE",
        })
    end
end

function TournamentUI.show_champion_indicator(player_id, tournament_data)
    if not player_id or not Net.is_player(player_id) then return false end

    local pos = ui_positions.ui_element_positions.champion_crown
    return draw_ui(
        player_id,
        visual_id(tournament_data.id, "CHAMPION_INDICATOR"),
        constants.crown_texture_path,
        constants.crown_anim_path,
        "ACTIVE",
        pos.x,
        pos.y,
        pos.z
    )
end

function TournamentUI.fade_to_black(player_id, seconds)
    if not player_id or not Net.is_player(player_id) or not Net.fade_player_camera then return end
    pcall(Net.fade_player_camera, player_id, { r = 0, g = 0, b = 0, a = 255 }, seconds or 0.3)
end

function TournamentUI.fade_from_black(player_id, seconds)
    if not player_id or not Net.is_player(player_id) or not Net.fade_player_camera then return end
    pcall(Net.fade_player_camera, player_id, { r = 0, g = 0, b = 0, a = 0 }, seconds or 0.3)
end

function TournamentUI.acquire_tournament_music(area_id)
    if not area_id then return nil end

    local state = tournament_area_music[area_id]
    if not state then
        state = {
            original_song = Net.get_song and Net.get_song(area_id) or nil,
            original_name = Net.get_area_name and Net.get_area_name(area_id) or nil,
            users = 0,
        }
        tournament_area_music[area_id] = state

        if Net.set_song then pcall(Net.set_song, area_id, constants.tournament_music) end
        if Net.set_area_name then pcall(Net.set_area_name, area_id, "Tournament") end
    end

    state.users = state.users + 1
    return area_id
end

function TournamentUI.release_tournament_music(area_id)
    local state = area_id and tournament_area_music[area_id] or nil
    if not state then return end

    state.users = state.users - 1
    if state.users > 0 then return end

    tournament_area_music[area_id] = nil

    if state.original_song and Net.set_song then
        pcall(Net.set_song, area_id, state.original_song)
    end

    if state.original_name and Net.set_area_name then
        pcall(Net.set_area_name, area_id, state.original_name)
    end
end

function TournamentUI.prewarm_player(player_id)
    if not player_id or not Net.is_player(player_id) then return end

    for _, bg in pairs(constants.bracket_background_path or {}) do
        safe_provide(player_id, bg.gradient_texture)
        safe_provide(player_id, bg.grid_texture)
    end

    safe_provide(player_id, constants.default_background_anim_path_bn4)
    safe_provide(player_id, constants.default_grid_anim_path_bn4)
    safe_provide(player_id, constants.default_bracket_anim_path_bn4)
    safe_provide(player_id, constants.default_mug_anim)
    safe_provide(player_id, constants.mug_frame_texture_path)
    safe_provide(player_id, constants.mug_frame_anim_path)
    safe_provide(player_id, constants.bracket_bm_bn4)
    safe_provide(player_id, constants.bracket_rs_bn4)
    safe_provide(player_id, constants.champion_topper_bn4)
    safe_provide(player_id, constants.champion_topper_bn4_anim)
    safe_provide(player_id, constants.champion_topper_bn45)
    safe_provide(player_id, constants.champion_topper_bn45_anim)
    safe_provide(player_id, constants.crown_texture_path)
    safe_provide(player_id, constants.crown_anim_path)
    safe_provide(player_id, constants.title_banner_anim_path)
    safe_provide(player_id, constants.tournament_music)

    -- Pre-warm the cheer sound effect for champion crowning
    safe_provide(player_id, "/server/assets/tourney/sfx/cheer.ogg")

    for _, texture in pairs(constants.title_banner_paths or {}) do
        safe_provide(player_id, texture)
    end

    for _, def in pairs(constants.progress_bar_path or {}) do
        safe_provide(player_id, def.texture)
        safe_provide(player_id, def.anim)
    end

    for _, theme in pairs(constants.progress_bar_overlay or {}) do
        for _, def in pairs(theme or {}) do
            safe_provide(player_id, def.texture)
            safe_provide(player_id, def.anim)
        end
    end

    async(function()
        await(Async.sleep(1.0))
        if not Net.is_player(player_id) then return end

        local function touch(id, texture, anim, state)
            if not safe_has_asset(texture) then return end
            if anim and anim ~= "" and not safe_has_asset(anim) then return end

            pcall(
                games.add_ui_element,
                id,
                player_id,
                texture,
                anim or "",
                state,
                -1000,
                -1000,
                0,
                2.0,
                2.0
            )
        end

        for key, bg in pairs(constants.bracket_background_path or {}) do
            touch("__tourney_pre_bg_" .. tostring(key), bg.gradient_texture, constants.default_background_anim_path_bn4, "BG")
            touch("__tourney_pre_grid_" .. tostring(key), bg.grid_texture, constants.default_grid_anim_path_bn4, "UI")
        end

        touch("__tourney_pre_bracket_bm", constants.bracket_bm_bn4, constants.default_bracket_anim_path_bn4, "UI")
        touch("__tourney_pre_bracket_rs", constants.bracket_rs_bn4, constants.default_bracket_anim_path_bn4, "UI")
        touch("__tourney_pre_topper_bn4", constants.champion_topper_bn4, constants.champion_topper_bn4_anim, "UI")
        touch("__tourney_pre_topper_bn45", constants.champion_topper_bn45, constants.champion_topper_bn45_anim, "UI")
        touch("__tourney_pre_crown", constants.crown_texture_path, constants.crown_anim_path, "INACTIVE")
        touch("__tourney_pre_mug_frame", constants.mug_frame_texture_path, constants.mug_frame_anim_path, "ACTIVE")

        if constants.progress_bar_path then
            touch("__tourney_pre_path_bottom", constants.progress_bar_path.bottom_tier.texture, constants.progress_bar_path.bottom_tier.anim, "l1_move")
            touch("__tourney_pre_path_middle", constants.progress_bar_path.middle_tier.texture, constants.progress_bar_path.middle_tier.anim, "l2_move")
            touch("__tourney_pre_path_top", constants.progress_bar_path.top_tier.texture, constants.progress_bar_path.top_tier.anim, "l3_move")
        end

        local blue = constants.progress_bar_overlay and constants.progress_bar_overlay.blue_moon
        if blue then
            touch("__tourney_pre_overlay_bottom", blue.bottom_tier.texture, blue.bottom_tier.anim, "l1_move")
            touch("__tourney_pre_overlay_middle", blue.middle_tier.texture, blue.middle_tier.anim, "l2_move")
            touch("__tourney_pre_overlay_top", blue.top_tier.texture, blue.top_tier.anim, "l3_move")
        end

        local default_title = constants.title_banner_paths
            and constants.title_banner_paths[constants.title_banner_default or "free-tourney"]
        if default_title then
            touch("__tourney_pre_title_banner", default_title, constants.title_banner_anim_path, constants.title_banner_state or "TITLE")
        end
    end)
end

return TournamentUI