--[[
* ---------------------------------------------------------- *
                 Jukebox v2.1 by D3str0y3d
	 https://github.com/ninjaman255/Server_12_22_2021_Jukebox
* ---------------------------------------------------------- *
]]

local Utils = require("scripts/jukebox/utils")
local NetGames = require("scripts/net-games/main")
local Emitter = require("scripts/utils/event-emitter")
local UIData = require("scripts/jukebox/constants/ui-data")
local InputAPI = require("scripts/input-controller/main")
local TextAPI = NetGames.Text or require("scripts/displayer/displayer").Text

local Jukebox = Emitter.new()

local sessions = {}

-- UI CONFIGURATION
local SCREEN = UIData.Screen
local TITLE = UIData.Title
local SONG_LIST = UIData.SongList
local RECORD = UIData.Record
local CURSOR = UIData.Cursor

local BaseGatherPath = "./assets/jukebox/albums/"
local TRACK_ROOT = "/server/assets/jukebox/albums/"

local function load_catalog()
  local ordered_albums = Utils.listDirectories(BaseGatherPath) or {}
  table.sort(ordered_albums)

  local tracks, albums = {}, {}

  for _, album_name in ipairs(ordered_albums) do
    local songs = {}

    for _, filename in ipairs(
      Utils.listFiles(BaseGatherPath .. album_name .. "/") or {}
    ) do
      if filename:lower():match("%.ogg$") then
        songs[#songs + 1] = filename
      end
    end

    table.sort(songs, function(a, b)
      local lower_a, lower_b = a:lower(), b:lower()

      if lower_a == lower_b then
        return a < b
      end

      return lower_a < lower_b
    end)

    local indices = {}

    for _, filename in ipairs(songs) do
      local index = #tracks + 1

      tracks[index] = {
        title = filename,
        display_title = filename:gsub("%.[Oo][Gg][Gg]$", ""),
        path = TRACK_ROOT .. album_name .. "/" .. filename,
        record_label = album_name
      }

      indices[#indices + 1] = index
    end

    if #indices > 0 then
      albums[#albums + 1] = {
        name = album_name,
        indices = indices
      }
    end
  end

  return tracks, albums, ordered_albums
end

local TrackItems, AlbumItems, SortedAlbums = load_catalog()

local function record_art_path(album_name, kind)
  if not album_name or album_name == "" then return nil end

  return RECORD.art_root
      .. album_name .. "/"
      .. (kind or RECORD.default_kind) .. ".png"
end

-- REGISTER MUSIC ASSETS
for _, area_id in ipairs(Net.list_areas() or {}) do
  for _, track in ipairs(TrackItems) do
    Net.provide_asset(area_id, track.path)
  end
end

print("[Jukebox] " .. tostring(#TrackItems) .. " track(s) across "
  .. tostring(#AlbumItems) .. " album(s)")


-- ALBUM MARQUEE
local function clear_title(player_id)
  TextAPI.removeMarquee(player_id, TITLE.id)
end

local function draw_album_title(player_id, album_name)
  clear_title(player_id)

  if not album_name or album_name == "" then
    return
  end

  TextAPI.draw(
    player_id,
    TITLE.id,
    album_name,
    TITLE.x,
    TITLE.y,
    {
      mode = "marquee",
      font = TITLE.font,
      scale = TITLE.scale,
      z = TITLE.z,
      width = TITLE.width,
      height = TITLE.height,
      marquee = {
        speed = TITLE.speed,
        loops = nil
      }
    }
  )
end

-- ===================================================================--
-- Input ownership
-- ===================================================================--
local INPUT_OWNER_PREFIX = "jukebox:"
local function input_owner(player_id)
  return INPUT_OWNER_PREFIX .. tostring(player_id)
end

local function navigation_pressed(ctrl, owner, action)
  return ctrl:is_action_pressed(action, owner)
      or ctrl:is_action_repeated(action, owner)
end

local function acquire_input(player_id)
  local ctrl = InputAPI.get_controller(player_id)
  if not ctrl then ctrl = InputAPI.create_controller(player_id) end
  if not ctrl then
    print("[Jukebox] no controller for player " .. tostring(player_id))
    return nil, nil
  end
  local owner = input_owner(player_id)
  if not ctrl:has_input_control(owner) then
    if not ctrl:claim_input(owner, true) then
      print("[Jukebox] claim_input failed for player " .. tostring(player_id))
      return nil, nil
    end

    ctrl:require_release({ "Confirm", "Cancel" }, owner)
  end
  return ctrl, owner
end

local function release_input_for(player_id)
  local ctrl = InputAPI.get_controller(player_id)
  if not ctrl then return end
  local owner = input_owner(player_id)
  if ctrl:has_input_control(owner) then
    ctrl:release_input(owner)
  end
end

-- ===================================================================--
-- UI
-- ===================================================================--

local function provide_base_ui_assets(player_id)
  local provided = {}

  local function provide(path)
    if not path or path == "" or provided[path] then
      return
    end

    pcall(Net.provide_asset_for_player, player_id, path)
    provided[path] = true
  end

  for _, name in ipairs(UIData.UIIDNames) do
    local element = UIData.UIData[name]

    if element then
      provide(element.texture_path)
      provide(element.anim_path)
    end
  end

  provide(RECORD.anim_path)
end

local function add_static_ui(player_id, name)
  local element = assert(
    UIData.UIData[name],
    "Missing UI configuration: " .. name
  )

  NetGames.add_ui_element(
    name, player_id,
    element.texture_path,
    element.anim_path,
    element.anim_state,
    element.x, element.y, element.z,
    element.sx, element.sy,
    SCREEN.width, SCREEN.height
  )
end

local function add_record_ui(player_id, album_name, kind)
  local session = sessions[player_id]
  if not session then return false end

  kind = kind or RECORD.default_kind

  local record_art = record_art_path(album_name, kind)
  if not record_art then return false end

  local sprite_id = RECORD.id_prefix .. album_name .. ":" .. kind
  local previous_id = session.record_id

  if previous_id == sprite_id then
    return true
  end

  -- PROVIDE NEW RECORD TEXTURE
  local asset_ok, asset_result = pcall(
    Net.provide_asset_for_player,
    player_id,
    record_art
  )

  if not asset_ok or asset_result == false then
    print("[Jukebox] Failed to load record: " .. record_art)
    return false
  end

  -- CREATE NEW RECORD BEFORE REMOVING PREVIOUS
  local created, result = pcall(
    NetGames.add_ui_element,
    sprite_id, player_id,
    record_art,
    RECORD.anim_path,
    RECORD.anim_state,
    RECORD.x, RECORD.y, RECORD.z,
    RECORD.sx, RECORD.sy,
    SCREEN.width, SCREEN.height
  )

  if not created or result == false then
    print("[Jukebox] Failed to create record: " .. tostring(result))

    pcall(NetGames.remove_ui_element, sprite_id, player_id)

    if type(Net.player_dealloc_sprite) == "function" then
      pcall(Net.player_dealloc_sprite, player_id, sprite_id)
    end

    return false
  end

  -- NEW RECORD IS READY
  session.record_id = sprite_id

  -- REMOVE PREVIOUS RECORD
  if previous_id then
    local removed, err = pcall(
      NetGames.remove_ui_element,
      previous_id,
      player_id
    )

    if not removed then
      print("[Jukebox] Failed to remove previous record: "
        .. tostring(err))
    end

    if type(Net.player_dealloc_sprite) == "function" then
      local released, release_err = pcall(
        Net.player_dealloc_sprite,
        player_id,
        previous_id
      )

      if not released then
        print("[Jukebox] Failed to release previous record: "
          .. tostring(release_err))
      end
    end
  end

  return true
end

-- RECORD ROTATION
local function slow_record(player_id, sprite_id)
  local session = sessions[player_id]

  if not session or session.record_id ~= sprite_id then
    return
  end

  NetGames.update_ui_element(sprite_id, player_id, { ro = 0 })

  NetGames.rotate_ui_element(
    sprite_id,
    player_id,
    360,
    RECORD.slow_duration,
    "linear",
    function(_, interrupted)
      if not interrupted
          and sessions[player_id] == session
          and session.record_id == sprite_id then
        slow_record(player_id, sprite_id)
      end
    end
  )
end

local function rotate_record(player_id)
  local session = sessions[player_id]
  if not session or not session.record_id then return end

  local sprite_id = session.record_id

  NetGames.stop_ui_animation(sprite_id, player_id)
  NetGames.update_ui_element(sprite_id, player_id, { ro = 0 })

  NetGames.rotate_ui_element(
    sprite_id,
    player_id,
    360,
    RECORD.fast_duration,
    "linear",
    function(_, interrupted)
      if not interrupted
          and sessions[player_id] == session
          and session.record_id == sprite_id then
        slow_record(player_id, sprite_id)
      end
    end
  )
end

local function spawnJukeboxUI(player_id)
  add_static_ui(player_id, "Shade Screen")
  add_static_ui(player_id, "Jukebox Backdrop")

  local initial_album = AlbumItems[1] and AlbumItems[1].name

  if initial_album then
    if add_record_ui(player_id, initial_album) then
      slow_record(player_id, sessions[player_id].record_id)
    end
  end

  add_static_ui(player_id, "Jukebox Frame")
  add_static_ui(player_id, "Jukebox Cursor Up")
  add_static_ui(player_id, "Jukebox Cursor Down")
  add_static_ui(player_id, "Jukebox Cursor Left")
  add_static_ui(player_id, "Jukebox Cursor Right")

  draw_album_title(player_id, initial_album)
  draw_track_list(player_id)
end

local function removeJukeboxUI(player_id, session)
  local sprite_id = session and session.record_id

  if sprite_id then
    NetGames.remove_ui_element(sprite_id, player_id)

    if Net.player_dealloc_sprite then
      Net.player_dealloc_sprite(player_id, sprite_id)
    end
  end

  clear_track_list(player_id)

  for _, name in ipairs(UIData.UIIDNames) do
    pcall(NetGames.remove_ui_element, name, player_id)
  end

  clear_title(player_id)
end

-- ===================================================================--
-- Open / close
-- ===================================================================--

local function openJukeboxMenu(player_id, area_id, object_id, on_close)
  local session = sessions[player_id]

  if session then
    if on_close then
      session.on_close = on_close
    end

    return true
  end

  area_id = area_id or Net.get_player_area(player_id)

  sessions[player_id] = {
    album_index = 1,
    track_position = 1,
    current_index = AlbumItems[1] and AlbumItems[1].indices[1],
    list_start = 1,
    area_id = area_id,
    cursor_time = 0,
    cursor_offset = 0,
    record_id = nil,
    on_close = on_close
  }

  provide_base_ui_assets(player_id)

  Jukebox:emit("Jukebox Open", {
    player_id = player_id,
    area_id = area_id,
    object_id = object_id
  })

  return true
end

local function closeJukeboxMenu(player_id, suppress_callback)
  local session = sessions[player_id]
  if not session then return end

  sessions[player_id] = nil

  Jukebox:emit("Jukebox Close", {
    player_id = player_id,
    session = session
  })

  if not suppress_callback and session.on_close then
    local ok, err = pcall(session.on_close, player_id)

    if not ok then
      print("[Jukebox] open() callback failed for "
        .. tostring(player_id) .. ": " .. tostring(err))
    end
  end
end

-- ===================================================================--
-- Track selection
-- ===================================================================--
local function update_list_window(session)
  if session.track_position < session.list_start then
    session.list_start = session.track_position
  end

  local last_visible = session.list_start + SONG_LIST.visible - 1

  if session.track_position > last_visible then
    session.list_start = session.track_position - SONG_LIST.visible + 1
  end
end

function clear_track_list(player_id)
  for i = 1, SONG_LIST.visible do
    TextAPI.removeStatic(player_id, SONG_LIST.id_prefix .. i)
  end
end

function draw_track_list(player_id)
  local session = sessions[player_id]
  if not session then return end

  clear_track_list(player_id)
  update_list_window(session)

  local current_song = Net.get_song(session.area_id)

  local album = AlbumItems[session.album_index]
  if not album then return end

  for line = 1, SONG_LIST.visible do
    local position = session.list_start + line - 1
    local track_index = album.indices[position]
    local track = track_index and TrackItems[track_index]

    if track then
      local title = track.display_title
      local color = SONG_LIST.colors.normal

      if current_song == track.path then
        color = SONG_LIST.colors.playing
      end

      if session.current_index == track_index then
        color = SONG_LIST.colors.selected
      end

      TextAPI.draw(
        player_id,
        SONG_LIST.id_prefix .. line,
        title,
        SONG_LIST.x,
        SONG_LIST.y + (line - 1) * SONG_LIST.line_height,
        {
          mode = "static",
          font = SONG_LIST.font,
          scale = SONG_LIST.scale,
          z = SONG_LIST.z,
          r = color[1],
          g = color[2],
          b = color[3]
        }
      )
    end
  end
end

local function select_preview(player_id, index)
  local session = sessions[player_id]

  if not session
      or not TrackItems[index]
      or session.current_index == index then
    return
  end

  session.current_index = index
  draw_track_list(player_id)
end

-- ALBUM NAVIGATION
local function change_album(player_id, direction)
  local session = sessions[player_id]
  if not session or #AlbumItems == 0 then return end

  local old_index = session.album_index

  local new_index =
      (old_index - 1 + direction) % #AlbumItems + 1

  if new_index == old_index and session.track_position == 1 then
    return
  end

  session.album_index = new_index
  session.track_position = 1
  session.list_start = 1

  local album = AlbumItems[new_index]

  if new_index ~= old_index then
    local previous_record = session.record_id

    if add_record_ui(player_id, album.name)
        and session.record_id ~= previous_record then
      rotate_record(player_id)
    end

    draw_album_title(player_id, album.name)
  end

  select_preview(player_id, album.indices[1])
end

-- TRACK NAVIGATION
local function change_track(player_id, direction)
  local session = sessions[player_id]
  if not session then return end

  local album = AlbumItems[session.album_index]
  if not album or #album.indices <= 1 then return end

  session.track_position =
      (session.track_position - 1 + direction) % #album.indices + 1

  select_preview(
    player_id,
    album.indices[session.track_position]
  )
end

local function requestJukeboxSong(player_id, index)
  local area_id = Net.get_player_area(player_id)
  if not area_id then
    print("[Jukebox] requestJukeboxSong: player " .. tostring(player_id)
      .. " has no area")
    return
  end
  local track = TrackItems[index]
  if not track then
    print("[Jukebox] requestJukeboxSong: no track at index " .. tostring(index))
    return
  end

  local track_path = track.path

  local ok_song, song_result = pcall(Net.set_song, area_id, track_path)
  if not ok_song or song_result == false then
    print("[Jukebox] set_song failed for " .. tostring(track_path) .. ": " .. tostring(song_result))
    return
  end

  for other_player_id, session in pairs(sessions) do
    if session.area_id == area_id then
      draw_track_list(other_player_id)
    end
  end
end

-- ===================================================================--
-- Event handlers
-- ===================================================================--

Jukebox:on("Jukebox Open", function(event)
  local player_id = event.player_id
  local ctrl, owner = acquire_input(player_id)

  if not ctrl then
    local session = sessions[player_id]
    sessions[player_id] = nil

    if session and session.on_close then
      pcall(session.on_close, player_id)
    end

    return
  end

  Net.lock_player_input(player_id)
  Net.toggle_player_hud(player_id)

  local ui_ok, ui_err = pcall(spawnJukeboxUI, player_id)

  if not ui_ok then
    print("[Jukebox] spawnJukeboxUI failed: "
      .. tostring(ui_err))

    closeJukeboxMenu(player_id)
    return
  end

  Async.promisify(coroutine.create(function()
    local session = sessions[player_id]
    ctrl:consume(owner)

    Async.await(Async.sleep(0.2))
    ctrl:consume(owner)

    while sessions[player_id] == session do
      if ctrl:is_action_pressed("Cancel", owner) then
        closeJukeboxMenu(player_id)
        break
      end

      if navigation_pressed(ctrl, owner, "Left") then
        change_album(player_id, -1)
      elseif navigation_pressed(ctrl, owner, "Right") then
        change_album(player_id, 1)
      elseif navigation_pressed(ctrl, owner, "Down") then
        change_track(player_id, 1)
      elseif navigation_pressed(ctrl, owner, "Up") then
        change_track(player_id, -1)
      end

      if session.current_index
          and ctrl:is_action_pressed("Confirm", owner) then
        Jukebox:emit("Jukebox Request Song", {
          player_id = player_id,
          index = session.current_index
        })
      end

      ctrl:consume(owner)
      Async.await(Async.sleep(0.2))
    end
  end))
end)

Jukebox:on("Jukebox Close", function(event)
  local player_id = event.player_id

  release_input_for(player_id)
  Net.unlock_player_input(player_id)
  Net.toggle_player_hud(player_id)

  removeJukeboxUI(player_id, event.session)
end)

Jukebox:on("Jukebox Request Song", function(event)
  requestJukeboxSong(event.player_id, event.index)
end)

-- SYNCHRONIZED CURSOR TICK UPDATE
Net:on("tick", function(event)
  local dt = event.delta_time or 0

  for player_id, session in pairs(sessions) do
    session.cursor_time = (session.cursor_time + dt) % CURSOR.cycle

    local phase = (session.cursor_time / CURSOR.cycle) * 2 * math.pi
    local motion = (1 - math.cos(phase)) / 2

    local offset = math.floor(motion * 2 + 0.5) / 2

    if offset ~= session.cursor_offset then
      session.cursor_offset = offset

      NetGames.update_ui_element("Jukebox Cursor Up", player_id, {
        y = UIData.UIData["Jukebox Cursor Up"].y + offset
      })

      NetGames.update_ui_element("Jukebox Cursor Down", player_id, {
        y = UIData.UIData["Jukebox Cursor Down"].y - offset
      })

      NetGames.update_ui_element("Jukebox Cursor Left", player_id, {
        x = UIData.UIData["Jukebox Cursor Left"].x + offset
      })

      NetGames.update_ui_element("Jukebox Cursor Right", player_id, {
        x = UIData.UIData["Jukebox Cursor Right"].x - offset
      })
    end
  end
end)


Net:on("object_interaction", function(event)
  local area_id = Net.get_player_area(event.player_id)
  local object = Net.get_object_by_id(area_id, event.object_id)

  if object.class ~= "Jukebox" and object.type ~= "Jukebox" then return end

  if event.button ~= 0 then return end
  openJukeboxMenu(event.player_id, area_id, event.object_id)
end)

-- ===================================================================--
-- Public API
-- ===================================================================--
local function open_jukebox_ui(player_id, on_close)
  if not player_id then return false end
  if type(Net.is_player) == "function" then
    local ok, alive = pcall(Net.is_player, player_id)
    if ok and not alive then return false end
  end
  local area_id = Net.get_player_area(player_id)
  if not area_id then return false end
  return openJukeboxMenu(player_id, area_id, nil, on_close)
end

local function close_jukebox_ui(player_id)
  if not player_id then return end
  closeJukeboxMenu(player_id, true)
end

Net:on("player_disconnect", function(event)
  local player_id = event.player_id
  local session = sessions[player_id]

  sessions[player_id] = nil

  if session and session.record_id then
    pcall(
      NetGames.stop_ui_animation,
      session.record_id,
      player_id
    )
  end
end)

return {
  open = open_jukebox_ui,
  close = close_jukebox_ui,
  emitter = Jukebox,
  get_tracks = function() return TrackItems end,
  get_albums = function()
    local albums = {}

    for i, name in ipairs(SortedAlbums) do
      albums[i] = name
    end

    return albums
  end,
}
