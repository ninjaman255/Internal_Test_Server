local ColorPicker = {}
ColorPicker.__index = ColorPicker

function ColorPicker:getRandom(which)
    local targetArray
    if which == "rainbow" then
        targetArray = self.RainbowArray
    elseif which == "colors" then
        targetArray = ColorPicker.ColorArray
    else
        error("Invalid color set specified. Use 'rainbow' or 'colors'.")
    end
    local random_number = math.random(1, #targetArray)
    return targetArray[random_number]
end

function ColorPicker:new()
    local self = setmetatable({}, ColorPicker)
    self.Rainbow = {    
        red    = { r = 255, g = 0,   b = 0   },
        orange = { r = 255, g = 165, b = 0   },
        yellow = { r = 255, g = 255, b = 0   },
        green  = { r = 0,   g = 128, b = 0   },
        blue   = { r = 0,   g = 0,   b = 255 },
        indigo = { r = 75,  g = 0,   b = 130 },
        violet = { r = 238, g = 130, b = 238 }
    }
    self.RainbowArray = {
        self.Rainbow.red, self.Rainbow.orange, self.Rainbow.yellow,
        self.Rainbow.green, self.Rainbow.blue, self.Rainbow.indigo, self.Rainbow.violet
    }
    return self
end

-- Extended color set accessible from outside
ColorPicker.Colors = {
    red        = { r = 255, g = 0,   b = 0   },
    green      = { r = 0,   g = 128, b = 0   },
    blue       = { r = 0,   g = 0,   b = 255 },
    yellow     = { r = 255, g = 255, b = 0   },
    cyan       = { r = 0,   g = 255, b = 255 },
    magenta    = { r = 255, g = 0,   b = 255 },
    white      = { r = 255, g = 255, b = 255 },
    black      = { r = 0,   g = 0,   b = 0   },
    gray       = { r = 128, g = 128, b = 128 },
    silver     = { r = 192, g = 192, b = 192 },
    maroon     = { r = 128, g = 0,   b = 0   },
    olive      = { r = 128, g = 128, b = 0   },
    lime       = { r = 0,   g = 255, b = 0   },
    teal       = { r = 0,   g = 128, b = 128 },
    navy       = { r = 0,   g = 0,   b = 128 },
    purple     = { r = 128, g = 0,   b = 128 },
    fuchsia    = { r = 255, g = 0,   b = 255 },
    aqua       = { r = 0,   g = 255, b = 255 },
    orange     = { r = 255, g = 165, b = 0   },
    pink       = { r = 255, g = 192, b = 203 },
    brown      = { r = 165, g = 42,  b = 42  },
    beige      = { r = 245, g = 245, b = 220 },
    lavender   = { r = 230, g = 230, b = 250 },
    turquoise  = { r = 64,  g = 224, b = 208 },
    indigo     = { r = 75,  g = 0,   b = 130 },
    violet     = { r = 238, g = 130, b = 238 },
    gold       = { r = 255, g = 215, b = 0   },
    coral      = { r = 255, g = 127, b = 80  },
    salmon     = { r = 250, g = 128, b = 114 },
    khaki      = { r = 240, g = 230, b = 140 },
    plum       = { r = 221, g = 160, b = 221 },
    orchid     = { r = 218, g = 112, b = 214 },
}

-- Also provide an array version for easy random access / iteration
ColorPicker.ColorArray = {}
for name, color in pairs(ColorPicker.Colors) do
    table.insert(ColorPicker.ColorArray, color)
end

return ColorPicker