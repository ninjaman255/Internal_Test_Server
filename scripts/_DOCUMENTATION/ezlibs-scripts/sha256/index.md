# 📄 `sha256.lua`

[🏠 Documentation home](../../index.md) · [⬆ Folder index](../index.md)

> **Source:** [`scripts/ezlibs-scripts/sha256.lua`](../../../ezlibs-scripts/sha256.lua)  
> **Source lines:** 5675  
> **SHA-256 (UTF-8):** `4994a6d1b14d5e…`  
> **Declared/assigned functions detected:** 121  
> **Anonymous closures detected:** 5  
> **Table initializers detected:** 35

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

VERSION: 12 (2022-02-23) AUTHOR: Egor Skriptunoff LICENSE: MIT (the same license as Lua itself) URL: https://github.com/Egor-Skriptunoff/pure_lua_SHA DESCRIPTION:

## 🔗 Dependencies

| Line | Module string supplied to `require` |
|---|---|
| 129 | `bit` |

## 📡 Event subscriptions

*No literal `.on` or `:on` event subscriptions detected.*

## 🧩 Functions

| Line | Function or assignment | Parameters (verbatim) | Declaration |
|---|---|---|---|
| 69 | `get_precision` | `one` | local |
| 228 | `SHL` | `x, n` | declared |
| 232 | `SHR` | `x, n` | declared |
| 237 | `ROL` | `x, n` | declared |
| 243 | `ROR` | `x, n` | declared |
| 263 | `and_or_xor` | `x, y, operation` | local |
| 286 | `AND` | `x, y` | declared |
| 290 | `OR` | `x, y` | declared |
| 294 | `XOR` | `x, y, z, t, u` | declared |
| 307 | `XOR_BYTE` | `x, y` | declared |
| 324 | `XORA5` | `x, y` | local |
| 328 | `create_array_of_lanes` | `(none)` | local |
| 369 | `build_keccak_format` | `elem` | local |
| 391 | `sha256_feed_64` | `H, str, offs, size` | declared |
| 457 | `G` | `a, b, c, d, k1, k2` | local |
| 470 | `blake2b_feed_128` | `H, _, str, offs, size, bytes_compressed, last_block_size, is_last_node` | declared |
| 526 | `create_array_of_lanes` | `(none)` | declared |
| 530 | `keccak_feed` | `lanes, _, str, offs, size, block_size_in_bytes` | declared |
| 571 | `XORA5` | `long, long2` | declared |
| 578 | `sha512_feed_128` | `H, _, str, offs, size` | declared |
| 638 | `XORROR64_1` | `a` | local |
| 647 | `XORROR64_2` | `b` | local |
| 656 | `XORROR64_3` | `e` | local |
| 665 | `XORROR64_6` | `a` | local |
| 674 | `XORROR64_4` | `e, f, g` | local |
| 687 | `XORROR64_5` | `a, b, c` | local |
| 700 | `XORROR64_7` | `a, b, m` | local |
| 712 | `XORROR64_8` | `a, b` | local |
| 724 | `XORROR64_9` | `a, b` | local |
| 734 | `XOR64` | `a, b` | local |
| 744 | `XORROR64_11` | `a, b, c` | local |
| 756 | `XORA5` | `long, long2` | declared |
| 770 | `HEX64` | `long` | declared |
| 778 | `sha512_feed_128` | `H, _, str, offs, size` | declared |
| 835 | `G` | `a, b, c, d, k1, k2` | local |
| 848 | `blake2b_feed_128` | `H, _, str, offs, size, bytes_compressed, last_block_size, is_last_node` | declared |
| 901 | `md5_feed_64` | `H, str, offs, size` | declared |
| 945 | `sha1_feed_64` | `H, str, offs, size` | declared |
| 998 | `create_array_of_lanes` | `(none)` | declared |
| 1007 | `keccak_feed` | `lanes_lo, lanes_hi, str, offs, size, block_size_in_bytes` | declared |
| 1072 | `sha256_feed_64` | `H, str, offs, size` | declared |
| 1117 | `ADD64_4` | `a_lo, a_hi, b_lo, b_hi, c_lo, c_hi, d_lo, d_hi` | local |
| 1130 | `sha512_feed_128` | `H_lo, H_hi, str, offs, size` | declared |
| 1187 | `sha512_feed_128` | `H_lo, H_hi, str, offs, size` | declared |
| 1242 | `md5_feed_64` | `H, str, offs, size` | declared |
| 1286 | `sha1_feed_64` | `H, str, offs, size` | declared |
| 1337 | `G` | `a, b, c, d, k1, k2` | local |
| 1364 | `blake2b_feed_128` | `H_lo, H_hi, str, offs, size, bytes_compressed, last_block_size, is_last_node` | declared |
| 1441 | `G` | `a, b, c, d, k1, k2` | local |
| 1454 | `blake2s_feed_64` | `H, str, offs, size, bytes_compressed, last_block_size, is_last_node` | declared |
| 1502 | `blake3_feed_64` | `str, offs, size, flags, chunk_index, H_in, H_out, wide_output, block_length` | declared |
| 2286 | `HEX` | `x` | declared |
| 3201 | `sha256_feed_64` | `H, str, offs, size` | declared |
| 3243 | `sha512_feed_128` | `H_lo, H_hi, str, offs, size` | declared |
| 3326 | `md5_feed_64` | `H, str, offs, size` | declared |
| 3383 | `md5_feed_64` | `H, str, offs, size` | declared |
| 3445 | `sha1_feed_64` | `H, str, offs, size` | declared |
| 3515 | `keccak_feed` | `lanes_lo, lanes_hi, str, offs, size, block_size_in_bytes` | declared |
| 3697 | `blake2s_feed_64` | `H, str, offs, size, bytes_compressed, last_block_size, is_last_node` | declared |
| 3835 | `blake2b_feed_128` | `H_lo, H_hi, str, offs, size, bytes_compressed, last_block_size, is_last_node` | declared |
| 4084 | `blake3_feed_64` | `str, offs, size, flags, chunk_index, H_in, H_out, wide_output, block_length` | declared |
| 4236 | `mul` | `src1, src2, factor, result_length` | local |
| 4322 | `next_bit` | `(none)` | local |
| 4356 | `sha256ext` | `width, message` | local |
| 4360 | `partial` | `message_part` | local |
| 4413 | `sha512ext` | `width, message` | local |
| 4417 | `partial` | `message_part` | local |
| 4476 | `md5` | `message` | local |
| 4480 | `partial` | `message_part` | local |
| 4530 | `sha1` | `message` | local |
| 4534 | `partial` | `message_part` | local |
| 4585 | `keccak` | `block_size_in_bytes, digest_size_in_bytes, is_SHAKE, message` | local |
| 4598 | `partial` | `message_part` | local |
| 4626 | `get_next_qwords_of_digest` | `qwords_qty` | local |
| 4653 | `get_next_part_of_digest` | `bytes_needed` | local |
| 4709 | `hex_to_bin` | `hex_string` | declared |
| 4717 | `bin_to_hex` | `binary_string` | declared |
| 4740 | `bin_to_base64` | `binary_string` | declared |
| 4753 | `base64_to_bin` | `base64_string` | declared |
| 4779 | `pad_and_xor` | `str, result_length, byte_for_xor` | local |
| 4787 | `hmac` | `hash_func, key, message` | local |
| 4799 | `partial` | `message_part` | local |
| 4822 | `xor_blake2_salt` | `salt, letter, H_lo, H_hi` | local |
| 4847 | `blake2s` | `message, key, salt, digest_size_in_bytes, XOF_length, B2_offset` | local |
| 4879 | `partial` | `message_part` | local |
| 4931 | `blake2b` | `message, key, salt, digest_size_in_bytes, XOF_length, B2_offset` | local |
| 4973 | `partial` | `message_part` | local |
| 5040 | `blake2sp` | `message, key, salt, digest_size_in_bytes` | local |
| 5067 | `partial` | `message_part` | local |
| 5147 | `blake2bp` | `message, key, salt, digest_size_in_bytes` | local |
| 5174 | `partial` | `message_part` | local |
| 5264 | `blake2x` | `inner_func, inner_func_letter, common_W_blake2, block_size, digest_size_in_bytes, message, key, salt` | local |
| 5287 | `partial` | `message_part` | local |
| 5300 | `get_hash_block` | `block_no` | local |
| 5319 | `get_next_part_of_digest` | `arg1, arg2` | local |
| 5365 | `blake2xs` | `digest_size_in_bytes, message, key, salt` | local |
| 5376 | `blake2xb` | `digest_size_in_bytes, message, key, salt` | local |
| 5388 | `blake3` | `message, key, digest_size_in_bytes, message_flags, K, return_array` | local |
| 5418 | `feed_blocks` | `str, offs, size` | local |
| 5460 | `get_hash_block` | `block_no` | local |
| 5481 | `partial` | `message_part` | local |
| 5541 | `get_next_part_of_digest` | `arg1, arg2` | local |
| 5590 | `blake3_derive_key` | `key_material, context_string, derived_key_size_in_bytes` | local |
| 5611 | `sha224` | `message` | assigned |
| 5612 | `sha256` | `message` | assigned |
| 5613 | `sha512_224` | `message` | assigned |
| 5614 | `sha512_256` | `message` | assigned |
| 5615 | `sha384` | `message` | assigned |
| 5616 | `sha512` | `message` | assigned |
| 5618 | `sha3_224` | `message` | assigned |
| 5619 | `sha3_256` | `message` | assigned |
| 5620 | `sha3_384` | `message` | assigned |
| 5621 | `sha3_512` | `message` | assigned |
| 5622 | `shake128` | `digest_size_in_bytes, message` | assigned |
| 5623 | `shake256` | `digest_size_in_bytes, message` | assigned |
| 5645 | `blake2b_160` | `message, key, salt` | assigned |
| 5646 | `blake2b_256` | `message, key, salt` | assigned |
| 5647 | `blake2b_384` | `message, key, salt` | assigned |
| 5649 | `blake2s_128` | `message, key, salt` | assigned |
| 5650 | `blake2s_160` | `message, key, salt` | assigned |
| 5651 | `blake2s_224` | `message, key, salt` | assigned |

### Function details

#### 1. `get_precision(one)`

- **Location:** source line 69.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `one` | Not explicitly documented in adjacent source annotations. |

#### 2. `SHL(x, n)`

- **Location:** source line 228.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `n` | Not explicitly documented in adjacent source annotations. |

#### 3. `SHR(x, n)`

- **Location:** source line 232.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `n` | Not explicitly documented in adjacent source annotations. |

#### 4. `ROL(x, n)`

- **Location:** source line 237.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `n` | Not explicitly documented in adjacent source annotations. |

#### 5. `ROR(x, n)`

- **Location:** source line 243.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `n` | Not explicitly documented in adjacent source annotations. |

#### 6. `and_or_xor(x, y, operation)`

- **Location:** source line 263.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |
| 3 | `operation` | Not explicitly documented in adjacent source annotations. |

#### 7. `AND(x, y)`

- **Location:** source line 286.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |

#### 8. `OR(x, y)`

- **Location:** source line 290.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |

#### 9. `XOR(x, y, z, t, u)`

- **Location:** source line 294.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |
| 3 | `z` | Not explicitly documented in adjacent source annotations. |
| 4 | `t` | Not explicitly documented in adjacent source annotations. |
| 5 | `u` | Not explicitly documented in adjacent source annotations. |

#### 10. `XOR_BYTE(x, y)`

- **Location:** source line 307.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |

#### 11. `XORA5(x, y)`

- **Location:** source line 324.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |
| 2 | `y` | Not explicitly documented in adjacent source annotations. |

#### 12. `create_array_of_lanes()`

- **Location:** source line 328.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 13. `build_keccak_format(elem)`

- **Location:** source line 369.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `elem` | Not explicitly documented in adjacent source annotations. |

#### 14. `sha256_feed_64(H, str, offs, size)`

- **Location:** source line 391.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `str` | Not explicitly documented in adjacent source annotations. |
| 3 | `offs` | Not explicitly documented in adjacent source annotations. |
| 4 | `size` | Not explicitly documented in adjacent source annotations. |

#### 15. `G(a, b, c, d, k1, k2)`

- **Location:** source line 457.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |
| 3 | `c` | Not explicitly documented in adjacent source annotations. |
| 4 | `d` | Not explicitly documented in adjacent source annotations. |
| 5 | `k1` | Not explicitly documented in adjacent source annotations. |
| 6 | `k2` | Not explicitly documented in adjacent source annotations. |

#### 16. `blake2b_feed_128(H, _, str, offs, size, bytes_compressed, last_block_size, is_last_node)`

- **Location:** source line 470.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `_` | Not explicitly documented in adjacent source annotations. |
| 3 | `str` | Not explicitly documented in adjacent source annotations. |
| 4 | `offs` | Not explicitly documented in adjacent source annotations. |
| 5 | `size` | Not explicitly documented in adjacent source annotations. |
| 6 | `bytes_compressed` | Not explicitly documented in adjacent source annotations. |
| 7 | `last_block_size` | Not explicitly documented in adjacent source annotations. |
| 8 | `is_last_node` | Not explicitly documented in adjacent source annotations. |

#### 17. `create_array_of_lanes()`

- **Location:** source line 526.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 18. `keccak_feed(lanes, _, str, offs, size, block_size_in_bytes)`

- **Location:** source line 530.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `lanes` | Not explicitly documented in adjacent source annotations. |
| 2 | `_` | Not explicitly documented in adjacent source annotations. |
| 3 | `str` | Not explicitly documented in adjacent source annotations. |
| 4 | `offs` | Not explicitly documented in adjacent source annotations. |
| 5 | `size` | Not explicitly documented in adjacent source annotations. |
| 6 | `block_size_in_bytes` | Not explicitly documented in adjacent source annotations. |

#### 19. `XORA5(long, long2)`

- **Location:** source line 571.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `long` | Not explicitly documented in adjacent source annotations. |
| 2 | `long2` | Not explicitly documented in adjacent source annotations. |

#### 20. `sha512_feed_128(H, _, str, offs, size)`

- **Location:** source line 578.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `_` | Not explicitly documented in adjacent source annotations. |
| 3 | `str` | Not explicitly documented in adjacent source annotations. |
| 4 | `offs` | Not explicitly documented in adjacent source annotations. |
| 5 | `size` | Not explicitly documented in adjacent source annotations. |

#### 21. `XORROR64_1(a)`

- **Location:** source line 638.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |

#### 22. `XORROR64_2(b)`

- **Location:** source line 647.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `b` | Not explicitly documented in adjacent source annotations. |

#### 23. `XORROR64_3(e)`

- **Location:** source line 656.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `e` | Not explicitly documented in adjacent source annotations. |

#### 24. `XORROR64_6(a)`

- **Location:** source line 665.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |

#### 25. `XORROR64_4(e, f, g)`

- **Location:** source line 674.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `e` | Not explicitly documented in adjacent source annotations. |
| 2 | `f` | Not explicitly documented in adjacent source annotations. |
| 3 | `g` | Not explicitly documented in adjacent source annotations. |

#### 26. `XORROR64_5(a, b, c)`

- **Location:** source line 687.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |
| 3 | `c` | Not explicitly documented in adjacent source annotations. |

#### 27. `XORROR64_7(a, b, m)`

- **Location:** source line 700.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |
| 3 | `m` | Not explicitly documented in adjacent source annotations. |

#### 28. `XORROR64_8(a, b)`

- **Location:** source line 712.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |

#### 29. `XORROR64_9(a, b)`

- **Location:** source line 724.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |

#### 30. `XOR64(a, b)`

- **Location:** source line 734.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |

#### 31. `XORROR64_11(a, b, c)`

- **Location:** source line 744.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |
| 3 | `c` | Not explicitly documented in adjacent source annotations. |

#### 32. `XORA5(long, long2)`

- **Location:** source line 756.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `long` | Not explicitly documented in adjacent source annotations. |
| 2 | `long2` | Not explicitly documented in adjacent source annotations. |

#### 33. `HEX64(long)`

- **Location:** source line 770.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `long` | Not explicitly documented in adjacent source annotations. |

#### 34. `sha512_feed_128(H, _, str, offs, size)`

- **Location:** source line 778.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `_` | Not explicitly documented in adjacent source annotations. |
| 3 | `str` | Not explicitly documented in adjacent source annotations. |
| 4 | `offs` | Not explicitly documented in adjacent source annotations. |
| 5 | `size` | Not explicitly documented in adjacent source annotations. |

#### 35. `G(a, b, c, d, k1, k2)`

- **Location:** source line 835.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |
| 3 | `c` | Not explicitly documented in adjacent source annotations. |
| 4 | `d` | Not explicitly documented in adjacent source annotations. |
| 5 | `k1` | Not explicitly documented in adjacent source annotations. |
| 6 | `k2` | Not explicitly documented in adjacent source annotations. |

#### 36. `blake2b_feed_128(H, _, str, offs, size, bytes_compressed, last_block_size, is_last_node)`

- **Location:** source line 848.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `_` | Not explicitly documented in adjacent source annotations. |
| 3 | `str` | Not explicitly documented in adjacent source annotations. |
| 4 | `offs` | Not explicitly documented in adjacent source annotations. |
| 5 | `size` | Not explicitly documented in adjacent source annotations. |
| 6 | `bytes_compressed` | Not explicitly documented in adjacent source annotations. |
| 7 | `last_block_size` | Not explicitly documented in adjacent source annotations. |
| 8 | `is_last_node` | Not explicitly documented in adjacent source annotations. |

#### 37. `md5_feed_64(H, str, offs, size)`

- **Location:** source line 901.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `str` | Not explicitly documented in adjacent source annotations. |
| 3 | `offs` | Not explicitly documented in adjacent source annotations. |
| 4 | `size` | Not explicitly documented in adjacent source annotations. |

#### 38. `sha1_feed_64(H, str, offs, size)`

- **Location:** source line 945.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `str` | Not explicitly documented in adjacent source annotations. |
| 3 | `offs` | Not explicitly documented in adjacent source annotations. |
| 4 | `size` | Not explicitly documented in adjacent source annotations. |

#### 39. `create_array_of_lanes()`

- **Location:** source line 998.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 40. `keccak_feed(lanes_lo, lanes_hi, str, offs, size, block_size_in_bytes)`

- **Location:** source line 1007.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `lanes_lo` | Not explicitly documented in adjacent source annotations. |
| 2 | `lanes_hi` | Not explicitly documented in adjacent source annotations. |
| 3 | `str` | Not explicitly documented in adjacent source annotations. |
| 4 | `offs` | Not explicitly documented in adjacent source annotations. |
| 5 | `size` | Not explicitly documented in adjacent source annotations. |
| 6 | `block_size_in_bytes` | Not explicitly documented in adjacent source annotations. |

#### 41. `sha256_feed_64(H, str, offs, size)`

- **Location:** source line 1072.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `str` | Not explicitly documented in adjacent source annotations. |
| 3 | `offs` | Not explicitly documented in adjacent source annotations. |
| 4 | `size` | Not explicitly documented in adjacent source annotations. |

#### 42. `ADD64_4(a_lo, a_hi, b_lo, b_hi, c_lo, c_hi, d_lo, d_hi)`

- **Location:** source line 1117.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a_lo` | Not explicitly documented in adjacent source annotations. |
| 2 | `a_hi` | Not explicitly documented in adjacent source annotations. |
| 3 | `b_lo` | Not explicitly documented in adjacent source annotations. |
| 4 | `b_hi` | Not explicitly documented in adjacent source annotations. |
| 5 | `c_lo` | Not explicitly documented in adjacent source annotations. |
| 6 | `c_hi` | Not explicitly documented in adjacent source annotations. |
| 7 | `d_lo` | Not explicitly documented in adjacent source annotations. |
| 8 | `d_hi` | Not explicitly documented in adjacent source annotations. |

#### 43. `sha512_feed_128(H_lo, H_hi, str, offs, size)`

- **Location:** source line 1130.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H_lo` | Not explicitly documented in adjacent source annotations. |
| 2 | `H_hi` | Not explicitly documented in adjacent source annotations. |
| 3 | `str` | Not explicitly documented in adjacent source annotations. |
| 4 | `offs` | Not explicitly documented in adjacent source annotations. |
| 5 | `size` | Not explicitly documented in adjacent source annotations. |

#### 44. `sha512_feed_128(H_lo, H_hi, str, offs, size)`

- **Location:** source line 1187.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H_lo` | Not explicitly documented in adjacent source annotations. |
| 2 | `H_hi` | Not explicitly documented in adjacent source annotations. |
| 3 | `str` | Not explicitly documented in adjacent source annotations. |
| 4 | `offs` | Not explicitly documented in adjacent source annotations. |
| 5 | `size` | Not explicitly documented in adjacent source annotations. |

#### 45. `md5_feed_64(H, str, offs, size)`

- **Location:** source line 1242.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `str` | Not explicitly documented in adjacent source annotations. |
| 3 | `offs` | Not explicitly documented in adjacent source annotations. |
| 4 | `size` | Not explicitly documented in adjacent source annotations. |

#### 46. `sha1_feed_64(H, str, offs, size)`

- **Location:** source line 1286.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `str` | Not explicitly documented in adjacent source annotations. |
| 3 | `offs` | Not explicitly documented in adjacent source annotations. |
| 4 | `size` | Not explicitly documented in adjacent source annotations. |

#### 47. `G(a, b, c, d, k1, k2)`

- **Location:** source line 1337.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |
| 3 | `c` | Not explicitly documented in adjacent source annotations. |
| 4 | `d` | Not explicitly documented in adjacent source annotations. |
| 5 | `k1` | Not explicitly documented in adjacent source annotations. |
| 6 | `k2` | Not explicitly documented in adjacent source annotations. |

#### 48. `blake2b_feed_128(H_lo, H_hi, str, offs, size, bytes_compressed, last_block_size, is_last_node)`

- **Location:** source line 1364.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H_lo` | Not explicitly documented in adjacent source annotations. |
| 2 | `H_hi` | Not explicitly documented in adjacent source annotations. |
| 3 | `str` | Not explicitly documented in adjacent source annotations. |
| 4 | `offs` | Not explicitly documented in adjacent source annotations. |
| 5 | `size` | Not explicitly documented in adjacent source annotations. |
| 6 | `bytes_compressed` | Not explicitly documented in adjacent source annotations. |
| 7 | `last_block_size` | Not explicitly documented in adjacent source annotations. |
| 8 | `is_last_node` | Not explicitly documented in adjacent source annotations. |

#### 49. `G(a, b, c, d, k1, k2)`

- **Location:** source line 1441.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `a` | Not explicitly documented in adjacent source annotations. |
| 2 | `b` | Not explicitly documented in adjacent source annotations. |
| 3 | `c` | Not explicitly documented in adjacent source annotations. |
| 4 | `d` | Not explicitly documented in adjacent source annotations. |
| 5 | `k1` | Not explicitly documented in adjacent source annotations. |
| 6 | `k2` | Not explicitly documented in adjacent source annotations. |

#### 50. `blake2s_feed_64(H, str, offs, size, bytes_compressed, last_block_size, is_last_node)`

- **Location:** source line 1454.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `str` | Not explicitly documented in adjacent source annotations. |
| 3 | `offs` | Not explicitly documented in adjacent source annotations. |
| 4 | `size` | Not explicitly documented in adjacent source annotations. |
| 5 | `bytes_compressed` | Not explicitly documented in adjacent source annotations. |
| 6 | `last_block_size` | Not explicitly documented in adjacent source annotations. |
| 7 | `is_last_node` | Not explicitly documented in adjacent source annotations. |

#### 51. `blake3_feed_64(str, offs, size, flags, chunk_index, H_in, H_out, wide_output, block_length)`

- **Location:** source line 1502.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `offs` | Not explicitly documented in adjacent source annotations. |
| 3 | `size` | Not explicitly documented in adjacent source annotations. |
| 4 | `flags` | Not explicitly documented in adjacent source annotations. |
| 5 | `chunk_index` | Not explicitly documented in adjacent source annotations. |
| 6 | `H_in` | Not explicitly documented in adjacent source annotations. |
| 7 | `H_out` | Not explicitly documented in adjacent source annotations. |
| 8 | `wide_output` | Not explicitly documented in adjacent source annotations. |
| 9 | `block_length` | Not explicitly documented in adjacent source annotations. |

#### 52. `HEX(x)`

- **Location:** source line 2286.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `x` | Not explicitly documented in adjacent source annotations. |

#### 53. `sha256_feed_64(H, str, offs, size)`

- **Location:** source line 3201.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `str` | Not explicitly documented in adjacent source annotations. |
| 3 | `offs` | Not explicitly documented in adjacent source annotations. |
| 4 | `size` | Not explicitly documented in adjacent source annotations. |

#### 54. `sha512_feed_128(H_lo, H_hi, str, offs, size)`

- **Location:** source line 3243.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H_lo` | Not explicitly documented in adjacent source annotations. |
| 2 | `H_hi` | Not explicitly documented in adjacent source annotations. |
| 3 | `str` | Not explicitly documented in adjacent source annotations. |
| 4 | `offs` | Not explicitly documented in adjacent source annotations. |
| 5 | `size` | Not explicitly documented in adjacent source annotations. |

#### 55. `md5_feed_64(H, str, offs, size)`

- **Location:** source line 3326.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `str` | Not explicitly documented in adjacent source annotations. |
| 3 | `offs` | Not explicitly documented in adjacent source annotations. |
| 4 | `size` | Not explicitly documented in adjacent source annotations. |

#### 56. `md5_feed_64(H, str, offs, size)`

- **Location:** source line 3383.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `str` | Not explicitly documented in adjacent source annotations. |
| 3 | `offs` | Not explicitly documented in adjacent source annotations. |
| 4 | `size` | Not explicitly documented in adjacent source annotations. |

#### 57. `sha1_feed_64(H, str, offs, size)`

- **Location:** source line 3445.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `str` | Not explicitly documented in adjacent source annotations. |
| 3 | `offs` | Not explicitly documented in adjacent source annotations. |
| 4 | `size` | Not explicitly documented in adjacent source annotations. |

#### 58. `keccak_feed(lanes_lo, lanes_hi, str, offs, size, block_size_in_bytes)`

- **Location:** source line 3515.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `lanes_lo` | Not explicitly documented in adjacent source annotations. |
| 2 | `lanes_hi` | Not explicitly documented in adjacent source annotations. |
| 3 | `str` | Not explicitly documented in adjacent source annotations. |
| 4 | `offs` | Not explicitly documented in adjacent source annotations. |
| 5 | `size` | Not explicitly documented in adjacent source annotations. |
| 6 | `block_size_in_bytes` | Not explicitly documented in adjacent source annotations. |

#### 59. `blake2s_feed_64(H, str, offs, size, bytes_compressed, last_block_size, is_last_node)`

- **Location:** source line 3697.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H` | Not explicitly documented in adjacent source annotations. |
| 2 | `str` | Not explicitly documented in adjacent source annotations. |
| 3 | `offs` | Not explicitly documented in adjacent source annotations. |
| 4 | `size` | Not explicitly documented in adjacent source annotations. |
| 5 | `bytes_compressed` | Not explicitly documented in adjacent source annotations. |
| 6 | `last_block_size` | Not explicitly documented in adjacent source annotations. |
| 7 | `is_last_node` | Not explicitly documented in adjacent source annotations. |

#### 60. `blake2b_feed_128(H_lo, H_hi, str, offs, size, bytes_compressed, last_block_size, is_last_node)`

- **Location:** source line 3835.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `H_lo` | Not explicitly documented in adjacent source annotations. |
| 2 | `H_hi` | Not explicitly documented in adjacent source annotations. |
| 3 | `str` | Not explicitly documented in adjacent source annotations. |
| 4 | `offs` | Not explicitly documented in adjacent source annotations. |
| 5 | `size` | Not explicitly documented in adjacent source annotations. |
| 6 | `bytes_compressed` | Not explicitly documented in adjacent source annotations. |
| 7 | `last_block_size` | Not explicitly documented in adjacent source annotations. |
| 8 | `is_last_node` | Not explicitly documented in adjacent source annotations. |

#### 61. `blake3_feed_64(str, offs, size, flags, chunk_index, H_in, H_out, wide_output, block_length)`

- **Location:** source line 4084.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `offs` | Not explicitly documented in adjacent source annotations. |
| 3 | `size` | Not explicitly documented in adjacent source annotations. |
| 4 | `flags` | Not explicitly documented in adjacent source annotations. |
| 5 | `chunk_index` | Not explicitly documented in adjacent source annotations. |
| 6 | `H_in` | Not explicitly documented in adjacent source annotations. |
| 7 | `H_out` | Not explicitly documented in adjacent source annotations. |
| 8 | `wide_output` | Not explicitly documented in adjacent source annotations. |
| 9 | `block_length` | Not explicitly documented in adjacent source annotations. |

#### 62. `mul(src1, src2, factor, result_length)`

- **Location:** source line 4236.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `src1` | Not explicitly documented in adjacent source annotations. |
| 2 | `src2` | Not explicitly documented in adjacent source annotations. |
| 3 | `factor` | Not explicitly documented in adjacent source annotations. |
| 4 | `result_length` | Not explicitly documented in adjacent source annotations. |

#### 63. `next_bit()`

- **Location:** source line 4322.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

#### 64. `sha256ext(width, message)`

- **Location:** source line 4356.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `width` | Not explicitly documented in adjacent source annotations. |
| 2 | `message` | Not explicitly documented in adjacent source annotations. |

#### 65. `partial(message_part)`

- **Location:** source line 4360.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message_part` | Not explicitly documented in adjacent source annotations. |

#### 66. `sha512ext(width, message)`

- **Location:** source line 4413.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `width` | Not explicitly documented in adjacent source annotations. |
| 2 | `message` | Not explicitly documented in adjacent source annotations. |

#### 67. `partial(message_part)`

- **Location:** source line 4417.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message_part` | Not explicitly documented in adjacent source annotations. |

#### 68. `md5(message)`

- **Location:** source line 4476.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 69. `partial(message_part)`

- **Location:** source line 4480.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message_part` | Not explicitly documented in adjacent source annotations. |

#### 70. `sha1(message)`

- **Location:** source line 4530.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 71. `partial(message_part)`

- **Location:** source line 4534.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message_part` | Not explicitly documented in adjacent source annotations. |

#### 72. `keccak(block_size_in_bytes, digest_size_in_bytes, is_SHAKE, message)`

- **Location:** source line 4585.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `block_size_in_bytes` | Not explicitly documented in adjacent source annotations. |
| 2 | `digest_size_in_bytes` | Not explicitly documented in adjacent source annotations. |
| 3 | `is_SHAKE` | Not explicitly documented in adjacent source annotations. |
| 4 | `message` | Not explicitly documented in adjacent source annotations. |

#### 73. `partial(message_part)`

- **Location:** source line 4598.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message_part` | Not explicitly documented in adjacent source annotations. |

#### 74. `get_next_qwords_of_digest(qwords_qty)`

- **Location:** source line 4626.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `qwords_qty` | Not explicitly documented in adjacent source annotations. |

#### 75. `get_next_part_of_digest(bytes_needed)`

- **Location:** source line 4653.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `bytes_needed` | Not explicitly documented in adjacent source annotations. |

#### 76. `hex_to_bin(hex_string)`

- **Location:** source line 4709.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `hex_string` | Not explicitly documented in adjacent source annotations. |

#### 77. `bin_to_hex(binary_string)`

- **Location:** source line 4717.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `binary_string` | Not explicitly documented in adjacent source annotations. |

#### 78. `bin_to_base64(binary_string)`

- **Location:** source line 4740.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `binary_string` | Not explicitly documented in adjacent source annotations. |

#### 79. `base64_to_bin(base64_string)`

- **Location:** source line 4753.
- **Declaration style:** `declared`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `base64_string` | Not explicitly documented in adjacent source annotations. |

#### 80. `pad_and_xor(str, result_length, byte_for_xor)`

- **Location:** source line 4779.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `result_length` | Not explicitly documented in adjacent source annotations. |
| 3 | `byte_for_xor` | Not explicitly documented in adjacent source annotations. |

#### 81. `hmac(hash_func, key, message)`

- **Location:** source line 4787.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `hash_func` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `message` | Not explicitly documented in adjacent source annotations. |

#### 82. `partial(message_part)`

- **Location:** source line 4799.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message_part` | Not explicitly documented in adjacent source annotations. |

#### 83. `xor_blake2_salt(salt, letter, H_lo, H_hi)`

- **Location:** source line 4822.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `salt` | Not explicitly documented in adjacent source annotations. |
| 2 | `letter` | Not explicitly documented in adjacent source annotations. |
| 3 | `H_lo` | Not explicitly documented in adjacent source annotations. |
| 4 | `H_hi` | Not explicitly documented in adjacent source annotations. |

#### 84. `blake2s(message, key, salt, digest_size_in_bytes, XOF_length, B2_offset)`

- **Location:** source line 4847.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `salt` | Not explicitly documented in adjacent source annotations. |
| 4 | `digest_size_in_bytes` | Not explicitly documented in adjacent source annotations. |
| 5 | `XOF_length` | Not explicitly documented in adjacent source annotations. |
| 6 | `B2_offset` | Not explicitly documented in adjacent source annotations. |

#### 85. `partial(message_part)`

- **Location:** source line 4879.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message_part` | Not explicitly documented in adjacent source annotations. |

#### 86. `blake2b(message, key, salt, digest_size_in_bytes, XOF_length, B2_offset)`

- **Location:** source line 4931.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `salt` | Not explicitly documented in adjacent source annotations. |
| 4 | `digest_size_in_bytes` | Not explicitly documented in adjacent source annotations. |
| 5 | `XOF_length` | Not explicitly documented in adjacent source annotations. |
| 6 | `B2_offset` | Not explicitly documented in adjacent source annotations. |

#### 87. `partial(message_part)`

- **Location:** source line 4973.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message_part` | Not explicitly documented in adjacent source annotations. |

#### 88. `blake2sp(message, key, salt, digest_size_in_bytes)`

- **Location:** source line 5040.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `salt` | Not explicitly documented in adjacent source annotations. |
| 4 | `digest_size_in_bytes` | Not explicitly documented in adjacent source annotations. |

#### 89. `partial(message_part)`

- **Location:** source line 5067.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message_part` | Not explicitly documented in adjacent source annotations. |

#### 90. `blake2bp(message, key, salt, digest_size_in_bytes)`

- **Location:** source line 5147.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `salt` | Not explicitly documented in adjacent source annotations. |
| 4 | `digest_size_in_bytes` | Not explicitly documented in adjacent source annotations. |

#### 91. `partial(message_part)`

- **Location:** source line 5174.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message_part` | Not explicitly documented in adjacent source annotations. |

#### 92. `blake2x(inner_func, inner_func_letter, common_W_blake2, block_size, digest_size_in_bytes, message, key, salt)`

- **Location:** source line 5264.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `inner_func` | Not explicitly documented in adjacent source annotations. |
| 2 | `inner_func_letter` | Not explicitly documented in adjacent source annotations. |
| 3 | `common_W_blake2` | Not explicitly documented in adjacent source annotations. |
| 4 | `block_size` | Not explicitly documented in adjacent source annotations. |
| 5 | `digest_size_in_bytes` | Not explicitly documented in adjacent source annotations. |
| 6 | `message` | Not explicitly documented in adjacent source annotations. |
| 7 | `key` | Not explicitly documented in adjacent source annotations. |
| 8 | `salt` | Not explicitly documented in adjacent source annotations. |

#### 93. `partial(message_part)`

- **Location:** source line 5287.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message_part` | Not explicitly documented in adjacent source annotations. |

#### 94. `get_hash_block(block_no)`

- **Location:** source line 5300.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `block_no` | Not explicitly documented in adjacent source annotations. |

#### 95. `get_next_part_of_digest(arg1, arg2)`

- **Location:** source line 5319.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `arg1` | Not explicitly documented in adjacent source annotations. |
| 2 | `arg2` | Not explicitly documented in adjacent source annotations. |

#### 96. `blake2xs(digest_size_in_bytes, message, key, salt)`

- **Location:** source line 5365.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `digest_size_in_bytes` | Not explicitly documented in adjacent source annotations. |
| 2 | `message` | Not explicitly documented in adjacent source annotations. |
| 3 | `key` | Not explicitly documented in adjacent source annotations. |
| 4 | `salt` | Not explicitly documented in adjacent source annotations. |

#### 97. `blake2xb(digest_size_in_bytes, message, key, salt)`

- **Location:** source line 5376.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `digest_size_in_bytes` | Not explicitly documented in adjacent source annotations. |
| 2 | `message` | Not explicitly documented in adjacent source annotations. |
| 3 | `key` | Not explicitly documented in adjacent source annotations. |
| 4 | `salt` | Not explicitly documented in adjacent source annotations. |

#### 98. `blake3(message, key, digest_size_in_bytes, message_flags, K, return_array)`

- **Location:** source line 5388.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `digest_size_in_bytes` | Not explicitly documented in adjacent source annotations. |
| 4 | `message_flags` | Not explicitly documented in adjacent source annotations. |
| 5 | `K` | Not explicitly documented in adjacent source annotations. |
| 6 | `return_array` | Not explicitly documented in adjacent source annotations. |

#### 99. `feed_blocks(str, offs, size)`

- **Location:** source line 5418.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `str` | Not explicitly documented in adjacent source annotations. |
| 2 | `offs` | Not explicitly documented in adjacent source annotations. |
| 3 | `size` | Not explicitly documented in adjacent source annotations. |

#### 100. `get_hash_block(block_no)`

- **Location:** source line 5460.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `block_no` | Not explicitly documented in adjacent source annotations. |

#### 101. `partial(message_part)`

- **Location:** source line 5481.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message_part` | Not explicitly documented in adjacent source annotations. |

#### 102. `get_next_part_of_digest(arg1, arg2)`

- **Location:** source line 5541.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `arg1` | Not explicitly documented in adjacent source annotations. |
| 2 | `arg2` | Not explicitly documented in adjacent source annotations. |

#### 103. `blake3_derive_key(key_material, context_string, derived_key_size_in_bytes)`

- **Location:** source line 5590.
- **Declaration style:** `local`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `key_material` | Not explicitly documented in adjacent source annotations. |
| 2 | `context_string` | Not explicitly documented in adjacent source annotations. |
| 3 | `derived_key_size_in_bytes` | Not explicitly documented in adjacent source annotations. |

#### 104. `sha224(message)`

- **Location:** source line 5611.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** SHA-2 hash functions:

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 105. `sha256(message)`

- **Location:** source line 5612.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 106. `sha512_224(message)`

- **Location:** source line 5613.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 107. `sha512_256(message)`

- **Location:** source line 5614.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 108. `sha384(message)`

- **Location:** source line 5615.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 109. `sha512(message)`

- **Location:** source line 5616.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 110. `sha3_224(message)`

- **Location:** source line 5618.
- **Declaration style:** `assigned`.
- **Adjacent source comment:** SHA-3 hash functions:

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 111. `sha3_256(message)`

- **Location:** source line 5619.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 112. `sha3_384(message)`

- **Location:** source line 5620.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 113. `sha3_512(message)`

- **Location:** source line 5621.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |

#### 114. `shake128(digest_size_in_bytes, message)`

- **Location:** source line 5622.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `digest_size_in_bytes` | Not explicitly documented in adjacent source annotations. |
| 2 | `message` | Not explicitly documented in adjacent source annotations. |

#### 115. `shake256(digest_size_in_bytes, message)`

- **Location:** source line 5623.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `digest_size_in_bytes` | Not explicitly documented in adjacent source annotations. |
| 2 | `message` | Not explicitly documented in adjacent source annotations. |

#### 116. `blake2b_160(message, key, salt)`

- **Location:** source line 5645.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `salt` | Not explicitly documented in adjacent source annotations. |

#### 117. `blake2b_256(message, key, salt)`

- **Location:** source line 5646.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `salt` | Not explicitly documented in adjacent source annotations. |

#### 118. `blake2b_384(message, key, salt)`

- **Location:** source line 5647.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `salt` | Not explicitly documented in adjacent source annotations. |

#### 119. `blake2s_128(message, key, salt)`

- **Location:** source line 5649.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `salt` | Not explicitly documented in adjacent source annotations. |

#### 120. `blake2s_160(message, key, salt)`

- **Location:** source line 5650.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `salt` | Not explicitly documented in adjacent source annotations. |

#### 121. `blake2s_224(message, key, salt)`

- **Location:** source line 5651.
- **Declaration style:** `assigned`.
- **Description:** No adjacent explanatory source comment; behavior must be verified in the linked implementation.

  **Parameter reference** (parameter names are sourced directly; undocumented types are not inferred):

| Position | Parameter | Source-established type / meaning |
|---|---|---|
| 1 | `message` | Not explicitly documented in adjacent source annotations. |
| 2 | `key` | Not explicitly documented in adjacent source annotations. |
| 3 | `salt` | Not explicitly documented in adjacent source annotations. |

## 🪄 Anonymous closures

These are anonymous `function(...)` expressions, including inline callbacks. Their argument lists are taken verbatim from source; lexical context is descriptive text, not a claim about execution.

| Line | Arguments | Preceding source context |
|---|---|---|
| 316 | `x` | `tes[x + y * 256] end end HEX = HEX or pcall(string_format, "%x", 2^31) and` |
| 320 | `x` | `hexadecimal digits return string_format("%08x", x % 4294967296) end or` |
| 4711 | `hh` | `4_to_bin do function hex_to_bin(hex_string) return (gsub(hex_string, "%x%x",` |
| 4719 | `c` | `end function bin_to_hex(binary_string) return (gsub(binary_string, ".",` |
| 4781 | `c` | `e local function pad_and_xor(str, result_length, byte_for_xor) return gsub(str, ".",` |

## 📦 Tables and data

The following **35** table initializer(s) were statically identified. Entries show **source expressions**, not evaluated values or guaranteed runtime table contents.

### 1. `AND_of_two_bytes` — line 249

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[0]` | numeric literal | `0` |

### 2. `return` — line 329

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `0` |
| `[2]` | numeric literal | `0` |
| `[3]` | numeric literal | `0` |
| `[4]` | numeric literal | `0` |
| `[5]` | numeric literal | `0` |
| `[6]` | numeric literal | `0` |
| `[7]` | numeric literal | `0` |
| `[8]` | numeric literal | `0` |
| `[9]` | numeric literal | `0` |
| `[10]` | numeric literal | `0` |
| `[11]` | numeric literal | `0` |
| `[12]` | numeric literal | `0` |
| `[13]` | numeric literal | `0` |
| `[14]` | numeric literal | `0` |
| `[15]` | numeric literal | `0` |
| `[16]` | numeric literal | `0` |
| `[17]` | numeric literal | `0` |
| `[18]` | numeric literal | `0` |
| `[19]` | numeric literal | `0` |
| `[20]` | numeric literal | `0` |
| `[21]` | numeric literal | `0` |
| `[22]` | numeric literal | `0` |
| `[23]` | numeric literal | `0` |
| `[24]` | numeric literal | `0` |
| `[25]` | numeric literal | `0` |

### 3. `sha3_RC_hi` — line 341

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 4. `sha2_H_ext256` — line 342

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[224]` | nested table | `{}` |
| `[256]` | expression/reference | `sha2_H_hi` |

### 5. `sha2_H_ext512_hi` — line 343

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[384]` | nested table | `{}` |
| `[512]` | expression/reference | `sha2_H_lo` |

### 6. `md5_sha1_H` — line 344

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 7. `md5_next_shift` — line 345

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `0` |
| `[2]` | numeric literal | `0` |
| `[3]` | numeric literal | `0` |
| `[4]` | numeric literal | `0` |
| `[5]` | numeric literal | `0` |
| `[6]` | numeric literal | `0` |
| `[7]` | numeric literal | `0` |
| `[8]` | numeric literal | `0` |
| `[9]` | numeric literal | `28` |
| `[10]` | numeric literal | `25` |
| `[11]` | numeric literal | `26` |
| `[12]` | numeric literal | `27` |
| `[13]` | numeric literal | `0` |
| `[14]` | numeric literal | `0` |
| `[15]` | numeric literal | `10` |
| `[16]` | numeric literal | `9` |
| `[17]` | numeric literal | `11` |
| `[18]` | numeric literal | `12` |
| `[19]` | numeric literal | `0` |
| `[20]` | numeric literal | `15` |
| `[21]` | numeric literal | `16` |
| `[22]` | numeric literal | `17` |
| `[23]` | numeric literal | `18` |
| `[24]` | numeric literal | `0` |
| `[25]` | numeric literal | `20` |
| `[26]` | numeric literal | `22` |
| `[27]` | numeric literal | `23` |
| `[28]` | numeric literal | `21` |

### 8. `common_W` — line 347

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 9. `sigma` — line 350

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | nested table | `{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 }` |
| `[2]` | nested table | `{ 15, 11, 5, 9, 10, 16, 14, 7, 2, 13, 1, 3, 12, 8, 6, 4 }` |
| `[3]` | nested table | `{ 12, 9, 13, 1, 6, 3, 16, 14, 11, 15, 4, 7, 8, 2, 10, 5 }` |
| `[4]` | nested table | `{ 8, 10, 4, 2, 14, 13, 12, 15, 3, 7, 6, 11, 5, 1, 16, 9 }` |
| `[5]` | nested table | `{ 10, 1, 6, 8, 3, 5, 11, 16, 15, 2, 12, 13, 7, 9, 4, 14 }` |
| `[6]` | nested table | `{ 3, 13, 7, 11, 1, 12, 9, 4, 5, 14, 8, 6, 16, 15, 2, 10 }` |
| `[7]` | nested table | `{ 13, 6, 2, 16, 15, 14, 5, 11, 1, 8, 7, 4, 10, 3, 9, 12 }` |
| `[8]` | nested table | `{ 14, 12, 8, 15, 13, 2, 4, 10, 6, 1, 16, 5, 9, 7, 3, 11 }` |
| `[9]` | nested table | `{ 7, 16, 15, 10, 12, 4, 1, 9, 13, 3, 14, 8, 2, 5, 11, 6 }` |
| `[10]` | nested table | `{ 11, 3, 9, 5, 8, 7, 2, 6, 16, 12, 10, 15, 4, 13, 14, 1 }` |

### 10. `perm_blake3` — line 362

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | numeric literal | `1` |
| `[2]` | numeric literal | `3` |
| `[3]` | numeric literal | `4` |
| `[4]` | numeric literal | `11` |
| `[5]` | numeric literal | `13` |
| `[6]` | numeric literal | `10` |
| `[7]` | numeric literal | `12` |
| `[8]` | numeric literal | `6` |
| `[9]` | numeric literal | `1` |
| `[10]` | numeric literal | `3` |
| `[11]` | numeric literal | `4` |
| `[12]` | numeric literal | `11` |
| `[13]` | numeric literal | `13` |
| `[14]` | numeric literal | `10` |
| `[15]` | numeric literal | `2` |
| `[16]` | numeric literal | `7` |
| `[17]` | numeric literal | `5` |
| `[18]` | numeric literal | `8` |
| `[19]` | numeric literal | `14` |
| `[20]` | numeric literal | `15` |
| `[21]` | numeric literal | `16` |
| `[22]` | numeric literal | `9` |
| `[23]` | numeric literal | `2` |
| `[24]` | numeric literal | `7` |
| `[25]` | numeric literal | `5` |
| `[26]` | numeric literal | `8` |
| `[27]` | numeric literal | `14` |
| `[28]` | numeric literal | `15` |

### 11. `keccak_format` — line 370

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 12. `v_hi` — line 1335

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 13. `weight` — line 4240

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 14. `H_hi` — line 4291

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 15. `H_hi` — line 4297

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 16. `tail` — line 4358

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `unpack(sha2_H_ext256[width])` |

### 17. `final_blocks` — line 4380

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `tail` |
| `[2]` | string literal | `"\128"` |
| `[3]` | expression/reference | `string_rep("\0", (-9 - length) % 64 + 1)` |

### 18. `final_blocks` — line 4437

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `tail` |
| `[2]` | string literal | `"\128"` |
| `[3]` | expression/reference | `string_rep("\0", (-17-length) % 128 + 9)` |

### 19. `tail` — line 4478

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `unpack(md5_sha1_H, 1, 4)` |

### 20. `final_blocks` — line 4500

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `tail` |
| `[2]` | string literal | `"\128"` |
| `[3]` | expression/reference | `string_rep("\0", (-9 - length) % 64)` |

### 21. `tail` — line 4532

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `unpack(md5_sha1_H)` |

### 22. `final_blocks` — line 4554

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `tail` |
| `[2]` | string literal | `"\128"` |
| `[3]` | expression/reference | `string_rep("\0", (-9 - length) % 64 + 1)` |

### 23. `qwords` — line 4624

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 24. `parts` — line 4650

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 25. `base64_symbols` — line 4725

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `['+'] = 62` |
| `[2]` | expression/reference | `['-'] = 62` |
| `[62]` | string literal | `'+'` |
| `[4]` | expression/reference | `['/'] = 63` |
| `['_']` | numeric literal | `63` |
| `[63]` | string literal | `'/'` |
| `[7]` | expression/reference | `['='] = -1` |
| `['.']` | numeric literal | `-1` |
| `[9]` | expression/reference | `[-1] = '='` |

### 26. `result` — line 4741

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 27. `chars_qty` — line 4754

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 28. `result` — line 5055

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 29. `root_H` — line 5096

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `unpack(sha2_H_hi)` |

### 30. `result` — line 5162

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 31. `root_H_hi` — line 5203

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[1]` | expression/reference | `unpack(sha2_H_lo)` |

### 32. `hash` — line 5315

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 33. `K` — line 5407

*Table constructor detected; no simple direct-level fields were extracted (or constructor is empty).*

### 34. `sha` — line 5607

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `md5` | expression/reference | `md5` |
| `[2]` | expression/reference | `-- MD5 sha1 = sha1` |
| `[3]` | expression/reference | `-- SHA-1 -- SHA-2 hash functions: sha224 = function (message) return sha256ext(224, message) end` |
| `[4]` | expression/reference | `-- SHA-224 sha256 = function (message) return sha256ext(256, message) end` |
| `[5]` | expression/reference | `-- SHA-256 sha512_224 = function (message) return sha512ext(224, message) end` |
| `[6]` | expression/reference | `-- SHA-512/224 sha512_256 = function (message) return sha512ext(256, message) end` |
| `[7]` | expression/reference | `-- SHA-512/256 sha384 = function (message) return sha512ext(384, message) end` |
| `[8]` | expression/reference | `-- SHA-384 sha512 = function (message) return sha512ext(512, message) end` |
| `[9]` | expression/reference | `-- SHA-512 -- SHA-3 hash functions: sha3_224 = function (message) return keccak((1600 - 2 * 224) / 8, 224 / 8, false, message) end` |
| `[10]` | expression/reference | `-- SHA3-224 sha3_256 = function (message) return keccak((1600 - 2 * 256) / 8, 256 / 8, false, message) end` |
| `[11]` | expression/reference | `-- SHA3-256 sha3_384 = function (message) return keccak((1600 - 2 * 384) / 8, 384 / 8, false, message) end` |
| `[12]` | expression/reference | `-- SHA3-384 sha3_512 = function (message) return keccak((1600 - 2 * 512) / 8, 512 / 8, false, message) end` |
| `[13]` | expression/reference | `-- SHA3-512 shake128 = function (digest_size_in_bytes, message) return keccak((1600 - 2 * 128) / 8, digest_size_in_bytes, true, message) end` |
| `[14]` | expression/reference | `-- SHAKE128 shake256 = function (digest_size_in_bytes, message) return keccak((1600 - 2 * 256) / 8, digest_size_in_bytes, true, message) end` |
| `[15]` | expression/reference | `-- SHAKE256 -- HMAC: hmac = hmac` |
| `[16]` | expression/reference | `-- HMAC(hash_func, key, message) is applicable to any hash function from this module except SHAKE* and BLAKE* -- misc utilities: hex_to_bin = hex_to_bin` |
| `[17]` | expression/reference | `-- converts hexadecimal representation to binary string bin_to_hex = bin_to_hex` |
| `[18]` | expression/reference | `-- converts binary string to hexadecimal representation base64_to_bin = base64_to_bin` |
| `[19]` | expression/reference | `-- converts base64 representation to binary string bin_to_base64 = bin_to_base64` |
| `[20]` | expression/reference | `-- converts binary string to base64 representation -- old style names for backward compatibility: hex2bin = hex_to_bin` |
| `bin2hex` | expression/reference | `bin_to_hex` |
| `base642bin` | expression/reference | `base64_to_bin` |
| `bin2base64` | expression/reference | `bin_to_base64` |
| `[24]` | expression/reference | `-- BLAKE2 hash functions: blake2b = blake2b` |
| `[25]` | expression/reference | `-- BLAKE2b (message, key, salt, digest_size_in_bytes) blake2s = blake2s` |
| `[26]` | expression/reference | `-- BLAKE2s (message, key, salt, digest_size_in_bytes) blake2bp = blake2bp` |
| `[27]` | expression/reference | `-- BLAKE2bp(message, key, salt, digest_size_in_bytes) blake2sp = blake2sp` |
| `[28]` | expression/reference | `-- BLAKE2sp(message, key, salt, digest_size_in_bytes) blake2xb = blake2xb` |
| `[29]` | expression/reference | `-- BLAKE2Xb(digest_size_in_bytes, message, key, salt) blake2xs = blake2xs` |
| `[30]` | expression/reference | `-- BLAKE2Xs(digest_size_in_bytes, message, key, salt) -- BLAKE2 aliases: blake2 = blake2b` |
| `blake2b_160` | function | `function (message, key, salt) return blake2b(message, key, salt, 20) end` |
| `[32]` | expression/reference | `-- BLAKE2b-160 blake2b_256 = function (message, key, salt) return blake2b(message, key, salt, 32) end` |
| `[33]` | expression/reference | `-- BLAKE2b-256 blake2b_384 = function (message, key, salt) return blake2b(message, key, salt, 48) end` |
| `[34]` | expression/reference | `-- BLAKE2b-384 blake2b_512 = blake2b` |
| `[35]` | expression/reference | `-- 64 -- BLAKE2b-512 blake2s_128 = function (message, key, salt) return blake2s(message, key, salt, 16) end` |
| `[36]` | expression/reference | `-- BLAKE2s-128 blake2s_160 = function (message, key, salt) return blake2s(message, key, salt, 20) end` |
| `[37]` | expression/reference | `-- BLAKE2s-160 blake2s_224 = function (message, key, salt) return blake2s(message, key, salt, 28) end` |
| `[38]` | expression/reference | `-- BLAKE2s-224 blake2s_256 = blake2s` |
| `[39]` | expression/reference | `-- 32 -- BLAKE2s-256 -- BLAKE3 hash function blake3 = blake3` |
| `[40]` | expression/reference | `-- BLAKE3 (message, key, digest_size_in_bytes) blake3_derive_key = blake3_derive_key` |
| `[41]` | expression/reference | `-- BLAKE3_KDF(key_material, context_string, derived_key_size_in_bytes)` |

### 35. `block_size_for_HMAC` — line 5659

| Field / index | Initializer category | Expression from source |
|---|---|---|
| `[sha.md5]` | numeric literal | `64` |
| `[sha.sha1]` | numeric literal | `64` |
| `[sha.sha224]` | numeric literal | `64` |
| `[sha.sha256]` | numeric literal | `64` |
| `[sha.sha512_224]` | numeric literal | `128` |
| `[sha.sha512_256]` | numeric literal | `128` |
| `[sha.sha384]` | numeric literal | `128` |
| `[sha.sha512]` | numeric literal | `128` |
| `[sha.sha3_224]` | numeric literal | `144` |
| `[10]` | expression/reference | `-- (1600 - 2 * 224) / 8 [sha.sha3_256] = 136` |
| `[11]` | expression/reference | `-- (1600 - 2 * 256) / 8 [sha.sha3_384] = 104` |
| `[12]` | expression/reference | `-- (1600 - 2 * 384) / 8 [sha.sha3_512] = 72` |
| `[13]` | expression/reference | `-- (1600 - 2 * 512) / 8` |

## ⚙️ Runtime API calls

*No calls matching the listed runtime API prefixes were detected.*

## 🧪 Static-analysis notes

- Generated directly from the uploaded server ZIP; source names, signatures, literal dependencies, and line counts were inspected from this copy.
- Function parameter names preserve Lua declaration spelling and order; Lua varargs are shown as `...`.
- Table rows are **initializer expressions**, not guarantees about contents after runtime mutation. Tables built dynamically may not appear.
- Anonymous functions and local functions assigned through computed keys are not fully enumerable using static pattern analysis.
- No Net/Async runtime behavior, battle compatibility, error contracts, or inferred type information is asserted without source support.
