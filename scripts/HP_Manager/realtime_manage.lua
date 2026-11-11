--[[
* ---------------------------------------------------------- *
                  Real Day Time Manager
* ---------------------------------------------------------- *
]]

local games = require("scripts/net-games/main")
local PlayerControl = require("scripts/player-control/main")
local log = require("scripts/logger/logger").register("hp_manager"):register_subsystem("real-time")
local TextLayout = require("scripts/displayer/text-layout")

local RealtimeManage = {}
local realtime_sessions = {}
local abandon_realtime_editor

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
local realtime_data_file = "scripts/hp_manager/data/realtime_data.dat"

-- Read the file and runtime properties independently of the editor preview.
local function realtime_description(mode, timezone)
    return "mode=" .. tostring(mode) .. " timezone=" .. tostring(timezone) ..
        " effective_timezone=" .. ((mode == "cus") and "UTC+offset" or
        ((mode == "sync") and "server-local+offset" or "disabled"))
end

local function disk_realtime_record(area_id)
    local file, err = io.open(realtime_data_file, "r")
    if not file then return nil, "cannot read " .. realtime_data_file .. ": " .. tostring(err) end
    local record
    for line in file:lines() do
        local area, mode, offset = line:match("^(.-)\t(.-)\t(.-)$")
        if area == area_id then
            record = { mode = mode, timezone = tonumber(offset) }
            break
        end
    end
    file:close()
    if not record then return nil, "no saved record for " .. tostring(area_id) end
    return record
end

local function live_realtime_description(area_id)
    local ok, mode, offset = pcall(function()
        return Net.get_area_custom_property(area_id, "Ambient_day_night"),
            Net.get_area_custom_property(area_id, "Ambient_timezone")
    end)
    if not ok then return "<read error: " .. tostring(mode) .. ">" end
    return realtime_description(mode, offset)
end

-- REALTIME DATA LOAD
local function load_realtime_data()
    local file = io.open(realtime_data_file, "r")

    if file == nil then
        file = io.open(realtime_data_file .. ".bak", "r")
    end

    if file == nil then
        log:debug("[Real Time Manager] no persistence file at " .. realtime_data_file)
        return
    end

    for line in file:lines() do
        local area_id, mode, timezone =
            line:match("^(.-)\t(.-)\t(.-)$")

        timezone = tonumber(timezone)

        if area_id ~= nil and (mode == "sync" or mode == "cus" or mode == "off") and timezone ~= nil and timezone >= -840 and timezone <= 840 then
            realtime_data[area_id] = {
                mode = mode,
                timezone = timezone
            }
            log:info("[Real Time Manager] loaded area=" .. tostring(area_id) .. " " ..
                realtime_description(mode, timezone))
        end
    end

    file:close()
end

-- REALTIME DATA SAVE
local function save_realtime_data()
    local temp_file = realtime_data_file .. ".tmp"
    local backup_file = realtime_data_file .. ".bak"
    -- Write and close the replacement fully before touching the old file.
    -- Binary mode preserves literal newlines on Windows for exact byte readback.
    local file, open_err = io.open(temp_file, "wb")
    if not file then
        log:error("[Real Time Manager] temporary save open failed: " .. tostring(open_err))
        return false
    end
    local written_lines = {}
    local ok, err = pcall(function()
        local area_ids = {}
        for area_id in pairs(realtime_data) do area_ids[#area_ids + 1] = area_id end
        table.sort(area_ids)
        for _, area_id in ipairs(area_ids) do
            local data = realtime_data[area_id]
            local line = area_id .. "\t" .. data.mode .. "\t" ..
                tostring(data.timezone) .. "\n"
            written_lines[#written_lines + 1] = line
            assert(file:write(line))
        end
    end)
    local closed, close_err = file:close()
    if not ok or not closed then
        os.remove(temp_file)
        log:error("[Real Time Manager] save write failed: " .. tostring(ok and close_err or err))
        return false
    end

    local old_file = io.open(realtime_data_file, "r")
    local had_old = old_file ~= nil
    if old_file then
        old_file:close()
        os.remove(backup_file)
        local moved, move_err = os.rename(realtime_data_file, backup_file)
        if not moved then
            os.remove(temp_file)
            log:error("[Real Time Manager] backup failed: " .. tostring(move_err))
            return false
        end
    end
    local moved, move_err = os.rename(temp_file, realtime_data_file)
    if not moved then
        -- Preserve the previously persisted file whenever the replacement
        -- cannot be installed (especially on Windows).
        os.rename(backup_file, realtime_data_file)
        os.remove(temp_file)
        log:error("[Real Time Manager] commit failed: " .. tostring(move_err))
        return false
    end
    local verify_file, verify_err = io.open(realtime_data_file, "rb")
    local actual
    if verify_file then
        actual = verify_file:read("*a")
        verify_file:close()
    end
    if actual ~= table.concat(written_lines) then
        log:error("[Real Time Manager] committed file readback failed path=" ..
            realtime_data_file .. " reason=" .. tostring(verify_err or "content mismatch"))
        os.remove(realtime_data_file)
        if had_old then
            local restored, restore_err = os.rename(backup_file, realtime_data_file)
            if not restored then log:error("[Real Time Manager] backup restore failed: " .. tostring(restore_err)) end
        end
        return false
    end
    os.remove(backup_file)
    log:info("[Real Time Manager] persisted " .. tostring(#written_lines) ..
        " area record(s) to " .. realtime_data_file .. " (verified readback)")
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
            log:info("[Real Time Manager] startup apply area=" .. tostring(area_id) ..
                " requested=" .. realtime_description(data.mode, data.timezone) ..
                " live=" .. live_realtime_description(area_id))
        end
    end
end

-- INITIALIZE SAVED SETTINGS
load_realtime_data()
apply_realtime_data()

-- CURRENT TIME
local function draw_current_time(player_id, session)
    local area_id = session.area_id
    local mode = session.preview_mode
    local timestamp = os.time()
    local date_format = "%I:%M %p"
    if mode == "cus" or mode == "off" then
        -- Custom mode offsets UTC; sync mode offsets the server-local clock.
        timestamp = timestamp + session.preview_timezone * 60
        date_format = "!%I:%M %p"
    elseif mode == "sync" then
        timestamp = timestamp + session.preview_timezone * 60
    end
    local current_time = os.date(date_format, timestamp)

    if session.last_displayed_time == current_time then return end

    session.last_displayed_time = current_time

    games.draw_text("realtime_current_time", player_id, "Time: " .. current_time, 91, 95, 150, "THICK", 1)
end


-- DRAW SETTING VALUE
local function draw_setting(player_id, area_id, index, session)
    local setting = realtime_settings[index]
    local value = "Not set"

    if setting.id == "Time_type" then
        local mode = session and session.preview_mode or
            Net.get_area_custom_property(area_id, "Ambient_day_night")

        if mode == "sync" or mode == "cus" or mode == "off" then
            value = mode
        end
    elseif setting.id == "Timezone" then
        local timezone = session and session.preview_timezone or
            tonumber(Net.get_area_custom_property(area_id, "Ambient_timezone"))

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
function RealtimeManage.open(player_id, return_to_hp, real_day_time, options)
    if realtime_sessions[player_id] then return false, "real-time editor already open" end

    local area_id = Net.get_player_area(player_id)

    options = options or {}
    local control, control_err = PlayerControl.begin(player_id, {
        owner="hp_manager:realtime", profile="settings_menu",
        parent=options.parent
    })
    if not control then
        log:warn("[Real Time Manager] " .. tostring(control_err))
        if return_to_hp and not options.parent then pcall(return_to_hp, player_id) end
        return false, control_err
    end
    local initial_mode = Net.get_area_custom_property(area_id, "Ambient_day_night")
    local initial_timezone = Net.get_area_custom_property(area_id, "Ambient_timezone")
    log:info("[Real Time Manager] opening editor area=" .. tostring(area_id) ..
        " mode=" .. tostring(initial_mode) .. " timezone=" .. tostring(initial_timezone))
    log:debug("[Real Time Manager] editor opened live area=" .. tostring(area_id) ..
        " " .. live_realtime_description(area_id))
    realtime_sessions[player_id] = {
        control = control,
        area_id = area_id,
        selected = 1,
        return_to_hp = return_to_hp,
        cursor_timer = 0,
        cursor_offset = 0,
        real_day_time = real_day_time,
        timezone_delay = 0,

        original_mode = initial_mode,
        original_timezone = initial_timezone,
        preview_mode = initial_mode,
        preview_timezone = tonumber(initial_timezone) or 0,
        closing = false,
        finished = false
    }
    control:on_close(function()
        local session = realtime_sessions[player_id]
        if not session or session.control ~= control then return end
        realtime_sessions[player_id] = nil
        -- Do not overwrite successfully saved changes. An unexpected closure
        -- of an unfinished session should revert the area settings.
        if session.closing ~= "finished" then
            pcall(Net.set_area_custom_property, session.area_id,
                "Ambient_day_night", session.original_mode or "")
            pcall(Net.set_area_custom_property, session.area_id,
                "Ambient_timezone", session.original_timezone or "")
            if session.real_day_time and type(session.real_day_time.refresh_area)=="function" then
                pcall(session.real_day_time.refresh_area, session.area_id)
            end
        end
        pcall(hide_settings_ui, player_id)
    end)

    games.add_ui_element("realtime_settings_board", player_id,
        "/server/assets/hp_manager/board.png", "", "", 80, 43, 20, 2, 2)

    local title = "Real Time Settings"
    local title_width = TextLayout.measureLine(title, {
        font = "THICK",
        scale = 1
    })

    games.draw_text("realtime_settings_title", player_id, title, (240 - title_width) / 2, 50, 150, "THICK", 1)

    -- SETTINGS LIST
    for index in ipairs(realtime_settings) do
        draw_setting(player_id, area_id, index, realtime_sessions[player_id])
    end

    -- CURRENT TIME
    draw_current_time(player_id, realtime_sessions[player_id])

    -- SETTINGS CURSOR
    local setting = realtime_settings[1]

    games.add_ui_element("realtime_settings_cursor", player_id,
        "/server/assets/net-games/cursors/text_cursor.png",
        "/server/assets/net-games/cursors/text_cursor.animation",
        "CURSOR_RIGHT", 89, setting.y + 2, 30, 1, 1)
    return true
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

-- Keep the editor's prospective settings independent of the live area
-- properties for the duration of Async.question_player. The real_daytime
-- module may also update the area's foreground while the question is open.
local function apply_preview(session)
    Net.set_area_custom_property(session.area_id, "Ambient_day_night", session.preview_mode)
    Net.set_area_custom_property(session.area_id, "Ambient_timezone", session.preview_timezone)
    if session.real_day_time and type(session.real_day_time.refresh_area) == "function" then
        session.real_day_time.refresh_area(session.area_id)
    end
end

local function finish_realtime_session(player_id, session, action)
    if realtime_sessions[player_id] ~= session or session.finished then return false end
    session.finished = true
    session.closing = "finished"
    log:info("[Real Time Manager] finishing " .. tostring(action) ..
        " area=" .. tostring(session.area_id) ..
        " mode=" .. tostring(session.preview_mode) ..
        " timezone=" .. tostring(session.preview_timezone))
    local saved = true
    if action == "save" then
        local mode, zone = session.preview_mode, session.preview_timezone
        log:info("[Real Time Manager] save requested area=" .. tostring(session.area_id) ..
            " " .. realtime_description(mode, zone))
        if (mode == "sync" or mode == "cus" or mode == "off") and
            type(zone) == "number" and zone >= -840 and zone <= 840 then
            local previous = realtime_data[session.area_id]
            realtime_data[session.area_id] = {mode = mode, timezone = zone}
            local ok, result = pcall(save_realtime_data)
            log:info("[Real Time Manager] disk write result area=" ..
                tostring(session.area_id) .. " success=" .. tostring(ok and result == true))
            if ok and result then
                local disk, read_error = disk_realtime_record(session.area_id)
                log:info("[Real Time Manager] disk readback area=" .. tostring(session.area_id) ..
                    " " .. (disk and realtime_description(disk.mode, disk.timezone) or "<missing>") ..
                    (read_error and (" error=" .. read_error) or ""))
                log:info("[Real Time Manager] live readback area=" .. tostring(session.area_id) ..
                    " " .. live_realtime_description(session.area_id))
            end
            if not ok or not result then
                saved = false
                realtime_data[session.area_id] = previous
                log:error("[Real Time Manager] unable to persist data for " ..
                    tostring(session.area_id) .. ": " ..
                    tostring(ok and "write failed" or result))
                local rollback_ok, rollback_err = pcall(restore_original_settings, session)
                if not rollback_ok then
                    log:error("[Real Time Manager] rollback failed: " .. tostring(rollback_err))
                end
            end
        else
            saved = false
            log:error("[Real Time Manager] rejected invalid preview state")
            pcall(restore_original_settings, session)
        end
    elseif action == "discard" then
        local ok, err = pcall(restore_original_settings, session)
        if not ok then log:error("[Real Time Manager] reverting failed: " .. tostring(err)) end
    end
    -- Remove every child element, including text, before changing focus.
    local ok, err = pcall(hide_settings_ui, player_id)
    if not ok then log:error("[Real Time Manager] UI cleanup error: " .. tostring(err)) end
    local close_ok, close_err = pcall(function() return session.control:close() end)
    if not close_ok then
        log:error("[Real Time Manager] control cleanup error: " .. tostring(close_err))
    end
    -- Keep the session registered until on_close finishes. Then clear any
    -- remainder before invoking the parent's return callback exactly once.
    if realtime_sessions[player_id] == session then realtime_sessions[player_id] = nil end
    if session.return_to_hp then
        log:debug("[Real Time Manager] handing control back to HP desktop")
        local return_ok, return_err = pcall(session.return_to_hp, player_id)
        if not return_ok then
            log:error("[Real Time Manager] desktop return failed: " .. tostring(return_err))
        end
    end
    return saved
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
                local mode_changed = session.preview_mode ~= session.original_mode
                local timezone_changed = tostring(session.preview_timezone) ~=
                    tostring(tonumber(session.original_timezone) or 0)
                if not mode_changed and not timezone_changed then
                    finish_realtime_session(player_id, session, "unchanged")
                    return
                end
                session.closing = true
                log:info("[Real Time Manager] prompting to save area=" .. tostring(session.area_id))
                local question_ok, question_err = pcall(function()
                    assert(session.control:yield_to_native_ui(),
                        "cannot yield real-time editor focus")
                    hide_settings_ui(player_id)
                    Async.question_player(player_id, "Save changes?").and_then(function(response)
                        if realtime_sessions[player_id] ~= session or session.finished then return end
                        log:debug("[Real Time Manager] save response=" .. tostring(response))
                        local completed, finish_err = pcall(finish_realtime_session,
                            player_id, session, response == 1 and "save" or "discard")
                        if not completed then
                            log:error("[Real Time Manager] save callback failed: " .. tostring(finish_err))
                            pcall(abandon_realtime_editor, player_id)
                            if session.return_to_hp then
                                pcall(session.return_to_hp, player_id)
                            end
                        end
                    end)
                end)
                if not question_ok then
                    log:error("[Real Time Manager] save prompt failure: " .. tostring(question_err))
                    finish_realtime_session(player_id, session, "discard")
                end
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
                    local current_mode = session.preview_mode
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

                    session.preview_mode = time_modes[next_index]

                    -- TIMEZONE
                elseif setting.id == "Timezone" then
                    local new_timezone = math.max(-840,
                        math.min(840, session.preview_timezone + direction * 5))
                    session.preview_timezone = new_timezone
                end

                -- Refresh the foreground immediately for the preview. Save
                -- will persist the same snapshot, not reread live properties.
                apply_preview(session)

                -- UPDATE DISPLAY
                draw_setting(player_id, session.area_id, session.selected, session)
                draw_current_time(player_id, session)
                return
            end
        end
    end
end



-- Shared focus/capture lifecycle; retain the timezone repeat filter in
-- handle_manager_input (0.5 seconds before subsequent timezone repeats).
local realtime_actions = {
    {"Up", "Move Up", false}, {"Down", "Move Down", false},
    {"Left", "Move Left", true}, {"Right", "Move Right", true},
    {"Confirm", "Confirm", false}, {"Cancel", "Cancel", false},
    {"ShoulderL", "Shoulder L", false}, {"ShoulderR", "Shoulder R", false}
}
Net:on("tick", function()
    for pid, session in pairs(realtime_sessions) do
        if session and not session.closing and session.control then
            local ok, err = pcall(function()
                local synthetic=session.control:poll(realtime_actions)
                if synthetic and #synthetic.events > 0 then handle_manager_input(synthetic) end
            end)
            if not ok then
                log:error("[Real Time Manager] input error: " .. tostring(err))
                abandon_realtime_editor(pid)
            end
        end
    end
end)

-- Discard unsaved changes on disconnect and unexpected area transfers.
abandon_realtime_editor = function(player_id)
    local session = realtime_sessions[player_id]
    if not session then return end
    realtime_sessions[player_id] = nil
    pcall(restore_original_settings, session)
    pcall(hide_settings_ui, player_id)
    if session.control then pcall(function() session.control:close() end) end
end
RealtimeManage.abort = abandon_realtime_editor
RealtimeManage.clear_ui = hide_settings_ui
Net:on("player_disconnect", function(event)
    abandon_realtime_editor(event.player_id)
end)
Net:on("player_area_transfer", function(event)
    abandon_realtime_editor(event.player_id)
end)

-- CURSOR ANIMATION
Net:on("tick", function(event)
    if #realtime_settings == 0 then return end

    for player_id, session in pairs(realtime_sessions) do
        local ok, err = pcall(function()
        if session.closing then return end
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
        end)
        if not ok then
            log:error("[Real Time Manager] animation error: " .. tostring(err))
            abandon_realtime_editor(player_id)
        end
    end
end)

return RealtimeManage