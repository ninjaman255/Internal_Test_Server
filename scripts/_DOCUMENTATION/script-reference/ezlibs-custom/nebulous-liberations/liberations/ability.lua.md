# `ezlibs-custom/nebulous-liberations/liberations/ability.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/liberations/ability.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

ability.lua

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/ability.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/ability.lua.md`
- **Source SHA-256 prefix:** `f8a6375b9b04`

## Source header notes

- ability.lua

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_encounters` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-custom/nebulous-liberations/liberations/constants` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `static_shape_generator` | `offset_x, offset_y, shape` |
| `liberate_and_loot` | `instance, player_session, results, remove_traps, destroy_items` |
| `panel_search` | `instance, player_session, results, remove_traps, destroy_items` |
| `initiate_encounter` | `instance, player_session` |
| `battle_to_liberate_and_loot` | `instance, player_session, r, remove_traps, destroy_items` |
| `Ability.resolve_for_player` | `player` |
| `activate` | `instance, player_session` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
