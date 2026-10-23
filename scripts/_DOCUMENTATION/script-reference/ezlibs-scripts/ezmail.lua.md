# `ezlibs-scripts/ezmail.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezmail.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-scripts/ezmail.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezmail.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezannounce/ezannounce` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezconfig` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `email_read` | `Net:on(...)` subscription found in source. |
| `player_join` | `Net:on(...)` subscription found in source. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `email_sent` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `_dbg` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_find_mail_in_bucket` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_get_bucket` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_get_tombstone_set` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_mark_email_read` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_notify_new_mail` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_percent_decode` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `_preload_email_assets` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezemail.resend_all` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezemail.send_once` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezemail.send_temp` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezemail.send_test_email` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `send_msg` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 340 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
