# `net-games/npcs/prog_shop.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/prog_shop.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== prog_shop.lua Default PROG shop NPC: - Default OW sprite + default mug - No frame dye (uses default look) - Uses shop UI skin for the vertical menu window =====================================================

## Module location

- **Source:** `net-games/npcs/prog_shop.lua`
- **Reference:** `script-reference/net-games/npcs/prog_shop.lua.md`
- **Source SHA-256 prefix:** `6c393c52ad3f`

## Source header notes

- prog_shop.lua
- Default PROG shop NPC:
- - Default OW sprite + default mug
- - No frame dye (uses default look)
- - Uses shop UI skin for the vertical menu window

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/npcs/talk` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `on_interact` | `player_id, _bot_id, bot_name` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ow/prog/prog_ow.png` |
| `/server/assets/ow/prog/prog_ow.animation` |
| `/server/assets/net-games/ui/prompt_vert_menu_shop_an.png` |
| `/server/assets/net-games/ui/prompt_vert_menu_an.animation` |
| `/server/assets/net-games/ui/prompt_vert_menu_shop_an_frame.png` |
| `/server/assets/net-games/ui/highlight_shop.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
