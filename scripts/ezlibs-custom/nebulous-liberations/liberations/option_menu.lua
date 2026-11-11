
-- Controller-driven option menu for Nebulous Liberations mission interactions.
-- The title and option list use separate 9-slice panels:
--   options-header: title
--   options-body: option rows
-- Both panels share a width while keeping independently measured heights.

local Displayer = require("scripts/displayer/displayer")
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
local MENU_MAX_WIDTH = 220
-- Every Liberation menu uses the width measured from the widest known menu
-- title. Panel interaction is currently the widest menu, so all menus share
-- that width instead of resizing to their individual contents.
local SHARED_MENU_TITLE = "Panel interaction"
local shared_menu_width = nil
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

local function is_menu_up_pressed(controller, owner)
    return controller:is_action_pressed("Up", owner)
        or controller:is_action_pressed("UpLeft", owner)
        or controller:is_action_pressed("UpRight", owner)
end

local function is_menu_down_pressed(controller, owner)
    return controller:is_action_pressed("Down", owner)
        or controller:is_action_pressed("DownLeft", owner)
        or controller:is_action_pressed("DownRight", owner)
end

local function make_header_children(title)
    return {
        Displayer.Builder.panelTextChild(title or "Select an option", {
            font = "THICK",
            scale = TEXT_SCALE,
            color = { r = 0, g = 0, b = 0, a = 255 },
            align = "center",
        }),
    }
end

local function make_body_children(options, selected)
    local children = {}

    for index, label in ipairs(options) do
        local cursor = index == selected and "> " or "  "
        children[#children + 1] = Displayer.Builder.panelTextChild(
            cursor .. tostring(label),
            {
                font = "THICK",
                scale = TEXT_SCALE,
                color = { r = 0, g = 0, b = 0, a = 255 },
                align = "start",
            }
        )
    end

    return children
end

local function remove_panel(player_id, panel_id)
    if panel_id then
        pcall(Displayer.SlicedPanel.remove, player_id, panel_id)
    end
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

    -- Anchor both panels to the lower-right corner. The title panel sits
    -- flush against the options panel and shares the body panel's left edge.
    local actual_width = math.max(tonumber(menu.shared_width) or 0, 1)
    local x = math.floor(screen_width - actual_width - SCREEN_MARGIN)
    local body_y = screen_height - body_height - SCREEN_MARGIN
    local header_y = body_y - header_height - PANEL_GAP

    if header_y < SCREEN_MARGIN then
        header_y = SCREEN_MARGIN
        body_y = header_y + header_height + PANEL_GAP
    end

    x = math.max(SCREEN_MARGIN, x)

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
        menu.body_panel:setChildren(make_body_children(
            menu.options,
            menu.selected
        ))
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
    menu.header_panel = nil
    menu.body_panel = nil

    -- Session closure atomically releases focus, capture and held-button
    -- guards. Keep the promise result independent of those cleanup callbacks.
    if menu.control_session then menu.control_session:close() end
    menu.resolve(result)
end

local function apply_shared_width(menu)
    if not shared_menu_width then
        -- Measure the reference title, not whichever menu happened to open
        -- first. This makes the width deterministic across all menu types.
        local measured_width = menu.header_panel:getSize()
        measured_width = tonumber(measured_width) or 0
        shared_menu_width = math.min(
            math.max(measured_width, 1),
            MENU_MAX_WIDTH
        )
    end

    menu.shared_width = shared_menu_width

    -- Fix both 9-slice panels to the same width. Their heights remain measured
    -- independently from their own title/options and can grow when text wraps.
    menu.header_panel:setOptions({
        auto_size = false,
        width = shared_menu_width,
    })

    menu.body_panel:setOptions({
        auto_size = false,
        width = shared_menu_width,
    })
end

local function create_panels(player_id, menu)
    local initial_options = {
        auto_size = true,
        max_width = MENU_MAX_WIDTH,
        padding = PANEL_PADDING,
        child_padding = CHILD_PADDING,
        slice_scale = SLICE_SCALE,
        z = 220,
    }

    local header_options = Displayer.Builder.columnPanelOptions({
        auto_size = initial_options.auto_size,
        max_width = initial_options.max_width,
        padding = initial_options.padding,
        child_padding = initial_options.child_padding,
        slice_scale = initial_options.slice_scale,
        z = initial_options.z,
        -- The first menu establishes the shared width using the widest title.
        -- Its real title is restored after the fixed width has been applied.
        children = make_header_children(shared_menu_width and menu.title or SHARED_MENU_TITLE),
    })

    local body_options = Displayer.Builder.columnPanelOptions({
        auto_size = initial_options.auto_size,
        max_width = initial_options.max_width,
        padding = initial_options.padding,
        child_padding = initial_options.child_padding,
        main_axis_spacing = OPTION_SPACING,
        slice_scale = initial_options.slice_scale,
        z = initial_options.z,
        children = make_body_children(menu.options, menu.selected),
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

    apply_shared_width(menu)
    if menu.title ~= SHARED_MENU_TITLE then
        menu.header_panel:setChildren(make_header_children(menu.title))
    end
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
                local ctrl,owner=menu.control_session and menu.control_session:input()
                if not ctrl then
                    -- A different interface currently has focus. Do not poll
                    -- or consume that interface's input events.
                else
                local navigation_blocked = false

                if menu.waiting_for_direction_release then
                    navigation_blocked =
                        ctrl:get_active_direction(owner) ~= nil

                    if not navigation_blocked then
                        menu.waiting_for_direction_release = false
                    end
                end

                -- Directional navigation waits for a neutral direction state.
                -- Confirm and Cancel remain available during that wait.
                if not navigation_blocked
                    and is_menu_up_pressed(ctrl, owner) then

                    menu.selected = menu.selected - 1

                    if menu.selected < 1 then
                        menu.selected = #menu.options
                    end

                    refresh_body(menu)

                elseif not navigation_blocked
                    and is_menu_down_pressed(ctrl, owner) then

                    menu.selected = menu.selected + 1

                    if menu.selected > #menu.options then
                        menu.selected = 1
                    end

                    refresh_body(menu)

                elseif ctrl:is_action_pressed("Cancel", owner) then
                    -- The Cancel button activates the visible Cancel row directly.
                    -- Keep the same zero-based response contract as Confirm.
                    local cancel_index = menu.cancel_index

                    if cancel_index then
                        cleanup(player_id, menu, cancel_index - 1)
                    end

                elseif ctrl:is_action_pressed("Confirm", owner) then
                    -- Preserve the zero-based response expected by instance.lua.
                    cleanup(player_id, menu, menu.selected - 1)
                end
                end -- managed input is current
            end
        end
    end
end)

function OptionMenu.select(player_id, options, title)
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
            menu.header_panel=nil
            menu.body_panel=nil
            menu.resolve(nil)
        end)
        control:guard_input(0,MENU_ACTIONS)
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

            -- This additional neutral check protects against a held diagonal
            -- changing into a cardinal action without the player's remaining
            -- direction being released.
            menu.waiting_for_direction_release =
                ctrl:get_active_direction(token) ~= nil

            menu.active = true
        end)
    end)
end

return OptionMenu
