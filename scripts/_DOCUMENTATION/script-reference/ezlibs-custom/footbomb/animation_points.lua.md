# `ezlibs-custom/footbomb/animation_points.lua`

> **Source reference**
>
> Generated from `ezlibs-custom/footbomb/animation_points.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

Backwards-compatible FootBomb animation-point helpers. Coordinate conversion is implemented centrally by world-attachment.lua so FootBomb and Net Games cannot drift into separate flip/projection math.

## Module location

- **Source:** `ezlibs-custom/footbomb/animation_points.lua`
- **Relative reference:** `script-reference/ezlibs-custom/footbomb/animation_points.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/world-attachment` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `AnimationPoints.offset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `AnimationPoints.to_map_offset` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 20 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
