# `tests/animation_points_test.lua`

> **Source reference**
>
> Refreshed from the current `tests/animation_points_test.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Animation points test source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `tests/animation_points_test.lua`
- **Reference:** `script-reference/tests/animation_points_test.lua.md`
- **Source SHA-256 prefix:** `93baf8b49bdb`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/footbomb/animation_points` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `check` | `label, frame, point, expected_x, expected_y` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
