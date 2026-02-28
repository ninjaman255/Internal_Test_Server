local ColorPicker = {}
ColorPicker.__index = ColorPicker

function ColorPicker:getRandom()
    local random_number = math.random(1, #self.RainbowArray)
    return self.RainbowArray[random_number]
end

function ColorPicker:new()
    local self = setmetatable({}, ColorPicker)
    self.Rainbow = {    
    red = {r = 255,g = 0,b = 0},
    orange = {r = 255,g = 165,b= 0},
    yellow = {r = 255,g = 255,b= 0},
    green = {r =0,g= 128,b= 0},
    blue = {r = 0, g =0, b = 255},
    indigo = {r = 75,g = 0,b = 130},
    violet = {r = 238,g = 130,b =  238}
    }
    self.RainbowArray = {
    self.Rainbow.red, self.Rainbow.orange, self.Rainbow.yellow, 
    self.Rainbow.green, self.Rainbow.blue, self.Rainbow.indigo, self.Rainbow.violet
    }
    return self
end

return ColorPicker