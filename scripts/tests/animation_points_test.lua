package.path = "./?.lua;./?/main.lua;" .. package.path
local AnimationPoints = require("scripts/ezlibs-custom/footbomb/animation_points")

local function check(label, frame, point, expected_x, expected_y)
    local offset, err = AnimationPoints.offset(frame, point)
    assert(offset, label .. ": " .. tostring(err))
    assert(offset.x == expected_x, label .. ": expected x=" .. expected_x .. ", got " .. tostring(offset.x))
    assert(offset.y == expected_y, label .. ": expected y=" .. expected_y .. ", got " .. tostring(offset.y))
    print("PASS " .. label .. " offset=" .. offset.x .. "," .. offset.y)
end

local base = { w = 36, h = 36, originx = 19, originy = 35 }
local ball = { x = 31, y = 11 }
check("normal frame", base, ball, 12, -24)
check("horizontal flip", { w = 36, h = 36, originx = 19, originy = 35, flipx = 1 }, ball, -12, -24)
check("vertical flip", { w = 36, h = 36, originx = 19, originy = 35, flipy = 1 }, ball, 12, 24)
check("both flips", { w = 36, h = 36, originx = 19, originy = 35, flipx = 1, flipy = 1 }, ball, -12, 24)
check("different frame origin", { w = 30, h = 24, originx = 14, originy = 18 }, { x = 9, y = 5 }, -5, -13)

local offset, err = AnimationPoints.offset(base, { x = "bad", y = 11 })
assert(offset == nil and err, "non-numeric point coordinates should fail clearly")
print("PASS invalid point coordinates rejected")
