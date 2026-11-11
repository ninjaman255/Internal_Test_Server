local EnemySelection = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection")
local EnemyHelpers = require("scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers")
local Preloader = require("scripts/ezlibs-custom/nebulous-liberations/liberations/preloader")
local GuardInterception = require("scripts/ezlibs-custom/nebulous-liberations/liberations/guard_interception")

Preloader.add_asset("/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/snowball.png")
Preloader.add_asset("/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/snowball.animation")

local BlizzardMan = {}

function BlizzardMan:new(instance, position, direction)
  local blizzardman = {
    instance = instance,
    id = nil,
    health = 400,
    is_boss = true,
    max_health = 400,
    x = math.floor(position.x),
    y = math.floor(position.y),
    z = math.floor(position.z),
    mug = {
      texture_path = "/server/assets/ezlibs-custom/nebulous-liberations/mugs/blizzardman.png",
      animation_path = "/server/assets/ezlibs-custom/nebulous-liberations/mugs/blizzardman.animation",
    },
    encounter = "/server/assets/encounters/big_brute_encounter.zip",
    selection = EnemySelection:new(instance)
  }

  setmetatable(blizzardman, self)
  self.__index = self

  local shape = {
    {1, 1, 1},
    {1, 0, 1},
    {1, 1, 1},
    {1, 1, 1}
  }

  blizzardman.selection:set_shape(shape, 0, -2)
  blizzardman:spawn(direction)

  return blizzardman
end

function BlizzardMan:spawn(direction)
  self.id = Net.create_bot({
    texture_path = "/server/assets/ezlibs-custom/nebulous-liberations/bots/npcs/blizzardman.png",
    animation_path = "/server/assets/ezlibs-custom/nebulous-liberations/bots/npcs/blizzardman.animation",
    area_id = self.instance.area_id,
    direction = direction,
    warp_in = false,
    x = self.x + .5,
    y = self.y + .5,
    z = self.z
  })
  Net.set_bot_minimap_color(self.id, EnemyHelpers.boss_minimap_color)
end

function BlizzardMan:get_death_message()
  return "Woosh!\nI can't believe\nit. I can't lose.\nNOOOO!"
end

function BlizzardMan:take_turn()
  local co = coroutine.create(function()
    if not debug and self.instance.phase == 1 then
      for _, player in ipairs(self.instance.players) do
        player:message(
          "I'll turn this area into a Nebula ski resort! Got it?",
          self.mug.texture_path,
          self.mug.animation_path
        )
      end

      -- Allow time for the players to read this message
      Async.await(Async.sleep(3))
    end

    self.selection:move(self, Net.get_bot_direction(self.id))

    local caught_sessions = self.selection:detect_player_sessions()
    
    if #caught_sessions == 0 then
      return
    end

    self.selection:indicate()

    Async.await(Async.sleep(1))

    for _, player in ipairs(self.instance.players) do
      player:message(
        "Shiver in my\ndeep winter!\nSnowball!",
        self.mug.texture_path,
        self.mug.animation_path
      )
    end

    Async.await(Async.sleep(1))

    local attack_records = GuardInterception.prepare_attack(self.instance, self, caught_sessions, 0.5)
    EnemyHelpers.play_attack_animation(self)

    local spawned_bots = {}

    for _, record in ipairs(attack_records) do
      local position = record.visual_position
      if position then
      local snowball_bot_id = Net.create_bot({
        texture_path = "/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/snowball.png",
        animation_path = "/server/assets/ezlibs-custom/nebulous-liberations/bots/attacks/snowball.animation",
        area_id = self.instance.area_id,
        warp_in = false,
        x = position.x - 0.5,
        y = position.y - 0.5,
        z = position.z + 8
      })

      Net.animate_bot_properties(snowball_bot_id, {
        {
          properties = {
            { property = "Animation", value = "FALL" },
          }
        },
        {
          properties = {
            { property = "Z", ease = "Linear", value = position.z + 1 },
          },
          duration = .5
        }
      })

      spawned_bots[#spawned_bots+1] = snowball_bot_id
      end
    end

    Async.await(Async.sleep(.5))

    for _, player in ipairs(self.instance.players) do
      Net.shake_player_camera(player.id, 2, .5)
    end

    GuardInterception.apply_damage(attack_records, 40, self)
    GuardInterception.finish_attack(self.instance, attack_records)

    Async.await(Async.sleep(.5))

    for _, bot_id in ipairs(spawned_bots) do
      Net.remove_bot(bot_id, false)
    end

    Async.await(Async.sleep(1))

    self.selection:remove_indicators()
  end)

  return Async.promisify(co)
end

return BlizzardMan
