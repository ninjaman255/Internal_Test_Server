-- points_gauge.lua
--
-- Screen HUD for a liberation's order points. Composed of three 3-slice
-- sprites drawn through Displayer.SlicedSprite:
--
--   * base-guage-3slice  -- the empty bar behind everything (widest)
--   * points-3slice      -- one pip per filled point, laid out left-to-right
--   * point-total-3slice -- centered badge showing "value/max" as text
--
-- Everything else in the codebase calls Mission:set_order_points(n), which
-- fans out to each PointsGauge. This module never leaks Displayer details
-- upward.

local Displayer = require("scripts/displayer/displayer")
local TextLayout = require("scripts/displayer/text-layout")

local PointsGauge = {}
PointsGauge.__index = PointsGauge

local ASSET_ROOT = "/server/assets/net-games/meters/liberation-order-points"

-- All layout values are in raw 480x320 screen pixels (matches
-- Displayer:getScreenDimensions() and Net.player_draw_sprite space).
local LAYOUT = {
    screen_w = 480,
    screen_h = 320,
    gauge_y = 12,
    gauge_h = 24,
    segment_w = 20,      -- width of one order-point pip
    badge_w = 48,
    badge_h = 16,
    badge_y = 0,         -- overlaps the gauge top by (gauge_y - (badge_y + badge_h))? no:
                         -- badge spans 0..16, gauge spans 12..36 → 4px overlap.
    z_base = 200,
    z_fill = 201,
    z_badge = 202,
    z_text = 203,
    text_font = "THICK",
    text_scale = 1.0,
    text_color = { r = 255, g = 255, b = 255, a = 255 },
}

-- sliceStyle3 tables are immutable at runtime; build them once for every
-- player's gauge to share.
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

local function id_safe(value)
    return tostring(value):gsub("[^%w_%-]", "_")
end

function PointsGauge:new(player_id, max_points)
    local gauge = setmetatable({}, PointsGauge)
    gauge.player_id = player_id
    gauge.max_points = math.max(1, math.floor(tonumber(max_points) or 8))
    gauge.value = 0
    gauge.visible = false

    gauge.gauge_w = gauge.max_points * LAYOUT.segment_w
    gauge.gauge_x = math.floor((LAYOUT.screen_w - gauge.gauge_w) / 2)
    gauge.badge_x = math.floor((LAYOUT.screen_w - LAYOUT.badge_w) / 2)

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

function PointsGauge:_draw_base()
    local s = get_styles()
    Displayer.SlicedSprite.draw3(
        self.player_id, self.base_lid,
        self.gauge_x, LAYOUT.gauge_y,
        self.gauge_w, LAYOUT.gauge_h,
        s.base,
        { z = LAYOUT.z_base }
    )
end

function PointsGauge:_draw_fill()
    local s = get_styles()
    for i = 1, self.max_points do
        if i <= self.value then
            Displayer.SlicedSprite.draw3(
                self.player_id, self.fill_lids[i],
                self.gauge_x + (i - 1) * LAYOUT.segment_w, LAYOUT.gauge_y,
                LAYOUT.segment_w, LAYOUT.gauge_h,
                s.points,
                { z = LAYOUT.z_fill }
            )
        else
            -- Clear any pips above the current value. Safe no-op when the
            -- pip was never drawn.
            Displayer.SlicedSprite.erase(self.player_id, self.fill_lids[i])
        end
    end
end

function PointsGauge:_draw_badge()
    local s = get_styles()
    Displayer.SlicedSprite.draw3(
        self.player_id, self.badge_lid,
        self.badge_x, LAYOUT.badge_y,
        LAYOUT.badge_w, LAYOUT.badge_h,
        s.badge,
        { z = LAYOUT.z_badge }
    )

    local text = tostring(self.value) .. "/" .. tostring(self.max_points)
    local opts = { font = LAYOUT.text_font, scale = LAYOUT.text_scale }
    local text_w = TextLayout.measureLine(text, opts)
    local approx_glyph_h = 8 * LAYOUT.text_scale
    local text_x = self.badge_x + math.floor((LAYOUT.badge_w - text_w) / 2)
    local text_y = LAYOUT.badge_y + math.floor((LAYOUT.badge_h - approx_glyph_h) / 2)

    Displayer.Text.drawStatic(
        self.player_id, self.text_tid, text, text_x, text_y,
        {
            font = LAYOUT.text_font, scale = LAYOUT.text_scale,
            z = LAYOUT.z_text,
            r = LAYOUT.text_color.r, g = LAYOUT.text_color.g,
            b = LAYOUT.text_color.b, a = LAYOUT.text_color.a,
            opacity = 255,
        }
    )
end

function PointsGauge:show()
    if self.visible then return end
    self.visible = true
    self:_draw_base()
    self:_draw_fill()
    self:_draw_badge()
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