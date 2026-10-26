# `net-games/npcs/talk_presets.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/talk_presets.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== talk_presets.lua Creator-facing presets for Dialogue NPCs (PROG-defaulted) =====================================================

## Module location

- **Source:** `net-games/npcs/talk_presets.lua`
- **Reference:** `script-reference/net-games/npcs/talk_presets.lua.md`
- **Source SHA-256 prefix:** `ce19a27c0f67`

## Source header notes

- talk_presets.lua
- Creator-facing presets for Dialogue NPCs (PROG-defaulted)

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `_shallow_copy` | `t` |
| `P.get_vert_menu_layout` | `key` |
| `P.get_vert_menu_flow` | `key` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ow/prog/prog_mug.png` |
| `/server/assets/ow/prog/prog_mug.animation` |
| `/server/assets/ow/prog/prog_mug_red.png` |
| `/server/assets/ow/prog/prog_mug_sapphire.png` |
| `/server/assets/ow/prog/prog_mug_emerald.png` |
| `/server/assets/ow/prog/prog_mug_yellow.png` |
| `/server/assets/ow/prog/prog_mug_orange.png` |
| `/server/assets/ow/prog/prog_mug_purple.png` |
| `/server/assets/ow/prog/prog_mug_pink.png` |
| `/server/assets/ow/prog/prog_mug_turquoise.png` |
| `/server/assets/ow/prog/prog_mug_charcoal_grey.png` |
| `/server/assets/ow/prog/prog_mug_lime.png` |
| `/server/assets/ow/prog/prog_mug_white.png` |
| `/server/assets/net-games/sfx/text.ogg` |
| `/server/assets/net-games/sfx/card_desc.ogg` |
| `/server/assets/net-games/sfx/card_confirm.ogg` |
| `/server/assets/net-games/sfx/card_desc_close.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
