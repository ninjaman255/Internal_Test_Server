# `camera/camera-manager.lua`

> **Source reference**
>
> Refreshed from the current `camera/camera-manager.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

CameraManager.lua

## Module location

- **Source:** `camera/camera-manager.lua`
- **Reference:** `script-reference/camera/camera-manager.lua.md`
- **Source SHA-256 prefix:** `6bdd2b97bb80`

## Source header notes

- CameraManager.lua

## Direct `require` dependencies

| Import path |
|---|
| `scripts/camera/camera-controller` |
| `scripts/enum/predefined-enums` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `dbg` | `...` |
| `CameraManager:init` | `handle_on_join, tile_interaction, setup_inputs` |
| `CameraManager:setup_event_listeners` | `handle_on_join, tile_interaction, setup_inputs` |
| `CameraManager:get_controller` | `player_id` |
| `CameraManager:activate_camera` | `player_id, mode, lock_input` |
| `CameraManager:deactivate_camera` | `player_id, keep_camera_position` |
| `CameraManager:is_camera_active` | `player_id` |
| `CameraManager:has_pending_move` | `player_id` |
| `CameraManager:move_camera` | `player_id, x, y, z` |
| `CameraManager:pan_camera` | `player_id, dx, dy, dz` |
| `CameraManager:get_camera_position` | `player_id` |
| `CameraManager:get_pending_camera_position` | `player_id` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
