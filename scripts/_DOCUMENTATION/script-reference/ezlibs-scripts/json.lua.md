# `ezlibs-scripts/json.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-scripts/json.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

json.lua Copyright (c) 2020 rxi Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITE

## Module location

- **Source:** `ezlibs-scripts/json.lua`
- **Reference:** `script-reference/ezlibs-scripts/json.lua.md`
- **Source SHA-256 prefix:** `3ee318e52d99`

## Source header notes

- json.lua
- Copyright (c) 2020 rxi
- Permission is hereby granted, free of charge, to any person obtaining a copy of
- this software and associated documentation files (the "Software"), to deal in
- the Software without restriction, including without limitation the rights to
- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `escape_char` | `c` |
| `encode_nil` | `...` |
| `encode_table` | `val, stack, indent_unit, level` |
| `encode_string` | `val, ...` |
| `encode_number` | `val, ...` |
| `json.encode` | `val, pretty` |
| `create_set` | `...` |
| `next_char` | `str, idx, set, negate` |
| `decode_error` | `str, idx, msg` |
| `codepoint_to_utf8` | `n` |
| `parse_unicode_escape` | `s` |
| `parse_string` | `str, i` |
| `parse_number` | `str, i` |
| `parse_literal` | `str, i` |
| `parse_array` | `str, i` |
| `parse_object` | `str, i` |
| `json.decode` | `str` |
| `encode` | `val, stack, indent_unit, level` |
| `parse` | `str, idx` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
