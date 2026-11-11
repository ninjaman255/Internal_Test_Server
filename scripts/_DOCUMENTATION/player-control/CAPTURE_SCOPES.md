# 🎮 PlayerControl — Named capture scopes

[🏠 Documentation home](../index.md) · [📖 PlayerControl API](README.md) · [🧭 Migration report](MIGRATION_AUDIT.md)

## Why named resources exist

`PlayerControl.begin(...)` owns a **focused interaction** (menu, desktop, camera or minigame). A cutscene, warp or native dialogue may only need to suppress engine movement while another menu already owns the controller. Those operations should not call `InputController:claim_input` or create competing root sessions.

The canonical module `scripts/player-control/main.lua` therefore also owns **named input/HUD capture resources**. The previous standalone capture adapter has been removed. All first-party Lua callers in this snapshot import PlayerControl directly.

## Engine capture without button focus

```lua
local PlayerControl = require("scripts/player-control/main")

PlayerControl.acquire_capture(player_id, "eznpcs:dialogue")
-- Run the existing interaction; virtual_input remains available to its owner.
PlayerControl.release_capture(player_id, "eznpcs:dialogue")
```

`acquire_capture(player_id, owner)` is **idempotent** for each `(player_id, owner)` key. Repeating the same call does not increment a nested count; use different owner names for truly independent overlapping operations. `release_capture` is idempotent for a missing key and returns `false, error` when engine restoration is deferred for retry. `has_capture` reports active ownership.

The equivalent HUD operations are `suppress_hud(player_id, owner)` and `restore_hud(player_id, owner)`. Every resource uses the same reference-counted `scripts/player-control/resources/ui-suppression.lua` implementation as focused sessions.

For an operation that benefits from one local disposable object:

```lua
local scope, err = PlayerControl.begin_capture_scope(player_id, "my-cutscene", {hud=true})
if not scope then return false, err end
-- Work owned by this scope.
scope:close()
```

**Important:** `scope:close()` closes the shared owner key; do not create two scopes with the same key for simultaneously active independent tasks.

## Interaction sessions and native UI

* For menus: `local session = PlayerControl.begin(player_id,{owner="my-menu",profile="menu"})`, then `session:poll(actions)` or `session:on_pressed(...)`.
* For nested menus: `parent:child({owner="child-menu",profile="menu"})`.
* For held-button return protection: `session:guard_input(seconds, actions)`.
* For a native dialog: `local handoff=session:begin_native_handoff({swallow_seconds=0.35})` and call `handoff:resume()` **after** the native response has been dismissed. `resume()` may be called only once and refuses a disposed session.
* `PlayerControl.cleanup_player(player_id)` closes all sessions and named resources on disconnect. Failed engine restores are retried through `retry_cleanup`.

## Compatibility boundaries

There is **no** `scripts/player-control/main.lua` module in this release. The old `scripts/net-games/ui-suppression.lua` path is retained only as a require-forwarder for external code. Current first-party imports point at `scripts/player-control/resources/ui-suppression.lua`.

Direct camera movement in older scripted cinematics remains an intentional separate migration boundary: named **engine input capture is not a camera lease**. Do not claim that it prevents a raw `Net.move_player_camera` from overwriting a view. See [camera integration](../camera/PLAYERCONTROL_INTEGRATION.md).
