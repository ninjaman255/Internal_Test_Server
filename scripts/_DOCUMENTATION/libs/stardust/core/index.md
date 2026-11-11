# 📄 `core.lua`

[🏠 Documentation home](../../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/libs/stardust/core.lua`](../../../../libs/stardust/core.lua)  
> **Source lines:** 625  
> **SHA-256 (UTF-8):** `6c408136310398…`  
> **Declared/assigned functions detected:** 55  
> **Anonymous closures detected:** 1  
> **Table initializers detected:** 15

## 🗂️ Contents

- [📌 Overview](#overview)
- [🔗 Dependencies](#dependencies)
- [📡 Event subscriptions](#event-subscriptions)
- [🧩 Functions](#functions)
- [🪄 Anonymous closures](#anonymous-closures)
- [📦 Tables and data](#tables-and-data)
- [⚙️ Runtime API calls](#runtime-api-calls)
- [🧪 Static-analysis notes](#static-analysis-notes)

## 📌 Overview

Source-based reference for `scripts/libs/stardust/core.lua`. No module-purpose prose was supplied in the leading source comments.

## 🔗 Dependencies

*No literal `require` module strings detected.*

## 📡 Event subscriptions

| Line | Subscription call | Literal event name |
|---|---|---|
| 618 | `Net:on` | `tick` |

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 37 | `linear` | `x` | assigned |
| 38 | `square` | `x` | assigned |
| 39 | `cubic` | `x` | assigned |
| 42 | `vec_one` | `(none)` | assigned |
| 49 | `vec_zero` | `(none)` | assigned |
| 56 | `ensure_val_or` | `c, val` | assigned |
| 64 | `ensure_vector_or` | `v, val` | assigned |
| 80 | `ensure_config` | `c` | assigned |
| 102 | `resolve_mode` | `m` | assigned |
| 110 | `system` | `opts` | assigned |
| 133 | `lerp_scalar` | `w, s1, s2` | assigned |
| 139 | `lerp_integer` | `w, s1, s2` | assigned |
| 143 | `lerp_vec` | `w1, w2, v1, v2` | assigned |
| 150 | `rand_scalar` | `s1, s2` | assigned |
| 154 | `rand_vec` | `v1, v2` | assigned |
| 158 | `respawn` | `sys, p` | assigned |
| 253 | `tick_ani` | `sys, p` | assigned |
| 317 | `t.config` | `self, opts` | assigned |
| 336 | `t.spawn` | `self, a, b` | assigned |
| 343 | `t.frames` | `self, a, b` | assigned |
| 350 | `t.start_x` | `self, a, b` | assigned |
| 357 | `t.start_y` | `self, a, b` | assigned |
| 364 | `t.vel_x` | `self, a, b, mode` | assigned |
| 373 | `t.vel_y` | `self, a, b, mode` | assigned |
| 382 | `t.acc_x` | `self, a, b, mode` | assigned |
| 391 | `t.acc_y` | `self, a, b, mode` | assigned |
| 400 | `t.scl_x` | `self, a, b, mode` | assigned |
| 409 | `t.scl_y` | `self, a, b, mode` | assigned |
| 418 | `t.ach` | `self, a, b, mode` | assigned |
| 427 | `t.rch` | `self, a, b, mode` | assigned |
| 436 | `t.gch` | `self, a, b, mode` | assigned |
| 445 | `t.bch` | `self, a, b, mode` | assigned |
| 454 | `t.fco_x` | `self, a, b` | assigned |
| 461 | `t.fco_y` | `self, a, b` | assigned |
| 468 | `t.delay` | `self, a, b` | assigned |
| 476 | `t.limit` | `self, limit` | assigned |
| 481 | `t.rand_fco` | `self` | assigned |
| 485 | `t.rand_acc` | `self` | assigned |
| 489 | `t.rand_vel` | `self` | assigned |
| 493 | `t.rand_pos` | `self` | assigned |
| 497 | `t.rand_scl` | `self` | assigned |
| 501 | `t.rand_cnt` | `self` | assigned |
| 505 | `t.rand_rot` | `self` | assigned |
| 510 | `t.rand_ach` | `self` | assigned |
| 514 | `t.rand_rch` | `self` | assigned |
| 518 | `t.rand_gch` | `self` | assigned |
| 522 | `t.rand_bch` | `self` | assigned |
| 526 | `t.rand_spn` | `self` | assigned |
| 530 | `t.rand_del` | `self` | assigned |
| 534 | `t.tick` | `self` | assigned |
| 566 | `t.apply` | `self, force` | assigned |
| 576 | `t.build` | `self` | assigned |
| 584 | `t.destroy` | `self` | assigned |
| 588 | `t.gen` | `self, count` | assigned |
| 606 | `t.for_each` | `self, fn` | assigned |

### Function details

#### 1. `linear(x)`

- **Location:** source line 37.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |

#### 2. `square(x)`

- **Location:** source line 38.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |

#### 3. `cubic(x)`

- **Location:** source line 39.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |

#### 4. `vec_one()`

- **Location:** source line 42.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 5. `vec_zero()`

- **Location:** source line 49.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 6. `ensure_val_or(c, val)`

- **Location:** source line 56.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `c` | Not explicitly documented in adjacent source annotations. |
| 2 | `val` | Not explicitly documented in adjacent source annotations. |

#### 7. `ensure_vector_or(v, val)`

- **Location:** source line 64.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `v` | Not explicitly documented in adjacent source annotations. |
| 2 | `val` | Not explicitly documented in adjacent source annotations. |

#### 8. `ensure_config(c)`

- **Location:** source line 80.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `c` | Not explicitly documented in adjacent source annotations. |

#### 9. `resolve_mode(m)`

- **Location:** source line 102.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `m` | Not explicitly documented in adjacent source annotations. |

#### 10. `system(opts)`

- **Location:** source line 110.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 11. `lerp_scalar(w, s1, s2)`

- **Location:** source line 133.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `w` | Not explicitly documented in adjacent source annotations. |
| 2 | `s1` | Not explicitly documented in adjacent source annotations. |
| 3 | `s2` | Not explicitly documented in adjacent source annotations. |

#### 12. `lerp_integer(w, s1, s2)`

- **Location:** source line 139.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `w` | Not explicitly documented in adjacent source annotations. |
| 2 | `s1` | Not explicitly documented in adjacent source annotations. |
| 3 | `s2` | Not explicitly documented in adjacent source annotations. |

#### 13. `lerp_vec(w1, w2, v1, v2)`

- **Location:** source line 143.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `w1` | Not explicitly documented in adjacent source annotations. |
| 2 | `w2` | Not explicitly documented in adjacent source annotations. |
| 3 | `v1` | Not explicitly documented in adjacent source annotations. |
| 4 | `v2` | Not explicitly documented in adjacent source annotations. |

#### 14. `rand_scalar(s1, s2)`

- **Location:** source line 150.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `s1` | Not explicitly documented in adjacent source annotations. |
| 2 | `s2` | Not explicitly documented in adjacent source annotations. |

#### 15. `rand_vec(v1, v2)`

- **Location:** source line 154.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `v1` | Not explicitly documented in adjacent source annotations. |
| 2 | `v2` | Not explicitly documented in adjacent source annotations. |

#### 16. `respawn(sys, p)`

- **Location:** source line 158.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sys` | Not explicitly documented in adjacent source annotations. |
| 2 | `p` | Not explicitly documented in adjacent source annotations. |

#### 17. `tick_ani(sys, p)`

- **Location:** source line 253.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `sys` | Not explicitly documented in adjacent source annotations. |
| 2 | `p` | Not explicitly documented in adjacent source annotations. |

#### 18. `t.config(self, opts)`

- **Location:** source line 317.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `opts` | Not explicitly documented in adjacent source annotations. |

#### 19. `t.spawn(self, a, b)`

- **Location:** source line 336.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |

#### 20. `t.frames(self, a, b)`

- **Location:** source line 343.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |

#### 21. `t.start_x(self, a, b)`

- **Location:** source line 350.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |

#### 22. `t.start_y(self, a, b)`

- **Location:** source line 357.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |

#### 23. `t.vel_x(self, a, b, mode)`

- **Location:** source line 364.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |
| 4 | `mode` | Not explicitly documented in adjacent source annotations. |

#### 24. `t.vel_y(self, a, b, mode)`

- **Location:** source line 373.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |
| 4 | `mode` | Not explicitly documented in adjacent source annotations. |

#### 25. `t.acc_x(self, a, b, mode)`

- **Location:** source line 382.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |
| 4 | `mode` | Not explicitly documented in adjacent source annotations. |

#### 26. `t.acc_y(self, a, b, mode)`

- **Location:** source line 391.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |
| 4 | `mode` | Not explicitly documented in adjacent source annotations. |

#### 27. `t.scl_x(self, a, b, mode)`

- **Location:** source line 400.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |
| 4 | `mode` | Not explicitly documented in adjacent source annotations. |

#### 28. `t.scl_y(self, a, b, mode)`

- **Location:** source line 409.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |
| 4 | `mode` | Not explicitly documented in adjacent source annotations. |

#### 29. `t.ach(self, a, b, mode)`

- **Location:** source line 418.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |
| 4 | `mode` | Not explicitly documented in adjacent source annotations. |

#### 30. `t.rch(self, a, b, mode)`

- **Location:** source line 427.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |
| 4 | `mode` | Not explicitly documented in adjacent source annotations. |

#### 31. `t.gch(self, a, b, mode)`

- **Location:** source line 436.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |
| 4 | `mode` | Not explicitly documented in adjacent source annotations. |

#### 32. `t.bch(self, a, b, mode)`

- **Location:** source line 445.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |
| 4 | `mode` | Not explicitly documented in adjacent source annotations. |

#### 33. `t.fco_x(self, a, b)`

- **Location:** source line 454.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |

#### 34. `t.fco_y(self, a, b)`

- **Location:** source line 461.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |

#### 35. `t.delay(self, a, b)`

- **Location:** source line 468.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `a` | Not explicitly documented in adjacent source annotations. |
| 3 | `b` | Not explicitly documented in adjacent source annotations. |

#### 36. `t.limit(self, limit)`

- **Location:** source line 476.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `limit` | Not explicitly documented in adjacent source annotations. |

#### 37. `t.rand_fco(self)`

- **Location:** source line 481.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 38. `t.rand_acc(self)`

- **Location:** source line 485.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 39. `t.rand_vel(self)`

- **Location:** source line 489.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 40. `t.rand_pos(self)`

- **Location:** source line 493.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 41. `t.rand_scl(self)`

- **Location:** source line 497.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 42. `t.rand_cnt(self)`

- **Location:** source line 501.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 43. `t.rand_rot(self)`

- **Location:** source line 505.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 44. `t.rand_ach(self)`

- **Location:** source line 510.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 45. `t.rand_rch(self)`

- **Location:** source line 514.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 46. `t.rand_gch(self)`

- **Location:** source line 518.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 47. `t.rand_bch(self)`

- **Location:** source line 522.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 48. `t.rand_spn(self)`

- **Location:** source line 526.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 49. `t.rand_del(self)`

- **Location:** source line 530.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 50. `t.tick(self)`

- **Location:** source line 534.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 51. `t.apply(self, force)`

- **Location:** source line 566.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `force` | Not explicitly documented in adjacent source annotations. |

#### 52. `t.build(self)`

- **Location:** source line 576.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 53. `t.destroy(self)`

- **Location:** source line 584.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |

#### 54. `t.gen(self, count)`

- **Location:** source line 588.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `count` | Not explicitly documented in adjacent source annotations. |

#### 55. `t.for_each(self, fn)`

- **Location:** source line 606.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `self` | Not explicitly documented in adjacent source annotations. |
| 2 | `fn` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 618 | `event` | `_idx = table.insert(system_set, t) return t:config(opts) end local DT = 0 Net:on("ti…` |

## 📦 Tables and data

The following **15** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `system_set` — line 33

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 2. `Presets` — line 35

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `random` | string literal | `'random'` |
| `linear` | function | `function(x) return x end` |
| `square` | function | `function(x) return x*x end` |
| `cubic` | function | `function(x) return x*x*x end` |

### 3. `return` — line 43

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | numeric literal | `1` |
| `y` | numeric literal | `1` |

### 4. `return` — line 50

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | numeric literal | `0` |
| `y` | numeric literal | `0` |

### 5. `v` — line 66

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 6. `c` — line 82

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `t` — line 111

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `upp` | nested table | `{}` |
| `low` | nested table | `{}` |
| `liv` | nested table | `{}` |
| `len` | numeric literal | `0` |
| `del` | numeric literal | `0` |
| `lim` | numeric literal | `1` |
| `ani` | nested table | `{ vel_x=Presets.random, acc_x=Presets.random, scl_x=Presets.random, vel_y=Presets.random, acc_y=Presets.random, scl_y=Presets.random, rot=Presets.random, …` |

### 8. `upp` — line 112

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `low` — line 113

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 10. `liv` — line 114

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 11. `ani` — line 118

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `vel_x` | expression/reference | `Presets.random` |
| `acc_x` | expression/reference | `Presets.random` |
| `scl_x` | expression/reference | `Presets.random` |
| `vel_y` | expression/reference | `Presets.random` |
| `acc_y` | expression/reference | `Presets.random` |
| `scl_y` | expression/reference | `Presets.random` |
| `rot` | expression/reference | `Presets.random` |
| `ach` | expression/reference | `Presets.random` |
| `rch` | expression/reference | `Presets.random` |
| `gch` | expression/reference | `Presets.random` |
| `bch` | expression/reference | `Presets.random` |

### 12. `v` — line 144

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `v2.x - v1.x` |
| `y` | expression/reference | `v2.y - v1.y` |

### 13. `return` — line 147

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `x` | expression/reference | `rx + v1.x` |
| `y` | expression/reference | `ry + v1.y` |

### 14. `opts` — line 319

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 15. `next` — line 542

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

## ⚙️ Runtime API calls

These are **statically detected call sites**, not API definitions or guaranteed successful runtime calls.

| Call identifier | Occurrences |
|---|---|
| `Net.on` | 1 |

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
