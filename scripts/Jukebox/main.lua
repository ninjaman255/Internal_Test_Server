--[[
* ---------------------------------------------------------- *
                 Jukebox v2.1 by D3str0y3d
	 https://github.com/ninjaman255/Server_12_22_2021_Jukebox
* ---------------------------------------------------------- *
]]

local Utils = require("scripts/jukebox/utils")
local Paths = require("scripts/jukebox/constants/paths")
local NetGames = require("scripts/net-games/main")
local TextLayout = require("scripts/displayer/text-layout")
local Emitter = require("scripts/utils/event-emitter")
local UIData = require("scripts/jukebox/constants/ui-data")
local InputAPI = require("scripts/input-controller/main")

-- Resolve the text API. Prefer NetGames.Text if the net-games module
-- re-exports the displayer; otherwise require the displayer module
-- directly. Only the marquee-capable path (Text.draw + Text.removeMarquee)
-- matters here; everything else uses NetGames.* as before.
local TextAPI = nil
if type(NetGames.Text) == "table" then
  TextAPI = NetGames.Text
else
  local ok, mod = pcall(require, "scripts/displayer/displayer")
  if ok and type(mod) == "table" and type(mod.Text) == "table" then
    TextAPI = mod.Text
  end
end

local Jukebox = Emitter.new()

local open_sessions = {}
local open_callbacks = {}

function async(p)
  local co = coroutine.create(p)
  return Async.promisify(co)
end

function await(v) return Async.await(v) end

print("[Jukebox] Loading the groove!")

local Songs = {}
local SongRecordsDir
local SongList
local AllMapsWithTypedObjects
local JukeboxObjectCache
local BaseGatherPath = "./assets/jukebox/tracks/"

local function gatherDirectoryContents(path)
  return Utils.listFilesDetailed(path)
end

SongRecordsDir = gatherDirectoryContents(BaseGatherPath)

local function gatherAllMusic()
  local song_list = {}
  if SongRecordsDir == nil then SongRecordsDir = {} end
  for i = 1, #SongRecordsDir do
    local Dir = SongRecordsDir[i]
    if Dir.is_dir ~= false then
      song_list[Dir.name] = Utils.listFiles(BaseGatherPath .. Dir["name"] .. "/")
    end
  end
  return song_list
end

SongList = gatherAllMusic()

local function gatherAllMapsAndObjects()
  local area_names = Net.list_areas()
  local out = {}
  for i = 1, #area_names do
    local area_id = area_names[i]
    local objects = Net.list_objects(area_id)
    out[area_id] = out[area_id] or {}
    for j = 1, #objects do
      local obj = Net.get_object_by_id(area_id, objects[j])
      local t = ""
      if obj.type ~= "" then t = obj.type
      elseif obj.class ~= "" then t = obj.class end
      if t ~= "" then
        out[area_id][t] = out[area_id][t] or {}
        table.insert(out[area_id][t], obj)
      end
    end
  end
  return out
end

AllMapsWithTypedObjects = gatherAllMapsAndObjects()

local function gatherAllJukeboxes(maps)
  local cache = {}
  for name, value in pairs(maps) do
    cache[name] = cache[name] or {}
    for _, objects in pairs(value) do
      for i = 1, #objects do
        if objects[i].type == "Jukebox" or objects[i].class == "Jukebox" then
          table.insert(cache[name], objects[i])
        end
      end
    end
  end
  return cache
end

JukeboxObjectCache = gatherAllJukeboxes(AllMapsWithTypedObjects)

Net:on("player_join", function(event)
  for name, value in pairs(SongList) do
    for area_id in pairs(JukeboxObjectCache) do
      for i = 1, #value do
        pcall(Net.provide_asset, area_id,
          "/server/assets/jukebox/tracks/" .. name .. "/" .. value[i])
      end
    end
  end
end)

local function sorted_albums()
  local albums = {}
  for name in pairs(SongList) do albums[#albums + 1] = name end
  table.sort(albums)
  return albums
end

local function first_album()
  return sorted_albums()[1]
end

local function record_art_path(album_name, kind)
  if not album_name or album_name == "" then return nil end
  kind = kind or "base"
  return "/server/assets/jukebox/records/" .. album_name .. "/" .. kind .. ".png"
end

local function track_path_for(track)
  if not track or not track.record_label or not track.title then return nil end
  return "/server/assets/jukebox/tracks/" .. track.record_label .. "/" .. track.title
end

local function compileTracks(song_list)
  local items = {}
  local index = 0
  for _, name in ipairs(sorted_albums()) do
    local songs = song_list[name]
    if type(songs) == "table" then
      for i = 1, #songs do
        index = index + 1
        table.insert(items, {
          index = index,
          title = songs[i],
          record_label = name,
          author = name,
          duration = 0,
        })
      end
    end
  end
  return items
end

local TrackItems = compileTracks(SongList)
print("[Jukebox] " .. tostring(#TrackItems) .. " track(s) across "
  .. tostring(#sorted_albums()) .. " album(s)")

-- ===================================================================--
-- Title display (marquee text + flanking cursors)
--
-- Marquee bounds (240x160 screen space):
--   top-left     = (56, 93)
--   bottom-right = (183, 112)
--   width        = 127
--   height       = 19
-- Loops forever (loops = nil in the displayer means infinite).
--
-- The marquee scrolls its text horizontally inside those bounds. Cursors
-- sit at fixed positions on the left and right of the viewport, framing
-- the scroll area rather than tracking the text width, so they don't
-- jitter as the title scrolls.
-- ===================================================================--
local SCREEN_W = 240
local SCREEN_H = 160

local TITLE_TEXT_ID = "Jukebox Title"
local TITLE_FONT = "THICK"
local TITLE_SCALE = 2.0
local TITLE_Z = 5

-- Marquee viewport bounds
local MARQUEE_X = 76
local MARQUEE_Y = 96
local MARQUEE_W = 90   -- 183 - 56
local MARQUEE_H = 20    -- 112 - 93
local MARQUEE_SPEED = 60  -- pixels per second

-- Cursors: fixed at the viewport's left/right edges.
local CURSOR_TEXTURE   = "/server/assets/net-games/text_cursor.png"
local CURSOR_ANIMATION = "/server/assets/net-games/text_cursor.animation"
local CURSOR_SCALE = 2.0
local CURSOR_WIDTH = 16   -- 8x8 base at scale 2
local CURSOR_GAP = 4
local CURSOR_Y = MARQUEE_Y + math.floor((MARQUEE_H - CURSOR_WIDTH) / 2)
local CURSOR_LEFT_X  = MARQUEE_X - CURSOR_GAP - CURSOR_WIDTH   -- 36
local CURSOR_RIGHT_X = MARQUEE_X + MARQUEE_W + CURSOR_GAP       -- 187

local function strip_extension(title)
  if not title then return "" end
  return (title:gsub("%.ogg$", ""))
end

local function measure_title_width(title)
  if not title or #title == 0 then return 0 end
  local ok, width = pcall(TextLayout.measureLine, title,
    { font = TITLE_FONT, scale = TITLE_SCALE })
  if ok and type(width) == "number" and width > 0 then
    return width
  end
  return #title * 6 * TITLE_SCALE
end

local function clear_title(player_id)
  -- Try every removal API the stack may expose; harmless if some are
  -- absent (all pcall-wrapped).
  if TextAPI then
    if TextAPI.removeMarquee then
      pcall(TextAPI.removeMarquee, player_id, TITLE_TEXT_ID)
    end
    if TextAPI.removeStatic then
      pcall(TextAPI.removeStatic, player_id, TITLE_TEXT_ID)
    end
  end
  if NetGames.remove_text then
    pcall(NetGames.remove_text, TITLE_TEXT_ID, player_id)
  end
end

local function draw_track_title(player_id, track)
  clear_title(player_id)
  if not track then return end
  local title = strip_extension(track.title)
  if title == "" then return end

  -- Prefer the unified marquee API. On success, return; on failure, log
  -- and fall through to the static centered fallback so the title is
  -- still visible.
  if TextAPI and type(TextAPI.draw) == "function" then
    local ok, err = pcall(TextAPI.draw,
      player_id, TITLE_TEXT_ID, title, MARQUEE_X, MARQUEE_Y,
      {
        mode = "marquee",
        font = TITLE_FONT,
        scale = TITLE_SCALE,
        z = TITLE_Z,
        width = MARQUEE_W,
        height = MARQUEE_H,
        marquee = { speed = MARQUEE_SPEED, loops = nil },
      })
    if ok then return end
    print("[Jukebox] marquee draw failed: " .. tostring(err)
      .. " - falling back to static text")
  end

  local width = measure_title_width(title)
  local x = math.floor(MARQUEE_X + (MARQUEE_W - width) / 2)
  if x < MARQUEE_X then x = MARQUEE_X end
  pcall(NetGames.draw_text, TITLE_TEXT_ID, player_id, title,
    x, MARQUEE_Y, TITLE_Z, TITLE_FONT, TITLE_SCALE)
end

local function update_title_display(player_id, track)
  draw_track_title(player_id, track)
  -- Cursor positions are fixed at the marquee bounds; no per-update
  -- repositioning needed. They're placed once in spawnJukeboxUI.
end

-- ===================================================================--
-- Input ownership
-- ===================================================================--
local INPUT_OWNER_PREFIX = "jukebox:"
local function input_owner(player_id)
  return INPUT_OWNER_PREFIX .. tostring(player_id)
end

local LEFT_ACTIONS    = { "Left",     "UpLeft",    "DownLeft" }
local RIGHT_ACTIONS   = { "Right",    "UpRight",   "DownRight" }
local CANCEL_ACTIONS  = { "Cancel" }
local CONFIRM_ACTIONS = { "Confirm" }

local function any_action_pressed(ctrl, owner, actions)
  for _, action in ipairs(actions) do
    if ctrl:is_action_pressed(action, owner) then return true end
  end
  return false
end

local function any_action_repeated(ctrl, owner, actions)
  for _, action in ipairs(actions) do
    if ctrl:is_action_repeated(action, owner) then return true end
  end
  return false
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
local BASE_UI_ASSETS = {
  "/server/assets/jukebox/ui-sprites/shade-screen.png",
  "/server/assets/jukebox/ui-sprites/jukebox-backdrop.png",
  "/server/assets/jukebox/ui-sprites/jukebox-frame.png",
  "/server/assets/jukebox/ui-sprites/records/record.animation",
  CURSOR_TEXTURE,
  CURSOR_ANIMATION,
}

local function provide_base_ui_assets(player_id, initial_album)
  for _, path in ipairs(BASE_UI_ASSETS) do
    pcall(Net.provide_asset_for_player, player_id, path)
  end
  if initial_album then
    local art = record_art_path(initial_album, "base")
    if art then pcall(Net.provide_asset_for_player, player_id, art) end
  end
end

local function add_record_ui(player_id, album_name)
  local record_art = record_art_path(album_name, "base")
  if not record_art then return false end
  pcall(Net.provide_asset_for_player, player_id, record_art)

  local ok_upd, upd_res = pcall(NetGames.update_ui_element,
    "Default Record", player_id, { texture_path = record_art })
  if ok_upd and upd_res == true then return true end

  pcall(NetGames.remove_ui_element, "Default Record", player_id)
  local ok_add, add_res = pcall(NetGames.add_ui_element,
    "Default Record", player_id,
    record_art,
    "/server/assets/jukebox/ui-sprites/records/record.animation",
    "DEFAULT",
    120, 79, 2, 2.0, 2.0, SCREEN_W, SCREEN_H)
  if not ok_add or add_res == false then
    print("[Jukebox] add_ui_element for Default Record failed: " ..
      tostring(add_res))
    return false
  end
  pcall(NetGames.rotate_ui_element,
    "Default Record", player_id, 360, 0.5, "linear", function() end, true)
  return true
end

local function spawnJukeboxUI(player_id)
  NetGames.add_ui_element("Shade Screen", player_id,
    "/server/assets/jukebox/ui-sprites/shade-screen.png", "", "",
    0, 0, 0, 2.0, 2.0, SCREEN_W, SCREEN_H)

  NetGames.add_ui_element("Jukebox Backdrop", player_id,
    "/server/assets/jukebox/ui-sprites/jukebox-backdrop.png", "", "",
    0, 1, 0, 2.0, 2.0, SCREEN_W, SCREEN_H)

  local initial_album = first_album()
  if initial_album then
    add_record_ui(player_id, initial_album)
  else
    print("[Jukebox] no albums found under " .. BaseGatherPath
      .. "; skipping initial record art")
  end

  NetGames.add_ui_element("Jukebox Frame", player_id,
    "/server/assets/jukebox/ui-sprites/jukebox-frame.png", "", "",
    0, 0, 3, 2.0, 2.0, SCREEN_W, SCREEN_H)

  -- Cursors are placed once at the marquee viewport edges. Marquee bounds
  -- are fixed for the UI's lifetime, so no repositioning is needed when
  -- the selected track changes.
  NetGames.add_ui_element("Cursor Left", player_id,
    CURSOR_TEXTURE, CURSOR_ANIMATION, "CURSOR_LEFT",
    CURSOR_LEFT_X, CURSOR_Y, TITLE_Z, CURSOR_SCALE, CURSOR_SCALE)

  NetGames.add_ui_element("Cursor Right", player_id,
    CURSOR_TEXTURE, CURSOR_ANIMATION, "CURSOR_RIGHT",
    CURSOR_RIGHT_X, CURSOR_Y, TITLE_Z, CURSOR_SCALE, CURSOR_SCALE)

  -- Initial marquee text for the first track.
  update_title_display(player_id, TrackItems[1])
end

local function removeJukeboxUI(player_id)
  for i = 1, #UIData.UIIDNames do
    pcall(NetGames.remove_ui_element, UIData.UIIDNames[i], player_id)
  end
  clear_title(player_id)
end

-- ===================================================================--
-- Open / close
-- ===================================================================--
local function openJukeboxMenu(player_id, area_id, object_id)
  if open_sessions[player_id] then return true end
  open_sessions[player_id] = { current_index = 1 }
  provide_base_ui_assets(player_id, first_album())
  Jukebox:emit("Jukebox Open",
    { player_id = player_id, area_id = area_id, object_id = object_id })
  return true
end

local function closeJukeboxMenu(player_id)
  if not open_sessions[player_id] then return end
  open_sessions[player_id] = nil
  Jukebox:emit("Jukebox Close", {player_id = player_id})
  local cb = open_callbacks[player_id]
  if cb then
    open_callbacks[player_id] = nil
    local ok, err = pcall(cb, player_id)
    if not ok then
      print("[Jukebox] open() callback failed for " ..
        tostring(player_id) .. ": " .. tostring(err))
    end
  end
end

-- ===================================================================--
-- Track selection
-- ===================================================================--
local function select_preview(player_id, index)
  local track = TrackItems[index]
  if not track then return end
  add_record_ui(player_id, track.record_label)
  update_title_display(player_id, track)
end

local function requestJukeboxSong(player_id, index, should_close)
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

  local track_path = track_path_for(track)
  local album_art = record_art_path(track.record_label, "base")
  if not track_path then
    print("[Jukebox] requestJukeboxSong: track has no path")
    return
  end

  local ok_prov, err_prov = pcall(Net.provide_asset, area_id, track_path)
  if not ok_prov then
    print("[Jukebox] provide_asset failed for " .. tostring(track_path)
      .. ": " .. tostring(err_prov))
  end
  if album_art then
    pcall(Net.provide_asset_for_player, player_id, album_art)
  end

  local ok_song, err_song = pcall(Net.set_song, area_id, track_path)
  if not ok_song then
    print("[Jukebox] set_song failed for " .. tostring(track_path)
      .. ": " .. tostring(err_song))
  end

  if open_sessions[player_id] then
    if album_art then add_record_ui(player_id, track.record_label) end
    update_title_display(player_id, track)
  end

  if should_close then
    closeJukeboxMenu(player_id)
  end
end

-- ===================================================================--
-- Event handlers
-- ===================================================================--
Jukebox:on("Jukebox Open", function(event)
  local player_id = event.player_id
  local ctrl, owner = acquire_input(player_id)
  if not ctrl then
    open_sessions[player_id] = nil
    local cb = open_callbacks[player_id]
    open_callbacks[player_id] = nil
    if cb then pcall(cb, player_id) end
    return
  end

  Net.lock_player_input(player_id)
  Net.toggle_player_hud(player_id)

  local ui_ok, ui_err = pcall(spawnJukeboxUI, player_id)
  if not ui_ok then
    print("[Jukebox] spawnJukeboxUI failed: " .. tostring(ui_err))
  end

  async(function()
    await(Async.sleep(0.1))

    while open_sessions[player_id] do
      local session = open_sessions[player_id]
      if not session then break end

      if any_action_pressed(ctrl, owner, CANCEL_ACTIONS) then
        closeJukeboxMenu(player_id)
        break
      end

      if any_action_pressed(ctrl, owner, LEFT_ACTIONS)
        or any_action_repeated(ctrl, owner, LEFT_ACTIONS) then
        if #TrackItems > 0 then
          session.current_index = session.current_index > 1
            and (session.current_index - 1) or #TrackItems
          select_preview(player_id, session.current_index)
        end
      elseif any_action_pressed(ctrl, owner, RIGHT_ACTIONS)
        or any_action_repeated(ctrl, owner, RIGHT_ACTIONS) then
        if #TrackItems > 0 then
          session.current_index = session.current_index < #TrackItems
            and (session.current_index + 1) or 1
          select_preview(player_id, session.current_index)
        end
      end

      if any_action_pressed(ctrl, owner, CONFIRM_ACTIONS) then
        Jukebox:emit("Jukebox Request Song", {
          player_id = player_id,
          index = session.current_index,
          should_close = true,
        })
        break
      end

      ctrl:consume(owner)
      await(Async.sleep(0.05))
    end
  end)
end)

Jukebox:on("Jukebox Close", function(event)
  local player_id = event.player_id
  release_input_for(player_id)
  Net.unlock_player_input(player_id)
  Net.toggle_player_hud(player_id)
  removeJukeboxUI(player_id)
end)

Jukebox:on("Jukebox Request Song", function(event)
  requestJukeboxSong(event.player_id, event.index, event.should_close)
end)

Net:on("object_interaction", function(event)
  local area_id = Net.get_player_area(event.player_id)
  local object = Net.get_object_by_id(area_id, event.object_id)
  if object.class ~= "Jukebox" then return end
  if object.type ~= "Jukebox" then return end
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
  if on_close then open_callbacks[player_id] = on_close end
  return openJukeboxMenu(player_id, area_id, nil)
end

local function close_jukebox_ui(player_id)
  if not player_id then return end
  open_callbacks[player_id] = nil
  closeJukeboxMenu(player_id)
end

Net:on("player_disconnect", function(event)
  open_sessions[event.player_id] = nil
  open_callbacks[event.player_id] = nil
end)

return {
  open = open_jukebox_ui,
  close = close_jukebox_ui,
  emitter = Jukebox,
  get_tracks = function() return TrackItems end,
  get_albums = function() return sorted_albums() end,
}