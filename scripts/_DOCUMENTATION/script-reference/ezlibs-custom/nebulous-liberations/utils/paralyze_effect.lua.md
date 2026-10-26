# `ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Paralyze effect source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua.md`
- **Source SHA-256 prefix:** `4a0c21b1a8e3`

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ParalyzeEffect:new` | `actor_id, area_wide_sfx` |
| `ParalyzeEffect:remove` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`is_bot`, `get_bot_area`, `get_bot_position`, `is_player`, `get_player_area`, `get_player_position`, `play_sound`, `play_sound_for_player`, `create_bot`, `remove_bot`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `SFX_PATH` | `"/server/assets/NebuLibsAssets/sound effects/paralyze.ogg"` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/NebuLibsAssets/sound effects/paralyze.ogg` |
| `/server/assets/NebuLibsAssets/bots/paralyze.png` |
| `/server/assets/NebuLibsAssets/bots/paralyze.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
