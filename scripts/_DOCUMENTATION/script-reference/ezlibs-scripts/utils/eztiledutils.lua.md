# `ezlibs-scripts/utils/eztiledutils.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/utils/eztiledutils.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

tiled_utils.lua Shared helpers for Tiled property access. Replaces local helpers in: * eznpcs.lua / eznpcs/dialogue_types.lua  (is_property_true) * FootBomb                                  (as_string / as_number) * ezpushback.lua                            (truthy / number_property) Runtime properties live at object.custom_properties (the shape used throughout ezlibs). For forward compatibility, object.properties is also accepted in both map form (name -> value) and array form (name/type/value entries). This module requires nothing, so it is safe to require from leaf files such as dialogue_types.lua without creating circular dependencies.

## Module location

- **Source:** `ezlibs-scripts/utils/eztiledutils.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/utils/eztiledutils.lua.md`

## Functions defined in this file

| Function | Notes |
|---|---|
| `M.get_boolean` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.get_boolean_from` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.get_class_or_type` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.get_number` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.get_number_from` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.get_object_reference` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.get_property` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.get_string` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.get_string_from` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.is_true` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.normalize_properties` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.to_number` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.to_string` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `M.validate_properties` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `raw_lookup` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 316 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
