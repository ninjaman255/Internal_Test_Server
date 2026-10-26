# `net-games/bn-textbox.lua`

> **Source reference**
>
> Refreshed from the current `net-games/bn-textbox.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

bn_textbox.lua Simple BN-style text box with typewriter, optional nameplate, mugshot, and backdrop. Uses the existing Dialogue.start system for reliable behavior and input handling.

## Module location

- **Source:** `net-games/bn-textbox.lua`
- **Reference:** `script-reference/net-games/bn-textbox.lua.md`
- **Source SHA-256 prefix:** `552f66876260`

## Source header notes

- bn_textbox.lua
- Simple BN-style text box with typewriter, optional nameplate, mugshot, and backdrop.
- Uses the existing Dialogue.start system for reliable behavior and input handling.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/dialogue/dialogue` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `shallow_copy` | `t` |
| `build_ui` | `player_id, opts` |
| `BNTextbox.show` | `player_id, text, opts` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/net-games/sfx/text.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
