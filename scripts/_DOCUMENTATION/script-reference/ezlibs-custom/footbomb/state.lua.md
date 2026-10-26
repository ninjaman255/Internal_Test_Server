# `ezlibs-custom/footbomb/state.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/footbomb/state.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

FootBomb state store. Mutable match/NPC/player registries live here instead of in the entry point. Keep this module data-only so main.lua remains responsible for game behavior.

## Module location

- **Source:** `ezlibs-custom/footbomb/state.lua`
- **Reference:** `script-reference/ezlibs-custom/footbomb/state.lua.md`
- **Source SHA-256 prefix:** `c2fbdef6e96a`

## Source header notes

- FootBomb state store.
- Mutable match/NPC/player registries live here instead of in the entry point.
- Keep this module data-only so main.lua remains responsible for game behavior.

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
