# `camera/camera-controller.lua`

> **Source reference**
>
> Refreshed from the current `camera/camera-controller.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

camera-controller.lua Unified camera controller with mode-based input handling. Subscribes to the shared per-player InputController's emitter. The camera applies its own repeat cadence to the shared InputController while it is active, and restores the controller's configured defaults on deactivate. This lets camera movement feel snappier without affecting any other consumer of the same InputController.

## Module location

- **Source:** `camera/camera-controller.lua`
- **Reference:** `script-reference/camera/camera-controller.lua.md`
- **Source SHA-256 prefix:** `68faf83ddac5`

## Source header notes

- camera-controller.lua
- Unified camera controller with mode-based input handling.
- Subscribes to the shared per-player InputController's emitter.
- The camera applies its own repeat cadence to the shared InputController
- while it is active, and restores the controller's configured defaults on
- deactivate. This lets camera movement feel snappier without affecting any

## Direct `require` dependencies

| Import path |
|---|
| `scripts/input-controller/main` |
| `scripts/enum/predefined-enums` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `dbg` | `...` |
| `handle_player_controlled_movement` | `self` |
| `emitter_off` | `emitter, event, cb` |
| `CameraController:new` | `player_id, opts` |
| `CameraController:_bind_input` | `` |
| `make_handler` | `kind` |
| `CameraController:_unbind_input` | `` |
| `CameraController:_apply_repeat_delays` | `` |
| `CameraController:_restore_repeat_delays` | `` |
| `CameraController:set_camera_repeat_delays` | `first_repeat_delay, repeat_delay` |
| `CameraController:_on_input_event` | `kind, ev` |
| `CameraController:handle_input` | `` |
| `CameraController:activate` | `mode, lock_player_input` |
| `CameraController:deactivate` | `keep_camera_position` |
| `CameraController:destroy` | `` |
| `CameraController:returnToPlayer` | `` |
| `CameraController:setMode` | `new_mode, custom_handlers` |
| `CameraController:setCustomHandlers` | `handlers` |
| `CameraController:moveTo` | `x, y, z` |
| `CameraController:relativeMoveTo` | `dx, dy, dz` |
| `CameraController:pan` | `dx, dy, dz` |
| `CameraController:setPosition` | `new_x, new_y, new_z` |
| `CameraController:getPosition` | `` |
| `CameraController:getPendingPosition` | `` |
| `CameraController:hasPendingMove` | `` |
| `CameraController:fadePlayerCamera` | `color, durationInSeconds` |
| `CameraController:shakePlayerCamera` | `strength, durationInSeconds` |
| `controller._handler_owner_changed` | `change` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`lock_player_input`, `unlock_player_input`, `unlock_player_camera`, `get_player_position`, `track_with_player_camera`, `move_player_camera`, `fade_player_camera`, `shake_player_camera`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `X_CAMERA_ADJUST` | `0.15` |
| `Y_CAMERA_ADJUST` | `0.15` |
| `DEFAULT_CAMERA_FIRST_REPEAT_DELAY` | `0.03` |
| `DEFAULT_CAMERA_REPEAT_DELAY` | `0.03` |
| `CAMERA_DIRECTIONS` | `{` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
