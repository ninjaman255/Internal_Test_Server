-- points_gauge.lua
--
-- Screen HUD for a liberation's order points. Composed of three 3-slice
-- sprites drawn through Displayer.SlicedSprite:
--
--   * base-guage-3slice  -- the empty bar behind everything (widest)
--   * points-3slice      -- pips drawn *inside* the base gauge
--   * point-total-3slice -- centered badge showing "value/max" as text
--
-- BADGE PLACEMENT: the badge is drawn below the base gauge on the Y axis,
-- horizontally centered on it, and its top edge overlaps the gauge's bottom
-- edge by LAYOUT.badge_overlap px. The z-indices (base=200, badge=202) only
-- control draw order so the badge appears on top where they overlap; the
-- vertical overlap itself is purely a Y-position calculation.
--
-- COORDINATE SPACES:
--   * SlicedSprite.draw3 operates in 480x320 raw-pixel space.
--   * Displayer.Text.drawStatic operates in 240x160 text space.
-- The badge rectangle is drawn with draw3 at 480-space; its text is placed
-- at 240-space by halving the badge center and offsetting by half the
-- measured 240-space text extents.
--
-- SLICED-SPRITE VALIDATION: this displayer's sliced-sprite implementation
-- requires every strip part of a horizontal 3-slice to have the SAME native
-- frame height. If LEFT_h, CENTER_h, and RIGHT_h are not equal, draw3
-- returns nil,"[SlicedSprite] all strip parts must have the same native
-- height" and the sprite does not render. The base gauge is well-formed
-- (16/16/16), which is why it works; the badge and points animations must
-- be edited at the asset level so their three parts match too. The startup
-- diagnostic below names the exact mismatch.
--
-- IMPORTANT: Displayer draws per player. The gauge assets MUST be delivered
-- via Net.provide_asset_for_player before :show() is called. See
-- Preloader.provide_gauge_assets_to_player.

local ezlogger = require("scripts/ezlibs-scripts/ezlogger")
local log = ezlogger.get("nebulous-liberations")

local Displayer = require("scripts/displayer/displayer")
local TextLayout = require("scripts/displayer/text-layout")

local PointsGauge = {}
PointsGauge.__index = PointsGauge

local ASSET_ROOT = "/server/assets/net-games/meters/liberation-order-points"

-- Sprite-space (480x320) layout.
local LAYOUT = {
    screen_w = 480,
    screen_h = 320,
    gauge_y = 12,
    gauge_h = 24,
    segment_w = 20,

    gauge_inner_padding_x = 12,
    gauge_inner_padding_y = 4,

    badge_w = 80,
    badge_h = 24,
    -- Px the badge's top overlaps the gauge's bottom. The badge sits below
    -- the gauge; increasing this value pulls the badge upward (more overlap)
    -- and decreasing it separates them (0 = badge directly below, no overlap).
    badge_overlap = 6,

    z_base = 200,
    z_fill = 201,
    z_badge = 202,
    z_text = 203,

    text_font = "THICK",
    text_scale = 1.0,
    text_color = { r = 255, g = 255, b = 255, a = 255 },
}

local FALLBACK_GLYPH_H_240 = 8

local animation_insights = nil
local function get_animation_insights()
    if animation_insights then return animation_insights end
    animation_insights = {}
    local boom_ok, Boom = pcall(require, "scripts/boom/main")
    if not boom_ok or type(Boom) ~= "table" or type(Boom.load) ~= "function" then
        return animation_insights
    end
    local specs = {
        { name = "base",   anim = ASSET_ROOT .. "/base-guage-3slice.animation" },
        { name = "points", anim = ASSET_ROOT .. "/points-3slice.animation" },
        { name = "badge",  anim = ASSET_ROOT .. "/point-total-3slice.animation" },
    }
    for _, spec in ipairs(specs) do
        local boom_path = spec.anim:gsub("^/server/", "")
        local load_ok, animation = pcall(Boom.load, boom_path)
        if load_ok and type(animation) == "table" then
            local insight = { loaded = true, states = {}, parts = {} }
            if animation.states then
                for state_name, state in pairs(animation.states) do
                    insight.states[state_name] = true
                    local frame = state.framelist and state.framelist[1]
                    if frame then
                        insight.parts[state_name] = {
                            w = tonumber(frame.w) or 0,
                            h = tonumber(frame.h) or 0,
                        }
                    end
                end
            end
            local left = insight.parts.LEFT or { w = 0, h = 0 }
            local center = insight.parts.CENTER or { w = 0, h = 0 }
            local right = insight.parts.RIGHT or { w = 0, h = 0 }
            insight.natural_width = left.w + center.w + right.w
            insight.natural_height = math.max(left.h, center.h, right.h)
            -- Key check: sliced-sprite.lua rejects draw3 when the three
            -- strip parts' native frame heights are not all equal.
            insight.heights_match =
                left.h > 0 and left.h == center.h and center.h == right.h
            animation_insights[spec.name] = insight
        else
            animation_insights[spec.name] = { loaded = false, error = tostring(animation) }
        end
    end
    return animation_insights
end

local styles = nil
local function get_styles()
    if styles then return styles end
    styles = {
        base = Displayer.Builder.sliceStyle3(
            ASSET_ROOT .. "/base-guage-3slice.png",
            ASSET_ROOT .. "/base-guage-3slice.animation"
        ),
        points = Displayer.Builder.sliceStyle3(
            ASSET_ROOT .. "/points-3slice.png",
            ASSET_ROOT .. "/points-3slice.animation"
        ),
        badge = Displayer.Builder.sliceStyle3(
            ASSET_ROOT .. "/point-total-3slice.png",
            ASSET_ROOT .. "/point-total-3slice.animation"
        ),
    }
    return styles
end

-- One-time startup diagnostic. Distinguishes three failure modes explicitly:
--   * animation file failed to load
--   * missing required state (LEFT / CENTER / RIGHT)
--   * mismatched strip heights (the draw3 rejection we hit here)
local diagnostic_done = false
local function run_startup_diagnostic()
    if diagnostic_done then return end
    diagnostic_done = true
    local insights = get_animation_insights()
    local required = { "LEFT", "CENTER", "RIGHT" }
    local specs = {
        { name = "base",   anim = ASSET_ROOT .. "/base-guage-3slice.animation" },
        { name = "points", anim = ASSET_ROOT .. "/points-3slice.animation" },
        { name = "badge",  anim = ASSET_ROOT .. "/point-total-3slice.animation" },
    }
    for _, spec in ipairs(specs) do
        local insight = insights[spec.name]
        if not insight or not insight.loaded then
            log:error_data("Gauge animation failed to load", {
                style = spec.name,
                anim_path = spec.anim,
                error = insight and insight.error or "unknown",
            })
        else
            local missing = {}
            local available = {}
            for name in pairs(insight.states) do
                available[#available + 1] = name
            end
            table.sort(available)
            for _, req in ipairs(required) do
                if not insight.states[req] then
                    missing[#missing + 1] = req
                end
            end
            local left = insight.parts.LEFT or {}
            local center = insight.parts.CENTER or {}
            local right = insight.parts.RIGHT or {}
            if #missing > 0 then
                log:error_data("Gauge animation is missing required states", {
                    style = spec.name,
                    anim_path = spec.anim,
                    missing_states = missing,
                    available_states = available,
                })
            elseif not insight.heights_match then
                -- Draw3 will reject any w/h for this style until the
                -- animation data is fixed: sliced-sprite validates that all
                -- three strip parts have identical native frame heights.
                log:error_data("Gauge animation has mismatched strip heights (draw3 will reject)", {
                    style = spec.name,
                    anim_path = spec.anim,
                    left_h = left.h,
                    center_h = center.h,
                    right_h = right.h,
                    fix = "Edit the .animation so LEFT, CENTER, and RIGHT frames all have the same height. "
                        .. "See how base-guage-3slice uses 16/16/16.",
                })
            else
                log:info_data("Gauge animation validated", {
                    style = spec.name,
                    anim_path = spec.anim,
                    left_w = left.w, left_h = left.h,
                    center_w = center.w, center_h = center.h,
                    right_w = right.w, right_h = right.h,
                    natural_width = insight.natural_width,
                    natural_height = insight.natural_height,
                    heights_match = true,
                })
            end
        end
    end
end

local function id_safe(value)
    return tostring(value):gsub("[^%w_%-]", "_")
end

local function measure_text_240(text, opts)
    local w, h = TextLayout.measure(text, opts)
    if type(w) == "table" then
        local size = w
        w = size.width or size.w or size[1]
        h = size.height or size.h or size[2]
    end
    w = tonumber(w)
    h = tonumber(h)
    if not w or w <= 0 then
        w = TextLayout.measureLine(text, opts) or 0
    end
    if not h or h <= 0 then
        h = FALLBACK_GLYPH_H_240 * (tonumber(opts and opts.scale) or 1)
    end
    return w, h
end

function PointsGauge:new(player_id, max_points)
    run_startup_diagnostic()
    local gauge = setmetatable({}, PointsGauge)
    gauge.player_id = player_id
    gauge.max_points = math.max(1, math.floor(tonumber(max_points) or 8))
    gauge.value = 0
    gauge.visible = false

    -- Cache the per-style usability flags once so we don't re-check on
    -- every redraw. `usable` is false when the animation is missing or
    -- when its strip heights are mismatched — in either case draw3 cannot
    -- succeed and we skip the futile call (with a one-time log).
    local insights = get_animation_insights()
    gauge.base_usable   = insights.base   and insights.base.loaded   and insights.base.heights_match
    gauge.points_usable = insights.points and insights.points.loaded and insights.points.heights_match
    gauge.badge_usable  = insights.badge  and insights.badge.loaded  and insights.badge.heights_match
    gauge._warned = {}

    gauge.gauge_w = gauge.max_points * LAYOUT.segment_w
    gauge.gauge_x = math.floor((LAYOUT.screen_w - gauge.gauge_w) / 2)

    local prefix = "nebulibs-op-" .. id_safe(player_id)
    gauge.base_lid = prefix .. "-base"
    gauge.badge_lid = prefix .. "-badge"
    gauge.text_tid = prefix .. "-text"
    gauge.fill_lids = {}
    for i = 1, gauge.max_points do
        gauge.fill_lids[i] = prefix .. "-fill-" .. tostring(i)
    end
    return gauge
end

-- One-time-per-tag warning helper so a broken asset warns once, not once
-- per redraw of every pip.
function PointsGauge:_warn_once(tag, message, extra)
    if self._warned[tag] then return end
    self._warned[tag] = true
    local payload = { tag = tag, player_id = self.player_id, message = message }
    for k, v in pairs(extra or {}) do payload[k] = v end
    log:warn_data("PointsGauge: skipping draw (see startup diagnostic)", payload)
end

local function safe_draw3(player_id, lid, x, y, w, h, style, opts, tag, gauge)
    local ok, a, b = pcall(Displayer.SlicedSprite.draw3, player_id, lid, x, y, w, h, style, opts)
    if not ok then
        if gauge then
            gauge:_warn_once(tag, "draw3 threw", { error = tostring(a), x = x, y = y, w = w, h = h })
        end
        return false
    end
    if a == nil and b ~= nil then
        if gauge then
            gauge:_warn_once(tag, "draw3 returned nil", { error = tostring(b), x = x, y = y, w = w, h = h })
        end
        return false
    end
    if a == false then
        if gauge then
            gauge:_warn_once(tag, "draw3 returned false", { error = b and tostring(b) or "no error", x = x, y = y, w = w, h = h })
        end
        return false
    end
    return true
end

function PointsGauge:_draw_base()
    if not self.base_usable then
        self:_warn_once("base", "base animation not usable (see startup diagnostic)")
        return
    end
    local s = get_styles()
    local insights = get_animation_insights()
    local natural_h = insights.base and insights.base.natural_height or 0
    local h = math.max(LAYOUT.gauge_h, natural_h)
    safe_draw3(
        self.player_id, self.base_lid,
        self.gauge_x, LAYOUT.gauge_y,
        self.gauge_w, h,
        s.base,
        { z = LAYOUT.z_base },
        "base", self
    )
end

function PointsGauge:_draw_fill()
    if not self.points_usable then
        self:_warn_once("fill", "points animation not usable (see startup diagnostic)")
        return
    end
    local s = get_styles()
    local inner_x = self.gauge_x + LAYOUT.gauge_inner_padding_x
    local inner_y = LAYOUT.gauge_y + LAYOUT.gauge_inner_padding_y
    local inner_h = LAYOUT.gauge_h - 2 * LAYOUT.gauge_inner_padding_y
    local inner_w = self.gauge_w - 2 * LAYOUT.gauge_inner_padding_x
    local pip_w = inner_w / self.max_points

    -- Respect the points animation's own natural size. If the pip width we
    -- want is below the animation's natural width, we'd have to shrink the
    -- center strip, which sliced-sprite also rejects — so widen the pip.
    local insights = get_animation_insights()
    local natural_pip_w = insights.points and insights.points.natural_width or 0
    local natural_pip_h = insights.points and insights.points.natural_height or 0
    if natural_pip_w > 0 and pip_w < natural_pip_w then
        pip_w = natural_pip_w
    end
    if natural_pip_h > 0 and inner_h < natural_pip_h then
        inner_h = natural_pip_h
    end

    for i = 1, self.max_points do
        if i <= self.value then
            local pip_x = math.floor(inner_x + (i - 1) * pip_w)
            safe_draw3(
                self.player_id, self.fill_lids[i],
                pip_x, inner_y,
                math.floor(pip_w), math.floor(inner_h),
                s.points,
                { z = LAYOUT.z_fill },
                "fill[" .. i .. "]", self
            )
        else
            Displayer.SlicedSprite.erase(self.player_id, self.fill_lids[i])
        end
    end
end

function PointsGauge:_draw_badge()
    local s = get_styles()
    local text = tostring(self.value) .. "/" .. tostring(self.max_points)
    local text_opts = { font = LAYOUT.text_font, scale = LAYOUT.text_scale }

    -- Clamp badge size up to the animation's natural dimensions. This avoids
    -- requesting a w/h smaller than what sliced-sprite can cut cleanly.
    local insights = get_animation_insights()
    local insight = insights.badge
    local badge_w = LAYOUT.badge_w
    local badge_h = LAYOUT.badge_h
    if insight and insight.loaded then
        if insight.natural_width > badge_w then badge_w = insight.natural_width end
        if insight.natural_height > badge_h then badge_h = insight.natural_height end
    end

    -- Badge sits below the gauge on Y, horizontally centered on it. Its top
    -- edge overlaps the gauge's bottom edge by badge_overlap px. The z-index
    -- (base=200, badge=202) only controls draw order so the badge sits on
    -- top where the two rectangles overlap.
    local badge_x = math.floor((LAYOUT.screen_w - badge_w) / 2)
    local badge_y = math.max(0, LAYOUT.gauge_y + LAYOUT.gauge_h - LAYOUT.badge_overlap)

    -- Attempt the frame draw only if the animation is well-formed. Skipping
    -- a guaranteed-fail call keeps the log clean; the text still draws below
    -- so the number stays visible while the .animation is being fixed.
    if self.badge_usable then
        safe_draw3(
            self.player_id, self.badge_lid,
            badge_x, badge_y, badge_w, badge_h,
            s.badge,
            { z = LAYOUT.z_badge },
            "badge", self
        )
    else
        self:_warn_once("badge", "badge animation not usable (see startup diagnostic)")
    end

    -- Text is drawn regardless of the frame's success. It is positioned at
    -- the intended badge center so once the animation is fixed, the number
    -- is already correctly nested inside the 3-slice.
    local text_w_240, text_h_240 = measure_text_240(text, text_opts)
    local badge_center_240_x = (badge_x + badge_w / 2) / 2
    local badge_center_240_y = (badge_y + badge_h / 2) / 2
    local text_x_240 = math.floor(badge_center_240_x - text_w_240 / 2)
    local text_y_240 = math.floor(badge_center_240_y - text_h_240 / 2)

    local tok, terr = pcall(
        Displayer.Text.drawStatic,
        self.player_id, self.text_tid, text,
        text_x_240, text_y_240,
        {
            font = LAYOUT.text_font, scale = LAYOUT.text_scale,
            z = LAYOUT.z_text,
            r = LAYOUT.text_color.r, g = LAYOUT.text_color.g,
            b = LAYOUT.text_color.b, a = LAYOUT.text_color.a,
            opacity = 255,
        }
    )
    if not tok then
        log:warn_data("PointsGauge:_draw_badge: drawStatic failed", {
            player_id = self.player_id,
            error = tostring(terr),
        })
    end
end

function PointsGauge:show()
    if self.visible then return end
    self.visible = true
    self:_draw_base()
    self:_draw_fill()
    self:_draw_badge()
    log:info_data("PointsGauge: shown", {
        player_id = self.player_id,
        value = self.value,
        max_points = self.max_points,
        base_usable = self.base_usable,
        points_usable = self.points_usable,
        badge_usable = self.badge_usable,
    })
end

function PointsGauge:set_value(value)
    local clamped = math.max(0, math.min(math.floor(tonumber(value) or 0), self.max_points))
    if clamped == self.value and self.visible then return end
    self.value = clamped
    if not self.visible then return end
    self:_draw_fill()
    self:_draw_badge()
end

function PointsGauge:hide()
    if not self.visible then return end
    self.visible = false
    Displayer.SlicedSprite.erase(self.player_id, self.base_lid)
    for i = 1, self.max_points do
        Displayer.SlicedSprite.erase(self.player_id, self.fill_lids[i])
    end
    Displayer.SlicedSprite.erase(self.player_id, self.badge_lid)
    pcall(Displayer.Text.removeStatic, self.player_id, self.text_tid)
end

function PointsGauge:destroy()
    self:hide()
    self.player_id = nil
end

return PointsGauge