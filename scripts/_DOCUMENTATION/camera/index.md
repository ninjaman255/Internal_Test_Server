# 📁 camera

[🏠 Documentation home](../index.md) · [⬆ Parent folder](../index.md)
> **Current PlayerControl references:** [Current camera capture integration](PLAYERCONTROL_INTEGRATION.md)


## 🗂️ Contents
- [📖 Guides & reference material](#guides--reference-material)

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `camera-controller.lua` | 1 | 28 | 9 | 556 | [Open script reference](camera-controller/index.md) |
| 📄 Script | `camera-manager.lua` | 1 | 12 | 2 | 154 | [Open script reference](camera-manager/index.md) |
| 📄 Script | `main.lua` | 1 | 3 | 0 | 105 | [Open script reference](main/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `camera-controller.lua` | `CameraController:new(player_id, opts)` | 119 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `controller._handler_owner_changed(change)` | 169 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:_bind_input()` | 190 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:_unbind_input()` | 217 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:_apply_repeat_delays()` | 234 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:_restore_repeat_delays()` | 244 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:set_camera_repeat_delays(first_repeat_delay, repeat_delay)` | 255 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:_on_input_event(kind, ev)` | 272 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:handle_input()` | 334 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:activate(mode, lock_player_input)` | 356 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:deactivate(keep_camera_position)` | 426 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:destroy()` | 462 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:returnToPlayer()` | 472 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:setMode(new_mode, custom_handlers)` | 485 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:setCustomHandlers(handlers)` | 500 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:moveTo(x, y, z)` | 507 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:relativeMoveTo(dx, dy, dz)` | 518 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:pan(dx, dy, dz)` | 525 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:setPosition(new_x, new_y, new_z)` | 527 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:getPosition()` | 534 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:getPendingPosition()` | 538 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:hasPendingMove()` | 545 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:fadePlayerCamera(color, durationInSeconds)` | 547 | [Details](camera-controller/index.md) |
| `camera-controller.lua` | `CameraController:shakePlayerCamera(strength, durationInSeconds)` | 552 | [Details](camera-controller/index.md) |
| `camera-manager.lua` | `CameraManager:init(handle_on_join, tile_interaction, setup_inputs)` | 18 | [Details](camera-manager/index.md) |
| `camera-manager.lua` | `CameraManager:setup_event_listeners(handle_on_join, tile_interaction, setup_inputs)` | 22 | [Details](camera-manager/index.md) |
| `camera-manager.lua` | `CameraManager:get_controller(player_id)` | 28 | [Details](camera-manager/index.md) |
| `camera-manager.lua` | `CameraManager:activate_camera(player_id, mode, lock_input)` | 36 | [Details](camera-manager/index.md) |
| `camera-manager.lua` | `CameraManager:deactivate_camera(player_id, keep_camera_position)` | 67 | [Details](camera-manager/index.md) |
| `camera-manager.lua` | `CameraManager:is_camera_active(player_id)` | 82 | [Details](camera-manager/index.md) |
| `camera-manager.lua` | `CameraManager:has_pending_move(player_id)` | 91 | [Details](camera-manager/index.md) |
| `camera-manager.lua` | `CameraManager:move_camera(player_id, x, y, z)` | 100 | [Details](camera-manager/index.md) |
| `camera-manager.lua` | `CameraManager:pan_camera(player_id, dx, dy, dz)` | 114 | [Details](camera-manager/index.md) |
| `camera-manager.lua` | `CameraManager:get_camera_position(player_id)` | 128 | [Details](camera-manager/index.md) |
| `camera-manager.lua` | `CameraManager:get_pending_camera_position(player_id)` | 141 | [Details](camera-manager/index.md) |

## 📊 Collection summary

This folder subtree contains **3 Lua source files**, **43 named/assigned function detections**, and **11 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `README.md`](README.md) | Camera Controller |
