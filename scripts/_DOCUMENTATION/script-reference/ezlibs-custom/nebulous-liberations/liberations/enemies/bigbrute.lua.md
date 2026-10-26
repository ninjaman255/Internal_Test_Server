# `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Bigbrute source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua.md`
- **Source SHA-256 prefix:** `44dacd33d3df`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/preloader` |
| `scripts/libs/direction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `BigBrute:new` | `instance, position, direction` |
| `BigBrute:spawn` | `direction` |
| `BigBrute:get_death_message` | `` |
| `sign` | `a` |
| `find_offset` | `self, xstep, ystep, limit` |
| `attempt_axis_move` | `self, player, diff, xfilter, yfilter` |
| `attempt_move` | `self` |
| `attempt_attack` | `self` |
| `BigBrute:take_turn` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`create_bot`, `set_bot_minimap_color`, `get_bot_direction`, `shake_player_camera`, `remove_bot`

## Engine `Async` calls

`create_promise`, `await`, `promisify`, `sleep`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/NebuLibsAssets/bots/beast breath.png` |
| `/server/assets/NebuLibsAssets/bots/beast breath.animation` |
| `/server/assets/encounters/big_brute_encounter.zip` |
| `/server/assets/NebuLibsAssets/bots/bigbrute.png` |
| `/server/assets/NebuLibsAssets/bots/bigbrute.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
