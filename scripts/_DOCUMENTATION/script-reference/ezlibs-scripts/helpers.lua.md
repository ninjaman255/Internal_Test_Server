# `ezlibs-scripts/helpers.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/helpers.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-scripts/helpers.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/helpers.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezcache` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/urlencode` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/utils/ezutil` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `first_value_from_table` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_table_length` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.clear_table` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.create_bbs_option` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.date_string_to_timestamp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.deep_copy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.ensure_directory` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.extract_numbered_properties` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.get_lock` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.get_safe_player_secret` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.indexOf` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.is_now_before_date` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.position_overlaps_something` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.read_item_information` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.safe_require` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `helpers.split` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `release` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 228 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
