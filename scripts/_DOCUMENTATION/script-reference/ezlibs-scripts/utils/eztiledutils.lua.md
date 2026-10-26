# `ezlibs-scripts/utils/eztiledutils.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/utils/eztiledutils.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

tiled_utils.lua Shared helpers for Tiled property access. Replaces local helpers in: * eznpcs.lua / eznpcs/dialogue_types.lua  (is_property_true) * FootBomb                                  (as_string / as_number) * ezpushback.lua                            (truthy / number_property) Runtime properties live at object.custom_properties (the shape used throughout ezlibs). For forward compatibility, object.properties is also accepted in both map form (name -> value) and array form (name/type/value entries). This module requires nothing, so it is safe to require from leaf files such as dialogue_types.lua without creating circular dependencies.

## Module location

- **Source:** `ezlibs-scripts/utils/eztiledutils.lua`
- **Reference:** `script-reference/ezlibs-scripts/utils/eztiledutils.lua.md`
- **Source SHA-256 prefix:** `e842ed7591a0`

## Source header notes

- tiled_utils.lua
- Shared helpers for Tiled property access.
- Replaces local helpers in:
- * eznpcs.lua / eznpcs/dialogue_types.lua  (is_property_true)
- * FootBomb                                  (as_string / as_number)
- * ezpushback.lua                            (truthy / number_property)

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `M.is_true` | `value, default` |
| `M.to_number` | `value, default` |
| `M.to_string` | `value, default` |
| `raw_lookup` | `obj, name` |
| `M.get_property` | `obj, name, default` |
| `M.get_string` | `obj, name, default` |
| `M.get_number` | `obj, name, default` |
| `M.get_boolean` | `obj, name, default` |
| `M.get_object_reference` | `obj, name, resolver, default` |
| `M.get_class_or_type` | `obj` |
| `M.get_string_from` | `props, name, default` |
| `M.get_number_from` | `props, name, default` |
| `M.get_boolean_from` | `props, name, default` |
| `M.normalize_properties` | `obj` |
| `M.validate_properties` | `obj, schema_props, enums` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
