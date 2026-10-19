-- FootBomb configuration.
-- Keep values grouped by responsibility so UI, assets, input, and match tuning
-- can be adjusted independently of lifecycle code.
local ASSET_ROOT = "/server/assets/net-game-footbomb/"
local BOT_ASSET_FOLDER = ASSET_ROOT .. "bots/"
local SCREEN_CENTER = { x = 120, y = 80 }

local constants = {
    DEFAULTS = {
        SOURCE_AREA = "footbomb",
        POINTS_TO_WIN = 10,
        ASSET_NAME = "ref-prog",
        MUGSHOT_NAME = "ref-prog-mug",
    },

    ASSETS = {
        BOT_FOLDER = BOT_ASSET_FOLDER,
        MUG_FOLDER = BOT_ASSET_FOLDER,
        BOMB_FOLDER = ASSET_ROOT .. "bombs/",
        DEFAULT_MUG_ANIMATION = BOT_ASSET_FOLDER .. "mug.animation",
        CURSOR_TEXTURE = "/server/assets/net-games/cursors/text_cursor.png",
        VIBRANT_CURSOR_TEXTURE = "/server/assets/net-games/cursors/vibrant_text_cursor.png",
        CURSOR_ANIMATION = "/server/assets/net-games/cursors/text_cursor.animation",
        CURSOR_SFX = "/server/assets/net-games/sfx/cursor_move.ogg",
        SCOREBOARD_TEXTURE = ASSET_ROOT .. "ui/score-board.png",
        SCOREBOARD_ANIMATION = ASSET_ROOT .. "ui/score-board.animation",
    },

    UI = {
        OFF_MAP_POSITION = { x = -1000, y = -1000, z = 0 },
        CONFIRM_PROMPT = "Press A To Confirm",
        CONFIRM_PROMPT_SCALE = 2.0,
        CONFIRM_PROMPT_Y = 5,
        NAVI_NAME_SCALE = 1.5,
        SCREEN_WIDTH = 240,
        SCREEN_HEIGHT = 160,
        SCREEN_CENTER = SCREEN_CENTER,
        SCOREBOARD_X = SCREEN_CENTER.x - 100,
        SCOREBOARD_Y = SCREEN_CENTER.y - 50,
        SCOREBOARD_SCALE = 2.0,
        SCORE_PLAYER_ONE_X = 94,
        SCORE_PLAYER_TWO_X = 132,
        SCORE_TEXT_Y = SCREEN_CENTER.y - 8,
        SCORE_TEXT_SCALE = 4.0,
        ROLE_TEXT_Y = 142,
        ROLE_TEXT_SCALE = 2.0,
        -- Character mug portraits sit on the matching score side.
        SCORE_PLAYER_ONE_MUG_X = 24,
        SCORE_PLAYER_TWO_MUG_X = 176,
        SCORE_MUG_Y = SCREEN_CENTER.y - 24,
        SCORE_MUG_SCALE = 2.0,
        BOMB_SELECTOR_SCALE = 2.0,
        BOMB_CURSOR_LEFT_X = SCREEN_CENTER.x - 28,
        BOMB_CURSOR_RIGHT_X = SCREEN_CENTER.x + 34,
        BOMB_CURSOR_Y = SCREEN_CENTER.y + 12,
        BOMB_PREVIEW_X = SCREEN_CENTER.x - 17,
        BOMB_PREVIEW_Y = SCREEN_CENTER.y + 4,
        DIRECTION_CURSOR_X = { 40, SCREEN_CENTER.x, 200 },
        DIRECTION_CURSOR_Y = SCREEN_CENTER.y - 18,
        DIRECTION_CURSOR_SCALE = 2.0,
        DIRECTION_CURSOR_BOB_OFFSET = 5,
        DIRECTION_CURSOR_BOB_TICKS = 2,
    },

    INPUT = {
        DIRECTION_SETTLE_SECONDS = 0.30,
    },

    DIRECTIONS = {
        CHOICES = { "Left", "Up", "Right" },
    },

    GAMEPLAY = {
        -- Result phase movement tuning (map-coordinate units per second).
        RESULT_MOVE_STEP_SECONDS = 0.1,
        RESULT_KICKER_WALK_UR_SPEED = 3,
        RESULT_KICKER_WALK_U_SPEED = 3,
        RESULT_BOMB_MOVE_SPEED = 3,
        RESULT_DEFENDER_JUMP_SPEED = 3,
        -- Render the attached ball in front of the defender using bot depth.
        RESULT_BALL_Z_LIFT = 4,
    },
}

return constants
