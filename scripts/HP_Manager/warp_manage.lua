--[[
* ---------------------------------------------------------- *
                    Warp Manager
* ---------------------------------------------------------- *
]]

local WarpManage = {}

local board_color = { r = 30, g = 30, b = 30 }
local warp_sessions = {}

local data_file = "scripts/HP_Manager/data/warp_data.dat"
local warp_data = {}

local constants = require("scripts/HP_Manager/constants/constants")

-- LOAD WARP DATA
local function load_warp_data()
  local file = io.open(data_file, "r")

  if file == nil then
    return
  end

  local content = file:read("*a")

  file:close()

  local chunk, error_message = load(content, "@" .. data_file, "t", {})

  if chunk == nil then
    print("[Warp Manager] Failed to load warp data: " .. tostring(error_message))
    return
  end

  local success, data = pcall(chunk)

  if not success or type(data) ~= "table" then
    print("[Warp Manager] Invalid warp data file.")
    return
  end

  warp_data = data
end

-- SAVE WARP DATA
local function save_warp_data()
  local temp_file = data_file .. ".tmp"
  local file = io.open(temp_file, "w")

  if file == nil then
    print("[Warp Manager] Failed to save warp data.")
    return false
  end

  file:write("return {\n")

  local areas = {}

  for area_id in pairs(warp_data) do
    areas[#areas + 1] = area_id
  end

  table.sort(areas)

  for _, area_id in ipairs(areas) do
    file:write("  [", string.format("%q", area_id), "] = {\n")

    local controllers = {}

    for controller_number in pairs(warp_data[area_id]) do
      controllers[#controllers + 1] = controller_number
    end

    table.sort(controllers)

    for _, controller_number in ipairs(controllers) do
      local warp = warp_data[area_id][controller_number]

      file:write("    [", controller_number, "] = {address = ", string.format("%q", warp.address or ""),
        ", port = ", string.format("%q", tostring(warp.port or "")),
        ", location = ", string.format("%q", warp.location or ""), "},\n")
    end

    file:write("  },\n")
  end

  file:write("}\n")
  file:close()

  local backup_file = data_file .. ".bak"

  os.remove(backup_file)

  local old_file = io.open(data_file, "r")

  if old_file ~= nil then
    old_file:close()

    if not os.rename(data_file, backup_file) then
      print("[Warp Manager] Failed to create warp data backup.")
      os.remove(temp_file)
      return false
    end
  end

  if not os.rename(temp_file, data_file) then
    print("[Warp Manager] Failed to replace warp data file.")

    os.rename(backup_file, data_file)

    return false
  end

  os.remove(backup_file)

  return true
end

local function async(func)
  local co = coroutine.create(func)
  return Async.promisify(co)
end

local function await(promise)
  return Async.await(promise)
end

-- warp_controller_FINDER
local function find_warp_controllers(area_id)
  local warp_groups = {}
  local object_ids = Net.list_objects(area_id)

  table.sort(object_ids)

  for _, object_id in ipairs(object_ids) do
    local object = Net.get_object_by_id(area_id, object_id)

    if object ~= nil then
      local controller_number = object.name and object.name:match("^warp_controller_(%d+)$")

      if controller_number ~= nil and object.class == "Server Warp" then
        local number = tonumber(controller_number)
        local properties = object.custom_properties or {}
        local warp = warp_groups[number]

        if warp == nil then
          warp = {
            object_ids = {},
            controller_number = number,
            address = "",
            port = "",
            location = ""
          }

          warp_groups[number] = warp
        end

        warp.object_ids[#warp.object_ids + 1] = object.id

        -- USE FIRST CONFIGURED DESTINATION
        local address = properties.Address or ""
        local port = properties.Port or ""

        if warp.address == "" and address ~= "" and port ~= "" then
          warp.address = address
          warp.port = port
        end

        -- USE FIRST LOCATION NAME
        local location = properties.Location or ""

        if warp.location == "" and location ~= "" then
          warp.location = location
        end
      end
    end
  end

  local warps = {}

  for _, warp in pairs(warp_groups) do
    if warp.location == "" then
      warp.location = "Warp Controller " .. warp.controller_number
    end

    warps[#warps + 1] = warp
  end

  table.sort(warps, function(a, b)
    return a.controller_number < b.controller_number
  end)

  return warps
end

-- APPLY SAVED WARPS
local function apply_saved_warps(area_id)
  local area_data = warp_data[area_id]

  if area_data == nil then
    return
  end

  for _, object_id in ipairs(Net.list_objects(area_id)) do
    local object = Net.get_object_by_id(area_id, object_id)

    if object ~= nil and object.class == "Server Warp" then
      local controller_number = object.name and object.name:match("^warp_controller_(%d+)$")
      local saved_warp = controller_number and area_data[tonumber(controller_number)]

      if saved_warp ~= nil then
        Net.set_object_custom_property(area_id, object_id, "Address", saved_warp.address)
        Net.set_object_custom_property(area_id, object_id, "Port", tostring(saved_warp.port))
        Net.set_object_custom_property(area_id, object_id, "Location", saved_warp.location)
      end
    end
  end
end

-- WARP LIST
function WarpManage.open(player_id, return_to_hp)
  local area_id = Net.get_player_area(player_id)
  apply_saved_warps(area_id)
  local warps = find_warp_controllers(area_id)
  local posts = {}

  for index, warp in ipairs(warps) do
    local title = warp.location

    if warp.address == "" or warp.port == "" then
      title = title .. " [X]"
    end

    posts[#posts + 1] = { id = index, title = title, author = "", read = true }
  end

  local close_index = #posts + 1

  posts[#posts + 1] = { id = close_index, title = "Close Warp Manager", author = "", read = true }

  warp_sessions[player_id] = {
    area_id = area_id,
    warps = warps,
    close_index = close_index,
    return_to_hp = return_to_hp
  }

  Net.open_board(player_id, "Server Warps", board_color, posts)
end

-- WARP SELECT
Net:on("post_selection", function(event)
  local player_id = event.player_id
  local session = warp_sessions[player_id]

  if session == nil then
    return
  end

  local selected_index = tonumber(event.post_id)

  if selected_index == nil then
    return
  end

-- CLOSE WARP MANAGER
if selected_index == session.close_index then
  if session.closing then return end

  session.closing = true
  Net.close_bbs(player_id)

  return
end

  -- WARP SELECTED
  local warp = session.warps[selected_index]

  if warp == nil then
    return
  end

  local area_id = session.area_id
  local return_to_hp = session.return_to_hp

  warp_sessions[player_id] = nil

  Net.close_bbs(player_id)

  async(function()
    -- NEW DESTINATION
    local current_destination = ""

    if warp.address ~= "" and warp.port ~= "" then
      current_destination = warp.address .. ":" .. warp.port
    end

    local new_destination = await(Async.prompt_player(player_id, 160, current_destination))

    -- CANCEL
    if new_destination == nil then
      WarpManage.open(player_id, return_to_hp)
      return
    end

    new_destination = new_destination:gsub("^%s+", ""):gsub("%s+$", "")

    -- ADDRESS AND PORT
    local new_address, new_port_text = new_destination:match("^(.+):(%d+)$")

    if new_address == nil or new_port_text == nil then
      await(Async.message_player(player_id, "Invalid destination. Use ADDRESS:PORT, for example 64.23.226.84:8766."))
      WarpManage.open(player_id, return_to_hp)
      return
    end

    new_address = new_address:gsub("^%s+", ""):gsub("%s+$", "")

    local new_port = tonumber(new_port_text)

    -- ADDRESS VALIDATION
    if new_address == "" then
      await(Async.message_player(player_id, "Address cannot be empty."))
      WarpManage.open(player_id, return_to_hp)
      return
    end

    -- PORT VALIDATION
    if new_port == nil or new_port < 1 or new_port > 65535 then
      await(Async.message_player(player_id, "Invalid port. Use a number between 1 and 65535."))
      WarpManage.open(player_id, return_to_hp)
      return
    end

    -- NEW LOCATION NAME
    local new_location = await(Async.prompt_player(player_id, 64, warp.location))

    -- CANCEL
    if new_location == nil then
      WarpManage.open(player_id, return_to_hp)
      return
    end

    new_location = new_location:gsub("^%s+", ""):gsub("%s+$", "")

    -- LOCATION VALIDATION
    if new_location == "" then
      await(Async.message_player(player_id, "Location name cannot be empty."))
      WarpManage.open(player_id, return_to_hp)
      return
    end

    -- CHANGE SERVER WARPS
    for _, object_id in ipairs(warp.object_ids) do
      Net.set_object_custom_property(area_id, object_id, "Address", new_address)
      Net.set_object_custom_property(area_id, object_id, "Port", tostring(new_port))
      Net.set_object_custom_property(area_id, object_id, "Location", new_location)
    end

    -- SAVE SERVER WARP
    if warp_data[area_id] == nil then
      warp_data[area_id] = {}
    end

    warp_data[area_id][warp.controller_number] = {
      address = new_address,
      port = tostring(new_port),
      location = new_location
    }

    local saved = save_warp_data()

    if not saved then
      await(Async.message_player(player_id, "Warp updated, but persistent data could not be saved."))
      WarpManage.open(player_id, return_to_hp)
      return
    end

    await(Async.message_player(player_id, new_location .. " now points to " .. new_address .. ":" .. new_port .. "."))

    WarpManage.open(player_id, return_to_hp)
  end)
end)

-- WARP MANAGER CLOSE
Net:on("board_close", function(event)
  local player_id = event.player_id
  local session = warp_sessions[player_id]

  if session == nil then
    return
  end

  local return_to_hp = session.return_to_hp

  warp_sessions[player_id] = nil

  if return_to_hp ~= nil then
    return_to_hp(player_id)
  end
end)

-- CLEANUP
Net:on("player_disconnect", function(event)
  warp_sessions[event.player_id] = nil
end)

-- LOAD PERSISTENT WARPS
load_warp_data()

for _, area_id in ipairs(Net.list_areas()) do
  apply_saved_warps(area_id)
end

return WarpManage
