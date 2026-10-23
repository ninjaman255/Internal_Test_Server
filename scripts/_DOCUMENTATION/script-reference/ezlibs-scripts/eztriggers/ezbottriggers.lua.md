# `ezlibs-scripts/eztriggers/ezbottriggers.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/eztriggers/ezbottriggers.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

ezbottriggers.lua Bot-only variant of eztriggers. Mirrors the rectangle/ellipse trigger API of eztriggers, but tracks bots instead of players. It does not touch eztriggers or its player-only state, so the two modules can be used side by side on the same source objects. Fed by eznpcs via ezbus events: bot_created { bot_id, area_id, x, y, z } bot_moved   { bot_id, area_id, x, y, z } bot_removed { bot_id } Each returned emitter fires: entered  { bot_id = ..., object = ..., reason = ..., x, y, z } departed { bot_id = ..., object = ..., reason = ..., x, y, z } The x/y/z values describe the position that caused the transition, so listeners can reconcile overlapping triggers without any Net lookup.

## Module location

- **Source:** `ezlibs-scripts/eztriggers/ezbottriggers.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/eztriggers/ezbottriggers.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `bot_created` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `bot_moved` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `bot_removed` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `ezbottriggers.add_radius_trigger` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbottriggers.add_rectangle_trigger` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbottriggers.clear_radius_overlaps_for_bot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbottriggers.clear_rectangle_overlaps_for_bot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbottriggers.handle_bot_created` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbottriggers.handle_bot_move` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezbottriggers.handle_bot_removed` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_trigger_key` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_bot_overlap` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 292 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
