-- tournament-constants.lua
local ui_element_paths = "/server/assets/tourney/tourney-board-elements/"

local constants = {
    ui_element_paths = ui_element_paths,

    bracket_background_path = {
        blue_bn4 = {
            gradient_texture = ui_element_paths .. "blue-bn4/gradient.png",
            grid_texture = ui_element_paths .. "blue-bn4/grid.png",
        },
        green_bn4 = {
            gradient_texture = ui_element_paths .. "green-bn4/gradient.png",
            grid_texture = ui_element_paths .. "green-bn4/grid.png",
        },
        pink_yellow_bn4 = {
            gradient_texture = ui_element_paths .. "pink-yellow-bn4/gradient.png",
            grid_texture = ui_element_paths .. "pink-yellow-bn4/grid.png",
        },
        pink_bn4 = {
            gradient_texture = ui_element_paths .. "pink-bn4/gradient.png",
            grid_texture = ui_element_paths .. "pink-bn4/grid.png",
        },
        lemon_lime_bn4 = {
            gradient_texture = ui_element_paths .. "lemon-lime-bn4/gradient.png",
            grid_texture = ui_element_paths .. "lemon-lime-bn4/grid.png",
        },
        green_blue_white_bn4 = {
            gradient_texture = ui_element_paths .. "green-blue-white-bn4/gradient.png",
            grid_texture = ui_element_paths .. "green-blue-white-bn4/grid.png",
        },
        red_orange_bn4 = {
            gradient_texture = ui_element_paths .. "red-orange-bn4/gradient.png",
            grid_texture = ui_element_paths .. "red-orange-bn4/grid.png",
        },
    },

    progress_bar_path = {
        bottom_tier = {
            texture = ui_element_paths .. "progress-bar-base/bottom-tier.png",
            anim = ui_element_paths .. "progress-bar-base/bottom-tier.anim",
        },
        middle_tier = {
            texture = ui_element_paths .. "progress-bar-base/middle-tier.png",
            anim = ui_element_paths .. "progress-bar-base/middle-tier.anim",
        },
        top_tier = {
            texture = ui_element_paths .. "progress-bar-base/top-tier.png",
            anim = ui_element_paths .. "progress-bar-base/top-tier.anim",
        },
    },

    progress_bar_overlay = {
        blue_moon = {
            bottom_tier = {
                texture = ui_element_paths .. "progress-bar-overlays/blue-moon/bottom-tier.png",
                anim = ui_element_paths .. "progress-bar-overlays/bottom-tier.anim",
            },
            middle_tier = {
                texture = ui_element_paths .. "progress-bar-overlays/blue-moon/middle-tier.png",
                anim = ui_element_paths .. "progress-bar-overlays/middle-tier.anim",
            },
            top_tier = {
                texture = ui_element_paths .. "progress-bar-overlays/blue-moon/top-tier.png",
                anim = ui_element_paths .. "progress-bar-overlays/top-tier.anim",
            },
        },
    },

    bracket_bm_bn4 = ui_element_paths .. "bracket-bm.png",
    bracket_rs_bn4 = ui_element_paths .. "bracket-rs.png",

    default_bracket_anim_path_bn4 = ui_element_paths .. "bracket.anim",
    default_background_anim_path_bn4 = ui_element_paths .. "gradient.anim",
    default_grid_anim_path_bn4 = ui_element_paths .. "grid.anim",
    default_mug_anim = ui_element_paths .. "mug.anim",

    mug_frame_texture_path = ui_element_paths .. "mini-mug-frame.png",
    mug_frame_anim_path = ui_element_paths .. "mini-mug-frame.anim",
    mug_frame_anim_states = { "INACTIVE", "ACTIVE", "MOVING" },

    crown_texture_path = ui_element_paths .. "crown.png",
    crown_anim_path = ui_element_paths .. "crown.anim",

    champion_topper_bn4 = ui_element_paths .. "champion-topper-bn4.png",
    champion_topper_bn45 = ui_element_paths .. "champion-topper-bn45.png",
    champion_topper_bn4_anim = ui_element_paths .. "champion-topper-bn4.anim",
    champion_topper_bn45_anim = ui_element_paths .. "champion-topper-bn45.anim",

    title_banner_anim_path = ui_element_paths .. "title-banners-bn4/title-banner.anim",
    title_banner_state = "TITLE",
    title_banner_default = "free-tourney",
    title_banner_paths = {
        ["free-tourney"] = ui_element_paths .. "title-banners-bn4/free-tourney.png",
        ["den-battle"] = ui_element_paths .. "title-banners-bn4/den-battle.png",
        ["eagle"] = ui_element_paths .. "title-banners-bn4/eagle.png",
        ["red-sun"] = ui_element_paths .. "title-banners-bn4/red-sun.png",
    },

    tournament_music = "/server/assets/tourney/music/bbn4_tournament_announcement.ogg",
    default_npc_path = "/server/assets/tourney/npc-navis-testing/",

    fallback_mug_texture = "/server/assets/tourney/npc-navis-testing/mug.png",
    last_resort_mug_texture = "/server/assets/tourney/npc-navis-testing/gutsman/mug.png",

    sepia_properties = {
        color_mode = 2,
        r = 202,
        g = 180,
        b = 155,
        a = 102,
    },
}

return constants
