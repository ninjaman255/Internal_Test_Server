# `example_pvp_script.lua`

> **Source reference**
>
> Generated from `example_pvp_script.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `example_pvp_script.lua`
- **Relative reference:** `script-reference/example_pvp_script.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `scripts/persistence/logger` | Import string found in source; runtime resolution depends on the server package layout. |

## Net event subscriptions

| Event | Evidence |
|---|---|
| `actor_interaction` | `Net:on(...)` subscription found in source. |
| `player_connect` | `Net:on(...)` subscription found in source. |
| `player_disconnect` | `Net:on(...)` subscription found in source. |
| `textbox_response` | `Net:on(...)` subscription found in source. |
| `tile_interaction` | `Net:on(...)` subscription found in source. |

## Source notes

- Approximate source size: 105 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
