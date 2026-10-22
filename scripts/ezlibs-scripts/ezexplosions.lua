local ezbus = require('scripts/ezlibs-scripts/ezbus')
local logger = require('scripts/ezlibs-scripts/ezlogger').get('ezexplosions')

local EXPLOSION_DURATION = .6

-- How long to keep the effect "alive" after the FINAL blast, so the last
-- bot's EXPLODE/SMOKE animation can finish playing.
--
-- Historical behavior: each bot slept its own full EXPLOSION_DURATION
-- (0.6s) after its last blast before self-removing. Because blasts are
-- staggered, the last bot's self-check fired 0.6s after the last visible
-- blast, producing a noticeable quiet gap before on_complete (and hence
-- any kick or other post-effect callback) ran.
--
-- This constant shortens that tail. When the counter hits 0, all other
-- bots are removed immediately (they've already fired) and this bot is
-- removed after EXPLOSION_TAIL_DURATION. Tune if animations are longer.
local EXPLOSION_TAIL_DURATION = 0.2
local EXPLOSION_AXIS_RANGE = .5

local function async(fn)
    local co = coroutine.create(fn)
    return Async.promisify(co)
end

local function await(value)
    return Async.await(value)
end

-- Refresh the effect's cached position from the tracked actor when it's
-- still alive. Returns true if the position was refreshed; false if the
-- actor has disappeared. On false, the previous position and area_id are
-- retained so remaining blasts can continue at the last-known location.
local function update_tracked_position(exploding_effect)
  local actor_id = exploding_effect.tracked_actor_id
  local area_id, position

  local ok_is_bot, is_bot = pcall(Net.is_bot, actor_id)
  if ok_is_bot and is_bot then
    local ok_area, a = pcall(Net.get_bot_area, actor_id)
    if ok_area then area_id = a end
    local ok_pos, p = pcall(Net.get_bot_position, actor_id)
    if ok_pos then position = p end
  else
    local ok_is_player, is_player = pcall(Net.is_player, actor_id)
    if ok_is_player and is_player then
      local ok_area, a = pcall(Net.get_player_area, actor_id)
      if ok_area then area_id = a end
      local ok_pos, p = pcall(Net.get_player_position, actor_id)
      if ok_pos then position = p end
    else
      -- Assume it's a tile object id, but only if we already know the area.
      -- This branch runs for MISSING bots too (removed NPCs), so
      -- Net.get_object_by_id will legitimately return nil there.
      local current_area = exploding_effect.area_id
      if current_area then
        local ok_obj, object = pcall(Net.get_object_by_id, current_area, actor_id)
        if ok_obj and object and object.x and object.y then
          position = { x = object.x, y = object.y, z = object.z or 0 }
        end
      end
    end
  end

  if position and position.x and position.y then
    if area_id then exploding_effect.area_id = area_id end
    exploding_effect.position = position
    return true
  end
  return false
end

local function finish_effect(self, reason)
  if self._finished then return end
  self._finished = true
  self._finish_reason = reason
  if type(self.on_complete) == "function" then
    local ok, err = pcall(self.on_complete, reason)
    if not ok then
      logger:warn("[ezexplosions] on_complete callback failed:", tostring(err))
    end
  end
end

-- Idempotent bot removal. Guards against double-counting `active_bots` if
-- the same bot is scheduled for removal through two paths (e.g., its own
-- scheduled self-check AND the coordinated last-blast cleanup).
local function remove_explosion_bot(self, bot_id, reason)
  self._removed_bots = self._removed_bots or {}
  if self._removed_bots[bot_id] then return end
  self._removed_bots[bot_id] = true

  if self._active_bot_ids then
    for i, id in ipairs(self._active_bot_ids) do
      if id == bot_id then
        table.remove(self._active_bot_ids, i)
        break
      end
    end
  end

  pcall(Net.remove_bot, bot_id)
  self.active_bots = (self.active_bots or 1) - 1
  if self.active_bots <= 0 then
    finish_effect(self, reason or "completed")
  end
end

-- Remove every bot still in _active_bot_ids. Copies the list first since
-- remove_explosion_bot mutates it.
local function remove_all_active_bots(self, reason)
  local to_remove = {}
  for _, id in ipairs(self._active_bot_ids or {}) do
    to_remove[#to_remove+1] = id
  end
  for _, id in ipairs(to_remove) do
    remove_explosion_bot(self, id, reason)
  end
end

local function explode(self, explosion_bot_id)
  if self.stopped then
    remove_explosion_bot(self, explosion_bot_id, "stopped")
    return
  end

  if self.max_explosions and (self.remaining_explosions or 0) <= 0 then
    remove_explosion_bot(self, explosion_bot_id, "completed")
    return
  end

  local fresh = update_tracked_position(self)

  if not fresh and self.max_explosions == nil then
    remove_explosion_bot(self, explosion_bot_id, "actor_gone")
    return
  end

  if not self.position or not self.area_id then
    remove_explosion_bot(self, explosion_bot_id, "no_position")
    return
  end

  local offset_x = (math.random() * 2 - 1) * EXPLOSION_AXIS_RANGE
  local offset_y = (math.random() * 2 - 1) * EXPLOSION_AXIS_RANGE

  pcall(Net.transfer_bot,
    explosion_bot_id,
    self.area_id,
    false,
    self.position.x + offset_x,
    self.position.y + offset_y,
    self.position.z or 0
  )

  if self.max_explosions then
    self.remaining_explosions = (self.remaining_explosions or 1) - 1
  end

  pcall(Net.play_sound, self.area_id, "/server/assets/ezlibs-assets/sfx/explode.ogg")

  if math.random(2) == 1 then
    pcall(Net.animate_bot, explosion_bot_id, "EXPLODE")
  else
    pcall(Net.animate_bot, explosion_bot_id, "SMOKE")
  end

  -- Last blast? Coordinate teardown of all remaining bots after a short
  -- animation tail instead of letting each bot wait its own full
  -- EXPLOSION_DURATION. This is what fixes the 0.6s dead gap between the
  -- last visible blast and any post-effect callback (kick, etc.).
  if self.max_explosions and self.remaining_explosions <= 0 then
    Async.sleep(EXPLOSION_TAIL_DURATION).and_then(function()
      remove_all_active_bots(self, "completed")
    end)
    return
  end

  -- Not the last blast: schedule the next fire on this bot. The
  -- remaining_explosions check at the top of the next explode call
  -- handles the case where another bot already consumed the budget.
  Async.sleep(EXPLOSION_DURATION).and_then(function()
    if self.stopped then
      remove_explosion_bot(self, explosion_bot_id, "stopped")
    elseif self.max_explosions and (self.remaining_explosions or 0) <= 0 then
      remove_explosion_bot(self, explosion_bot_id, "completed")
    else
      explode(self, explosion_bot_id)
    end
  end)
end

local function spawn(self)
  local bot_count = self.total_explosions
  if self.max_explosions and self.max_explosions < bot_count then
    bot_count = self.max_explosions
  end

  for i = 1, bot_count, 1 do
    if self._finished then break end

    -- pcall Net.create_bot defensively. A throw here would propagate all
    -- the way up through await(explode_and_wait(...)) in the caller,
    -- skipping any post-explosion cleanup (like kicking a defeated
    -- player or unlocking their input).
    local ok_create, result = pcall(Net.create_bot, {
      texture_path = "/server/assets/ezlibs-assets/ezexplosions/explosion.png",
      animation_path = "/server/assets/ezlibs-assets/ezexplosions/explosion.animation",
      area_id = self.area_id,
      warp_in = false,
      x = self.position and self.position.x or 0,
      y = self.position and self.position.y or 0,
      z = self.position and (self.position.z or 0) or 0,
    })
    local explosion_bot_id = ok_create and result or nil

    if not explosion_bot_id then
      logger:warn("[ezexplosions] failed to create explosion bot #", i,
        ok_create and "returned nil" or tostring(result))
      if i == 1 then
        finish_effect(self, "bot_creation_failed")
        return
      end
    else
      self.active_bots = (self.active_bots or 0) + 1
      self._active_bot_ids[#self._active_bot_ids + 1] = explosion_bot_id

      if i > 1 then
        Async.sleep((i - 1) * EXPLOSION_DURATION / self.total_explosions)
          .and_then(function()
            explode(self, explosion_bot_id)
          end)
      else
        explode(self, explosion_bot_id)
      end
    end
  end
end

local ExplodingEffect = {}

function ExplodingEffect:new(actor_id, opt_area_id, max_explosions, on_complete)
  local exploding_effect = {
    tracked_actor_id = actor_id,
    position = nil,
    area_id = opt_area_id,
    max_explosions = max_explosions,
    remaining_explosions = max_explosions,
    total_explosions = 3,
    stopped = false,
    on_complete = on_complete,
    active_bots = 0,
    _active_bot_ids = {},
    _finished = false,
  }

  setmetatable(exploding_effect, self)
  self.__index = self

  update_tracked_position(exploding_effect)
  spawn(exploding_effect)

  return exploding_effect
end

-- Call this to stop an effect early. on_complete will still fire once all
-- active bots have been removed, with reason "stopped".
function ExplodingEffect:remove()
  if self.stopped then return end
  self.stopped = true
  if (self.active_bots or 0) <= 0 then
    finish_effect(self, "stopped")
    return
  end
  -- Schedule a quick coordinated teardown so callers don't have to wait
  -- for each bot's own EXPLOSION_DURATION sleep to expire. The brief
  -- deferral gives any in-flight animate_bot call a chance to land on a
  -- live bot before it is removed.
  Async.sleep(0.05).and_then(function()
    remove_all_active_bots(self, "stopped")
  end)
end

local ezexplosions = {}

function ezexplosions.explode(actor_id, area_id, max_explosions, on_complete)
    return ExplodingEffect:new(actor_id, area_id, max_explosions, on_complete)
end

-- Awaitable variant. Resolves with the completion reason once the effect's
-- on_complete fires, or "timeout" if the effect never completes. Default
-- timeout is 5s, well beyond any reasonable effect duration.
function ezexplosions.explode_and_wait(actor_id, area_id, max_explosions, timeout_seconds)
    return async(function()
        local done = false
        local finish_reason = nil

        ezexplosions.explode(actor_id, area_id, max_explosions, function(reason)
            finish_reason = reason
            done = true
        end)

        local max_wait = tonumber(timeout_seconds) or 5.0
        local elapsed = 0
        while not done and elapsed < max_wait do
            await(Async.sleep(0.02))
            elapsed = elapsed + 0.02
        end

        if not done then
            logger:warn("[ezexplosions] explode_and_wait timed out after",
                max_wait, "seconds for actor", tostring(actor_id))
            return "timeout"
        end

        return finish_reason
    end)
end

ezbus:on("explode", function(event)
    ezexplosions.explode(
      event.actor_id,
      event.area_id,
      event.max_explosions,
      event.on_complete
    )
end)

return ezexplosions