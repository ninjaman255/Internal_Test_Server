# `avatar_registry/main.lua`

> **Source reference**
>
> Refreshed from the current `avatar_registry/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `avatar_registry/main.lua`
- **Reference:** `script-reference/avatar_registry/main.lua.md`
- **Source SHA-256 prefix:** `f900737c6478`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/avatar_utils/avatar_registry` |
| `scripts/avatar_utils/avatar_utils` |

## `Net:on` subscriptions

| Event |
|---|
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `sanitize` | `s` |
| `join_path` | `a, b` |
| `default_base_dir` | `player_id` |
| `build_disk_paths` | `base_dir` |
| `AvatarRegistry.copy` | `player_id, base_dir` |
| `AvatarRegistry.get` | `player_id` |
| `AvatarRegistry.get_or_copy` | `player_id, base_dir` |
| `AvatarRegistry.has` | `player_id` |
| `AvatarRegistry.get_paths` | `player_id` |
| `AvatarRegistry.get_bot_def` | `player_id, overrides` |
| `AvatarRegistry.remove` | `player_id, opts` |
| `AvatarRegistry.clear` | `opts` |
| `AvatarRegistry.list` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`create_bot`, `has_asset`, `remove_asset`, `on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DEFAULT_BASE` | `"assets/avatars"` |
| `FILE_NAMES` | `{` |
| `PATH_KEYS` | `{` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/avatars/<id>/player.png` |
| `/server/assets/avatars/<id>/player.animation` |
| `/server/assets/avatars/<id>/player_mug.png` |
| `/server/assets/avatars/<id>/player_mug.animation` |
| `assets/avatars` |
| `assets/avatars/<sanitized-player-id>` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
