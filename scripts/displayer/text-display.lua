-- Unified text renderer for static text, marquee text, and BN-style typewriter boxes.
-- Public coordinates are virtual 240x160 coordinates.
-- Hardened with deterministic marquee IDs, pixel-snapped updates, real paging,
-- explicit teardown, and a public layout/measurement API.

local TextDisplay = {}
TextDisplay.__index = TextDisplay

local fontSystem = require("scripts/displayer/font-system")
local AnimationEngine = require("scripts/animation-engine/animation-engine")
local TextLayout = require("scripts/displayer/text-layout")

local DEFAULT_BACKDROP_TEXTURE = "/server/assets/net-games/displayer/empty_white.png"

local function normalize_loops(value)
    if value == nil or value == true then return nil end -- nil = infinite at this layer
    if value == false or value == "once" then return 1 end
    local n = tonumber(value)
    if not n then return nil end
    return math.max(1, math.floor(n))
end

local function pixel_snap_virtual(value)
    -- Net renders at 2x; half a virtual unit is exactly one rendered pixel.
    return math.floor((tonumber(value) or 0) * 2 + 0.5) / 2
end

local function copy_table(src)
    local out = {}
    for k, v in pairs(src or {}) do out[k] = v end
    return out
end

local function safe_call(fn, ...)
    if type(fn) ~= "function" then return end
    local ok, err = pcall(fn, ...)
    if not ok then print("[TextDisplay] callback failed: " .. tostring(err)) end
end

local function deterministic_glyph_id(text_id, index)
    return tostring(text_id) .. "_char_" .. tostring(index)
end

local DisplayInstance = {}
DisplayInstance.__index = DisplayInstance

function DisplayInstance:new(owner, player_id, text_id, text, x, y, options)
    options = options or {}
    local o = setmetatable({}, DisplayInstance)
    o.owner = owner
    o.player_id = player_id
    o.text_id = tostring(text_id)
    o.text = tostring(text or "")
    o.x = tonumber(x) or 0
    o.y = tonumber(y) or 0
    o.width = options.width and tonumber(options.width) or nil
    o.height = options.height and tonumber(options.height) or nil
    o.font = options.font or "THICK"
    o.scale = tonumber(options.scale) or 2.0
    o.z = tonumber(options.z) or 100
    o.halign = options.halign or "left"
    o.valign = options.valign or "top"
    o.perChar = options.perChar
    o.mode = options.mode or "static"
    o.global = {
        r = tonumber(options.r) or 255,
        g = tonumber(options.g) or 255,
        b = tonumber(options.b) or 255,
        opacity = tonumber(options.opacity) or 255,
        a = tonumber(options.a) or 255,
        ro = tonumber(options.ro) or 0,
        color_mode = tonumber(options.color_mode) or 0,
    }
    o.keep_alive = options.keep_alive == true
    o.marked_for_removal = false
    o.anim_id = nil
    o.next_char_delay = nil
    o.glyph_ids = {}
    o.drawn = {}
    o.backdrop = nil
    o._cleanup_generation = 0

    if o.mode == "marquee" then
        local mq = options.marquee or options
        o.loops = normalize_loops(mq.loops)
        o.speed = math.max(1, tonumber(mq.speed) or 60)
        o.pixel_snap = mq.pixel_snap ~= false
        o.cleanup_passes = math.max(1, math.floor(tonumber(mq.cleanup_passes) or 2))
        o.on_finish = mq.on_finish or options.on_finish
        o.viewport = copy_table(mq.viewport)
        if not o.viewport.x then o.viewport.x = o.x end
        if not o.viewport.y then o.viewport.y = o.y end
        if not o.viewport.width then o.viewport.width = o.width or 240 end
        if not o.viewport.height then o.viewport.height = o.height end
        o.viewport.padding_x = tonumber(o.viewport.padding_x or mq.padding_x) or 0
        o.backdrop_config = mq.backdrop or options.backdrop
        o.state = "active"
    elseif o.mode == "typewriter" then
        local tw = options.typewriter or options
        o.speed = math.max(1, tonumber(tw.speed or options.speed) or 30)
        o.char_delay = 1 / o.speed
        o.sound = tw.sound or options.type_sound
        o.sound_min_dt = tonumber(tw.sound_min_dt or options.type_sound_min_dt) or 0.1
        o._last_sound = -math.huge
        o.current_page = 1
        o.current_line = 1
        o.current_char = 0
        o.state = "printing"
        o.max_lines = tonumber(tw.max_lines or options.max_lines)
    else
        o.state = "active"
    end

    o:relayout()

    if o.mode == "marquee" then
        o:_drawBackdrop()
        o:_startMarquee()
    elseif o.mode == "typewriter" then
        o:_startCurrentPage()
    else
        o:_drawStatic()
    end

    return o
end

function DisplayInstance:relayout()
    self.layout = TextLayout.layout(self.text, {
        x = self.x,
        y = self.y,
        -- Marquee width is a viewport constraint, not a wrapping constraint.
        width = self.mode == "marquee" and nil or self.width,
        height = self.mode == "marquee" and nil or self.height,
        font = self.font,
        scale = self.scale,
        halign = self.halign,
        valign = self.valign,
        max_lines = self.max_lines,
    })
end

function DisplayInstance:_glyphOptions(glyph, extra)
    local opts = {
        scale = self.scale,
        z = self.z,
        r = self.global.r,
        g = self.global.g,
        b = self.global.b,
        opacity = self.global.opacity,
        a = self.global.a,
        ro = self.global.ro,
        color_mode = self.global.color_mode,
    }
    if extra then for k, v in pairs(extra) do opts[k] = v end end
    if self.perChar then
        local over = self.perChar(glyph.visible_index or 0, glyph.char, {
            page = glyph.page,
            line = glyph.line,
            col = glyph.col,
            elapsed = extra and extra.elapsed,
            isNew = extra and extra.isNew,
        })
        if over then for k, v in pairs(over) do opts[k] = v end end
    end
    return opts
end

function DisplayInstance:_eraseGlyphId(id)
    if id then fontSystem:eraseGlyph(self.player_id, id) end
    self.drawn[id] = nil
end

function DisplayInstance:_eraseAllGlyphs()
    for _, id in pairs(self.glyph_ids) do
        if id then fontSystem:eraseGlyph(self.player_id, id) end
    end
    -- Deterministic cleanup catches stale client sprites even if local bookkeeping was lost.
    local max_chars = 0
    for _, page in ipairs(self.layout.pages or {}) do
        for _, line in ipairs(page) do max_chars = max_chars + #line end
    end
    for i = 1, max_chars do
        fontSystem:eraseGlyph(self.player_id, deterministic_glyph_id(self.text_id, i))
    end
    self.glyph_ids = {}
    self.drawn = {}
end

function DisplayInstance:_drawStatic()
    local page = self.layout.page_layouts[1]
    if not page then return end
    local seq = 0
    for _, line in ipairs(page.lines) do
        for _, glyph in pairs(line.glyphs) do
            if glyph.char ~= " " then
                seq = seq + 1
                local id = deterministic_glyph_id(self.text_id, glyph.visible_index)
                fontSystem:drawGlyph(self.player_id, self.font, glyph.char, glyph.x, glyph.y,
                    self:_glyphOptions(glyph, { instance_id = id }))
                self.glyph_ids[glyph.visible_index] = id
                self.drawn[id] = { x = glyph.x, y = glyph.y, char = glyph.char }
            end
        end
    end
end

function DisplayInstance:_drawBackdrop()
    local cfg = self.backdrop_config
    if type(cfg) ~= "table" then return end

    local texture = cfg.texture_path or DEFAULT_BACKDROP_TEXTURE
    if Net.has_asset then
        local ok, exists = pcall(Net.has_asset, texture)
        if ok and exists == false then
            print("[TextDisplay] backdrop asset missing: " .. tostring(texture))
            return
        end
    end

    local asset_id = self.text_id .. "_marquee_backdrop_asset"
    local draw_id = self.text_id .. "_marquee_backdrop"
    pcall(Net.provide_asset_for_player, self.player_id, texture)
    pcall(Net.player_alloc_sprite, self.player_id, asset_id, { texture_path = texture })

    local x = tonumber(cfg.x) or tonumber(self.viewport.x) or self.x
    local y = tonumber(cfg.y) or tonumber(self.viewport.y) or self.y
    local width = tonumber(cfg.width) or tonumber(self.viewport.width) or 240
    local height = tonumber(cfg.height) or tonumber(self.viewport.height) or 16
    Net.player_draw_sprite(self.player_id, asset_id, {
        id = draw_id,
        x = x * 2,
        y = y * 2,
        z = tonumber(cfg.z) or (self.z - 1),
        sx = width * 2,
        sy = height * 2,
        r = tonumber(cfg.r) or 255,
        g = tonumber(cfg.g) or 255,
        b = tonumber(cfg.b) or 255,
        a = tonumber(cfg.a) or 255,
        opacity = tonumber(cfg.opacity) or 255,
        color_mode = tonumber(cfg.color_mode) or 0,
    })
    self.backdrop = { asset_id = asset_id, draw_id = draw_id, keep = cfg.keep_backdrop == true }
end

function DisplayInstance:_eraseBackdrop(force)
    if not self.backdrop then return end
    if self.backdrop.keep and not force then return end
    pcall(Net.player_erase_sprite, self.player_id, self.backdrop.draw_id)
    if Net.player_dealloc_sprite then pcall(Net.player_dealloc_sprite, self.player_id, self.backdrop.asset_id) end
    self.backdrop = nil
end

function DisplayInstance:_marqueeGlyphs()
    local out = {}
    local page = self.layout.page_layouts[1]
    if not page then return out end
    for _, line in ipairs(page.lines) do
        for _, glyph in pairs(line.glyphs) do
            if glyph.char ~= " " then out[#out + 1] = glyph end
        end
    end
    table.sort(out, function(a, b) return a.visible_index < b.visible_index end)
    return out
end

function DisplayInstance:_drawMarqueeAt(offset, elapsed)
    local viewport = self.viewport
    local left = tonumber(viewport.x) or self.x
    local right = left + (tonumber(viewport.width) or 240)

    for _, glyph in ipairs(self:_marqueeGlyphs()) do
        local gx = glyph.x + offset
        local gw = TextLayout.measureLine(glyph.char, { font = self.font, scale = self.scale })
        local visible = (gx + gw) >= left and gx <= right
        local id = deterministic_glyph_id(self.text_id, glyph.visible_index)

        if visible then
            local snapped_x = self.pixel_snap and pixel_snap_virtual(gx) or gx
            local snapped_y = self.pixel_snap and pixel_snap_virtual(glyph.y) or glyph.y
            local last = self.drawn[id]
            -- This is the key production fix: do not transmit a draw when the rendered pixel did not move.
            if not last then
                fontSystem:drawGlyph(self.player_id, self.font, glyph.char, snapped_x, snapped_y,
                    self:_glyphOptions(glyph, { instance_id = id, elapsed = elapsed, isNew = true }))
                self.glyph_ids[glyph.visible_index] = id
                self.drawn[id] = { x = snapped_x, y = snapped_y, char = glyph.char }
            elseif last.x ~= snapped_x or last.y ~= snapped_y or last.char ~= glyph.char then
                fontSystem:updateGlyph(self.player_id, id,
                    self:_glyphOptions(glyph, { x = snapped_x, y = snapped_y, char = glyph.char, elapsed = elapsed }))
                last.x, last.y, last.char = snapped_x, snapped_y, glyph.char
            end
        elseif self.drawn[id] then
            fontSystem:eraseGlyph(self.player_id, id)
            self.drawn[id] = nil
            self.glyph_ids[glyph.visible_index] = nil
        end
    end
end

function DisplayInstance:_cleanupMarquee(done)
    self:_eraseAllGlyphs()
    local passes = self.cleanup_passes or 1
    local generation = self._cleanup_generation + 1
    self._cleanup_generation = generation

    local function pass(n)
        if generation ~= self._cleanup_generation then return end
        self:_eraseAllGlyphs()
        if n < passes then
            AnimationEngine.delay(0, function() pass(n + 1) end)
        else
            if done then done() end
        end
    end
    pass(1)
end

function DisplayInstance:_startMarquee()
    local glyphs = self:_marqueeGlyphs()
    if #glyphs == 0 then
        self.state = "completed"
        safe_call(self.on_finish, self.player_id, self.text_id)
        return
    end

    local text_width = self.layout.total_width
    local left = tonumber(self.viewport.x) or self.x
    local viewport_width = tonumber(self.viewport.width) or 240
    local padding = tonumber(self.viewport.padding_x) or 0
    local base_x = self.layout.page_layouts[1].lines[1] and self.layout.page_layouts[1].lines[1].x or self.x
    local start_offset = (left + viewport_width + padding) - base_x
    local end_offset = (left - padding - text_width) - base_x
    local distance = math.abs(start_offset - end_offset)
    local duration = math.max(0.001, distance / self.speed)

    local loop_value = self.loops == nil and true or self.loops
    self.anim_id = AnimationEngine.animate({ progress = 0 }, { progress = 1 }, duration, {
        easing = "linear",
        loop = loop_value,
        on_update = function(values)
            if self.marked_for_removal then return end
            local p = values.progress or 0
            local offset = start_offset + (end_offset - start_offset) * p
            self:_drawMarqueeAt(offset, p * duration)
        end,
        on_complete = function(_, interrupted)
            self.anim_id = nil
            if interrupted or self.marked_for_removal then return end
            self:_cleanupMarquee(function()
                self.state = "completed"
                self:_eraseBackdrop(false)
                safe_call(self.on_finish, self.player_id, self.text_id)
            end)
        end,
    })
end

function DisplayInstance:_pageMeta(page_index)
    return self.layout.page_layouts[page_index]
end

function DisplayInstance:_currentGlyph()
    local page = self:_pageMeta(self.current_page)
    if not page then return nil end
    local line = page.lines[self.current_line]
    if not line then return nil end
    return line.glyphs[self.current_char]
end

function DisplayInstance:_cancelPendingCharacter()
    if self.next_char_delay then
        if AnimationEngine.cancel_delay then AnimationEngine.cancel_delay(self.next_char_delay) end
        self.next_char_delay = nil
    end
end

function DisplayInstance:_scheduleNextChar(delay)
    self:_cancelPendingCharacter()
    if self.state ~= "printing" then return end
    self.next_char_delay = AnimationEngine.delay(math.max(0, tonumber(delay) or 0), function()
        self.next_char_delay = nil
        if self.state == "printing" and not self.marked_for_removal then self:_printNextChar() end
    end)
end

function DisplayInstance:_startCurrentPage()
    self:_cancelPendingCharacter()
    self.current_line = 1
    self.current_char = 0
    if not self:_pageMeta(self.current_page) then
        self.state = "completed"
        return
    end
    self.state = "printing"
    self:_scheduleNextChar(0)
end

function DisplayInstance:_pageFinished()
    self:_cancelPendingCharacter()
    self.state = "waiting"
end

function DisplayInstance:_drawTypewriterGlyph(glyph)
    if not glyph or glyph.char == " " then return end
    local id = deterministic_glyph_id(self.text_id, glyph.visible_index)
    fontSystem:drawGlyph(self.player_id, self.font, glyph.char,
        pixel_snap_virtual(glyph.x), pixel_snap_virtual(glyph.y),
        self:_glyphOptions(glyph, { instance_id = id, isNew = true }))
    self.glyph_ids[glyph.visible_index] = id
    self.drawn[id] = { x = pixel_snap_virtual(glyph.x), y = pixel_snap_virtual(glyph.y), char = glyph.char }

    if self.sound then
        local t = AnimationEngine.get_time and AnimationEngine.get_time() or 0
        if t - self._last_sound >= self.sound_min_dt then
            pcall(Net.play_sound_for_player, self.player_id, self.sound)
            self._last_sound = t
        end
    end
end

function DisplayInstance:_printNextChar()
    if self.state ~= "printing" then return false end
    local page = self:_pageMeta(self.current_page)
    if not page then self.state = "completed"; return false end

    local line = page.lines[self.current_line]
    if not line then self:_pageFinished(); return false end

    self.current_char = self.current_char + 1
    if self.current_char > #line.text then
        self.current_line = self.current_line + 1
        self.current_char = 0
        if self.current_line > #page.lines then
            self:_pageFinished()
        else
            self:_scheduleNextChar(self.char_delay)
        end
        return true
    end

    local glyph = line.glyphs[self.current_char]
    if glyph then self:_drawTypewriterGlyph(glyph) end
    local pause = glyph and glyph.pause_before or 0
    self:_scheduleNextChar(self.char_delay + pause)
    return true
end

function DisplayInstance:_finishCurrentPageImmediately()
    local page = self:_pageMeta(self.current_page)
    if not page then self.state = "completed"; return end
    self:_cancelPendingCharacter()
    for _, line in ipairs(page.lines) do
        for _, glyph in pairs(line.glyphs) do
            if glyph.char ~= " " then
                local id = deterministic_glyph_id(self.text_id, glyph.visible_index)
                if not self.drawn[id] then self:_drawTypewriterGlyph(glyph) end
            end
        end
    end
    self.current_line = #page.lines
    self.current_char = #((page.lines[#page.lines] and page.lines[#page.lines].text) or "")
    self.state = "waiting"
end

function DisplayInstance:_eraseCurrentPage()
    local page = self:_pageMeta(self.current_page)
    if not page then return end
    for _, line in ipairs(page.lines) do
        for _, glyph in pairs(line.glyphs) do
            local id = deterministic_glyph_id(self.text_id, glyph.visible_index)
            if self.drawn[id] or self.glyph_ids[glyph.visible_index] then
                fontSystem:eraseGlyph(self.player_id, id)
                self.drawn[id] = nil
                self.glyph_ids[glyph.visible_index] = nil
            end
        end
    end
end

function DisplayInstance:advance()
    if self.mode ~= "typewriter" or self.marked_for_removal then return end
    if self.state == "printing" then
        self:_finishCurrentPageImmediately()
    elseif self.state == "waiting" then
        self:_eraseCurrentPage()
        self.current_page = self.current_page + 1
        if self.current_page > #self.layout.pages then
            self.state = "completed"
        else
            self:_startCurrentPage()
        end
    end
end

function DisplayInstance:reset(text, options)
    options = options or {}
    self._cleanup_generation = self._cleanup_generation + 1
    if self.anim_id then AnimationEngine.stop_animation(self.anim_id); self.anim_id = nil end
    self:_cancelPendingCharacter()
    self:_eraseAllGlyphs()
    self.marked_for_removal = false
    self.text = tostring(text or "")

    if options.font then self.font = options.font end
    if options.scale then self.scale = tonumber(options.scale) or self.scale end
    if options.z then self.z = tonumber(options.z) or self.z end
    if options.width then self.width = tonumber(options.width) end
    if options.height then self.height = tonumber(options.height) end
    if options.x then self.x = tonumber(options.x) or self.x end
    if options.y then self.y = tonumber(options.y) or self.y end
    if options.speed then self.speed = math.max(1, tonumber(options.speed) or self.speed) end
    if options.type_sound ~= nil then self.sound = options.type_sound end
    if options.type_sound_min_dt then self.sound_min_dt = tonumber(options.type_sound_min_dt) or self.sound_min_dt end
    if options.max_lines then self.max_lines = tonumber(options.max_lines) end

    self.current_page = 1
    self.current_line = 1
    self.current_char = 0
    self:relayout()

    if self.mode == "typewriter" then self:_startCurrentPage()
    elseif self.mode == "marquee" then self.state = "active"; self:_startMarquee()
    else self.state = "active"; self:_drawStatic() end
end

function DisplayInstance:close()
    if self.marked_for_removal then return end
    self.marked_for_removal = true
    self._cleanup_generation = self._cleanup_generation + 1
    self:_cancelPendingCharacter()
    if self.anim_id then AnimationEngine.stop_animation(self.anim_id); self.anim_id = nil end
    self:_eraseAllGlyphs()
    self:_eraseBackdrop(true)
    self.state = "completed"
end

function TextDisplay:init()
    if self._initialized then return self end
    self._initialized = true
    self.font_system = fontSystem
    self.player_texts = self.player_texts or {}

    Net:on("tick", function(event)
        local ok, err = pcall(function() self:updateAll(event and event.delta_time or 0) end)
        if not ok then print("[TextDisplay] tick failed: " .. tostring(err)) end
    end)
    Net:on("player_disconnect", function(event)
        if event and event.player_id then self:cleanupPlayer(event.player_id) end
    end)
    return self
end

function TextDisplay:layout(text, options)
    return TextLayout.layout(text, options or {})
end

function TextDisplay:measure(text, options)
    return TextLayout.measure(text, options or {})
end

function TextDisplay:cleanupPlayer(player_id)
    local displays = self.player_texts[player_id]
    if not displays then return end
    for _, display in pairs(displays) do display:close() end
    self.player_texts[player_id] = nil
end

function TextDisplay:updateAll(_dt)
    for player_id, displays in pairs(self.player_texts) do
        local remove = {}
        for text_id, display in pairs(displays) do
            if display.marked_for_removal or (display.state == "completed" and not display.keep_alive and display.mode ~= "typewriter") then
                remove[#remove + 1] = text_id
            end
        end
        for _, text_id in ipairs(remove) do displays[text_id] = nil end
        if next(displays) == nil then self.player_texts[player_id] = nil end
    end
end

function TextDisplay:draw(player_id, text_id, text, x, y, options)
    options = options or {}
    self.player_texts[player_id] = self.player_texts[player_id] or {}
    local old = self.player_texts[player_id][text_id]
    if old then old:close() end
    local display = DisplayInstance:new(self, player_id, text_id, text, x, y, options)
    self.player_texts[player_id][text_id] = display
    return display
end

function TextDisplay:remove(player_id, text_id)
    local display = self.player_texts[player_id] and self.player_texts[player_id][text_id]
    if not display then return false end
    display:close()
    return true
end

function TextDisplay:get(player_id, text_id)
    return self.player_texts[player_id] and self.player_texts[player_id][text_id] or nil
end

function TextDisplay:getState(player_id, text_id)
    local display = self:get(player_id, text_id)
    return display and display.state or nil
end

function TextDisplay:getData(player_id, text_id)
    local d = self:get(player_id, text_id)
    if not d then return nil end

    local line_x_offsets = {}
    for p, page in ipairs(d.layout.page_layouts or {}) do
        line_x_offsets[p] = {}
        for li, line in ipairs(page.lines or {}) do
            line_x_offsets[p][li] = line.x * 2
        end
    end

    return {
        -- Legacy screen-pixel fields retained for current Nameplate/Prompt callers.
        x = d.x * 2,
        y = d.y * 2,
        width = d.width and d.width * 2 or nil,
        height = d.height and d.height * 2 or nil,
        inner_x = d.x * 2,
        inner_y = d.y * 2,
        _line_height_px = d.layout.line_height * 2,
        line_x_offsets = line_x_offsets,

        -- Canonical public virtual-coordinate fields.
        virtual_x = d.x,
        virtual_y = d.y,
        virtual_width = d.width,
        virtual_height = d.height,
        line_height = d.layout.line_height,

        scale = d.scale,
        z_order = d.z,
        font = d.font,
        mode = d.mode,
        state = d.state,
        pages = d.layout.pages,
        page_layouts = d.layout.page_layouts,
        page_count = #d.layout.pages,
        current_page = d.current_page or 1,
        current_line = d.current_line or 1,
        current_char = d.current_char or 0,
        marked_for_removal = d.marked_for_removal,
        backdrop = d.backdrop_config,
        _box_id = d.text_id,
    }
end

function TextDisplay:setKeepAlive(player_id, text_id, value)
    local display = self:get(player_id, text_id)
    if not display then return false end
    display.keep_alive = value == true
    return true
end

function TextDisplay:advance(player_id, text_id)
    local display = self:get(player_id, text_id)
    if not display then return false end
    display:advance()
    return true
end

function TextDisplay:reset(player_id, text_id, text, options)
    local display = self:get(player_id, text_id)
    if not display then return nil end
    display:reset(text, options or {})
    return display
end



-- --------------------------------------------------------------------
-- Compatibility/public convenience wrappers used by the current Displayer facade.
-- --------------------------------------------------------------------
local function copy_options(options)
    local out = {}
    for k, v in pairs(options or {}) do out[k] = v end
    return out
end

function TextDisplay:drawStatic(player_id, text_id, text, x, y, options)
    local opts = copy_options(options)
    opts.mode = "static"
    self:draw(player_id, text_id, text, x, y, opts)
    return text_id
end

function TextDisplay:removeStatic(player_id, text_id)
    return self:remove(player_id, text_id)
end

function TextDisplay:drawMarquee(player_id, marquee_id, text, y, options)
    local opts = copy_options(options)
    opts.mode = "marquee"
    local x = tonumber(opts.x) or 0
    self:draw(player_id, marquee_id, text, x, y, opts)
    return marquee_id
end

function TextDisplay:removeMarquee(player_id, marquee_id)
    return self:remove(player_id, marquee_id)
end

function TextDisplay:createTextBox(player_id, box_id, text, x, y, width, height, options)
    local opts = copy_options(options)
    opts.mode = "typewriter"
    opts.width = width
    opts.height = height
    self:draw(player_id, box_id, text, x, y, opts)
    return box_id
end

function TextDisplay:advanceTextBox(player_id, box_id)
    return self:advance(player_id, box_id)
end

function TextDisplay:closeTextBox(player_id, box_id)
    return self:remove(player_id, box_id)
end

function TextDisplay:getTextBoxState(player_id, box_id)
    local display = self:get(player_id, box_id)
    if not display then
        -- Preserve the creator API contract: a missing text box is logically completed.
        -- Callers that need to distinguish completed-vs-gone should use getTextBoxData().
        return "completed"
    end
    if display.mode == "typewriter" then
        return display.state
    end
    return "completed"
end

function TextDisplay:getTextBoxData(player_id, box_id)
    return self:getData(player_id, box_id)
end

function TextDisplay:resetTextBox(player_id, box_id, text, options)
    return self:reset(player_id, box_id, text, options)
end

local singleton = setmetatable({}, TextDisplay)
singleton:init()
return singleton
