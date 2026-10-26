# `ezlibs-custom/footbomb/result_timeline.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/footbomb/result_timeline.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Pure timing helpers for FootBomb's result sequence. This module deliberately does not animate actors or wait on async tasks; it calculates timing boundaries from authored animation data and gameplay travel estimates so callers can coordinate their own event-driven tracks.

## Module location

- **Source:** `ezlibs-custom/footbomb/result_timeline.lua`
- **Reference:** `script-reference/ezlibs-custom/footbomb/result_timeline.lua.md`
- **Source SHA-256 prefix:** `1b51ed585de1`

## Source header notes

- Pure timing helpers for FootBomb's result sequence.
- This module deliberately does not animate actors or wait on async tasks;
- it calculates timing boundaries from authored animation data and gameplay
- travel estimates so callers can coordinate their own event-driven tracks.

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `ResultTimeline.state_timing` | `state` |
| `ResultTimeline.shared_response_duration` | `options` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
