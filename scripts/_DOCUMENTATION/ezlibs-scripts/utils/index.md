# 📁 ezlibs-scripts/utils

[🏠 Documentation home](../../index.md) · [⬆ Parent folder](../index.md)

## 🗂️ Contents
- [📖 Guides & reference material](#guides--reference-material)

- [📚 Collection contents](#collection-contents)
- [🔎 Module API overview](#module-api-overview)
- [📊 Collection summary](#collection-summary)

## 📚 Collection contents

| Type | Entry | Lua files | Functions | Tables | Source lines | Documentation |
|---|---|---|---|---|---|---|
| 📄 Script | `ezdebug.lua` | 1 | 6 | 2 | 47 | [Open script reference](ezdebug/index.md) |
| 📄 Script | `eztiledutils.lua` | 1 | 15 | 6 | 316 | [Open script reference](eztiledutils/index.md) |
| 📄 Script | `ezutil.lua` | 1 | 8 | 3 | 96 | [Open script reference](ezutil/index.md) |
| 📄 Script | `ezvalidate.lua` | 1 | 4 | 1 | 68 | [Open script reference](ezvalidate/index.md) |

## 🔎 Module API overview

Named, qualified functions detected in direct files in this folder. Check each linked script reference for **all local and assigned functions**, parameters, initializer tables, and line numbers. A qualified name alone does not establish external accessibility.

| Module | Qualified function / method | Source line | Reference |
|---|---|---|---|
| `ezdebug.lua` | `ezdebug.configure(options)` | 11 | [Details](ezdebug/index.md) |
| `ezdebug.lua` | `ezdebug.info(...)` | 39 | [Details](ezdebug/index.md) |
| `ezdebug.lua` | `ezdebug.warn(...)` | 40 | [Details](ezdebug/index.md) |
| `ezdebug.lua` | `ezdebug.error(...)` | 41 | [Details](ezdebug/index.md) |
| `ezdebug.lua` | `ezdebug.traceback(message, level)` | 43 | [Details](ezdebug/index.md) |
| `eztiledutils.lua` | `M.is_true(value, default)` | 33 | [Details](eztiledutils/index.md) |
| `eztiledutils.lua` | `M.to_number(value, default)` | 51 | [Details](eztiledutils/index.md) |
| `eztiledutils.lua` | `M.to_string(value, default)` | 65 | [Details](eztiledutils/index.md) |
| `eztiledutils.lua` | `M.get_property(obj, name, default)` | 121 | [Details](eztiledutils/index.md) |
| `eztiledutils.lua` | `M.get_string(obj, name, default)` | 127 | [Details](eztiledutils/index.md) |
| `eztiledutils.lua` | `M.get_number(obj, name, default)` | 131 | [Details](eztiledutils/index.md) |
| `eztiledutils.lua` | `M.get_boolean(obj, name, default)` | 135 | [Details](eztiledutils/index.md) |
| `eztiledutils.lua` | `M.get_object_reference(obj, name, resolver, default)` | 148 | [Details](eztiledutils/index.md) |
| `eztiledutils.lua` | `M.get_class_or_type(obj)` | 160 | [Details](eztiledutils/index.md) |
| `eztiledutils.lua` | `M.get_string_from(props, name, default)` | 174 | [Details](eztiledutils/index.md) |
| `eztiledutils.lua` | `M.get_number_from(props, name, default)` | 179 | [Details](eztiledutils/index.md) |
| `eztiledutils.lua` | `M.get_boolean_from(props, name, default)` | 184 | [Details](eztiledutils/index.md) |
| `eztiledutils.lua` | `M.normalize_properties(obj)` | 194 | [Details](eztiledutils/index.md) |
| `eztiledutils.lua` | `M.validate_properties(obj, schema_props, enums)` | 240 | [Details](eztiledutils/index.md) |
| `ezutil.lua` | `ezutil.clamp(value, minimum, maximum)` | 7 | [Details](ezutil/index.md) |
| `ezutil.lua` | `ezutil.table_contains(list, value)` | 18 | [Details](ezutil/index.md) |
| `ezutil.lua` | `ezutil.table_remove_value(list, value, remove_all)` | 26 | [Details](ezutil/index.md) |
| `ezutil.lua` | `ezutil.table_count(value)` | 44 | [Details](ezutil/index.md) |
| `ezutil.lua` | `ezutil.table_is_empty(value)` | 53 | [Details](ezutil/index.md) |
| `ezutil.lua` | `ezutil.shallow_copy(source)` | 58 | [Details](ezutil/index.md) |
| `ezutil.lua` | `ezutil.deep_copy(source, seen)` | 68 | [Details](ezutil/index.md) |
| `ezutil.lua` | `ezutil.table_merge(target, source)` | 85 | [Details](ezutil/index.md) |
| `ezvalidate.lua` | `ezvalidate.is_type(value, expected_type)` | 6 | [Details](ezvalidate/index.md) |
| `ezvalidate.lua` | `ezvalidate.number_range(value, minimum, maximum)` | 11 | [Details](ezvalidate/index.md) |
| `ezvalidate.lua` | `ezvalidate.required_fields(value, fields)` | 33 | [Details](ezvalidate/index.md) |
| `ezvalidate.lua` | `ezvalidate.table_field_types(value, expected)` | 49 | [Details](ezvalidate/index.md) |

## 📊 Collection summary

This folder subtree contains **4 Lua source files**, **33 named/assigned function detections**, and **12 table initializer detections**.

Counts represent static matching of archived code and may omit anonymous closures or dynamic table construction.

## 📖 Guides & reference material

| Document | Description |
|---|---|
| [📘 `README.md`](README.md) | Utility modules |
