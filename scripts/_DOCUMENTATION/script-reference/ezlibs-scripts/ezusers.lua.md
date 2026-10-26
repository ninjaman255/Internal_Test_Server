# `ezlibs-scripts/ezusers.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezusers.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezusers.lua A flexible user/role/permission system for your server. Stores each player's role and a full copy of their permissions in ezmemory. Permissions are defined per role in the global `permissions` table. Per‑user permissions can be overridden without changing the role. Integrates with ezlibs via standard plugin hooks: handle_player_join, handle_player_disconnect.

## Module location

- **Source:** `ezlibs-scripts/ezusers.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezusers.lua.md`
- **Source SHA-256 prefix:** `8302a28d5cb8`

## Source header notes

- ezusers.lua
- A flexible user/role/permission system for your server.
- Stores each player's role and a full copy of their permissions in ezmemory.
- Permissions are defined per role in the global `permissions` table.
- Per‑user permissions can be overridden without changing the role.
- Integrates with ezlibs via standard plugin hooks: handle_player_join, handle_player_disconnect.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/sha256` |
| `scripts/ezlibs-scripts/ezconfig` |
| `scripts/ezlibs-scripts/object_registry` |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `async` | `p` |
| `await` | `v` |
| `deep_copy` | `orig` |
| `get_safe_secret` | `player_id` |
| `get_role` | `player_id` |
| `assign_role` | `player_id, role` |
| `get_user_permissions` | `player_id` |
| `set_user_permission` | `player_id, permission_path, value` |
| `reset_user_permissions` | `player_id` |
| `has_permission` | `player_id, permission_path` |
| `check_password_and_grant_admin` | `player_id, password_attempt` |
| `add_role` | `role_name, permission_table` |
| `update_permissions` | `role_name, permission_updates` |
| `handle_player_join` | `player_id` |
| `handle_player_disconnect` | `player_id` |

## Engine `Async` calls

`promisify`, `await`, `message_player`, `question_player`, `prompt_player`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `BBS` | `{` |
| `BBS` | `{` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
