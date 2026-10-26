# `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

enemy_templates.lua

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/enemy_templates.lua.md`
- **Source SHA-256 prefix:** `e8b3e4c8563c`

## Source header notes

- enemy_templates.lua

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/preloader` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `EnemyTemplates.register` | `name, template` |
| `EnemyTemplates.create` | `instance, position, direction, template_name` |
| `EnemyTemplates.ai.simple_charge` | `self` |
| `attempt_axis` | `xstep, ystep, diff` |
| `EnemyTemplates.ai.ranged` | `self` |
| `spawn` | `self, direction` |
| `get_death_message` | `self` |
| `take_turn` | `self` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`create_bot`, `set_bot_minimap_color`, `get_bot_direction`, `shake_player_camera`, `remove_bot`

## Engine `Async` calls

`create_promise`, `await`, `sleep`, `promisify`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/NebuLibsAssets/bots/beast breath.png` |
| `/server/assets/NebuLibsAssets/bots/beast breath.animation` |
| `/server/assets/NebuLibsAssets/bots/bigbrute.png` |
| `/server/assets/NebuLibsAssets/bots/bigbrute.animation` |
| `/server/assets/encounters/big_brute_encounter.zip` |
| `/server/assets/NebuLibsAssets/bots/blizzardman.png` |
| `/server/assets/NebuLibsAssets/bots/blizzardman.animation` |
| `/server/assets/NebuLibsAssets/bots/snowball.png` |
| `/server/assets/NebuLibsAssets/bots/snowball.animation` |
| `/server/assets/NebuLibsAssets/mugs/blizzardman.png` |
| `/server/assets/NebuLibsAssets/mugs/blizzardman.animation` |
| `/server/assets/NebuLibsAssets/bots/shademan.png` |
| `/server/assets/NebuLibsAssets/bots/shademan.animation` |
| `/server/assets/ezlibs-assets/ezencounters/Shademan.zip` |
| `/server/assets/NebuLibsAssets/mugs/shademan.png` |
| `/server/assets/NebuLibsAssets/mugs/shademan.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
