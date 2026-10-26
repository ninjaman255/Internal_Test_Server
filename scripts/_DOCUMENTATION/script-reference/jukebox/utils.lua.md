# `jukebox/utils.lua`

> **Source reference**
>
> Refreshed from the current `jukebox/utils.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

utils.lua Helper functions for OS detection, file listing, and string splitting.

## Module location

- **Source:** `jukebox/utils.lua`
- **Reference:** `script-reference/jukebox/utils.lua.md`
- **Source SHA-256 prefix:** `5acb20c02354`

## Source header notes

- utils.lua
- Helper functions for OS detection, file listing, and string splitting.

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `utils.splitter` | `inputstr, sep` |
| `utils.get_os` | `` |
| `utils.listFiles` | `directory` |
| `utils.listFilesDetailed` | `directory` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
