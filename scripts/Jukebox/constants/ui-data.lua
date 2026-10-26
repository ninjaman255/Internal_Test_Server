local StaticUIData = {}

-- SCREEN
StaticUIData.Screen = {
    width = 240,
    height = 160
}

local UI_ROOT = "/server/assets/jukebox/ui-sprites/"
local RECORD_ROOT = "/server/assets/jukebox/disk_sprites/"

-- STATIC UI ELEMENTS
StaticUIData.UIIDNames = {
    "Shade Screen",
    "Jukebox Backdrop",
    "Jukebox Frame",
    "Jukebox Cursor Up",
    "Jukebox Cursor Down",
    "Jukebox Cursor Left",
    "Jukebox Cursor Right"
}

StaticUIData.UIData = {
    ["Shade Screen"] = {
        texture_path = UI_ROOT .. "shade-screen.png",
        anim_path = "",
        anim_state = "",
        x = 0,
        y = 0,
        z = 0,
        sx = 2.0,
        sy = 2.0
    },

    ["Jukebox Backdrop"] = {
        texture_path = UI_ROOT .. "jukebox-backdrop.png",
        anim_path = "",
        anim_state = "",
        x = 0,
        y = 1,
        z = 0,
        sx = 2.0,
        sy = 2.0
    },

    ["Jukebox Frame"] = {
        texture_path = UI_ROOT .. "jukebox-frame.png",
        anim_path = "",
        anim_state = "",
        x = 0,
        y = 0,
        z = 3,
        sx = 2.0,
        sy = 2.0
    },

    ["Jukebox Cursor Up"] = {
        texture_path = UI_ROOT .. "cursor.png",
        anim_path = UI_ROOT .. "cursor.animation",
        anim_state = "UP",
        x = 180,
        y = 130,
        z = 4,
        sx = 2.0,
        sy = 2.0
    },


    ["Jukebox Cursor Down"] = {
        texture_path = UI_ROOT .. "cursor.png",
        anim_path = UI_ROOT .. "cursor.animation",
        anim_state = "DOWN",
        x = 180,
        y = 156,
        z = 4,
        sx = 2.0,
        sy = 2.0
    },

    ["Jukebox Cursor Left"] = {
        texture_path = UI_ROOT .. "cursor.png",
        anim_path = UI_ROOT .. "cursor.animation",
        anim_state = "LEFT",
        x = 51,
        y = 97,
        z = 4,
        sx = 2.0,
        sy = 2.0
    },

    ["Jukebox Cursor Right"] = {
        texture_path = UI_ROOT .. "cursor.png",
        anim_path = UI_ROOT .. "cursor.animation",
        anim_state = "RIGHT",
        x = 189,
        y = 97,
        z = 4,
        sx = 2.0,
        sy = 2.0
    }
}

-- RECORD SETTINGS
StaticUIData.Record = {
    id_prefix = "Default Record:",
    art_root = RECORD_ROOT,
    anim_path = RECORD_ROOT .. "record.animation",
    anim_state = "DEFAULT",
    default_kind = "base",

    x = 120,
    y = 79,
    z = 2,
    sx = 2.0,
    sy = 2.0,

    fast_duration = 0.5,
    slow_duration = 12
}

-- ALBUM TITLE
StaticUIData.Title = {
    id = "Jukebox Title",
    font = "THICK",
    scale = 2.0,
    z = 5,

    x = 76,
    y = 98,
    width = 90,
    height = 20,
    speed = 60
}

-- MUSIC LIST
StaticUIData.SongList = {
    id_prefix = "Jukebox Track ",
    x = 70,
    y = 133,
    z = 5,
    scale = 1,
    font = "THICK",
    line_height = 9,
    visible = 3,

    colors = {
        normal = { 255, 255, 255 },
        selected = { 80, 160, 255 },
        playing = { 255, 220, 0 }
    }
}

-- CURSOR MOTION
StaticUIData.Cursor = {
    cycle = 0.8
}

return StaticUIData
