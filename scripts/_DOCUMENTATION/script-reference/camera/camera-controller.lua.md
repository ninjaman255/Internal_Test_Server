# `camera/camera-controller.lua`

> **Source reference**
>
> Generated from `camera/camera-controller.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

camera-controller.lua Unified camera controller with mode-based input handling. Subscribes to the shared per-player InputController's emitter. The camera applies its own repeat cadence to the shared InputController while it is active, and restores the controller's configured defaults on deactivate. This lets camera movement feel snappier without affecting any other consumer of the same InputController.

## Module location

- **Source:** `camera/camera-controller.lua`
- **Relative reference:** `script-reference/camera/camera-controller.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/enum/predefined-enums` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input-controller/main` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `CameraController:_apply_repeat_delays` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:_bind_input` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:_on_input_event` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:_restore_repeat_delays` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:_unbind_input` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:activate` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:deactivate` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:destroy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:fadePlayerCamera` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:getPendingPosition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:getPosition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:handle_input` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:hasPendingMove` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:moveTo` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:new` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:pan` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:relativeMoveTo` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:returnToPlayer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:setCustomHandlers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:setMode` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:setPosition` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:set_camera_repeat_delays` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `CameraController:shakePlayerCamera` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `controller._handler_owner_changed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `dbg` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `emitter_off` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `handle_player_controlled_movement` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `make_handler` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 556 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
