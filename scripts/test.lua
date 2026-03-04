--[[
test_Displayer.lua – Comprehensive test script for Displayer API.
All coordinates are now in 240×160 virtual space.
Non‑blocking version using the timer system for sequencing.
Run this after a player joins, passing their player_id.
Now safely cancels all steps if the player disconnects.
]]

local Displayer = require("scripts/displayer/displayer")
local ColorPicker = require("scripts/color-picker/color-picker")   -- added for rainbow

if not Displayer:init() then
    print("Failed to initialize Displayer API")
    return false
end


-- Test runner state (single player assumed)
local Test = {
    player_id = nil,
    active = false,        -- becomes false on disconnect
    step = 0,
    glyph_id = nil,
    box_id = nil,
    text_list_id = nil,
    sprite_list_id = nil,
}

-- Ensure disconnect handler is registered only once
local disconnect_handler_registered = false

-- Schedule a function after a delay using the global timer system.
-- Captures the player_id at scheduling time and only runs the callback
-- if that player is still the active test.
local function schedule(delay, callback)
    local target_player = Test.player_id
    local timer_id = "test_timer_" .. tostring(os.clock()) .. "_" .. math.random(1000)
    Displayer.Timer.createGlobalTimer(timer_id, delay, function()
        -- Only proceed if this player is still the active test
        if target_player == Test.player_id and Test.active then
            callback()
        else
            -- Silently discard – test was cancelled
        end
    end, false)
end

-- Test steps
local steps = {
    -- Step 1: Font glyph
    function()
        print("1. Testing Font.drawGlyph and updateGlyph")
        Test.glyph_id = Displayer.Font.drawGlyph(Test.player_id, "THICK", "A", 25, 25,
            Displayer.Builder.glyph({ scale = 3, r = 255, g = 0, b = 0, ro = 0 })
        )
        schedule(1, function()
            Displayer.Font.updateGlyph(Test.player_id, Test.glyph_id,
                Displayer.Builder.glyph({ r = 0, g = 255, b = 0, ro = 45 })
            )
            schedule(1, function()
                Displayer.Font.eraseGlyph(Test.player_id, Test.glyph_id)
                print("Font test complete")
                next_step()
            end)
        end)
    end,

    -- Step 2: Static text (legacy wrapper)
    function()
        print("2. Testing Text.drawStatic (legacy)")
        Displayer.Text.drawStatic(Test.player_id, "static1", "Hello Static!", 5, 20,
            Displayer.Builder.staticText({ font = "SHIMMER", scale = 2, r = 255, g = 0, b = 0, a = 255, color_mode = 1 })
        )
        schedule(10, function()
            Displayer.Text.removeStatic(Test.player_id, "static1")
            print("Static text removed")
            next_step()
        end)
    end,

    -- Step 3: Marquee with rainbow per‑character animation (legacy wrapper)
    function()
        print("3. Testing Text.drawMarquee (legacy) with rainbow animation")

        -- Prepare rainbow colors from color-picker
        local cp = ColorPicker:new()
        local rainbow = cp.RainbowArray   -- array of {r,g,b} in order

        -- Per‑character update function: cycles through rainbow
        local function rainbowUpdate(text_index, char, elapsed)
            local speed = 2.0                 -- cycles per second
            local phase = (text_index - 1) * 0.5  -- offset per character for ripple effect
            local idx = math.floor(elapsed * speed + phase) % #rainbow + 1
            local color = rainbow[idx]
            return { r = color.r, g = color.g, b = color.b, a = 188}
        end

        Displayer.Text.drawMarquee(Test.player_id, "marquee1", "This is a scrolling marquee...", 70,
            Displayer.Builder.marquee({
                speed = 80,
                loops = 2,                     -- will disappear after two loops
                font = "SHIMMER",
                scale = 2,
                r = 255, g = 255, b = 255,         -- base color (overridden by updateChar)
                color_mode = 2,
                updateChar = rainbowUpdate      -- <-- the magic!
            })
        )
        -- Marquee will auto-remove after loops, just wait enough
        schedule(2, function()
            print("Marquee test ongoing (should disappear after loops)")
            next_step()
        end)
    end,

    -- Step 4: Text box with nameplate (legacy wrapper)
    function()
        print("4. Testing Text.createTextBox and Nameplate.attach (legacy)")
        Test.box_id = "box1"
        Displayer.Text.createTextBox(Test.player_id, Test.box_id,
            "This is a test of the text box system. It will type out character by character, and then we'll attach a nameplate above it. I'm going to add more text here so when we advance there's actually more text.",
            25, 90, 200, 50,
            Displayer.Builder.textBox({
                font = "THICK",
                scale = 2,
                speed = 20,
                type_sound = "/server/assets/net-games/sfx/text.ogg", -- optional
                r = 255,
                g = 255,
                b = 255,
            })
        )
        schedule(2, function()
            -- Attach nameplate
            Displayer.Nameplate.attach(Test.player_id, {}, Test.box_id,
                Displayer.Text.getTextBoxData(Test.player_id, Test.box_id), "Speaker")
            schedule(5, function()
                -- Advance text box
                print("Advancing text box")
                Displayer.Text.advanceTextBox(Test.player_id, Test.box_id)
                schedule(3, function()
                    -- Begin closing
                    print("Closing nameplate and text box")
                    Displayer.Nameplate.begin_close(Test.player_id, {},
                        Displayer.Text.getTextBoxData(Test.player_id, Test.box_id))
                    schedule(1, function()
                        Displayer.Text.closeTextBox(Test.player_id, Test.box_id)
                        print("Text box closed")
                        next_step()
                    end)
                end)
            end)
        end)
    end,

    -- Step 5: Unified Text API demonstration (static, marquee, typewriter)
    function()
        print("5. Testing unified Text.draw (static, marquee, typewriter)")

        -- Unified static text
        Displayer.Text.draw(Test.player_id, "unified_static", "Unified Static Text", 5, 35,
            Displayer.Builder.text("static", { font = "THIN", scale = 2, r = 0, g = 255, b = 0 })
        )

        schedule(2, function()
            -- Unified marquee text
            Displayer.Text.draw(Test.player_id, "unified_marquee", "Unified Marquee Scrolls...", 0, 20,
                Displayer.Builder.text("marquee", {
                    font = "SHIMMER",
                    scale = 2,
                    marquee = { speed = 70, loops = 1 },
                    perChar = function(idx, ch, ctx)
                        if ctx.elapsed then
                            local hue = (ctx.elapsed * 50 + idx * 10) % 255
                            return { r = hue, g = 255 - hue, b = 128 }
                        end
                    end
                })
            )
            schedule(3, function()
                -- Unified typewriter text box
                Displayer.Text.draw(Test.player_id, "unified_typewriter",
                    "This is a unified typewriter box. It should reveal characters one by one.", 25, 50,
                    Displayer.Builder.text("typewriter", {
                        width = 120, height = 30,
                        font = "THICK",
                        scale = 2,
                        typewriter = { speed = 25, sound = "/server/assets/net-games/sfx/text.ogg" },
                        perChar = function(idx, ch, ctx)
                            if ctx.isNew and ch:match("%u") then
                                return { r = 255, g = 255, b = 0 }  -- highlight capitals
                            end
                        end
                    })
                )
                schedule(5, function()
                    Displayer.Text.closeTextBox(Test.player_id, "unified_typewriter")  -- legacy wrapper works
                    print("Unified typewriter closed")
                    next_step()
                end)
            end)
        end)
    end,

    -- Step 6: Player-specific countdown display
    function()
        print("6. Testing TimerDisplay.createPlayerCountdown (10 sec countdown)")
        Displayer.TimerDisplay.createPlayerCountdown(Test.player_id, "cd_test", 60, 40,
            Displayer.Builder.timerDisplay({ font = "THICK", scale = 3, color = { r = 255, g = 200, b = 0 } })
        )
        Displayer.Timer.createPlayerCountdown(Test.player_id, "cd_test", 10, function()
            print("Player countdown finished!")
        end, false)
        schedule(11, function()
            next_step()
        end)
    end,

    -- Step 7: Global countdown display (visible to all players)
    function()
        print("7. Testing TimerDisplay.createGlobalCountdownDisplay (8 sec global countdown)")

        -- Start the actual global countdown timer (matches the display ID)
        Displayer.Timer.createGlobalCountdown("global_cd_test", 8, function()
            print("Global countdown finished!")
        end, false)
        -- Create the visual for all players (current and future)
        Displayer.TimerDisplay.createGlobalCountdown("global_cd_test", 0, 0,
            Displayer.Builder.timerDisplay({ font = "THICK", scale = 3, color = { r = 100, g = 255, b = 100 } })
        )
        schedule(9, function()
            next_step()
        end)
    end,

    -- Step 8: Scrolling Text List
    function()
        print("8. Testing ScrollingText.createList")
        Test.text_list_id = "scroll_text_1"
        Displayer.ScrollingText.createList(Test.player_id, Test.text_list_id, 0, 0, 240, 160,
            Displayer.Builder.textList({
                font = "THICK",
                scale = 1.5,
                scroll_speed = 40,
                entry_delay = 1.0,
                line_spacing = 20,
                texts = {
                    "First entry",
                    "Second entry",
                    "Third entry",
                    "Fourth entry",
                },
                backdrop = Displayer.Builder.backdrop(0, 0, 240, 160, 10, 10, 0, 0, 0, 200)
            })
        )
        schedule(8, function()
            Displayer.ScrollingText.removeList(Test.player_id, Test.text_list_id)
            print("Scrolling text list removed")
            next_step()
        end)
    end,
-- Step 9: Scrolling Sprite List
    function()
        print("9. Testing ScrollingSprite.createList")
        local sprites = {}
        Test.sprite_list_id = "scroll_sprite_1"
        local sprite_list = Displayer.ScrollingSprite.createList(Test.player_id, Test.sprite_list_id, 0, 0, 240, 160,
            Displayer.Builder.spriteList({
                scroll_speed = 100,
                entry_delay = 0.5,
                max_columns = 2,
                column_spacing = 10,
                row_spacing = 10,
                align = "center",
                sprites = {},  -- start empty
                backdrop = Displayer.Builder.backdrop(0, 0, 240, 160, 10, 10, 50, 50, 50, 150)
            })
        )

        if sprite_list then
            -- ✅ Correct call: texture_path, anim_path, anim_state, overrides
            sprite_list:addSprite(Displayer.Builder.spriteDef(
                "/server/assets/net-games/meters/order_points.png",
                "/server/assets/net-games/meters/order_points.animation",
                "7POINT"
            ))
        else
            print("Failed to create sprite list")
        end

        schedule(10, function()
            Displayer.ScrollingSprite.removeList(Test.player_id, Test.sprite_list_id)
            print("Scrolling sprite list removed")
            next_step()
        end)
    end,
}

-- Advance to next step
function next_step()
    if not Test.active then
        print("Test cancelled – player disconnected.")
        return
    end
    Test.step = Test.step + 1
    if steps[Test.step] then
        steps[Test.step]()
    else
        print("Test finished unexpectedly.")
    end
end

-- Main entry point
function test_Displayer(player_id)
    -- Register disconnect handler once
    if not disconnect_handler_registered then
        Net:on("player_disconnect", function(event)
            if event.player_id == Test.player_id then
                Test.active = false
                print("Player " .. event.player_id .. " disconnected – test cancelled.")
            end
        end)
        disconnect_handler_registered = true
    end

    Test.player_id = player_id
    Test.active = true
    Test.step = 0
    Net.toggle_player_hud(player_id)
    print("===== Starting Displayer Test for player " .. player_id .. " =====")
    next_step()
end

-- Example usage (if run in a player join event):
Net:on("player_join", function(event)
    test_Displayer(event.player_id)
end)