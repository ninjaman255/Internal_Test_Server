--[[
* ---------------------------------------------------------- *
          Net Games Demo by Indiana - Version 0.06
	      https://github.com/indianajson/net-games 
* ---------------------------------------------------------- *
]]--

local games = require("scripts/net-games/main")
local NetHelpers = require("scripts/net-games/helpers/net-helpers")
local AnimationEngine = require("scripts/animation-engine/animation-engine")
local AnimationSequences = require("scripts/animation-engine/animation-sequences")
local InputSystem = require("scripts/input-controller/main")   -- per‑player input controllers

NetHelpers.patch_net()

NetHelpers.safe_require("scripts/net-games/dialogue/startup")

--purpose: Shorthand for async
local function async(p)
    local co = coroutine.create(p)
    return Async.promisify(co)
end

--purpose: Shorthand for await
local function await(v) return Async.await(v) end

-------------------------------------------
-- DEBUG: print raw virtual_input
-------------------------------------------
Net:on("virtual_input", function(event)
    for _, ev in ipairs(event.events) do
        print("RAW INPUT:", ev.name, "state:", ev.state)
    end
end)

-------------------------------------------
-- AUTO-SPAWN NPCs FROM TILED OBJECTS
-------------------------------------------

-- Mapping from Tiled object name to bot ID and default assets
local npc_config = {
    MarqueeBat = {
        bot_id = "marquee_demo",
        texture = "/server/assets/demo/cyber_bat.png",
        animation = "/server/assets/demo/cyber_bat.animation",
        anim_state = nil
    },
    LiberationPointsBat = {
        bot_id = "bat",
        texture = "/server/assets/demo/cyber_bat.png",
        animation = "/server/assets/demo/cyber_bat.animation",
        anim_state = nil
    },
    NaviChanger = {
        bot_id = "changer",
        texture = "/server/assets/demo/protoman-bn5.png",
        animation = "/server/assets/demo/protoman-bn5.animation",
        anim_state = "IDLE_DL"
    },
    CosmeticRoll = {
        bot_id = "cosmo",
        texture = "/server/assets/demo/roll.png",
        animation = "/server/assets/demo/roll.animation",
        anim_state = nil
    }
}

local function spawn_demo_npcs()
    local areas = Net.list_areas()
    for _, area_id in ipairs(areas) do
        area_id = tostring(area_id)
        local objects = Net.list_objects(area_id)
        for _, object_id in ipairs(objects) do
            local object = Net.get_object_by_id(area_id, object_id)
            if object and npc_config[object.name] then
                local config = npc_config[object.name]
                Net.create_bot(config.bot_id, {
                    name = "",
                    area_id = area_id,
                    texture_path = config.texture,
                    animation_path = config.animation,
                    animation = config.anim_state,
                    x = object.x,
                    y = object.y,
                    z = object.z or 0,
                    solid = true,
                    warp_in = false
                })
                print("[demo] Spawned " .. config.bot_id .. " from Tiled object " .. object.name)
            end
        end
    end
end

-- Spawn all NPCs defined in the map
spawn_demo_npcs()

-------------------------------------------
-- DEMO CODE FOR NPC THAT LITTERALLY JUST TALK (WOW) --
-------------------------------------------

require("scripts/net-games/npcs/prog_banner_dialogue")
require("scripts/net-games/npcs/prog_basic_dialogue")
require("scripts/net-games/npcs/prog_basic_freedraw")
require("scripts/net-games/npcs/prog_dramatic_dialogue")
require("scripts/net-games/npcs/prog_dyed_dialogue")
require("scripts/net-games/npcs/prog_prompt_dialogue")
require("scripts/net-games/npcs/prog_basic_nameplate")
require("scripts/net-games/npcs/prog_talk_dialogue")
require("scripts/net-games/npcs/prog_talk_colors")
require("scripts/net-games/npcs/prog_vert_prompt")
require("scripts/net-games/npcs/prog_vert_prompt_2")
require("scripts/net-games/npcs/prog_vert_prompt_sapphire")
require("scripts/net-games/npcs/prog_vert_prompt_pink")
require("scripts/net-games/npcs/prog_vert_prompt_lime")
require("scripts/net-games/npcs/prog_vert_prompt_charcoal_grey")
require("scripts/net-games/npcs/prog_vert_prompt_red")
require("scripts/net-games/npcs/prog_vert_prompt_emerald")
require("scripts/net-games/npcs/prog_shop")
-------------------------------------------
-- DEMO CODE FOR NPC THAT GIVES COSMETIC --
-------------------------------------------

-- Bot "cosmo" is now auto‑spawned from Tiled object "CosmeticRoll"
local cosmo = {}

Net:on("actor_interaction", function(event)
    local cosmetic_id = "confetti"
    if event.actor_id == "cosmo" and event.button == 0 and (cosmo[event.player_id] ~= true) then
        local texture_path = "/server/assets/demo/shock.png"
        local animation_path = "/server/assets/demo/shock.animation"
        games.set_cosmetic(cosmetic_id, event.player_id, texture_path, animation_path, "cosmetic", 2, -40, true,-2)
        cosmo[event.player_id] = true
        Net.message_player(event.player_id, "Cosmetic enabled. So shiny!")
    elseif event.actor_id == "cosmo" and event.button == 0 and cosmo[event.player_id] == true then
        cosmo[event.player_id] = false
        games.remove_cosmetic(cosmetic_id, event.player_id)
        Net.message_player(event.player_id, "Cosmetic removed!")
    end
end)


----------------------------------------------------------
-- DEMO CODE FOR BASIC MARQUEE EXAMPLE [IN DEVELOPMENT] --
----------------------------------------------------------
local marquee_active = {}

-- Bot "marquee_demo" is auto‑spawned from Tiled object "MarqueeBat"

local backdrop_config = {
    x = 0,
    y = 130,
    width = 240,
    height = 30,
    loops = 0,
}

Net:on("actor_interaction", function(event)
    if event.actor_id == "marquee_demo" and event.button == 0 and (marquee_active[event.player_id] ~= true) then
        games.draw_marquee_text("demo_marquee", event.player_id, "Welcome to the Net Games Demo! This is a scrolling marquee text!", 15, "THICK", 2.0, 100, 60, backdrop_config)
        marquee_active[event.player_id] = true
        Net.message_player(event.player_id, "Marquee text activated! Watch it scroll across the screen.")
    elseif event.actor_id == "marquee_demo" and event.button == 0 and marquee_active[event.player_id] == true then
        marquee_active[event.player_id] = false
        Net.message_player(event.player_id, "Marquee text was removed!")
        games.remove_text("demo_marquee", event.player_id)
    end
end)

Net:on("player_join", function(event)
    marquee_active[event.player_id] = false

    local ctrl = InputSystem.get_controller(event.player_id)
    if ctrl then
        ctrl:on("button_pressed", function(ev)
            if ev.action == "Start" then
                Net.message_player(ev.player_id, "Start button pressed!")
            end
        end)
    end
end)

Net:on("player_disconnect", function(event)
    marquee_active[event.player_id] = false
end)

--------------------------------------------------------------
-- DEMO CODE FOR THE BAT NPC THAT SPAWNS THE ORDER POINT UI --
--------------------------------------------------------------

local bat_active = {}
local points_per_player = {}

-- Bot "bat" is auto‑spawned from Tiled object "LiberationPointsBat"

Net:on("virtual_input", function(event)
    local player_id = event.player_id
    if bat_active[player_id] ~= true then return end

    local ctrl = InputSystem.get_controller(player_id)
    if not ctrl then return end

    if ctrl:is_action_pressed("ShoulderR") then
        local points = points_per_player[player_id] or 8
        if points > 0 then
            points = points - 1
        else
            points = 8
        end
        points_per_player[player_id] = points
        games.set_ui_animation("points", player_id, tostring(points .. "POINT"))

    elseif ctrl:is_action_pressed("ShoulderL") then
        local points = points_per_player[player_id] or 8
        if points < 8 then
            points = points + 1
        else
            points = 0
        end
        points_per_player[player_id] = points
        games.set_ui_animation("points", player_id, tostring(points .. "POINT"))

    elseif ctrl:is_action_pressed("dir_Left") or ctrl:is_action_pressed("dir_Right") or
           ctrl:is_action_pressed("dir_Up") or ctrl:is_action_pressed("dir_Down") then
        games.remove_ui_element("points", player_id)
        bat_active[player_id] = false
        Net.unlock_player_input(player_id)
    end
end)

Net:on("actor_interaction", function (event)
    if event.actor_id == "bat" and event.button == 0 and bat_active[event.player_id] == false then
        points_per_player[event.player_id] = 8
        Net.message_player(event.player_id, "Press Left Shoulder to increase and Right Shoulder to decrease. Press any arrow key to stop.","","")
        Net.lock_player_input(event.player_id)

        local spr_id = "points"
        local pid = event.player_id

        games.add_ui_element(spr_id,pid,"/server/assets/demo/order_points.png","/server/assets/demo/order_points.animation","8POINT",0,0,0, 2,2, 240, 160)
        games.add_ui_element(spr_id.."a",pid,"/server/assets/demo/order_points.png","/server/assets/demo/order_points.animation","8POINT",0,0,0, 2,2, 240, 160, "center", "middle")
        games.add_ui_element(spr_id.."b",pid,"/server/assets/demo/order_points.png","/server/assets/demo/order_points.animation","8POINT",4,4,0, 2,2)
        async(function()
            local eprops1 = games.get_ui_element_properties(spr_id,pid)
            local eprops2 = games.get_ui_element_properties(spr_id.."a",pid)
            local eprops3 = games.get_ui_element_properties(spr_id.."b",pid)

            print(eprops1)

            games.complex_summon_ui_element_relative(spr_id,pid, 110, 50, 2.0, 4, 1, 2.0)
            games.set_ui_animation((spr_id.."b"), pid, "7POINT")
            games.set_ui_animation((spr_id.."a"), pid, "6POINT")

            AnimationSequences.series(
                {spr1 = eprops1,spr2 = eprops2,spr3 = eprops3},
              function(obj, opts)
                opts.loop = 1
                opts.ping_pong = true
                return AnimationSequences.pulse(obj, opts)
              end,
              { delay_between = 0.05, loop = true, anim_options = { duration = 0.18, scale_to = 1.15 } }
            )
            await(Async.sleep(2))

            games.shake_ui_element(spr_id.."b",pid,1, 100, 10)

            games.relative_slide_ui_element(spr_id, pid, 4, 141, 2, AnimationEngine.AnimEnums.EasingFns.cubic)

            games.menu_cursor_ui_element(spr_id, pid, 10, 1.1, 2,1, "horizontal")

            games.set_ui_element_color(spr_id, pid, 214, 124, 111, 1, AnimationEngine.AnimEnums.EasingFns.bounce_in)

            games.bob_ui_element(spr_id.."a",pid, 5, 2)

            games.summon_ui_element_relative(spr_id.."b",pid,161, 151, 2.0,3,20,1.1, 2, AnimationEngine.AnimEnums.EasingFns.cubic, function () end)

            games.color_pulse_from_current(spr_id.."b",pid, {r = 10, g = 122, b = 125, a = 255})
        end)

        bat_active[event.player_id] = true
    end
end)

Net:on("player_join", function(event)
    bat_active[event.player_id] = false
end)

Net:on("player_disconnect", function(event)
    bat_active[event.player_id] = false
end)

----------------------------------------------------------------------
-- DEMO CODE FOR THE NPC THAT SPAWNS A CURSOR TO CHANGE IT'S AVATAR --
----------------------------------------------------------------------

local points = 8   -- (unused variable kept for compatibility)

-- Bot "changer" is auto‑spawned from Tiled object "NaviChanger"

Net:on("cursor_selection", function(event)
    if event.cursor == "navi_changer" then
        print("DEBUG: cursor_selection received for player", event.player_id, "selection:", event.selection)
        games.remove_text("roll_label",event.player_id)
        games.remove_text("megaman_label",event.player_id)
        games.remove_text("protoman_label",event.player_id)
        games.remove_cursor("navi_changer",event.player_id)
        Net.unlock_player_input(event.player_id)

        local texture = ""
        local animation = ""
        if event.selection == "protoman" then
            texture = "/server/assets/demo/protoman-bn5.png"
            animation = "/server/assets/demo/protoman-bn5.animation"
        elseif event.selection == "roll" then
            texture = "/server/assets/demo/roll.png"
            animation = "/server/assets/demo/roll.animation"
        elseif event.selection == "megaman" then
            texture = "/server/assets/demo/megaman.png"
            animation = "/server/assets/demo/megaman.animation"
        end
        Net.provide_asset_for_player(event.player_id, texture)
        Net.provide_asset_for_player(event.player_id, animation)

        Net.set_bot_avatar("changer",texture,animation)
        local keyframes = {{properties={{property="Animation",value="IDLE_DL"}},duration=0}}
        Net.animate_bot_properties("changer", keyframes)
    end
end)

Net:on("actor_interaction", function (event)
    if event.actor_id == "changer" and event.button == 0 then
        print("DEBUG: Interacting with changer, spawning cursor for player", event.player_id)

        local green_cursor_texture = "/server/assets/net-games/cursors/text_cursor.png"
        local green_cursor_anim = "/server/assets/net-games/cursors/text_cursor.animation"
        local cursor_options = {
            texture = green_cursor_texture,
            animation = green_cursor_anim,
            movement = "vertical",
            selections = {
                { x = 35, y = 45, z = 0, name = 'roll',      state = "CURSOR_RIGHT" },
                { x = 35, y = 65, z = 0, name = 'megaman',   state = "CURSOR_RIGHT" },
                { x = 35, y = 85, z = 0, name = 'protoman',  state = "CURSOR_RIGHT" }
            },
        }
        games.spawn_cursor("navi_changer", event.player_id, cursor_options)

        games.color_pulse_from_current("navi_changer", event.player_id, {r = 0, g = 0, b = 255, a = 128})

        games.draw_text("roll_label",     event.player_id, "<Roll_EXE>",     40, 40, 100, "BATTLE")
        games.draw_text("megaman_label",  event.player_id, "Megaman_EXE",     40, 60, 100, "BATTLE")
        games.draw_text("protoman_label", event.player_id, "<PROTOMAN_EXE>", 40, 80, 100, "BATTLE")
    end
end)