# `ezlibs-scripts/ezmail.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/ezmail.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Ezmail source module. See the declarations and call sites below for its current responsibilities.

## Module location

- **Source:** `ezlibs-scripts/ezmail.lua`
- **Reference:** `script-reference/ezlibs-scripts/ezmail.lua.md`
- **Source SHA-256 prefix:** `d0681d5f9da7`

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezlogger` |
| `scripts/ezlibs-scripts/helpers` |
| `scripts/ezlibs-scripts/ezmemory` |
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-scripts/ezconfig` |
| `scripts/ezlibs-scripts/ezannounce/ezannounce` |

## `Net:on` subscriptions

| Event |
|---|
| `player_join` |
| `email_read` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `_preload_email_assets` | `player_id, mail` |
| `_get_bucket` | `player_id` |
| `_dbg` | `...` |
| `_percent_decode` | `s` |
| `_get_tombstone_set` | `` |
| `_find_mail_in_bucket` | `bucket, email_id` |
| `_mark_email_read` | `player_id, email_id` |
| `_notify_new_mail` | `player_id, msg, delay_seconds` |
| `send_msg` | `` |
| `ezemail.resend_all` | `player_id` |
| `ezemail.send_once` | `player_id, mail, opts` |
| `ezemail.send_temp` | `player_id, mail, opts` |
| `ezemail.send_test_email` | `player_id, delay_seconds` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`provide_asset_for_player`, `ring_player_hud`, `message_player`, `get_player_mugshot`, `send_player_email`, `on`

## Engine `Async` calls

`sleep`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `CONFIG` | `require('scripts/ezlibs-scripts/ezconfig')` |
| `NEW_MAIL_MESSAGE_DELAY` | `CONFIG.NEW_MAIL_MESSAGE_DELAY or 1.5        -- seconds: wait after ring before message_...` |
| `ENABLE_TEST_EMAIL_ON_JOIN` | `false    -- set false after you finish tuning` |
| `TEST_EMAIL_DELAY` | `2.0              -- seconds (start same as NEW_MAIL_MESSAGE_DELAY)` |
| `EZEMAIL_DEBUG` | `true -- set false after verified` |
| `ANNOUNCEMENTS_FEED_MODULE` | `'scripts/ezlibs-scripts/announcements_feed'` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/eznpcs/mug/denpa-warp-sf2.png` |
| `/server/assets/ezlibs-assets/eznpcs/mug/mug.animation` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
