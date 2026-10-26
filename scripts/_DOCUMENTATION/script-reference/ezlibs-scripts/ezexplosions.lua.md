# `ezlibs-scripts/ezexplosions.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezexplosions.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Ezexplosions source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezexplosions.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezexplosions.lua.md`
- **Source SHA-256 prefix:** `5da457d0a412`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/ezlogger` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `async` | `fn` |
| `await` | `value` |
| `update_tracked_position` | `exploding_effect` |
| `finish_effect` | `self, reason` |
| `remove_explosion_bot` | `self, bot_id, reason` |
| `remove_all_active_bots` | `self, reason` |
| `explode` | `self, explosion_bot_id` |
| `spawn` | `self` |
| `ExplodingEffect:new` | `actor_id, opt_area_id, max_explosions, on_complete` |
| `ExplodingEffect:remove` | `` |
| `ezexplosions.explode` | `actor_id, area_id, max_explosions, on_complete` |
| `ezexplosions.explode_and_wait` | `actor_id, area_id, max_explosions, timeout_seconds` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`is_bot`, `get_bot_area`, `get_bot_position`, `is_player`, `get_player_area`, `get_player_position`, `get_object_by_id`, `remove_bot`, `transfer_bot`, `play_sound`, `animate_bot`, `create_bot`

## Engine `Async` calls

`promisify`, `await`, `sleep`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `EXPLOSION_DURATION` | `.6` |
| `EXPLOSION_TAIL_DURATION` | `0.2` |
| `EXPLOSION_AXIS_RANGE` | `.5` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/sfx/explode.ogg` |
| `/server/assets/ezlibs-assets/ezexplosions/explosion.png` |
| `/server/assets/ezlibs-assets/ezexplosions/explosion.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
