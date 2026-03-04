-- server/scripts/net-games/dialogue/startup.lua
print("[net-games dialogue/startup] LOADING...")
_G.NG_TEXTBOX_DEBUG = false
_G.NG_TEXTBOX_DEBUG_TRACE = false

local Displayer = require("scripts/displayer/displayer")
local Input     = require("scripts/input/input")

assert(Displayer:init(), "[net-games dialogue/startup] Displayer failed to init")
Input.attach_virtual_input_listener()

print("[net-games dialogue/startup] READY")
return true