# `ezlibs-scripts/helpers.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/helpers.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Helpers source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/helpers.lua`
- **Reference:** `script-reference/ezlibs-scripts/helpers.lua.md`
- **Source SHA-256 prefix:** `42f814d7efe8`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/utils/ezutil` |
| `scripts/ezlibs-scripts/urlencode` |
| `scripts/ezlibs-scripts/ezcache` |

## `Net:on` subscriptions

| Event |
|---|
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `async` | `p` |
| `await` | `v` |
| `first_value_from_table` | `tbl` |
| `get_table_length` | `tbl` |
| `helpers.indexOf` | `array, value` |
| `helpers.extract_numbered_properties` | `object,property_prefix` |
| `helpers.clear_table` | `tbl` |
| `helpers.create_bbs_option` | `text,id` |
| `helpers.deep_copy` | `orig` |
| `helpers.split` | `string, delimiter` |
| `helpers.get_safe_player_secret` | `player_id` |
| `helpers.safe_require` | `script_path` |
| `helpers.date_string_to_timestamp` | `date_string` |
| `helpers.is_now_before_date` | `date_string` |
| `helpers.position_overlaps_something` | `position,area_id` |
| `helpers.get_lock` | `player_id,lock_id,timeout` |
| `helpers.read_item_information` | `area_id, item_object_id` |
| `helpers.ensure_directory` | `path` |
| `release` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`get_player_secret`, `list_players`, `get_player_position`, `on`

## Engine `Async` calls

`promisify`, `await`, `sleep`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
