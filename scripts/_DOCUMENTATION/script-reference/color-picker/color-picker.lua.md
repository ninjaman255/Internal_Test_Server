# `color-picker/color-picker.lua`

> **Source reference**
>
> Refreshed from the current `color-picker/color-picker.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Color picker source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `color-picker/color-picker.lua`
- **Reference:** `script-reference/color-picker/color-picker.lua.md`
- **Source SHA-256 prefix:** `1fee33096ab1`

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ColorPicker:getRandom` | `which` |
| `ColorPicker:new` | `` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
