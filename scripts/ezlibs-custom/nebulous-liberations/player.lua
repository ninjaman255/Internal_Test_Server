local ezmemory = require("scripts/ezlibs-scripts/ezmemory")
local helpers = require('scripts/ezlibs-scripts/helpers')
local ezlogger = require("scripts/ezlibs-scripts/ezlogger")
local log = ezlogger.get("nebulous-liberations")

-- private functions

local function create_textbox_promise(self)
  if self.disconnected then
    return Async.create_promise(function(resolve)
      resolve()
    end)
  end

  return Async.create_promise(function(resolve)
    table.insert(self.textbox_promise_resolvers, resolve)
  end)
end

local BattleReason = {
  DRAW = 0,
  WIN = 1,
  LOSE = 2,
  RUN = 3,
  USER_PANIC = 4,
}

-- Only these two explicit end reasons are considered a forced exit.
-- DRAW and LOSE are ordinary battle outcomes, not panics.
local function stats_indicate_panic(stats)
  if not stats then return false end
  local reason = tonumber(stats.reason)
  return reason == BattleReason.RUN or reason == BattleReason.USER_PANIC
end

-- public
local Player = {}

function Player:new(player_id)
  local position = Net.get_player_position(player_id)

  local player = {
    id = player_id,
    activity = nil,
    mug = Net.get_player_mugshot(player_id),
    textbox_promise_resolvers = {},
    resolve_battle = nil,
    pending_battle_stats = nil,
    battle_exit_fallback_token = nil,
    avatar_details = nil,
    moved = false,
    x = position.x,
    y = position.y,
    z = position.z,
    disconnected = false
  }

  setmetatable(player, self)
  self.__index = self

  return player
end

function Player:message(message, texture_path, animation_path)
  Net.message_player(self.id, message, texture_path, animation_path)
  return create_textbox_promise(self)
end

function Player:message_with_mug(message)
  return self:message(message, self.mug.texture_path, self.mug.animation_path)
end

-- Fire-and-forget informational message. Does NOT push a resolver, so it
-- cannot hang the caller if the client never renders/dismisses the textbox
-- (which can happen right after a battle exit). Use this for flavor text.
function Player:say(message, texture_path, animation_path)
  if self.disconnected then return end
  Net.message_player(self.id, message, texture_path, animation_path)
end

function Player:say_with_mug(message)
  self:say(message, self.mug.texture_path, self.mug.animation_path)
end

function Player:question(question, texture_path, animation_path)
  Net.question_player(self.id, question, texture_path, animation_path)
  return create_textbox_promise(self)
end

function Player:question_with_mug(question)
  return self:question(question, self.mug.texture_path, self.mug.animation_path)
end

function Player:quiz(a, b, c, texture_path, animation_path)
  Net.quiz_player(self.id, a, b, c, texture_path, animation_path)
  return create_textbox_promise(self)
end

-- Mugshot-flavored quiz. Used by the liberation flow so the player's own
-- portrait accompanies the "Liberation / Pass / Cancel" prompts; the
-- order-points value is now shown by PointsGauge, not by the mugshot.
function Player:quiz_with_mug(a, b, c)
  return self:quiz(a, b, c, self.mug.texture_path, self.mug.animation_path)
end

function Player:is_battling()
  return self.resolve_battle ~= nil
end

local function create_default_results()
  return {
    reason = 1,
    health = 1,
    time = 0,
    ran = true,
    emotion = 0,
    enemies = {},
    turns = 3,
    score = 0,
  }
end

function Player:initiate_encounter(asset_path, data)
  if self.disconnected then
    return Async.create_promise(function(resolve)
      resolve(create_default_results())
    end)
  end

  if self:is_battling() then
    error("This player is already in a battle")
  end

  Net.initiate_encounter(self.id, asset_path, data)

  return Async.create_promise(function(resolve)
    self.resolve_battle = resolve
  end)
end

function Player:handle_textbox_response(response)
  local pending = self.textbox_promise_resolvers and #self.textbox_promise_resolvers or 0
  local resolve = table.remove(self.textbox_promise_resolvers, 1)
  if resolve ~= nil then
    log:debug_data("textbox_response: resolver consumed", {
      player_id = self.id,
      response = response,
      pending_before = pending,
      pending_after = self.textbox_promise_resolvers and #self.textbox_promise_resolvers or 0,
    })
    resolve(response)
  else
    log:debug_data("textbox_response: stray (no pending resolver)", {
      player_id = self.id,
      response = response,
    })
  end
end

function Player:handle_battle_results(stats)
  local is_panic = stats_indicate_panic(stats)
  log:info_data("handle_battle_results: captured", {
    player_id = self.id,
    has_stats = stats ~= nil,
    has_pending_resolve = self.resolve_battle ~= nil,
    reason = stats and tostring(stats.reason) or nil,
    escape = stats and tostring(stats.escape) or nil,
    fled = stats and tostring(stats.fled) or nil,
    panicked = is_panic,
  })
  if not self.resolve_battle then
    return
  end
  self.pending_battle_stats = stats

  local fallback_delay = is_panic and 3.0 or 20.0
  local token = {}
  self.battle_exit_fallback_token = token
  local player_id = self.id
  Async.sleep(fallback_delay).and_then(function()
    if self.battle_exit_fallback_token ~= token then
      return
    end
    if not self.resolve_battle then
      return
    end
    log:warn_data("battle_exit did not fire; resolving via fallback", {
      player_id = player_id,
      delay_seconds = fallback_delay,
      panicked = is_panic,
    })
    self.battle_exit_fallback_token = nil
    local resolve = self.resolve_battle
    self.resolve_battle = nil
    local pending = self.pending_battle_stats or stats
    self.pending_battle_stats = nil
    resolve(pending or create_default_results())
  end)
end

function Player:handle_battle_exit(stats)
  self.battle_exit_fallback_token = nil

  local resolved = stats or self.pending_battle_stats
  local source
  if stats ~= nil then
    source = "battle_exit_event"
  elseif self.pending_battle_stats ~= nil then
    source = "pending_from_results"
  else
    source = "defaults"
  end
  self.pending_battle_stats = nil
  log:info_data("handle_battle_exit: resolving", {
    player_id = self.id,
    has_stats_arg = stats ~= nil,
    source = source,
    has_pending_resolve = self.resolve_battle ~= nil,
  })
  if not self.resolve_battle then
    return
  end
  local resolve = self.resolve_battle
  self.resolve_battle = nil
  resolve(resolved or create_default_results())
end

function Player:handle_disconnect()
  self.disconnected = true
  self.battle_exit_fallback_token = nil

  for _, resolve in ipairs(self.textbox_promise_resolvers) do
    resolve()
  end

  if self.resolve_battle then
    local resolve = self.resolve_battle
    self.resolve_battle = nil
    resolve(self.pending_battle_stats or create_default_results())
  end
  self.pending_battle_stats = nil

  self.textbox_promise_resolvers = nil

  if self.activity then
    self.activity:handle_player_disconnect(self.id)
  end
end

function Player:boot_to_lobby(isVictory, mapName)
  self.activity:handle_player_disconnect(self.id)
  self.activity = nil
  local area_id = Net.get_player_area(self.id)
  local respawn_area = Net.get_area_custom_property(area_id, "Respawn Area")
  local spawn = nil
  if respawn_area ~= nil then
    spawn = Net.get_object_by_name(respawn_area, "Liberation Respawn")
  else
    respawn_area = "default"
    spawn = Net.get_spawn_position("default")
  end
  Net.transfer_player(self.id, respawn_area, true, spawn.x, spawn.y, spawn.z)
  if isVictory then
    local gate_to_remove = nil
    for index, value in ipairs(Net.list_objects(respawn_area)) do
      local prospective_gate = Net.get_object_by_id(respawn_area, value)
      if prospective_gate.custom_properties["Liberation Map Name"] == mapName then
        gate_to_remove = prospective_gate
        break
      end
    end
    if gate_to_remove ~= nil then
      local safe_secret = helpers.get_safe_player_secret(self.id)
      local player_area_memory = ezmemory.get_player_area_memory(safe_secret,respawn_area)
      player_area_memory.hidden_objects[tostring(gate_to_remove.id)] = true
      ezmemory.save_player_memory(safe_secret)
    end
  end
  ezmemory.set_player_max_health(self.id, ezmemory.get_player_max_health(self.id), true)
  ezmemory.set_player_health(self.id, 9999)
end

return Player