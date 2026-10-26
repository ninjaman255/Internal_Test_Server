# `ezlibs-scripts/avatar_utils/avatar_utils.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/avatar_utils/avatar_utils.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

avatar_utils.lua Utility functions for handling player avatars and mugshots

## Module location

- **Source:** `ezlibs-scripts/avatar_utils/avatar_utils.lua`
- **Reference:** `script-reference/ezlibs-scripts/avatar_utils/avatar_utils.lua.md`
- **Source SHA-256 prefix:** `befc1af2ef82`

## Source header notes

- avatar_utils.lua
- Utility functions for handling player avatars and mugshots

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/lib` |
| `scripts/ezlibs-scripts/avatar_utils/base64` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `parse_duration` | `duration_str` |
| `ensure_directory` | `filepath` |
| `set_or_update_asset` | `asset_path, asset_content` |
| `write_temp_file` | `content` |
| `avatar_utils.copy_player_avatar_to` | `player_id, new_texture_path, new_animation_path, mug_texture_path, mug_animation_path` |
| `avatar_utils.parse_animation_data` | `data` |
| `avatar_utils.parse_animation_file` | `filepath` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`has_asset`, `remove_asset`, `update_asset`, `get_player_avatar`, `get_player_mugshot`, `read_asset`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `assets/avatars/sheet/secret.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
