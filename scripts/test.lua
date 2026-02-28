--[[
test_displayer.lua – Comprehensive test script for displayer API.
Non‑blocking version using the timer system for sequencing.
Run this after a player joins, passing their player_id.
]]

local displayer = require("scripts/displayer/displayer")
local ColorPicker = require("scripts/color-picker/color-picker")   -- added for rainbow

displayer:init()

-- Test runner state
local Test = {
    player_id = nil,
    step = 0,
    glyph_id = nil,
    box_id = nil,
    text_list_id = nil,
    sprite_list_id = nil,
}

-- Schedule a function after a delay using the global timer system
local function schedule(delay, callback)
    local timer_id = "test_timer_" .. tostring(os.clock()) .. "_" .. math.random(1000)
    displayer.Timer.createGlobalTimer(timer_id, delay, function()
        callback()
        -- Timer auto-removes (non-looping)
    end, false)
end

-- Test steps
local steps = {
    -- Step 1: Font glyph
    function()
        print("1. Testing Font.drawGlyph and updateGlyph")
        Test.glyph_id = displayer.Font.drawGlyph(Test.player_id, "THICK", "A", 50, 50,
            displayer.Builder.glyph({ scale = 3, r = 255, g = 0, b = 0, ro = 0 })
        )
        schedule(1, function()
            displayer.Font.updateGlyph(Test.player_id, Test.glyph_id,
                displayer.Builder.glyph({ r = 0, g = 255, b = 0, ro = 45 })
            )
            schedule(1, function()
                displayer.Font.eraseGlyph(Test.player_id, Test.glyph_id)
                print("Font test complete")
                next_step()
            end)
        end)
    end,

    -- Step 2: Static text
    function()
        print("2. Testing Text.drawStatic")
        displayer.Text.drawStatic(Test.player_id, "static1", "Hello Static!", 120, 80,
            displayer.Builder.staticText({ font = "THICK", scale = 2, r = 255, g = 255, b = 255 })
        )
        schedule(2, function()
            displayer.Text.removeStatic(Test.player_id, "static1")
            print("Static text removed")
            next_step()
        end)
    end,

    -- Step 3: Marquee with rainbow per‑character animation
    function()
        print("3. Testing Text.drawMarquee with rainbow animation")

        -- Prepare rainbow colors from color-picker
        local cp = ColorPicker:new()
        local rainbow = cp.RainbowArray   -- array of {r,g,b} in order

        -- Per‑character update function: cycles through rainbow
        local function rainbowUpdate(text_index, char, elapsed)
            local speed = 2.0                 -- cycles per second
            local phase = (text_index - 1) * 0.5  -- offset per character for ripple effect
            local idx = math.floor(elapsed * speed + phase) % #rainbow + 1
            local color = rainbow[idx]
            return { r = color.r, g = color.g, b = color.b }
        end

        displayer.Text.drawMarquee(Test.player_id, "marquee1", "This is a scrolling marquee...", 150,
            displayer.Builder.marquee({
                speed = 80,
                loops = 2,                     -- will disappear after two loops
                font = "THICK",
                scale = 2,
                r = 255, g = 255, b = 255,         -- base color (overridden by updateChar)
                color_mode = 2,
                a = 255,
                updateChar = rainbowUpdate      -- <-- the magic!
            })
        )
        -- Marquee will auto-remove after loops, just wait enough
        schedule(5, function()
            print("Marquee test ongoing (should disappear after loops)")
            next_step()
        end)
    end,

    -- Step 4: Text box with nameplate
    function()
        print("4. Testing Text.createTextBox and Nameplate.attach")
        Test.box_id = "box1"
        displayer.Text.createTextBox(Test.player_id, Test.box_id,
            "This is a test of the text box system. It will type out character by character, and then we'll attach a nameplate above it.",
            50, 180, 400, 100,
            displayer.Builder.textBox({
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
            displayer.Nameplate.attach(Test.player_id, {}, Test.box_id,
                displayer.Text.getTextBoxData(Test.player_id, Test.box_id), "Speaker")
            schedule(5, function()
                -- Advance text box
                print("Advancing text box")
                displayer.Text.advanceTextBox(Test.player_id, Test.box_id)
                schedule(3, function()
                    -- Begin closing
                    print("Closing nameplate and text box")
                    displayer.Nameplate.begin_close(Test.player_id, {},
                        displayer.Text.getTextBoxData(Test.player_id, Test.box_id))
                    schedule(1, function()
                        displayer.Text.closeTextBox(Test.player_id, Test.box_id)
                        print("Text box closed")
                        next_step()
                    end)
                end)
            end)
        end)
    end,

    -- Step 5: Player-specific countdown display
    function()
        print("5. Testing TimerDisplay.createPlayerCountdown (10 sec countdown)")
        displayer.TimerDisplay.createPlayerCountdown(Test.player_id, "cd_test", 200, 150,
            displayer.Builder.timerDisplay({ font = "THICK", scale = 3, color = { r = 255, g = 200, b = 0 } })
        )
        displayer.Timer.createPlayerCountdown(Test.player_id, "cd_test", 10, function()
            print("Player countdown finished!")
        end, false)
        schedule(11, function()
            next_step()
        end)
    end,

    -- Step 6: Global countdown display (visible to all players)
    function()
        print("6. Testing TimerDisplay.createGlobalCountdownDisplay (8 sec global countdown)")

        -- Start the actual global countdown timer (matches the display ID)
        displayer.Timer.createGlobalCountdown("global_cd_test", 8, function()
            print("Global countdown finished!")
        end, false)
        -- Create the visual for all players (current and future)
        displayer.TimerDisplay.createGlobalCountdown("global_cd_test", 0, 0,
            displayer.Builder.timerDisplay({ font = "THICK", scale = 3, color = { r = 100, g = 255, b = 100 } })
        )
        schedule(9, function()
            next_step()
        end)
    end,

    -- Step 7: Scrolling Text List
    function()
        print("7. Testing ScrollingText.createList")
        Test.text_list_id = "scroll_text_1"
        displayer.ScrollingText.createList(Test.player_id, Test.text_list_id, 0, 0, 240, 160,
            displayer.Builder.textList({
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
                backdrop = displayer.Builder.backdrop(0, 0, 240, 160, 10, 10, 0, 0, 0, 200)
            })
        )
        schedule(8, function()
            displayer.ScrollingText.removeList(Test.player_id, Test.text_list_id)
            print("Scrolling text list removed")
            next_step()
        end)
    end,

    -- Step 8: Scrolling Sprite List
    function()
        print("8. Testing ScrollingSprite.createList")
        local sprites = {
            displayer.Builder.spriteDef("/server/assets/net-games/meters/order_points.png", { sx = 2, sy = 2 }),
            displayer.Builder.spriteDef("/server/assets/net-games/meters/order_points.png", { sx = 2, sy = 2 }),
            displayer.Builder.spriteDef("/server/assets/net-games/meters/order_points.png", { sx = 2, sy = 2 }),
        }
        Test.sprite_list_id = "scroll_sprite_1"
        displayer.ScrollingSprite.createList(Test.player_id, Test.sprite_list_id, 0, 0, 240, 160,
            displayer.Builder.spriteList({
                scroll_speed = 50,
                entry_delay = 1.5,
                max_columns = 2,
                column_spacing = 10,
                row_spacing = 10,
                align = "center",
                sprites = sprites,
                backdrop = displayer.Builder.backdrop(0, 0, 240, 160, nil, nil, 50, 50, 50, 150)
            })
        )
        schedule(10, function()
            displayer.ScrollingSprite.removeList(Test.player_id, Test.sprite_list_id)
            print("Scrolling sprite list removed")
            next_step()
        end)
    end,

    -- Step 9: Done
    function()
        print("9. All tests completed.")
        print("===== Displayer Test Completed =====")
    end,
}

-- Advance to next step
function next_step()
    Test.step = Test.step + 1
    if steps[Test.step] then
        steps[Test.step]()
    else
        print("Test finished unexpectedly.")
    end
end

-- Main entry point
function test_displayer(player_id)
    Test.player_id = player_id
    Net.toggle_player_hud(player_id)
    print("===== Starting Displayer Test for player " .. player_id .. " =====")
    Test.step = 0
    next_step()
end

-- Example usage (if run in a player join event):
Net:on("player_join", function(event)
    test_displayer(event.player_id)
end)