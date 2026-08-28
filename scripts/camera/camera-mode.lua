CameraMode = {
    MiniMap = "minimap",
    PlayerControlled = "player",
    ServerControlled = "server",
    Custom = "custom"
}


function CameraMode:new(type)
    local o = {}

    setmetatable(o, CameraMode)
    return o
end

return CameraMode