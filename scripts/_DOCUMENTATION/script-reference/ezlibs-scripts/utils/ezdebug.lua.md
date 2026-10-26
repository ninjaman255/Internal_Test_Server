# `ezlibs-scripts/utils/ezdebug.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/utils/ezdebug.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ezdebug.lua Small logger wrapper. By default it writes to standard output. Host-specific logging can be supplied as a callback.

## Module location

- **Source:** `ezlibs-scripts/utils/ezdebug.lua`
- **Reference:** `script-reference/ezlibs-scripts/utils/ezdebug.lua.md`
- **Source SHA-256 prefix:** `bfba714f5492`

## Source header notes

- ezdebug.lua
- Small logger wrapper. By default it writes to standard output.
- Host-specific logging can be supplied as a callback.

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ezdebug.configure` | `options` |
| `write` | `level, ...` |
| `ezdebug.info` | `...` |
| `ezdebug.warn` | `...` |
| `ezdebug.error` | `...` |
| `ezdebug.traceback` | `message, level` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
