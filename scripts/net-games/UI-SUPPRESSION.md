# UI Suppression Manager

Module: `scripts/net-games/ui-suppression.lua`

## Engine HUD vs custom UI

`acquire_engine_hud()` only controls the engine-provided HUD (health indicator upper-left and real-time indicator upper-right) through `Net.toggle_player_hud(player_id)`. It does not hide custom sprites, text, panels, or custom HUD elements.

`acquire_input_lock()` requests an engine input lock through `Net.lock_player_input(player_id)`. The matching unlock occurs only after the final manager request is released. This allows independent systems to overlap without one releasing another system's request.

**Important:** because the HUD API is a toggle, the manager assumes the engine HUD is visible on the first managed request. Participating scripts must stop calling `Net.toggle_player_hud()` directly and use this manager instead. Likewise, scripts participating in shared input-lock ownership must use the manager instead of calling `Net.lock_player_input()` / `Net.unlock_player_input()` directly. Calls that bypass the manager cannot be reflected in its request count.

## API

```lua
local UISuppression = require("scripts/net-games/ui-suppression")

local hud = UISuppression.acquire_engine_hud(player_id, "my-feature:hud")
local input = UISuppression.acquire_input_lock(player_id, "my-feature:input")
-- Later, release only this feature's requests:
UISuppression.release(hud)
UISuppression.release(input)

-- Or use a preset (menu = engine HUD hidden + engine input locked):
local menu = UISuppression.acquire_profile(player_id, "menu", "my-menu")
UISuppression.release_profile(menu)
```

Built-in profiles: `menu`, `cinematic`, `engine_hud_only`, and `input_locked`.
Use `register_profile()` to add or replace a profile. Profile entries may be `"engine_hud"`, `"input_lock"`, a registered custom handler name, or `{ handler = "name", options = {...} }`.

## Custom UI handlers

Custom UI is separate. Register a handler with `register_handler(name, { acquire = function(...), release = function(...) })`. Its acquire callback must hide/suppress the intended UI and return a restoration token; release must restore from that token. The manager cannot automatically reverse remove-only APIs unless the owning component supplies enough data to recreate the element.

Use `get_debug_state(player_id)` to inspect active engine HUD and input-lock request counts. Call `cleanup_player(player_id)` when a player fully disconnects, after feature-specific cleanup has had a chance to release its own handles.

See `ui-suppression-examples.lua` for commented usage examples.
