# `HP_Manager/warp_manage.lua`

> **Source reference**
>
> Refreshed from the current `HP_Manager/warp_manage.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `HP_Manager/warp_manage.lua`
- **Reference:** `script-reference/HP_Manager/warp_manage.lua.md`
- **Source SHA-256 prefix:** `91541a51a6ed`

## Source header notes

- [[

## Direct `require` dependencies

| Import path |
|---|
| `scripts/HP_Manager/constants/constants` |

## `Net:on` subscriptions

| Event |
|---|
| `post_selection` |
| `board_close` |
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `load_warp_data` | `` |
| `save_warp_data` | `` |
| `async` | `func` |
| `await` | `promise` |
| `find_warp_controllers` | `area_id` |
| `apply_saved_warps` | `area_id` |
| `WarpManage.open` | `player_id, return_to_hp` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`list_objects`, `get_object_by_id`, `set_object_custom_property`, `get_player_area`, `open_board`, `on`, `close_bbs`, `list_areas`

## Engine `Async` calls

`promisify`, `await`, `prompt_player`, `message_player`, `sleep`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
