# `ezlibs-scripts/eztriggers/eztriggers.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/eztriggers/eztriggers.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-scripts/eztriggers/eztriggers.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/eztriggers/eztriggers.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/object_registry` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `eztriggers.add_event` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eztriggers.add_interact_trigger` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eztriggers.add_location_event_trigger` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eztriggers.add_radius_trigger` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eztriggers.add_rectangle_trigger` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eztriggers.clear_radius_overlaps_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eztriggers.clear_rectangle_overlaps_for_player` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eztriggers.handle_object_interaction` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eztriggers.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eztriggers.handle_player_move` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `eztriggers.handle_player_transfer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `is_button_trigger` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `set_player_overlap` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `tick_check_player_triggers` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 436 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
