# `ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Exploding effect source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua.md`
- **Source SHA-256 prefix:** `a4f26f013bf7`

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `update_tracked_position` | `exploding_effect` |
| `explode` | `self, explosion_bot_id` |
| `spawn` | `self, area_id, position` |
| `ExplodingEffect:new` | `actor_id` |
| `ExplodingEffect:remove` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`is_bot`, `get_bot_area`, `get_bot_position`, `is_player`, `get_player_area`, `get_player_position`, `transfer_bot`, `remove_bot`, `play_sound`, `animate_bot`, `create_bot`

## Engine `Async` calls

`sleep`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `TOTAL_EXPLOSIONS` | `3` |
| `EXPLOSION_DURATION` | `.6` |
| `EXPLOSION_AXIS_RANGE` | `.5` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/NebuLibsAssets/sound effects/explode.ogg` |
| `/server/assets/NebuLibsAssets/bots/explosion.png` |
| `/server/assets/NebuLibsAssets/bots/explosion.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
