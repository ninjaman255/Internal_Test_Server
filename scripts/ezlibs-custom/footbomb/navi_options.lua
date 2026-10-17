-- Selectable Navi roster. Each entry references shared paths and state names.
local C = require("scripts/ezlibs-custom/footbomb/constants")
local States = require("scripts/ezlibs-custom/footbomb/animation_states")
local root = C.ASSETS.BOT_FOLDER

return {
    { name = "MegaMan", texture = root .. "megaman.png", animation = root .. "megaman.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE },
    { name = "Roll", texture = root .. "roll.png", animation = root .. "roll.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE },
    { name = "Normal Navi", texture = root .. "normal-navi-green.png", animation = root .. "normal-navi-green.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE },
    { name = "ProtoMan", texture = root .. "protoman.png", animation = root .. "protoman.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE },
    { name = "Glyde", texture = root .. "glyde.png", animation = root .. "glyde.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE },
    { name = "GutsMan", texture = root .. "gutsman.png", animation = root .. "gutsman.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE },
    { name = "Prog", texture = root .. "prog.png", animation = root .. "prog.animation", animation_state = States.FOOTBOMB_IDLE_DEFENSE },
}
