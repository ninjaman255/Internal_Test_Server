local constants = {
    --BACKGROUNDS FOLDER FILEPATH FOR BACKGROUND MANAGE
    background_folder = "assets/Backgrounds/",
    background_asset_folder = "/server/assets/Backgrounds/",
    --OPTIONAL EXTENSIONS FILEPATH
    real_day_time = "scripts/real_daytime/main.lua",
    jukebox = "scripts/Jukebox/main.lua"
}

--CHECK IF HAS EXTENSIONS DOWNLOADED
function file_exists(path)
  local file = io.open(path, "r")
  if file == nil then return false end
  
  file:close()
  return true
end

return constants