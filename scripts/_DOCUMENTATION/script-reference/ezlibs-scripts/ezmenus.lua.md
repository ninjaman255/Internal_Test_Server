# `ezlibs-scripts/ezmenus.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezmenus.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Ezmenus source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezmenus.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezmenus.lua.md`
- **Source SHA-256 prefix:** `c9c06ad13acf`

## `Net:on` subscriptions

| Event |
|---|
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ezmenus.open_menu` | `player_id, board_name, color, posts` |
| `board_emitter.close_async` | `` |
| `board_emitter.selection_once` | `` |
| `handle_cancel` | `event` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`open_board`, `close_bbs`, `remove_listener`, `on`

## Engine `Async` calls

`sleep`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
