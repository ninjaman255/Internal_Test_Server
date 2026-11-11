# 📷 CameraFocus — Exclusive camera leases

[🏠 Home](../index.md) · [🎮 PlayerControl API](README.md)

**Source:** `scripts/player-control/camera-focus.lua`.

CameraFocus is **not** an engine camera implementation. It tracks ownership and permits only an active lease to issue or restore camera operations through `Session:camera()`.

| Function | Parameters | Purpose |
|---|---|---|
| `acquire` | `player_id, owner, {label, parent, restore_on_release}` | Create exclusive lease; current lease must be named as parent to nest |
| `is_current` | `lease` | Check whether lease is active and on top |
| `get_current` | `player_id` | Current top lease, if any |
| `release` | `lease` | Close current lease, optionally restore player tracking if root |
| `cleanup_player` | `player_id` | Drop all leases on disconnect without calling camera engine APIs |
| `get_debug_state` | `player_id` | Return active-lease summaries |

Use `PlayerControl.begin(...,{camera="exclusive"})` instead of calling `CameraFocus.acquire` directly for new gameplay features. That keeps camera, engine capture, callbacks, and HUD under one interaction lifecycle.

`Session:camera()` supports `move_to(x,y,z)`, `slide_to(x,y,z,duration)`, and `follow_player()`. They validate current ownership before calling the server's existing `Net` APIs. Calls return the protected call's success result and possible error. The final camera lease may restore player tracking; `restore_camera=false` explicitly leaves the view unchanged.

**Limitations:** Existing old camera code in Liberation, Endless Runner, and other game modules still directly invokes camera APIs. Such code bypasses lease authorization until migrated. Failure to restore tracking (for instance an injected failing `Net.track_with_player_camera`) leaves a lease pending for recovery. A slide's local `pending_seconds` is an estimate, not proof the engine rendered a final frame.
