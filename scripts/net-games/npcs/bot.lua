-- Native Net Games reusable bot definitions.
-- Spawn from Tiled, bind native interaction once, and select either dialogue,
-- a Yes/No prompt, a vertical menu or an advanced custom callback.
-- Uses the existing Talk UI styles and PlayerControl-owned dialogue flows.
local Direction = require("scripts/libs/direction")
local Dialogue = require("scripts/net-games/dialogue/dialogue")
local DebugLog = require("scripts/net-games/logging").get("BOT")
local Bot = {}

function Bot.spawn(cfg)
  assert(cfg and cfg.object, "[Bot.spawn] cfg.object required (Tiled object name)")

  local area_id  = cfg.area_id or "default"
  local obj_name = cfg.object

  local bot_pos = Net.get_object_by_name(area_id, obj_name)
  assert(bot_pos, "[Bot.spawn] Missing Tiled object named '" .. obj_name .. "' in area: " .. tostring(area_id))

  local bot_id = Net.create_bot({
    name = cfg.name or obj_name,
    area_id = area_id,
    texture_path = cfg.texture_path or "/server/assets/ow/prog/prog_ow.png",
    animation_path = cfg.animation_path or "/server/assets/ow/prog/prog_ow.animation",
    x = bot_pos.x,
    y = bot_pos.y,
    z = bot_pos.z or 0,
    direction = cfg.direction or Direction.Down,
    solid = (cfg.solid ~= false),
  })

  local BOT_NAME = Net.get_bot_name(bot_id)
  DebugLog:info_data("Talk NPC created", {
    area_id = area_id, npc = obj_name, bot_id = bot_id, bot_name = BOT_NAME,
  })

  Net:on("actor_interaction", function(event)
    if event.actor_id ~= bot_id then return end

    if event.button ~= nil and event.button ~= 0 then return end
    local player_id = event.player_id
    local Talk = require("scripts/net-games/npcs/talk")
    DebugLog:info_data("Talk NPC interacted", {
      npc = obj_name, player_id = player_id, bot_id = bot_id,
      mode = cfg.on_interact and "custom" or (cfg.menu and "menu" or (cfg.prompt and "prompt" or "dialogue")),
    })
    local TalkVertMenu = require("scripts/net-games/npcs/talk_vert_menu")
    if Dialogue.is_active(player_id) or TalkVertMenu.is_busy(player_id) then
      DebugLog:warn_data("Talk NPC interaction ignored; dialogue active", {npc = obj_name, player_id = player_id})
      return
    end

    if type(cfg.on_open) == "function" then
      local ok, err = pcall(cfg.on_open, player_id, bot_id, BOT_NAME)
      if not ok then DebugLog:error_data("Bot on_open failed", {
        object = obj_name, player_id = player_id, error = tostring(err),
      }) end
    end

    -- Face the player
    local player_pos = Net.get_player_position(player_id)
    Net.set_bot_direction(bot_id, Direction.from_points(bot_pos, player_pos))

    -- Custom handler override (advanced users)
    if type(cfg.on_interact) == "function" then
      local ok, err = pcall(cfg.on_interact, player_id, bot_id, BOT_NAME)
      if not ok then DebugLog:error_data("Custom bot interaction failed", {
        area_id = area_id, object = obj_name, player_id = player_id, error = tostring(err),
      }) end
      return
    end

    -- Reusable menu config: no extra per-NPC on_interact boilerplate.
    if cfg.menu then
      local menu = {}
      for k,v in pairs(cfg.menu) do menu[k] = v end
      if menu.on_close == nil then menu.on_close = cfg.on_close end
      Talk.vert_menu(player_id, BOT_NAME, cfg, menu)
      return
    end

    local function followup_config()
      local out = {}
      for k,v in pairs(cfg) do out[k] = v end
      if cfg.on_close then
        out.on_finish = function(...)
          if cfg.on_finish then cfg.on_finish(...) end
          cfg.on_close(player_id, bot_id, BOT_NAME)
        end
      end
      return out
    end

    -- Prompt flow (optional)
    if cfg.prompt then
      local p = cfg.prompt
      if type(p.on_yes) == "function" or type(p.on_no) == "function"
          or type(p.on_cancel) == "function" then
        Talk.prompt_yesno(player_id, p.question or "Continue?", cfg, BOT_NAME, {
          on_yes = function()
            if p.on_yes then p.on_yes(player_id, bot_id, BOT_NAME) end
            if p.yes_lines then
              local next_cfg = followup_config()
              next_cfg.from_prompt = true
              next_cfg.reuse_existing_box = true
              Talk.start(player_id, p.yes_lines, next_cfg, BOT_NAME)
            end
          end,
          on_no = function()
            if p.on_no then p.on_no(player_id, bot_id, BOT_NAME) end
            if p.no_lines then
              local next_cfg = followup_config()
              next_cfg.from_prompt = true
              next_cfg.reuse_existing_box = true
              Talk.start(player_id, p.no_lines, next_cfg, BOT_NAME)
            end
          end,
          on_cancel = function()
            if p.on_cancel then p.on_cancel(player_id, bot_id, BOT_NAME) end
          end,
        })
      else
        Talk.prompt_then_talk(player_id,
          p.question or "Continue?",
          p.yes_lines or p.on_yes_lines or { "..." },
          p.no_lines or p.on_no_lines or { "..." }, followup_config(), BOT_NAME)
      end
      return
    end

    -- Normal dialogue
    local lines = cfg.lines or cfg.text or { "..." }
    local dialogue_cfg = cfg
    if type(cfg.on_close) == "function" then
      dialogue_cfg = {}
      for k,v in pairs(cfg) do dialogue_cfg[k] = v end
      dialogue_cfg.on_finish = function(...)
        if cfg.on_finish then cfg.on_finish(...) end
        cfg.on_close(player_id, bot_id, BOT_NAME)
      end
    end
    local box_id, err = Talk.start(player_id, lines, dialogue_cfg, BOT_NAME)
    if not box_id then
      DebugLog:error_data("Talk NPC dialogue failed to open", {
        npc = obj_name, player_id = player_id, error = tostring(err),
      })
    end
  end)

  return bot_id
end


return Bot
