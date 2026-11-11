--[[
* ---------------------------------------------------------- *
                  Background Manager
* ---------------------------------------------------------- *
]]

local games = require("scripts/net-games/main")
local PlayerControl = require("scripts/player-control/main")
local log = require("scripts/logger/logger").register("hp_manager"):register_subsystem("background")
local TextLayout = require("scripts/displayer/text-layout")

local BackgroundManage = {}

local background_sessions = {}
local abandon_background_editor

local constants = require("scripts/hp_manager/constants/constants")

local background_data = {}
local background_data_file = "scripts/hp_manager/data/background_data.dat"

-- The packaged files are under assets/Backgrounds (capital B).
-- Normalize historical case variants before handing paths to clients.
local function canonical_background_asset_path(path)
    if type(path) ~= "string" then return path end
    local normalized = path:gsub("\\", "/")
    local prefix = "/server/assets/backgrounds/"
    if normalized:sub(1, #prefix):lower() == prefix then
        return constants.background_asset_folder .. normalized:sub(#prefix + 1)
    end
    return normalized
end

local provided_assets = {}
local function provide_background_assets(area_id, texture_path, animation_path)
    local supplied = provided_assets[area_id]
    if not supplied then
        supplied = {}
        provided_assets[area_id] = supplied
    end
    for _, path in ipairs({texture_path, animation_path}) do
        if type(path) == "string" and path ~= "" and not supplied[path] then
            local ok, err = pcall(Net.provide_asset, area_id, path)
            if ok then
                supplied[path] = true
                log:debug("[Background Manager] provided asset area=" ..
                    tostring(area_id) .. " path=" .. path)
            else
                log:warn("[Background Manager] asset provision failed area=" ..
                    tostring(area_id) .. " path=" .. path .. " error=" .. tostring(err))
            end
        end
    end
end

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

-- Source-of-truth diagnostics: disk and live engine state are deliberately
-- read independently of the editor's in-memory preview.
local function background_description(data)
    if not data then return "<missing>" end
    return "texture=" .. tostring(data.texture_path) ..
        " animation=" .. tostring(data.animation_path) ..
        " velocity_x=" .. tostring(data.velocity_x) ..
        " velocity_y=" .. tostring(data.velocity_y) ..
        " parallax=" .. tostring(data.parallax)
end

local function disk_background_record(area_id)
    local file, err = io.open(background_data_file, "r")
    if not file then return nil, "cannot read " .. background_data_file .. ": " .. tostring(err) end
    local result
    for line in file:lines() do
        local area, texture, animation, vx, vy, parallax =
            line:match("^(.-)\t(.-)\t(.-)\t(.-)\t(.-)\t(.-)$")
        if area == area_id then
            result = {
                texture_path = texture, animation_path = animation,
                velocity_x = tonumber(vx), velocity_y = tonumber(vy),
                parallax = tonumber(parallax)
            }
            break
        end
    end
    file:close()
    if not result then return nil, "no saved record for " .. tostring(area_id) end
    return result
end

local function live_background_description(area_id)
    local ok, bg, velocity, parallax = pcall(function()
        return Net.get_background(area_id), Net.get_background_velocity(area_id),
            Net.get_background_parallax(area_id)
    end)
    if not ok then return "<read error: " .. tostring(bg) .. ">" end
    if not bg or not velocity then return "<unavailable>" end
    return background_description({
        texture_path = bg.texture_path, animation_path = bg.animation_path,
        velocity_x = velocity.x, velocity_y = velocity.y, parallax = parallax
    })
end

-- BACKGROUND DATA LOAD
local function load_background_data()
    local file = io.open(background_data_file, "r")

    if file == nil then
        file = io.open(background_data_file .. ".bak", "r")
    end

    if file == nil then
        log:debug("[Background Manager] no background persistence file at " .. background_data_file)
        return
    end

    for line in file:lines() do
        local area_id, texture_path, animation_path, velocity_x, velocity_y, parallax =
            line:match("^(.-)\t(.-)\t(.-)\t(.-)\t(.-)\t(.-)$")

        velocity_x = tonumber(velocity_x)
        velocity_y = tonumber(velocity_y)
        parallax = tonumber(parallax)

        if area_id ~= nil and texture_path ~= nil and
            velocity_x ~= nil and velocity_y ~= nil and parallax ~= nil then
            background_data[area_id] = {
                texture_path = canonical_background_asset_path(texture_path),
                animation_path = canonical_background_asset_path(animation_path),
                velocity_x = velocity_x,
                velocity_y = velocity_y,
                parallax = parallax
            }
            log:info("[Background Manager] loaded area=" .. tostring(area_id) .. " " ..
                background_description(background_data[area_id]))
        end
    end

    file:close()
end

-- BACKGROUND DATA SAVE
local function save_background_data()
    local temp_file = background_data_file .. ".tmp"
    local backup_file = background_data_file .. ".bak"
    -- Write and close the replacement fully before touching the old file.
    -- Binary mode preserves literal newlines on Windows for exact byte readback.
    local file, open_err = io.open(temp_file, "wb")
    if not file then
        log:error("[Background Manager] temporary save open failed: " .. tostring(open_err))
        return false
    end
    local written_lines = {}
    local ok, err = pcall(function()
        local area_ids = {}
        for area_id in pairs(background_data) do area_ids[#area_ids + 1] = area_id end
        table.sort(area_ids)
        for _, area_id in ipairs(area_ids) do
            local data = background_data[area_id]
            local line = area_id .. "\t" .. tostring(data.texture_path or "") .. "\t" ..
                tostring(data.animation_path or "") .. "\t" ..
                tostring(data.velocity_x) .. "\t" ..
                tostring(data.velocity_y) .. "\t" ..
                tostring(data.parallax) .. "\n"
            written_lines[#written_lines + 1] = line
            assert(file:write(line))
        end
    end)
    local closed, close_err = file:close()
    if not ok or not closed then
        os.remove(temp_file)
        log:error("[Background Manager] save write failed: " .. tostring(ok and close_err or err))
        return false
    end

    local old_file = io.open(background_data_file, "r")
    local had_old = old_file ~= nil
    if old_file then
        old_file:close()
        os.remove(backup_file)
        local moved, move_err = os.rename(background_data_file, backup_file)
        if not moved then
            os.remove(temp_file)
            log:error("[Background Manager] backup failed: " .. tostring(move_err))
            return false
        end
    end
    local moved, move_err = os.rename(temp_file, background_data_file)
    if not moved then
        -- Preserve the previously persisted file whenever the replacement
        -- cannot be installed (especially on Windows).
        os.rename(backup_file, background_data_file)
        os.remove(temp_file)
        log:error("[Background Manager] commit failed: " .. tostring(move_err))
        return false
    end
    -- Verify the committed bytes before deleting the last known-good copy.
    local verify_file, verify_err = io.open(background_data_file, "rb")
    local actual
    if verify_file then
        actual = verify_file:read("*a")
        verify_file:close()
    end
    if actual ~= table.concat(written_lines) then
        log:error("[Background Manager] committed file readback failed path=" ..
            background_data_file .. " reason=" .. tostring(verify_err or "content mismatch"))
        os.remove(background_data_file)
        if had_old then
            local restored, restore_err = os.rename(backup_file, background_data_file)
            if not restored then log:error("[Background Manager] backup restore failed: " .. tostring(restore_err)) end
        end
        return false
    end
    os.remove(backup_file)
    log:info("[Background Manager] persisted " .. tostring(#written_lines) ..
        " area record(s) to " .. background_data_file .. " (verified readback)")
    return true
end

-- CHECK BACKGROUND ASSET
local function background_asset_exists(asset_path)
    asset_path = canonical_background_asset_path(asset_path)
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
                provide_background_assets(area_id, data.texture_path, data.animation_path)
                Net.set_background(area_id, data.texture_path, data.animation_path,
                    data.velocity_x, data.velocity_y, data.parallax)
                log:info("[Background Manager] startup apply area=" .. tostring(area_id) ..
                    " requested=" .. background_description(data))
                log:debug("[Background Manager] startup live area=" .. tostring(area_id) ..
                    " " .. live_background_description(area_id))
            else
                -- Keep the stored choice intact: a missing mounted asset or a
                -- temporarily unavailable disk must not destroy user settings.
                log:warn("[Background Manager] Missing saved background asset area=" ..
                    tostring(area_id) .. " texture=" .. tostring(data.texture_path) ..
                    " animation=" .. tostring(data.animation_path) ..
                    "; leaving persisted selection untouched and using map background")
            end
        end
    end

end

load_background_data()
apply_background_data()

-- Remove every resource regardless of the screen the editor was in when it
-- closed. The old screen-dependent cleanup could leave the bottom selection
-- strip behind if a native save prompt interrupted a screen transition.
local function hide_background_manage_ui(player_id, session)
    local function remove(kind, id)
        local ok, err
        if kind == "text" then
            ok, err = pcall(games.remove_text, id, player_id)
        else
            ok, err = pcall(games.remove_ui_element, id, player_id)
        end
        if not ok then
            log:error("[Background Manager] failed to remove " .. kind .. " " .. id .. ": " .. tostring(err))
        end
    end

    remove("text", "background_manager_name")
    remove("text", "background_settings_title")
    for index = 1, #background_settings do
        remove("text", "background_setting_" .. index)
    end
    for _, cursor in ipairs(background_cursors) do
        remove("sprite", cursor.id)
    end
    for _, id in ipairs({"board", "settings_cursor", "word_bar", "lb", "rb"}) do
        remove("sprite", id)
    end
end

-- Keep the editor's prospective background independent of Net.get_background.
-- A native dialog or another area operation may change the engine's live
-- background before the asynchronous save callback runs.
local function copy_background(bg)
    return {
        texture_path = canonical_background_asset_path(bg.texture_path),
        animation_path = canonical_background_asset_path(bg.animation_path)
    }
end

local function set_session_background(session, background)
    provide_background_assets(session.area_id,
        background.texture_path, background.animation_path)
    Net.set_background(session.area_id,
        background.texture_path, background.animation_path,
        session.velocity.x, session.velocity.y, session.parallax)
end

local function restore_original_background(session)
    local original = session.original_background
    provide_background_assets(session.area_id,
        original.texture_path, original.animation_path)
    Net.set_background(session.area_id,
        original.texture_path, original.animation_path,
        session.original_velocity.x, session.original_velocity.y,
        session.original_parallax)
end

-- This is the only normal completion path (unchanged/save/discard). Keep the
-- session registered until its close callback has cleaned up any residual UI.
local function finish_background_session(player_id, session, action)
    if background_sessions[player_id] ~= session or session.finished then return false end
    session.finished = true
    session.closing = "finished"
    local saved = true
    log:info("[Background Manager] finishing " .. tostring(action) ..
        " for area=" .. tostring(session.area_id))

    if action == "save" then
        local requested = {
            texture_path = session.preview_background.texture_path,
            animation_path = session.preview_background.animation_path,
            velocity_x = session.velocity.x, velocity_y = session.velocity.y,
            parallax = session.parallax
        }
        log:info("[Background Manager] save requested area=" .. tostring(session.area_id) ..
            " " .. background_description(requested))
        local previous = background_data[session.area_id]
        background_data[session.area_id] = {
            texture_path = session.preview_background.texture_path,
            animation_path = session.preview_background.animation_path,
            velocity_x = session.velocity.x,
            velocity_y = session.velocity.y,
            parallax = session.parallax
        }
        local ok, result = pcall(save_background_data)
        log:info("[Background Manager] disk write result area=" .. tostring(session.area_id) ..
            " success=" .. tostring(ok and result == true))
        if ok and result then
            local disk, read_error = disk_background_record(session.area_id)
            log:info("[Background Manager] disk readback area=" .. tostring(session.area_id) ..
                " " .. background_description(disk) ..
                (read_error and (" error=" .. read_error) or ""))
            log:info("[Background Manager] live readback area=" .. tostring(session.area_id) ..
                " " .. live_background_description(session.area_id))
        end
        if not ok or not result then
            saved = false
            background_data[session.area_id] = previous
            log:error("[Background Manager] could not persist changes for " ..
                tostring(session.area_id) .. ": " .. tostring(ok and "write failed" or result))
            local revert_ok, revert_err = pcall(restore_original_background, session)
            if not revert_ok then
                log:error("[Background Manager] restoring failed save: " .. tostring(revert_err))
            end
        end
    elseif action == "discard" then
        local ok, err = pcall(restore_original_background, session)
        if not ok then log:error("[Background Manager] reverting changes failed: " .. tostring(err)) end
    end

    hide_background_manage_ui(player_id, session)
    local close_ok, close_err = pcall(function() return session.control:close() end)
    if not close_ok then
        log:error("[Background Manager] control close failed: " .. tostring(close_err))
    end
    -- The on_close callback normally removes this entry. This assignment
    -- also covers failure during session disposal.
    if background_sessions[player_id] == session then
        background_sessions[player_id] = nil
    end
    if session.return_to_hp then
        log:debug("[Background Manager] handing control back to HP desktop")
        local ok, err = pcall(session.return_to_hp, player_id)
        if not ok then log:error("[Background Manager] returning to desktop failed: " .. tostring(err)) end
    end
    return saved
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
function BackgroundManage.open(player_id, return_to_hp, options)
    if background_sessions[player_id] then return false, "background editor already open" end
    local area_id = Net.get_player_area(player_id)
    local backgrounds = find_backgrounds()

    if #backgrounds == 0 then
        Net.message_player(player_id, "No backgrounds found in assets/backgrounds.")

        if return_to_hp ~= nil and not (options and options.parent) then
            pcall(return_to_hp, player_id)
        end

        return false, "no backgrounds found"
    end

    local current_background = Net.get_background(area_id)
    local velocity = Net.get_background_velocity(area_id)
    local parallax = Net.get_background_parallax(area_id)
    if not current_background or type(current_background.texture_path) ~= "string"
       or not velocity or type(velocity.x) ~= "number" or type(velocity.y) ~= "number"
       or type(parallax) ~= "number" then
        log:error("[Background Manager] area background state unavailable for " .. tostring(area_id))
        return false, "area background unavailable"
    end

    local current_file = current_background.texture_path:match("([^/\\]+)$") or ""
    local selected = 0

    -- FIND CURRENT BACKGROUND
    for index, background in ipairs(backgrounds) do
        if background.file_name:lower() == current_file:lower() then
            selected = index
            break
        end
    end

    options = options or {}
    local control, control_err = PlayerControl.begin(player_id, {
        owner="hp_manager:background", profile="settings_menu",
        parent=options.parent
    })
    if not control then
        log:warn("[Background Manager] " .. tostring(control_err))
        if return_to_hp and not options.parent then pcall(return_to_hp, player_id) end
        return false, control_err
    end
    log:info("[Background Manager] opening editor area=" .. tostring(area_id) ..
        " textures=" .. tostring(#backgrounds))
    log:debug("[Background Manager] editor opened live area=" .. tostring(area_id) ..
        " " .. live_background_description(area_id))
    background_sessions[player_id] = {
        control = control,
        area_id = area_id,
        backgrounds = backgrounds,
        selected = selected,

        original_background = copy_background(current_background),
        preview_background = copy_background(current_background),
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
    control:on_close(function()
        local session = background_sessions[player_id]
        if not session or session.control ~= control then return end
        background_sessions[player_id] = nil
        -- Save callbacks remove the session before normal close. Revert only
        -- when an external failure/disconnect disposes an unfinished editor.
        if session.closing ~= "finished" then
            local ok, err = pcall(restore_original_background, session)
            if not ok then log:error("[Background Manager] cleanup restore failed: " .. tostring(err)) end
        end
        pcall(hide_background_manage_ui, player_id, session)
    end)

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
    return true
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

                    -- Keep the background name visible while editing settings.
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
                        local current_file = session.preview_background.texture_path:match("([^/\\]+)$") or ""
                        name = current_file:gsub("%.[^%.]+$", "") .. " [Current]"
                    end

                    local text_width = TextLayout.measureLine(name, { font = "THICK", scale = 2 })
                    local text_x = (240 - text_width) / 2

                    games.remove_text("background_manager_name", player_id)
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

                session.preview_background = copy_background(background)
                set_session_background(session, session.preview_background)

                local text_width = TextLayout.measureLine(background.name, { font = "THICK", scale = 2 })
                local text_x = (240 - text_width) / 2

                games.remove_text("background_manager_name", player_id)
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

                    set_session_background(session, session.preview_background)

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
                local preview = session.preview_background
                local original = session.original_background
                local background_changed =
                    preview.texture_path ~= original.texture_path or
                    preview.animation_path ~= original.animation_path
                local velocity_changed =
                    math.abs(session.velocity.x - session.original_velocity.x) > 0.0001 or
                    math.abs(session.velocity.y - session.original_velocity.y) > 0.0001
                local parallax_changed =
                    math.abs(session.parallax - session.original_parallax) > 0.0001

                if not (background_changed or velocity_changed or parallax_changed) then
                    finish_background_session(player_id, session, "unchanged")
                    return
                end

                -- Native UI needs to receive the answer. Keep the capture
                -- lease alive, but stop editor polling and erase every sprite
                -- BEFORE opening the engine's question dialog.
                session.closing = true
                log:info("[Background Manager] prompting to save background for " .. tostring(session.area_id))
                local ok, err = pcall(function()
                    assert(session.control:yield_to_native_ui(), "cannot yield background editor focus")
                    hide_background_manage_ui(player_id, session)
                    Async.question_player(player_id, "Save changes?").and_then(function(response)
                        if background_sessions[player_id] ~= session or session.finished then return end
                        log:debug("[Background Manager] save dialog response=" .. tostring(response))
                        local completed, finish_err = pcall(finish_background_session,
                            player_id, session, response == 1 and "save" or "discard")
                        if not completed then
                            log:error("[Background Manager] save callback failed: " .. tostring(finish_err))
                            pcall(abandon_background_editor, player_id)
                            if session.return_to_hp then
                                pcall(session.return_to_hp, player_id)
                            end
                        end
                    end)
                end)
                if not ok then
                    log:error("[Background Manager] could not open save prompt: " .. tostring(err))
                    finish_background_session(player_id, session, "discard")
                end
                return
            end
        end
    end
end



-- The parent desktop retains capture; the foreground editor owns focus.
local background_actions = {
    {"Up", "Move Up", false}, {"Down", "Move Down", false},
    {"Left", "Move Left", true}, {"Right", "Move Right", true},
    {"Confirm", "Confirm", false}, {"Cancel", "Cancel", false},
    {"ShoulderL", "Shoulder L", false}, {"ShoulderR", "Shoulder R", false}
}
Net:on("tick", function()
    for pid, session in pairs(background_sessions) do
        if session and not session.closing and session.control then
            local ok, err = pcall(function()
                local synthetic=session.control:poll(background_actions)
                if synthetic and #synthetic.events > 0 then handle_manager_input(synthetic) end
            end)
            if not ok then
                log:error("[Background Manager] input error: " .. tostring(err))
                abandon_background_editor(pid)
            end
        end
    end
end)

-- Cleanup is shared by disconnect and unexpected area transfers.
abandon_background_editor = function(player_id)
    local session = background_sessions[player_id]
    if not session then return end
    background_sessions[player_id] = nil
    local ok, err = pcall(restore_original_background, session)
    if not ok then log:error("[Background Manager] abort restore failed: " .. tostring(err)) end
    hide_background_manage_ui(player_id, session)
    if session.control then pcall(function() session.control:close() end) end
end
BackgroundManage.abort = abandon_background_editor
-- Used by the parent desktop to clear stale client overlay elements before
-- drawing its home screen after a native dialog handoff.
BackgroundManage.clear_ui = hide_background_manage_ui
Net:on("player_disconnect", function(event)
    abandon_background_editor(event.player_id)
end)
Net:on("player_area_transfer", function(event)
    abandon_background_editor(event.player_id)
end)

-- CURSOR ANIMATION
Net:on("tick", function(event)
    for player_id, session in pairs(background_sessions) do
        local ok, err = pcall(function()
        if not session.closing and session.screen == "background" then
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
        end)
        if not ok then
            log:error("[Background Manager] animation error: " .. tostring(err))
            abandon_background_editor(player_id)
        end
    end
end)

return BackgroundManage
