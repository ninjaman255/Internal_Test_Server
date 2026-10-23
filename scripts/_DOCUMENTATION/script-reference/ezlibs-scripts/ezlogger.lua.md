# `ezlibs-scripts/ezlogger.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezlogger.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

ezlogger.lua Shared append-only JSONL logging for ezlibs modules. Lua 5.2 compatible. Log files are written below: scripts/ezlibs-scripts/_DEBUGGING/<module>/ Default module log: debugging.log Player log:         <safe-player-secret>.log Area/map log:       <area-id>.log

## Module location

- **Source:** `ezlibs-scripts/ezlogger.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezlogger.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/json` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/urlencode` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_join` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `Logger:_log` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:_should_log` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:debug` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:debug_data` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:error` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:error_data` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:flush` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:for_area` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:for_safe_secret` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:forceFlush` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:info` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:info_data` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:set_min_level` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:warn` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `Logger:warn_data` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `cache_key` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `copy_options` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `directory_of` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `encode_entry` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `encode_string` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_directory` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezlogger.configure` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezlogger.flush_all` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezlogger.get` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `join_arguments` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `make_logger` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `mkdir_recursive_lfs` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `module_name_of` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_path` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_safe_player_secret` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `safe_component` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `timestamp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 456 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
