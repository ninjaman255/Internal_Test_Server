# 🧭 PlayerControl v2 — Lifecycle and handoffs

[🏠 Home](../index.md) · [🎮 API guide](README.md) · [📷 Camera focus](CAMERA_FOCUS.md)

## Control resources

| Resource | Owner | Restoration |
|---|---|---|
| Native input capture | Ref-counted `ui-suppression` lease | Final successful release restores engine world controls |
| Logical button focus | One `InputController` claim held by PlayerControl | Current child gets focus; parent resumes after child closes |
| Input repeat timing | Current focused PlayerControl context | Previous default policy restored on final claim release |
| Camera control | Exclusive `camera-focus` lease | Current owner can move/restore; a child may supersede its parent |
| Engine HUD | Ref-counted `ui-suppression` lease | Visible after final successful suppression release |

## Root desktop → child screen → desktop

1. `PlayerControl.begin(player_id,{profile="desktop",owner="hp_manager"})` captures engine input and focuses desktop actions.
2. `desktop:child({profile="music_menu",owner="jukebox"})` keeps the parent alive but routes scripted actions to Jukebox. Its HUD lease is independent.
3. Child closes; UI cleanup runs, its HUD/capture lease releases, and the desktop receives fresh-input guards on resumption.
4. Root closes; if no other managed capture remains, native player movement resumes.

An old Confirm press cannot automatically select the first option in a newly focused child. Focus change guards require input release. Native board dialogs should use the `native_ui` profile or `yield_to_native_ui`, not intercept board events with a raw InputController button handler.

## Dedicated free camera → another system

The free camera now uses `PlayerControl.begin` with `profile="free_camera"`, `camera="exclusive"`, and its own repeat timing. Another root control context can explicitly request `handoff_free_camera=true`; PlayerControl tells the camera manager to deactivate first. No periodic forced input-claim loop is used.

If the camera activation fails between input acquisition and initialization, the session is closed transactionally. Repeat policy and engine capture are no longer restored by ad hoc camera code.

## Cinematic-only capture

A scene can use `profile="cinematic",camera="scripted"`. Scripted buttons stay suspended while the engine still sends `virtual_input`; native walking is disabled until the final capture releases. Native dialogue textbox response should be awaited separately; the session does not consume textbox replies.

## Error cases

* No session may release another session's engine-input or HUD handle.
* If an engine restore fails, the handle stays pending and `PlayerControl.retry_cleanup(player_id)` may retry it.
* If a child callback raises, the session fires `on_error`, closes, and executes `on_close` cleanup.
* Do not assume a timed `Net.slide_player_camera` has a completion event; the controller's pending timer is a local estimate.
* A camera callback must check that its camera lease is current before movement. Direct legacy camera calls remain outside this protection.

See [TESTING.md](TESTING.md) for regression scenarios and [CAPTURE_SCOPES.md](CAPTURE_SCOPES.md) for named capture callers.

## Native dialog handoff (new)

1. Active scripted menu calls `session:begin_native_handoff({swallow_seconds=0.35})`.
2. Its PlayerControl session stays alive and keeps engine capture, but scripted button callbacks are suspended.
3. After the client closes the native dialog, the owner invokes `handoff:resume()`.
4. Focus is restored only if the session is still valid, old button edges are discarded, and held actions must release.
5. Disposed/duplicate handoffs are ignored rather than reopening an expired UI.

For gameplay operations that do not need button focus, use named captures described in [CAPTURE_SCOPES.md](CAPTURE_SCOPES.md).
