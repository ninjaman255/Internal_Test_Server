-- ui-pos.lua
local UIPositions = {}

UIPositions.mugshot_positions = {
    round0 = {
        {x = 8, y = 132, z = 4},
        {x = 34, y = 132, z = 4},
        {x = 64, y = 132, z = 4},
        {x = 90, y = 132, z = 4},
        {x = 128, y = 132, z = 4},
        {x = 154, y = 132, z = 4},
        {x = 184, y = 132, z = 4},
        {x = 210, y = 132, z = 4},
    },
    round1 = {
        {x = 22, y = 82, z = 4},
        {x = 78, y = 82, z = 4},
        {x = 142, y = 82, z = 4},
        {x = 198, y = 82, z = 4},
    },
    round2 = {
        {x = 50, y = 56, z = 4},
        {x = 170, y = 56, z = 4},
    },
    round3 = {
        {x = 110, y = 34, z = 4},
    },
}

UIPositions.progress_bar_eliminated = {
    bottom_tier = {
        {x = 17, y = 96, z = 1},
        {x = 47, y = 96, z = 1},
        {x = 73, y = 96, z = 1},
        {x = 103, y = 96, z = 1},
        {x = 137, y = 96, z = 1},
        {x = 167, y = 96, z = 1},
        {x = 193, y = 96, z = 1},
        {x = 223, y = 96, z = 1},
    },
    middle_tier = {
        {x = 29, y = 72, z = 1},
        {x = 91, y = 72, z = 1},
        {x = 149, y = 72, z = 1},
        {x = 211, y = 72, z = 1},
    },
    top_tier = {
        {x = 57, y = 56, z = 1},
        {x = 183, y = 56, z = 1},
    },
}

UIPositions.progress_bar_positions = {
    bottom_tier = {
        {x = 17, y = 96, z = 2},
        {x = 47, y = 96, z = 2},
        {x = 73, y = 96, z = 2},
        {x = 103, y = 96, z = 2},
        {x = 137, y = 96, z = 2},
        {x = 167, y = 96, z = 2},
        {x = 193, y = 96, z = 2},
        {x = 223, y = 96, z = 2},
    },
    middle_tier = {
        {x = 29, y = 72, z = 2},
        {x = 91, y = 72, z = 2},
        {x = 149, y = 72, z = 2},
        {x = 211, y = 72, z = 2},
    },
    top_tier = {
        {x = 57, y = 56, z = 2},
        {x = 183, y = 56, z = 2},
    },
}

UIPositions.progress_bar_overlays = {
    bottom_tier = {
        {x = 17, y = 96, z = 3},
        {x = 47, y = 96, z = 3},
        {x = 73, y = 96, z = 3},
        {x = 103, y = 96, z = 3},
        {x = 137, y = 96, z = 3},
        {x = 167, y = 96, z = 3},
        {x = 193, y = 96, z = 3},
        {x = 223, y = 96, z = 3},
    },
    middle_tier = {
        {x = 29, y = 72, z = 3},
        {x = 91, y = 72, z = 3},
        {x = 149, y = 72, z = 3},
        {x = 211, y = 72, z = 3},
    },
    top_tier = {
        {x = 57, y = 56, z = 3},
        {x = 183, y = 56, z = 3},
    },
}

UIPositions.queue_timer_position = {
    x = 100,
    y = 20,
}

UIPositions.ui_element_positions = {
    tournament_tree = {x = 0, y = 0, z = 0},
    champion_topper = {x = 80, y = 40, z = 1},
    title_banner = {x = 0, y = 0, z = 0},
    crown_1 = {x = 64, y = 48, z = 0},
    crown_2 = {x = 176, y = 48, z = 0},
    champion_crown = {x = 120, y = 36, z = 5},
    background = {x = 0, y = 0, z = -2},
    grid = {x = 0, y = 0, z = -1},
}

function UIPositions.get_mugshot_positions(round)
    local round_key = "round" .. round
    return UIPositions.mugshot_positions[round_key] or UIPositions.mugshot_positions.round0
end

function UIPositions.get_progress_bar_positions(tier)
    local tier_key = tier .. "_tier"
    return UIPositions.progress_bar_positions[tier_key] or {}
end

function UIPositions.get_progress_bar_index(round, match_index, winner_is_player1)
    if round == 1 then
        local base_index = (match_index - 1) * 2
        return winner_is_player1 and (base_index + 1) or (base_index + 2)
    elseif round == 2 then
        local base_index = (match_index - 1) * 2
        return winner_is_player1 and (base_index + 1) or (base_index + 2)
    elseif round == 3 then
        return winner_is_player1 and 1 or 2
    end

    return 1
end

return UIPositions
