# `ezlibs-custom/nebulous-liberations/liberations/enemy.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/enemy.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

enemy.lua

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/enemy.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/enemy.lua.md`
- **Source SHA-256 prefix:** `8fe5271e9024`

## Source header notes

- enemy.lua

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_templates` |
| `scripts/ezlibs-custom/nebulous-liberations/utils/exploding_effect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `Enemy.from` | `instance, position, direction, name` |
| `Enemy.is_alive` | `enemy` |
| `Enemy.destroy` | `instance, enemy` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`set_bot_name`, `is_bot`, `is_player_input_locked`, `lock_player_input`, `slide_player_camera`, `move_player_camera`, `unlock_player_camera`, `remove_bot`, `unlock_player_input`

## Engine `Async` calls

`create_promise`, `await`, `sleep`, `promisify`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
