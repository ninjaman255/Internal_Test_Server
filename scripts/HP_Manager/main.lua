--[[
* ---------------------------------------------------------- *
                 HP_Manager v0.1 by Darkware
	 github link

  - this require net-games by indianajson
  https://github.com/indianajson/net-games
* ---------------------------------------------------------- *
]]

local games = require("scripts/net-games/main")
local WarpManage = require("scripts/HP_Manager/warp_manage")
local BackgroundManage = require("scripts/HP_Manager/background_manage")
local TextLayout = require("scripts/displayer/text-layout")

local constants = require("scripts/HP_Manager/constants/constants")
--local AmbientManage = require("scripts/HP_Manager/ambient_manage")

local hp_sessions = {}

local desktop_options = {
  {
    id = "exit",
    label = "Exit",
    x = 112,
    y = 145,
    cursor_x = 110,
    cursor_y = 152
  },
  {
    id = "warp",
    label = "Warp Manager",
    x = 20,
    y = 30,
    cursor_x = 18,
    cursor_y = 38
  },
  {
    id = "background",
    label = "Background Manager",
    x = 70,
    y = 30,
    cursor_x = 68,
    cursor_y = 38
  }
}

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
  windows = "/server/assets/HP_Manager/Wallpapers/windows_wallpaper.png",
  linux = "/server/assets/HP_Manager/Wallpapers/linux_wallpaper.png",
  macos = "/server/assets/HP_Manager/Wallpapers/macos_wallpaper.png",
  unix = "/server/assets/HP_Manager/Wallpapers/linux_wallpaper.png"
}

local server_os = get_server_os()
local wallpaper = system_wallpaper[server_os] or system_wallpaper.windows

--print("HP Manager:", server_os)

-- HP MANAGER OPEN
local function open_hp_manager(player_id, selected_id)
  selected_id = selected_id or "exit"

  local selected = desktop_option_indexes[selected_id] or desktop_option_indexes["exit"]

  hp_sessions[player_id] = { selected = selected, cursor_timer = 0, cursor_offset = 0 }

  Net.lock_player_input(player_id)

  local exit_option = desktop_options_by_id["exit"]
  local warp_option = desktop_options_by_id["warp"]
  local background_option = desktop_options_by_id["background"]
  local selected_option = desktop_options[selected]

  games.add_ui_element("hp_wallpaper", player_id, wallpaper, "", "", 0, 0, 0, 2, 2)
  games.add_ui_element("hp_border", player_id, "/server/assets/HP_Manager/border.png", "", "", 0, 0, 10, 2, 2)

  -- ICONS
  games.add_ui_element("hp_emblem", player_id, "/server/assets/HP_Manager/emblem.png", "", "", exit_option.x,
    exit_option.y, 15, 2, 2)
  games.add_ui_element("hp_warp_icon", player_id, "/server/assets/HP_Manager/warp_icon.png", "", "", warp_option.x,
    warp_option.y, 15, 2, 2)
  games.add_ui_element("hp_background_icon", player_id, "/server/assets/HP_Manager/background_icon.png", "", "",
    background_option.x, background_option.y, 15, 2, 2)

  -- CURSOR
  games.add_ui_element("hp_selector", player_id, "/server/assets/net-games/cursors/text_cursor.png",
    "/server/assets/net-games/cursors/text_cursor.animation", "CURSOR_RIGHT",
    selected_option.cursor_x, selected_option.cursor_y, 30, 2, 2)

  -- OPTION NAME
  draw_option_name(player_id, selected_option)
end

-- HP MANAGER INPUT
Net:on("virtual_input", function(event)
  local player_id = event.player_id
  local session = hp_sessions[player_id]

  if session == nil then
    return
  end

  for _, button in next, event.events do
    if button.state == 1 then
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
          for _, element in ipairs(desktop_elements) do
            games.remove_ui_element(element, player_id)
          end

          games.remove_text("hp_option_name", player_id)

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
            for _, element in ipairs(desktop_elements) do
              games.remove_ui_element(element, player_id)
            end

            games.remove_text("hp_option_name", player_id)

            hp_sessions[player_id] = nil

            Net.unlock_player_input(player_id)

            return
          end

          -- WARP MANAGER
          if option.id == "warp" then
            hp_sessions[player_id] = nil

            Net.fade_player_camera(player_id, { r = 0, g = 0, b = 0, a = 255 }, 0.05)

            Async.sleep(0.05).and_then(function()
              for _, element in ipairs(desktop_elements) do
                games.remove_ui_element(element, player_id)
              end

              games.remove_text("hp_option_name", player_id)

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
              for _, element in ipairs(desktop_elements) do
                games.remove_ui_element(element, player_id)
              end

              games.remove_text("hp_option_name", player_id)

              BackgroundManage.open(player_id, function(player_id)
                open_hp_manager(player_id, option.id)
              end)
            end)

            return
          end
        end
      end
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
  if object.name ~= "hp_manager" then return end
  if (object.type or object.class) ~= "HP_Manager" then return end

  open_hp_manager(player_id)
end)

-- CURSOR ANIMATION
Net:on("tick", function(event)
  for player_id, session in pairs(hp_sessions) do
    session.cursor_timer = session.cursor_timer + event.delta_time

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
