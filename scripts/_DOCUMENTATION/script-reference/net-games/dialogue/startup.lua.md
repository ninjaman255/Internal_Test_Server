# `net-games/dialogue/startup.lua`

> **Source reference**
>
> Refreshed from the current `net-games/dialogue/startup.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

server/scripts/net-games/dialogue/startup.lua print("[net-games dialogue/startup] LOADING...") _G.NG_TEXTBOX_DEBUG = false _G.NG_TEXTBOX_DEBUG_TRACE = false local Displayer = require("scripts/displayer/displayer") local Input     = require("scripts/input/input") assert(Displayer:init(), "[net-games dialogue/startup] Displayer failed to init") Input.attach_virtual_input_listener() print("[net-games dialogue/startup] READY") return true

## Module location

- **Source:** `net-games/dialogue/startup.lua`
- **Reference:** `script-reference/net-games/dialogue/startup.lua.md`
- **Source SHA-256 prefix:** `d6ee31b1cabe`

## Source header notes

- server/scripts/net-games/dialogue/startup.lua
- print("[net-games dialogue/startup] LOADING...")
- _G.NG_TEXTBOX_DEBUG = false
- _G.NG_TEXTBOX_DEBUG_TRACE = false
- local Displayer = require("scripts/displayer/displayer")
- local Input     = require("scripts/input/input")

## Direct `require` dependencies

| Import path |
|---|
| `scripts/displayer/displayer` |
| `scripts/input/input` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
