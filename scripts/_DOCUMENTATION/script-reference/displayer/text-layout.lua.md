# `displayer/text-layout.lua`

> **Source reference**
>
> Generated from `displayer/text-layout.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

Public text measurement/layout helper for Displayer. All input and output coordinates are virtual 240x160 coordinates.

## Module location

- **Source:** `displayer/text-layout.lua`
- **Relative reference:** `script-reference/displayer/text-layout.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/displayer/font-system` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `TextLayout.layout` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextLayout.measure` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextLayout.measureLine` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `TextLayout.parseMarkup` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `glyph_advance` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `normalize_text` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `push_char` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `split_long_word` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `split_preserve_empty` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `wrap_paragraph` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 292 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
