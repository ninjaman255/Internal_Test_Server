# `camera/main.lua`

> **Source reference**
>
> Refreshed from the current `camera/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

main.lua (Entry Point)

## Module location

- **Source:** `camera/main.lua`
- **Reference:** `script-reference/camera/main.lua.md`
- **Source SHA-256 prefix:** `59db11d71c0d`

## Source header notes

- main.lua (Entry Point)

## Direct `require` dependencies

| Import path |
|---|
| `scripts/camera/camera-manager` |
| `scripts/camera/camera-controller` |
| `scripts/enum/predefined-enums` |
| `scripts/input-controller/main` |

## `Net:on` subscriptions

| Event |
|---|
| `player_join` |
| `tile_interaction` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `dbg` | `...` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`, `get_player_area`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DBG` | `false` |
| `CAMERA_FIRST_REPEAT_DELAY` | `0.05` |
| `CAMERA_REPEAT_DELAY` | `0.03` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
