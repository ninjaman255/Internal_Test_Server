# `libs/emotions.lua`

> **Source reference**
>
> Refreshed from the current `libs/emotions.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Emotions source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `libs/emotions.lua`
- **Reference:** `script-reference/libs/emotions.lua.md`
- **Source SHA-256 prefix:** `8a965ebbafc3`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `NORMAL` | `0,` |
| `FULL_SYNCHRO` | `1,` |
| `ANGRY` | `2,` |
| `EVIL` | `3,` |
| `ANXIOUS` | `4,` |
| `TIRED` | `5,` |
| `EXHAUSTED` | `6,` |
| `PINCH` | `7,` |
| `FOCUS` | `8,` |
| `HAPPY` | `9,` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
