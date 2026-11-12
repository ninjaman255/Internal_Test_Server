
-- Controller-driven option menu for Nebulous Liberations mission interactions.
-- The title and option list use separate 9-slice panels:
--   options-header: title
--   options-body: option rows
-- Both panels fit the longest complete line (including cursor) without wrapping.

local Displayer = require("scripts/displayer/displayer")
local TextLayout = require("scripts/displayer/text-layout")
local PlayerControl = require("scripts/player-control/main")

local OptionMenu = {}

local ASSET_ROOT = "/server/assets/ezlibs-custom/nebulous-liberations/ui/"
local HEADER_TEXTURE = ASSET_ROOT .. "options-header.png"
local HEADER_ANIMATION = ASSET_ROOT .. "options-header.animation"
local BODY_TEXTURE = ASSET_ROOT .. "options-body.png"
local BODY_ANIMATION = ASSET_ROOT .. "options-body.animation"

local PANEL_ID_PREFIX = "liberation_option_menu:"
local INPUT_OWNER_PREFIX = "liberation_option_menu:"
local INPUT_SETTLE_SECONDS = 0.10

-- The previous menu used scale 2.0. 1.5 is three quarters of that scale.
local TEXT_SCALE = 1.5
local SLICE_SCALE = 1.5
-- Measure the actual THICK font, not a hard-coded panel width. For the
-- Golden Prog selector, allow smaller text only if the *whole* menu and mug
-- would exceed the player's screen. Never wrap an option across rows.
local FONT_NAME = "THICK"
local SLICE_CORNER_WIDTH = 7 -- options-header/body.animation CORNER_UL/CORNER_UR
local SCREEN_MARGIN = 12
-- Keep the header and body edges touching. A positive gap creates a
-- visible horizontal line between the two separate panel sprites.
local PANEL_GAP = 0

local PANEL_PADDING = { horizontal = 9, vertical = 8 }
local CHILD_PADDING = { horizontal = 3, vertical = 2 }
local OPTION_SPACING = 2

local header_style = Displayer.Builder.sliceStyle9(
    HEADER_TEXTURE,
    HEADER_ANIMATION
)

local body_style = Displayer.Builder.sliceStyle9(
    BODY_TEXTURE,
    BODY_ANIMATION
)

local active_menus = {}
-- Direction actions are generated dynamically by the input controller. A
-- diagonal is a distinct action (for example, UpRight), not a simultaneous
-- Up + Right action, so include every direction in the menu's release guard.
local MENU_ACTIONS = {
    "Up", "Down", "Left", "Right",
    "UpLeft", "UpRight", "DownLeft", "DownRight",
    "Confirm", "Cancel",
}
local CANCEL_OPTION = "Cancel"

-- A diagonal can generate more than one direction-press edge while the
-- controller transitions through cardinal states inside one input packet.
-- Consume ALL direction edges together so an obsolete intermediate edge
-- cannot move the cursor a second time on a later tick. Use the controller's
-- final active direction to decide which edge represents this action.
-- Direction repeats are handled separately from Confirm/Cancel, which must
-- remain deliberate, fresh presses.
local NAVIGATION_DIRECTIONS = {
    "Up", "Down", "Left", "Right",
    "UpLeft", "UpRight", "DownLeft", "DownRight",
}

local function read_navigation(controller, owner)
    local active = controller:get_active_direction(owner)
    local current_edge = false
    for _, direction in ipairs(NAVIGATION_DIRECTIONS) do
        local pressed = controller:is_action_pressed(direction, owner)
        local repeated = controller:is_action_repeated(direction, owner)
        if direction == active and (pressed or repeated) then
            current_edge = true
        end
    end

    if not current_edge then return 0 end
    if active == "Up" or active == "UpLeft" or active == "UpRight" then
        return -1
    elseif active == "Down" or active == "DownLeft" or active == "DownRight" then
        return 1
    end
    return 0
end

local function make_header_children(title, text_scale)
    return {
        Displayer.Builder.panelTextChild(title or "Select an option", {
            font = "THICK",
            scale = text_scale or TEXT_SCALE,
            color = { r = 0, g = 0, b = 0, a = 255 },
            align = "center",
        }),
    }
end

-- The mission selector can supply a maximum visible row count. Other
-- Liberation interactions retain their existing, unpaginated layout.
local function menu_window(menu)
    local total = #menu.options
    local count = math.min(total, menu.max_visible or total)
    local first = math.max(1, math.min(menu.first_visible or 1, total - count + 1))
    return first, first + count - 1
end

local function menu_title(menu)
    if menu.max_visible and #menu.options > menu.max_visible then
        return tostring(menu.title or "Select") .. " "
            .. tostring(menu.selected) .. "/" .. tostring(#menu.options)
    end
    return menu.title
end

local function make_body_children(menu)
    local children = {}
    local first, last = menu_window(menu)
    for index = first, last do
        local label = tostring(menu.options[index]):gsub("[\r\n\f]", " ")
        local cursor = index == menu.selected and "> " or "  "
        children[#children + 1] = Displayer.Builder.panelTextChild(
            cursor .. label,
            {
                font = "THICK",
                scale = menu.text_scale or TEXT_SCALE,
                color = { r = 0, g = 0, b = 0, a = 255 },
                align = "start",
            }
        )
    end
    return children
end

local function update_visible_window(menu)
    if not menu.max_visible then return end
    local count = menu.max_visible
    if menu.selected < menu.first_visible then
        menu.first_visible = menu.selected
    elseif menu.selected >= menu.first_visible + count then
        menu.first_visible = menu.selected - count + 1
    end
    menu.first_visible = math.max(1, math.min(
        menu.first_visible, #menu.options - count + 1))
end

local function remove_panel(player_id, panel_id)
    if panel_id then
        pcall(Displayer.SlicedPanel.remove, player_id, panel_id)
    end
end

-- Net screen sprites require a selected animation frame; allocating the raw
-- 120x48 gold-Prog mug without its animation would show the entire strip.
local function remove_mug(menu)
    if not menu.mug_allocated then return end
    pcall(Net.player_erase_sprite, menu.player_id, menu.mug_draw_id)
    pcall(Net.player_dealloc_sprite, menu.player_id, menu.mug_asset_id)
    menu.mug_allocated = false
end

local function prepare_mug(menu)
    local mug = menu.mugshot
    if not mug then return true end
    for _, path in ipairs({ mug.texture_path, mug.animation_path }) do
        if type(path) ~= "string" or path == "" then
            return false, "mugshot texture/animation path missing"
        end
        local ok, err = pcall(Net.provide_asset_for_player, menu.player_id, path)
        if not ok then return false, tostring(err) end
    end
    local ok, err = pcall(Net.player_alloc_sprite, menu.player_id,
        menu.mug_asset_id, {
            texture_path = mug.texture_path,
            anim_path = mug.animation_path,
            anim_state = mug.anim_state or "IDLE",
        })
    if not ok then return false, tostring(err) end
    menu.mug_allocated = true
    return true
end

local function position_mug(menu, x, y)
    if not menu.mug_allocated then return end
    local mug = menu.mugshot
    local scale = tonumber(mug.scale) or 2
    Net.player_draw_sprite(menu.player_id, menu.mug_asset_id, {
        id = menu.mug_draw_id,
        x = math.floor(x),
        y = math.floor(y),
        z = 230,
        sx = scale,
        sy = scale,
        anim_state = mug.anim_state or "IDLE",
    })
end

-- Displayer TextPanel measures text in virtual 240x160 units, then doubles
-- those measurements when sizing a 480x320 screen-space panel. Use the SAME
-- font metrics here so fixed-width text never enters its wrap path.
local function screen_text_width(text, scale)
    -- An option is one menu row, even if a future label contains line breaks.
    text = tostring(text or ""):gsub("[\r\n\f]", " ")
    return TextLayout.measureLine(text, {
        font = FONT_NAME,
        scale = scale,
    }) * 2
end

local function menu_text_width(menu, scale)
    local title = tostring(menu.title or "Select an option")
    if menu.max_visible and #menu.options > menu.max_visible then
        -- The counter changes while scrolling. Measure its WIDEST possible
        -- form up front so the panel never resizes between selections.
        title = title .. " " .. tostring(#menu.options)
            .. "/" .. tostring(#menu.options)
    end
    local maximum = screen_text_width(title, scale)
    for _, label in ipairs(menu.options) do
        local line = tostring(label)
        -- A selected line includes the actual > cursor. Also allow for the
        -- unselected padding so either state fits at the same panel width.
        maximum = math.max(maximum,
            screen_text_width("> " .. line, scale),
            screen_text_width("  " .. line, scale))
    end
    return maximum
end

local function measure_menu_width(menu)
    local horizontal_padding = 2 * (PANEL_PADDING.horizontal + CHILD_PADDING.horizontal)
    local minimum_width = math.ceil(2 * SLICE_CORNER_WIDTH * SLICE_SCALE + 1)
    local screen_width = Displayer:getScreenDimensions()
    screen_width = tonumber(screen_width) or 480
    local mug = menu.mugshot
    local mug_width = (menu.centered and mug)
        and (tonumber(mug.width) or 40) * (tonumber(mug.scale) or 2) or 0
    local mug_gap = mug_width > 0 and 12 or 0
    local available_width = math.max(minimum_width,
        screen_width - 2 * SCREEN_MARGIN - mug_width - mug_gap)

    local text_scale = TEXT_SCALE
    local wanted_text_width = menu_text_width(menu, text_scale)
    local available_text_width = available_width - horizontal_padding - 1
    if wanted_text_width > available_text_width and available_text_width > 0 then
        -- Keep the entire label on one line even for unusually long mission
        -- names, without moving the Prog mugshot off-screen.
        text_scale = text_scale * available_text_width / wanted_text_width
    end
    local measured = menu_text_width(menu, text_scale)
    -- One spare pixel avoids floating-point boundary wrapping in TextLayout.
    local width = math.max(minimum_width, math.ceil(measured + horizontal_padding + 1))
    return width, text_scale
end

local function position_panels(menu)
    if not menu.header_panel or not menu.body_panel then
        return
    end

    local screen_width, screen_height = Displayer:getScreenDimensions()
    screen_width = tonumber(screen_width) or 480
    screen_height = tonumber(screen_height) or 320

    local _, header_height = menu.header_panel:getSize()
    local _, body_height = menu.body_panel:getSize()
    header_height = tonumber(header_height) or 0
    body_height = tonumber(body_height) or 0

    local actual_width = math.max(tonumber(menu.panel_width) or 0, 1)
    local x, body_y, header_y
    if menu.centered then
        -- The selector is one horizontally centered group: Gold Prog mug on
        -- the left, existing two-panel 9-slice Liberation menu on the right.
        local mug = menu.mugshot
        local mug_width = mug and ((tonumber(mug.width) or 40)
            * (tonumber(mug.scale) or 2)) or 0
        local mug_height = mug and ((tonumber(mug.height) or 48)
            * (tonumber(mug.scale) or 2)) or 0
        local gap = mug and 12 or 0
        local group_width = mug_width + gap + actual_width
        local panel_height = header_height + PANEL_GAP + body_height
        local group_height = math.max(panel_height, mug_height)
        local group_x = math.max(SCREEN_MARGIN,
            math.floor((screen_width - group_width) / 2))
        local group_y = math.max(SCREEN_MARGIN,
            math.floor((screen_height - group_height) / 2))
        x = group_x + mug_width + gap
        header_y = group_y + math.floor((group_height - panel_height) / 2)
        body_y = header_y + header_height + PANEL_GAP
        if mug then
            position_mug(menu, group_x,
                group_y + math.floor((group_height - mug_height) / 2))
        end
    else
        -- Unchanged standard Liberation layout: lower right.
        x = math.floor(screen_width - actual_width - SCREEN_MARGIN)
        body_y = screen_height - body_height - SCREEN_MARGIN
        header_y = body_y - header_height - PANEL_GAP
        if header_y < SCREEN_MARGIN then
            header_y = SCREEN_MARGIN
            body_y = header_y + header_height + PANEL_GAP
        end
        x = math.max(SCREEN_MARGIN, x)
    end
    menu.header_panel:setPosition(x, math.floor(header_y))
    menu.body_panel:setPosition(x, math.floor(body_y))
end

local function find_cancel_option(options)
    for index, label in ipairs(options) do
        if type(label) == "string"
            and string.lower(string.gsub(label, "^%s*(.-)%s*$", "%1")) == "cancel" then
            return index
        end
    end
    return nil
end

local function refresh_body(menu)
    if menu.body_panel then
        update_visible_window(menu)
        menu.body_panel:setChildren(make_body_children(menu))
        if menu.max_visible and #menu.options > menu.max_visible then
            menu.header_panel:setChildren(make_header_children(menu_title(menu), menu.text_scale))
        end
        position_panels(menu)
    end
end

local function cleanup(player_id, menu, result)
    if menu.finished then
        return
    end

    menu.finished = true

    if active_menus[player_id] == menu then
        active_menus[player_id] = nil
    end

    remove_panel(player_id, menu.header_id)
    remove_panel(player_id, menu.body_id)
    remove_mug(menu)
    menu.header_panel = nil
    menu.body_panel = nil

    -- Session closure atomically releases focus, capture and held-button
    -- guards. Keep the promise result independent of those cleanup callbacks.
    if menu.control_session then menu.control_session:close() end
    menu.resolve(result)
end

local function create_panels(player_id, menu)
    menu.panel_width, menu.text_scale = measure_menu_width(menu)
    local initial_options = {
        auto_size = false,
        width = menu.panel_width,
        padding = PANEL_PADDING,
        child_padding = CHILD_PADDING,
        slice_scale = SLICE_SCALE,
        z = 220,
    }

    local header_options = Displayer.Builder.columnPanelOptions({
        auto_size = initial_options.auto_size,
        width = initial_options.width,
        padding = initial_options.padding,
        child_padding = initial_options.child_padding,
        slice_scale = initial_options.slice_scale,
        z = initial_options.z,
        children = make_header_children(menu_title(menu), menu.text_scale),
    })

    local body_options = Displayer.Builder.columnPanelOptions({
        auto_size = initial_options.auto_size,
        width = initial_options.width,
        padding = initial_options.padding,
        child_padding = initial_options.child_padding,
        main_axis_spacing = OPTION_SPACING,
        slice_scale = initial_options.slice_scale,
        z = initial_options.z,
        children = make_body_children(menu),
    })

    local header_panel, header_err = Displayer.SlicedPanel.createWithChildren(
        player_id,
        menu.header_id,
        SCREEN_MARGIN,
        SCREEN_MARGIN,
        header_style,
        header_options
    )

    if not header_panel then
        return false, header_err
    end

    menu.header_panel = header_panel

    local body_panel, body_err = Displayer.SlicedPanel.createWithChildren(
        player_id,
        menu.body_id,
        SCREEN_MARGIN,
        SCREEN_MARGIN,
        body_style,
        body_options
    )

    if not body_panel then
        remove_panel(player_id, menu.header_id)
        menu.header_panel = nil
        return false, body_err
    end

    menu.body_panel = body_panel

    position_panels(menu)
    return true
end

-- Process all active menus from one engine tick listener.
Net:on("tick", function(event)
    for player_id, menu in pairs(active_menus) do
        if menu.active and not menu.finished then
            if not Net.is_player(player_id) then
                cleanup(player_id, menu, nil)
            else
                -- Do not put the multi-return :input() call behind `and`:
                -- Lua's logical operators collapse multiple returns to ONE,
                -- silently dropping the owner token. InputController then
                -- refuses every input query while the session holds focus.
                local ctrl, owner
                if menu.control_session then
                    ctrl, owner = menu.control_session:input()
                end
                if not ctrl then
                    -- A different interface currently has focus. Do not poll
                    -- or consume that interface's input events.
                else
                -- A native NPC dialogue may still have its interaction key
                -- held as we open. PlayerControl:guard_input() already
                -- requires release for every menu action; do not add a
                -- second "wait until absolutely neutral" gate, which could
                -- leave this menu unresponsive when the client reports a
                -- sticky direction or changes diagonal direction.
                local navigation = read_navigation(ctrl, owner)

                -- Cancel/Confirm are single-edge actions. Prefer them over
                -- navigation if the player pressed both in one frame, and
                -- never leave an old navigation edge buffered afterward.
                if ctrl:is_action_pressed("Cancel", owner) then
                    cleanup(player_id, menu, menu.cancel_index - 1)
                elseif ctrl:is_action_pressed("Confirm", owner) then
                    cleanup(player_id, menu, menu.selected - 1)
                elseif navigation ~= 0 then
                    menu.selected = ((menu.selected - 1 + navigation)
                        % #menu.options) + 1
                    refresh_body(menu)
                end
                end -- managed input is current
            end
        end
    end
end)

-- config (optional): max_visible, centered, mugshot. Selection results remain
-- zero based, including the visible Cancel row, for existing callers.
function OptionMenu.select(player_id, options, title, config)
    config = config or {}
    if type(options) ~= "table" then
        return Async.create_promise(function(resolve)
            resolve(nil)
        end)
    end

    -- Work on a copy so adding the fallback Cancel row never mutates a
    -- caller-owned options table or changes the indexes of existing choices.
    local menu_options = {}
    for index, label in ipairs(options) do
        menu_options[index] = label
    end

    local cancel_index = find_cancel_option(menu_options)
    if not cancel_index then
        menu_options[#menu_options + 1] = CANCEL_OPTION
        cancel_index = #menu_options
    end

    if active_menus[player_id] then
        return Async.create_promise(function(resolve)
            resolve(nil)
        end)
    end

    local owner=INPUT_OWNER_PREFIX..tostring(player_id)
    local header_id = PANEL_ID_PREFIX .. tostring(player_id) .. ":header"
    local body_id = PANEL_ID_PREFIX .. tostring(player_id) .. ":body"

    return Async.create_promise(function(resolve)
        local menu = {
            player_id = player_id,
            owner = owner,
            header_id = header_id,
            body_id = body_id,
            title = title,
            options = menu_options,
            cancel_index = cancel_index,
            selected = 1,
            first_visible = 1,
            max_visible = config.max_visible and math.max(1,
                math.floor(tonumber(config.max_visible) or #menu_options)) or nil,
            centered = config.centered == true,
            mugshot = config.mugshot,
            mug_asset_id = PANEL_ID_PREFIX .. tostring(player_id) .. ":mug_asset",
            mug_draw_id = PANEL_ID_PREFIX .. tostring(player_id) .. ":mug_draw",
            active = false,
            finished = false,
            header_panel = nil,
            body_panel = nil,
            resolve = resolve,
        }

        local control,err=PlayerControl.begin(player_id,{
            owner=owner,profile="menu",handoff_free_camera=true,
        })
        if not control then
            print("[Liberation OptionMenu] Input focus unavailable: "..tostring(err))
            resolve(nil)
            return
        end
        menu.control_session=control
        control:poll({})
        control:on_close(function()
            -- Called on disconnect / parent disposal as well as normal close.
            if menu.finished then return end
            menu.finished=true
            if active_menus[player_id]==menu then active_menus[player_id]=nil end
            remove_panel(player_id,menu.header_id)
            remove_panel(player_id,menu.body_id)
            remove_mug(menu)
            menu.header_panel=nil
            menu.body_panel=nil
            menu.resolve(nil)
        end)
        control:guard_input(0,MENU_ACTIONS)
        local mug_ready, mug_err = prepare_mug(menu)
        if not mug_ready then
            print("[Liberation OptionMenu] Mugshot setup failed: " .. tostring(mug_err))
            control:close()
            return
        end
        local created,create_err=create_panels(player_id,menu)
        if not created then
            print("[Liberation OptionMenu] Panel creation failed: "..tostring(create_err))
            control:close()
            return
        end

        active_menus[player_id] = menu

        -- Ignore inputs during the panel transition. Then consume any edges
        -- generated during that interval and require a fresh release/press.
        Async.sleep(INPUT_SETTLE_SECONDS).and_then(function()
            if menu.finished then
                return
            end

            if not Net.is_player(player_id) then
                cleanup(player_id, menu, nil)
                return
            end

            if not control:guard_input(0,MENU_ACTIONS) then
                -- Remain live; the tick dispatcher resumes when focus returns.
                menu.active=true
                return
            end
            local ctrl,token=control:input()
            if not ctrl then menu.active=true;return end

            -- guard_input above handles held keys through InputController's
            -- release_required flags. Requiring an independently neutral
            -- D-pad here can stall navigation after diagonal transitions.
            menu.active = true
        end)
    end)
end

return OptionMenu
