# `ezlibs-scripts/ezencounters/main.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/ezencounters/main.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-scripts/ezencounters/main.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/ezencounters/main.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/ezlibs-scripts/ezbus` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezconfig` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezlogger` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezmemory` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/eztriggers/eztriggers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/ezwarps/main` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/helpers` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/object_registry` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `battle_results` | `Net:on(...)` subscription found in source. |

## Event-bus event names

| Event | Evidence |
|---|---|
| `encounter_finished` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |
| `encounter_started` | Bus operation found in source. Confirm direction/payload in implementation before relying on it. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `ezencounters.begin_encounter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezencounters.begin_encounter_by_name` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezencounters.clear_last_position` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezencounters.clear_tiles_since_encounter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezencounters.handle_player_disconnect` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezencounters.handle_player_move` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezencounters.increment_steps_since_encounter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezencounters.pick_encounter_from_table` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ezencounters.try_random_encounter` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `load_encounters_for_areas` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `on_radius_encounter_triggered` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `should_record_step` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 241 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
