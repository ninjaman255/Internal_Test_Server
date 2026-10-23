# `ezlibs-scripts/generate-ezlibs-tiled.lua`

> **Source reference**
>
> Generated from `ezlibs-scripts/generate-ezlibs-tiled.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

generate-ezlibs-tiled.lua Generates three artifacts from a single source of truth: ezlibs-tiled-types.json    — Tiled project types (unchanged shape; metadata fields are stripped so Tiled doesn't see anything it might reject). ezlibs-tiled-schema.lua    — Runtime schema including category/required/ description/dependsOn metadata, consumed by tiled_utils.validate_properties. ezlibs-tiled-reference.md  — Map-maker reference generated from the same metadata, grouped by category, with a conditional-properties section per class. Run with: lua generate-ezlibs-tiled.lua [output_path_for_types_json] Where each file goes: * types.json       — wherever output_path points (default: cwd). * schema.lua  

## Module location

- **Source:** `ezlibs-scripts/generate-ezlibs-tiled.lua`
- **Relative reference:** `script-reference/ezlibs-scripts/generate-ezlibs-tiled.lua.md`

## Direct `require` dependencies

| Import path | Notes |
|---|---|
| `...generate-ezlibs-tiled` | Import string found in source; runtime resolution depends on the server package layout. |
| `scripts/ezlibs-scripts/json` | Import string found in source; runtime resolution depends on the server package layout. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `build_reference_md` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `build_schema_lua` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `build_tiled_types` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `category_of` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `conditional_of` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `description_of` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `dirname` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `err` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `fmt_default` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `fmt_type` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `lua_quote` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `main` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `md_escape` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `merge_member_meta` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `prop` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `required_of` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `script_dirname` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `serialize_value` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `strip_class_members` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `strip_member` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `validate_schema` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `w` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 1848 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
