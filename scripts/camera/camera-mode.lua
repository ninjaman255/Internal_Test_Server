CameraMode = {
    MiniMap = "minimap",
    PlayerControlled = "player",
    ServerControlled = "server",
    Custom = "custom"

}

function CameraMode:new()
    local o = {}
    setmetatable(o, CameraMode)
    return o
end

return CameraMode