local SharedLogger = require("scripts/logger/logger")
local log = require("scripts/ezlibs-custom/nebulous-liberations/liberations/logger").encounters
local ezconfig = require("scripts/ezlibs-scripts/ezconfig")

local PanelEncounters = {}

--[[
Encounters are defined per base area by ezencounters itself. The file
{ENCOUNTERS_PATH}{area_id}.lua is the single source of truth for regular
area battles and liberation battle packages. Its schema separates the random pool from
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

        -- Used by regular areas and liberation missions when engaging an
        -- enemy whose template has is_boss = true. Never random-selected.
        bosses = {
            {
                name = "ShadeManBattle",
                path = "scripts/ezlibs-assets/ezencounters/ezencounters.zip",
                weight = 1,
                enemies = { { name = "ShadeMan", rank = 1 } },
            },
        },

        -- Used by regular areas and liberation missions for special enemy
        -- templates such as BigBrute. Never random-selected.
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
  local panel_type_table = {"Dark Panel", "Dark Hole", "Dark Hole Buffed Virus", "Indestructible Panel", "Item Panel", "Trap Panel"}
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

-- Validate the payload shape *before* handing it to the client. The ONB
-- client cannot recover gracefully from invalid battle character indexes.
-- These checks cover the V2.1 matrices consumed by the packaged entry.lua;
-- missing optional terrain matrices are still handled by that package.
function PanelEncounters.validate_encounter_data(definition, package_path)
  if type(definition) ~= "table" then return false, "encounter is not a table" end
  local path = definition.path or package_path
  if type(path) ~= "string" or path == "" then
    return false, "missing encounter ZIP path"
  end
  local enemies = definition.enemies
  if type(enemies) ~= "table" or #enemies < 1 or #enemies > 9 then
    return false, "expected between 1 and 9 enemy entries"
  end
  for i, enemy in ipairs(enemies) do
    if type(enemy) ~= "table" or type(enemy.name) ~= "string" or enemy.name == "" then
      return false, "enemy " .. i .. " has no package alias"
    end
    local rank = tonumber(enemy.rank)
    if rank == nil or rank % 1 ~= 0 or rank < 0 or rank > 7 then
      return false, "enemy " .. i .. " has invalid rank " .. tostring(enemy.rank)
    end
  end

  local function check_matrix(key)
    local matrix = definition[key]
    if matrix == nil then return true end
    if type(matrix) ~= "table" or #matrix ~= 3 then
      return false, key .. " must contain 3 rows"
    end
    for y = 1, 3 do
      local row = matrix[y]
      if type(row) ~= "table" or #row ~= 6 then
        return false, key .. " row " .. y .. " must contain 6 cells"
      end
      for x = 1, 6 do
        local value = tonumber(row[x])
        if value == nil or value % 1 ~= 0 or value < 0 then
          return false, key .. " has invalid cell at " .. x .. "," .. y
        end
      end
    end
    return true
  end

  for _, key in ipairs({"positions", "player_positions", "obstacle_positions", "tiles", "teams"}) do
    local ok, err = check_matrix(key)
    if not ok then return false, err end
  end

  local pos = definition.positions
  if pos then
    local seen = {}
    for y = 1, 3 do
      for x = 1, 6 do
        local index = pos[y][x]
        if index ~= 0 then
          if index > #enemies or seen[index] then
            return false, "invalid/duplicate enemy position index " .. tostring(index)
          end
          seen[index] = true
        end
      end
    end
    for i = 1, #enemies do
      if not seen[i] then return false, "enemy " .. i .. " has no position" end
    end
  end
  if type(definition.player_positions) == "table" then
    local pos_players = definition.player_positions
    for y = 1, 3 do
      for x = 1, 6 do
        local player_index = pos_players[y][x]
        if player_index ~= 0 and definition.positions
            and definition.positions[y][x] ~= 0 then
          return false, "player/enemy position collision at " .. x .. "," .. y
        end
      end
    end
  end
  if definition.freedom_mission ~= nil then
    local fm = definition.freedom_mission
    if type(fm) ~= "table" then return false, "freedom_mission must be a table" end
    local turns = tonumber(fm.turn_count or fm.turns or 3)
    if turns == nil or turns % 1 ~= 0 or turns < 1 then
      return false, "freedom_mission requires a positive turn_count"
    end
  end
  return true
end

-- The regular ezencounters loader supplies encounter ZIPs to each BASE area.
-- Liberation battles run in dynamically cloned areas, which must receive the
-- package as well. Provision registered packages immediately after cloning,
-- before players transfer, rather than waiting for the first battle packet.
-- Keep a per-area cache to avoid resending the same package for every panel.
local provided_package_paths = {}

function PanelEncounters.ensure_encounter_asset(area_id, package_path)
  if area_id == nil or type(package_path) ~= "string" or package_path == "" then
    log:error_data("Cannot provision liberation encounter: missing area or package", {
      area_id = tostring(area_id), package_path = tostring(package_path),
    })
    return false
  end

  local area_key = tostring(area_id)
  local provided = provided_package_paths[area_key]
  if provided and provided[package_path] then
    return true
  end

  local ok, err = pcall(Net.provide_asset, area_id, package_path)
  if not ok or err == false then
    log:error_data("Could not provision liberation encounter package", {
      area_id = area_id, package_path = package_path, error = tostring(err),
    })
    return false
  end

  provided = provided or {}
  provided_package_paths[area_key] = provided
  provided[package_path] = true
  log:info_data("Liberation encounter package provision requested", {
    area_id = area_id, package_path = package_path,
  })
  return true
end

function PanelEncounters.provide_mission_encounter_assets(base_area_id, mission_area_id)
  local encounter_table, key_used = load_area_encounter_table(base_area_id)
  local requested, failures = 0, 0
  local unique = {}

  for _, section_name in ipairs({"encounters", "bosses", "special_encounters"}) do
    local section = encounter_table and encounter_table[section_name]
    if type(section) == "table" then
      for _, definition in ipairs(section) do
        local valid, reason = PanelEncounters.validate_encounter_data(definition)
        if not valid then
          failures = failures + 1
          log:error_data("Invalid authored Liberation encounter", {
            area_id = base_area_id, section = section_name,
            encounter_name = definition and definition.name,
            problem = reason,
          })
        end
        local path = type(definition) == "table" and definition.path or nil
        if type(path) == "string" and path ~= "" and not unique[path] then
          unique[path] = true
          requested = requested + 1
          if not PanelEncounters.ensure_encounter_asset(mission_area_id, path) then
            failures = failures + 1
          end
        end
      end
    end
  end

  log:info_data("Liberation mission encounter asset preflight", {
    base_area_id = base_area_id,
    mission_area_id = mission_area_id,
    encounter_key = key_used,
    distinct_packages = requested,
    failed_packages = failures,
    has_area_encounter_table = encounter_table ~= nil,
  })
  if not encounter_table then
    log:warn_data("No encounter table for preflight; override paths will be provisioned on demand", {
      base_area_id = base_area_id, mission_area_id = mission_area_id,
    })
  end
  return failures == 0, requested, failures
end

-- Release an instance's provisioning cache when it is disposed. A later clone
-- may use a different package set and must not inherit a dead area's cache.
function PanelEncounters.clear_mission_encounter_assets(mission_area_id)
  if mission_area_id ~= nil then
    provided_package_paths[tostring(mission_area_id)] = nil
  end
end

-- Weighted selection is also used by the separate Dark Hole liberation list.
-- Never mutate cached area encounter definitions when assigning pool weights.
function PanelEncounters.pick_weighted(candidates)
  if type(candidates) ~= "table" then return nil end
  local total = 0
  local valid = {}
  for _, entry in ipairs(candidates) do
    if type(entry) == "table" and type(entry.path) == "string" and entry.path ~= "" then
      local weight = tonumber(entry.weight)
      if weight == nil then weight = 1 end
      if weight > 0 and weight < math.huge then
        valid[#valid + 1] = {definition = entry, weight = weight}
        total = total + weight
      end
    end
  end
  if total <= 0 then return nil end
  local choice = math.random() * total
  for _, item in ipairs(valid) do
    choice = choice - item.weight
    if choice <= 0 then return item.definition end
  end
  return valid[#valid].definition
end

-- Used by instance.lua for the per-panel "Encounter Path" custom property
-- override. Routes through the area-scoped ezencounters.resolve_encounter
-- lookup so names resolve to the current base area's full definition.
-- Literal package paths remain supported by the resolver.
function PanelEncounters.resolve_encounter_value(reference, base_area_id)
  if reference == nil or tostring(reference) == "" then return nil end
  local ezencounters = require("scripts/ezlibs-scripts/ezencounters/main")
  if type(ezencounters.resolve_encounter) == "function" then
    return ezencounters.resolve_encounter(reference, base_area_id)
  end
  return { path = tostring(reference) }
end

-- Resolve an authored encounter name ONLY inside the requested section of the
-- base area's encounter file. The global ezencounters name registry is not
-- suitable here: two areas may legitimately use the same encounter name.
-- Never treat an unknown name as a package path or random encounter.
function PanelEncounters.resolve_named_encounter(base_area_id, category, reference)
  local name = reference ~= nil and tostring(reference):match("^%s*(.-)%s*$") or ""
  if name == "" then return nil end

  local encounter_table = load_area_encounter_table(base_area_id)
  local section = type(encounter_table) == "table" and encounter_table[category] or nil
  if type(section) == "table" then
    for _, definition in ipairs(section) do
      if definition.name == name then
        if type(definition.path) ~= "string" or definition.path == "" then
          log:error_data("Named liberation encounter has no package path", {
            base_area_id = base_area_id,
            category = category,
            encounter_name = name,
          })
          return nil
        end
        local copy = {}
        for key, value in pairs(definition) do copy[key] = value end
        return copy
      end
    end
  end

  log:warn_data("Named liberation encounter not found in area section", {
    base_area_id = base_area_id,
    category = category,
    encounter_name = name,
  })
  return nil
end

-- The object reference is to a Tiled "Dark Hole Encounter List" object in
-- the BASE area. Each nonblank numbered Name field is the name of a
-- special_encounters entry in that area's encounter table. Missing and
-- invalid names are ignored with diagnostics; a fully empty/invalid list
-- yields no candidates so the caller can use its bot encounter instead.
function PanelEncounters.resolve_dark_hole_liberation_encounters(base_area_id, object_reference)
  if object_reference == nil or tostring(object_reference) == "" or tostring(object_reference) == "0" then
    return {}
  end
  local id = tonumber(object_reference) or object_reference
  local list_object = Net.get_object_by_id(base_area_id, id)
  if not list_object or list_object.type ~= "Dark Hole Encounter List" then
    log:warn_data("Dark Hole Liberation Encounters is not a Dark Hole Encounter List", {
      base_area_id = base_area_id,
      reference = tostring(object_reference),
      object_type = list_object and list_object.type,
    })
    return {}
  end

  local numbered = {}
  for field, value in pairs(list_object.custom_properties or {}) do
    local index = type(field) == "string" and tonumber(field:match("^Name (%d+)$"))
    local name = value ~= nil and tostring(value):match("^%s*(.-)%s*$") or ""
    if index and index > 0 and name ~= "" then
      numbered[#numbered + 1] = { index = index, name = name }
    end
  end
  table.sort(numbered, function(a, b) return a.index < b.index end)

  local candidates = {}
  for _, entry in ipairs(numbered) do
    local definition = PanelEncounters.resolve_named_encounter(
      base_area_id, "special_encounters", entry.name)
    if definition then
      candidates[#candidates + 1] = definition
    end
  end
  return candidates
end

-- New Tiled encounter selection modes apply to the OW bot encounter only.
-- The separate "Liberation Encounters" list is selected by instance.lua and
-- intentionally keeps its own authored battle HP.
local function nonempty(value)
  if value == nil then return nil end
  local name = tostring(value):match("^%s*(.-)%s*$")
  if name == "" or name == "0" or name == "Auto" then return nil end
  return name
end

local function normalize_category(value, fallback)
  if value == "encounters" or value == "special_encounters" or value == "bosses" then
    return value
  end
  return fallback or "encounters"
end

local function weighted_pool(base_area_id, reference, inherited_category)
  local pool_id = tonumber(reference)
  if not pool_id or pool_id <= 0 then
    log:warn_data("Encounter Pool missing a valid Tiled object reference", {
      base_area_id = base_area_id, pool_reference = tostring(reference),
    })
    return nil
  end
  local ok, pool = pcall(Net.get_object_by_id, base_area_id, pool_id)
  if not ok or type(pool) ~= "table" or pool.type ~= "Liberation Encounter Pool" then
    log:warn_data("Encounter Pool reference is not a Liberation Encounter Pool", {
      base_area_id = base_area_id, pool_reference = tostring(reference),
      actual_type = pool and pool.type,
    })
    return nil
  end
  local properties = pool.custom_properties or {}
  local category = normalize_category(properties["Encounter Category"], inherited_category)
  local entries = {}
  for index = 1, 20 do
    local name = nonempty(properties["Name " .. index])
    local weight = tonumber(properties["Weight " .. index])
    if name then
      if weight == nil then weight = 1 end
      if weight > 0 and weight < math.huge then
        local found = PanelEncounters.resolve_named_encounter(base_area_id, category, name)
        if found then
          found.weight = weight
          entries[#entries + 1] = found
        end
      elseif weight < 0 then
        log:warn_data("Encounter Pool has negative weight; entry ignored", {
          base_area_id = base_area_id, pool_id = pool_id,
          encounter_name = name, weight = weight,
        })
      end
    end
  end
  local selected = PanelEncounters.pick_weighted(entries)
  log:info_data("Encounter Pool resolved", {
    base_area_id = base_area_id, pool_id = pool_id, category = category,
    candidate_count = #entries, selected_encounter = selected and selected.name,
  })
  return selected
end

-- Resolves fixed, pool or category-based overworld encounters using the
-- base area's encounter data. Config values were already merged by
-- EnemyConfig.resolve (local > shared > category > global).
-- If a setting is unavailable/invalid, fall back to the normal category.
function PanelEncounters.resolve_enemy_encounter(base_area_id, default_category, enemy, properties, config)
  properties = properties or {}
  config = config or {}
  local category = normalize_category(
    config.encounter_category or (enemy and enemy.encounter_category)
      or properties["Encounter Category"], default_category)
  local mode = nonempty(config.encounter_mode)
    or nonempty(enemy and enemy.encounter_mode)
    or nonempty(properties["Encounter Mode"]) or "Auto"
  local name = nonempty(config.encounter_name)
    or nonempty(enemy and enemy.ow_bot_encounter_name)
    or nonempty(properties["OW Bot Encounter"])
    or nonempty(properties["Boss Encounter"])
    or nonempty(enemy and enemy.default_ow_bot_encounter_name)
  local pool = config.encounter_pool
    or (enemy and enemy.encounter_pool)
    or properties["OW Encounter Pool"]

  local resolved = nil
  if mode == "Category" then
    resolved = PanelEncounters.resolve_encounter(base_area_id, category)
  elseif mode == "Fixed" then
    if name then resolved = PanelEncounters.resolve_named_encounter(base_area_id, category, name) end
    if not resolved then
      log:warn_data("Fixed encounter missing; falling back to category", {
        base_area_id = base_area_id, requested_name = tostring(name), category = category,
      })
    end
  elseif mode == "Pool" then
    resolved = weighted_pool(base_area_id, pool, category)
    if not resolved then
      log:warn_data("Encounter Pool could not select an encounter; falling back to category", {
        base_area_id = base_area_id, pool_reference = tostring(pool), category = category,
      })
    end
  else -- Auto (including unknown/legacy values)
    if name then resolved = PanelEncounters.resolve_named_encounter(base_area_id, category, name) end
    if not resolved and tonumber(pool) and tonumber(pool) > 0 then
      resolved = weighted_pool(base_area_id, pool, category)
    end
  end
  if not resolved then
    resolved = PanelEncounters.resolve_encounter(base_area_id, category)
  end
  log:info_data("Resolved enemy encounter selection", {
    base_area_id = base_area_id, category = category, mode = mode,
    requested_name = name, pool = pool,
    selected_name = resolved and resolved.name,
  })
  return resolved
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
    local is_liberation_area = false
    for _, object_id in ipairs(Net.list_objects(area_id) or {}) do
      local object = Net.get_object_by_id(area_id, object_id)
      if object and object.type == "Liberation Config" then
        local props = object.custom_properties or {}
        if props["Liberation Tileset"] then is_liberation_area = true end
        break
      end
    end
    if is_liberation_area then
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