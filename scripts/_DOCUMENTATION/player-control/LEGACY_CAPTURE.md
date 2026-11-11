# 🔌 LegacyCapture — Compatibility input and HUD leases

[🏠 Home](../index.md) · [🎮 PlayerControl API](README.md) · [🛠 Migration audit](MIGRATION_AUDIT.md)

**Source:** `scripts/player-control/legacy-capture.lua`. Retains the old imperative calling pattern without invoking `Net.lock_player_input` or `Net.unlock_player_input` directly from gameplay code.

| API | Parameters | Meaning |
|---|---|---|
| `lock` | `player_id, owner_key` | Acquire one idempotent capture lease for feature/player |
| `unlock` | `player_id, owner_key` | Release the feature's capture lease only |
| `has` | `player_id, owner_key` | Whether this feature holds a capture lease |
| `hide_hud` | `player_id, owner_key` | Acquire a feature-owned engine HUD suppression lease |
| `show_hud` | `player_id, owner_key` | Release only that feature's HUD suppression |
| `cleanup_player` | `player_id` | Release outstanding compatibility handles on disconnect |
| `get_debug_state` | `player_id` | List owned capture/HUD handles |

**Implementation detail:** Leases are idempotent **per owner key**, not a true nested counter for repeat calls using the same owner key. A feature that requires nested locks must use distinct owner keys or, preferably, PlayerControl scopes. Match each lock with its own unlock. If a restore fails, this adapter keeps its handle and raises an error rather than silently forgetting the lock.

```lua
local Capture = require("scripts/player-control/legacy-capture")
Capture.lock(player_id, "feature:camera_sequence")
-- Existing sequence.
Capture.unlock(player_id, "feature:camera_sequence")
```

This adapter does not grant logical input focus, manage interactive callbacks, or enforce camera ownership. It is transitional infrastructure for legacy modules. New code should use a PlayerControl session with `profile="capture_only"`, `"menu"`, or `"cinematic"` as appropriate.
