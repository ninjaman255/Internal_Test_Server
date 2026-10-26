# `boom/main.lua`

> **Source reference**
>
> Refreshed from the current `boom/main.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[@module boom

## Module location

- **Source:** `boom/main.lua`
- **Reference:** `script-reference/boom/main.lua.md`
- **Source SHA-256 prefix:** `17ef6279a1af`

## Source header notes

- [[@module boom

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `warn` | `message` |
| `cleanstr` | `value` |
| `parse_attributes` | `line, convert_numbers, frame_rate` |
| `valid_state` | `animation, state_name, operation` |
| `make_animation` | `version` |
| `animation.get_state` | `self, name` |
| `animation.get_frame` | `self, name, frame_index` |
| `animation.get_point` | `self, name, frame_index, label` |
| `animation.duration` | `self, name` |
| `animation.get_duration` | `self, name` |
| `animation.refresh` | `self, name` |
| `animation.update` | `self, name, seconds` |
| `read_lines` | `path` |
| `parse_v20` | `lines, path` |
| `parse_v25` | `lines, path` |
| `boom.load` | `path` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
