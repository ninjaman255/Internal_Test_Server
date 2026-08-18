-- scripts/net-games/menuAPI/main.lua
-- Reusable BN-style menu layer for net-games.
--
-- This is a creator-side rewrite inspired by the production MenuAPI used by
-- shadis_hp. It intentionally depends only on net-games/Displayer/Input and
-- does not contain pet, inventory, LMenu, or server-specific business logic.

require("scripts/net-games/main")

local Displayer = require("scripts/displayer/displayer")
local Input = require("scripts/input/input")
local UISafe = require("scripts/net-games/ui-safe")

local MenuAPI = {}
_G.MenuAPI = MenuAPI

local cfg = {
    open_sfx   = "/server/assets/net-games/sfx/screen_open.ogg",
    move_sfx   = "/server/assets/net-games/sfx/cursor_move.ogg",
    choose_sfx = "/server/assets/net-games/sfx/choose.ogg",
    cancel_sfx = "/server/assets/net-games/sfx/cancel.ogg",

    title_tint = { r = 18, g = 42, b = 100, color_mode = 2 },
    row_tint   = { r = 95, g = 100, b = 108, color_mode = 2 },
    right_tint = { r = 95, g = 100, b = 108, color_mode = 2 },
    disabled_tint = { r = 110, g = 110, b = 110, color_mode = 0, opacity = 150 },

    lock_input_by_default = true,
    asset_root = "/server/assets/ui/menuAPI/",
}
MenuAPI.config = cfg

local function tint_copy(src)
    local out = {}
    for k, v in pairs(src or {}) do out[k] = v end
    return out
end

MenuAPI.tint_palettes = {
    default = { title_tint = tint_copy(cfg.title_tint), row_tint = tint_copy(cfg.row_tint), right_tint = tint_copy(cfg.right_tint) },
    red = { title_tint = {r=120,g=20,b=24,color_mode=2}, row_tint={r=128,g=27,b=27,color_mode=2}, right_tint={r=120,g=50,b=50,color_mode=2} },
    blue = { title_tint = {r=18,g=42,b=100,color_mode=2}, row_tint={r=70,g=90,b=125,color_mode=2}, right_tint={r=65,g=85,b=120,color_mode=2} },
    green = { title_tint = {r=20,g=95,b=55,color_mode=2}, row_tint={r=65,g=105,b=75,color_mode=2}, right_tint={r=55,g=115,b=70,color_mode=2} },
    gold = { title_tint = {r=145,g=95,b=20,color_mode=2}, row_tint={r=115,g=95,b=55,color_mode=2}, right_tint={r=135,g=100,b=35,color_mode=2} },
    purple = { title_tint = {r=95,g=40,b=125,color_mode=2}, row_tint={r=95,g=80,b=115,color_mode=2}, right_tint={r=105,g=75,b=125,color_mode=2} },
    gray = { title_tint = {r=55,g=60,b=70,color_mode=2}, row_tint={r=95,g=100,b=108,color_mode=2}, right_tint={r=95,g=100,b=108,color_mode=2} },
}

function MenuAPI.get_palette(name)
    return MenuAPI.tint_palettes[tostring(name or "default"):lower()] or MenuAPI.tint_palettes.default
end

local MENU_TYPES = {
    [1] = {
        name = "scroll_list",
        selectable = true,
        vertical = true,
        layout = {
            texture = cfg.asset_root .. "menu1.png", x = 49, y = 17, z = 220, scale = 2,
            title_x = 17, title_y = 1, title_font = "THICK", title_scale = 1.5,
            row_x = 13, row_y = 16, row_font = "THICK", row_scale = 1.5, row_advance = 13,
            right_x = 103, right_font = "THICK", right_scale = 1.5,
            visible_rows = 8,
            cursor_texture = cfg.asset_root .. "cursor.png", cursor_x = 1, cursor_y_offset = -2, cursor_scale = 2,
            scroll_texture = cfg.asset_root .. "scroll.png", scroll_x = 131, scroll_top_y = 11, scroll_bottom_y = 106, scroll_h = 13, scroll_scale = 2,
        },
    },
    [2] = {
        name = "info_window",
        selectable = false,
        vertical = false,
        layout = {
            texture = cfg.asset_root .. "menu2.png", x = 49, y = 17, z = 220, scale = 2,
            title_x = 17, title_y = 1, title_font = "THICK", title_scale = 1.5,
            row_x = 13, row_y = 16, row_font = "THICK", row_scale = 1.5, row_advance = 13,
            visible_rows = 4,
        },
    },
    [3] = {
        name = "compact_menu",
        selectable = true,
        vertical = true,
        layout = {
            texture = cfg.asset_root .. "menu2.png", x = 49, y = 17, z = 220, scale = 2,
            title_x = 17, title_y = 1, title_font = "THICK", title_scale = 1.5,
            row_x = 13, row_y = 16, row_font = "THICK", row_scale = 1.5, row_advance = 13,
            visible_rows = 4,
            cursor_texture = cfg.asset_root .. "cursor.png", cursor_x = 1, cursor_y_offset = -2, cursor_scale = 2,
        },
    },
    [4] = {
        name = "confirm_prompt",
        selectable = true,
        horizontal = true,
        layout = {
            texture = cfg.asset_root .. "menu2.png", x = 49, y = 17, z = 220, scale = 2,
            title_x = 17, title_y = 1, title_font = "THICK", title_scale = 1.5,
            line_x = 13, line_y = 16, line_font = "THICK", line_scale = 1.5, line_advance = 13,
            choice_y = 55, yes_x = 25, no_x = 82, choice_scale = 1.5,
        },
    },
    [5] = {
        name = "profile_list",
        selectable = true,
        vertical = true,
        layout = {
            profile_texture = cfg.asset_root .. "menu3.png", profile_x = 144, profile_y = 20, profile_z = 220, profile_scale = 2,
            mug_x = 4, mug_y = 13, mug_scale = 1,
            profile_title_x = 17, profile_title_y = 2, profile_title_font = "THICK_BLACK", profile_title_scale = 1.8,
            profile_text_x = 40, profile_text_y = 24, profile_text_advance = 10, profile_font = "THICK", profile_text_scale = 1.5,
            texture = cfg.asset_root .. "menu1.png", x = 2, y = 20, z = 220, scale = 2,
            title_x = 17, title_y = 1, title_font = "THICK", title_scale = 1.5,
            row_x = 13, row_y = 16, row_font = "THICK", row_scale = 1.5, row_advance = 13,
            right_x = 96, right_font = "THICK", right_scale = 1.5,
            visible_rows = 8,
            cursor_texture = cfg.asset_root .. "cursor.png", cursor_x = 1, cursor_y_offset = -2, cursor_scale = 2,
            scroll_texture = cfg.asset_root .. "scroll.png", scroll_x = 131, scroll_top_y = 11, scroll_bottom_y = 106, scroll_h = 13, scroll_scale = 2,
        },
    },
}
MenuAPI.menu_types = MENU_TYPES

local stacks = {}
local next_id = 0

local function copy_table(src)
    local out = {}
    for k, v in pairs(src or {}) do
        if type(v) == "table" then out[k] = copy_table(v) else out[k] = v end
    end
    return out
end

local function merge(dst, src)
    for k, v in pairs(src or {}) do
        if type(v) == "table" and type(dst[k]) == "table" then merge(dst[k], v)
        else dst[k] = v end
    end
    return dst
end

local function resolve_type(value)
    if type(value) == "string" then
        local wanted = value:lower()
        for id, def in pairs(MENU_TYPES) do if def.name == wanted then return id end end
    end
    local id = math.floor(tonumber(value) or 1)
    return MENU_TYPES[id] and id or 1
end

local function stack_for(player_id, create)
    if create then stacks[player_id] = stacks[player_id] or {} end
    return stacks[player_id]
end

local function active(player_id)
    local stack = stacks[player_id]
    return stack and stack[#stack] or nil
end

local function set_input_locked(player_id, locked)
    if locked and Net.lock_player_input then pcall(Net.lock_player_input, Net, player_id)
    elseif (not locked) and Net.unlock_player_input then pcall(Net.unlock_player_input, Net, player_id) end
end

local function play_sfx(player_id, path)
    if not path or path == "" or not UISafe.safe_provide(player_id, path) then return end
    if Net.play_sound_for_player then pcall(Net.play_sound_for_player, player_id, path) end
end

local function normalize_rows(rows)
    local out = {}
    for i, row in ipairs(rows or {}) do
        if type(row) == "table" then
            local copy = copy_table(row)
            copy.id = copy.id or tostring(i)
            out[#out + 1] = copy
        else
            out[#out + 1] = { id = tostring(i), text = tostring(row) }
        end
    end
    return out
end

local function row_selectable(row)
    return type(row) ~= "table" or (row.selectable ~= false and row.enabled ~= false)
end

local function first_selectable(rows)
    for i, row in ipairs(rows or {}) do if row_selectable(row) then return i end end
    return #rows > 0 and 1 or 0
end

local function next_selectable(rows, start, direction)
    if #rows == 0 then return 0 end
    local i = math.max(1, math.min(#rows, start or 1))
    for _ = 1, #rows do
        i = i + direction
        if i < 1 then i = #rows elseif i > #rows then i = 1 end
        if row_selectable(rows[i]) then return i end
    end
    return start
end

local function ensure_visible(st)
    local total = #st.rows
    local visible = st.layout.visible_rows or 4
    if total == 0 then st.cursor, st.top_index = 0, 1; return end
    st.cursor = math.max(1, math.min(total, st.cursor))
    local max_top = math.max(1, total - visible + 1)
    st.top_index = math.max(1, math.min(max_top, st.top_index or 1))
    if st.cursor < st.top_index then st.top_index = st.cursor
    elseif st.cursor > st.top_index + visible - 1 then st.top_index = st.cursor - visible + 1 end
end

local function sprite_key(st, key) return st.prefix .. "_" .. key end
local function text_key(st, key) return st.prefix .. "_text_" .. key end

local function draw_text(st, key, text, x, y, options)
    local id = text_key(st, key)
    Displayer.Text.removeStatic(st.player_id, id)
    local opts = options or {}
    return Displayer.Text.drawStatic(st.player_id, id, tostring(text or ""), x, y, opts)
end

local function erase_text(st, key)
    Displayer.Text.removeStatic(st.player_id, text_key(st, key))
end

local function tint_options(tint, extra)
    tint = tint or {}
    local opts = {
        font = "THICK", scale = 1.5, z = 225,
        r = tint.r or 255, g = tint.g or 255, b = tint.b or 255,
        opacity = tint.opacity or 255, a = tint.a or 255,
        color_mode = tint.color_mode or 0,
    }
    for k, v in pairs(extra or {}) do opts[k] = v end
    return opts
end

local function draw_background(st)
    local L = st.layout
    UISafe.draw(st.player_id, sprite_key(st, "bg"), L.texture, {
        anim_path = L.anim, anim_state = L.anim_state,
        x = L.x, y = L.y, z = L.z, scale = L.scale,
        r = st.bg_tint and st.bg_tint.r or 255,
        g = st.bg_tint and st.bg_tint.g or 255,
        b = st.bg_tint and st.bg_tint.b or 255,
        opacity = st.bg_tint and st.bg_tint.opacity or 255,
        color_mode = st.bg_tint and st.bg_tint.color_mode or 0,
    })
end

local function draw_title(st)
    local L = st.layout
    draw_text(st, "title", st.title or "Menu", L.x + (L.title_x or 0), L.y + (L.title_y or 0),
        tint_options(st.title_tint, { font=L.title_font, scale=L.title_scale, z=(L.z or 220)+5 }))
end

local function clear_visible_rows(st)
    local visible = st.layout.visible_rows or 4
    for i = 1, visible do
        erase_text(st, "row_" .. i)
        erase_text(st, "right_" .. i)
        UISafe.erase(st.player_id, sprite_key(st, "row_icon_" .. i))
    end
end

local function draw_rows(st)
    local L = st.layout
    clear_visible_rows(st)
    local visible = L.visible_rows or 4
    for slot = 1, visible do
        local index = (st.top_index or 1) + slot - 1
        local row = st.rows[index]
        if row then
            local y = L.y + (L.row_y or 0) + (slot - 1) * (L.row_advance or 13)
            local text_x = L.x + (row.text_x or L.row_x or 0)
            if row.icon_texture then
                UISafe.draw(st.player_id, sprite_key(st, "row_icon_" .. slot), row.icon_texture, {
                    anim_path = row.icon_anim, anim_state = row.icon_state,
                    x = L.x + (row.icon_x or L.row_icon_x or L.row_x or 0),
                    y = y + (row.icon_y_offset or L.row_icon_y_offset or 0),
                    z = row.icon_z or ((L.z or 220) + 7),
                    scale = row.icon_scale or L.row_icon_scale or 1,
                    r = row.icon_tint and row.icon_tint.r or 255,
                    g = row.icon_tint and row.icon_tint.g or 255,
                    b = row.icon_tint and row.icon_tint.b or 255,
                    opacity = row.icon_tint and row.icon_tint.opacity or 255,
                    color_mode = row.icon_tint and row.icon_tint.color_mode or 0,
                })
                text_x = L.x + (row.text_x or L.row_icon_text_x or L.row_x or 0)
            end

            local tint = row.tint or (row_selectable(row) and st.row_tint or cfg.disabled_tint)
            draw_text(st, "row_" .. slot, row.text or row.label or row.name or row.id or "", text_x, y,
                tint_options(tint, { font=row.font or L.row_font, scale=row.scale or L.row_scale, z=row.z or ((L.z or 220)+5) }))

            local right = row.right
            if right == nil then right = row.value end
            if right == nil then right = row.count end
            if right ~= nil and L.right_x then
                draw_text(st, "right_" .. slot, tostring(right), L.x + L.right_x, y,
                    tint_options(row.right_tint or st.right_tint, { font=row.right_font or L.right_font, scale=row.right_scale or L.right_scale, z=(L.z or 220)+5 }))
            end
        end
    end
end

local function draw_cursor(st)
    local L = st.layout
    if not L.cursor_texture or st.cursor <= 0 then
        UISafe.erase(st.player_id, sprite_key(st, "cursor")); return
    end
    local slot = st.cursor - st.top_index + 1
    if slot < 1 or slot > (L.visible_rows or 4) then return end
    UISafe.draw(st.player_id, sprite_key(st, "cursor"), L.cursor_texture, {
        anim_path = L.cursor_anim, anim_state = L.cursor_state,
        x = L.x + (L.cursor_x or 0),
        y = L.y + (L.row_y or 0) + (slot - 1) * (L.row_advance or 13) + (L.cursor_y_offset or 0),
        z = (L.z or 220) + 6, scale = L.cursor_scale or 2,
    })
end

local function draw_scroll(st)
    local L = st.layout
    if not L.scroll_texture or #st.rows <= (L.visible_rows or 4) then
        UISafe.erase(st.player_id, sprite_key(st, "scroll")); return
    end
    local visible = L.visible_rows or 4
    local max_top = math.max(1, #st.rows - visible + 1)
    local t = (st.top_index - 1) / math.max(1, max_top - 1)
    local top = L.scroll_top_y or 0
    local bottom = math.max(top, (L.scroll_bottom_y or top) - (L.scroll_h or 0))
    UISafe.draw(st.player_id, sprite_key(st, "scroll"), L.scroll_texture, {
        anim_path=L.scroll_anim, anim_state=L.scroll_state,
        x=L.x+(L.scroll_x or 0), y=L.y+top+(bottom-top)*t,
        z=(L.z or 220)+6, scale=L.scroll_scale or 2,
    })
end

local function draw_profile(st)
    local L, profile = st.layout, st.profile or {}
    if not L.profile_texture then return end
    UISafe.draw(st.player_id, sprite_key(st, "profile_bg"), L.profile_texture, {
        anim_path=L.profile_anim, anim_state=L.profile_state,
        x=L.profile_x, y=L.profile_y, z=L.profile_z or L.z, scale=L.profile_scale or 2,
    })

    if profile.mug_texture then
        UISafe.draw(st.player_id, sprite_key(st, "profile_mug"), profile.mug_texture, {
            anim_path=profile.mug_anim, anim_state=profile.mug_state or "UI",
            x=(L.profile_x or 0)+(profile.mug_x or L.mug_x or 0),
            y=(L.profile_y or 0)+(profile.mug_y or L.mug_y or 0),
            z=(L.profile_z or L.z or 220)+7,
            sx=profile.mug_sx or profile.mug_scale or L.mug_scale or 1,
            sy=profile.mug_sy or profile.mug_scale or L.mug_scale or 1,
        })
    else
        UISafe.erase(st.player_id, sprite_key(st, "profile_mug"))
    end

    erase_text(st, "profile_title")
    for i=1,4 do erase_text(st, "profile_line_"..i) end
    if profile.title then
        draw_text(st, "profile_title", profile.title,
            (L.profile_x or 0)+(L.profile_title_x or 0), (L.profile_y or 0)+(L.profile_title_y or 0),
            tint_options(profile.title_tint or st.title_tint, {font=profile.title_font or L.profile_title_font, scale=profile.title_scale or L.profile_title_scale, z=(L.profile_z or L.z or 220)+9}))
    end
    for i, line in ipairs(profile.lines or {}) do
        if i > 4 then break end
        draw_text(st, "profile_line_"..i, tostring(line),
            (L.profile_x or 0)+(profile.text_x or L.profile_text_x or 0),
            (L.profile_y or 0)+(profile.text_y or L.profile_text_y or 0)+(i-1)*(profile.text_advance or L.profile_text_advance or 10),
            tint_options((profile.line_tints and profile.line_tints[i]) or profile.tint or st.row_tint,
                {font=profile.font or L.profile_font, scale=profile.text_scale or L.profile_text_scale, z=(L.profile_z or L.z or 220)+8}))
    end
end

local function draw_confirm(st)
    local L = st.layout
    draw_background(st); draw_title(st)
    for i = 1, 3 do
        erase_text(st, "line_"..i)
        local line = st.lines and st.lines[i]
        if line then
            draw_text(st, "line_"..i, line, L.x+(L.line_x or 0), L.y+(L.line_y or 0)+(i-1)*(L.line_advance or 13),
                tint_options(st.row_tint, {font=L.line_font, scale=L.line_scale, z=(L.z or 220)+5}))
        end
    end
    local yes_tint = st.choice == 1 and st.title_tint or st.row_tint
    local no_tint = st.choice == 2 and st.title_tint or st.row_tint
    draw_text(st, "choice_yes", (st.choice==1 and "> " or "  ") .. (st.yes_text or "Yes"), L.x+(L.yes_x or 0), L.y+(L.choice_y or 0),
        tint_options(yes_tint, {font=L.line_font, scale=L.choice_scale, z=(L.z or 220)+5}))
    draw_text(st, "choice_no", (st.choice==2 and "> " or "  ") .. (st.no_text or "No"), L.x+(L.no_x or 0), L.y+(L.choice_y or 0),
        tint_options(no_tint, {font=L.line_font, scale=L.choice_scale, z=(L.z or 220)+5}))
end

local function full_draw(st)
    if st.type == 4 then draw_confirm(st); return end
    if st.type == 5 then draw_profile(st) end
    draw_background(st); draw_title(st); ensure_visible(st); draw_rows(st); draw_cursor(st); draw_scroll(st)
end

local function cleanup(st)
    if not st then return end
    local visible = st.layout.visible_rows or 8
    for _, key in ipairs({"bg","cursor","scroll","profile_bg","profile_mug"}) do UISafe.erase(st.player_id, sprite_key(st,key)) end
    for i=1,visible do UISafe.erase(st.player_id, sprite_key(st,"row_icon_"..i)) end
    for _, key in ipairs({"title","profile_title","choice_yes","choice_no","line_1","line_2","line_3"}) do erase_text(st,key) end
    for i=1,visible do erase_text(st,"row_"..i); erase_text(st,"right_"..i) end
    for i=1,4 do erase_text(st,"profile_line_"..i) end
end

local function move_selection(st, direction)
    if st.type == 4 then
        st.choice = st.choice == 1 and 2 or 1
        draw_confirm(st); play_sfx(st.player_id, cfg.move_sfx); return true
    end
    if #st.rows == 0 then return false end
    local old_cursor, old_top = st.cursor, st.top_index
    st.cursor = next_selectable(st.rows, st.cursor, direction)
    ensure_visible(st)
    if st.cursor == old_cursor then return false end
    play_sfx(st.player_id, cfg.move_sfx)
    if st.top_index ~= old_top then
        draw_rows(st); draw_scroll(st); draw_cursor(st)
    else
        -- Production optimization: moving within the visible window updates only
        -- the cursor, not the background/title/rows.
        draw_cursor(st)
    end
    if st.on_move then pcall(st.on_move, st.cursor, st.rows[st.cursor], st) end
    return true
end

local function confirm(st)
    if st.type == 4 then
        local value = st.choice == 1
        play_sfx(st.player_id, cfg.choose_sfx)
        if st.on_result then pcall(st.on_result, value, st) end
        if st.close_on_select ~= false then MenuAPI.close(st.player_id, {reason="select"}) end
        return
    end
    local row = st.rows[st.cursor]
    if not row or not row_selectable(row) then return end
    play_sfx(st.player_id, cfg.choose_sfx)
    if row.on_select then pcall(row.on_select, row, st.cursor, st) end
    if st.on_select then pcall(st.on_select, row, st.cursor, st) end
    if st.close_on_select == true then MenuAPI.close(st.player_id, {reason="select"}) end
end

local function handle_cancel(st)
    if st.on_cancel then
        local ok, handled = pcall(st.on_cancel, st)
        if ok and handled == true then return end
    end
    play_sfx(st.player_id, cfg.cancel_sfx)
    MenuAPI.close(st.player_id, { reason = "cancel" })
end

function MenuAPI.open(player_id, spec)
    spec = spec or {}
    local type_id = resolve_type(spec.type or spec.menu_type)
    local def = MENU_TYPES[type_id]
    local layout = merge(copy_table(def.layout), spec.layout or {})
    -- Common direct layout overrides are convenient for small callers.
    for _, key in ipairs({"texture","anim","anim_state","x","y","z","scale","visible_rows"}) do
        if spec[key] ~= nil then layout[key] = spec[key] end
    end

    next_id = next_id + 1
    local palette = MenuAPI.get_palette(spec.palette)
    local st = {
        player_id = player_id,
        type = type_id,
        type_name = def.name,
        prefix = "menuapi_" .. tostring(player_id) .. "_" .. tostring(next_id),
        layout = layout,
        title = spec.title or "Menu",
        rows = normalize_rows(spec.rows),
        cursor = 1,
        top_index = 1,
        profile = copy_table(spec.profile),
        lines = copy_table(spec.lines),
        choice = (tonumber(spec.default_selection) == 2 or tostring(spec.default_selection):lower() == "no") and 2 or 1,
        yes_text = spec.yes_text,
        no_text = spec.no_text,
        title_tint = copy_table(spec.title_tint or palette.title_tint),
        row_tint = copy_table(spec.row_tint or palette.row_tint),
        right_tint = copy_table(spec.right_tint or palette.right_tint),
        bg_tint = copy_table(spec.bg_tint),
        on_select = spec.on_select,
        on_move = spec.on_move,
        on_cancel = spec.on_cancel,
        on_result = spec.on_result,
        on_close = spec.on_close,
        close_on_select = spec.close_on_select,
        lock_input = spec.lock_input ~= false and cfg.lock_input_by_default,
    }
    st.cursor = tonumber(spec.cursor) or first_selectable(st.rows)
    ensure_visible(st)

    local stack = stack_for(player_id, true)
    local was_empty = #stack == 0
    stack[#stack + 1] = st
    if was_empty and st.lock_input then set_input_locked(player_id, true) end

    -- Ensure font assets exist even if MenuAPI was required after player_join.
    pcall(Displayer.Font.allocateAllFontsForPlayer, player_id)
    Input.consume(player_id)
    Input.swallow(player_id, 0.10)
    Input.require_release(player_id, {"confirm","cancel"})
    full_draw(st)
    play_sfx(player_id, cfg.open_sfx)
    return st
end

MenuAPI.push = MenuAPI.open

function MenuAPI.close(player_id, opts)
    opts = opts or {}
    local stack = stack_for(player_id, false)
    if not stack or #stack == 0 then return false end
    local st = table.remove(stack)
    cleanup(st)
    if st.on_close then pcall(st.on_close, opts.reason, st) end

    if #stack == 0 then
        stacks[player_id] = nil
        if st.lock_input and opts.keep_locked ~= true then set_input_locked(player_id, false) end
    else
        -- Returning to the previous menu does not require a full redraw because it
        -- remained rendered beneath the pushed menu; refresh only its cursor.
        draw_cursor(stack[#stack])
    end
    Input.consume(player_id)
    Input.swallow(player_id, 0.08)
    Input.require_release(player_id, {"confirm","cancel"})
    return true
end

function MenuAPI.close_all(player_id, opts)
    opts = opts or {}
    local stack = stack_for(player_id, false)
    if not stack then return end
    for i = #stack, 1, -1 do cleanup(stack[i]) end
    stacks[player_id] = nil
    if opts.keep_locked ~= true then set_input_locked(player_id, false) end
    Input.consume(player_id)
    Input.require_release(player_id, {"confirm","cancel"})
end

function MenuAPI.is_open(player_id) return active(player_id) ~= nil end
function MenuAPI.get_state(player_id) return active(player_id) end
function MenuAPI.get_stack(player_id) return stack_for(player_id, false) end

function MenuAPI.refresh(player_id)
    local st = active(player_id)
    if not st then return false end
    full_draw(st)
    return true
end

function MenuAPI.set_rows(player_id, rows, preserve_selection)
    local st = active(player_id)
    if not st then return false end
    local old_id = st.rows[st.cursor] and st.rows[st.cursor].id
    st.rows = normalize_rows(rows)
    st.cursor = first_selectable(st.rows)
    if preserve_selection and old_id then
        for i, row in ipairs(st.rows) do if row.id == old_id and row_selectable(row) then st.cursor=i; break end end
    end
    st.top_index = 1; ensure_visible(st)
    draw_rows(st); draw_cursor(st); draw_scroll(st)
    return true
end

function MenuAPI.set_profile(player_id, profile)
    local st = active(player_id)
    if not st or st.type ~= 5 then return false end
    st.profile = copy_table(profile)
    draw_profile(st)
    return true
end

function MenuAPI.set_title(player_id, title)
    local st = active(player_id); if not st then return false end
    st.title = tostring(title or ""); draw_title(st); return true
end

function MenuAPI.handle_cancel(player_id)
    local st = active(player_id); if not st then return false end
    handle_cancel(st); return true
end

-- One global tick polls the canonical input system; MenuAPI never installs a
-- second virtual_input listener and never uses os.clock for repeat timing.
Net:on("tick", function(_event)
    for player_id, stack in pairs(stacks) do
        local st = stack[#stack]
        if st then
            if st.type == 4 then
                if Input.pop(player_id, "left") or Input.pop(player_id, "right") then move_selection(st, 1)
                elseif Input.pop(player_id, "confirm") then confirm(st)
                elseif Input.pop(player_id, "cancel") then handle_cancel(st) end
            elseif MENU_TYPES[st.type].selectable then
                if Input.pop(player_id, "up") or Input.pop_repeated(player_id, "up") then move_selection(st, -1)
                elseif Input.pop(player_id, "down") or Input.pop_repeated(player_id, "down") then move_selection(st, 1)
                elseif Input.pop(player_id, "confirm") then confirm(st)
                elseif Input.pop(player_id, "cancel") then handle_cancel(st) end
            elseif Input.pop(player_id, "cancel") then
                handle_cancel(st)
            end
        end
    end
end)

Net:on("player_disconnect", function(event)
    if event and event.player_id then
        local stack = stacks[event.player_id]
        if stack then for i=#stack,1,-1 do cleanup(stack[i]) end end
        stacks[event.player_id] = nil
    end
end)

return MenuAPI
