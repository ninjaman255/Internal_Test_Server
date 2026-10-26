# `jukebox/constants/ui-data.lua`

> **Source reference**
>
> Refreshed from the current `jukebox/constants/ui-data.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Ui data source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `jukebox/constants/ui-data.lua`
- **Reference:** `script-reference/jukebox/constants/ui-data.lua.md`
- **Source SHA-256 prefix:** `b4254abd85a3`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/jukebox/ui-sprites/shade-screen.png` |
| `/server/assets/jukebox/ui-sprites/jukebox-backdrop.png` |
| `/server/assets/jukebox/ui-sprites/jukebox-frame.png` |
| `/server/assets/jukebox/records/MMBN7_OST-alouetteEXE/base.png` |
| `/server/assets/jukebox/ui-sprites/records/record.animation` |
| `/server/assets/net-games/text_cursor.png` |
| `/server/assets/net-games/text_cursor.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
