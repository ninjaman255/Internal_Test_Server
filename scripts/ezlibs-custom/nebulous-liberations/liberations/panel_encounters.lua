local ezlogger = require("scripts/ezlibs-scripts/ezlogger")
local log = ezlogger.get("nebulous-liberations")
local ezconfig = require("scripts/ezlibs-scripts/ezconfig")

local PanelEncounters = {}

--[[
Encounters are defined per base area by ezencounters itself. The file
{ENCOUNTERS_PATH}{area_id}.lua is the single source of truth for the
liberation battle packages. Its schema separates the random pool from
explicit boss and special encounters:

    return {
        -- Ordinary/random encounters only.
        encounters = {
            {
                name = "ACDC4Liberation",
                path = "scripts/ezlibs-assets/ezencounters/ezencounters.zip",
                weight = 1,
                enemies = { { name = "NormalNavi", rank = 1 } },
            },
        },

        -- Used when engaging an enemy whose template has is_boss = true.
        -- Never selected by ordinary random encounter rolls.
        bosses = {
            {
                name = "ShadeManBattle",
                path = "scripts/ezlibs-assets/ezencounters/ezencounters.zip",
                weight = 1,
                enemies = { { name = "ShadeMan", rank = 1 } },
            },
        },

        -- Used for large viruses / special enemy templates such as BigBrute.
        -- Never selected by ordinary random encounter rolls.
        special_encounters = {
            {
                name = "BigBruteBattle",
                path = "scripts/ezlibs-assets/ezencounters/ezencounters.zip",
                weight = 1,
                enemies = { { name = "BigBrute", rank = 1 } },
            },
        },
    }

resolve_encounter(base_area_id) selects only from .encounters. Passing
"bosses" or "special_encounters" explicitly selects from that section.
When an optional section is absent/empty, it falls back to .encounters for
backwards compatibility. Entries use weight (default 1) when a section
contains multiple choices.

The per-panel "Encounter Path" custom property still overrides the default
by routing through resolve_encounter_value(), which defers to
ezencounters.resolve_encounter() (name lookup or direct path).
]]

local corner_offsets = {
  { 1, -1 },
  { 1, 1 },
  { -1, -1 },
  { -1, 1 },
}

local function has_dark_panel(instance, x, y, z)
  local panel = instance:get_panel_at(x, y, z)
  if not panel then return false end
  local panel_type_table = {"Dark Panel", "Dark Hole", "Indestructible Panel", "Item Panel", "Trap Panel"}
  local function includes(values, value)
    for _, candidate in ipairs(values) do
      if value == candidate then
        return true
      end
    end
    return false
  end
  return includes(panel_type_table, panel.type)
end

function PanelEncounters.resolve_terrain(instance, player)
  local x_left = has_dark_panel(instance, player.x - 1, player.y, player.z)
  local x_right = has_dark_panel(instance, player.x + 1, player.y, player.z)
  local y_left = has_dark_panel(instance, player.x, player.y - 1, player.z)
  local y_right = has_dark_panel(instance, player.x, player.y + 1, player.z)

  if (x_left and x_right) or (y_left and y_right) then
    return "surrounded"
  end

  if (x_left or x_right) and (y_left or y_right) then
    return "disadvantage"
  end

  for _, offset in ipairs(corner_offsets) do
    if has_dark_panel(instance, player.x + offset[1], player.y + offset[2], player.z) then
      return "even"
    end
  end

  return "advantage"
end

-- Cache: key (area_id or area name) -> encounter table, or false when load
-- failed. Both the numeric/id form returned by Net.list_areas and the name
-- form returned by Net.get_area_name are tried, mirroring how callers
-- sometimes pass either form as base_area_id.
local area_table_cache = {}

local function candidate_area_keys(base_area_id)
  local keys = {}
  if base_area_id ~= nil then
    keys[#keys + 1] = tostring(base_area_id)
  end
  local ok, name = pcall(Net.get_area_name, base_area_id)
  if ok and name ~= nil then
    local name_str = tostring(name)
    if name_str ~= "" and name_str ~= tostring(base_area_id) then
      keys[#keys + 1] = name_str
    end
  end
  return keys
end

local function load_area_encounter_table(base_area_id)
  for _, key in ipairs(candidate_area_keys(base_area_id)) do
    local cached = area_table_cache[key]
    if cached ~= nil then
      if cached ~= false then
        return cached, key
      end
      -- previously failed: don't retry within this process lifetime.
    else
      local module_path = ezconfig.ENCOUNTERS_PATH .. key
      local ok, result = pcall(require, module_path)
      if ok and type(result) == "table" then
        area_table_cache[key] = result
        log:info_data("Loaded area encounter table", {
          base_area_id = base_area_id,
          key = key,
          module_path = module_path,
          encounter_count = (type(result.encounters) == "table") and #result.encounters or 0,
        })
        return result, key
      else
        area_table_cache[key] = false
      end
    end
  end
  return nil, nil
end

local function pick_encounter(encounter_table, category)
  if type(encounter_table) ~= "table" then return nil end
  local section = (category == "bosses" or category == "special_encounters")
      and category or "encounters"
  local options = encounter_table[section]
  if type(options) ~= "table" or #options == 0 then
    -- Keep older area tables working until they define the optional section.
    if section ~= "encounters" then
      options = encounter_table.encounters
    end
  end
  if type(options) ~= "table" or #options == 0 then return nil end
  if #options == 1 then return options[1] end

  local total_weight = 0
  for _, opt in ipairs(options) do
    total_weight = total_weight + (tonumber(opt.weight) or 1)
  end
  if total_weight <= 0 then
    return options[math.random(#options)]
  end

  local pick = math.random() * total_weight
  for _, opt in ipairs(options) do
    pick = pick - (tonumber(opt.weight) or 1)
    if pick <= 0 then
      return opt
    end
  end
  return options[#options]
end

-- Used by instance.lua for the per-panel "Encounter Path" custom property
-- override. Routes through ezencounters.resolve_encounter so named
-- encounters registered via encounters/*.lua resolve to their full
-- definition (with battle data), while raw paths fall back to {path = ref}.
function PanelEncounters.resolve_encounter_value(reference)
  if reference == nil or tostring(reference) == "" then return nil end
  local ezencounters = require("scripts/ezlibs-scripts/ezencounters/main")
  if type(ezencounters.resolve_encounter) == "function" then
    return ezencounters.resolve_encounter(reference)
  end
  return { path = tostring(reference) }
end

function PanelEncounters.resolve_encounter(base_area_id, category)
  if base_area_id == nil then return nil end
  local area_name = Net.get_area_name(base_area_id)
  local table_data, key_used = load_area_encounter_table(base_area_id)
  if table_data == nil then
    log:warn_data("No area encounter table found", {
      base_area_id = base_area_id,
      area_name = area_name,
      tried_path_prefix = ezconfig.ENCOUNTERS_PATH,
    })
    return nil
  end

  local picked = pick_encounter(table_data, category)
  if picked == nil then
    log:warn_data("Area encounter table has no encounters", {
      base_area_id = base_area_id,
      area_name = area_name,
      key_used = key_used,
    })
    return nil
  end
  if picked.path == nil then
    log:error_data("Picked encounter has no path", {
      base_area_id = base_area_id,
      area_name = area_name,
      key_used = key_used,
      category = category or "encounters",
      picked_name = picked.name,
    })
    return nil
  end

  log:info_data("Resolved area encounter", {
    base_area_id = base_area_id,
    area_name = area_name,
    key_used = key_used,
    encounter_name = picked.name,
    category = category or "encounters",
    path = picked.path,
  })

  -- Shallow copy so instance.lua's merge loop can't mutate the cached table.
  local out = {}
  for k, v in pairs(picked) do out[k] = v end
  return out
end

-- Startup diagnostic: for every area that looks like a liberation base
-- (has a Liberation Tileset custom property), report whether ezencounters
-- can see an encounter file for it and how many encounters it declares.
local function startup_diagnostic()
  local areas = Net.list_areas()
  for _, area_id in ipairs(areas) do
    local tileset = Net.get_area_custom_property(area_id, "Liberation Tileset")
    if tileset ~= nil and tostring(tileset) ~= "" then
      local table_data, key_used = load_area_encounter_table(area_id)
      if table_data == nil then
        log:warn_data("Liberation area has NO encounter file", {
          area_id = area_id,
          area_name = Net.get_area_name(area_id),
          tried_path_prefix = ezconfig.ENCOUNTERS_PATH,
        })
      elseif (type(table_data.encounters) ~= "table" or #table_data.encounters == 0)
          and (type(table_data.bosses) ~= "table" or #table_data.bosses == 0)
          and (type(table_data.special_encounters) ~= "table" or #table_data.special_encounters == 0) then
        log:warn_data("Liberation area encounter file has no encounters, bosses, or special encounters", {
          area_id = area_id,
          area_name = Net.get_area_name(area_id),
          key_used = key_used,
        })
      else
        for _, section_name in ipairs({"encounters", "bosses", "special_encounters"}) do
          for i, enc in ipairs(table_data[section_name] or {}) do
            log:info_data("Liberation area encounter loaded", {
              area_id = area_id,
              area_name = Net.get_area_name(area_id),
              key_used = key_used,
              section = section_name,
              index = i,
              name = enc.name,
              path = enc.path,
              weight = enc.weight,
            })
          end
        end
      end
    end
  end
end

startup_diagnostic()

return PanelEncounters