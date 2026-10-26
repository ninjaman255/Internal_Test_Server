# `cosmo.lua`

> **Source reference**
>
> Refreshed from the current `cosmo.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `cosmo.lua`
- **Reference:** `script-reference/cosmo.lua.md`
- **Source SHA-256 prefix:** `dfeb809cc17a`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/main` |
| `scripts/net-games/helpers/net-helpers` |

## `Net:on` subscriptions

| Event |
|---|
| `actor_interaction` |
| `player_join` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `log` | `message` |
| `spawn_cosmo_from_tiled` | `` |
| `enable_cosmetic` | `player_id` |
| `disable_cosmetic` | `player_id` |
| `is_enabled` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`list_areas`, `list_objects`, `get_object_by_id`, `is_bot`, `create_bot`, `message_player`, `on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `COSMO_OBJECT_NAME` | `"CosmeticRoll"` |
| `COSMO_BOT_ID` | `"cosmo"` |
| `COSMO_TEXTURE` | `"/server/assets/demo/roll.png"` |
| `COSMO_ANIMATION` | `"/server/assets/demo/roll.animation"` |
| `COSMETIC_ID` | `"confetti"` |
| `COSMETIC_TEXTURE` | `"/server/assets/demo/shock.png"` |
| `COSMETIC_ANIMATION` | `"/server/assets/demo/shock.anim"` |
| `COSMETIC_STATE` | `"cosmetic"` |
| `COSMETIC_SCREEN_X` | `2` |
| `COSMETIC_SCREEN_Y` | `-40` |
| `COSMETIC_VISIBLE` | `true` |
| `COSMETIC_PLAYER_XOFFSET` | `-2` |
| `COSMETIC_PLAYER_YOFFSET` | `-2` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/demo/roll.png` |
| `/server/assets/demo/roll.animation` |
| `/server/assets/demo/shock.png` |
| `/server/assets/demo/shock.anim` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
