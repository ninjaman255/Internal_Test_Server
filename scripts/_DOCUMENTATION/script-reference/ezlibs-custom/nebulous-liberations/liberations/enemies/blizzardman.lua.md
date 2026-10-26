# `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Blizzardman source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua.md`
- **Source SHA-256 prefix:** `28a9d0b998a3`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/preloader` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `BlizzardMan:new` | `instance, position, direction` |
| `BlizzardMan:spawn` | `direction` |
| `BlizzardMan:get_death_message` | `` |
| `BlizzardMan:take_turn` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`create_bot`, `set_bot_minimap_color`, `get_bot_direction`, `animate_bot_properties`, `shake_player_camera`, `remove_bot`

## Engine `Async` calls

`await`, `sleep`, `promisify`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/NebuLibsAssets/bots/snowball.png` |
| `/server/assets/NebuLibsAssets/bots/snowball.animation` |
| `/server/assets/NebuLibsAssets/mugs/blizzardman.png` |
| `/server/assets/NebuLibsAssets/mugs/blizzardman.animation` |
| `/server/assets/encounters/big_brute_encounter.zip` |
| `/server/assets/NebuLibsAssets/bots/blizzardman.png` |
| `/server/assets/NebuLibsAssets/bots/blizzardman.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
