# `jukebox/constants/paths.lua`

> **Source reference**
>
> Refreshed from the current `jukebox/constants/paths.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Paths source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `jukebox/constants/paths.lua`
- **Reference:** `script-reference/jukebox/constants/paths.lua.md`
- **Source SHA-256 prefix:** `48e2cc175d80`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `assets/jukebox/records/` |
| `assets/jukebox/tracks/` |
| `assets/jukebox/ui-sprites/` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
