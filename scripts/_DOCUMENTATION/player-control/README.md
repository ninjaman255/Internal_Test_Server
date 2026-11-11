# 🎮 PlayerControl v2 — Scoped Input and Camera Ownership

[🏠 Documentation home](../index.md) · [🧭 Control flow](CONTROL_FLOW.md) · [📷 Camera leases](CAMERA_FOCUS.md) · [🔌 Legacy migration](LEGACY_CAPTURE.md) · [🧪 Tests](TESTING.md)

> **Current source:** `scripts/player-control/main.lua`, `camera-focus.lua`, and `legacy-capture.lua` in the same directory. This guide describes the implemented v2 patch, not hypothetical engine APIs.

## Contents

1. [Core principle](#core-principle)
2. [Quick start](#quick-start)
3. [Profiles and begin options](#profiles-and-begin-options)
4. [Session methods](#session-methods)
5. [Camera ownership](#camera-ownership)
6. [Cleanup and failure recovery](#cleanup-and-failure-recovery)
7. [Integration boundaries](#integration-boundaries)

## Core principle

**`Net.lock_player_input(player_id)` suppresses the client's native character input; it does not disable scripted `virtual_input` events.** A custom menu, minigame, or camera needs engine input **capture** while it processes controller actions. Capture and logical InputController focus are different resources. A cinematic can capture without handling buttons.

PlayerControl uses `scripts/net-games/ui-suppression.lua` for reference-counted capture and optional HUD suppression, `scripts/input-controller/main.lua` for button actions, and `camera-focus.lua` for exclusive scripted camera ownership. The final release restores the underlying engine behavior. Each resource is tied to its owning session.

## Quick start

```lua
local PlayerControl = require("scripts/player-control/main")
local session, err = PlayerControl.begin(player_id, {
    owner = "feature:menu", profile = "menu",
    handoff_free_camera = true,
})
if not session then
    print("[feature] controls unavailable: " .. tostring(err))
    return
end

session:on_close(function()
    -- Remove UI resources created by this interaction.
    remove_my_ui(player_id)
end)
session:on_pressed("Confirm", function(event)
    -- Perform the selected action.
end)
session:on_pressed("Cancel", function()
    session:close()
end)
```

The UI helpers above are illustrative application code, not exported functions of PlayerControl. All calls to `PlayerControl` and session methods match the v2 implementation.

## Profiles and begin options

| Profile | Capture engine input | Logical focus | Default engine HUD suppression | Common use |
|---|---|---|---|---|
| `desktop` | Yes | Yes | No | HP Manager desktop |
| `menu` | Yes | Yes | No | Standard custom menu |
| `music_menu` | Yes | Yes | Yes | Jukebox |
| `settings_menu` | Yes | Yes | No | HP Manager settings editors |
| `native_ui` | Yes | No | No | Warp board, native dialogs |
| `cinematic` | Yes | No | No | Camera sequence |
| `capture_only` | Yes | No | No | Suppress native movement only |
| `free_camera` | Yes | Yes | No | Free camera |
| `minigame` | Yes | Yes | No | FootBomb |
| `mission_transition` | Yes | No | No | Liberation transitions |

| `PlayerControl.begin(player_id, options)` field | Purpose |
|---|---|
| `owner` | Diagnostic name; unique session identity is automatic |
| `profile` | One of the profiles above, default `menu` |
| `parent` | Live, currently topmost parent session for a nested screen |
| `focus` | Override profile's logical button focus |
| `capture` | Set `false` to skip the profile's capture lease |
| `hud` | `"hidden"` acquires HUD-suppression lease |
| `native` | Begin without scripted button delivery |
| `camera` | `"exclusive"` or `"scripted"` acquires a camera lease |
| `restore_camera` | `false` prevents tracking restoration on lease release |
| `first_repeat_delay`, `repeat_delay` | Per-context input-repeat timings |
| `handoff_free_camera` | Explicitly deactivate the existing free camera before opening a root context |

`begin` returns `session` or `nil, error`. It never forcibly steals an unrelated InputController owner. Opening a second root context while one exists fails; open a child instead.

## Session methods

| Method | Parameters | Behavior |
|---|---|---|
| `session:on_pressed` | `action, callback` | Receive button press while this session has focus |
| `session:on_repeat` | `action, callback` | Receive repeat events while focused |
| `session:on_released` | `action, callback` | Receive button releases while focused |
| `session:poll` | `actions` | Consume mapped press/repeat edges; list entries `{action, output_name, allow_repeat}` |
| `session:on_close` | `callback` | Cleanup hook, runs before resource release |
| `session:on_error` | `callback` | Invoked when one of this session's input callbacks fails |
| `session:on_suspend` | `callback` | Triggered when focus changes away |
| `session:on_resume` | `callback` | Triggered when focus becomes active |
| `session:set_repeat_delays` | `first, interval` | Adjust this session's repeat policy |
| `session:child` | `options` | Open a nested session attached to this parent |
| `session:yield_to_native_ui` | — | Suspend scripted input while native UI is active |
| `session:resume_buttons` | — | Request scripted focus again; held buttons must release first |
| `session:suspend_buttons` | — | Alias of `yield_to_native_ui` |
| `session:camera` | — | Returns a gated camera facade if the session owns a camera lease |
| `session:is_alive` | — | False after close or removal from active state |
| `session:is_current` | — | True only for current focused logical input session |
| `session:input` | — | Returns controller and manager owner token only while current |
| `session:close` | — | Idempotent close, including child scopes and owned resources |

**Do not mix `poll()` and callback delivery in the same session.** The manager selects the first delivery style and refuses registration of callbacks after polling has begun. A child session can use a different delivery style from its parent.

### Module functions

`PlayerControl.begin(player_id, options)`, `get_active(player_id)`, `get_debug_state(player_id)`, `retry_cleanup(player_id)`, and `cleanup_player(player_id)` are implemented. Player disconnect triggers cleanup automatically; queued restoration errors are retried in the registered server tick callback approximately once a second.

## Camera ownership

Only sessions opened with `camera="exclusive"` or `camera="scripted"` return a camera facade:

```lua
local sequence = PlayerControl.begin(player_id, {
    owner = "feature:cutscene", profile = "cinematic", camera = "scripted",
})
if not sequence then return end
local camera = sequence:camera()
camera:move_to(x, y, z)
camera:slide_to(x, y, z, duration)
-- A late callback must verify the sequence still owns the camera.
sequence:close()
```

`camera:follow_player()` is also available. These methods call the existing `Net.move_player_camera`, `Net.slide_player_camera`, `Net.unlock_player_camera` and `Net.track_with_player_camera` APIs, **not invented engine calls**. A stale session cannot move/restore a camera held by another lease. Child camera leases temporarily supersede a parent's camera lease. See [CAMERA_FOCUS.md](CAMERA_FOCUS.md).

## Cleanup and failure recovery

* `on_close` runs when an interaction ends and should remove any UI/cancel local work.
* An input callback failure is logged, triggers `on_error`, and closes its session; other input subscribers continue receiving events.
* Owned engine-input/HUD handles are retained in the manager's pending-recovery table if their engine-level restore fails. `retry_cleanup` retries; `get_debug_state` lists remaining failures.
* Camera activation acquires a session first, protects initialization, and rolls back on failure.
* Focus transitions, not ordinary ticks, apply held-button release guards and edge consumption. Repeat timing is tied to the active focus scope instead of restored by an old camera.
* Late asynchronous callbacks must check their own scope or generation before touching gameplay state; `on_close` doesn't automatically cancel arbitrary external promises.

## Integration boundaries

The v2 drop-in migrates direct **engine input** lock/unlock calls in ordinary gameplay through `legacy-capture.lua`, and FootBomb/free camera use PlayerControl directly. Other features still call some **engine camera APIs directly** and don't all participate in exclusive camera leases. Raw `virtual_input` subscribers also remain in several game-specific modules. Consequently, **camera exclusivity is enforceable among migrated participants, but not universally across all old callers**. See [MIGRATION_AUDIT.md](MIGRATION_AUDIT.md).

Use PlayerControl for *new* interactions; keep `legacy-capture.lua` only for callers whose imperative lock lifetime hasn't been refactored into a session yet. Avoid using `Net.lock_player_input`/`Net.unlock_player_input` or toggling engine HUD directly in gameplay code.
