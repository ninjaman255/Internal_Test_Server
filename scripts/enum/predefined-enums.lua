-- predefined_enums.lua
-- Central place to define your enums for easy reuse.
-- You can add as many as you like.

local Enum = require("scripts/enum/enum")

local PredefinedEnums = {
    CameraMode = Enum.new({
        active = "minimap",
        options = {
            MiniMap = "minimap",
            PlayerControlled = "player",
            ServerControlled = "server",
            Custom = "custom"
        }
    }),
    
    Status = Enum.new({
        ACTIVE   = "active",
        INACTIVE = "inactive",
        PENDING  = { code = 0, label = "pending" },
    }),
    
    LogLevel = Enum.new({Debug = "DEBUG", Info = "INFO", Warn = "WARN", Error = "ERROR"}),
    
    DefaultPlayerAnimNames = Enum.new({
        IdleDL = "IDLE_DL",
        IdleDR = "IDLE_DR",
        IdleUL = "IDLE_UL",
        IdleUR = "IDLE_UR",
        IdleU = "IDLE_U",
        IdleD = "IDLE_D",
        IdleR = "IDLE_R",
        IdleL = "IDLE_L",
    })
}

return PredefinedEnums