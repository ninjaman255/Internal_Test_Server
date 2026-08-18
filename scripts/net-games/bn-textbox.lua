-- bn_textbox.lua
-- Simple BN-style text box with typewriter, optional nameplate, mugshot, and backdrop.
-- Uses the existing Dialogue.start system for reliable behavior and input handling.

local Dialogue = require("scripts/net-games/dialogue/dialogue")

local BNTextbox = {}

-- Small helper to copy tables
local function shallow_copy(t)
    local o = {}
    if t then
        for k, v in pairs(t) do
            o[k] = v
        end
    end
    return o
end

-- Build the UI configuration table expected by Dialogue.start
local function build_ui(player_id, opts)
    local ui = {
        box_id = opts.box_id or ("bn_textbox_" .. player_id .. "_" .. tostring(os.time())),
        font = opts.font or "THIN_BLACK",
        scale = opts.scale or 2.0,
        z = opts.z or 100,
        typing_speed = opts.typing_speed or 30,
        type_sfx_path = opts.type_sfx_path or "/server/assets/net-games/sfx/text.ogg",
        type_sfx_min_dt = opts.type_sfx_min_dt or 0.05,
    }

    -- Backdrop (text box frame)
    local backdrop = {
        render_offset_x = opts.backdrop_render_offset_x or 3,
        render_offset_y = opts.backdrop_render_offset_y or 46,
        style = "textbox_panel",                      -- default; overridden if frame_tint is given
        open_seconds = opts.backdrop_open_seconds or 0.20,
        close_seconds = opts.backdrop_close_seconds or 0.25,
        x = opts.backdrop_x or 1,
        y = opts.backdrop_y or 209,
        width = opts.backdrop_width or 478,
        height = opts.backdrop_height or 104,
        padding_x = opts.backdrop_padding_x or 16,
        padding_y = opts.backdrop_padding_y or 4,
        max_lines = opts.backdrop_max_lines or 3,
        indicator = {
            enabled = true,
            width = 2,
            height = 2,
            offset_x = 24,
            offset_y = 26,
        },
    }

    -- Apply frame tint if provided
    if opts.frame_tint then
        backdrop.style = "textbox_panel_frame_tint"
        backdrop.r = opts.frame_tint.r or 255
        backdrop.g = opts.frame_tint.g or 255
        backdrop.b = opts.frame_tint.b or 255
        backdrop.a = opts.frame_tint.a or 255
        backdrop.color_mode = opts.frame_tint.color_mode or 2
    end

    ui.backdrop = backdrop

    -- Nameplate
    if opts.nameplate ~= false then
        local name = opts.name or opts.nameplate_text or "???"
        ui.nameplate = {
            text = name,
            anchor = opts.nameplate_anchor or "above",
            align = opts.nameplate_align or "left",
            gap_x = opts.nameplate_gap_x or 6,
            gap_y = opts.nameplate_gap_y or 59,
            dur = opts.nameplate_dur or 0.20,
            close_dur = opts.nameplate_close_dur or 0.20,
            bob_amp = opts.nameplate_bob_amp or 1.2,
            bob_speed = opts.nameplate_bob_speed or 2,
        }

        -- If a frame tint was applied, also tint the nameplate's frame overlay
        if opts.frame_tint then
            ui.nameplate.frame = {
                r = backdrop.r,
                g = backdrop.g,
                b = backdrop.b,
                a = backdrop.a,
                color_mode = backdrop.color_mode,
            }
        end

        -- Allow explicit override of nameplate frame (e.g., if you want a different tint)
        if opts.nameplate_frame then
            ui.nameplate.frame = opts.nameplate_frame
        end
    end

    -- Mugshot
    if opts.mugshot_texture then
        ui.mugshot = {
            enabled = true,
            texture_path = opts.mugshot_texture,
            anim_path = opts.mugshot_anim_path or "",
            talk_anim_state = opts.mugshot_talk_anim_state or "TALK",
            idle_anim_state = opts.mugshot_idle_anim_state or "IDLE",
            reserve_w = opts.mugshot_reserve_w or 40,
            reserve_h = opts.mugshot_reserve_h or 40,
            offset_x = opts.mugshot_offset_x or 6,
            offset_y = opts.mugshot_offset_y or -46,
            gap_px = opts.mugshot_gap_px or 6,
            sprite_id = opts.mugshot_sprite_id or 5300,
            z_bias = opts.mugshot_z_bias or 50,
        }
    end

    return ui
end

--- Show a BN‑style text box.
---
---@param player_id string
---@param text string|table   -- single string or array of lines (strings)
---@param opts table          -- optional overrides (see documentation below)
---@return table              -- the dialogue object (from Dialogue.start)
function BNTextbox.show(player_id, text, opts)
    opts = opts or {}
    local ui = build_ui(player_id, opts)
    local lines = type(text) == "table" and text or { text }

    return Dialogue.start(player_id, lines, {
        page_advance = opts.page_advance or "wait_for_confirm",
        confirm_during_typing = opts.confirm_during_typing ~= false,
        ui = ui,
        on_finish = opts.on_finish,
        reuse_existing_box = opts.reuse_existing_box or false,
        from_prompt = opts.from_prompt or false,
    })
end

return BNTextbox