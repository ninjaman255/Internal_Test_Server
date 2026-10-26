# `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Shademan source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/enemies/shademan.lua.md`
- **Source SHA-256 prefix:** `fa98eeb7b60e`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/preloader` |
| `scripts/libs/direction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ShadeMan:new` | `instance, position, direction` |
| `ShadeMan:spawn` | `direction` |
| `ShadeMan:get_death_message` | `` |
| `ShadeMan:take_turn` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`create_bot`, `set_bot_minimap_color`

## Engine `Async` calls

`await`, `sleep`, `message_player`, `promisify`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/NebuLibsAssets/mugs/shademan.png` |
| `/server/assets/NebuLibsAssets/mugs/shademan.animation` |
| `/server/assets/ezlibs-assets/ezencounters/Shademan.zip` |
| `/server/assets/NebuLibsAssets/bots/shademan.png` |
| `/server/assets/NebuLibsAssets/bots/shademan.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
