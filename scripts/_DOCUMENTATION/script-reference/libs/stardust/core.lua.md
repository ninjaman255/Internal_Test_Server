# `libs/stardust/core.lua`

> **Source reference**
>
> Refreshed from the current `libs/stardust/core.lua` file in `internal_test_server.zip` on 2026-10-25. This page is derived from source inspection; it does not imply runtime testing.

## Purpose

[[

## Module location

- **Source:** `libs/stardust/core.lua`
- **Reference:** `script-reference/libs/stardust/core.lua.md`
- **Source SHA-256 prefix:** `6c4081363103`

## Source header notes

- [[

## `Net:on` subscriptions

| Event |
|---|
| `tick` |

## Function declarations

These signatures are extracted from the current source. Local helpers are included; their presence does not make them public API.

| Function | Parameters as declared |
|---|---|
| `linear` | `x` |
| `square` | `x` |
| `cubic` | `x` |
| `t.config` | `self, opts` |
| `t.spawn` | `self, a, b` |
| `t.frames` | `self, a, b` |
| `t.start_x` | `self, a, b` |
| `t.start_y` | `self, a, b` |
| `t.vel_x` | `self, a, b, mode` |
| `t.vel_y` | `self, a, b, mode` |
| `t.acc_x` | `self, a, b, mode` |
| `t.acc_y` | `self, a, b, mode` |
| `t.scl_x` | `self, a, b, mode` |
| `t.scl_y` | `self, a, b, mode` |
| `t.ach` | `self, a, b, mode` |
| `t.rch` | `self, a, b, mode` |
| `t.gch` | `self, a, b, mode` |
| `t.bch` | `self, a, b, mode` |
| `t.fco_x` | `self, a, b` |
| `t.fco_y` | `self, a, b` |
| `t.delay` | `self, a, b` |
| `t.limit` | `self, limit` |
| `t.rand_fco` | `self` |
| `t.rand_acc` | `self` |
| `t.rand_vel` | `self` |
| `t.rand_pos` | `self` |
| `t.rand_scl` | `self` |
| `t.rand_cnt` | `self` |
| `t.rand_rot` | `self` |
| `t.rand_ach` | `self` |
| `t.rand_rch` | `self` |
| `t.rand_gch` | `self` |
| `t.rand_bch` | `self` |
| `t.rand_spn` | `self` |
| `t.rand_del` | `self` |
| `t.tick` | `self` |
| `t.apply` | `self, force` |
| `t.build` | `self` |
| `t.destroy` | `self` |
| `t.gen` | `self, count` |
| `t.for_each` | `self, fn` |

## Engine `Net` calls

The following member names occur in this file; this is an inventory of call sites, not an independent engine API specification.

`on`

## Usage and maintenance notes

- Treat the source file as authoritative if this inventory and implementation disagree.
- Confirm callers and initialization order before changing exported names or event lifecycles.
- Engine-provided globals and APIs are not defined by Lua 5.2 itself.
