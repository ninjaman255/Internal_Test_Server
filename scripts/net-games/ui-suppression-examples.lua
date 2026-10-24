-- Usage examples for scripts/net-games/ui-suppression.lua.
-- This file is documentation only; it is not required by the framework.
local UISuppression = require("scripts/net-games/ui-suppression")

-- Example 1: hide ONLY the engine-provided HUD (health upper-left and real-time upper-right).
-- This does not hide custom sprites, text, panels, or our custom HUD.
local engine_hud_handle = UISuppression.acquire_engine_hud(player_id, "example:engine-hud")
-- ... display your custom UI ...
-- UISuppression.release(engine_hud_handle)

-- Example 2: acquire a lock request. If another feature also has a request,
-- releasing this one will NOT unlock the player until the final request is released.
local input_handle = UISuppression.acquire_input_lock(player_id, "example:input-lock")
-- ... run a menu / transition ...
-- UISuppression.release(input_handle)

-- Example 3: request both engine HUD suppression and input lock with a preset.
local menu_handle = UISuppression.acquire_profile(player_id, "menu", "example:menu")
-- ... menu lifecycle ...
-- UISuppression.release_profile(menu_handle)

-- Example 4: register a custom UI suppression handler. The owner component must
-- preserve enough state to restore the UI; remove-only APIs are not automatically reversible.
UISuppression.register_handler("my_custom_panel", {
  acquire = function(pid, owner, options)
    -- Hide the panel owned by this system and return a restoration token.
    -- Replace with your actual component API.
    return { owner = owner, options = options }
  end,
  release = function(pid, token)
    -- Restore the panel using the saved token.
  end,
})

-- Then add { handler = "my_custom_panel", options = { ... } } to a profile,
-- or call acquire_element(player_id, "my_custom_panel", owner, options).
