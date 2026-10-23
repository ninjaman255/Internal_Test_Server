# `libs/stardust/core.lua`

> **Source reference**
>
> Generated from `libs/stardust/core.lua` in the supplied `scripts_internal_test_server.zip` archive (inspected 2026-10-23). This is a source-based reference, not a claim of live runtime testing.

## Purpose

[[

## Module location

- **Source:** `libs/stardust/core.lua`
- **Relative reference:** `script-reference/libs/stardust/core.lua.md`

## Net event subscriptions

| Event | Evidence |
|---|---|
| `tick` | `Net:on(...)` subscription found in source. |

## Functions defined in this file

| Function | Notes |
|---|---|
| `cubic` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_config` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_val_or` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `ensure_vector_or` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `lerp_integer` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `lerp_scalar` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `lerp_vec` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `linear` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `rand_scalar` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `rand_vec` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `resolve_mode` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `respawn` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `square` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `system` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.acc_x` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.acc_y` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.ach` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.apply` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.bch` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.build` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.config` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.delay` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.destroy` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.fco_x` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.fco_y` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.for_each` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.frames` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.gch` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.gen` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.limit` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rand_acc` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rand_ach` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rand_bch` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rand_cnt` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rand_del` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rand_fco` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rand_gch` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rand_pos` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rand_rch` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rand_rot` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rand_scl` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rand_spn` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rand_vel` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.rch` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.scl_x` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.scl_y` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.spawn` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.start_x` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.start_y` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.tick` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.vel_x` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `t.vel_y` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `tick_ani` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `vec_one` | Defined in this file; inspect implementation for arguments, return values, and side effects. |
| `vec_zero` | Defined in this file; inspect implementation for arguments, return values, and side effects. |

## Source notes

- Approximate source size: 625 lines.
- Tables above are extracted from source patterns. A function may be assigned dynamically or exported under another name and therefore not appear in the function list.
- Verify external engine APIs, asset availability, lifecycle ordering, and runtime behavior in the target server before changing integration code.

## Related documentation

- [Documentation index](../index.md)
- [Scripts tree reference](../scripts-tree.md)
- [Assets and file paths](../assets-and-file-paths.md)
