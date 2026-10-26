# `displayer/text-layout.lua`

> **Source reference**
>
> Refreshed from the current `displayer/text-layout.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Public text measurement/layout helper for Displayer. All input and output coordinates are virtual 240x160 coordinates.

## Module location

- **Source:** `displayer/text-layout.lua`
- **Reference:** `script-reference/displayer/text-layout.lua.md`
- **Source SHA-256 prefix:** `140b18513660`

## Source header notes

- Public text measurement/layout helper for Displayer.
- All input and output coordinates are virtual 240x160 coordinates.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/displayer/font-system` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `normalize_scale` | `value, fallback` |
| `normalize_text` | `text` |
| `TextLayout.parseMarkup` | `text` |
| `push_char` | `ch` |
| `glyph_advance` | `font, char, scale` |
| `TextLayout.measureLine` | `text, options` |
| `split_long_word` | `word, max_width, options` |
| `wrap_paragraph` | `paragraph, max_width, options` |
| `split_preserve_empty` | `text, sep` |
| `TextLayout.layout` | `text, options` |
| `TextLayout.measure` | `text, options` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
