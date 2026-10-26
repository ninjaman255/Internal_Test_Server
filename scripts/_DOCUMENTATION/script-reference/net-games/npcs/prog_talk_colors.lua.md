# `net-games/npcs/prog_talk_colors.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/prog_talk_colors.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== prog_talk_colors.lua PROG talk NPCs: one per frame dye color Tiled object names must be: prog_{color} =====================================================

## Module location

- **Source:** `net-games/npcs/prog_talk_colors.lua`
- **Reference:** `script-reference/net-games/npcs/prog_talk_colors.lua.md`
- **Source SHA-256 prefix:** `d869219ed423`

## Source header notes

- prog_talk_colors.lua
- PROG talk NPCs: one per frame dye color
- Tiled object names must be: prog_{color}

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/main` |
| `scripts/net-games/npcs/talk` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ow` | `color` |

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `AREA_ID` | `"default"` |
| `OW_COLOR_DIR` | `"/server/assets/ow/prog/"` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ow/prog/` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
