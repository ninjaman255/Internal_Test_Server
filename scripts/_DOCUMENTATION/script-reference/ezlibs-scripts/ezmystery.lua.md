# `ezlibs-scripts/ezmystery.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezmystery.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Ezmystery source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezmystery.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezmystery.lua.md`
- **Source SHA-256 prefix:** `b9c66c6181f5`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/ezcache` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/ezlocks` |
| `scripts/ezlibs-scripts/condition` |
| `scripts/ezlibs-scripts/ezencounters/main` |
| `math` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/avatar_utils/main` |
| `scripts/ezlibs-scripts/avatar_utils/avatar_utils` |

## `Net:on` subscriptions

| Event |
|---|
| `player_join` |
| `avatar_change` |
| `object_interaction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `is_property_true` | `val` |
| `resource_name` | `cost_type` |
| `object_is_mystery_data` | `object` |
| `fetch_player_avatar_and_details` | `player_id` |
| `ezmystery.handle_player_disconnect` | `player_id` |
| `ezmystery.hide_random_data` | `player_id` |
| `ezmystery.handle_player_transfer` | `player_id` |
| `ezmystery.handle_player_join` | `player_id` |
| `run_quiz_from_list` | `player_id, area_id, quiz_list_id, failure_message` |
| `try_collect_datum` | `player_id, area_id, object` |
| `read_datum_information` | `area_id, object` |
| `collect_datum` | `player_id, object, datum_id_override, is_quiz` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_player_secret`, `on`, `get_player_area`, `get_object_by_id`, `list_objects`, `get_area_custom_property`, `get_player_direction`

## Engine `Async` calls

`message_player`, `quiz_player`, `question_player`, `sleep`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/sfx/item_get.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
