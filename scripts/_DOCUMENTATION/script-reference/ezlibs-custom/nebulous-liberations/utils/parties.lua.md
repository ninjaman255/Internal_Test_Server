# `ezlibs-custom/nebulous-liberations/utils/parties.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/nebulous-liberations/utils/parties.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Parties source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/utils/parties.lua`
- **Reference:** `script-reference/ezlibs-custom/nebulous-liberations/utils/parties.lua.md`
- **Source SHA-256 prefix:** `63a330050002`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/libs/emotes` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `internal_find` | `player_id` |
| `Parties.find` | `player_id` |
| `Parties.is_in_same_party` | `player_a, player_b` |
| `Parties.on_tick` | `elapsed` |
| `Parties.request` | `requester, recruit` |
| `internal_find_request` | `requester, recruit` |
| `Parties.has_request` | `recruit, requester` |
| `Parties.accept` | `recruit, requester` |
| `Parties.leave` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`exclusive_player_emote`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `REQUEST_EMOTE` | `Emotes.QUESTION` |
| `ACCEPT_EMOTE` | `Emotes.HAPPY` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
