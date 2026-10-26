# `libs/enums.lua`

> **Source reference**
>
> Refreshed from the current `libs/enums.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Enums source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `libs/enums.lua`
- **Reference:** `script-reference/libs/enums.lua.md`
- **Source SHA-256 prefix:** `201cde86c4cc`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `MULT` | `0,  -- Multiply (default)` |
| `ADD` | `1,   -- Addititve` |
| `COLOR` | `2, -- Colorize` |
| `MONEY` | `0,` |
| `CARD` | `1,` |
| `HEALTH` | `2,` |
| `FRAGMENT` | `3` |
| `NONE` | `0,` |
| `PRESSED` | `1,` |
| `HELD` | `2,` |
| `RELEASED` | `3` |
| `RUN` | `"Run",` |
| `INTERACT` | `"Interact",` |
| `MINIMAP` | `"Minimap",` |
| `SHOOT` | `"Shoot",` |
| `USE_CARD` | `"Use Card",` |
| `SPECIAL` | `"Special",` |
| `CUST_MENU` | `"Cust Menu",` |
| `PAUSE` | `"Pause",` |
| `MOVE_UP` | `"Move Up",` |
| `MOVE_DOWN` | `"Move Down",` |
| `MOVE_LEFT` | `"Move Left",` |
| `MOVE_RIGHT` | `"Move Right",` |
| `SHOULDER_L` | `"Shoulder L",` |
| `SHOULDER_R` | `"Shoulder R",` |
| `UI_UP` | `"UI Up",` |
| `UI_DOWN` | `"UI Down",` |
| `UI_LEFT` | `"UI Left",` |
| `UI_RIGHT` | `"UI Right",` |
| `CONFIRM` | `"Confirm",` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
