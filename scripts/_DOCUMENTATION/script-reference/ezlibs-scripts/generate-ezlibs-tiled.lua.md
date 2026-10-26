# `ezlibs-scripts/generate-ezlibs-tiled.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/generate-ezlibs-tiled.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

generate-ezlibs-tiled.lua Generates three artifacts from a single source of truth: ezlibs-tiled-types.json    — Tiled project types (unchanged shape; metadata fields are stripped so Tiled doesn't see anything it might reject). ezlibs-tiled-schema.lua    — Runtime schema including category/required/ description/dependsOn metadata, consumed by tiled_utils.validate_properties. ezlibs-tiled-reference.md  — Map-maker reference generated from the same metadata, grouped by category, with a conditional-properties section per class. Run with: lua generate-ezlibs-tiled.lua [output_path_for_types_json] Where each file goes: * types.json       — wherever output_path points (default: cwd). * schema.lua

## Module location

- **Source:** `ezlibs-scripts/generate-ezlibs-tiled.lua`
- **Reference:** `script-reference/ezlibs-scripts/generate-ezlibs-tiled.lua.md`
- **Source SHA-256 prefix:** `da3f457a6bdc`

## Source header notes

- generate-ezlibs-tiled.lua
- Generates three artifacts from a single source of truth:
- ezlibs-tiled-types.json    — Tiled project types (unchanged shape;
- metadata fields are stripped so Tiled
- doesn't see anything it might reject).
- ezlibs-tiled-schema.lua    — Runtime schema including category/required/

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/json` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `prop` | `name, typ, default, enumName` |
| `validate_schema` | `` |
| `err` | `fmt, ...` |
| `strip_member` | `p` |
| `strip_class_members` | `members` |
| `build_tiled_types` | `` |
| `lua_quote` | `s` |
| `serialize_value` | `v, indent` |
| `merge_member_meta` | `ot, p` |
| `build_schema_lua` | `` |
| `w` | `s` |
| `md_escape` | `s` |
| `fmt_default` | `v` |
| `fmt_type` | `p` |
| `category_of` | `ot_name, p` |
| `required_of` | `ot_name, p` |
| `description_of` | `ot_name, p` |
| `conditional_of` | `ot_name, p` |
| `build_reference_md` | `` |
| `dirname` | `p` |
| `script_dirname` | `` |
| `main` | `output_path, pretty` |

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `META` | `{` |
| `METADATA_FIELDS` | `{` |
| `CATEGORY_ORDER` | `{` |

## Literal asset/path strings

Paths can be built dynamically elsewhere; this section includes only matching literal strings in this file.

| Path |
|---|
| `/server/assets/ezlibs-assets/sfx/panel_change.ogg` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
