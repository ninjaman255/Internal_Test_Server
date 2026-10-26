# `ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua`

> **Source reference**
>
> Generated from `ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Module location

- **Source:** `ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua`
- **Relative reference:** `script-reference/ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua.md`

## Functions defined in this file

| Function | Notes |
|---|---|
| `PanelEncounters.resolve_terrain` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `has_dark_panel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `includes` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 56 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)

## Encounter Definition Integration

- The default `Liberation Encounters` area custom property is indexed by the **base `area_id`**, not the cloned mission instance ID and not merely the display area name.
- `resolve_encounter_value(reference)` uses `ezencounters.resolve_encounter` so named encounter definitions registered in the normal ezencounters tables can be used. If the reference is not a registered name, it is retained as a direct package path for compatibility.
- `resolve_encounter(base_area_id)` resolves the default encounter configured on the source map. `Mission` stores `base_area_id` separately from its instance `area_id` and uses the former for this lookup.
- `resolve_terrain` is still NebuLibs-specific; it computes the liberation player's terrain advantage and is merged into the encounter definition data at encounter start.
