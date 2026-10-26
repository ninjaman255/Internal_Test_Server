# `ezlibs-custom/nebulous-liberations/liberations/camera_sequence.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/camera_sequence.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

camera_sequence.lua

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/camera_sequence.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/camera_sequence.lua.md`
- **Source SHA-256 prefix:** `48bd3aa92863`

## Source header notes

- camera_sequence.lua

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `CameraSequence.play` | `instance, player, start_point` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`move_player_camera`, `slide_player_camera`, `unlock_player_camera`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
