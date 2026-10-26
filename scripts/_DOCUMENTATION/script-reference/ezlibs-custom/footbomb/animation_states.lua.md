# `ezlibs-custom/footbomb/animation_states.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/footbomb/animation_states.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Animation states shared by FootBomb's Navi assets. These names are intentionally centralized: update the roster animation files and this list together when the game adds or renames a state.

## Module location

- **Source:** `ezlibs-custom/footbomb/animation_states.lua`
- **Reference:** `script-reference/ezlibs-custom/footbomb/animation_states.lua.md`
- **Source SHA-256 prefix:** `656e5e39d071`

## Source header notes

- Animation states shared by FootBomb's Navi assets.
- These names are intentionally centralized: update the roster animation
- files and this list together when the game adds or renames a state.

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `IDLE_D` | `"IDLE_D",` |
| `IDLE_UR` | `"IDLE_UR",` |
| `IDLE_U` | `"IDLE_U",` |
| `WALK_U` | `"WALK_U",` |
| `WALK_UR` | `"WALK_UR",` |
| `FOOTBOMB_IDLE_DEFENSE` | `"FOOTBOMB_IDLE_DEFENSE",` |
| `FOOTBOMB_READY_DEFENSE` | `"FOOTBOMB_READY_DEFENSE",` |
| `FOOTBOMB_JUMP_RIGHT` | `"FOOTBOMB_JUMP_RIGHT",` |
| `FOOTBOMB_JUMP_RIGHT_END` | `"FOOTBOMB_JUMP_RIGHT_END",` |
| `FOOTBOMB_JUMP_LEFT` | `"FOOTBOMB_JUMP_LEFT",` |
| `FOOTBOMB_JUMP_LEFT_END` | `"FOOTBOMB_JUMP_LEFT_END",` |
| `BOMB_PREVIEW` | `"Preview",` |
| `SMALL_BOMB` | `"Small-Bomb",` |
| `BIG_BOMB` | `"Big-Bomb",` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
