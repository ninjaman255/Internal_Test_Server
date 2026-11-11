> **2026-11-11 — Current PlayerControl migration:** New scoped PlayerControl now handles HP desktop/Background/Real Time/Warp/Jukebox sessions and the free camera has an owned capture lease. This is a first-stage migration; other direct engine-lock and scripted-camera callers remain. Read the [current PlayerControl API](player-control/README.md), [migration inventory](player-control/MIGRATION_AUDIT.md), and [Tiled setup](areas/HP_MANAGER_TILED.md). The remainder of this guide originates from an earlier project snapshot.

# 🧭 Current Systems Guide — Internal Test Server

[🏠 Documentation home](index.md) · [📋 Snapshot report](SNAPSHOT_REPORT.md)

> **Scope:** The uploaded `internal_test_server(2).zip` (2026-11-11). These notes describe the current **Lua source**, not a runtime-tested server. Existing historical READMEs are retained in the source tree; where a description conflicts, use the linked source and generated function reference.

## 🗂️ Contents

- [⚔️ Encounter registration and routing](#encounter-registration-and-routing)
- [🎁 Reward ownership and outcome](#reward-ownership-and-outcome)
- [🌌 Liberation enemy configuration](#liberation-enemy-configuration)
- [📐 Battle scale vs HP](#battle-scale-vs-hp)
- [🎮 Input-controller ownership](#input-controller-ownership)
- [🧾 Concrete encounter examples](#concrete-encounter-examples)
- [🔗 Further references](#further-references)

## ⚔️ Encounter registration and routing

| Area | Current source behavior | Reference |
|---|---|---|
| Random encounters | The `encounters` array is the random pool; boss and special lists do not enter that pool. | [`ezencounters/main.lua`](ezlibs-scripts/ezencounters/main/index.md) |
| Named encounters | `get_encounter_by_name(encounter_name, area_id)` resolves an area-specific encounter. Without `area_id`, duplicated names across areas are ambiguous and return `nil`. | [`ezencounters/main.lua`](ezlibs-scripts/ezencounters/main/index.md) |
| Explicit package paths | `resolve_encounter(encounter_reference, area_id)` looks up a name, or accepts a direct path (slash/backslash/`.zip`). An unknown unqualified name returns `nil`. | [`ezencounters/main.lua`](ezlibs-scripts/ezencounters/main/index.md) |
| Liberation pools | `panel_encounters.lua` documents `encounters`, `bosses`, and `special_encounters`. Its category selectors fall back to `encounters` when their optional lists are missing/empty. | [`panel_encounters.lua`](ezlibs-custom/nebulous-liberations/liberations/panel_encounters/index.md) |
| Battle runtime data | `begin_encounter(...)` merges runtime-only data into a fresh encounter payload rather than mutating the cached area definition. | [`ezencounters/main.lua`](ezlibs-scripts/ezencounters/main/index.md) |

**Main entry point signatures (source):** `get_encounter_by_name(encounter_name, area_id)`, `resolve_encounter(encounter_reference, area_id)`, `begin_encounter_by_name(player_id, encounter_name, trigger_object, runtime_data)`, and `begin_encounter(player_id, encounter_info, trigger_object, runtime_data)`.

## 🎁 Reward ownership and outcome

The new [`ezencounters/rewards.lua`](ezlibs-scripts/ezencounters/rewards/index.md) owns the hybrid reward processing. The declared precedence is **`runtime_data.rewards` → `encounter_info.rewards` → `area_table.rewards` → `area_table.enemy_rewards`**. This is replacement priority, not automatically additive across all levels. Explicit callback rewards may be appended. A literal `false` or `{ enabled = false }` disables configured rewards.

| Reward type | Native packet type value | Relevant source condition |
|---|---:|---|
| Money | `0` | Persisted using the module's ezmemory handling |
| Chip | `1` | Requires a nonempty card/package id and code; **owned-chip inventory persistence is caller-owned** |
| HP | `2` | Can be disabled by `disable_health_rewards`; for regular encounters persistent health is an explicit opt-in |
| BugFrags | `3` | Persisted using the module's ezmemory handling |

Rewards are victory-gated: `Rewards.is_victory(stats)` rejects runs and missing battle results; when an outcome `reason` exists, it treats only `reason == 1` as victory. Encounter battle-result handling clears the managed context before processing to avoid duplicate grants.

**External game modes:** `ezencounters.register_external_battle(player_id, encounter_data, options)` and `clear_external_battle(player_id, token)` provide opt-in reward management. **Nebulous Liberations deliberately does not register its battles** and uses its panel/mission loot path instead. This separation is stated explicitly in both the encounter and reward modules.

## 🌌 Liberation enemy configuration

The [`liberations/enemy_config.lua`](ezlibs-custom/nebulous-liberations/liberations/enemy_config/index.md) resolver uses Tiled object properties. Its effective precedence is:

1. Direct properties on the enemy/panel object.
2. Its referenced `Liberation Enemy Config` object, if any.
3. `Liberation Enemy Defaults` for the matching category.
4. `Liberation Enemy Defaults` in the `All` category.
5. An enemy template for defaults not resolved above.

The resolver also has **legacy HP/scale handling** inside `Config.resolve(...)`; the rule above is about the config layers, not a guarantee that every legacy field is evaluated identically. In particular, `Max HP`, `Starting HP`, `OW Scale`, `Battle Scale`, and the older local `scale` are handled explicitly. Its returned configuration can include OW attack/defense modifiers, battle attack/defense multipliers, AI type, encounter name/mode/pool/category, and battle scale scope.

| Function | Declared arguments | Role grounded in code |
|---|---|---|
| `Config.resolve` | `area_id, source, legacy_health_property, category` | Resolves Tiled properties and inherits defaults; default category is `Dark Hole` |
| `Config.apply` | `enemy, cfg` | Applies resolved health, scale, combat modifiers and encounter settings to an enemy object |

## 📐 Battle scale vs HP

[`liberations/battle_scale.lua`](ezlibs-custom/nebulous-liberations/liberations/battle_scale/index.md) applies a **configured visual scale to selected encounter enemy entries**, without rewriting the cached definition. It is intentionally separate from persistent overworld health. It supports the following selectors:

| Scope | Selection behavior |
|---|---|
| `Matching` (default) | Match enemy aliases/display names; with exactly one enemy, use that as an unambiguous fallback. Non-matching multi-enemy definitions are left unchanged. |
| `All` | Apply to all enemy entries (explicit authoring option). |

An explicitly configured `Battle Scale`, a non-1 scale, or scope `All` may replace an entry's authored scale. Otherwise an authored enemy-entry scale takes precedence over a default 1x overworld scale. The function to inspect is `BattleScale.apply(data, source, options)`.

**HP is a separate concern:** `Config.apply(...)` sets `max_health` and `health` where values are configured, and caps `starting_hp` at the effective maximum. The Liberation mission's encounter builder copies enemy data per battle; it does not write derived battle data into its cached encounter definition.

## 🎮 Input-controller ownership

[`input-controller/input-controller.lua`](input-controller/input-controller/index.md) has exclusive logical ownership for interactive control. It continues collecting raw input, but when an owner is set, edge polling requires that owner. The source provides these operations:

| API | Declared arguments | Source behavior |
|---|---|---|
| `claim_input` | `owner, force` | Rejects missing owner/destroyed controller; returns true for a repeat claim by the same owner; otherwise requires unclaimed state or an explicit forced handoff |
| `release_input` | `owner` | Only the current owner can release |
| `has_input_control` | `owner` | Tests current exclusive ownership |
| `get_input_owner` | *(none)* | Returns the stored owner |
| `require_release` | `actions, owner` | Establishes held-input release requirements |
| `consume` | `owner` | Consumes action edges for the permitted owner |

The source documents that `force` is intended for an **explicit context transition**, not repeated ownership stealing. Owner changes emit `input_owner_changed` events; held buttons must be released before the new owner can act on them.

## 🧾 Concrete encounter examples

The uploaded [`encounters/DEBUGLIB.lua`](encounters/DEBUGLIB/index.md) includes top-level `encounters`, `special_encounters`, and `bosses` arrays. Its authored `freedom_mission` objects use `turn_count = 3` and `player_can_flip = false`. These are values observed in this example, **not a claim about a global default**. The [encounter source field inventory](ENCOUNTER_FIELD_INVENTORY.md) distinguishes authored keys from properties guaranteed by the caller.

## 🔗 Further references

- [🌌 Nebulous Liberations module directory](ezlibs-custom/nebulous-liberations/index.md)
- [⚔️ All example encounters](encounters/index.md)
- [🧠 `ezencounters` directory](ezlibs-scripts/ezencounters/index.md)
- [🧩 Input Controller directory](input-controller/index.md)
- [📋 Change and coverage report](SNAPSHOT_REPORT.md)
