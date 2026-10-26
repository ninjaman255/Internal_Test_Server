--[[
* ---------------------------------------------------------- *
                  Background Manager
* ---------------------------------------------------------- *
]]

local games = require("scripts/net-games/main")
local InputAPI = require("scripts/input-controller/main")
local TextLayout = require("scripts/displayer/text-layout")

local BackgroundManage = {}

local background_sessions = {}

local constants = require("scripts/hp_manager/constants/constants")

local background_data = {}
local background_data_file = "scripts/hp_manager/data/background_data.dat"

local background_cursors = {
    {
        id = "right_cursor",
        animation = "CURSOR_RIGHT",
        x = 233,
        y = 150,
        direction = 1
    },
    {
        id = "left_cursor",
        animation = "CURSOR_LEFT",
        x = 16,
        y = 150,
        direction = -1
    }
}

local background_settings = {
    {
        id = "velocity_x",
        label = "Velx",
        y = 65
    },
    {
        id = "velocity_y",
        label = "Vely",
        y = 80
    },
    {
        id = "parallax",
        label = "Prlx",
        y = 95
    }
}

-- BACKGROUND DATA LOAD
local function load_background_data()
    local file = io.open(background_data_file, "r")

    if file == nil then
        file = io.open(background_data_file .. ".bak", "r")
    end

    if file == nil then return end

    for line in file:lines() do
        local area_id, texture_path, animation_path, velocity_x, velocity_y, parallax =
            line:match("^(.-)\t(.-)\t(.-)\t(.-)\t(.-)\t(.-)$")

        velocity_x = tonumber(velocity_x)
        velocity_y = tonumber(velocity_y)
        parallax = tonumber(parallax)

        if area_id ~= nil and texture_path ~= nil and
            velocity_x ~= nil and velocity_y ~= nil and parallax ~= nil then
            background_data[area_id] = {
                texture_path = texture_path,
                animation_path = animation_path,
                velocity_x = velocity_x,
                velocity_y = velocity_y,
                parallax = parallax
            }
        end
    end

    file:close()
end

-- BACKGROUND DATA SAVE
local function save_background_data()
    local temp_file = background_data_file .. ".tmp"
    local backup_file = background_data_file .. ".bak"

    local file = io.open(temp_file, "w")

    if file == nil then return false end

    local area_ids = {}

    for area_id, _ in pairs(background_data) do
        area_ids[#area_ids + 1] = area_id
    end

    table.sort(area_ids)

    for _, area_id in ipairs(area_ids) do
        local data = background_data[area_id]

        file:write(
            area_id .. "\t" ..
            data.texture_path .. "\t" ..
            data.animation_path .. "\t" ..
            tostring(data.velocity_x) .. "\t" ..
            tostring(data.velocity_y) .. "\t" ..
            tostring(data.parallax) .. "\n"
        )
    end

    file:close()

    os.remove(backup_file)
    os.rename(background_data_file, backup_file)

    local saved = os.rename(temp_file, background_data_file)

    if not saved then
        os.rename(backup_file, background_data_file)
        return false
    end

    os.remove(backup_file)

    return true
end

-- CHECK BACKGROUND ASSET
local function background_asset_exists(asset_path)
    if type(asset_path) ~= "string" or asset_path == "" then
        return false
    end

    local file_path = asset_path:gsub("^/server/", "")
    local file = io.open(file_path, "rb")

    if file == nil then
        return false
    end

    file:close()
    return true
end

-- APPLY SAVED BACKGROUNDS
local function apply_background_data()
    local areas = {}
    local data_changed = false

    for _, area_id in ipairs(Net.list_areas()) do
        areas[area_id] = true
    end

    for area_id, data in pairs(background_data) do
        if areas[area_id] then
            local texture_exists = background_asset_exists(data.texture_path)

            local animation_exists = data.animation_path == nil
                or data.animation_path == ""
                or background_asset_exists(data.animation_path)

            if texture_exists and animation_exists then
                Net.set_background(area_id, data.texture_path, data.animation_path,
                    data.velocity_x, data.velocity_y, data.parallax)
            else
                -- REMOVE INVALID SAVED BACKGROUND
                background_data[area_id] = nil
                data_changed = true

                print("[Background Manager] Missing background asset in area: " .. area_id)
                print("[Background Manager] Keeping original map background.")
            end
        end
    end

    -- UPDATE DATA FILE ONLY WHEN NECESSARY
    if data_changed then
        if not save_background_data() then
            print("[Background Manager] Failed to update background data.")
        end
    end
end

load_background_data()
apply_background_data()

local function hide_background_manage_ui(player_id, session)
    if session.screen == "background" then
        games.remove_text("background_manager_name", player_id)

        for _, cursor in ipairs(background_cursors) do
            games.remove_ui_element(cursor.id, player_id)
        end
    elseif session.screen == "settings" then
        games.remove_text("background_settings_title", player_id)

        for index, _ in ipairs(background_settings) do
            games.remove_text("background_setting_" .. index, player_id)
        end

        games.remove_ui_element("board", player_id)
        games.remove_ui_element("settings_cursor", player_id)
    end

    games.remove_ui_element("word_bar", player_id)
    games.remove_ui_element("lb", player_id)
    games.remove_ui_element("rb", player_id)
end

-- BACKGROUND FINDER
local function find_backgrounds()
    local backgrounds = {}
    local separator = package.config:sub(1, 1)
    local command

    if separator == "\\" then
        command = 'dir /b /a-d "' .. constants.background_folder .. '"'
    else
        command = 'ls -1 "' .. constants.background_folder .. '"'
    end

    if io == nil or io.popen == nil then return backgrounds end

    local handle = io.popen(command)

    if handle == nil then return backgrounds end

    -- FIND VALID BACKGROUNDS
    for file_name in handle:lines() do
        if file_name:lower():match("%.png$") then
            local name = file_name:gsub("%.[^%.]+$", "")
            local animation_name = name .. ".animation"
            local animation_file = io.open(constants.background_folder .. "/" .. animation_name, "r")

            -- REQUIRE MATCHING ANIMATION
            if animation_file ~= nil then
                animation_file:close()

                backgrounds[#backgrounds + 1] = {
                    name = name,
                    file_name = file_name,
                    texture_path = constants.background_asset_folder .. file_name,
                    animation_path = constants.background_asset_folder .. animation_name
                }
            end
        end
    end

    handle:close()

    table.sort(backgrounds, function(a, b)
        return a.name:lower() < b.name:lower()
    end)

    return backgrounds
end

-- BACKGROUND MANAGER OPEN
function BackgroundManage.open(player_id, return_to_hp)
    local area_id = Net.get_player_area(player_id)
    local backgrounds = find_backgrounds()

    if #backgrounds == 0 then
        Net.message_player(player_id, "No backgrounds found in assets/backgrounds.")

        if return_to_hp ~= nil then
            return_to_hp(player_id)
        end

        return
    end

    local current_background = Net.get_background(area_id)
    local velocity = Net.get_background_velocity(area_id)
    local parallax = Net.get_background_parallax(area_id)

    local current_file = current_background.texture_path:match("([^/\\]+)$") or ""
    local selected = 0

    -- FIND CURRENT BACKGROUND
    for index, background in ipairs(backgrounds) do
        if background.file_name:lower() == current_file:lower() then
            selected = index
            break
        end
    end

    background_sessions[player_id] = {
        area_id = area_id,
        backgrounds = backgrounds,
        selected = selected,

        original_background = current_background,
        original_velocity = {
            x = velocity.x,
            y = velocity.y
        },
        original_parallax = parallax,

        velocity = {
            x = velocity.x,
            y = velocity.y
        },
        parallax = parallax,

        screen = "background",
        settings_selected = 1,

        return_to_hp = return_to_hp,
        cursor_timer = 0,
        cursor_offset = 0,
        closing = false
    }

    Net.lock_player_input(player_id)

    games.add_ui_element("word_bar", player_id, "/server/assets/hp_manager/background_manage_bar.png", "", "", 0,
        140, 110, 2, 2)

    games.add_ui_element("lb", player_id, "/server/assets/hp_manager/lb_button.png", "", "", 224,
        135, 100, 2, 2)

    games.add_ui_element("rb", player_id, "/server/assets/hp_manager/rb_button.png", "", "", 3,
        135, 100, 2, 2)

    -- CURSORS

    for _, cursor in ipairs(background_cursors) do
        games.add_ui_element(cursor.id, player_id, "/server/assets/net-games/cursors/text_cursor.png",
            "/server/assets/net-games/cursors/text_cursor.animation", cursor.animation, cursor.x, cursor.y, 30, 2, 2)
    end

    if selected > 0 then
        local name = backgrounds[selected].name
        local text_width = TextLayout.measureLine(name, { font = "THICK", scale = 2 })
        local text_x = (240 - text_width) / 2

        games.draw_text("background_manager_name", player_id, name, text_x, 145, 150, "THICK", 2)
    else
        local current_name = current_file:gsub("%.[^%.]+$", "") .. " [Current]"
        local text_width = TextLayout.measureLine(current_name, { font = "THICK", scale = 2 })
        local text_x = (240 - text_width) / 2

        games.draw_text("background_manager_name", player_id, current_name, text_x, 145, 150, "THICK", 2)
    end
end

-- BACKGROUND MANAGER INPUT
local function handle_manager_input(event)
    local player_id = event.player_id
    local session = background_sessions[player_id]

    if session == nil or session.closing then return end

    for _, button in next, event.events do
        if button.state == 1 then
            local new_selection = nil
            local backgrounds = session.backgrounds
            local background_count = #backgrounds

            -- CHANGE SCREEN
            if button.name == "Shoulder L" or button.name == "Shoulder R" then
                -- BACKGROUND -> SETTINGS
                if session.screen == "background" then
                    session.screen = "settings"

                    games.remove_text("background_manager_name", player_id)

                    for _, cursor in ipairs(background_cursors) do
                        games.remove_ui_element(cursor.id, player_id)
                    end

                    local title = "Background Settings"
                    local title_width = TextLayout.measureLine(title, { font = "THICK", scale = 1 })
                    local title_x = (240 - title_width) / 2

                    games.draw_text("background_settings_title", player_id, title, title_x, 50, 150, "THICK", 1)

                    for index, setting in ipairs(background_settings) do
                        local value

                        if setting.id == "parallax" then
                            value = session.parallax
                        else
                            value = session.velocity[setting.id == "velocity_x" and "x" or "y"]
                        end

                        games.draw_text("background_setting_" .. index, player_id,
                            setting.label .. ": " .. string.format("%.2f", value), 100, setting.y, 150, "THICK", 1)
                    end

                    local setting = background_settings[session.settings_selected]

                    games.add_ui_element("settings_cursor", player_id, "/server/assets/net-games/cursors/text_cursor.png",
                        "/server/assets/net-games/cursors/text_cursor.animation", "CURSOR_RIGHT", 98, setting.y + 2, 30,
                        1, 1)

                    games.add_ui_element("board", player_id, "/server/assets/hp_manager/board.png",
                        "", "",
                        80, 43, 20, 2, 2)

                    -- SETTINGS -> BACKGROUND
                elseif session.screen == "settings" then
                    session.screen = "background"

                    games.remove_text("background_settings_title", player_id)

                    for index, _ in ipairs(background_settings) do
                        games.remove_text("background_setting_" .. index, player_id)
                    end

                    games.remove_ui_element("settings_cursor", player_id)
                    games.remove_ui_element("board", player_id)

                    for _, cursor in ipairs(background_cursors) do
                        games.add_ui_element(cursor.id, player_id, "/server/assets/net-games/cursors/text_cursor.png",
                            "/server/assets/net-games/cursors/text_cursor.animation", cursor.animation,
                            cursor.x, cursor.y, 30, 2, 2)
                    end

                    local background = backgrounds[session.selected]
                    local name

                    if background ~= nil then
                        name = background.name
                    else
                        local current = Net.get_background(session.area_id)
                        local current_file = current.texture_path:match("([^/\\]+)$") or ""
                        name = current_file:gsub("%.[^%.]+$", "") .. " [Current]"
                    end

                    local text_width = TextLayout.measureLine(name, { font = "THICK", scale = 2 })
                    local text_x = (240 - text_width) / 2

                    games.draw_text("background_manager_name", player_id, name, text_x, 145, 150, "THICK", 2)
                end

                return
            end

            -- BACKGROUND NAVIGATION
            if session.screen == "background" then
                if button.name == "Move Right" then
                    if session.selected == 0 then
                        new_selection = 1
                    else
                        new_selection = session.selected % background_count + 1
                    end
                elseif button.name == "Move Left" then
                    if session.selected == 0 then
                        new_selection = background_count
                    else
                        new_selection = (session.selected - 2) % background_count + 1
                    end
                end
            end

            -- BACKGROUND PREVIEW
            if new_selection ~= nil and new_selection ~= session.selected then
                session.selected = new_selection

                local background = backgrounds[new_selection]

                Net.set_background(session.area_id, background.texture_path, background.animation_path,
                    session.velocity.x, session.velocity.y, session.parallax)

                local text_width = TextLayout.measureLine(background.name, { font = "THICK", scale = 2 })
                local text_x = (240 - text_width) / 2

                games.draw_text("background_manager_name", player_id, background.name, text_x, 145, 150, "THICK", 2)
            end

            -- BACKGROUND SETTINGS
            if session.screen == "settings" then
                -- SETTING NAVIGATION
                if button.name == "Move Down" then
                    session.settings_selected = session.settings_selected % #background_settings + 1

                    local setting = background_settings[session.settings_selected]

                    games.update_ui_element("settings_cursor", player_id, {
                        x = 98,
                        y = setting.y + 2,
                        z = 30
                    })
                elseif button.name == "Move Up" then
                    session.settings_selected = (session.settings_selected - 2) % #background_settings + 1

                    local setting = background_settings[session.settings_selected]

                    games.update_ui_element("settings_cursor", player_id, {
                        x = 98,
                        y = setting.y + 2,
                        z = 30
                    })
                end

                -- CHANGE SETTING VALUE
                if button.name == "Move Left" or button.name == "Move Right" then
                    local setting = background_settings[session.settings_selected]
                    local amount = button.name == "Move Right" and 0.1 or -0.1

                    if setting.id == "velocity_x" then
                        session.velocity.x = tonumber(string.format("%.1f", session.velocity.x + amount))
                    elseif setting.id == "velocity_y" then
                        session.velocity.y = tonumber(string.format("%.1f", session.velocity.y + amount))
                    elseif setting.id == "parallax" then
                        session.parallax = tonumber(string.format("%.1f", session.parallax + amount))
                    end

                    local current = Net.get_background(session.area_id)

                    Net.set_background(session.area_id, current.texture_path, current.animation_path,
                        session.velocity.x, session.velocity.y, session.parallax)

                    local value

                    if setting.id == "parallax" then
                        value = session.parallax
                    else
                        value = session.velocity[setting.id == "velocity_x" and "x" or "y"]
                    end

                    games.draw_text("background_setting_" .. session.settings_selected, player_id,
                        setting.label .. ": " .. string.format("%.2f", value), 100, setting.y, 150, "THICK", 1)
                end
            end

            -- CLOSE BACKGROUND MANAGER
            if button.name == "Cancel" then
                local return_to_hp = session.return_to_hp
                local current = Net.get_background(session.area_id)

                local background_changed =
                    current.texture_path ~= session.original_background.texture_path or
                    current.animation_path ~= session.original_background.animation_path

                local velocity_changed =
                    math.abs(session.velocity.x - session.original_velocity.x) > 0.0001 or
                    math.abs(session.velocity.y - session.original_velocity.y) > 0.0001

                local parallax_changed =
                    math.abs(session.parallax - session.original_parallax) > 0.0001

                local has_changes = background_changed or velocity_changed or parallax_changed

                -- NO CHANGES
                if not has_changes then
                    hide_background_manage_ui(player_id, session)

                    background_sessions[player_id] = nil

                    Async.sleep(0.01).and_then(function()
                        if return_to_hp ~= nil then
                            return_to_hp(player_id)
                        else
                            Net.unlock_player_input(player_id)
                        end
                    end)

                    return
                end

                -- SAVE CHANGES?
                session.closing = true

                hide_background_manage_ui(player_id, session)

                Async.question_player(player_id, "Save changes?").and_then(function(response)
                    if response == nil then return end

                    local current_session = background_sessions[player_id]

                    if current_session == nil then return end

                    -- SAVE
                    if response == 1 then
                        local current = Net.get_background(current_session.area_id)

                        background_data[current_session.area_id] = {
                            texture_path = current.texture_path,
                            animation_path = current.animation_path,
                            velocity_x = current_session.velocity.x,
                            velocity_y = current_session.velocity.y,
                            parallax = current_session.parallax
                        }

                        save_background_data()

                        -- DON'T SAVE
                    else
                        local original = current_session.original_background

                        Net.set_background(current_session.area_id, original.texture_path, original.animation_path,
                            current_session.original_velocity.x, current_session.original_velocity.y,
                            current_session.original_parallax)
                    end

                    background_sessions[player_id] = nil

                    Async.sleep(0.01).and_then(function()
                        if return_to_hp ~= nil then
                            return_to_hp(player_id)
                        else
                            Net.unlock_player_input(player_id)
                        end
                    end)
                end)

                return
            end
        end
    end
end



-- InputController ownership/polling adapter. The shared controller is the only
-- source of gameplay input; this module never consumes raw virtual_input events.
local input_owner_prefix = "hp-background-manager:"
local function input_owner(player_id) return input_owner_prefix .. tostring(player_id) end
local function poll_manager_input(player_id, owner)
    local ctrl = InputAPI.get_controller(player_id)
    if not ctrl then return nil end
    if not ctrl:has_input_control(owner) then
        if ctrl:get_input_owner() ~= nil or not ctrl:claim_input(owner) then return nil end
        ctrl:require_release({"Up", "Down", "Left", "Right", "Confirm", "Cancel", "ShoulderL", "ShoulderR"}, owner)
        return nil -- ignore the handoff frame
    end
    local events = {}
    local function take(action, raw_name, allow_repeat)
        if ctrl:is_action_pressed(action, owner) then
            events[#events + 1] = {name = raw_name, state = 1}
        elseif allow_repeat and ctrl:is_action_repeated(action, owner) then
            events[#events + 1] = {name = raw_name, state = 2}
        end
    end
    take("Up", "Move Up", false)
    take("Down", "Move Down", false)
    take("Left", "Move Left", true)
    take("Right", "Move Right", true)
    take("Confirm", "Confirm", false)
    take("Cancel", "Cancel", false)
    take("ShoulderL", "Shoulder L", false)
    take("ShoulderR", "Shoulder R", false)
    return {player_id = player_id, events = events}
end

Net:on("tick", function()
    local active = {}
    for player_id, session in pairs(background_sessions) do
        if session and not session.closing then active[#active + 1] = player_id end
    end
    for _, player_id in ipairs(active) do
        local owner = input_owner(player_id)
        local synthetic = poll_manager_input(player_id, owner)
        if synthetic and #synthetic.events > 0 then handle_manager_input(synthetic) end
    end
    -- Release only this manager's claim when it no longer has an active session.
    for player_id, ctrl in pairs(InputAPI._controllers or {}) do
        if background_sessions[player_id] == nil then ctrl:release_input(input_owner(player_id)) end
    end
end)

-- CLEANUP
Net:on("player_disconnect", function(event)
    local session = background_sessions[event.player_id]

    if session == nil then
        return
    end

    local original = session.original_background

    Net.set_background(session.area_id, original.texture_path, original.animation_path,
        session.original_velocity.x, session.original_velocity.y, session.original_parallax)

    background_sessions[event.player_id] = nil
end)

-- CURSOR ANIMATION
Net:on("tick", function(event)
    for player_id, session in pairs(background_sessions) do
        if session.screen == "background" then
            session.cursor_timer = session.cursor_timer + event.delta_time

            if session.cursor_timer >= 0.20 then
                session.cursor_timer = 0
                session.cursor_offset = session.cursor_offset == 0 and 1 or 0

                for _, cursor in ipairs(background_cursors) do
                    games.update_ui_element(cursor.id, player_id, {
                        x = cursor.x + session.cursor_offset * cursor.direction,
                        y = cursor.y,
                        z = 30
                    })
                end
            end
        end
    end
end)

return BackgroundManage
