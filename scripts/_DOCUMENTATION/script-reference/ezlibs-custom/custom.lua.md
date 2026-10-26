# `ezlibs-custom/custom.lua`

> **Source reference**
>
> Refreshed from the current `ezlibs-custom/custom.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

Custom plugin aggregator. Keep custom gameplay modules here so ezlibs' main dispatcher can fan out event callbacks to each module without duplicate Net:on subscriptions.

## Module location

- **Source:** `ezlibs-custom/custom.lua`
- **Reference:** `script-reference/ezlibs-custom/custom.lua.md`
- **Source SHA-256 prefix:** `62aec92f0c92`

## Source header notes

- Custom plugin aggregator.
- Keep custom gameplay modules here so ezlibs' main dispatcher can fan out
- event callbacks to each module without duplicate Net:on subscriptions.

## Direct `require` dependencies

| Import path |
|---|
| `scripts/ezlibs-scripts/ezbus` |
| `scripts/ezlibs-custom/endless-runner/endless-runner` |
| `scripts/ezlibs-custom/nebulous-liberations/main` |
| `scripts/ezlibs-custom/footbomb/main` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `dispatch` | `method_name, ...` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`

## Selected uppercase constants

| Name | Source expression |
|---|---|
| `ENDLESS_RUNNER_BASE_AREA` | `"endless-runner"` |
| `ENDLESS_RUNNER_FLOOR_PLAN` | `{` |
| `ENDLESS_RUNNER_ENTER_OPTIONS` | `{` |

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
