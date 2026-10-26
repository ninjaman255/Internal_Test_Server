# `avatar_utils/base64.lua`

> **Source reference**
>
> Refreshed from the current `avatar_utils/base64.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `avatar_utils/base64.lua`
- **Reference:** `script-reference/avatar_utils/base64.lua.md`
- **Source SHA-256 prefix:** `bce7480e262b`

## Source header notes

- [[

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `base64.makeencoder` | `s62, s63, spad` |
| `base64.makedecoder` | `s62, s63, spad` |
| `base64.encode` | `str, encoder, usecaching` |
| `base64.decode` | `b64, decoder, usecaching` |
| `extract` | `v, from, width` |

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `DEFAULT_ENCODER` | `base64.makeencoder()` |
| `DEFAULT_DECODER` | `base64.makedecoder()` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
