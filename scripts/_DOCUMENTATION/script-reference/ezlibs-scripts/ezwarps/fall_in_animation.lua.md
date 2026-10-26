# `ezlibs-scripts/ezwarps/fall_in_animation.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezwarps/fall_in_animation.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Fall in animation source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezwarps/fall_in_animation.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezwarps/fall_in_animation.lua.md`
- **Source SHA-256 prefix:** `4c68dc15985b`

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `animate` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_player_position`, `get_player_area`, `animate_player_properties`, `play_sound`, `shake_player_camera`, `unlock_player_input`

## Engine `Async` calls

`sleep`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/ezwarps/earthquake.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
