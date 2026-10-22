local extensions = {}

function file_exists(path)
  local file = io.open(path, "r")
  if file == nil then return false end
  
  file:close()
  return true
end



return extensions