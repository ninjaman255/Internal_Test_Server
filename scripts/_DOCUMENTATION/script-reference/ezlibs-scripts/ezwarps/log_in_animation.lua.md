# `ezlibs-scripts/ezwarps/log_in_animation.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezwarps/log_in_animation.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Log in animation source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezwarps/log_in_animation.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezwarps/log_in_animation.lua.md`
- **Source SHA-256 prefix:** `8b8b60aa8da1`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `create_jack_in_out_animation` | `is_arriving` |
| `animate` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_player_position`, `get_player_area`, `provide_asset`, `create_bot`, `animate_bot`, `play_sound`, `animate_player_properties`, `list_players`, `include_actor_for_player`, `exclude_actor_for_player`, `unlock_player_camera`, `remove_bot`

## Engine `Async` calls

`sleep`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/ezwarps/logout.png` |
| `/server/assets/ezlibs-assets/ezwarps/logout.animation` |
| `/server/assets/ezlibs-assets/ezwarps/log_in.ogg` |
| `/server/assets/ezlibs-assets/ezwarps/log_out.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
