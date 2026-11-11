-- Avoid duplicate Net:on registrations if this script is loaded through
-- multiple server entrypoints in the same Lua environment.
if rawget(_G, "__hp_manager_main_initialized") then
  return rawget(_G, "__hp_manager_main_initialized")
end

--[[
* ---------------------------------------------------------- *
                 HP_Manager v0.1 by Darkware
	 github link

  - this require net-games by indianajson
  https://github.com/indianajson/net-games
* ---------------------------------------------------------- *
]]

--DEPENDENCES
local games = require("scripts/net-games/main")
local PlayerControl = require("scripts/player-control/main")
local log = require("scripts/logger/logger").register("hp_manager"):register_subsystem("desktop")
local TextLayout = require("scripts/displayer/text-layout")
--MANAGERS
local WarpManage = require("scripts/hp_manager/warp_manage")
local BackgroundManage = require("scripts/hp_manager/background_manage")
local RealtimeManage = require("scripts/hp_manager/realtime_manage")
--CONFIG FILE
local constants = require("scripts/hp_manager/constants/constants")

local hp_sessions = {}
local desktop_control = {}

-- A native save dialog may deliver a late Confirm/Cancel packet after its
-- callback. A returning desktop is deliberately less eager than a fresh one.
local INITIAL_SETTLE_SECONDS = 0.20
local RETURN_SETTLE_SECONDS = 0.40
local RETURN_SWALLOW_SECONDS = 0.35

local desktop_options = {
  {
    id = "exit",
    label = "Exit",
    x = 112,
    y = 145,
  },
  {
    id = "warp",
    label = "Warp Manager",
    x = 36,
    y = 30,
  },
  {
    id = "background",
    label = "Background Manager",
    x = 86,
    y = 30,
  }
}

-- OPTIONAL DESKTOP ICONS
local optional_icons = {
  {
    id = "real_daytime",
    label = "Real Time Manager",
    path = constants.real_day_time,
    load_module = true,
    icon = "/server/assets/hp_manager/realtime_icon.png",
    x = 136,
    y = 30,
  },
  {
    id = "jukebox",
    label = "Music Manager",
    path = constants.jukebox,
    load_module = true,
    icon = "/server/assets/hp_manager/music_icon.png",
    x = 186,
    y = 30,
  }
}

local extensions = {}

-- ADD AVAILABLE EXTENSIONS
local function add_desktop_icons()
  for _, option in ipairs(optional_icons) do
    option.enabled = type(option.path) == "string"
        and option.path ~= ""
        and file_exists(option.path)

    if option.enabled then
      desktop_options[#desktop_options + 1] = option

      if option.load_module then
        local path = option.path:gsub("%.lua$", "")
        local ok, mod = pcall(require, path)
        if ok then
          extensions[option.id] = mod
        else
          log:error("[HP_Manager] failed to load module " ..
            tostring(option.id) .. " at " .. tostring(path) ..
            ": " .. tostring(mod))
        end
      end
    end
  end
end

add_desktop_icons()

-- CURSOR POSITION
for _, option in ipairs(desktop_options) do
  option.cursor_x = option.x - 2
  option.cursor_y = option.y + 8
end

local desktop_options_by_id = {}
local desktop_option_indexes = {}

for index, option in ipairs(desktop_options) do
  desktop_options_by_id[option.id] = option
  desktop_option_indexes[option.id] = index
end

-- DRAW MANAGER NAME
local option_label_y = 6
local option_label_font = "THICK"
local option_label_scale = 1

local function draw_option_name(player_id, option)
  local text_width = TextLayout.measureLine(option.label, { font = option_label_font, scale = option_label_scale })
  local text_x = (240 - text_width) / 2

  games.remove_text("hp_option_name", player_id)
  games.draw_text("hp_option_name", player_id, option.label, text_x, option_label_y, 30, option_label_font,
    option_label_scale)
end

local desktop_elements = {
  "hp_selector",
  "hp_warp_icon",
  "hp_background_icon",
  "hp_emblem",
  "hp_border",
  "hp_wallpaper",
}

-- REGISTER OPTIONAL ELEMENTS
for _, option in ipairs(desktop_options) do
  if option.icon then
    desktop_elements[#desktop_elements + 1] =
        "hp_" .. option.id .. "_icon"
  end
end

-- SERVER OPERATIONAL SYSTEM GET + WALLPAPER CHOICE
local function get_server_os()
  local separator = package.config:sub(1, 1)

  if separator == "\\" then
    return "windows"
  end

  if io ~= nil and io.popen ~= nil then
    local handle = io.popen("uname -s 2>/dev/null")

    if handle ~= nil then
      local system = handle:read("*l") or ""

      handle:close()

      system = system:lower()

      if system:find("darwin", 1, true) then
        return "macos"
      end

      if system:find("linux", 1, true) then
        return "linux"
      end
    end
  end

  return "unix"
end

local system_wallpaper = {
  windows = "/server/assets/hp_manager/Wallpapers/windows_wallpaper.png",
  linux = "/server/assets/hp_manager/Wallpapers/linux_wallpaper.png",
  macos = "/server/assets/hp_manager/Wallpapers/macos_wallpaper.png",
  unix = "/server/assets/hp_manager/Wallpapers/linux_wallpaper.png"
}

local server_os = get_server_os()
local wallpaper = system_wallpaper[server_os] or system_wallpaper.windows

--HP MANAGER CLOSE
local function close_hp_manage(player_id)
  for _, element in ipairs(desktop_elements) do
    games.remove_ui_element(element, player_id)
  end

  games.remove_text("hp_option_name", player_id)
end

-- HP MANAGER OPEN
local function open_hp_manager(player_id, selected_id)
    if hp_sessions[player_id] then return true end
    local control = desktop_control[player_id]
    if selected_id == nil and control and control:is_alive() then
        return false -- already open or a child interaction is in progress
    end
    -- Only interaction with the world object may create a new root session.
    -- A late return callback after an area transfer must never reopen a UI.
    if selected_id ~= nil and (not control or not control:is_alive()) then
        return false
    end
    if not control or not control:is_alive() then
        local err
        control, err = PlayerControl.begin(player_id, {
            owner = "hp_manager:desktop", profile = "desktop",
            handoff_free_camera = true
        })
        if not control then
            log:error("[HP_Manager] cannot capture input: " .. tostring(err))
            return false
        end
        desktop_control[player_id] = control
        control:on_close(function()
          -- Unexpected PlayerControl disposal must not leave a ghost desktop.
          if desktop_control[player_id] == control then
            desktop_control[player_id] = nil
            hp_sessions[player_id] = nil
            pcall(close_hp_manage, player_id)
          end
        end)
        control.area_id = Net.get_player_area(player_id)
    end
    if control.area_id ~= Net.get_player_area(player_id) then
        control:close()
        desktop_control[player_id] = nil
        return false
    end
    local initial_open = selected_id == nil
    selected_id = selected_id or "exit"

    local selected = desktop_option_indexes[selected_id] or desktop_option_indexes["exit"]

    hp_sessions[player_id] = {
        selected = selected,
        control = control,
        cursor_timer = 0,
        cursor_offset = 0,
        input_delay = initial_open and INITIAL_SETTLE_SECONDS or RETURN_SETTLE_SECONDS
    }


  local exit_option = desktop_options_by_id["exit"]
  local warp_option = desktop_options_by_id["warp"]
  local background_option = desktop_options_by_id["background"]
  local selected_option = desktop_options[selected]

  games.add_ui_element("hp_wallpaper", player_id, wallpaper, "", "", 0, 0, 0, 2, 2)
  games.add_ui_element("hp_border", player_id, "/server/assets/hp_manager/border.png", "", "", 0, 0, 10, 2, 2)

  -- ICONS
  games.add_ui_element("hp_emblem", player_id, "/server/assets/hp_manager/emblem.png", "", "", exit_option.x,
    exit_option.y, 15, 2, 2)
  games.add_ui_element("hp_warp_icon", player_id, "/server/assets/hp_manager/warp_icon.png", "", "", warp_option.x,
    warp_option.y, 15, 2, 2)
  games.add_ui_element("hp_background_icon", player_id, "/server/assets/hp_manager/background_icon.png", "", "",
    background_option.x, background_option.y, 15, 2, 2)

  -- DRAW OPTIONAL ICONS
  for _, option in ipairs(desktop_options) do
    if option.icon then
      games.add_ui_element(
        "hp_" .. option.id .. "_icon",
        player_id,
        option.icon, "", "",
        option.x, option.y, 15, 2, 2
      )
    end
  end

  -- CURSOR
  games.add_ui_element("hp_selector", player_id, "/server/assets/net-games/cursors/text_cursor.png",
    "/server/assets/net-games/cursors/text_cursor.animation", "CURSOR_RIGHT",
    selected_option.cursor_x, selected_option.cursor_y, 30, 2, 2)

  -- OPTION NAME
  draw_option_name(player_id, selected_option)
  return true
end

-- If UI construction fails halfway through, close the managed capture and
-- remove any partial sprites so the HP Manager object can be used again.
local function safe_open_hp_manager(player_id, selected_id)
  local ok, result = pcall(open_hp_manager, player_id, selected_id)
  if ok then return result end
  log:error("[HP_Manager] opening desktop failed: " .. tostring(result))
  pcall(close_hp_manage, player_id)
  hp_sessions[player_id] = nil
  local control = desktop_control[player_id]
  desktop_control[player_id] = nil
  if control then pcall(function() control:close() end) end
  return false
end

-- A native question resolves before the previous UI frame is guaranteed to
-- disappear on the client. Resume on a later turn of the existing Async loop,
-- and refuse callbacks from an expired player/area/desktop interaction.
local function resume_desktop(player_id, option_id, expected_control, after_resume)
  local function resume()
    if desktop_control[player_id] ~= expected_control or
       not expected_control or not expected_control:is_alive() then
      log:debug("[HP_Manager] stale " .. tostring(option_id) .. " return ignored")
      return
    end
    if expected_control.area_id ~= Net.get_player_area(player_id) then return end
    -- Both editor modules expose idempotent UI erasure. A late native UI
    -- update must not leave an old child panel on top of the desktop.
    if option_id == "background" then
      pcall(BackgroundManage.clear_ui, player_id)
    elseif option_id == "real_daytime" then
      pcall(RealtimeManage.clear_ui, player_id)
    end
    local opened = safe_open_hp_manager(player_id, option_id)
    if opened then
      -- The native question's response can race with the first desktop
      -- input poll. Clear any queued edges and require a fresh press before
      -- the returned desktop may open another child. This is deliberately
      -- limited to this player and this still-active parent session.
      local current = hp_sessions[player_id]
      if current and current.control == expected_control then
        current.input_delay = RETURN_SETTLE_SECONDS
        local guard_ok, guard_err = pcall(function()
          -- PlayerControl centralizes the post-native-dialog release/edge
          -- guard. Keep HP Manager's proven timing values unchanged.
          local guarded, reason=expected_control:guard_input(RETURN_SWALLOW_SECONDS,
            {"Confirm", "Cancel", "Up", "Down", "Left", "Right", "ShoulderL", "ShoulderR"})
          if not guarded then error(tostring(reason)) end
        end)
        if not guard_ok then
          log:warn("[HP_Manager] desktop input rearm failed: " .. tostring(guard_err))
        end
      end
      log:debug("[HP_Manager] desktop return input settled from " .. tostring(option_id) ..
        " for " .. tostring(RETURN_SETTLE_SECONDS) .. "s")
      log:info("[HP_Manager] resumed desktop after " .. tostring(option_id))
    else
      log:error("[HP_Manager] unable to resume desktop after " .. tostring(option_id))
    end
    if after_resume then
      local ok, err = pcall(after_resume, player_id)
      if not ok then log:error("[HP_Manager] post-return failed: " .. tostring(err)) end
    end
  end
  local function guarded_resume()
    local ok, err = pcall(resume)
    if not ok then
      log:error("[HP_Manager] desktop resume exception: " .. tostring(err))
      if desktop_control[player_id] == expected_control then
        -- A broken UI render must never keep an invisible input owner alive.
        hp_sessions[player_id] = nil
        desktop_control[player_id] = nil
        pcall(close_hp_manage, player_id)
        pcall(function() expected_control:close() end)
      end
    end
  end
  local ok, err = pcall(function()
    Async.sleep(0.08).and_then(guarded_resume)
  end)
  if not ok then
    log:error("[HP_Manager] deferring desktop resume failed: " .. tostring(err))
    guarded_resume()
  end
end

local function launch_child(player_id, option_id, callback, abort_child)
  local ok, result, detail = pcall(callback)
  if not ok or result == false then
    log:error("[HP_Manager] " .. tostring(option_id) .. " failed to open: " ..
      tostring(ok and detail or result))
    -- A child may have acquired focus before an asset/UI operation failed.
    -- Dispose it before restoring desktop focus.
    if abort_child then
      local abort_ok, abort_err = pcall(abort_child, player_id)
      if not abort_ok then log:error("[HP_Manager] child abort failed: " .. tostring(abort_err)) end
    end
    if not safe_open_hp_manager(player_id, option_id) then
      -- If the child left behind a context, close the parent rather than
      -- leaving a frozen desktop with an invisible active input owner.
      local c = desktop_control[player_id]
      if c then pcall(function() c:close() end) end
      desktop_control[player_id] = nil
      hp_sessions[player_id] = nil
    end
    return false
  end
  return true
end

-- HP MANAGER INPUT
local function handle_manager_input(event)
  local player_id = event.player_id
  local session = hp_sessions[player_id]

if session == nil or session.input_delay > 0 then return end

  for _, button in next, event.events do
    if button.state == 1 or button.state == 2 then
      local new_selection = nil

      -- OPTION NAVIGATION
      if button.name == "Move Up" or button.name == "Move Right" then
        new_selection = session.selected % #desktop_options + 1
      elseif button.name == "Move Down" or button.name == "Move Left" then
        new_selection = (session.selected - 2) % #desktop_options + 1
      end

      -- CHANGE OPTION
      if new_selection ~= nil and new_selection ~= session.selected then
        session.selected = new_selection
        session.cursor_offset = 0

        local option = desktop_options[session.selected]

        games.update_ui_element("hp_selector", player_id, {
          x = option.cursor_x,
          y = option.cursor_y,
          z = 30
        })

        draw_option_name(player_id, option)
      end


      -- EXIT IN CANCEL BUTTON
      if button.name == "Cancel" then
        local exit_index = desktop_option_indexes["exit"]

        -- ALREADY ON EXIT
        if session.selected == exit_index then
          close_hp_manage(player_id)

          hp_sessions[player_id] = nil

          if desktop_control[player_id] then
              desktop_control[player_id]:close()
              desktop_control[player_id] = nil
          end

          return
        end

        -- MOVE TO EXIT
        session.selected = exit_index
        session.cursor_offset = 0

        local option = desktop_options_by_id["exit"]

        games.update_ui_element("hp_selector", player_id, {
          x = option.cursor_x,
          y = option.cursor_y,
          z = 30
        })

        draw_option_name(player_id, option)

        return
      end

      -- OPTION SELECT
      if button.name == "Confirm" or button.name == "Interact" then
        local option = desktop_options[session.selected]

        if option ~= nil then
          -- EXIT
          if option.id == "exit" then
            close_hp_manage(player_id)

            hp_sessions[player_id] = nil

            if desktop_control[player_id] then
              desktop_control[player_id]:close()
              desktop_control[player_id] = nil
          end

            return
          end

          -- WARP MANAGER
          if option.id == "warp" then
            local expected_control = desktop_control[player_id]
            hp_sessions[player_id] = nil

            Net.fade_player_camera(player_id, { r = 0, g = 0, b = 0, a = 255 }, 0.05)

            Async.sleep(0.05).and_then(function()
              if desktop_control[player_id] ~= expected_control or
                 not expected_control or not expected_control:is_alive() then return end
              close_hp_manage(player_id)

              launch_child(player_id, option.id, function()
                return WarpManage.open(player_id, function(pid)
                  resume_desktop(pid, option.id, expected_control, function(p)
                    Net.fade_player_camera(p, { r = 0, g = 0, b = 0, a = 0 }, 0.05)
                  end)
                end, { parent = expected_control })
              end, WarpManage.abort)
            end)

            return
          end

          -- BACKGROUND MANAGER
          if option.id == "background" then
            local expected_control = desktop_control[player_id]
            hp_sessions[player_id] = nil

            Async.sleep(0.05).and_then(function()
              if desktop_control[player_id] ~= expected_control or
                 not expected_control or not expected_control:is_alive() then return end
              close_hp_manage(player_id)

              launch_child(player_id, option.id, function()
                return BackgroundManage.open(player_id, function(pid)
                  resume_desktop(pid, option.id, expected_control)
                end, { parent = expected_control })
              end, BackgroundManage.abort)
            end)

            return
          end

          -- REAL DAY TIME MANAGER
          if option.id == "real_daytime" then
            local expected_control = desktop_control[player_id]
            hp_sessions[player_id] = nil

            Async.sleep(0.05).and_then(function()
              if desktop_control[player_id] ~= expected_control or
                 not expected_control or not expected_control:is_alive() then return end
              close_hp_manage(player_id)

              launch_child(player_id, option.id, function()
                return RealtimeManage.open(player_id, function(pid)
                  resume_desktop(pid, option.id, expected_control)
                end, extensions.real_daytime, { parent = expected_control })
              end, RealtimeManage.abort)
            end)

            return
          end

          -- JUKEBOX / MUSIC MANAGER
          --
          -- Uses the jukebox module's public open() API. The jukebox owns its
          -- own UI (spawn, input loop, teardown) and calls back once the
          -- player has closed it. HP_Manager never manipulates the jukebox
          -- internals or creates fake objects.
          if option.id == "jukebox" then
            local expected_control = desktop_control[player_id]
            local jukebox_module = extensions.jukebox
            if not jukebox_module or type(jukebox_module.open) ~= "function" then
              log:warn("[HP_Manager] jukebox extension loaded but has no open() function; " ..
                "cannot open the music manager")
              return
            end

            hp_sessions[player_id] = nil

            Async.sleep(0.05).and_then(function()
              if desktop_control[player_id] ~= expected_control or
                 not expected_control or not expected_control:is_alive() then return end
              close_hp_manage(player_id)

              launch_child(player_id, option.id, function()
                return jukebox_module.open(player_id, function(pid)
                  resume_desktop(pid, option.id, expected_control)
                end, { parent = expected_control })
              end, jukebox_module.close)
            end)

            return
          end
        end
      end
    end
  end
end



-- Controller input is dispatched through the PlayerControl desktop session.
-- Child screens keep the parent capture alive but exclusively own focus.
local desktop_actions = {
  {"Up", "Move Up", true}, {"Down", "Move Down", true},
  {"Left", "Move Left", true}, {"Right", "Move Right", true},
  {"Confirm", "Confirm", false}, {"Cancel", "Cancel", false},
  {"ShoulderL", "Shoulder L", false}, {"ShoulderR", "Shoulder R", false}
}
Net:on("tick", function()
  for pid, session in pairs(hp_sessions) do
    if session and session.control and not session.closing then
      local ok, err = pcall(function()
        local synthetic = session.control:poll(desktop_actions)
        if synthetic and #synthetic.events > 0 then handle_manager_input(synthetic) end
      end)
      if not ok then
        log:error("[HP_Manager] desktop input error: " .. tostring(err))
        pcall(close_hp_manage, pid)
        hp_sessions[pid] = nil
        local active = desktop_control[pid]
        desktop_control[pid] = nil
        if active then pcall(function() active:close() end) end
      end
    end
  end
end)

-- HP MANAGER INTERACTION
Net:on("object_interaction", function(event)
  if event.button ~= nil and event.button ~= 0 then return end

  local player_id = event.player_id
  local area_id = Net.get_player_area(player_id)
  local object = Net.get_object_by_id(area_id, event.object_id)

  if object == nil then return end
  if object.type ~= "HP_Manager" and object.class ~= "HP_Manager" then return end
  local existing = desktop_control[player_id]
  if existing and existing:is_alive() then return end
  log:debug("[HP_Manager] object interaction area=" .. tostring(area_id) ..
        " object=" .. tostring(event.object_id))
  safe_open_hp_manager(player_id)
end)
log:info("[HP_Manager] registered HP_Manager object_interaction listener")

-- CLEANUP
Net:on("player_disconnect", function(event)
  hp_sessions[event.player_id] = nil
  desktop_control[event.player_id] = nil
end)

Net:on("player_area_transfer", function(event)
  local pid = event.player_id
  local control = desktop_control[pid]
  if control then
    close_hp_manage(pid)
    hp_sessions[pid] = nil
    desktop_control[pid] = nil
    control:close()
  end
end)

-- CURSOR ANIMATION
Net:on("tick", function(event)
  for player_id, session in pairs(hp_sessions) do
    local ok, err = pcall(function()
    session.cursor_timer = session.cursor_timer + event.delta_time
    session.input_delay = math.max(0, session.input_delay - event.delta_time)
    if session.cursor_timer >= 0.20 then
      session.cursor_timer = session.cursor_timer - 0.20
      session.cursor_offset = session.cursor_offset == 0 and 1 or 0

      local option = desktop_options[session.selected]

      if option ~= nil then
        games.update_ui_element("hp_selector", player_id,
          { x = option.cursor_x + session.cursor_offset, y = option.cursor_y, z = 30 })
      end
    end
    end)
    if not ok then
      log:error("[HP_Manager] desktop animation error: " .. tostring(err))
      pcall(close_hp_manage, player_id)
      hp_sessions[player_id] = nil
      local active = desktop_control[player_id]
      desktop_control[player_id] = nil
      if active then pcall(function() active:close() end) end
    end
  end
end)
-- Exposed only as a module-initialization sentinel. HP Manager is event-driven.
rawset(_G, "__hp_manager_main_initialized", true)
return true
