# `ezlibs-scripts/ezwarps/lev_beast_in_animation.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezwarps/lev_beast_in_animation.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Lev beast in animation source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezwarps/lev_beast_in_animation.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezwarps/lev_beast_in_animation.lua.md`
- **Source SHA-256 prefix:** `f6ba8ac259eb`

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `animate` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_player_position`, `get_player_area`, `create_bot`, `shake_player_camera`, `animate_player`, `animate_player_properties`, `animate_bot_properties`, `play_sound`, `unlock_player_input`, `remove_bot`

## Engine `Async` calls

`sleep`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/ezwarps/lev-beast-64-65.png` |
| `/server/assets/ezlibs-assets/ezwarps/lev-beast-64-65.animation` |
| `/server/assets/ezlibs-assets/ezwarps/lev-bus-arrive.ogg` |
| `/server/assets/ezlibs-assets/ezwarps/lev-bus-leave.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
