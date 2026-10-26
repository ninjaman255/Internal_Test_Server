# `ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Enemy helpers source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua.md`
- **Source SHA-256 prefix:** `94551bc7fab6`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/utils/recover_effect` |
| `scripts/libs/direction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `EnemyHelpers.play_attack_animation` | `enemy` |
| `EnemyHelpers.update_name` | `enemy` |
| `EnemyHelpers.heal` | `enemy, amount` |
| `EnemyHelpers.face_position` | `enemy, x, y` |
| `EnemyHelpers.can_move_to` | `instance, x, y, z` |
| `EnemyHelpers.move` | `instance, enemy, x, y, z, direction` |
| `EnemyHelpers.offset_position_with_direction` | `position, direction` |
| `EnemyHelpers.chebyshev_tile_distance` | `enemy, x, y` |
| `EnemyHelpers.find_closest_player_session` | `instance, enemy` |
| `EnemyHelpers.sync_health` | `enemy, results` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_bot_direction`, `animate_bot`, `set_bot_name`, `set_bot_direction`, `slide_player_camera`, `get_bot_area`, `create_bot`, `get_width`, `transfer_bot`, `remove_bot`

## Engine `Async` calls

`create_promise`, `await`, `sleep`, `promisify`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/NebuLibsAssets/bots/blur.png` |
| `/server/assets/NebuLibsAssets/bots/blur.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
