--[[
* ---------------------------------------------------------- *
                  Real Day Time Manager
* ---------------------------------------------------------- *
]]

local games = require("scripts/net-games/main")
local InputAPI = require("scripts/input-controller/main")
local TextLayout = require("scripts/displayer/text-layout")

local RealtimeManage = {}
local realtime_sessions = {}

-- REAL TIME SETTINGS
local realtime_settings = {
    {
        id = "Time_type",
        label = "Time type",
        y = 65
    },
    {
        id = "Timezone",
        label = "Timezone",
        y = 80
    }
}

local time_modes = { "sync", "cus", "off" }


local realtime_data = {}
local realtime_data_file = "scripts/HP_Manager/data/realtime_data.dat"

-- REALTIME DATA LOAD
local function load_realtime_data()
    local file = io.open(realtime_data_file, "r")

    if file == nil then
        file = io.open(realtime_data_file .. ".bak", "r")
    end

    if file == nil then return end

    for line in file:lines() do
        local area_id, mode, timezone =
            line:match("^(.-)\t(.-)\t(.-)$")

        timezone = tonumber(timezone)

        if area_id ~= nil and (mode == "sync" or mode == "cus" or mode == "off") and timezone ~= nil and timezone >= -840 and timezone <= 840 then
            realtime_data[area_id] = {
                mode = mode,
                timezone = timezone
            }
        end
    end

    file:close()
end

-- REALTIME DATA SAVE
local function save_realtime_data()
    local temp_file = realtime_data_file .. ".tmp"
    local backup_file = realtime_data_file .. ".bak"

    local file = io.open(temp_file, "w")

    if file == nil then return false end

    local area_ids = {}

    for area_id, _ in pairs(realtime_data) do
        area_ids[#area_ids + 1] = area_id
    end

    table.sort(area_ids)

    for _, area_id in ipairs(area_ids) do
        local data = realtime_data[area_id]

        file:write(
            area_id .. "\t" ..
            data.mode .. "\t" ..
            tostring(data.timezone) .. "\n"
        )
    end

    file:close()

    os.remove(backup_file)
    os.rename(realtime_data_file, backup_file)

    local saved = os.rename(temp_file, realtime_data_file)

    if not saved then
        os.rename(backup_file, realtime_data_file)
        return false
    end

    os.remove(backup_file)

    return true
end

-- APPLY SAVED SETTINGS
local function apply_realtime_data()
    local areas = {}

    for _, area_id in ipairs(Net.list_areas()) do
        areas[area_id] = true
    end

    for area_id, data in pairs(realtime_data) do
        if areas[area_id] then
            Net.set_area_custom_property(area_id, "Ambient_day_night", data.mode)
            Net.set_area_custom_property(area_id, "Ambient_timezone", data.timezone)
        end
    end
end

-- INITIALIZE SAVED SETTINGS
load_realtime_data()
apply_realtime_data()

-- CURRENT TIME
local function draw_current_time(player_id, session)
    local area_id = session.area_id
    local mode = Net.get_area_custom_property(area_id, "Ambient_day_night")
    local timestamp = os.time()

    if mode == "cus" or mode == "off" then
        local timezone = tonumber(Net.get_area_custom_property(area_id, "Ambient_timezone")) or 0

        timestamp = timestamp + timezone * 60
    end

    local current_time = os.date("%I:%M %p", timestamp)

    if session.last_displayed_time == current_time then return end

    session.last_displayed_time = current_time

    games.draw_text("realtime_current_time", player_id, "Time: " .. current_time, 91, 95, 150, "THICK", 1)
end


-- DRAW SETTING VALUE
local function draw_setting(player_id, area_id, index)
    local setting = realtime_settings[index]
    local value = "Not set"

    if setting.id == "Time_type" then
        local mode = Net.get_area_custom_property(area_id, "Ambient_day_night")

        if mode == "sync" or mode == "cus" or mode == "off" then
            value = mode
        end
    elseif setting.id == "Timezone" then
        local timezone = tonumber(Net.get_area_custom_property(area_id, "Ambient_timezone"))

        if timezone ~= nil then
            value = string.format("%+g min", timezone)
        end
    end

    games.draw_text("realtime_setting_" .. index, player_id, setting.label .. ": " .. value, 91, setting.y, 150, "THICK", 1)
end

-- SETTINGS UI
local function hide_settings_ui(player_id)
    games.remove_text("realtime_settings_title", player_id)
    games.remove_text("realtime_settings_empty", player_id)
    games.remove_text("realtime_current_time", player_id)

    for index in ipairs(realtime_settings) do
        games.remove_text("realtime_setting_" .. index, player_id)
    end

    games.remove_ui_element("realtime_settings_cursor", player_id)
    games.remove_ui_element("realtime_settings_board", player_id)
end

-- REAL TIME MANAGER OPEN
function RealtimeManage.open(player_id, return_to_hp, real_day_time)
    if realtime_sessions[player_id] ~= nil then return end

    local area_id = Net.get_player_area(player_id)

    realtime_sessions[player_id] = {
        area_id = area_id,
        selected = 1,
        return_to_hp = return_to_hp,
        cursor_timer = 0,
        cursor_offset = 0,
        real_day_time = real_day_time,
        timezone_delay = 0,

        original_mode = Net.get_area_custom_property(area_id, "Ambient_day_night"),
        original_timezone = Net.get_area_custom_property(area_id, "Ambient_timezone"),
        closing = false
    }


    Net.lock_player_input(player_id)

    games.add_ui_element("realtime_settings_board", player_id,
        "/server/assets/HP_Manager/board.png", "", "", 80, 43, 20, 2, 2)

    local title = "Real Time Settings"
    local title_width = TextLayout.measureLine(title, {
        font = "THICK",
        scale = 1
    })

    games.draw_text("realtime_settings_title", player_id, title, (240 - title_width) / 2, 50, 150, "THICK", 1)

    -- SETTINGS LIST
    for index in ipairs(realtime_settings) do
        draw_setting(player_id, area_id, index)
    end

    -- CURRENT TIME
    draw_current_time(player_id, realtime_sessions[player_id])

    -- SETTINGS CURSOR
    local setting = realtime_settings[1]

    games.add_ui_element("realtime_settings_cursor", player_id,
        "/server/assets/net-games/cursors/text_cursor.png",
        "/server/assets/net-games/cursors/text_cursor.animation",
        "CURSOR_RIGHT", 89, setting.y + 2, 30, 1, 1)
end

-- RESTORE ORIGINAL SETTINGS
local function restore_original_settings(session)
    local area_id = session.area_id

    Net.set_area_custom_property(area_id, "Ambient_day_night", session.original_mode or "")
    Net.set_area_custom_property(area_id, "Ambient_timezone", session.original_timezone or "")

    if session.real_day_time and type(session.real_day_time.refresh_area) == "function" then
        session.real_day_time.refresh_area(area_id)
    end
end

-- REAL TIME MANAGER INPUT
local function handle_manager_input(event)
    local player_id = event.player_id
    local session = realtime_sessions[player_id]

    if session == nil or session.closing then return end


for _, button in next, event.events do
    if button.state == 1 and
        (button.name == "Move Left" or button.name == "Move Right") then
        session.timezone_delay = 0
    end

    if button.state == 1 or (button.state == 2 and session.timezone_delay >= 0.5 and realtime_settings[session.selected].id == "Timezone" and (button.name == "Move Left" or button.name == "Move Right")) then

            -- CLOSE REAL TIME MANAGER
            if button.name == "Cancel" then
                local return_to_hp = session.return_to_hp
                local area_id = session.area_id

                local current_mode = Net.get_area_custom_property(area_id, "Ambient_day_night")
                local current_timezone = Net.get_area_custom_property(area_id, "Ambient_timezone")

                local mode_changed = current_mode ~= session.original_mode
                local timezone_changed = tostring(current_timezone or "") ~= tostring(session.original_timezone or "")
                local has_changes = mode_changed or timezone_changed

                -- NO CHANGES
                if not has_changes then
                    hide_settings_ui(player_id)

                    realtime_sessions[player_id] = nil

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

                hide_settings_ui(player_id)

                Async.question_player(player_id, "Save changes?").and_then(function(response)
                    local current_session = realtime_sessions[player_id]

                    if current_session == nil then return end

                    local current_area = current_session.area_id

                    -- SAVE
                    if response == 1 then
                        local mode = Net.get_area_custom_property(current_area, "Ambient_day_night")
                        local timezone = tonumber(Net.get_area_custom_property(current_area, "Ambient_timezone")) or 0

                        if (mode == "sync" or mode == "cus" or mode == "off")
                            and timezone >= -840 and timezone <= 840 then
                            realtime_data[current_area] = {
                                mode = mode,
                                timezone = timezone
                            }

                            if not save_realtime_data() then
                                print("[Real Time Manager] Failed to save settings.")
                            end
                        else
                            print("[Real Time Manager] Invalid area settings.")
                            restore_original_settings(current_session)
                        end

                        -- DON'T SAVE
                    else
                        restore_original_settings(current_session)
                    end

                    realtime_sessions[player_id] = nil

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


            if #realtime_settings == 0 then return end

            -- SETTINGS NAVIGATION
            local new_selection = nil

            if button.name == "Move Down" then
                new_selection = session.selected % #realtime_settings + 1
            elseif button.name == "Move Up" then
                new_selection = (session.selected - 2) % #realtime_settings + 1
            end

            -- CHANGE SETTING
            if new_selection ~= nil and new_selection ~= session.selected then
                session.selected = new_selection
                session.cursor_offset = 0

                local setting = realtime_settings[session.selected]

                games.update_ui_element("realtime_settings_cursor", player_id, {
                    x = 91,
                    y = setting.y + 2,
                    z = 30
                })

                return
            end

            -- CHANGE SETTING VALUE
            if button.name == "Move Left" or button.name == "Move Right" then
                local setting = realtime_settings[session.selected]
                local direction = button.name == "Move Right" and 1 or -1

                -- TIME TYPE
                if setting.id == "Time_type" then
                    local current_mode = Net.get_area_custom_property(session.area_id, "Ambient_day_night")
                    local current_index = 0

                    for index, mode in ipairs(time_modes) do
                        if mode == current_mode then
                            current_index = index
                            break
                        end
                    end

                    local next_index

                    if current_index == 0 then
                        next_index = direction == 1 and 1 or #time_modes
                    else
                        next_index = (current_index - 1 + direction) % #time_modes + 1
                    end

                    Net.set_area_custom_property(session.area_id, "Ambient_day_night", time_modes[next_index])

                    -- TIMEZONE
                elseif setting.id == "Timezone" then
                    local current_timezone = tonumber(Net.get_area_custom_property(session.area_id, "Ambient_timezone")) or 0
                    local new_timezone = math.max(-1440, math.min(1440, current_timezone + direction * 5))

                    Net.set_area_custom_property(session.area_id, "Ambient_timezone", new_timezone)
                end

                -- REFRESH REAL DAY TIME SETTINGS
                if session.real_day_time
                    and type(session.real_day_time.refresh_area) == "function" then
                    session.real_day_time.refresh_area(session.area_id)
                end

                -- UPDATE DISPLAY
                draw_setting(player_id, session.area_id, session.selected)
                draw_current_time(player_id, session)
                return
            end
        end
    end
end



-- InputController ownership/polling adapter. The shared controller is the only
-- source of gameplay input; this module never consumes raw virtual_input events.
local input_owner_prefix = "hp-realtime-manager:"
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
    for player_id, session in pairs(realtime_sessions) do
        if session and not session.closing then active[#active + 1] = player_id end
    end
    for _, player_id in ipairs(active) do
        local owner = input_owner(player_id)
        local synthetic = poll_manager_input(player_id, owner)
        if synthetic and #synthetic.events > 0 then handle_manager_input(synthetic) end
    end
    -- Release only this manager's claim when it no longer has an active session.
    for player_id, ctrl in pairs(InputAPI._controllers or {}) do
        if realtime_sessions[player_id] == nil then ctrl:release_input(input_owner(player_id)) end
    end
end)

-- CLEANUP
Net:on("player_disconnect", function(event)
    local session = realtime_sessions[event.player_id]

    if session == nil then return end

    restore_original_settings(session)

    realtime_sessions[event.player_id] = nil
end)

-- CURSOR ANIMATION
Net:on("tick", function(event)
    if #realtime_settings == 0 then return end

    for player_id, session in pairs(realtime_sessions) do
        session.cursor_timer = session.cursor_timer + event.delta_time
        session.timezone_delay = math.min(0.5, session.timezone_delay + event.delta_time)

        if session.cursor_timer >= 0.20 then
            session.cursor_timer = session.cursor_timer - 0.20
            session.cursor_offset = session.cursor_offset == 0 and 1 or 0
            draw_current_time(player_id, session)
            local setting = realtime_settings[session.selected]

            games.update_ui_element("realtime_settings_cursor", player_id, {
                x = 89 + session.cursor_offset,
                y = setting.y + 2,
                z = 30
            })
        end
    end
end)

return RealtimeManage