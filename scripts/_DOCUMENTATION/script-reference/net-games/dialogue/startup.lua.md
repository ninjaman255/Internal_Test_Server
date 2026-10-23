# `net-games/dialogue/startup.lua`

> **Source reference**
>
> Generated from `net-games/dialogue/startup.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

server/scripts/net-games/dialogue/startup.lua print("[net-games dialogue/startup] LOADING...") _G.NG_TEXTBOX_DEBUG = false _G.NG_TEXTBOX_DEBUG_TRACE = false local Displayer = require("scripts/displayer/displayer") local Input     = require("scripts/input/input") assert(Displayer:init(), "[net-games dialogue/startup] Displayer failed to init") Input.attach_virtual_input_listener() print("[net-games dialogue/startup] READY") return true

## Module location

- **Source:** `net-games/dialogue/startup.lua`
- **Relative reference:** `script-reference/net-games/dialogue/startup.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/displayer/displayer` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/input/input` | Import string found in source; runtime resolution depends on the server package layout. |

## Source notes

- Approximate source size: 13 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
