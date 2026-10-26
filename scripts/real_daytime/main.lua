--[[
* ---------------------------------------------------------- *
                  Ambient Manager
* ---------------------------------------------------------- *
]]

local AmbientManage = {}

local ambient_areas = {}

local dawn_texture = "/server/assets/real_daytime/dawn.png"
local morning_texture = "/server/assets/real_daytime/morning.png"
local night_texture = "/server/assets/real_daytime/night.png"

local dawn_start_time = 1
local morning_start_time = 6 * 60 + 1
local afternoon_start_time = 12 * 60 + 1
local night_start_time = 18 * 60 + 1

local last_update_minute = nil

local valid_day_night_modes = {
  sync = true,
  cus = true,
  off = true
}


-- AREA SETTINGS
local function get_area_settings(area_id)
  local settings = ambient_areas[area_id]

  if settings ~= nil then
    return settings
  end

  local mode = Net.get_area_custom_property(area_id, "Ambient_day_night")

  if mode == nil then return nil end

  mode = mode:lower()

  if not valid_day_night_modes[mode] then return nil end

  local timezone_offset = nil

  if mode == "cus" or mode == "off" then
    timezone_offset = tonumber(Net.get_area_custom_property(area_id, "Ambient_timezone"))

    if timezone_offset == nil or timezone_offset < -840 or timezone_offset > 840 then
      if mode == "cus" then return nil end

      timezone_offset = nil
    end
  end

  local foreground = Net.get_foreground(area_id)
  local velocity = Net.get_foreground_velocity(area_id)
  local parallax = Net.get_foreground_parallax(area_id)

  settings = {
    day_night_mode = mode,
    timezone_offset = timezone_offset,
    current_phase = nil,
    current_date = nil,

    original_foreground = {
      texture_path = foreground.texture_path,
      animation_path = foreground.animation_path,
      velocity_x = velocity.x,
      velocity_y = velocity.y,
      parallax = parallax
    }
  }

  ambient_areas[area_id] = settings

  return settings
end

-- CURRENT TIME
local function get_current_time(settings)
  if settings.day_night_mode == "cus"
      or (settings.day_night_mode == "off" and settings.timezone_offset ~= nil) then
    local timestamp = os.time()

    return os.date("*t", timestamp + settings.timezone_offset * 60)
  end

  return os.date("*t")
end

-- DAY PHASE
local function get_day_phase(time)
  local current_time = time.hour * 60 + time.min

  if current_time >= dawn_start_time and current_time < morning_start_time then
    return "dawn"
  end

  if current_time >= morning_start_time and current_time < afternoon_start_time then
    return "morning"
  end

  if current_time >= afternoon_start_time and current_time < night_start_time then
    return "afternoon"
  end

  return "night"
end

-- DAY DATE
local function get_day_date(time)
  return string.format("%04d-%02d-%02d", time.year, time.month, time.day)
end

-- DAY TYPE
local day_types = {
  "sunday",
  "monday",
  "tuesday",
  "wednesday",
  "thursday",
  "friday",
  "saturday"
}

local function get_day_type(time)
  return day_types[time.wday]
end

-- RESTORE FOREGROUND
local function restore_foreground(area_id, settings)
  local foreground = settings.original_foreground

  Net.set_foreground(area_id, foreground.texture_path, foreground.animation_path,
    foreground.velocity_x, foreground.velocity_y, foreground.parallax)
end

-- APPLY DAY PHASE
local function apply_day_phase(area_id, settings, phase)
  if phase == "dawn" then
    Net.set_foreground(area_id, dawn_texture, "", 0, 0, 0)
  elseif phase == "morning" then
    Net.set_foreground(area_id, morning_texture, "", 0, 0, 0)
  elseif phase == "afternoon" then
    restore_foreground(area_id, settings)
  elseif phase == "night" then
    Net.set_foreground(area_id, night_texture, "", 0, 0, 0)
  end
end

-- CLEAN DAY PROPERTIES IF AMBIENT_DAY_NIGHT IS TOGGLED OFF
local properties = {
  "Day_time",
  "Day_date",
  "Day_type"
}

local function clear_day_properties(area_id)
  for _, property in ipairs(properties) do
    local value = Net.get_area_custom_property(area_id, property)

    if value ~= nil and value ~= "" then
      Net.set_area_custom_property(area_id, property, "")
    end
  end
end


-- UPDATE AREA
local function update_area(area_id)
  local settings = get_area_settings(area_id)

  if settings == nil then return end

  local time = get_current_time(settings)

  local date = get_day_date(time)

  if date ~= settings.current_date then
    Net.set_area_custom_property(area_id, "Day_date", date)
    Net.set_area_custom_property(area_id, "Day_type", get_day_type(time))

    settings.current_date = date
  end

  local phase = get_day_phase(time)

  if phase == settings.current_phase then return end

  Net.set_area_custom_property(area_id, "Day_time", phase)

  if settings.day_night_mode ~= "off" then
    apply_day_phase(area_id, settings, phase)
  end

  settings.current_phase = phase
end

-- REFRESH AREA SETTINGS
function AmbientManage.refresh_area(area_id)
  local old_settings = ambient_areas[area_id]

  if old_settings ~= nil
      and old_settings.day_night_mode ~= "off"
      and old_settings.current_phase ~= nil
      and old_settings.current_phase ~= "afternoon" then
    restore_foreground(area_id, old_settings)
  end

  ambient_areas[area_id] = nil

  update_area(area_id)

  if ambient_areas[area_id] == nil then
    clear_day_properties(area_id)
  end
end

-- GET DAY/NIGHT MODE
function AmbientManage.get_day_night_mode(area_id)
  local settings = get_area_settings(area_id)

  if settings == nil then return nil end

  return settings.day_night_mode
end

-- GET TIMEZONE
function AmbientManage.get_timezone(area_id)
  local settings = get_area_settings(area_id)

  if settings == nil then return nil end

  return settings.timezone_offset
end

-- CURRENT MINUTE
last_update_minute = os.date("%Y-%m-%d %H:%M")

-- INITIALIZE AREAS
for _, area_id in ipairs(Net.list_areas()) do
  update_area(area_id)
end

-- AUTOMATIC UPDATE
Net:on("tick", function()
  local current_minute = os.date("%Y-%m-%d %H:%M")

  if current_minute == last_update_minute then return end

  last_update_minute = current_minute

  for area_id, _ in pairs(ambient_areas) do
    update_area(area_id)
  end
end)

return AmbientManage
