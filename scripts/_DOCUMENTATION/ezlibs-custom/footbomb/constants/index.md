# 📄 `constants.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-custom/footbomb/constants.lua`](../../../../ezlibs-custom/footbomb/constants.lua)  
> **Source lines:** 113  
> **SHA-256 (UTF-8):** `b32b0f13f41fa2…`  
> **Declared/assigned functions detected:** 0  
> **Anonymous closures detected:** 0  
> **Table initializers detected:** 13

## 🗂️ Contents

- [📌 Overview](#overview)
- [🔗 Dependencies](#dependencies)
- [📡 Event subscriptions](#event-subscriptions)
- [🧩 Functions](#functions)
- [🪄 Anonymous closures](#anonymous-closures)
- [📦 Tables and data](#tables-and-data)
- [⚙️ Runtime API calls](#runtime-api-calls)
- [🧪 Static-analysis notes](#static-analysis-notes)

## 📌 Overview

FootBomb configuration. Keep values grouped by responsibility so UI, assets, input, and match tuning can be adjusted independently of lifecycle code.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

*No named function declaration or `= function(...)` assignment detected. Anonymous callbacks may still be present.*

## 🪄 Anonymous closures

*No anonymous `function(...)` expressions detected.*

## 📦 Tables and data

The following **13** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `SCREEN_CENTER` — line 6

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | numeric literal | `120` |
| `y` | numeric literal | `80` |

### 2. `constants` — line 8

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `-- Expensive, verbose diagnostics are disabled during normal gameplay. -- Enable either flag temporarily when investigating mappings or assets. DIAGNOSTIC…` |
| `DEFAULTS` | nested table | `{ SOURCE_AREA = "footbomb", POINTS_TO_WIN = 10, ASSET_NAME = "ref-prog", MUGSHOT_NAME = "ref-prog-mug", }` |
| `ASSETS` | nested table | `{ BOT_FOLDER = BOT_ASSET_FOLDER, MUG_FOLDER = BOT_ASSET_FOLDER, BOMB_FOLDER = ASSET_ROOT .. "bombs/", DEFAULT_MUG_ANIMATION = BOT_ASSET_FOLDER .. "mug.ani…` |
| `UI` | nested table | `{ OFF_MAP_POSITION = { x = -1000, y = -1000, z = 0 }, CONFIRM_PROMPT = "Press A To Confirm", CONFIRM_PROMPT_SCALE = 2.0, CONFIRM_PROMPT_Y = 5, NAVI_NAME_S…` |
| `INPUT` | nested table | `{ DIRECTION_SETTLE_SECONDS = 0.30, }` |
| `DIRECTIONS` | nested table | `{ CHOICES = { "Left", "Up", "Right" }, }` |
| `GAMEPLAY` | nested table | `{ -- Result phase movement tuning. Defender jump speed shapes progress -- within the authored movement window; it does not alter animation time. RESULT_KI…` |

### 3. `DIAGNOSTICS` — line 11

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `RUN_ANIMATION_DIAGNOSTICS` | boolean literal | `false` |
| `RUN_DIRECTION_MAPPING_TEST` | boolean literal | `false` |

### 4. `DEFAULTS` — line 16

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `SOURCE_AREA` | string literal | `"footbomb"` |
| `POINTS_TO_WIN` | numeric literal | `10` |
| `ASSET_NAME` | string literal | `"ref-prog"` |
| `MUGSHOT_NAME` | string literal | `"ref-prog-mug"` |

### 5. `ASSETS` — line 23

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `BOT_FOLDER` | expression/reference | `BOT_ASSET_FOLDER` |
| `MUG_FOLDER` | expression/reference | `BOT_ASSET_FOLDER` |
| `BOMB_FOLDER` | expression/reference | `ASSET_ROOT .. "bombs/"` |
| `DEFAULT_MUG_ANIMATION` | expression/reference | `BOT_ASSET_FOLDER .. "mug.animation"` |
| `CURSOR_TEXTURE` | string literal | `"/server/assets/net-games/cursors/text_cursor.png"` |
| `VIBRANT_CURSOR_TEXTURE` | string literal | `"/server/assets/net-games/cursors/vibrant_text_cursor.png"` |
| `CURSOR_ANIMATION` | string literal | `"/server/assets/net-games/cursors/text_cursor.animation"` |
| `CURSOR_SFX` | string literal | `"/server/assets/net-games/sfx/cursor_move.ogg"` |
| `SCOREBOARD_TEXTURE` | expression/reference | `ASSET_ROOT .. "ui/score-board.png"` |
| `SCOREBOARD_ANIMATION` | expression/reference | `ASSET_ROOT .. "ui/score-board.animation"` |
| `FINAL_SCORE_SFX` | expression/reference | `ASSET_ROOT .. "sfx/winner.ogg"` |
| `THUD_SFX` | expression/reference | `ASSET_ROOT .. "sfx/item-thud.ogg"` |
| `ROLE_PANEL_TEXTURE_KICKER` | expression/reference | `ASSET_ROOT .. "ui/kicker-role-box-9slice.png"` |
| `ROLE_PANEL_TEXTURE_DEFENDER` | expression/reference | `ASSET_ROOT .. "ui/defender-role-box-9slice.png"` |
| `[15]` | expression/reference | `-- Both role-specific textures use the shared 9-slice animation definition. ROLE_PANEL_ANIMATION = ASSET_ROOT .. "ui/role-box-9slice.animation"` |
| `ROLE_ICONS_TEXTURE` | expression/reference | `ASSET_ROOT .. "ui/role-icons.png"` |
| `ROLE_ICONS_ANIMATION` | expression/reference | `ASSET_ROOT .. "ui/role-icons.animation"` |

### 6. `UI` — line 44

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `OFF_MAP_POSITION` | nested table | `{ x = -1000, y = -1000, z = 0 }` |
| `CONFIRM_PROMPT` | string literal | `"Press A To Confirm"` |
| `CONFIRM_PROMPT_SCALE` | numeric literal | `2.0` |
| `CONFIRM_PROMPT_Y` | numeric literal | `5` |
| `NAVI_NAME_SCALE` | numeric literal | `1.5` |
| `SCREEN_WIDTH` | numeric literal | `240` |
| `SCREEN_HEIGHT` | numeric literal | `160` |
| `SCOREBOARD_X` | expression/reference | `SCREEN_CENTER.x - 100` |
| `SCOREBOARD_Y` | expression/reference | `SCREEN_CENTER.y - 50` |
| `SCOREBOARD_SCALE` | numeric literal | `2.0` |
| `SCORE_BOX_PLAYER_ONE_X` | numeric literal | `67` |
| `SCORE_BOX_PLAYER_TWO_X` | numeric literal | `122` |
| `SCORE_BOX_Y` | numeric literal | `54` |
| `SCORE_BOX_WIDTH` | numeric literal | `52` |
| `SCORE_BOX_HEIGHT` | numeric literal | `55` |
| `SCORE_TEXT_SCALE` | numeric literal | `4.0` |
| `ROLE_TEXT_Y` | numeric literal | `142` |
| `ROLE_TEXT_SCALE` | numeric literal | `2.0` |
| `ROLE_PANEL_Y` | numeric literal | `260` |
| `[20]` | expression/reference | `-- Keep horizontal inset at 6 while adding a little more room above/below. ROLE_PANEL_PADDING = { horizontal = 6, vertical = 8 }` |
| `[21]` | expression/reference | `-- Small inset on every side of each role-panel child. The sliced-panel -- layout includes this child padding in its measured auto-size. ROLE_PANEL_CHILD_…` |
| `ROLE_PANEL_SLICE_SCALE` | numeric literal | `2.0` |
| `ROLE_ICON_SCALE` | numeric literal | `1.0` |
| `[24]` | expression/reference | `-- Horizontal gap between the left icon, role text, and right icon. ROLE_ICON_GAP = 8` |
| `ROLE_ICON_STATE_KICKER` | string literal | `"KICKER"` |
| `ROLE_ICON_STATE_DEFENDER` | string literal | `"DEFENSE"` |
| `[27]` | expression/reference | `-- Character mug portraits sit on the matching score side. SCORE_PLAYER_ONE_MUG_X = 24` |
| `SCORE_PLAYER_TWO_MUG_X` | numeric literal | `176` |
| `SCORE_MUG_Y` | expression/reference | `SCREEN_CENTER.y - 24` |
| `SCORE_MUG_SCALE` | numeric literal | `2.0` |
| `BOMB_SELECTOR_SCALE` | numeric literal | `2.0` |
| `BOMB_CURSOR_LEFT_X` | expression/reference | `SCREEN_CENTER.x - 28` |
| `BOMB_CURSOR_RIGHT_X` | expression/reference | `SCREEN_CENTER.x + 34` |
| `BOMB_CURSOR_Y` | expression/reference | `SCREEN_CENTER.y + 12` |
| `BOMB_PREVIEW_X` | expression/reference | `SCREEN_CENTER.x - 17` |
| `BOMB_PREVIEW_Y` | expression/reference | `SCREEN_CENTER.y + 4` |
| `DIRECTION_CURSOR_X` | nested table | `{ 40, SCREEN_CENTER.x, 200 }` |
| `DIRECTION_CURSOR_Y` | expression/reference | `SCREEN_CENTER.y - 18` |
| `DIRECTION_CURSOR_SCALE` | numeric literal | `2.0` |
| `DIRECTION_CURSOR_BOB_OFFSET` | numeric literal | `5` |
| `DIRECTION_CURSOR_BOB_TICKS` | numeric literal | `2` |

### 7. `OFF_MAP_POSITION` — line 45

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | numeric literal | `-1000` |
| `y` | numeric literal | `-1000` |
| `z` | numeric literal | `0` |

### 8. `ROLE_PANEL_PADDING` — line 65

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `horizontal` | numeric literal | `6` |
| `vertical` | numeric literal | `8` |

### 9. `DIRECTION_CURSOR_X` — line 86

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `40` |
| `[2]` | expression/reference | `SCREEN_CENTER.x` |
| `[3]` | numeric literal | `200` |

### 10. `INPUT` — line 93

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `DIRECTION_SETTLE_SECONDS` | numeric literal | `0.30` |

### 11. `DIRECTIONS` — line 97

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `CHOICES` | nested table | `{ "Left", "Up", "Right" }` |

### 12. `CHOICES` — line 98

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | string literal | `"Left"` |
| `[2]` | string literal | `"Up"` |
| `[3]` | string literal | `"Right"` |

### 13. `GAMEPLAY` — line 101

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `-- Result phase movement tuning. Defender jump speed shapes progress -- within the authored movement window; it does not alter animation time. RESULT_KICK…` |
| `RESULT_KICKER_WALK_U_SPEED` | numeric literal | `3` |
| `RESULT_BOMB_MOVE_SPEED` | numeric literal | `3` |
| `RESULT_DEFENDER_JUMP_SPEED` | numeric literal | `3` |
| `[5]` | expression/reference | `-- Render the attached ball in front of the defender using bot depth. RESULT_BALL_Z_LIFT = 4` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
