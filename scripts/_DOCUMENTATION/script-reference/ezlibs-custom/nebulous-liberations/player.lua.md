# `ezlibs-custom/nebulous-liberations/player.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/player.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Player source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/player.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/player.lua.md`
- **Source SHA-256 prefix:** `f6debf6fffcf`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/helpers` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `create_textbox_promise` | `self` |
| `Player:new` | `player_id` |
| `Player:message` | `message, texture_path, animation_path` |
| `Player:message_with_mug` | `message` |
| `Player:question` | `question, texture_path, animation_path` |
| `Player:question_with_mug` | `question` |
| `Player:quiz` | `a, b, c, texture_path, animation_path` |
| `Player:is_battling` | `` |
| `create_default_results` | `` |
| `Player:initiate_encounter` | `asset_path, data` |
| `Player:handle_textbox_response` | `response` |
| `Player:handle_battle_results` | `stats` |
| `Player:handle_disconnect` | `` |
| `Player:boot_to_lobby` | `isVictory, mapName` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_player_position`, `get_player_mugshot`, `message_player`, `question_player`, `quiz_player`, `initiate_encounter`, `get_player_area`, `get_area_custom_property`, `get_object_by_name`, `get_spawn_position`, `transfer_player`, `list_objects`, `get_object_by_id`

## Engine `Async` calls

`create_promise`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
