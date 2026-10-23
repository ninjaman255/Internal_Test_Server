# `ezlibs-scripts/ezannounce.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezannounce.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-scripts/ezannounce.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezannounce.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezemail` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `announcement_sent` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `_feed_signature` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_get_email_bucket` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_is_active` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_reload_feed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezannounce.broadcast_missing_to_online` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezannounce.get_feed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezannounce.send_missing` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezannounce.start_watch` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `loop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 199 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
