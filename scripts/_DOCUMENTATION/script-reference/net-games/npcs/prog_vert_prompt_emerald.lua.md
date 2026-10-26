# `net-games/npcs/prog_vert_prompt_emerald.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/prog_vert_prompt_emerald.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== prog_vert_prompt_emerald_shop.lua Shop-themed variant of ProgVertPromptRed: - identical flow + option generator - overrides PromptVertical assets ONLY for this NPC instance =====================================================

## Module location

- **Source:** `net-games/npcs/prog_vert_prompt_emerald.lua`
- **Reference:** `script-reference/net-games/npcs/prog_vert_prompt_emerald.lua.md`
- **Source SHA-256 prefix:** `924257c9b819`

## Source header notes

- prog_vert_prompt_emerald_shop.lua
- Shop-themed variant of ProgVertPromptRed:
- - identical flow + option generator
- - overrides PromptVertical assets ONLY for this NPC instance

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
| `/server/assets/ow/prog/prog_ow_emerald.png` |
| `/server/assets/ow/prog/prog_ow.animation` |
| `/server/assets/net-games/ui/prompt_vert_menu_shop_an.png` |
| `/server/assets/net-games/ui/prompt_vert_menu_an.animation` |
| `/server/assets/net-games/ui/prompt_vert_menu_shop_an_frame.png` |
| `/server/assets/net-games/ui/highlight_shop.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
