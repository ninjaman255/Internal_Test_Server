# `ezlibs-scripts/ezmystery.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezmystery.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-scripts/ezmystery.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezmystery.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `math` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/avatar_utils/avatar_utils` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/avatar_utils/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/condition` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezcache` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezencounters/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlocks` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `avatar_change` | `Net:on(...)` subscription found in source. |
| `object_interaction` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `explode` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `mystery_collected` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `collect_datum` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmystery.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmystery.handle_player_join` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmystery.handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezmystery.hide_random_data` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `fetch_player_avatar_and_details` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `is_property_true` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `object_is_mystery_data` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `read_datum_information` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resource_name` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `run_quiz_from_list` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `try_collect_datum` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 398 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
