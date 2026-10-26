# `ezlibs-scripts/ezannounce/ezannounce.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezannounce/ezannounce.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Ezannounce source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezannounce/ezannounce.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezannounce/ezannounce.lua.md`
- **Source SHA-256 prefix:** `50723a25e2f9`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/ezemail` |
| `scripts/ezlibs-scripts/ezbus` |

## `Net:on` subscriptions

| Event |
|---|
| `player_disconnect` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `_get_email_bucket` | `player_id` |
| `_is_active` | `ann, now` |
| `_feed_signature` | `feed` |
| `_reload_feed` | `` |
| `ezannounce.get_feed` | `` |
| `ezannounce.send_missing` | `player_id` |
| `ezannounce.broadcast_missing_to_online` | `` |
| `ezannounce.start_watch` | `interval` |
| `loop` | `` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`

## Engine `Async` calls

`sleep`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `FEED_MODULE` | `'scripts/ezlibs-scripts/ezannounce/announcements_feed'` |
| `POLL_SECONDS` | `10` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/eznpcs/mug/denpa-warp-sf2.png` |
| `/server/assets/ezlibs-assets/eznpcs/mug/mug.animation` |
| `/server/assets/ezlibs-assets/eznpcs/mug/luigi-idle.png` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
