# `ezlibs-scripts/ezusers.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezusers.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

ezusers.lua A flexible user/role/permission system for your server. Stores each player's role and a full copy of their permissions in ezmemory. Permissions are defined per role in the global `permissions` table. Per‑user permissions can be overridden without changing the role. Integrates with ezlibs via standard plugin hooks: handle_player_join, handle_player_disconnect.

## Module location

- **Source:** `ezlibs-scripts/ezusers.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezusers.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezconfig` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/object_registry` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/sha256` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `add_role` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `assign_role` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `async` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `await` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `check_password_and_grant_admin` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `deep_copy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_role` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_safe_secret` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `get_user_permissions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `handle_player_join` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `has_permission` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `reset_user_permissions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_user_permission` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `update_permissions` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Uppercase constants

`BBS`

## Source notes

- Approximate source size: 346 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
