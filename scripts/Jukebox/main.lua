-- HP Manager dynamically requires this module, and an external server loader
-- may load the same file under a different require/dofile name. Both paths
-- must share the same instance to avoid duplicate Net:on registrations.
local loaded_jukebox = rawget(_G, "__jukebox_main_initialized")
if loaded_jukebox then return loaded_jukebox end

local log = require("scripts/logger/logger").register("jukebox"):register_subsystem("main")
--[[
* ---------------------------------------------------------- *
                 Jukebox v3.0 by D3str0y3d & DarkwarePX
	 https://github.com/ninjaman255/Server_12_22_2021_Jukebox
* ---------------------------------------------------------- *
]]

local Utils = require("scripts/jukebox/utils")
local NetGames = require("scripts/net-games/main")
local Emitter = require("scripts/utils/event-emitter")
local UIData = require("scripts/jukebox/constants/ui-data")
local PlayerControl = require("scripts/player-control/main")
local TextAPI = NetGames.Text or require("scripts/displayer/displayer").Text

local Jukebox = Emitter.new()

local sessions = {}

-- UI configuration
local SCREEN = UIData.Screen
local TITLE = UIData.Title
local SONG_LIST = UIData.SongList
local RECORD = UIData.Record
local CURSOR = UIData.Cursor

local BaseGatherPath = "./assets/jukebox/albums/"
local TRACK_ROOT = "/server/assets/jukebox/albums/"

-- ============================================================================
-- MUSIC CATALOG AND LOOKUP INDEXES
-- ============================================================================
-- Discover OGG files, sort albums and tracks, and build their display metadata.
local function load_catalog()
  local ordered_albums = Utils.listDirectories(BaseGatherPath) or {}
  table.sort(ordered_albums)

  local tracks, albums = {}, {}

  for _, album_name in ipairs(ordered_albums) do
    local songs = {}

    for _, filename in ipairs(Utils.listFiles(BaseGatherPath .. album_name .. "/") or {}) do
      if filename:lower():match("%.ogg$") then
        songs[#songs + 1] = filename
      end
    end

    table.sort(songs, function(a, b)
      local lower_a, lower_b = a:lower(), b:lower()

      if lower_a == lower_b then return a < b end

      return lower_a < lower_b
    end)

    local indices = {}

    for _, filename in ipairs(songs) do
      local index = #tracks + 1
      local name = filename:lower()

      local kind = name:match("_gold%.ogg$") and "gold" or name:match("_ghost%.ogg$") and "ghost" or "base"

      local display_title = filename:gsub("%.[Oo][Gg][Gg]$", "")

      if kind ~= "base" then
        display_title = display_title:sub(1, #display_title - #kind - 1)
      end

      tracks[index] = {
        title = filename,
        display_title = display_title,
        path = TRACK_ROOT .. album_name .. "/" .. filename,
        record_label = album_name,
        record_kind = kind
      }

      indices[#indices + 1] = index
    end

    if #indices > 0 then
      albums[#albums + 1] = {name = album_name, indices = indices}
    end
  end

  return tracks, albums
end

local TrackItems, AlbumItems = load_catalog()

-- Store direct lookups while preserving the catalog's sorted indices.
local AlbumIndexByName = {}
local TrackIndexByAlbum = {}
local TrackIndexByPath = {}

for album_index, album in ipairs(AlbumItems) do
  AlbumIndexByName[album.name] = album_index

  local filenames = {}
  TrackIndexByAlbum[album.name] = filenames

  for _, track_index in ipairs(album.indices) do
    local track = TrackItems[track_index]

    filenames[track.title] = track_index
    TrackIndexByPath[track.path] = track_index
  end
end


-- ============================================================================
-- AREA MUSIC PERSISTENCE
-- ============================================================================
local music_data_file = "scripts/jukebox/data/music_data.dat"
local music_data = {}
local music_revision = 0
local music_active_file = nil

-- Calculate the checksum used to validate persisted data.
local function music_checksum(content)
  local a, b = 1, 0

  for i = 1, #content do
    a = (a + content:byte(i)) % 65521
    b = (b + a) % 65521
  end

  return b * 65536 + a
end

-- Write and reread a data file to verify that its bytes were saved.
local function write_music_file(path, content)
  local file = io.open(path, "wb")
  if not file then return false end

  local ok, written = pcall(function()
    return file:write(content) and file:flush()
  end)

  local close_ok, closed = pcall(function()
    return file:close()
  end)

  if not ok or not written or not close_ok or not closed then
    return false
  end

  local check = io.open(path, "rb")
  if not check then return false end

  local read_ok, saved = pcall(function()
    return check:read("*a")
  end)

  local check_close_ok, check_closed = pcall(function()
    return check:close()
  end)

  return read_ok and saved == content and check_close_ok and check_closed
end

-- Read and validate area music data, including the legacy file format.
local function read_music_file(path)
  local file = io.open(path, "rb")
  if not file then return nil end

  local ok, content = pcall(function()
    return file:read("*a")
  end)

  local close_ok, closed = pcall(function()
    return file:close()
  end)

  if not ok or not close_ok or not closed or not content or content == "" then
    return nil
  end

  local revision, length, hash, payload =
      content:match("^JBOX2\t(%d+)\t(%d+)\t(%d+)\n(.*)$")

  if revision then
    if #payload ~= tonumber(length) or music_checksum(payload) ~= tonumber(hash) then
      return nil
    end
  elseif content:sub(1, 5) == "JBOX2" then
    return nil
  else
    -- Compatibility with older .dat files
    payload = content
    revision = 0
  end

  if payload ~= "" and payload:sub(-1) ~= "\n" then
    return nil
  end

  local data = {}

  for line in payload:gmatch("(.-)\n") do
    if line:sub(-1) == "\r" then
      line = line:sub(1, -2)
    end

    local area_id, track_path = line:match("^([^\t]+)\t([^\t]+)$")

    if not area_id or not track_path then
      return nil
    end

    data[area_id] = track_path
  end

  return data, tonumber(revision), content
end

-- Restore the newest valid area music file from the two alternating copies.
local function load_music_data()
  local main, main_revision =
      read_music_file(music_data_file)

  local backup, backup_revision =
      read_music_file(music_data_file .. ".bak")

  if backup and (not main or backup_revision > main_revision) then
    music_data = backup
    music_revision = backup_revision
    music_active_file = music_data_file .. ".bak"
  elseif main then
    music_data = main
    music_revision = main_revision
    music_active_file = music_data_file
  end
end

-- Persist area music to the alternate file without overwriting the last valid copy.
local function save_music_data()
  local areas = {}

  for area_id in pairs(music_data) do
    areas[#areas + 1] = area_id
  end

  table.sort(areas)

  local lines = {}

  for _, area_id in ipairs(areas) do
    lines[#lines + 1] =
        area_id .. "\t" .. music_data[area_id] .. "\n"
  end

  local payload = table.concat(lines)
  local revision = music_revision + 1

  local content = "JBOX2\t" .. revision .. "\t" .. #payload
      .. "\t" .. music_checksum(payload) .. "\n" .. payload

  local target = music_active_file == music_data_file and (music_data_file .. ".bak") or music_data_file

  if not write_music_file(target, content) then
    return false
  end

  music_revision = revision
  music_active_file = target

  return true
end

-- ============================================================================
-- PLAYER MUSIC UNLOCKS AND PERSISTENCE
-- ============================================================================
local users_music_file = "scripts/jukebox/data/users_music.dat"
local users_music = {}
local users_music_loaded = false
local users_music_available = false
local users_music_revision = 0
local users_music_active_file = nil

-- Derive a stable lookup key without storing the raw player secret.
local function get_music_user_key(player_id)
  local ok, secret = pcall(Net.get_player_secret, player_id)
  if not ok or type(secret) ~= "string" or secret == "" then
    return nil
  end

  local h1, h2 = 5381, 7919

  for i = 1, #secret do
    local byte = secret:byte(i)
    h1 = (h1 * 131 + byte) % 2147483647
    h2 = (h2 * 137 + byte) % 2147483629
  end

  return string.format("%08x%08x%04x", h1, h2, #secret % 65536)
end

-- Validate a user unlock file and reconstruct its album/track records.
local function read_users_music_file(path)
  local file = io.open(path, "rb")
  if not file then return nil, nil, "missing" end

  local ok, content = pcall(function()
    return file:read("*a")
  end)

  local close_ok, closed = pcall(function()
    return file:close()
  end)

  if not ok or not close_ok or not closed or not content then
    return nil, nil, "invalid"
  end

  local revision, length, checksum, payload = content:match("^JUSERS1\t(%d+)\t(%d+)\t(%d+)\n(.*)$")

  if not revision or #payload ~= tonumber(length)
      or music_checksum(payload) ~= tonumber(checksum) then
    return nil, nil, "invalid"
  end

  if payload ~= "" and payload:sub(-1) ~= "\n" then
    return nil, nil, "invalid"
  end

  local result = {}

  for line in payload:gmatch("(.-)\n") do
    local key, album = line:match("^([0-9a-f]+)\tA\t([^\t\r\n]+)$")

    if key then
      local record = result[key]

      if not record then
        record = { albums = {}, tracks = {} }
        result[key] = record
      end

      record.albums[album] = true
    else
      local track_path

      key, track_path = line:match("^([0-9a-f]+)\tT\t([^\t\r\n]+)$")

      if not key then return nil, nil, "invalid" end

      local record = result[key]

      if not record then
        record = { albums = {}, tracks = {} }
        result[key] = record
      end

      record.tracks[track_path] = true
    end
  end

  return result, tonumber(revision), "valid"
end

-- Load user unlocks once, preferring the newest valid saved copy.
local function load_users_music()
  if users_music_loaded then return users_music_available end

  users_music_loaded = true

  local main, main_revision, main_status = read_users_music_file(users_music_file)

  local backup, backup_revision, backup_status = read_users_music_file(users_music_file .. ".bak")

  if backup and (not main or backup_revision > main_revision) then
    users_music = backup
    users_music_revision = backup_revision
    users_music_active_file = users_music_file .. ".bak"

  elseif main then
    users_music = main
    users_music_revision = main_revision
    users_music_active_file = users_music_file

  elseif main_status ~= "missing" or backup_status ~= "missing" then
    -- Preserve damaged files for recovery.
    return false
  end

  users_music_available = true
  return true
end

-- Save unlocked albums and tracks using alternate verified data files.
local function save_users_music()
  if not users_music_available then return false end

  local keys = {}

  for key in pairs(users_music) do
    keys[#keys + 1] = key
  end

  table.sort(keys)

  local lines = {}

  for _, key in ipairs(keys) do
    local record = users_music[key]
    local albums, tracks = {}, {}

    for album in pairs(record.albums) do
      albums[#albums + 1] = album
    end

    for track in pairs(record.tracks) do
      tracks[#tracks + 1] = track
    end

    table.sort(albums)
    table.sort(tracks)

    for _, album in ipairs(albums) do
      lines[#lines + 1] =
          key .. "\tA\t" .. album .. "\n"
    end

    for _, track in ipairs(tracks) do
      lines[#lines + 1] =
          key .. "\tT\t" .. track .. "\n"
    end
  end

  local payload = table.concat(lines)
  local revision = users_music_revision + 1

  local content = "JUSERS1\t" .. revision .. "\t" .. #payload
      .. "\t" .. music_checksum(payload) .. "\n" .. payload

  local target = users_music_active_file == users_music_file
      and (users_music_file .. ".bak")
      or users_music_file

  if not write_music_file(target, content) then
    return false
  end

  users_music_revision = revision
  users_music_active_file = target

  return true
end

-- Check whether a track is unlocked directly or through its album.
local function is_music_unlocked(user_key, track)
  local record = users_music[user_key]

  return record ~= nil and
      (record.albums[track.record_label]
          or record.tracks[track.path]) == true
end

-- Build a catalog-ordered view of a player's unlocked music.
local function get_unlocked_albums(user_key)
  local record = users_music[user_key]
  if not record then return {} end

  local visible_by_index = {}

  -- Add fully unlocked albums.
  for album_name in pairs(record.albums) do
    local album_index = AlbumIndexByName[album_name]

    if album_index then
      visible_by_index[album_index] = AlbumItems[album_index]
    end
  end

  -- Add individually unlocked tracks.
  for track_path in pairs(record.tracks) do
    local track_index = TrackIndexByPath[track_path]

    if track_index then
      local track = TrackItems[track_index]

      if not record.albums[track.record_label] then
        local album_index = AlbumIndexByName[track.record_label]

        if album_index then
          local album = visible_by_index[album_index]

          if not album then
            album = {
              name = track.record_label,
              indices = {}
            }

            visible_by_index[album_index] = album
          end

          album.indices[#album.indices + 1] = track_index
        end
      end
    end
  end

  -- Preserve the original catalog order.
  local sorted_album_indices = {}

  for album_index in pairs(visible_by_index) do
    sorted_album_indices[#sorted_album_indices + 1] = album_index
  end

  table.sort(sorted_album_indices)

  local unlocked = {}

  for _, album_index in ipairs(sorted_album_indices) do
    local album = visible_by_index[album_index]

    if not record.albums[album.name] then
      table.sort(album.indices)
    end

    unlocked[#unlocked + 1] = album
  end

  return unlocked
end

-- Declared early; the UI refresh callback is assigned after its dependencies.
local refresh_unlocked_sessions

-- Refresh open restricted menus after a successful persistent unlock.
local function notify_unlocks_changed(user_key)
  if not refresh_unlocked_sessions then return end

  local ok, err = pcall(refresh_unlocked_sessions, user_key)

  if not ok then
    log:info(
      "[Jukebox] Failed to refresh unlocked music: "
      .. tostring(err)
    )
  end
end

-- Unlock one track, rolling back the in-memory change if saving fails.
local function unlock_music(player_id, album_name, filename)
  if type(album_name) ~= "string"
      or type(filename) ~= "string" then
    return false, "invalid_track"
  end

  local album_tracks = TrackIndexByAlbum[album_name]
  local track_index = album_tracks and album_tracks[filename]
  local track = track_index and TrackItems[track_index]

  if not track then return false, "unknown_track" end
  if not load_users_music() then
    return false, "storage_unavailable"
  end

  local key = get_music_user_key(player_id)
  if not key then return false, "invalid_player" end

  local record = users_music[key]

  if not record then
    record = { albums = {}, tracks = {} }
    users_music[key] = record
  end

  if record.albums[album_name] or record.tracks[track.path] then
    return true, "already_unlocked"
  end

  record.tracks[track.path] = true

  if not save_users_music() then
    record.tracks[track.path] = nil

    if not next(record.albums) and not next(record.tracks) then
      users_music[key] = nil
    end

    return false, "save_failed"
  end

    notify_unlocks_changed(key)

  return true
end

-- Unlock an entire album, rolling back if saving fails.
local function unlock_album(player_id, album_name)
  if type(album_name) ~= "string" then
    return false, "invalid_album"
  end

  if not AlbumIndexByName[album_name] then
    return false, "unknown_album"
  end

  if not load_users_music() then
    return false, "storage_unavailable"
  end

  local key = get_music_user_key(player_id)
  if not key then return false, "invalid_player" end

  local record = users_music[key]

  if not record then
    record = { albums = {}, tracks = {} }
    users_music[key] = record
  end

  if record.albums[album_name] then
    return true, "already_unlocked"
  end

  record.albums[album_name] = true

  if not save_users_music() then
    record.albums[album_name] = nil

    if not next(record.albums) and not next(record.tracks) then
      users_music[key] = nil
    end

    return false, "save_failed"
  end

  notify_unlocks_changed(key)

  return true
end

-- ============================================================================
-- AREA MUSIC RESTORATION
-- ============================================================================
-- Restore saved area songs only when a persistent Jukebox exists.
local function apply_music_data()
  for _, area_id in ipairs(Net.list_areas() or {}) do
    local track_path = music_data[area_id]

    if track_path then
      local valid = TrackIndexByPath[track_path] ~= nil

      if valid then
        for _, object_id in ipairs(Net.list_objects(area_id) or {}) do
          local object = Net.get_object_by_id(area_id, object_id)
          local properties = object and object.custom_properties or {}

          if object and (properties.music_perma == true or properties.music_perma == "true") then
            Net.set_song(area_id, track_path)
            break
          end
        end
      end
    end
  end
end

-- ============================================================================
-- STARTUP: REGISTER TRACK ASSETS AND RESTORE AREA MUSIC
-- ============================================================================
for _, area_id in ipairs(Net.list_areas() or {}) do
  for _, track in ipairs(TrackItems) do
    Net.provide_asset(area_id, track.path)
  end
end

load_music_data()
apply_music_data()

log:info("[Jukebox] " .. tostring(#TrackItems) .. " track(s) across "
  .. tostring(#AlbumItems) .. " album(s)")

-- ============================================================================
-- INPUT OWNERSHIP
-- ============================================================================
-- Each Jukebox receives a PlayerControl context. A desktop may own its
-- parent capture, or the Jukebox may open directly as a root context.
local function navigation_pressed(ctrl, owner, action)
  return ctrl:is_action_pressed(action, owner) or ctrl:is_action_repeated(action, owner)
end
local function acquire_input(player_id)
  local session = sessions[player_id]
  if not session then return nil, nil end
  local control, err = PlayerControl.begin(player_id, {
    owner="jukebox", profile="music_menu", parent=session.control_parent
  })
  if not control then
    log:error("[Jukebox] unable to acquire input: " .. tostring(err))
    return nil, nil
  end
  session.control=control
  return control:input()
end

-- ============================================================================
-- ALBUM TITLE MARQUEE
-- ============================================================================
-- Stop and remove the currently displayed album marquee.
local function clear_title(player_id)
  TextAPI.removeMarquee(player_id, TITLE.id)
end

-- Replace the album marquee while retaining the configured appearance.
local function draw_album_title(player_id, album_name)
  clear_title(player_id)

  if not album_name or album_name == "" then
    return
  end

  TextAPI.draw(player_id, TITLE.id, album_name, TITLE.x, TITLE.y,
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

-- ============================================================================
-- UI ASSETS, RECORD ART AND ANIMATION
-- ============================================================================
-- Resolve the artwork path for a record variant.
local function record_art_path(album_name, kind)
  if not album_name or album_name == "" then return nil end

  return RECORD.art_root
      .. album_name .. "/"
      .. (kind or RECORD.default_kind) .. ".png"
end

-- Provide shared UI textures and animations once per opening.
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

-- Create a UI element from its configuration entry.
local function add_static_ui(player_id, name)
  local element = assert(UIData.UIData[name], "Missing UI configuration: " .. name)

  NetGames.add_ui_element(name, player_id, element.texture_path, element.anim_path, element.anim_state, element.x, element.y, element.z, element.sx, element.sy, SCREEN.width, SCREEN.height)
end

-- Replace the record artwork only when its identity changes.
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

  -- Load the new record texture before changing the visible sprite.
  local asset_ok, asset_result = pcall(Net.provide_asset_for_player, player_id, record_art)

  if not asset_ok or asset_result == false then
    log:error("[Jukebox] Failed to load record: " .. record_art)
    return false
  end

  -- Create the replacement before removing the previous record.
  local created, result = pcall(NetGames.add_ui_element, sprite_id, player_id, record_art, RECORD.anim_path, RECORD.anim_state, RECORD.x, RECORD.y, RECORD.z, RECORD.sx, RECORD.sy, SCREEN.width, SCREEN.height)

  if not created or result == false then
    log:error("[Jukebox] Failed to create record: " .. tostring(result))

    pcall(NetGames.remove_ui_element, sprite_id, player_id)

    if type(Net.player_dealloc_sprite) == "function" then
      pcall(Net.player_dealloc_sprite, player_id, sprite_id)
    end

    return false
  end

  -- Publish the new record only after it was created successfully.
  session.record_id = sprite_id

  -- Release the previous record after the new one is ready.
  if previous_id then
    local removed, err = pcall(NetGames.remove_ui_element, previous_id, player_id)

    if not removed then
      log:error("[Jukebox] Failed to remove previous record: "
        .. tostring(err))
    end

    if type(Net.player_dealloc_sprite) == "function" then
      local released, release_err = pcall(Net.player_dealloc_sprite, player_id, previous_id)

      if not released then
        log:error("[Jukebox] Failed to release previous record: "
          .. tostring(release_err))
      end
    end
  end

  return true
end

-- Keep the selected record rotating slowly while its session is active.
local function slow_record(player_id, sprite_id)
  local session = sessions[player_id]

  if not session or session.record_id ~= sprite_id then
    return
  end

  NetGames.update_ui_element(sprite_id, player_id, { ro = 0 })

  NetGames.rotate_ui_element(sprite_id, player_id, 360, RECORD.slow_duration, "linear",
    function(_, interrupted)
      if not interrupted and sessions[player_id] == session and session.record_id == sprite_id then
        slow_record(player_id, sprite_id)
      end
    end
  )
end

-- Begin the faster rotation that transitions into the idle spin.
local function rotate_record(player_id)
  local session = sessions[player_id]
  if not session or not session.record_id then return end

  local sprite_id = session.record_id

  NetGames.stop_ui_animation(sprite_id, player_id)
  NetGames.update_ui_element(sprite_id, player_id, { ro = 0 })

  NetGames.rotate_ui_element(sprite_id, player_id, 360, RECORD.fast_duration, "linear",
    function(_, interrupted)
      if not interrupted and sessions[player_id] == session and session.record_id == sprite_id then
        slow_record(player_id, sprite_id)
      end
    end
  )
end

-- ============================================================================
-- TRACK LIST, SELECTION AND UNLOCK REFRESH
-- ============================================================================
-- Scroll the visible list just far enough to contain the selected track.
local function update_list_window(session)
  if session.track_position < session.list_start then
    session.list_start = session.track_position
  end

  local last_visible = session.list_start + SONG_LIST.visible - 1

  if session.track_position > last_visible then
    session.list_start = session.track_position - SONG_LIST.visible + 1
  end
end

-- Remove all currently visible song-title sprites.
function clear_track_list(player_id)
  for i = 1, SONG_LIST.visible do
    TextAPI.removeStatic(player_id, SONG_LIST.id_prefix .. i)
  end
end

-- Render the current album's visible tracks and selection colors.
function draw_track_list(player_id)
  local session = sessions[player_id]
  if not session then return end

  clear_track_list(player_id)
  update_list_window(session)

  local current_song = Net.get_song(session.area_id)

  local album = session.albums[session.album_index]
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

      TextAPI.draw(player_id, SONG_LIST.id_prefix .. line, title, SONG_LIST.x, SONG_LIST.y + (line - 1) * SONG_LIST.line_height,
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

-- Update the highlighted track and record art without replaying music.
local function select_preview(player_id, index)
  local session = sessions[player_id]
  local track = TrackItems[index]

  if not session or not track or session.current_index == index then
    return
  end

  local previous_track = TrackItems[session.current_index]
  local previous_record = session.record_id

  local same_album = previous_track and previous_track.record_label == track.record_label

  -- Preserve the current rotation angle when switching record variants.
  local angle = 0

  if same_album and previous_record then
    local sprite = NetGames.get_ui_element_proxy(previous_record, player_id)

    if sprite then
      angle = (sprite.ro or 0) % 360
    end
  end

  if add_record_ui(player_id, track.record_label, track.record_kind)
      and session.record_id ~= previous_record then
    if same_album then
      local sprite_id = session.record_id

      -- Continue the rotation from the previous angle.
      NetGames.update_ui_element(sprite_id, player_id, {ro = angle})

      NetGames.rotate_ui_element(sprite_id, player_id, 360, RECORD.slow_duration * (360 - angle) / 360, "linear",
        function(_, interrupted)
          if not interrupted and sessions[player_id] == session and session.record_id == sprite_id then
            slow_record(player_id, sprite_id)
          end
        end
      )
    else
      rotate_record(player_id)
    end
  end

  session.current_index = index
  draw_track_list(player_id)
end

-- Rebuild open restricted menus while preserving selection when possible.
refresh_unlocked_sessions = function(user_key)
  local unlocked_albums

  for player_id, session in pairs(sessions) do
    if session.music_locked
        and session.user_key == user_key then

      -- Build the updated catalog only once.
      if not unlocked_albums then
        unlocked_albums = get_unlocked_albums(user_key)
      end

      local previous_album = session.albums[session.album_index]

      local previous_album_name = previous_album and previous_album.name

      local previous_track_index = session.current_index
      local album_index = 1

      -- Preserve the currently selected album.
      if previous_album_name then
        for index, album in ipairs(unlocked_albums) do
          if album.name == previous_album_name then
            album_index = index
            break
          end
        end
      end

      local album = unlocked_albums[album_index]
      local selected_index = album and album.indices[1]
      local track_position = 1

      -- Preserve the selected track when possible.
      if album and previous_album_name == album.name then
        for position, track_index in ipairs(album.indices) do
          if track_index == previous_track_index then
            selected_index = track_index
            track_position = position
            break
          end
        end
      end

      -- Apply the refreshed catalog to the session.
      session.albums = unlocked_albums
      session.album_index = album_index
      session.track_position = track_position

      -- Update the album title only when necessary.
      if previous_album_name ~= (album and album.name) then
        session.list_start = 1

        draw_album_title(player_id, album and album.name or "No musics available")
      end

      -- Update the record and visible track list.
      if selected_index and selected_index ~= previous_track_index then

        select_preview(player_id, selected_index)
      else
        session.current_index = selected_index
        draw_track_list(player_id)
      end
    end
  end
end


-- ============================================================================
-- ALBUM NAVIGATION AND MUSIC PLAYBACK
-- ============================================================================
-- Select the next or previous album, wrapping around at either end.
local function change_album(player_id, direction)
  local session = sessions[player_id]
  local albums = session and session.albums
  if not albums or #albums == 0 then return end

  local old_index = session.album_index
  local new_index = (old_index - 1 + direction) % #albums + 1

  if new_index == old_index and session.track_position == 1 then
    return
  end

  session.album_index = new_index
  session.track_position = 1
  session.list_start = 1

  local album = albums[new_index]

  if new_index ~= old_index then
    draw_album_title(player_id, album.name)
  end

  select_preview(player_id, album.indices[1])
end

-- Select the next or previous track inside the active album.
local function change_track(player_id, direction)
  local session = sessions[player_id]
  if not session then return end

  local album = session.albums[session.album_index]
  if not album or #album.indices <= 1 then return end

  session.track_position = (session.track_position - 1 + direction) % #album.indices + 1

  select_preview(player_id, album.indices[session.track_position])
end

-- Validate a song request, play it, and persist area music when enabled.
local function requestJukeboxSong(player_id, index)
  local area_id = Net.get_player_area(player_id)
  if not area_id then
    log:info("[Jukebox] requestJukeboxSong: player " .. tostring(player_id)
      .. " has no area")
    return
  end

  local active_session = sessions[player_id]

  if not active_session or active_session.area_id ~= area_id then
    return
  end

  local track = TrackItems[index]
  if not track then
    log:info("[Jukebox] requestJukeboxSong: no track at index " .. tostring(index))
    return
  end

  if active_session.music_locked then
    local album = active_session.albums[active_session.album_index]

    if not album
        or album.indices[active_session.track_position] ~= index
        or not is_music_unlocked(active_session.user_key, track) then
      return
    end
  end

  local track_path = track.path

  local ok_song, song_result = pcall(Net.set_song, area_id, track_path)
  if not ok_song or song_result == false then
    log:error("[Jukebox] set_song failed for " .. tostring(track_path) .. ": " .. tostring(song_result))
    return
  end

  local session = sessions[player_id]

  if session and session.music_perma
      and music_data[area_id] ~= track_path then

    local previous_path = music_data[area_id]
    music_data[area_id] = track_path

    if not save_music_data() then
      music_data[area_id] = previous_path
      log:error("[Jukebox] Failed to save music for area: " .. area_id)
    end
  end

  for other_player_id, session in pairs(sessions) do
    if session.area_id == area_id then
      draw_track_list(other_player_id)
    end
  end
end


-- ============================================================================
-- JUKEBOX UI LIFECYCLE
-- ============================================================================
-- Create the menu visuals for the player's current music catalog.
local function spawnJukeboxUI(player_id)
  add_static_ui(player_id, "Shade Screen")
  add_static_ui(player_id, "Jukebox Backdrop")

  local albums = sessions[player_id].albums
  local initial_album = albums[1] and albums[1].name

  if initial_album then
    local track = TrackItems[albums[1].indices[1]]

    if add_record_ui(player_id, initial_album, track.record_kind) then
      slow_record(player_id, sessions[player_id].record_id)
    end
  end

  add_static_ui(player_id, "Jukebox Frame")
  add_static_ui(player_id, "Jukebox Cursor Up")
  add_static_ui(player_id, "Jukebox Cursor Down")
  add_static_ui(player_id, "Jukebox Cursor Left")
  add_static_ui(player_id, "Jukebox Cursor Right")

  draw_album_title(player_id, initial_album or "No musics available")
  draw_track_list(player_id)
end

-- Remove menu sprites and text, including the session's current record.
local function removeJukeboxUI(player_id, session)
  local sprite_id = session and session.record_id

  if sprite_id then
    pcall(NetGames.remove_ui_element, sprite_id, player_id)

    if type(Net.player_dealloc_sprite) == "function" then
      pcall(Net.player_dealloc_sprite, player_id, sprite_id)
    end
  end

  pcall(clear_track_list, player_id)

  for _, name in ipairs(UIData.UIIDNames) do
    pcall(NetGames.remove_ui_element, name, player_id)
  end

  pcall(clear_title, player_id)
end


-- ============================================================================
-- PLAYER SESSION LIFECYCLE
-- ============================================================================
-- Create a session and load its normal or restricted album catalog.
local function openJukeboxMenu(player_id, area_id, object_id, on_close, options)
  if #AlbumItems == 0 then return false end

  local session = sessions[player_id]

  if session then
    if on_close then
      session.on_close = on_close
    end

    return true
  end

  area_id = area_id or Net.get_player_area(player_id)

  local object = object_id and Net.get_object_by_id(area_id, object_id)
  local properties = object and object.custom_properties or {}
  local locked = properties.music_locked == true or properties.music_locked == "true"
  local albums = AlbumItems
  local user_key

  -- Only check unlocks in locked mode.
  if locked then
    if not load_users_music() then return false end

    user_key = get_music_user_key(player_id)
    if not user_key then return false end

    albums = get_unlocked_albums(user_key)
  end

  sessions[player_id] = {
    album_index = 1,
    track_position = 1,
    current_index = albums[1] and albums[1].indices[1],
    list_start = 1,
    albums = albums,
    user_key = user_key,
    area_id = area_id,
    cursor_time = 0,
    cursor_offset = 0,
    record_id = nil,
    on_close = on_close,
    control_parent = options and options.parent,
    music_perma = properties.music_perma == true or properties.music_perma == "true",
    music_locked = locked,
  }
  provide_base_ui_assets(player_id)

  Jukebox:emit("Jukebox Open", {
    player_id = player_id,
    area_id = area_id,
    object_id = object_id
  })

  return sessions[player_id] ~= nil
end

-- End the session, emit the close event, and optionally return control.
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
      log:error("[Jukebox] open() callback failed for "
        .. tostring(player_id) .. ": " .. tostring(err))
    end
  end
end

-- ============================================================================
-- PUBLIC INTERFACE
-- ============================================================================
-- Expose a guarded opening entry point for other modules.
local function open_jukebox_ui(player_id, on_close, object_id, options)
  if type(object_id) == "table" and options == nil then
    options = object_id
    object_id = nil
  end
  if not player_id then return false end
  if type(Net.is_player) == "function" then
    local ok, alive = pcall(Net.is_player, player_id)
    if ok and not alive then return false end
  end
  local area_id = Net.get_player_area(player_id)
  if not area_id then return false end
  return openJukeboxMenu(player_id, area_id, object_id, on_close, options)
end

-- Expose a close operation that does not invoke the return callback.
local function close_jukebox_ui(player_id)
  if not player_id then return end
  closeJukeboxMenu(player_id, true)
end

-- ============================================================================
-- EVENT HANDLERS
-- ============================================================================
-- Claim input and render the menu for a newly created session.
Jukebox:on("Jukebox Open", function(event)
  local player_id = event.player_id
  local ctrl, owner = acquire_input(player_id)

  if not ctrl then
    sessions[player_id] = nil
    return -- open() reports false; caller can restore its parent safely.
  end

  local context=sessions[player_id]
  if context and context.control then
    context.control:on_close(function()
      -- A forced session close must dispose the UI even if the ordinary
      -- Jukebox Close event was never raised.
      if sessions[player_id] == context then
        sessions[player_id] = nil
        local ok, err=pcall(removeJukeboxUI, player_id, context)
        if not ok then log:info("[Jukebox] forced UI cleanup: "..tostring(err)) end
      end
    end)
  end

  local ui_ok, ui_err = pcall(spawnJukeboxUI, player_id)

  if not ui_ok then
    log:error("[Jukebox] spawnJukeboxUI failed: "
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
      -- A suspended child must not receive the parent or another UI's input.
      if not session.control or not session.control:is_current() then
        Async.await(Async.sleep(0.2))
      else
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
        Jukebox:emit("Jukebox Request Song", {player_id = player_id, index = session.current_index})
      end

      ctrl:consume(owner)
      Async.await(Async.sleep(0.2))
      end
    end
  end))
end)

-- Return input and HUD control, then remove this session's UI.
Jukebox:on("Jukebox Close", function(event)
  local player_id = event.player_id

  local ok, err = pcall(removeJukeboxUI, player_id, event.session)
  if not ok then log:error("[Jukebox] UI cleanup failed: " .. tostring(err)) end
  if event.session and event.session.control then
    event.session.control:close()
  end
end)

-- Route confirmation events through playback validation.
Jukebox:on("Jukebox Request Song", function(event)
  requestJukeboxSong(event.player_id, event.index)
end)

-- End the menu if the player is transferred to another area.
Net:on("player_area_transfer", function(event)
  if sessions[event.player_id] then
    closeJukeboxMenu(event.player_id, true)
  end
end)

-- Animate cursors only while their Jukebox sessions remain active.
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

      NetGames.update_ui_element("Jukebox Cursor Down", player_id, {y = UIData.UIData["Jukebox Cursor Down"].y - offset})
      NetGames.update_ui_element("Jukebox Cursor Left", player_id, {x = UIData.UIData["Jukebox Cursor Left"].x + offset})
      NetGames.update_ui_element("Jukebox Cursor Right", player_id, {x = UIData.UIData["Jukebox Cursor Right"].x - offset})

    end
  end
end)

-- Open the Jukebox only for the interact button on a Jukebox object.
Net:on("object_interaction", function(event)
  if event.button ~= 0 then return end

  local area_id = Net.get_player_area(event.player_id)
  if not area_id then return end

  local object = Net.get_object_by_id(area_id, event.object_id)

  if not object or (object.class ~= "Jukebox"
      and object.type ~= "Jukebox") then
    return
  end

  openJukeboxMenu(event.player_id, area_id, event.object_id)
end)


-- Release session state and record animation when a player disconnects.
Net:on("player_disconnect", function(event)
  local player_id = event.player_id
  local session = sessions[player_id]

  if session and session.control then session.control:close() end
  sessions[player_id] = nil

  if session and session.record_id then
    pcall(NetGames.stop_ui_animation, session.record_id, player_id)
  end
end)

-- ============================================================================
-- MODULE EXPORTS
-- ============================================================================
-- Keep the external API unchanged for existing integrations.
local public_api = {
  open = open_jukebox_ui,
  close = close_jukebox_ui,
  emitter = Jukebox,
  get_tracks = function() return TrackItems end,
  unlock_music = unlock_music,
  unlock_album = unlock_album,
  get_albums = function()
    local albums = {}

    for i, album in ipairs(AlbumItems) do
      albums[i] = album.name
    end

    return albums
  end,
}

-- Set only after successful initialization. Repeated loads in this Lua state
-- return the same API without rescanning music or adding duplicate listeners.
rawset(_G, "__jukebox_main_initialized", public_api)
return public_api
