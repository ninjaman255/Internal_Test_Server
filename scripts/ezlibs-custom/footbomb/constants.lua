-- Shared FootBomb configuration and tuning values.
-- Keep paths and UI layout values here so they can be adjusted without
-- touching match lifecycle or input logic.
local C = {}

C.DEFAULT_SOURCE_AREA = "footbomb"
C.DEFAULT_POINTS_TO_WIN = 10
C.DEFAULT_ASSET_NAME = "ref-prog"
C.BOT_ASSET_FOLDER = "/server/assets/net-game-footbomb/bots/"
C.MUG_FOLDER = C.BOT_ASSET_FOLDER
C.DEFAULT_MUGSHOT_NAME = "ref-prog-mug"
C.BOMB_ASSET_FOLDER = "/server/assets/net-game-footbomb/bombs/"
C.DEFAULT_MUG_ANIMATION = C.BOT_ASSET_FOLDER .. "mug.animation"
C.CURSOR_TEXTURE = "/server/assets/net-games/cursors/text_cursor.png"
C.CURSOR_ANIMATION = "/server/assets/net-games/cursors/text_cursor.animation"
C.CURSOR_SFX = "/server/assets/net-games/sfx/cursor_move.ogg"
C.OFF_MAP_POSITION = { x = -1000, y = -1000, z = 0 }
C.CONFIRM_PROMPT = "Press A To Confirm"
C.CONFIRM_PROMPT_SCALE = 2.0
C.CONFIRM_PROMPT_Y = 5
C.NAVI_NAME_SCALE = 1.5
C.SCREEN_WIDTH = 240
C.SCREEN_HEIGHT = 160
C.SCREEN_CENTER = { x = 120, y = 80 }
C.SCOREBOARD_TEXTURE = "/server/assets/net-game-footbomb/ui/score-board.png"
C.SCOREBOARD_ANIMATION = "/server/assets/net-game-footbomb/ui/score-board.animation"
C.SCOREBOARD_X = C.SCREEN_CENTER.x - 34
C.SCOREBOARD_Y = C.SCREEN_CENTER.y - 14
C.SCOREBOARD_SCALE = 2.0
C.SCORE_PLAYER_ONE_X = 108
C.SCORE_PLAYER_TWO_X = 128
C.SCORE_TEXT_Y = C.SCREEN_CENTER.y - 4
C.SCORE_TEXT_SCALE = 1.5
C.BOMB_PREVIEW_ANIMATION = "Preview"
C.DIRECTION_CHOICES = { "Left", "Up", "Right" }
C.DIRECTION_INPUT_SETTLE_SECONDS = 0.30
-- Result phase movement tuning (map-coordinate units per second).
-- Adjust these independently to tune each leg of the result animation.
C.RESULT_MOVE_STEP_SECONDS = 0.10
C.RESULT_KICKER_WALK_UR_SPEED = 3 -- Kicker walking diagonally to Move Forward.
C.RESULT_KICKER_WALK_U_SPEED = 3  -- Kicker walking upward from Move Forward to the bomb.
C.RESULT_BOMB_MOVE_SPEED = 5       -- Bomb traveling from the Kicker to the chosen Defender point.
C.RESULT_DEFENDER_JUMP_SPEED = 5   -- Defender jump speed; bomb duration matches this movement.
C.BOMB_SELECTOR_SCALE = 2.0
C.BOMB_CURSOR_LEFT_X = C.SCREEN_CENTER.x - 28
C.BOMB_CURSOR_RIGHT_X = C.SCREEN_CENTER.x + 34
C.BOMB_CURSOR_Y = C.SCREEN_CENTER.y + 12
C.BOMB_PREVIEW_X = C.SCREEN_CENTER.x - 17
C.BOMB_PREVIEW_Y = C.SCREEN_CENTER.y + 4

return C
