-- layouts-demo.lua
-- Demonstration of all layout types using card and menu_option sprites
-- Timer system
local Timer = {}
Timer.__index = Timer

function Timer.new(delay, callback)
    local self = setmetatable({}, Timer)
    self.delay = delay
    self.callback = callback
    self.elapsed = 0
    self.active = true
    return self
end

function Timer:update(dt)
    if not self.active then return false end

    self.elapsed = self.elapsed + dt
    if self.elapsed >= self.delay then
        self.active = false
        self.callback()
        return true
    end
    return false
end

local SpriteSystem = require("scripts/sprite-widget/sprite-displayer")
-- local CameraController = require("scripts/camera-controller")

-- Helper function to create sprite instances
local function create_sprite_instances(player_id, sprite_id, base_id, count)
    local sprites = {}
    for i = 1, count do
        if sprite_id == "card" then
        local sprite = SpriteSystem.Sprite.create(player_id, sprite_id, 
            base_id .. "_" .. tostring(i), {
                x = 0,
                y = 0,
                width = 21,  -- Reduced from 64 to 16 for 240x160 screen
                height = 39  -- Reduced from 64 to 16 for 240x160 screen
            })
        table.insert(sprites, sprite)
        else
        local sprite = SpriteSystem.Sprite.create(player_id, sprite_id, 
            base_id .. "_" .. tostring(i), {
                x = 0,
                y = 0,
                width = 72,  -- Reduced from 64 to 16 for 240x160 screen
                height = 15  -- Reduced from 64 to 16 for 240x160 screen
            })
        table.insert(sprites, sprite)
        end
    end
    return sprites
end

-- Main demonstration function
local function demonstrate_layouts(player_id)
    print("=== Layout System Demonstration (240x160 screen) ===")
    
    -- Create sprite instances for demonstration
    local cards = create_sprite_instances(player_id, "card", "demo_card", 9)
    local menu_items = create_sprite_instances(player_id, "menu_option", "demo_menu", 9)
    
    -- Layout 1: ABSOLUTE (all children stacked at same position)
    print("\n1. ABSOLUTE Layout (stacked)")
    local absolute_layout = SpriteSystem.Layout.create({
        id = "absolute_demo",
        player_id = player_id,
        type = "absolute",
        x = 40,    -- Reduced from 100
        y = 40,    -- Reduced from 100
        alignment = SpriteSystem.Constants.ALIGNMENT.CENTER,
        spacing = { x = 0, y = 0 }
    })
    
    -- Add 3 cards stacked on top of each other
    for i = 1, 3 do
        if cards[i] then
            absolute_layout:add_child(cards[i])
        end
    end
    
    -- Add slight transparency to show stacking
    for i, child in ipairs(absolute_layout.children) do
        child:set_opacity(150 + (i * 30))

    end
    
    -- Debug the absolute layout
    SpriteSystem.Layout.debug(player_id, absolute_layout._id)
    
    
    -- Layout 2: RELATIVE (children with individual offsets)
    print("\n2. RELATIVE Layout (with offsets)")
    local relative_layout = SpriteSystem.Layout.create({
        id = "relative_demo",
        player_id = player_id,
        type = "relative",
        x = 120,   -- Adjusted position
        y = 40,    -- Adjusted position
        alignment = SpriteSystem.Constants.ALIGNMENT.TOP_RIGHT
    })
    
    -- Add cards with specific offsets
    local offset_cards = {}
    for i = 4, 6 do
        if cards[i] then
            -- Set individual offsets before adding
            cards[i]._obj.offset_x = (i - 4) * 10  -- Reduced from 40
            cards[i]._obj.offset_y = (i - 4) * 5   -- Reduced from 20
            relative_layout:add_child(cards[i])
            table.insert(offset_cards, cards[i])
        end
    end
    
    -- Set different animations for demonstration
    for i, card in ipairs(offset_cards) do
        local animations = {"IDLE_D", "IDLE_U", "IDLE_L", "IDLE_R"}
        card:set_animation(animations[i] or "IDLE_D")
    end
    
    
    -- Layout 3: HORIZONTAL (left to right arrangement)
    print("\n3. HORIZONTAL Layout")
    local horizontal_layout = SpriteSystem.Layout.create({
        id = "horizontal_demo",
        player_id = player_id,
        type = "horizontal",
        x = 40,    -- Reduced from 100
        y = 80,    -- Reduced from 300
        spacing = { x = 4, y = 0 },  -- Reduced from 10
        alignment = SpriteSystem.Constants.ALIGNMENT.CENTER_LEFT,
        max_children = 5
    })
    
    -- Add menu items horizontally
    for i = 1, 5 do
        if menu_items[i] then
            horizontal_layout:add_child(menu_items[i])
            -- Different scales for visual variety
        end
    end
    
    -- Move the last child to front to demonstrate ordering
    horizontal_layout:bring_child_to_front(menu_items[5])
    
    
    -- Layout 4: VERTICAL (top to bottom arrangement)
    print("\n4. VERTICAL Layout")
    local vertical_layout = SpriteSystem.Layout.create({
        id = "vertical_demo",
        player_id = player_id,
        type = "vertical",
        x = 0,   -- Adjusted position
        y = 0,    -- Adjusted position
        spacing = { x = 0, y = 6 },  -- Reduced from 15
        cross_axis_alignment = "center",
        main_axis_alignment = "start"
    })
    
    -- Add menu items vertically
    for i = 6, 9 do
        if menu_items[i] then
            vertical_layout:add_child(menu_items[i])
            -- Set different opacities
            menu_items[i]:set_opacity(150 + (i - 5) * 30)
              -- Reduced scale
        end
    end
    
    -- Demonstrate swapping children
    vertical_layout:swap_children(1, 4)
    
    
    -- Layout 5: GRID (matrix arrangement)
    print("\n5. GRID Layout")
    local grid_layout = SpriteSystem.Layout.create({
        id = "grid_demo",
        player_id = player_id,
        type = "grid",
        x = 120,   -- Adjusted position
        y = 120,   -- Adjusted position
        spacing = { x = 8, y = 8 },  -- Reduced from 20
        alignment = SpriteSystem.Constants.ALIGNMENT.CENTER,
        max_children = 9
    })
    
    -- Create new sprites for grid (reusing the remaining cards)
    local grid_sprites = {}
    for i = 7, 9 do
        if cards[i] then
            cards[i]:set_scale(0.4, 0.4)  -- Scale down grid sprites
            table.insert(grid_sprites, cards[i])
        end
    end
    
    -- Fill remaining slots with menu items
    for i = 1, 6 do
        if menu_items[i] and i <= 6 then
            menu_items[i]:set_scale(0.4, 0.4)  -- Scale down grid sprites
            table.insert(grid_sprites, menu_items[i])
        end
    end
    
    -- Add all sprites to grid (will be arranged in square grid)
    for _, sprite in ipairs(grid_sprites) do
        grid_layout:add_child(sprite)
    end
    
    -- Colorize grid items for visual distinction
    for i, child in ipairs(grid_layout.children) do
        local r = math.min(255, 100 + (i * 20))
        local g = math.min(255, 150 + (i * 10))
        local b = math.min(255, 200 - (i * 15))
        child:set_color(r, g, b, 255)
    end
    
    
    -- Layout 6: NESTED LAYOUTS (layout inside layout)
    print("\n6. NESTED LAYOUTS Demo")
    local container_layout = SpriteSystem.Layout.create({
        id = "container_demo",
        player_id = player_id,
        type = "absolute",
        x = 200,   -- Adjusted position
        y = 40,    -- Adjusted position
        alignment = SpriteSystem.Constants.ALIGNMENT.TOP_LEFT
    })
    
    -- Create a child layout
    local child_horizontal = SpriteSystem.Layout.create({
        id = "child_horizontal",
        player_id = player_id,
        type = "horizontal",
        x = 0,  -- Relative to parent
        y = 0,  -- Relative to parent
        spacing = { x = 2, y = 0 },  -- Reduced from 5
        alignment = SpriteSystem.Constants.ALIGNMENT.TOP_LEFT
    })
    
    -- Add 3 menu items to child layout with smaller size
    for i = 1, 3 do
        local new_menu = SpriteSystem.Sprite.create(player_id, "menu_option", 
            "nested_menu_" .. tostring(i), {
                x = 0,
                y = 0,
                width = 8,    -- Reduced from 32
                height = 8,   -- Reduced from 32
            })
        child_horizontal:add_child(new_menu)
    end
    
    -- Create a sprite to act as container background
    local container_bg = SpriteSystem.Sprite.create(player_id, "card", 
        "container_bg", {
            x = 200,    -- Same as container layout x
            y = 40,     -- Same as container layout y
            width = 32, -- Reduced from 200
            height = 16, -- Reduced from 100
            opacity = 100,
        })
    
    -- Add background to container
    container_layout:add_child(container_bg)
    
    -- Manually position child layout inside container
    for _, child in ipairs(child_horizontal.children) do
        child:set_position(202, 42)  -- Small offset from container
    end
    
    
    -- Interactive Demonstration Functions
    local function move_layout(layout_id, x, y)
        local layout = SpriteSystem.Layout.get(player_id, layout_id)
        if layout then
            layout:set_position(x, y)
            print(string.format("Moved layout %s to (%d, %d)", layout_id, x, y))
        end
    end
    
    local function change_alignment(layout_id, alignment)
        local layout = SpriteSystem.Layout.get(player_id, layout_id)
        if layout then
            layout:set_alignment(alignment)
            print(string.format("Changed layout %s alignment to %s", 
                layout_id, alignment))
        end
    end
    
    local function toggle_visibility(layout_id, visible)
        local layout = SpriteSystem.Layout.get(player_id, layout_id)
        if layout then
            for _, child in ipairs(layout.children) do
                child:set_visible(visible)
            end
            print(string.format("%s layout %s", 
                visible and "Showed" or "Hidden", layout_id))
        end
    end
    
    -- Return interactive controls
    return {
        move_absolute = function(x, y) 
            -- Clamp to screen bounds
            x = math.max(0, math.min(x, 240 - 32))
            y = math.max(0, math.min(y, 160 - 32))
            move_layout("absolute_demo", x, y) 
        end,
        move_horizontal = function(x, y) 
            x = math.max(0, math.min(x, 240 - 100))
            y = math.max(0, math.min(y, 160 - 32))
            move_layout("horizontal_demo", x, y) 
        end,
        move_grid = function(x, y) 
            x = math.max(0, math.min(x, 240 - 64))
            y = math.max(0, math.min(y, 160 - 64))
            move_layout("grid_demo", x, y) 
        end,
        
        align_absolute = function(align) change_alignment("absolute_demo", align) end,
        align_horizontal = function(align) change_alignment("horizontal_demo", align) end,
        
        show_all = function() 
            for _, layout_id in ipairs({"absolute_demo", "horizontal_demo", 
                                        "vertical_demo", "grid_demo", 
                                        "relative_demo"}) do
                toggle_visibility(layout_id, true)
            end
        end,
        
        hide_all = function()
            for _, layout_id in ipairs({"absolute_demo", "horizontal_demo", 
                                        "vertical_demo", "grid_demo", 
                                        "relative_demo"}) do
                toggle_visibility(layout_id, false)
            end
        end,
        
        debug_all = function()
            for _, layout_id in ipairs({"absolute_demo", "horizontal_demo", 
                                        "vertical_demo", "grid_demo", 
                                        "relative_demo", "container_demo"}) do
                SpriteSystem.Layout.debug(player_id, layout_id)
            end
        end,
        
        -- New function to get layout bounds
        get_screen_bounds = function()
            return {width = 240, height = 160}
        end
    }
end

-- Setup function to call when player joins
local function setup_player_layouts(player_id)
    -- Allocate sprites (from your example)
    SpriteSystem.Sprite.allocate(player_id, "card",
        "/server/assets/card.png",
        "/server/assets/card.anim",
        "IDLE_D"
    )
    
    SpriteSystem.Sprite.allocate(player_id, "menu_option",
        "/server/assets/net-games/menu_item.png",
        "/server/assets/net-games/menu_item.anim",
        "IDLE"
    )
    
    -- Create the layout demonstrations
    local controls = demonstrate_layouts(player_id)
    
    -- Example of using controls after setup
    print("\n=== Layout Controls Available (240x160 screen) ===")
    print("Screen bounds: 240x160")
    print("Use controls.move_absolute(x, y) to move absolute layout")
    print("Use controls.move_horizontal(x, y) to move horizontal layout")
    print("Use controls.align_absolute('center-center') to change alignment")
    print("Use controls.show_all() / controls.hide_all() to toggle visibility")
    print("Use controls.debug_all() to see detailed layout info")
    print("Positions are automatically clamped to screen bounds")
    
    return controls
end

-- Event handler for player join
Net:on("player_join", function(event)
    if event.player_id then
        print("Setting up layout demonstration for player:", event.player_id)
        local player_controls = setup_player_layouts(event.player_id)

        -- Store controls for later use
        _G["player_controls_" .. event.player_id] = player_controls
        
        -- Example: Move absolute layout after 3 seconds
        Timer.new(3000, function()
            player_controls.move_absolute(60, 60)
            player_controls.align_horizontal("center-center")
        end)
    end
end)

Net:on("tick", function(event)
    -- Timer updates would go here if you're using them
    -- For now, just a placeholder
end)

-- Cleanup on player leave
Net:on("player_disconnect", function(event)
    if event.player_id then
        -- Remove all sprites and layouts
        SpriteSystem.Sprite.removeAll(event.player_id)
        
        -- Clean up stored controls
        _G["player_controls_" .. event.player_id] = nil
        
        print("Cleaned up layouts for player:", event.player_id)
    end
end)

-- Export for manual testing
return {
    setup = setup_player_layouts,
    constants = SpriteSystem.Constants
}