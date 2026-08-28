-- predefined_enums.lua
-- Central place to define your enums for easy reuse.
-- You can add as many as you like.

local Enum = require("scripts/enum/enum")

local PredefinedEnums = {
    Color = Enum.new("RED", "GREEN", "BLUE"),
    Status = Enum.new({
        ACTIVE   = "active",
        INACTIVE = "inactive",
        PENDING  = { code = 0, label = "pending" },
    }),
    LogLevel = Enum.new("DEBUG", "INFO", "WARN", "ERROR"),
    -- Add more enums here...
}

return PredefinedEnums