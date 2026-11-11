# 📄 `camera-controller.lua` — Current source reference

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/camera/camera-controller.lua`](../../../../../control_impl/src/scripts/camera/camera-controller.lua)  
> **Source lines:** 564  
> **SHA-256:** `2a080555b8b3c030331a045e8cb7a6cf24ab9cfed9952a3a23006b9668907968`  
> **Declared/assigned functions:** 28 · **table initializers (simple patterns):** 7 · **event subscriptions detected:** 0

> **Method:** Static source inventory. Parameters are spelled as in the source; no types, return values, or public accessibility are inferred from signatures alone. See the authored guides for behavioral descriptions.

## 🧭 Contents

- [Overview](#overview)
- [Dependencies](#dependencies)
- [Events](#events)
- [Functions and parameters](#functions-and-parameters)
- [Tables](#tables)
- [Net APIs](#net-apis)

## Overview

Current reference for `camera/camera-controller.lua` in the PlayerControl-patched November 11 snapshot.

## Dependencies

| Line | Required module |
|---:|---|
| 1 | `scripts/net-games/ui-suppression` |
| 11 | `scripts/input-controller/main` |
| 12 | `scripts/enum/predefined-enums` |

## Events

No literal named event registrations detected.

## Functions and parameters

| Line | Declared/assigned function | Parameters (source) | Local |
|---:|---|---|---|
| 33 | `dbg` | `...` | yes |
| 42 | `handle_player_controlled_movement` | `self` | yes |
| 105 | `emitter_off` | `emitter, event, cb` | yes |
| 120 | `CameraController:new` | `player_id, opts` | no |
| 170 | `controller._handler_owner_changed` | `change` | no |
| 191 | `CameraController:_bind_input` | `(none)` | no |
| 200 | `make_handler` | `kind` | yes |
| 218 | `CameraController:_unbind_input` | `(none)` | no |
| 235 | `CameraController:_apply_repeat_delays` | `(none)` | no |
| 245 | `CameraController:_restore_repeat_delays` | `(none)` | no |
| 256 | `CameraController:set_camera_repeat_delays` | `first_repeat_delay, repeat_delay` | no |
| 273 | `CameraController:_on_input_event` | `kind, ev` | no |
| 335 | `CameraController:handle_input` | `(none)` | no |
| 357 | `CameraController:activate` | `mode, lock_player_input` | no |
| 436 | `CameraController:deactivate` | `keep_camera_position` | no |
| 474 | `CameraController:destroy` | `(none)` | no |
| 484 | `CameraController:returnToPlayer` | `(none)` | no |
| 497 | `CameraController:setMode` | `new_mode, custom_handlers` | no |
| 512 | `CameraController:setCustomHandlers` | `handlers` | no |
| 519 | `CameraController:moveTo` | `x, y, z` | no |
| 530 | `CameraController:relativeMoveTo` | `dx, dy, dz` | no |
| 537 | `CameraController:pan` | `dx, dy, dz` | no |
| 539 | `CameraController:setPosition` | `new_x, new_y, new_z` | no |
| 546 | `CameraController:getPosition` | `(none)` | no |
| 550 | `CameraController:getPendingPosition` | `(none)` | no |
| 557 | `CameraController:hasPendingMove` | `(none)` | no |
| 559 | `CameraController:fadePlayerCamera` | `color, durationInSeconds` | no |
| 564 | `CameraController:shakePlayerCamera` | `strength, durationInSeconds` | no |

### Parameter details

#### 1. `dbg(...)`

- **Declared at:** source line 33.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `...` | Exact source parameter; type not asserted. |

#### 2. `handle_player_controlled_movement(self)`

- **Declared at:** source line 42.
- **Scope syntax:** local.
- **Nearby source comment:** Default direction-driven movement.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `self` | Exact source parameter; type not asserted. |

#### 3. `emitter_off(emitter, event, cb)`

- **Declared at:** source line 105.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `emitter` | Exact source parameter; type not asserted. |
| 2 | `event` | Exact source parameter; type not asserted. |
| 3 | `cb` | Exact source parameter; type not asserted. |

#### 4. `CameraController:new(player_id, opts)`

- **Declared at:** source line 120.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Constructor

| # | Parameter | Notes |
|---:|---|---|
| 1 | `player_id` | Exact source parameter; type not asserted. |
| 2 | `opts` | Exact source parameter; type not asserted. |

#### 5. `controller._handler_owner_changed(change)`

- **Declared at:** source line 170.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Observe exclusive input ownership. A minigame can take control of the player's shared controller; the camera then stops processing input but leaves the camera position alone for the new owner to manage.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `change` | Exact source parameter; type not asserted. |

#### 6. `CameraController:_bind_input()`

- **Declared at:** source line 191.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Input binding
- **Parameters:** none explicitly declared.

#### 7. `make_handler(kind)`

- **Declared at:** source line 200.
- **Scope syntax:** local.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `kind` | Exact source parameter; type not asserted. |

#### 8. `CameraController:_unbind_input()`

- **Declared at:** source line 218.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 9. `CameraController:_apply_repeat_delays()`

- **Declared at:** source line 235.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Repeat cadence override
- **Parameters:** none explicitly declared.

#### 10. `CameraController:_restore_repeat_delays()`

- **Declared at:** source line 245.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 11. `CameraController:set_camera_repeat_delays(first_repeat_delay, repeat_delay)`

- **Declared at:** source line 256.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Optional API: change the camera's cadence at runtime. If the camera is currently active, the change takes effect immediately.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `first_repeat_delay` | Exact source parameter; type not asserted. |
| 2 | `repeat_delay` | Exact source parameter; type not asserted. |

#### 12. `CameraController:_on_input_event(kind, ev)`

- **Declared at:** source line 273.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Input event handling

| # | Parameter | Notes |
|---:|---|---|
| 1 | `kind` | Exact source parameter; type not asserted. |
| 2 | `ev` | Exact source parameter; type not asserted. |

#### 13. `CameraController:handle_input()`

- **Declared at:** source line 335.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Legacy entry point.
- **Parameters:** none explicitly declared.

#### 14. `CameraController:activate(mode, lock_player_input)`

- **Declared at:** source line 357.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Activation / Deactivation

| # | Parameter | Notes |
|---:|---|---|
| 1 | `mode` | Exact source parameter; type not asserted. |
| 2 | `lock_player_input` | Exact source parameter; type not asserted. |

#### 15. `CameraController:deactivate(keep_camera_position)`

- **Declared at:** source line 436.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `keep_camera_position` | Exact source parameter; type not asserted. |

#### 16. `CameraController:destroy()`

- **Declared at:** source line 474.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 17. `CameraController:returnToPlayer()`

- **Declared at:** source line 484.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 18. `CameraController:setMode(new_mode, custom_handlers)`

- **Declared at:** source line 497.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Mode switching

| # | Parameter | Notes |
|---:|---|---|
| 1 | `new_mode` | Exact source parameter; type not asserted. |
| 2 | `custom_handlers` | Exact source parameter; type not asserted. |

#### 19. `CameraController:setCustomHandlers(handlers)`

- **Declared at:** source line 512.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `handlers` | Exact source parameter; type not asserted. |

#### 20. `CameraController:moveTo(x, y, z)`

- **Declared at:** source line 519.
- **Scope syntax:** table/global declaration.
- **Nearby source comment:** Camera movement API (unchanged)

| # | Parameter | Notes |
|---:|---|---|
| 1 | `x` | Exact source parameter; type not asserted. |
| 2 | `y` | Exact source parameter; type not asserted. |
| 3 | `z` | Exact source parameter; type not asserted. |

#### 21. `CameraController:relativeMoveTo(dx, dy, dz)`

- **Declared at:** source line 530.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `dx` | Exact source parameter; type not asserted. |
| 2 | `dy` | Exact source parameter; type not asserted. |
| 3 | `dz` | Exact source parameter; type not asserted. |

#### 22. `CameraController:pan(dx, dy, dz)`

- **Declared at:** source line 537.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `dx` | Exact source parameter; type not asserted. |
| 2 | `dy` | Exact source parameter; type not asserted. |
| 3 | `dz` | Exact source parameter; type not asserted. |

#### 23. `CameraController:setPosition(new_x, new_y, new_z)`

- **Declared at:** source line 539.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `new_x` | Exact source parameter; type not asserted. |
| 2 | `new_y` | Exact source parameter; type not asserted. |
| 3 | `new_z` | Exact source parameter; type not asserted. |

#### 24. `CameraController:getPosition()`

- **Declared at:** source line 546.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 25. `CameraController:getPendingPosition()`

- **Declared at:** source line 550.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 26. `CameraController:hasPendingMove()`

- **Declared at:** source line 557.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.
- **Parameters:** none explicitly declared.

#### 27. `CameraController:fadePlayerCamera(color, durationInSeconds)`

- **Declared at:** source line 559.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `color` | Exact source parameter; type not asserted. |
| 2 | `durationInSeconds` | Exact source parameter; type not asserted. |

#### 28. `CameraController:shakePlayerCamera(strength, durationInSeconds)`

- **Declared at:** source line 564.
- **Scope syntax:** table/global declaration.
- **Source comment:** No adjacent explanation; refer to the implementation.

| # | Parameter | Notes |
|---:|---|---|
| 1 | `strength` | Exact source parameter; type not asserted. |
| 2 | `durationInSeconds` | Exact source parameter; type not asserted. |


## Tables

| Line | Table variable |
|---:|---|
| 15 | `CameraController` |
| 28 | `CAMERA_DIRECTIONS` |
| 144 | `controller` |
| 152 | `current_position` |
| 154 | `camera_color` |
| 420 | `self.current_position` |
| 520 | `self.pending_position` |

## Net APIs

| Called API | Occurrences | First source line |
|---|---:|---:|
| `Net.fade_player_camera` | 1 | 561 |
| `Net.get_player_position` | 2 | 419 |
| `Net.move_player_camera` | 1 | 525 |
| `Net.shake_player_camera` | 1 | 565 |
| `Net.track_with_player_camera` | 2 | 453 |
| `Net.unlock_player_camera` | 3 | 405 |
