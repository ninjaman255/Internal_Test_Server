# `ezlibs-custom/footbomb/constants.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/footbomb/constants.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

FootBomb configuration. Keep values grouped by responsibility so UI, assets, input, and match tuning can be adjusted independently of lifecycle code.

## Module location

- **Source:** `ezlibs-custom/footbomb/constants.lua`
- **Reference:** `script-reference/ezlibs-custom/footbomb/constants.lua.md`
- **Source SHA-256 prefix:** `b32b0f13f41f`

## Source header notes

- FootBomb configuration.
- Keep values grouped by responsibility so UI, assets, input, and match tuning
- can be adjusted independently of lifecycle code.

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `ASSET_ROOT` | `"/server/assets/net-game-footbomb/"` |
| `BOT_ASSET_FOLDER` | `ASSET_ROOT .. "bots/"` |
| `SCREEN_CENTER` | `{ x = 120, y = 80 }` |
| `DIAGNOSTICS` | `{` |
| `RUN_ANIMATION_DIAGNOSTICS` | `false,` |
| `RUN_DIRECTION_MAPPING_TEST` | `false,` |
| `DEFAULTS` | `{` |
| `SOURCE_AREA` | `"footbomb",` |
| `POINTS_TO_WIN` | `10,` |
| `ASSET_NAME` | `"ref-prog",` |
| `MUGSHOT_NAME` | `"ref-prog-mug",` |
| `ASSETS` | `{` |
| `BOT_FOLDER` | `BOT_ASSET_FOLDER,` |
| `MUG_FOLDER` | `BOT_ASSET_FOLDER,` |
| `BOMB_FOLDER` | `ASSET_ROOT .. "bombs/",` |
| `DEFAULT_MUG_ANIMATION` | `BOT_ASSET_FOLDER .. "mug.animation",` |
| `CURSOR_TEXTURE` | `"/server/assets/net-games/cursors/text_cursor.png",` |
| `VIBRANT_CURSOR_TEXTURE` | `"/server/assets/net-games/cursors/vibrant_text_cursor.png",` |
| `CURSOR_ANIMATION` | `"/server/assets/net-games/cursors/text_cursor.animation",` |
| `CURSOR_SFX` | `"/server/assets/net-games/sfx/cursor_move.ogg",` |
| `SCOREBOARD_TEXTURE` | `ASSET_ROOT .. "ui/score-board.png",` |
| `SCOREBOARD_ANIMATION` | `ASSET_ROOT .. "ui/score-board.animation",` |
| `FINAL_SCORE_SFX` | `ASSET_ROOT .. "sfx/winner.ogg",` |
| `THUD_SFX` | `ASSET_ROOT .. "sfx/item-thud.ogg",` |
| `ROLE_PANEL_TEXTURE_KICKER` | `ASSET_ROOT .. "ui/kicker-role-box-9slice.png",` |
| `ROLE_PANEL_TEXTURE_DEFENDER` | `ASSET_ROOT .. "ui/defender-role-box-9slice.png",` |
| `ROLE_PANEL_ANIMATION` | `ASSET_ROOT .. "ui/role-box-9slice.animation",` |
| `ROLE_ICONS_TEXTURE` | `ASSET_ROOT .. "ui/role-icons.png",` |
| `ROLE_ICONS_ANIMATION` | `ASSET_ROOT .. "ui/role-icons.animation",` |
| `OFF_MAP_POSITION` | `{ x = -1000, y = -1000, z = 0 },` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-game-footbomb/` |
| `/server/assets/net-games/cursors/text_cursor.png` |
| `/server/assets/net-games/cursors/vibrant_text_cursor.png` |
| `/server/assets/net-games/cursors/text_cursor.animation` |
| `/server/assets/net-games/sfx/cursor_move.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
