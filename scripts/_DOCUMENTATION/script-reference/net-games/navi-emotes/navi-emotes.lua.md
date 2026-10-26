# `net-games/navi-emotes/navi-emotes.lua`

> **Source reference**
>
> Refreshed from the current `net-games/navi-emotes/navi-emotes.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Navi emotes source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `net-games/navi-emotes/navi-emotes.lua`
- **Reference:** `script-reference/net-games/navi-emotes/navi-emotes.lua.md`
- **Source SHA-256 prefix:** `6d1e807314e5`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/net-games/main` |

## `Net:on` subscriptions

| Event |
|---|
| `player_join` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `NaviEmotes.activate` | `player_id` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`lock_player_input`, `on`

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `assets/card.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
