-- bn_textbox_example.lua
-- Example NPC that uses the new BN text box module.
-- Place this file in your scripts/net-games/ folder and add a Tiled object
-- named "BNTextboxExample" to your map.

local Direction = require("scripts/libs/direction")
local BNTextbox = require("scripts/net-games/bn-textbox")   -- your new module

--=====================================================
-- Area / placement (must match your TMX object name)
--=====================================================
local area_id  = "default"
local obj_name = "prog_emerald"   -- create a Tiled object with this name

local bot_pos = Net.get_object_by_name(area_id, obj_name)
assert(bot_pos, "[bn_textbox_example] Missing Tiled object named '" .. obj_name .. "' in area: " .. tostring(area_id))

--=====================================================
-- Create the overworld NPC
--=====================================================
local bot_id = Net.create_bot({
    name = "BN Textbox Demo",
    area_id = area_id,
    texture_path = "/server/assets/ow/prog/prog_ow.png",   -- using the default PROG sprite
    animation_path = "/server/assets/ow/prog/prog_ow.animation",
    x = bot_pos.x,
    y = bot_pos.y,
    z = bot_pos.z or 0,
    direction = Direction.Down,
    solid = true,
})

--=====================================================
-- Interaction handler
--=====================================================
Net:on("actor_interaction", function(event)
    if event.actor_id ~= bot_id then return end
    if event.button ~= 0 then return end   -- A button only

    local player_id = event.player_id

    -- Face the player (optional but nice)
    local player_pos = Net.get_player_position(player_id)
    Net.set_bot_direction(bot_id, Direction.from_points(bot_pos, player_pos))

    -- 1) Simple text box with no nameplate, no mugshot
    BNTextbox.show(player_id, "Hello! This is a basic BN text box.")

    -- But you can also chain multiple calls; they will wait for the previous to finish.
    -- For a more complex example, we could use a timer, but here we'll just show one.
    -- Instead, we'll demonstrate another box after a short delay using AnimationEngine.
    -- However, the simplest is to just show one box at a time.
    -- So we'll show a second box after the first finishes using the on_finish callback.
    -- But that would require storing state. For demonstration, we'll show a second box
    -- with a different config by calling it again after a delay (not recommended in production).
    -- Better: We'll use the on_finish callback to chain.
    -- Let's do that.
    BNTextbox.show(player_id, "Press A to close this box.", {
        name = "Demo Prog",
        mugshot_texture = "/server/assets/ow/prog/prog_mug.png",
        frame_tint = { r = 80, g = 255, b = 80, a = 255, color_mode = 2 }, -- lime tint
        on_finish = function()
            -- After this box closes, show another one with a different style.
            BNTextbox.show(player_id, "This box has a nameplate and mugshot, but no frame tint.", {
                name = "MegaMan",
                mugshot_texture = "/server/assets/ow/prog/prog_mug.png",
                -- no frame_tint => default panel
            })
        end
    })
end)