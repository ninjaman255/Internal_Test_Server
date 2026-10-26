# `HP_Manager/constants/constants.lua`

> **Source reference**
>
> Refreshed from the current `HP_Manager/constants/constants.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Constants source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `HP_Manager/constants/constants.lua`
- **Reference:** `script-reference/HP_Manager/constants/constants.lua.md`
- **Source SHA-256 prefix:** `c0af0ace954b`

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `file_exists` | `path` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `assets/Backgrounds/` |
| `/server/assets/Backgrounds/` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
