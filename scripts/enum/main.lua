-- main.lua
-- Example of how to use the modules.

local Enum = require("scripts/enum/enum")
local EnumSet = require("scripts/enum/enumset")
local PredefinedEnums = require("scripts/enum/predefined-enums")

-- Create a set from the predefined enums
local mySet = EnumSet.new(PredefinedEnums)

-- Access an enum by key -> automatically returns a copy
local color = mySet.Color
color.active = color.BLUE
print("Original Color active:", PredefinedEnums.Color:getName(PredefinedEnums.Color:getActive()))
print("Copy Color active:    ", color:getName(color:getActive()))

-- Each access yields a new copy
local anotherColor = mySet.Color
anotherColor.active = anotherColor.GREEN
print("Another copy active:  ", anotherColor:getName(anotherColor:getActive()))

-- Use explicit get method
local status = mySet:get("Status")
status.active = status.PENDING
print("Status copy active:   ", status:getName(status:getActive()))

-- List keys
print("Available keys:")
for _, k in ipairs(mySet:keys()) do
    print(" - " .. k)
end