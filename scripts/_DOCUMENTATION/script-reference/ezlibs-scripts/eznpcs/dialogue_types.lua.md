# `ezlibs-scripts/eznpcs/dialogue_types.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/eznpcs/dialogue_types.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Dialogue types source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/eznpcs/dialogue_types.lua`
- **Reference:** `script-reference/ezlibs-scripts/eznpcs/dialogue_types.lua.md`
- **Source SHA-256 prefix:** `7c883aeb75f8`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/ezquests` |
| `scripts/ezlibs-scripts/ezemail` |
| `scripts/ezlibs-scripts/condition` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/ezencounters/main` |
| `scripts/ezlibs-scripts/ezexplosions` |
| `scripts/ezlibs-scripts/utils/eztiledutils` |

## `Net:on` subscriptions

| Event |
|---|
| `tick` |
| `battle_results` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `now` | `` |
| `player_won_from_stats` | `stats` |
| `merge_result_fields` | `stats, exit_results` |
| `has_asset` | `path` |
| `ensure_ext` | `p, ext` |
| `resolve_texture` | `raw` |
| `resolve_anim` | `raw` |
| `action` | `npc, player_id, dialogue, relay_object` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`, `get_player_area`, `has_asset`, `is_player`, `kick_player`, `unlock_player_input`, `is_player_battling`

## Engine `Async` calls

`sleep`, `message_player`, `question_player`, `quiz_player`, `prompt_player`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `RESULT_FIELDS` | `{` |
| `MUG_DIR` | `"/server/assets/ezlibs-assets/eznpcs/mug/"` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/eznpcs/mug/` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
