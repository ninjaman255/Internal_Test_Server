> **2026-11-11 — Current PlayerControl integration:** Free camera now uses an owned UISuppression engine-input capture lease and cleanup on transfer/disconnect. The older sections below may describe direct lock/unlock behavior from before this change. See [current camera integration](PLAYERCONTROL_INTEGRATION.md) and the [patched source reference](camera-controller/index.md).

# Camera Controller

> 📡 **Current-source update · 2026-11-11:** This authored guide is retained from the uploaded `internal_test_server(2).zip`. Its existing narrative/examples have **not** been exhaustively rewritten. For refreshed function signatures, parameters, dependencies, table initializers, and source line numbers, see the [regenerated module index](index.md) and [current systems guide](../CURRENT_SYSTEMS.md). If older instructions here conflict with the current Lua implementation, follow the linked source references.


The camera system in `scripts/camera/` provides per-player camera controllers, direction-driven camera movement, and a manager for activation and camera positioning. It uses the shared Input Controller API; it does not create an independent raw-input event handler.

## Files

| File | Responsibility |
|---|---|
| `main.lua` | Entry point. Creates one camera controller per player join and routes left-button tile interactions to camera activation. |
| `camera-manager.lua` | Stores per-player controllers and exposes activation, deactivation, move, pan, and position-query helpers. |
| `camera-controller.lua` | Owns camera state, input ownership, direction-driven movement, repeat cadence, and activation/deactivation cleanup. |

## Input integration

The camera controller gets its input from the canonical API path:

```lua
local InputAPI = require("scripts/input-controller/main")
```

On activation, it attempts to claim the shared controller. Activation fails if another system owns input. On success, it binds to the controller's input events, requires a fresh release for camera directions, applies camera-specific repeat timing, and locks player input by default. `activate(mode, lock_player_input)` can explicitly choose whether the engine input lock should be enabled.

On deactivation, the camera releases only its own controller lease, restores the previous repeat cadence, and normally calls `Net.unlock_player_input`. Controllers configured with `keep_player_input_locked = true` retain the engine input lock. These are separate lifecycles: releasing controller ownership does not itself unlock engine input.

## FootBomb interaction

FootBomb moves the real player actor off-map and uses `Net.move_player_camera` to keep the camera focused on the assigned match bot. It does not activate the free-camera controller. The `tile_interaction` handler in `main.lua` explicitly ignores interactions in area IDs matching `^footbomb[_%-]`, preventing the free camera from activating inside a FootBomb instance even if input ownership has not yet changed. The camera controller also refuses to claim the shared input controller when FootBomb already owns it.

## Public manager methods

The module returned by `require("scripts/camera/main")` is the `CameraManager`. The implementation exposes these methods:

- `get_controller(player_id)`
- `activate_camera(player_id, mode, lock_input)`
- `deactivate_camera(player_id, keep_camera_position)`
- `is_camera_active(player_id)`
- `has_pending_move(player_id)`
- `move_camera(player_id, x, y, z)`
- `pan_camera(player_id, dx, dy, dz)`
- `get_camera_position(player_id)`
- `get_pending_camera_position(player_id)`

The mode values come from `scripts/enum/predefined-enums` (`CameraMode`). Check that module for the supported enum values rather than duplicating mode strings.

## Debugging notes

- If activation returns `false`, check whether another subsystem owns the shared input controller.
- If directional camera movement stops, check that the camera is active, owns the input lease, and is receiving `virtual_input` through the shared Input Controller.
- When adding a minigame that locks input, make sure every exit and disconnect path unlocks it.
- Keep FootBomb's area guard in place unless the camera/input handoff design changes and is retested.
