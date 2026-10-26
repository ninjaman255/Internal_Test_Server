# `libs/emotes.lua`

> **Source reference**
>
> Refreshed from the current `libs/emotes.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Emotes source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `libs/emotes.lua`
- **Reference:** `script-reference/libs/emotes.lua.md`
- **Source SHA-256 prefix:** `d05c61d450f1`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `HAPPY` | `0,` |
| `BLANK` | `1,` |
| `MAD` | `2,` |
| `SAD` | `3,` |
| `SMUG` | `4,` |
| `SHOCKED` | `5,` |
| `COB` | `6,` |
| `PVP` | `7,` |
| `ZZZ` | `8,` |
| `KEY` | `9,` |
| `QUESTION` | `10,` |
| `ALERT` | `11,` |
| `HEART` | `12,` |
| `LOL` | `14,` |
| `YES` | `15,` |
| `VOMIT` | `17,` |
| `COOL` | `18,` |
| `UNCOOL` | `19,` |
| `SPIRIT` | `20,` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
