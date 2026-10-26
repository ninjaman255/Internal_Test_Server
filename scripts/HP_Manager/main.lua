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
local InputAPI = require("scripts/input-controller/main")
local TextLayout = require("scripts/displayer/text-layout")
--MANAGERS
local WarpManage = require("scripts/hp_manager/warp_manage")
local BackgroundManage = require("scripts/hp_manager/background_manage")
local RealtimeManage = require("scripts/hp_manager/realtime_manage")
--CONFIG FILE
local constants = require("scripts/hp_manager/constants/constants")

local hp_sessions = {}
local manager_claimed_controllers = {}

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
          print("[HP_Manager] failed to load module " ..
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
  windows = "/server/assets/hp_manager/wallpapers/windows_wallpaper.png",
  linux = "/server/assets/hp_manager/wallpapers/linux_wallpaper.png",
  macos = "/server/assets/hp_manager/wallpapers/macos_wallpaper.png",
  unix = "/server/assets/hp_manager/wallpapers/linux_wallpaper.png"
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
    local initial_open = selected_id == nil
    selected_id = selected_id or "exit"

    local selected = desktop_option_indexes[selected_id] or desktop_option_indexes["exit"]

    hp_sessions[player_id] = {
        selected = selected,
        cursor_timer = 0,
        cursor_offset = 0,
        input_delay = initial_open and 0.2 or 0
    }

  Net.lock_player_input(player_id)

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

          Net.unlock_player_input(player_id)

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

            Net.unlock_player_input(player_id)

            return
          end

          -- WARP MANAGER
          if option.id == "warp" then
            hp_sessions[player_id] = nil

            Net.fade_player_camera(player_id, { r = 0, g = 0, b = 0, a = 255 }, 0.05)

            Async.sleep(0.05).and_then(function()
              close_hp_manage(player_id)

              WarpManage.open(player_id, function(player_id)
                open_hp_manager(player_id, option.id)

                Net.fade_player_camera(player_id, { r = 0, g = 0, b = 0, a = 0 }, 0.05)
              end)
            end)

            return
          end

          -- BACKGROUND MANAGER
          if option.id == "background" then
            hp_sessions[player_id] = nil

            Async.sleep(0.05).and_then(function()
              close_hp_manage(player_id)

              BackgroundManage.open(player_id, function(player_id)
                open_hp_manager(player_id, option.id)
              end)
            end)

            return
          end

          -- REAL DAY TIME MANAGER
          if option.id == "real_daytime" then
            hp_sessions[player_id] = nil

            Async.sleep(0.05).and_then(function()
              close_hp_manage(player_id)

              RealtimeManage.open(player_id, function(player_id)
                open_hp_manager(player_id, option.id)
              end, extensions.real_daytime)
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
            local jukebox_module = extensions.jukebox
            if not jukebox_module or type(jukebox_module.open) ~= "function" then
              print("[HP_Manager] jukebox extension loaded but has no open() function; " ..
                "cannot open the music manager")
              return
            end

            hp_sessions[player_id] = nil

            Async.sleep(0.05).and_then(function()
              close_hp_manage(player_id)

              local opened_ok = jukebox_module.open(player_id, function(pid)
                -- Jukebox UI closed. Reopen the desktop with the jukebox
                -- option still selected so the player lands where they left.
                open_hp_manager(pid, option.id)
              end)

              if opened_ok == false then
                -- Jukebox refused to open (player gone, area missing,
                -- assets failed, etc.). Restore the desktop so the player
                -- isn't stranded with no UI.
                open_hp_manager(player_id, option.id)
              end
            end)

            return
          end
        end
      end
    end
  end
end



-- InputController ownership/polling adapter. InputController owns the only
-- virtual_input listener; HP_Manager reads logical actions from the shared API.
local input_owner_prefix = "hp-manager:"
local function input_owner(player_id)
    return input_owner_prefix .. tostring(player_id)
end

local function release_manager_input(player_id)
    local ctrl = manager_claimed_controllers[player_id]
    if ctrl then
        -- release_input only releases this manager's claim; it cannot release
        -- a claim belonging to another module.
        ctrl:release_input(input_owner(player_id))
        manager_claimed_controllers[player_id] = nil
    end
end

local function poll_manager_input(player_id, owner)
    local ctrl = InputAPI.get_controller(player_id)
    if not ctrl then
        return nil
    end

    if not ctrl:has_input_control(owner) then
        -- Do not steal input from another active UI/game.
        if ctrl:get_input_owner() ~= nil then
            return nil
        end
        if not ctrl:claim_input(owner) then
            return nil
        end
        manager_claimed_controllers[player_id] = ctrl
        ctrl:require_release({
            "Up", "Down", "Left", "Right",
            "Confirm", "Cancel", "ShoulderL", "ShoulderR"
        }, owner)
        return nil -- ignore the ownership handoff frame
    end

    manager_claimed_controllers[player_id] = ctrl

    local events = {}
    local function take(action, raw_name, allow_repeat)
        if ctrl:is_action_pressed(action, owner) then
            events[#events + 1] = { name = raw_name, state = 1 }
        elseif allow_repeat and ctrl:is_action_repeated(action, owner) then
            events[#events + 1] = { name = raw_name, state = 2 }
        end
    end

    take("Up", "Move Up", true)
    take("Down", "Move Down", true)
    take("Left", "Move Left", true)
    take("Right", "Move Right", true)
    take("Confirm", "Confirm", false)
    take("Cancel", "Cancel", false)
    take("ShoulderL", "Shoulder L", false)
    take("ShoulderR", "Shoulder R", false)

    return { player_id = player_id, events = events }
end

Net:on("tick", function()
    local active = {}
    for player_id, session in pairs(hp_sessions) do
        if session and not session.closing then
            active[#active + 1] = player_id
        end
    end

    for _, player_id in ipairs(active) do
        local synthetic = poll_manager_input(player_id, input_owner(player_id))
        if synthetic and #synthetic.events > 0 then
            handle_manager_input(synthetic)
        end
    end

    -- Release only controllers this module previously claimed, without reading
    -- InputAPI's private _controllers registry.
    for player_id in pairs(manager_claimed_controllers) do
        if hp_sessions[player_id] == nil then
            release_manager_input(player_id)
        end
    end
end)

-- HP MANAGER INTERACTION
Net:on("object_interaction", function(event)
  if event.button ~= 0 then return end

  local player_id = event.player_id
  local area_id = Net.get_player_area(player_id)
  local object = Net.get_object_by_id(area_id, event.object_id)

  if object == nil then return end
  if (object.type or object.class) ~= "HP_Manager" then return end

  open_hp_manager(player_id)
end)

-- CLEANUP
Net:on("player_disconnect", function(event)
  release_manager_input(event.player_id)
  hp_sessions[event.player_id] = nil
end)

-- CURSOR ANIMATION
Net:on("tick", function(event)
  for player_id, session in pairs(hp_sessions) do
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
  end
end)