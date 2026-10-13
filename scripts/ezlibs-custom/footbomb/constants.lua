-- Shared FootBomb configuration and tuning values.
-- Keep paths and UI layout values here so they can be adjusted without
-- touching match lifecycle or input logic.
local C = {}

C.DEFAULT_SOURCE_AREA = "footbomb"
C.DEFAULT_ASSET_NAME = "ref-prog"
C.BOT_ASSET_FOLDER = "/server/assets/net-game-footbomb/bots/"
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
C.BOMB_PREVIEW_ANIMATION = "Preview"
C.BOMB_SELECTOR_SCALE = 2.0
C.BOMB_CURSOR_LEFT_X = C.SCREEN_CENTER.x - 28
C.BOMB_CURSOR_RIGHT_X = C.SCREEN_CENTER.x + 34
C.BOMB_CURSOR_Y = C.SCREEN_CENTER.y + 12
C.BOMB_PREVIEW_X = C.SCREEN_CENTER.x - 17
C.BOMB_PREVIEW_Y = C.SCREEN_CENTER.y + 4

return C
