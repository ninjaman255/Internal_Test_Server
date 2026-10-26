# `net-games/npcs/prog_talk_dialogue.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/prog_talk_dialogue.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

===================================================== prog_talk_dialogue.lua Example: PROG-style prompt that branches into dialogue Uses NEW Talk.npc + presets + purple frame dye =====================================================

## Module location

- **Source:** `net-games/npcs/prog_talk_dialogue.lua`
- **Reference:** `script-reference/net-games/npcs/prog_talk_dialogue.lua.md`
- **Source SHA-256 prefix:** `9ba5eebb43cb`

## Source header notes

- prog_talk_dialogue.lua
- Example: PROG-style prompt that branches into dialogue
- Uses NEW Talk.npc + presets + purple frame dye

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/main` |
| `scripts/net-games/npcs/talk` |

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `AREA_ID` | `"default"              -- your map/area id` |
| `OBJECT` | `"prog_talk_prompt_npc" -- Tiled object name for this NPC` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
