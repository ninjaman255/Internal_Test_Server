# `net-games/npcs/menu_options.lua`

> **Source reference**
>
> Refreshed from the current `net-games/npcs/menu_options.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

scripts/net-games/npcs/menu_options.lua Purpose: Build PromptVertical option tables without loops/math in each NPC file.

## Module location

- **Source:** `net-games/npcs/menu_options.lua`
- **Reference:** `script-reference/net-games/npcs/menu_options.lua.md`
- **Source SHA-256 prefix:** `2def12bf1934`

## Source header notes

- scripts/net-games/npcs/menu_options.lua
- Purpose: Build PromptVertical option tables without loops/math in each NPC file.

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `pad2` | `n` |
| `M.count` | `count, cfg` |
| `M.list` | `items, cfg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
