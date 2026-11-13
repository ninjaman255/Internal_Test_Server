-- Reusable NPC UI definition resolver. One authoritative place for frame tints,
-- mugshot textures, nameplate text, font choice and stable textbox IDs.
-- Pure table construction: never allocates sprites or captures input.
local Presets = require("scripts/net-games/npcs/talk_presets")
local Style = {}
local function shallow_copy(t)
    local out = {}
    for k,v in pairs(t or {}) do out[k] = v end
    return out
end
local function deep_merge(dst, src)
    for k,v in pairs(src or {}) do
        if type(v) == "table" and type(dst[k]) == "table" then
            deep_merge(dst[k], v)
        else dst[k] = v end
    end
    return dst
end
local function stable_box_id(cfg)
    if cfg.box_id then return tostring(cfg.box_id) end
    return "talk_" .. tostring(cfg.area_id or "default") .. "_" .. tostring(cfg.object or "npc")
end
function Style.build(cfg, bot_name, opts)
  opts = opts or {}

  -- 1) Choose pack (default = prog)
  local pack_key = cfg.preset or cfg.pack or "prog"
  local pack = Presets.packs[pack_key] or Presets.packs.prog

  -- 2) Choose component presets
  local box_key = cfg.box or pack.box or "panel"
  local mug_key = cfg.mug or pack.mug
  local np_key  = cfg.nameplate or pack.nameplate

  local ui = {}

  -- Box (base)
  local box = Presets.boxes[box_key] or Presets.boxes.panel
  deep_merge(ui, shallow_copy(box))

  -- IMPORTANT: keep a real table instance for backdrop (and its nested indicator table)
  ui.backdrop = shallow_copy(box.backdrop)
  deep_merge(ui.backdrop, box.backdrop)

  -- Frame dye optional: switches backdrop style + applies tint values
  -- We ALSO want to propagate this to the nameplate (later), so keep a resolved table.
  local resolved_frame = nil
  if cfg.frame then
    local frame = Presets.frames[cfg.frame] or cfg.frame
    ui.backdrop.style = "textbox_panel_frame_tint"
    if type(frame) == "table" then
      ui.backdrop.r = frame.r
      ui.backdrop.g = frame.g
      ui.backdrop.b = frame.b
      ui.backdrop.a = frame.a
      ui.backdrop.color_mode = frame.color_mode
      resolved_frame = frame
    end
  end

  -- Mugshot
  if mug_key == false then
    ui.mugshot = nil
  elseif mug_key then
    local mug = Presets.mugs[mug_key] or mug_key
    if type(mug) == "table" then
      ui.mugshot = shallow_copy(mug)
    end
  end

  -- Nameplate
  if np_key == false then
    ui.nameplate = nil
  elseif np_key then
    local np = Presets.nameplates[np_key] or np_key
    if type(np) == "table" then
      ui.nameplate = shallow_copy(np)
      ui.nameplate.text = ui.nameplate.text or bot_name

      -- NEW: if textbox frame dye was requested, apply same dye to nameplate overlay frame
      -- (your nameplate.lua reads ui.nameplate.frame.{r,g,b,a,color_mode})
      if resolved_frame then
        ui.nameplate.frame = ui.nameplate.frame or {}
        ui.nameplate.frame.r = resolved_frame.r
        ui.nameplate.frame.g = resolved_frame.g
        ui.nameplate.frame.b = resolved_frame.b
        ui.nameplate.frame.a = resolved_frame.a
        ui.nameplate.frame.color_mode = resolved_frame.color_mode
      end
    end
  end

  -- Stable box id (prompt + dialogue reuse)
  ui.box_id = stable_box_id(cfg)

  -- Per-NPC overrides (last)
  if cfg.ui then
    deep_merge(ui, cfg.ui)

    -- If someone overwrote nameplate, ensure text is still sane unless explicitly set
    if ui.nameplate and ui.nameplate.text == nil then
      ui.nameplate.text = bot_name
    end

    -- Keep stable id unless explicitly overwritten
    ui.box_id = ui.box_id or stable_box_id(cfg)
  end

  -- =====================================================
  -- INDICATOR SAFETY:
  -- Some configs accidentally replace backdrop without carrying indicator.
  -- We restore the preset indicator unless the author explicitly disabled it.
  -- =====================================================
  if ui.backdrop then
    local base_ind = box and box.backdrop and box.backdrop.indicator

    if ui.backdrop.indicator == nil and base_ind then
      ui.backdrop.indicator = shallow_copy(base_ind)
    end

    if ui.backdrop.indicator and ui.backdrop.indicator.enabled == nil then
      ui.backdrop.indicator.enabled = true
    end
  end

  return ui
end


return Style
