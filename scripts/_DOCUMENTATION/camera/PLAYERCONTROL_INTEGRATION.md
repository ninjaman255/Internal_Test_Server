# 📷 Camera controller and PlayerControl v2

[🏠 Documentation home](../index.md) · [🎮 PlayerControl API](../player-control/README.md) · [📷 Camera lease details](../player-control/CAMERA_FOCUS.md)

`camera/camera-controller.lua` now acquires `PlayerControl.begin(player_id,{profile="free_camera",camera="exclusive"})` on activation. A successful activation owns the engine capture, logical controller focus, context-specific repeat cadence, and a camera lease. Failed partial activation rolls back. `deactivate` closes only its own scope, without directly unlocking engine input or overwriting another owner's repeat policy.

Free-camera directional input remains handled through the existing `InputController` action events, now subscribed through `session:on_pressed`, `on_released`, and `on_repeat`. Mode switching retains held-input release guards. Camera ownership is checked before moving or restoring tracking.

`CameraController:slideTo(x,y,z,duration)` tracks an **estimated** pending duration; `:tick(delta_time)` advances it. No unverified engine completion callback is assumed. Immediate `:moveTo` has no timed pending state. The CameraManager wraps `slide_camera`, along with its existing move/pan/deactivate calls.

**Compatibility boundary:** Other old scripted camera systems using raw `Net` camera APIs bypass the lease check. Their input locks may now be reference-counted through LegacyCapture, but that does not automatically coordinate camera position. See [migration audit](../player-control/MIGRATION_AUDIT.md).
