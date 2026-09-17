-- Public text measurement/layout helper for Displayer.
-- All input and output coordinates are virtual 240x160 coordinates.

local fontSystem = require("scripts/displayer/font-system")

local TextLayout = {}

local function normalize_text(text)
    text = tostring(text or "")
    text = text:gsub("\r", "")
    text = text:gsub("\239\187\191", "") -- UTF-8 BOM
    text = text:gsub("\194\160", " ")    -- NBSP
    local b = string.char
    text = text:gsub(b(0x91), "'"):gsub(b(0x92), "'")
    text = text:gsub(b(0x93), '"'):gsub(b(0x94), '"')
    text = text:gsub(b(0x96), "-"):gsub(b(0x97), "-")
    text = text:gsub(b(0x85), "...")
    return text
end
TextLayout.normalizeText = normalize_text

-- Turn the legacy dialogue markup into plain layout text while preserving pause positions.
-- Supported tags: {p_0.25}, {end_line}, {end_page}. Unknown tags remain literal.
function TextLayout.parseMarkup(text)
    text = normalize_text(text)
    local out = {}
    local pauses = {}
    local visible_count = 0
    local i = 1

    local function push_char(ch)
        out[#out + 1] = ch
        if ch ~= "\n" and ch ~= "\f" then visible_count = visible_count + 1 end
    end

    while i <= #text do
        if text:sub(i, i) == "{" then
            local close = text:find("}", i + 1, true)
            if close then
                local tag = text:sub(i + 1, close - 1)
                local pause = tag:match("^p_(%d+%.?%d*)$")
                if pause then
                    local next_index = visible_count + 1
                    pauses[next_index] = (pauses[next_index] or 0) + (tonumber(pause) or 0)
                    i = close + 1
                elseif tag == "end_line" then
                    push_char("\n")
                    i = close + 1
                elseif tag == "end_page" then
                    push_char("\f")
                    i = close + 1
                else
                    for j = i, close do push_char(text:sub(j, j)) end
                    i = close + 1
                end
            else
                push_char(text:sub(i, i))
                i = i + 1
            end
        else
            push_char(text:sub(i, i))
            i = i + 1
        end
    end

    return table.concat(out), pauses
end

local function glyph_advance(font, char, scale)
    local w = fontSystem:getGlyphDimensions(font, char)
    local spacing = fontSystem:isBattleFont(font) and 0 or 1
    -- FontSystem doubles virtual positions before rendering. Convert rendered pixels back to virtual units.
    return ((w + spacing) * scale) / 2
end

function TextLayout.measureLine(text, options)
    options = options or {}
    local font = options.font or "THICK"
    local scale = options.scale or 2.0
    local width = 0
    for i = 1, #tostring(text or "") do
        local ch = text:sub(i, i)
        width = width + glyph_advance(font, ch, scale)
    end
    return width
end

local function split_long_word(word, max_width, options)
    if not max_width or max_width <= 0 then return { word } end
    local chunks, current, width = {}, "", 0
    for i = 1, #word do
        local ch = word:sub(i, i)
        local adv = glyph_advance(options.font, ch, options.scale)
        if current ~= "" and width + adv > max_width then
            chunks[#chunks + 1] = current
            current, width = "", 0
        end
        current = current .. ch
        width = width + adv
    end
    if current ~= "" then chunks[#chunks + 1] = current end
    return chunks
end

local function wrap_paragraph(paragraph, max_width, options)
    if not max_width or max_width <= 0 then return { paragraph } end
    if paragraph == "" then return { "" } end

    local lines, current = {}, ""
    local space_width = TextLayout.measureLine(" ", options)

    for word in paragraph:gmatch("%S+") do
        local pieces = { word }
        if TextLayout.measureLine(word, options) > max_width then
            pieces = split_long_word(word, max_width, options)
        end

        for pi, piece in ipairs(pieces) do
            local piece_width = TextLayout.measureLine(piece, options)
            local current_width = TextLayout.measureLine(current, options)
            local needs_space = current ~= "" and pi == 1
            local next_width = current_width + (needs_space and space_width or 0) + piece_width

            if current ~= "" and next_width > max_width then
                lines[#lines + 1] = current
                current = piece
            else
                if needs_space then current = current .. " " end
                current = current .. piece
            end

            if pi < #pieces then
                lines[#lines + 1] = current
                current = ""
            end
        end
    end

    if current ~= "" or #lines == 0 then lines[#lines + 1] = current end
    return lines
end

local function split_preserve_empty(text, sep)
    local out, start = {}, 1
    while true do
        local s, e = text:find(sep, start, true)
        if not s then
            out[#out + 1] = text:sub(start)
            break
        end
        out[#out + 1] = text:sub(start, s - 1)
        start = e + 1
    end
    return out
end

function TextLayout.layout(text, options)
    options = options or {}
    local font = options.font or "THICK"
    local scale = tonumber(options.scale) or 2.0
    local x = tonumber(options.x) or 0
    local y = tonumber(options.y) or 0
    local width = tonumber(options.width)
    local height = tonumber(options.height)
    local halign = options.halign or "left"
    local valign = options.valign or "top"

    local plain, pauses = TextLayout.parseMarkup(text)
    local source_pages = split_preserve_empty(plain, "\f")
    local line_height = (tonumber(options.line_height) or (12 * scale / 2))
    local max_lines = tonumber(options.max_lines)
    if not max_lines and height and line_height > 0 then
        max_lines = math.max(1, math.floor(height / line_height + 0.0001))
    end
    max_lines = max_lines and math.max(1, math.floor(max_lines)) or math.huge

    local wrapped_lines = {}
    local forced_page_break_after = {}
    for page_index, source_page in ipairs(source_pages) do
        local paragraphs = split_preserve_empty(source_page, "\n")
        for _, paragraph in ipairs(paragraphs) do
            local lines = wrap_paragraph(paragraph, width, { font = font, scale = scale })
            for _, line in ipairs(lines) do wrapped_lines[#wrapped_lines + 1] = line end
        end
        if page_index < #source_pages then forced_page_break_after[#wrapped_lines] = true end
    end

    if #wrapped_lines == 0 then wrapped_lines[1] = "" end

    local pages, current = {}, {}
    for line_index, line in ipairs(wrapped_lines) do
        current[#current + 1] = line
        if #current >= max_lines or forced_page_break_after[line_index] then
            pages[#pages + 1] = current
            current = {}
        end
    end
    if #current > 0 or #pages == 0 then pages[#pages + 1] = current end

    local page_layouts = {}
    local flat_glyphs = {}
    local global_visible_index = 0
    local max_page_width = 0

    for page_index, page in ipairs(pages) do
        local page_height = #page * line_height
        local page_y = y
        if height then
            if valign == "middle" then page_y = y + (height - page_height) / 2
            elseif valign == "bottom" then page_y = y + height - page_height end
        end

        local lines_meta = {}
        local page_width = 0
        for line_index, line in ipairs(page) do
            local line_width = TextLayout.measureLine(line, { font = font, scale = scale })
            if line_width > page_width then page_width = line_width end
            local line_x = x
            if width then
                if halign == "center" then line_x = x + (width - line_width) / 2
                elseif halign == "right" then line_x = x + width - line_width end
            end
            local line_y = page_y + (line_index - 1) * line_height
            local cx = line_x
            local glyphs = {}
            for col = 1, #line do
                local ch = line:sub(col, col)
                global_visible_index = global_visible_index + 1
                local glyph = {
                    char = ch,
                    x = cx,
                    y = line_y,
                    page = page_index,
                    line = line_index,
                    col = col,
                    visible_index = global_visible_index,
                    pause_before = pauses[global_visible_index] or 0,
                }
                glyphs[col] = glyph
                if ch ~= " " then flat_glyphs[#flat_glyphs + 1] = glyph end
                cx = cx + glyph_advance(font, ch, scale)
            end
            lines_meta[line_index] = {
                text = line,
                x = line_x,
                y = line_y,
                width = line_width,
                glyphs = glyphs,
            }
        end
        if page_width > max_page_width then max_page_width = page_width end
        page_layouts[page_index] = {
            lines = lines_meta,
            width = page_width,
            height = page_height,
            x = x,
            y = page_y,
        }
    end

    return {
        text = plain,
        pages = pages,
        page_layouts = page_layouts,
        flat_glyphs = flat_glyphs,
        font = font,
        scale = scale,
        x = x,
        y = y,
        width = width,
        height = height,
        line_height = line_height,
        max_lines = max_lines == math.huge and nil or max_lines,
        total_width = max_page_width,
        total_height = (#pages[1] or 0) * line_height,
        page_count = #pages,
        pauses = pauses,
    }
end

function TextLayout.measure(text, options)
    local layout = TextLayout.layout(text, options)
    return {
        width = layout.total_width,
        height = layout.total_height,
        page_count = layout.page_count,
        line_height = layout.line_height,
        pages = layout.pages,
    }
end

return TextLayout
