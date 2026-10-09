# 📚 ezlibs Library — Complete Documentation

> 📝 **Documentation note**
>
> I'll document this across multiple messages, organized by system/module. This message covers the **overview**, **directory structure**, and the **Core Infrastructure** layer. Subsequent messages will cover the higher‑level systems.

## 🗂️ Table of Contents

- [🧭 Part 1 — Overview & Core Infrastructure](#part-1)
- [💾 Part 2 — ezmemory (Player/Area Memory) & ezusers (Roles/Permissions)](#part-2)
- [🎛️ Part 3 — eztriggers, ezbuttons, ezcheckpoints, ezlocks, ezexplosions](#part-3)
- [💬 Part 4 — eznpcs & dialogue_types](#part-4)
- [🌀 Part 5 — ezwarps (Warp Objects & Animations)](#part-5)
- [✉️ Part 6 — ezemail, ezmail, and ezannounce](#part-6)
- [📌 Part 7 — ezbbs (Bulletin Board System)](#part-7)
- [🌱 Part 8 — ezfarms](#part-8)
- [💎 Part 9 — ezmystery](#part-9)
- [🧩 Part 10 — ezquests, ezpress, ezchristmas, ezrushroads, ezweather, ezmenus](#part-10)
- [🧱 Part 11 — generate-ezlibs-tiled.lua (Tiled Type Generator)](#part-11)
- [🔎 Part 12 — Final Combined Cross‑Reference](#part-12)
- [🧰 Part 13 — Utility Modules](#part-13)

---

<a id="part-1"></a>
## 🧭 Part 1 — Overview & Core Infrastructure

### 1.1 Overview

`ezlibs` is a modular Lua library for a server runtime that exposes a global `Net` API (event‑driven, with async primitives `Async`, `async`, `await`). It provides systems for:

- Player/area memory persistence (`ezmemory`)
- Server‑client event routing (`main.lua`)
- Custom Tiled object handling via a registry (`object_registry`)
- Region/radius/interact triggers (`eztriggers`)
- NPCs with dialogue state machines (`eznpcs`)
- BBS boards (`ezbbs`)
- In‑game email + server announcements (`ezemail`, `ezannounce`)
- Warp objects with animated transitions (`ezwarps`)
- Weather (`ezweather`)
- Buttons with chain unlocking (`ezbuttons`)
- Farming (`ezfarms`)
- Mystery Data / quiz / reward objects (`ezmystery`)
- Checkpoints / locks (`ezcheckpoints`, `ezlocks`)
- Random and radius encounters (`ezencounters`)
- Rush Roads minigame (`ezrushroads`)
- "Minish Mode" compression (`ezpress`)
- Explosion VFX (`ezexplosions`)
- Quest framework (`ezquests`)
- Users/roles/permissions (`ezusers`)
- Cross‑cutting helpers (`helpers`, `utils/ezutil.lua`, `utils/ezvalidate.lua`, `utils/ezdebug.lua`), event bus (`ezbus`), JSON (`json`), SHA‑256 (`sha256`), URL encoding (`urlencode`), direction math (`direction`), condition evaluation (`condition`), object cache (`ezcache`), avatar asset copy/parse (`avatar_utils`)

---

### 1.2 Directory Layout (as inferred from require paths)

```
scripts/
  ezlibs-scripts/
    main.lua
    ezconfig.lua
    helpers.lua
    json.lua
    urlencode.lua
    sha256.lua
    direction.lua
    condition.lua
    ezcache.lua
    object_registry.lua
    ezbus.lua
    ezemitter.lua
    ezmemory.lua
    ezusers.lua
    ezemail.lua
    ezmail.lua
    ezbbs.lua
    ezmenus.lua
    ezweather.lua
    eztriggers.lua
    ezlocks.lua
    ezcheckpoints.lua
    ezexplosions.lua
    ezfarms.lua
    ezmystery.lua
    ezquests.lua
    ezrushroads.lua
    ezpress.lua
    ezbuttons.lua
    ezchristmas.lua
    generate-ezlibs-tiled.lua

    utils/
      ezutil.lua
      ezvalidate.lua
      ezdebug.lua

    ezannounce/
      announcements_feed.lua
      ezannounce.lua

    eznpcs/
      dialogue_types.lua
      eznpcs.lua

    ezwarps/
      main.lua
      arrow_animation_factory.lua
      fall_in_animation.lua
      fall_off_2.lua
      lev_beast_in_animation.lua
      lev_beast_out_animation.lua
      log_in_animation.lua

    ezencounters/
      main.lua

    avatar_utils/
      main.lua
      avatar_utils.lua
      base64.lua
      lua_yes_parser/lib.lua   (not documented here)

scripts/
  events/
    eznpcs_onceitem.lua   (loaded via safe_require from main.lua)
    eznpcs_events.lua     (loaded via safe_require from eznpcs.lua)
```

---

### 1.3 `helpers.lua`

Global utility functions. Most are provided on the `helpers` table. Some free functions (`async`, `await`, `first_value_from_table`, `get_table_length`) are also exported at the module level.

#### Globals defined when this module loads

| Name | Signature | Description |
|------|-----------|-------------|
| `async(p)` | `function(p: function): Promise` | Wraps a coroutine body `p` and returns `Async.promisify(co)`. |
| `await(v)` | `function(v: Promise): any` | Alias for `Async.await(v)`. |
| `first_value_from_table(tbl)` | `function(tbl: table): any` | Returns the value of the first `pairs` entry, or `nil`. |
| `get_table_length(tbl)` | `function(tbl: table): number` | Counts entries by iterating `pairs`. |

> 💡 **Note:** these are defined as **globals**, not on the `helpers` table.

#### `helpers` table API

| Function | Parameters | Returns | Notes |
|----------|-----------|---------|-------|
| `helpers.indexOf(array, value)` | `array: table`, `value: any` | `number\|nil` | 1‑based index using `ipairs`. |
| `helpers.extract_numbered_properties(object, property_prefix)` | `object: TiledObject`, `property_prefix: string` | `table` | Iterates `i=1..20` reading `object.custom_properties[property_prefix..i]`. Returns array. |
| `helpers.clear_table(tbl)` | `tbl: table` | `nil` | Sets indices `0..#tbl` to nil. |
| `helpers.create_bbs_option(text, id)` | `text: string`, `id: string\|nil` | `table` | Returns `{id=text, read=true, title=text, author=""}`. If `id` given, `id=id` is used for `id` key too — actually `id=text` is used. (See code: `return {id= text, read= true, title=text, author= ""}`.) |
| `helpers.deep_copy(orig)` | `orig: any` | `any` | Deep copy preserving metatables. |
| `helpers.split(string, delimiter)` | `string: string`, `delimiter: string` | `table` | Character class split — note: delimiter is embedded into a gmatch pattern. |
| `helpers.get_safe_player_secret(player_id)` | `player_id` | `string` | Takes `Net.get_player_secret(player_id):sub(2,32)` and URL‑encodes it. |
| `helpers.safe_require(script_path)` | `script_path: string` | `any\|nil` | `pcall`‑based require; logs warnings. |
| `helpers.date_string_to_timestamp(date_string)` | `date_string: string` (space separated: sec min hour day month year) | `number\|nil` | `*` means "keep current". Requires at least 6 parts. |
| `helpers.is_now_before_date(date_string)` | `date_string: string` | `boolean` | `os.time() < helpers.date_string_to_timestamp(...)`. |
| `helpers.position_overlaps_something(position, area_id)` | `position: {x,y,z,size}`, `area_id` | `boolean` | Checks all players in the area; `abs` deltas `< size` on X and Y, and equal Z. |
| `helpers.get_lock(player_id, lock_id, timeout?)` | `player_id`, `lock_id: string`, `timeout: number?` | `lock\|false` | Lock object has `.release()`. If already locked, returns `false`. |
| `helpers.read_item_information(area_id, item_object_id)` | `area_id`, `item_object_id` | `item\|false` | Reads `Name`, `Amount`, `Description`, `Type`, `Price` from a cached object's custom_properties. Validates `keyitem`/`item` need `Name`, `keyitem` needs `Description`. |
| `helpers.ensure_directory(path)` | `path: string` | `nil` | Tries LuaFileSystem first, then `os.execute mkdir`. |

#### Events registered

- `Net:on("player_disconnect", ...)` — releases all locks owned by the disconnecting player.

#### Item info structure returned by `read_item_information`

```lua
{
  name        = string,
  amount      = number  (default 1),
  description = string  (default "???"),
  type        = string  ("item" default; "keyitem", "money", "fragments", "tokens" also handled),
  price       = number  (default 999999)
}
```

---

### 1.4 `json.lua`

Pure‑Lua JSON library (rxi/json.lua v0.1.2). **API**:

| Function | Parameters | Returns |
|----------|-----------|---------|
| `json.encode(val, pretty?)` | `val: any`, `pretty: boolean\|string?` | `string` |
| `json.decode(str)` | `str: string` | `any` |

- `encode` supports pretty printing when `pretty` is a string (indent unit) or `true` (2‑space).
- Circular refs and mixed‑key tables raise errors.
- `decode` accepts standard JSON; error messages include line/col.

---

### 1.5 `urlencode.lua`

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `urlencode.string(str)` | `str: string` | `string` | RFC 3986 unreserved chars kept; space→`+`; other chars `%XX`. Newlines normalized to CRLF. |
| `urlencode.table(t)` | `t: table` | `string` | `k=v&k=v` form. |

---

### 1.6 `sha256.lua`

Pure‑Lua SHA library (Egor‑Skriptunoff's pure_lua_SHA v12). It auto‑selects an implementation branch based on the runtime's capabilities (FFI, INT64, INT32, LIB32, EMUL).

#### Main API

| Function | Parameters | Returns |
|----------|-----------|---------|
| `sha.md5(message)` | `message: string` | `string` (hex) |
| `sha.sha1(message)` | `message: string` | `string` |
| `sha.sha224(message)` / `sha.sha256(message)` | `string` | `string` |
| `sha.sha384(message)` / `sha.sha512(message)` | `string` | `string` |
| `sha.sha512_224(message)` / `sha.sha512_256(message)` | `string` | `string` |
| `sha.sha3_224(message)` / `sha3_256` / `sha3_384` / `sha3_512` | `string` | `string` |
| `sha.shake128(digest_size_in_bytes, message)` | `number, string` | `string` |
| `sha.shake256(digest_size_in_bytes, message)` | `number, string` | `string` |
| `sha.hmac(hash_func, key, message)` | `function, string, string` | `string` |
| `sha.hex_to_bin(str)` / `hex2bin` | `string` | `string` |
| `sha.bin_to_hex(str)` / `bin2hex` | `string` | `string` |
| `sha.base64_to_bin(str)` / `base642bin` | `string` | `string` |
| `sha.bin_to_base64(str)` / `bin2base64` | `string` | `string` |
| `sha.blake2b(message, key?, salt?, digest_size?)` | see below | `string` |
| `sha.blake2s(message, key?, salt?, digest_size?)` | | |
| `sha.blake2bp`, `sha.blake2sp` | | |
| `sha.blake2xb(digest_size, message, key?, salt?)` | | |
| `sha.blake2xs(digest_size, message, key?, salt?)` | | |
| `sha.blake2` (= `blake2b`) | | |
| `sha.blake2b_160`, `blake2b_256`, `blake2b_384`, `blake2b_512` | | |
| `sha.blake2s_128`, `blake2s_160`, `blake2s_224`, `blake2s_256` | | |
| `sha.blake3(message, key?, digest_size?, message_flags?, K?, return_array?)` | | |
| `sha.blake3_derive_key(key_material, context_string, derived_key_size?)` | | |

Every hash function supports "chunk‑by‑chunk" input mode: call `sha.sha256()` with no message to obtain a function `partial`; feed chunks via `partial(chunk)`; call `partial()` with no argument to obtain the hex digest.

> Only `sha.sha256` is used directly by ezlibs (in `ezusers.lua`).

---

### 1.7 `ezconfig.lua`

Loads `ezlibs-config` (a Lua module in the server root) and returns it. Errors if missing.

Fields referenced elsewhere (not defined here — must be provided by the user's `ezlibs-config.lua`):

| Key | Used by |
|-----|---------|
| `PLAYERS_PATH` | `ezmemory` |
| `ITEMS_PATH` | `ezmemory` |
| `AREA_PATH_FOLDER` | `ezmemory` |
| `PLAYER_PATH_FOLDER` | `ezmemory` |
| `BOARD_PATH_FOLDER` | `ezbbs` |
| `FARM_MAP` | `ezfarms` |
| `FARM_TIMESCALE` | `ezfarms` |
| `ENCOUNTERS_PATH` | `ezencounters` |
| `ADMIN_SEED` | `ezusers` |
| `NEW_MAIL_MESSAGE_DELAY` | `ezemail` / `ezmail` |

---

### 1.8 `ezcache.lua`

Central cache for specific Tiled object types so they can be hidden from the server's object list and looked up by ID efficiently.

| Field/Function | Parameters | Returns | Notes |
|----------------|-----------|---------|-------|
| `ezcache.cache` | — | `table` | `cache[area_id][object_id]` |
| `ezcache.cacheable_types` | — | `table` | set of type names |
| `ezcache.add_cacheable_type(type_name)` | `string` | `nil` | Adds to the cacheable set. |
| `ezcache.object_is_of_type(object)` | `object` | `boolean` | `cacheable_types[object.type] == true` |
| `ezcache.cache_object(area_id, object)` | `area_id`, `object` | `object\|nil` | Stores and calls `Net.remove_object(area_id, object.id)`. |
| `ezcache.get_object_by_id_cached(area_id, object_id)` | `area_id`, `object_id` | `object\|nil` | Returns from cache, else fetches via `Net.get_object_by_id` (numeric id used). Caches if type qualifies. |

---

### 1.9 `object_registry.lua`

Runs callbacks for Tiled objects whose `type` matches registered handlers, then optionally caches them.

| Function | Parameters | Returns | Notes |
|----------|-----------|---------|-------|
| `object_registry.register_handler(object_type, callback, cache?)` | `string`, `function(area_id, object)`, `boolean?` (default `true`) | `nil` | Adds callback; if caching enabled, `ezcache.add_cacheable_type(object_type)`. |
| `object_registry.load_all()` | none | `nil` | Iterates every area/object once; for each matching type, runs all handlers **then** caches. |

`object_registry.handlers[type]` = array of callbacks; `object_registry.types_to_cache[type]` = boolean.

---

### 1.10 `ezemitter.lua`

Generic EventEmitter (used by `ezbus` and by `eztriggers`).

| Method | Parameters | Returns |
|--------|-----------|---------|
| `EventEmitter.new()` | — | instance |
| `:on(event, callback)` | `string, function` | self |
| `:once(event, callback)` | `string, function` | self |
| `:on_any(callback)` | `function` | self |
| `:on_any_once(callback)` | `function` | self |
| `:emit(event, ...)` | `string, ...` | self |
| `:remove_listener(event, callback)` | `string, function` | self |
| `:remove_on_any_listener(callback)` | `function` | self |
| `:async_iter(event)` | `string` | iterator function |
| `:async_iter_all()` | — | iterator function |
| `:destroy()` | — | nil |

- `emit` calls regular, once, any, and any‑once listeners. `once` listeners are cleared after firing. `any_once` listeners are cleared after any emit.
- `async_iter` returns a function that yields either queued args or a promise resolver.

---

### 1.11 `ezbus.lua`

```lua
local EzEmitter = require('scripts/ezlibs-scripts/ezemitter')
local ezbus = EzEmitter.new()
return ezbus
```

A single shared `EventEmitter` instance. All subsystems use `ezbus:on(...)` / `ezbus:emit(...)`.

#### Known event names used across ezlibs

| Event | Emitted by | Payload (fields) |
|-------|-----------|------------------|
| `announcement_sent` | `ezannounce` | `player_id`, `announcement_id` |
| `email_sent` | `ezemail` | `player_id`, `email_id`, `persistent` |
| `item_gained` | `ezmemory` | `player_id`, `item_name`, `amount`, `new_total` |
| `item_lost` | `ezmemory` | `player_id`, `item_name`, `amount_removed`, `remaining` |
| `money_spent` | `ezmemory` | `player_id`, `amount`, `new_balance` |
| `money_changed` | `ezmemory` | `player_id`, `new_balance` |
| `fragments_changed` | `ezmemory` | `player_id`, `new_total` |
| `tokens_changed` | `ezmemory` | `player_id`, `new_total` |
| `health_changed` | `ezmemory` | `player_id`, `new_health`, `new_max_health` |
| `object_hidden` | `ezmemory` | `player_id`, `area_id`, `object_id`, `persistent` |
| `checkpoint_unlocked` | `ezcheckpoints` | `player_id`, `area_id`, `object_id` |
| `lock_attempt` | `ezlocks` | `player_id`, `type`, `passed`, extra args |
| `explode` | (emitter side) | `actor_id`, `area_id`, `max_explosions` |
| `weather_changed` | `ezweather` | `area_id`, `new_type` |
| `ezbuttons.chain_unlocked` | `ezbuttons` | `player_id`, `chain_root`, `area_id` |
| `player_compressed` / `player_decompressed` | `ezpress` | `player_id` |
| `mystery_collected` | `ezmystery` | `player_id`, `area_id`, `object_id`, `item_info` |
| `encounter_started` | `ezencounters` | `player_id`, `encounter_info`, `trigger_object` |
| `encounter_finished` | `ezencounters` | `player_id`, `stats` |
| `rush_tile_entered` / `rush_tile_departed` | `ezrushroads` | `player_id`, `area_id`, `road_id`, `bot_name` |
| `quest_event` | `dialogue_types` (quest_event) | `player_id`, `quest_name`, `event_value` |
| `warp` | `ezwarps` | `player_id`, `from_area`, `to_area`, `warp_type` |
| `dialogue_ended` | `eznpcs` | `player_id`, `npc_id` |

---

### 1.12 `direction.lua`

| Field/Function | Parameters | Returns |
|----------------|-----------|---------|
| `Direction.UP/LEFT/DOWN/RIGHT/UP_LEFT/UP_RIGHT/DOWN_LEFT/DOWN_RIGHT` | — | `string` ("Up", "Down Left", etc.) |
| `Direction.list` | — | array of all directions |
| `Direction.reverse(direction)` | `string` | `string` |
| `Direction.to_vector(direction_str)` | `string` | `{x:number, y:number}` |
| `Direction.from_points(point_a, point_b)` | `{x,y,z}`, `{x,y,z}` | `string` |
| `Direction.from_offset(x, y)` | `number, number` | `string` |

---

### 1.13 `condition.lua`

| Function | Parameters | Returns | Notes |
|----------|-----------|---------|-------|
| `condition.date_before(date_string)` | `string` | `boolean` | via `helpers.is_now_before_date` |
| `condition.date_after(date_string)` | `string` | `boolean` | |
| `condition.item(player_id, item_name, amount?, consume?)` | | `boolean` | If `consume`, calls `ezmemory.remove_player_item`. |
| `condition.money(player_id, amount?, consume?)` | | `boolean` | If `consume`, uses `ezmemory.spend_player_money`. |
| `condition.fragments(player_id, amount?, consume?)` | | `boolean` | Uses `ezmemory.get_player_fragments` / `spend_player_fragments`. |
| `condition.tokens(player_id, amount?, consume?)` | | `boolean` | Uses `ezmemory.get_player_tokens` / `spend_player_tokens`. |
| `condition.quest_flag(player_id, quest_name, flag_name, expected?, op?)` | | `boolean` | Compares flag value to `expected`. `expected==nil` means "is truthy". Ops: `==`, `!=`, `>=`, `<=`, `>`, `<`. |
| `condition.evaluate(player_id, cond)` | `player_id`, `cond` | `boolean` | Dispatches by `cond.type`. Types: `date_before`, `date_after`, `item`, `money`, `fragments`, `tokens`, `quest_flag`. |

Condition table shapes:
```lua
{ type="date_before", date="sec min hour day month year" }
{ type="date_after",  date="..." }
{ type="item",     name=string, amount=number, consume=bool }
{ type="money",    amount=number, consume=bool }
{ type="fragments",amount=number, consume=bool }
{ type="tokens",   amount=number, consume=bool }
{ type="quest_flag", quest=string, flag=string, value=any, op=string }
```

---

### 1.14 `main.lua` (root)

Bootstraps the whole library: requires every module, registers the object registry preload, hooks all `Net:on` events, and fans out to each module's `handle_*` hooks.

#### SFX provided to every joining player

```lua
local sfx = {
  hurt       = '/server/assets/ezlibs-assets/sfx/hurt.ogg',
  item_get   = '/server/assets/ezlibs-assets/sfx/item_get.ogg',
  recover    = '/server/assets/ezlibs-assets/sfx/recover.ogg',
  card_error = '/server/assets/ezlibs-assets/ezfarms/card_error.ogg',
  compressSfx= '/server/assets/ezlibs-assets/sfx/compress.ogg'
}
```

#### Load order (plugins array)

`ezweather, eznpcs, ezmemory, ezmystery, ezwarps, ezencounters, eztriggers, ezemail, ezannouncement, ezcheckpoints, ezrushroads, ezpress, ezusers, ezbbs, ezbuttons` (+ optional user `custom_plugin` from `scripts/ezlibs-custom/custom`).

#### `Net` event fan‑out

For each `Net:on("<event>", ...)` handler, `main.lua` iterates the `plugins` array calling `<plugin>.handle_<event>(...)` if present:

| Net event | Handlers called |
|-----------|-----------------|
| `battle_results` | `plugin.handle_battle_results(player_id, stats)` |
| `shop_purchase` | `plugin.handle_shop_purchase(player_id, item_name)` |
| `shop_close` | `plugin.handle_shop_close(player_id)` |
| `custom_warp` | `plugin.handle_custom_warp(player_id, object_id)` |
| `player_move` | `plugin.handle_player_move(player_id, x, y, z)` |
| `player_request` | `plugin.handle_player_request(player_id, data)` |
| `tile_interaction` | `plugin.handle_tile_interaction(player_id, x, y, z, button)` |
| `post_selection` | `plugin.handle_post_selection(player_id, post_id)` |
| `board_close` | `plugin.handle_board_close(player_id)` |
| `player_avatar_change` | `plugin.handle_player_avatar_change(player_id, details)` |
| `player_join` | `plugin.handle_player_join(player_id)`; then provides `sfx` |
| `actor_interaction` | `plugin.handle_actor_interaction(player_id, actor_id, button)` |
| `tick` | `plugin.on_tick(delta_time)` |
| `player_disconnect` | `plugin.handle_player_disconnect(player_id)` |
| `object_interaction` | `plugin.handle_object_interaction(player_id, object_id, button)` |
| `player_area_transfer` | `plugin.handle_player_transfer(player_id)` |
| `textbox_response` | `plugin.handle_textbox_response(player_id, response)` |

#### Startup actions (in order)

1. `object_registry.load_all()`
2. `eznpcs.load_npcs()`
3. `ezrushroads.init()`
4. Print `[main] ezlibs loaded in <seconds>s`.

#### `battle_results` payload passed to plugins (`stats`)

```lua
{
  health   = number,
  time     = number,
  ran      = bool,
  emotion  = number,
  turns    = number,
  enemies  = ?,       -- passed through
  score    = number
}
```

#### `player_avatar_change` `details` passed to plugins

```lua
{
  texture_path        = string,
  animation_path      = string,
  name                = string,
  element             = ?,
  max_health          = number,
  prevent_default     = ?
}
```

---

<a id="part-2"></a>
## 💾 Part 2 — ezmemory (Player/Area Memory) & ezusers (Roles/Permissions)

### 2.1 ezmemory.lua

Central persistence layer. Manages player memory, area memory, items, and hidden objects. Interacts with the filesystem via Async.read_file / Async.write_file and a JSON codec.

#### 2.1.1 Files & directories at startup

Ensures ./memory/ exists.

Ensures parent dir of ezconfig.PLAYERS_PATH and ezconfig.ITEMS_PATH exists.

Creates PLAYERS_PATH and ITEMS_PATH (default content "{}") if missing.

Ensures ezconfig.AREA_PATH_FOLDER and ezconfig.PLAYER_PATH_FOLDER exist.

#### 2.1.2 File path helpers

get_file_paths(base):

If base ends in .json: main = base, backup = base with _backup.json inserted before .json.

Otherwise: main = base .. ".json", backup = base .. "_backup.json".

ezmemory_load_file(file_path) (async): reads main, falls back to backup, returns {} if both fail.

ezmemory_save_file(file_path, value) (async): writes backup first, then main.

#### 2.1.3 Internal state

```lua
player_memory       = {}  -- [safe_secret] = memory table
area_memory         = {}  -- [area_id]     = memory table
player_list         = {}  -- [safe_secret] = player_name
player_avatar_details = {}-- [player_id]   = avatar details
items               = {}  -- [item_id]     = item record
item_name_table     = {}  -- [item_name]   = item_id
objects_hidden_till_disconnect_for_player = {} -- [player_id][area_id][object_id] = true
highest_item_id     = 1
memory_loaded_flags = {area_memory=false, player_memory=false, items=false}.
```

#### 2.1.4 Player memory schema

```lua
{
  items       = { [item_id] = quantity },
  money       = number,
  fragments   = number,
  tokens      = number,
  meta        = { joins = number },
  area_memory = { [area_id] = { hidden_objects = { [object_id] = true } } },
  emails      = { by_id = { [email_id] = { ... } } },
  role        = string,           -- set by ezusers
  permissions = table,            -- set by ezusers
  quests      = { [quest_name] = { [flag_name] = value } },
  farming     = { water = number },-- set by ezfarms
  health      = number,           -- cached
  max_health  = number,
}
```

#### 2.1.5 Area memory schema

```lua
{
  hidden_objects = { [object_id] = true },
  buttons        = { [object_id] = true },
  tile_states    = { [loc_string] = { gid, x, y, z, plant, owner, time = {tilled, watered, planted, death} } },
  rain_started   = number|nil,
  timed_button_unlock_info = { [root_id] = { player_id, area_id, checkpoint_object_id } },
  area_wide_unlock         = { [root_id] = { area_id, checkpoint_object_id, once } },
}
```

#### 2.1.6 Item schema

```lua
{
  name        = string,
  description = string,
  key_item    = boolean,
}
```

#### 2.1.7 Public API

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `ezmemory.is_loaded()` | — | boolean | All three flags true. |
| `ezmemory.wait_until_loaded()` | — | Promise | Async poll loop; sleeps 0.2 s between checks. |
| `ezmemory.get_item_info(item_id)` | string\|number | table\|nil |  |
| `ezmemory.create_or_update_item(item_name, item_description, is_key)` | string, string, bool | item_id:string | Uses highest_item_id+1 when new. Calls Net.create_item when is_key. Saves items. |
| `ezmemory.get_item_id_by_name(item_name)` | string | string\|nil | Errors if items not loaded yet. |
| `ezmemory.get_or_create_item(item_name, item_description, is_key)` | string, string, bool | item_id:string |  |
| `ezmemory.save_items()` | — | (async) | Writes items. |
| `ezmemory.save_area_memory(area_id)` | string | (async) |  |
| `ezmemory.save_player_memory(safe_secret)` | string | (async) |  |
| `ezmemory.dangerously_override_player_memory(safe_secret, new_memory)` | string, table | (async) | Only writes if a memory entry exists. |
| `ezmemory.get_area_memory(area_id)` | string | table | Loads on demand, initializes {hidden_objects={}}. |
| `ezmemory.get_player_memory(safe_secret)` | string | table | Errors if player_memory not loaded. Creates default if missing. |
| `ezmemory.get_player_area_memory(safe_secret, area_id)` | string, string | table | Creates {hidden_objects={}} on demand. |
| `ezmemory.update_player_list(safe_secret, name)` | string, string | (async) |  |
| `ezmemory.get_player_name_from_safesecret(safe_secret)` | string | string (default "Unknown") |  |
| `ezmemory.give_player_item(player_id, name, amount?)` |  | number | Default amount=1. Sends item_gained on bus. Special-cases "HPMem" to bump max HP. |
| `ezmemory.remove_player_item(player_id, name, remove_quant)` |  | number | Remaining count. Sends item_lost. |
| `ezmemory.get_player_money(player_id)` |  | number\|nil | Reconciles with Net.get_player_money. |
| `ezmemory.spend_player_money(player_id, amount)` |  | boolean | Sends money_spent. |
| `ezmemory.set_player_money(player_id, money)` |  | — | Sends money_changed. |
| `ezmemory.get_player_fragments(player_id)` |  | number\|nil |  |
| `ezmemory.set_player_fragments(player_id, fragments)` |  | — | Sends fragments_changed. Errors if not supported. |
| `ezmemory.add_player_fragments(player_id, amount)` |  | boolean |  |
| `ezmemory.spend_player_fragments(player_id, amount)` |  | boolean |  |
| `ezmemory.get_player_tokens(player_id)` |  | number | Non‑negative integer, floors. |
| `ezmemory.set_player_tokens(player_id, tokens)` |  | number | Sends tokens_changed. |
| `ezmemory.add_player_tokens(player_id, amount)` |  | number |  |
| `ezmemory.spend_player_tokens(player_id, amount)` |  | boolean | Negative amount adds tokens. |
| `ezmemory.count_player_item(player_id, item_name)` |  | number |  |
| `ezmemory.open_shop_async(player_id, shop_items, mugshot_texture_path, mugshot_animation_path)` |  | Promise | Iterates shop event stream; on shop_purchase spends money and gives item. |
| `ezmemory.hide_object_from_player_till_disconnect(player_id, area_id, object_id)` |  | — | Emits object_hidden with persistent=false. |
| `ezmemory.unhide_object_from_player_till_disconnect(player_id, area_id, object_id)` |  | — | Also calls Net.include_object_for_player if in area. |
| `ezmemory.unhide_object_from_player(player_id, area_id, object_id)` |  | — | Clears persistent entry; includes for player. |
| `ezmemory.hide_object_from_player(player_id, area_id, object_id)` |  | — | Persistent; emits object_hidden with persistent=true. |
| `ezmemory.object_is_hidden_from_player(player_id, area_id, object_id)` |  | boolean | Checks temporary, area, then player memory. |
| `ezmemory.object_is_hidden_from_player_till_disconnect(player_id, area_id, object_id)` |  | boolean |  |
| `ezmemory.handle_player_disconnect(player_id)` |  | — | Clears temporary hidden objects table (global reset). |
| `ezmemory.handle_player_join(player_id)` |  | — | Loads memory, gives key items, reconciles money/fragments/tokens, increments join count, runs transfer logic. |
| `ezmemory.handle_player_transfer(player_id)` |  | — | Re-applies hidden objects (area and per-player), plus excludes related NPC bots. |
| `ezmemory.calculate_player_modified_max_hp(player_id, base_max_hp, hp_memory_modifier, hp_memory_item)` |  | number |  |
| `ezmemory.get_player_max_health(player_id)` |  | number |  |
| `ezmemory.get_player_health(player_id)` |  | number |  |
| `ezmemory.set_player_max_health(player_id, new_max_health, should_heal_by_increase)` |  | — | Emits health_changed. |
| `ezmemory.set_player_health(player_id, new_health)` |  | — | Emits health_changed. |
| `ezmemory.handle_player_avatar_change(player_id, details)` |  | — | Calls update_player_health. |
| `ezmemory.give_item_with_optional_notify(player_id, area_id, item_object_id, item_info?, notify_player?)` |  | Promise | Handles types keyitem, item, money, fragments, tokens. Plays item_get and messages player when notify_player ~= false. |
| `ezmemory.play_anim_get(player_id)` |  | — | Plays ITEM_GET then ITEM_GET_HOLD. Wrapped in pcall. |
| `ezmemory.set_direction_anim(player_id, direction)` |  | — | Plays idle anim for direction. |

#### 2.1.8 update_player_health(player_id) (private)

Reads area custom props:

"Forced Base HP" (number)

"Honor HPMem" (string "true")

"Honor Saved HP" (string "true")

"Full Heal" (string "true")

Sets max HP and current HP accordingly.

#### 2.1.9 Net events registered

Net:on("handle_player_join", ...) — provides item_get sfx.

Net:on("player_request", ...) — kicks player if memory still loading.

#### 2.1.10 Startup

Runs load_all_memory() immediately on require. Loads items (and creates key items via Net.create_item), player list + per‑player memory, and area memory (falling back to initialize_area_memory_file).

### 2.2 ezusers.lua

User roles, permissions, and the "Admin Console" Tiled object.

#### 2.2.1 Configuration

Reads ezconfig.ADMIN_SEED (string). Stores admin_password_hash = sha.sha256(ADMIN_SEED). If seed empty, admin_password_hash = "" and admin access disabled with a warning.

#### 2.2.2 Built‑in roles (permissions table)

```lua
permissions = {
  user = {
    BBS = { CanRead=true, CanPost=false, CanEdit=false, CanDelete=false, CanPin=false },
    Commands = { CanAccess=false }
  },
  admin = {
    BBS = { CanRead=true, CanPost=true, CanEdit=true, CanDelete=true, CanPin=true },
    Commands = { CanAccess=true, CanWarp=true, CanGiftItem=true, CanTakeItem=true, CanKickUser=true }
  }
}
```

#### 2.2.3 Public API (returned table keys)

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `get_role(player_id)` |  | string | Initializes player memory with role="user" + deep‑copied user permissions if missing. |
| `assign_role(player_id, role)` |  | boolean | Resets permissions to the new role's defaults. |
| `get_user_permissions(player_id)` |  | table\|nil |  |
| `set_user_permission(player_id, permission_path, value)` | string\|table, any | boolean | Dot‑separated path ("BBS.CanPost") or array of keys. Creates missing sub‑tables. |
| `reset_user_permissions(player_id)` |  | boolean |  |
| `has_permission(player_id, permission_path)` | string\|table | any\|nil | Traverses. |
| `check_password_and_grant_admin(player_id, password_attempt)` | string | boolean | On success, assigns "admin" role. |
| `add_role(role_name, permission_table)` | string, table | — |  |
| `update_permissions(role_name, permission_updates)` | string, table | — | Shallow merge into existing role permissions. |
| `handle_player_join(player_id)` |  | — | Ensures role & permissions exist (migrates old accounts). |
| `handle_player_disconnect(player_id)` |  | — | No‑op. |

#### 2.2.4 Admin Console object handler

object_registry.register_handler("Admin Console", callback, false) — not cached.

On interaction:

If already admin, message: "You are already an admin." and return.

question_player: "Would you like to enter admin password?".

If 1, prompt_player for password.

If check_password_and_grant_admin succeeds, message: "Password correct. You are now an admin.".

#### 2.2.5 Dependencies

helpers.get_safe_player_secret

ezmemory.get_player_memory / save_player_memory

sha.sha256 (from scripts/ezlibs-scripts/sha256)

ezconfig.ADMIN_SEED

object_registry, eztriggers (for interact trigger)

---

<a id="part-3"></a>
## 🎛️ Part 3 — eztriggers, ezbuttons, ezcheckpoints, ezlocks, ezexplosions

### 3.1 eztriggers.lua

The spatial trigger system. Three trigger kinds (interact, radius, rectangle) plus a "location trigger" wrapper driven by Tiled objects. Also holds a global event table (_event_table) that Location Trigger objects can reference by name.

#### 3.1.1 Internal tables

```lua
eztriggers.interact_triggers  = {}   -- [area_id][trigger_object_id] = { object=..., emitter=... }
eztriggers.radius_triggers    = {}   -- [area_id][trigger_object_id] = { object, emitter, overlapping_players, radius_x, radius_y, center_x, center_y }
eztriggers.rectangle_triggers = {}   -- [area_id][trigger_object_id] = { object, emitter, overlapping_players, width, height }
eztriggers._event_table       = {}   -- [event_name] = { name, action }
```

overlapping_players is [player_id] = true.

#### 3.1.2 Trigger emitters

All three factories return a Net.EventEmitter (see ezemitter.lua). The events they emit:

| Trigger kind | Events |
| --- | --- |
| Interact | "interaction" with {player_id, object, button} |
| Radius | "entered" and "departed" with {player_id, object} |
| Rectangle | "entered" and "departed" with {player_id, object} |

#### 3.1.3 Public API

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `eztriggers.add_location_event_trigger(area_id, object)` | area_id: string, object: TiledObject | nil | Reads object.custom_properties["Event Name"]. Requires object.data.type == "ellipse" or "rect". For ellipse uses object.width/2, object.height/2 as center. Wires an entered handler that looks up the event by name, obtains a lock player_id .. ":" .. event_name, calls event.action(player_id, object).and_then(release). |
| `eztriggers.add_interact_trigger(area_id, trigger_object)` |  | Emitter\|nil | Registers under interact_triggers[area_id][trigger_object.id]. Warns if duplicate. |
| `eztriggers.add_radius_trigger(area_id, trigger_object, diameter_x, diameter_y, center_x, center_y, event_name?)` |  | Emitter\|nil | Stores center_x = trigger_object.x + center_x, center_y = trigger_object.y + center_y, radii = diameters / 2. Warns if duplicate. |
| `eztriggers.add_rectangle_trigger(area_id, trigger_object, width, height, event_name?)` |  | Emitter\|nil | Uses trigger_object.x/y/width/height for the AABB. Warns if duplicate. |
| `eztriggers.handle_object_interaction(player_id, object_id, button)` |  | nil | Emits "interaction" on any matching interact trigger. |
| `eztriggers.handle_player_move(player_id, x, y, z)` |  | nil | Checks all radius triggers (ellipse equation (x-cx)²/rx² + (y-cy)²/ry² <= 1) and rectangle triggers (x >= obj.x and y >= obj.y and x <= obj.x+w and y <= obj.y+h), filtered by trigger_info.object.z == z. Emits entered/departed accordingly. |
| `eztriggers.add_event(event_object)` | {name=string, action=function(player_id, object) -> Promise} | — | Warns if missing name/action or if name already registered. |
| `eztriggers.clear_radius_overlaps_for_player(player_id)` |  | — |  |
| `eztriggers.clear_rectangle_overlaps_for_player(player_id)` |  | — |  |
| `eztriggers.handle_player_transfer(player_id)` |  | — | Clears both radius and rectangle overlaps. |
| `eztriggers.handle_player_disconnect(player_id)` |  | — | Same as above. |

#### 3.1.4 Registered Tiled object type

| Object type | Registered handler | Cache? |
| --- | --- | --- |
| `"Location Trigger"` | eztriggers.add_location_event_trigger(area_id, object) | default (true) |

Requires object.data.type to be "ellipse" or "rect" to build the correct trigger shape.

#### 3.1.5 Notes

Radius triggers require both radius_x and radius_y to be nonzero (else return early).

add_location_event_trigger will still add a trigger even if Event Name is missing, but will warn about the missing event name.

### 3.2 ezbuttons.lua

Overworld buttons built from Tiled objects (a placeholder + a bot + a trigger), chained via "Next 1". Supports unlocking checkpoints, exclusive chains, and area‑wide unlock/relock.

#### 3.2.1 Internal state

```lua
button_placeholders         = {}   -- [area_id][object_id(string)] = info
button_bots                 = {}   -- [bot_id] = info
chain_roots                 = {}   -- [root_placeholder_id(string)] = array of placeholder ids
placeholder_to_chain_root   = {}   -- [placeholder_id] = root_placeholder_id
chain_callbacks             = {}   -- [root_placeholder_id] = function(player_id)
chain_type                  = {}   -- [root_placeholder_id] = "Any" | "Exclusive"
checkpoint_bindings         = {}   -- [root_placeholder_id] = { area_id, checkpoint_object_id, once, area_wide }
button_to_checkpoint        = {}   -- [button_object_id] = { area_id, checkpoint_object_id, once, area_wide }
button_triggers             = {}   -- [trigger_id] = emitter
custom_script_cache         = {}   -- [script_path] = module
chains_built                = false
button_asset_folder = '/server/assets/ezlibs-assets/ezbuttons/', TILE_SIZE = 32.
```

#### 3.2.2 Info table per button (stored in button_placeholders)

```lua
{
  area_id, object_id, bot_id,
  next_id,                -- "Next 1"
  active_anim, inactive_anim,
  behavior,               -- "Repeatable"|"One-Time"|"Dynamic"|"Custom"|"Timed"
  script_path,
  bot_x, bot_y, bot_z,
  activation_anim, activation_duration,
  deactivation_anim, deactivation_duration,
  is_animating (bool),
  trigger_x, trigger_y, trigger_z,
  trigger_half_w, trigger_half_h,
  chain_type,             -- "Any"|"Exclusive"
  activated_time,         -- seconds (Timed behavior)
  timed_cancel (bool),
  relock_target,          -- checkpoint object id (string) or nil
  relock_area_wide (bool),
  last_activator,         -- player_id
  trigger_info,           -- emitter
  custom_handlers,        -- module or nil
  _skip_exclusive,        -- transient
}
```

#### 3.2.3 Registered Tiled object type

| Object type | Handler | Cache? |
| --- | --- | --- |
| `"OW Button"` | inline (see 3.2.4) | default (true) |

#### 3.2.4 Properties read from Tiled

From the OW Button object (props):

| Property | Type | Used as |
| --- | --- | --- |
| `"Bot Details"` | object id (string) | Reference to a Button Bot Details object. |
| `"Next 1"` | object id (string) | Chain link. |
| `"Button Behavior"` | string | "Repeatable", "One-Time", "Dynamic", "Custom", "Timed" (default "One-Time"). |
| `"Script Path"` | string | Loaded for Custom behavior. |
| `"Trigger Object"` | object id (string) | Optional separate trigger object. |
| `"Trigger Type"` | string | "rect" or "ellipse". Fallback if no Trigger Object. |
| `"Trigger Width", "Trigger Height"` | numbers (px) | Fallback (default 4). |
| `"Button Activated Behavior"` | object id (string) | Reference to Unlock Behavior object. |
| `"Button Deactivated Behavior"` | object id (string) | Reference to Relock Behavior object. |
| `"Button Chain Type"` | string | "Any" (default) or "Exclusive". |
| `"Activated Time"` | number (seconds) | Default 1. Used for Timed behavior. |

From Button Bot Details object (details_props):

| Property | Type | Notes |
| --- | --- | --- |
| `"Asset Name"` | string | Required. |
| `"Direction"` | string | Required. |
| `"Animation Name"` | string | Optional override for animation file. |
| `"Mug Animation Name"` | string | Optional. |
| `"Active Animation"` | string | Default "ACTIVE". |
| `"Inactive Animation"` | string | Default "INACTIVE". |
| `"Activated Animation"` | string | Optional (transitional). |
| `"Deactivated Animation"` | string | Optional. |
| `"Activation Animation Duration"` | number | Default 0.5. |
| `"Deactivation Animation Duration"` | number | Default 0.5. |

From Unlock Behavior object (beh_props):

| Property | Type | Notes |
| --- | --- | --- |
| `"Unlock This"` | object id (string) | Checkpoint to unlock. |
| `"Unlock Permanently"` | bool or string | Default true. String "true" accepted. |
| `"Area Wide"` | bool or string | Default false. |

From Relock Behavior object (relock_props):

| Property | Type | Notes |
| --- | --- | --- |
| `"Relock This"` | object id (string) | Checkpoint to relock. |
| `"Area Wide"` | bool or string | Default false. |

From Button Trigger object (trigger_obj.custom_properties):

| Property | Type | Notes |
| --- | --- | --- |
| `"Trigger Type"` | string | "rect" (default) or "ellipse". |

#### 3.2.5 Behavior matrix

| Behavior | entered | departed |
| --- | --- | --- |
| Repeatable | Activate if not active. | Deactivate if active. |
| One-Time | Activate if not active. | Nothing. |
| Dynamic | Toggle (activate if inactive, deactivate if active). | Nothing. |
| Timed | Activate then start a Async.sleep(activated_time) that calls deactivate_button_internal. | Nothing. |
| Custom | Calls module.on_enter(player_id, info) if provided. | Calls module.on_exit(player_id, info) if provided. |

Custom script requirements (load_custom_script): the required module must define a function on_enter. on_exit is optional. If loading fails, the behavior silently downgrades to "One-Time" (with a print).

#### 3.2.6 Public API

| Function | Parameters | Returns |
| --- | --- | --- |
| `ezbuttons.on_chain_unlocked(root_button_id, callback)` | string, function(player_id) | — |
| `ezbuttons.build_chains()` | — | — |
| `ezbuttons.is_button_active(area_id, object_id)` |  | boolean |
| `ezbuttons.activate_button(area_id, object_id, player_id)` |  | — |
| `ezbuttons.deactivate_button(area_id, object_id)` |  | — |
| `ezbuttons.reset_button(area_id, object_id)` |  | — |
| `ezbuttons.reset_chain(root_object_id)` |  | — |
| `ezbuttons.bind_checkpoint_to_chain(root_button_id, checkpoint_area_id, checkpoint_object_id, once)` | string, string, string, boolean? | — |

#### 3.2.7 Chain semantics

Chains are built lazily by build_chains() (called from activate_button, deactivate_button, or explicitly).

A chain is the linked list of buttons reachable via "Next 1".

The root is the button whose id is not referenced as a "Next 1" by any other.

chain_type is inherited from the root's "Button Chain Type".

Exclusive chains: when a button activates, all other buttons in the same chain deactivate first.

Checkpoint binding: read from each button's "Button Activated Behavior" object. Stored in button_to_checkpoint[button_id]; when chains are built, transferred to checkpoint_bindings[root_id] for each chain.

#### 3.2.8 Activation effect on checkpoints

When a chain becomes fully active:

Area Wide: Net.list_players(cp_area) → for each, ezcheckpoints.force_unlock_checkpoint(pid, cp_area, cp_id, once). Also stores in cp_area_mem.area_wide_unlock[root_id].

Single player: ezcheckpoints.force_unlock_checkpoint(player_id, cp_area, cp_id, once). If once is false, records in area_mem.timed_button_unlock_info[root_id] for later relock.

#### 3.2.9 Deactivation effect

Automatic relock triggers when the chain transitions fully‑active → not‑fully‑active. Handles:

Area‑wide unlock record (uses cp_area_mem.area_wide_unlock[root_id]).

Per‑player timed unlock record (uses area_mem.timed_button_unlock_info[root_id]).

Explicit relock_target (from "Button Deactivated Behavior" object) — applies to last_activator (single) or to all players in the area (area wide).

#### 3.2.10 Registration / initialization details

Calls pcall(Net.exclude_object_for_player, player_id, object_id) to hide the placeholder.

Bot is non‑solid, size 0.2, speed 1, dont_face_player = true, warp_in = true.

Trigger created with trigger_id = "button_" .. area_id .. "_" .. object.id.

#### 3.2.11 Net events registered

Net:on("player_join", ...) — hides placeholders, syncs animations, applies area‑wide unlocks.

Net:on("player_area_transfer", ...) — same.

#### 3.2.12 Related object types (not handlers, referenced only)

Button Bot Details

Unlock Behavior

Relock Behavior

Button Trigger

These are read by id from "Bot Details", "Button Activated Behavior", "Button Deactivated Behavior", "Trigger Object" properties.

### 3.3 ezcheckpoints.lua

Security Cube / checkpoint unlocking with optional password, money, fragments, tokens, or item requirements. Also handles boss gates (mention only — full code is not present in provided files).

#### 3.3.1 Registered event

Net:on("object_interaction", ...) — filters button == 0, area = player's area, object type must be "Checkpoint".

#### 3.3.2 Tiled properties read

| Property | Type | Default |
| --- | --- | --- |
| `"Password"` | string | false |
| `"Key Type"` | string | "money" (also "fragments", "tokens", "item", "bossgate") |
| `"Key Item Name"` | string | "" |
| `"Required Keys"` | number (string) | 1 |
| `"Consume"` | string "true"/"false" | — (checks == "true") |
| `"Once"` | string "true"/"false" | — |
| `"Unlocking Asset Name"` | string | "bn5cubegreen_bot" |
| `"Unlocking Animation Time"` | number | 0 |
| `"Unlocking Sound Path"` | string | "/server/assets/ezlibs-assets/sfx/panel_change.ogg" |
| `"Skip Prompt"` | string "true"/"false" | — |
| `"Description"` | string | "It's a Security Cube" |
| `"Unlocked Message"` | string | "The Security Cube was unlocked!" |
| `"Unlock Failed Message"` | string | "You were unable to unlock the Security Cube" |
| `"Boss Gate"` | string "true"/"false" | — |

#### 3.3.3 Public API

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `ezcheckpoints.unlock_checkpoint_for_player(player_id, area_id, object_id, unlocking_asset_name, unlocking_sound_path, unlocking_animation_time, once)` |  | Promise | Locks input; plays sound; hides the object either permanently (once) or till disconnect; if animation time > 0, spawns a temporary bot at the object position playing "UNLOCKING", then removes it. Emits checkpoint_unlocked. |
| `ezcheckpoints.force_unlock_checkpoint(player_id, area_id, object_id, once)` |  | Promise\|false | Reads the checkpoint's own properties and calls the above. |
| `ezcheckpoints.relock_checkpoint(player_id, area_id, object_id)` |  | boolean | Removes from both persistent and temporary hidden lists; calls Net.include_object_for_player if player is in area. |

#### 3.3.4 Prompt messages generated per key type

Password: "Please input the password".

Money consume: "Spend N$ to Unlock?"; money show: "Show N$ to Unlock?".

Fragments consume: "Spend N Fragments to Unlock?"; show: "Show N Fragments to Unlock?".

Tokens consume: "Spend N Tokens to Unlock?"; show: "Show N Tokens to Unlock?".

Item (amount 1): "Use X to Unlock?" / "Show X to Unlock?".

Item (amount > 1): "Use N X to Unlock?" / "Show N X to Unlock?".

If "Skip Prompt" is "true", the prompt message is empty and the flow skips the question (password still prompts for input).

#### 3.3.5 Locking

Uses helpers.get_lock(player_id, player_id .. "_" .. area_id .. "_" .. checkpoint_object.id). All code paths release the lock.

#### 3.3.6 Event registered

ezbus:emit("checkpoint_unlocked", {player_id, area_id, object_id}) when successful.

### 3.4 ezlocks.lua

Small reusable lock/payment helpers, all returning Promise (async).

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `ezlocks.check_password(player_id, prompt_message, correct_password)` |  | Promise<boolean> | "" prompt message skips the message; only prompt. Emits lock_attempt with "password". |
| `ezlocks.check_money(player_id, prompt_message, amount, consume)` |  | Promise<boolean\|nil> | nil if player declines (question returns 0). If consume, spends. Emits lock_attempt with "money". |
| `ezlocks.check_item(player_id, prompt_message, required_item, amount, consume)` |  | Promise<boolean\|nil> | nil on decline; consumes items when consume. Emits lock_attempt with "item". |

> 💡 **Note:** check_item uses ezmemory.count_player_item and ezmemory.remove_player_item; check_money uses ezmemory.spend_player_money when consume, else Net.get_player_money.

### 3.5 ezexplosions.lua

Explosion VFX subsystem driven via ezbus:on("explode", ...).

#### 3.5.1 Public API

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `ezexplosions.explode(actor_id, area_id, max_explosions)` |  | ExplodingEffect | Creates a new effect. max_explosions may be nil for infinite. |

#### 3.5.2 ExplodingEffect object

Fields set in :new:

```lua
{
  tracked_actor_id = actor_id,
  position = {x,y,z},         -- set by update_tracked_position
  area_id = opt_area_id,      -- or resolved from actor's area
  max_explosions = max_explosions,        -- nil for infinite
  remaining_explosions = max_explosions,
  total_explosions = 3,       -- number of bots spawned
  stopped = false,
}
```

Methods:

ExplodingEffect:new(actor_id, opt_area_id, max_explosions).

ExplodingEffect:remove() — sets stopped = true. Bots are cleaned up on their next explode() tick.

#### 3.5.3 Behavior

On spawn, creates total_explosions bots at the actor's position (staggered by EXPLOSION_DURATION / total_explosions).

Each tick: random X/Y offset within ±EXPLOSION_AXIS_RANGE (0.5), transfers bot; if max_explosions reached, removes bot and stops; if stopped, removes bot and stops.

Plays "/server/assets/ezlibs-assets/sfx/explode.ogg" at the area.

Randomly plays "EXPLODE" or "SMOKE" animation.

EXPLOSION_DURATION = .6 seconds per cycle.

Assets used: "/server/assets/ezlibs-assets/ezexplosions/explosion.png", "/server/assets/ezlibs-assets/ezexplosions/explosion.animation".

#### 3.5.4 Actors supported by update_tracked_position

Bots (via Net.is_bot): area & position from bot.

Players (via Net.is_player): area & position from player.

Otherwise treated as a tile object: Net.get_object_by_id(area_id, actor_id).

#### 3.5.5 Event registered

ezbus:on("explode", function(event) ezexplosions.explode(event.actor_id, event.area_id, event.max_explosions) end)

Expected payload: {actor_id, area_id, max_explosions}.

---

<a id="part-4"></a>
## 💬 Part 4 — eznpcs & dialogue_types

Two files: eznpcs/eznpcs.lua (NPC runtime, bot management, waypoints, exclusivity) and eznpcs/dialogue_types.lua (dialogue state‑machine node types).

### 4.1 eznpcs/eznpcs.lua

#### 4.1.1 Constants & asset layout

```lua
npc_asset_folder           = '/server/assets/ezlibs-assets/eznpcs/'
custom_events_script_path  = 'scripts/events/eznpcs_events'
generic_npc_mug_animation_path = npc_asset_folder..'mug/mug.animation'
```

Bot texture path pattern: <folder>sheet/<Asset Name>.png
Bot animation path pattern: <folder>sheet/<Asset Name>.animation
Override animation: <folder>sheet/<Animation Name>.animation
Mugshot texture: <folder>mug/<Mugshot>.png
Mugshot animation: <folder>mug/<Mug Animation Name>.animation (or generic default)

Required object properties (fails if missing): "Direction", "Asset Name" (npc_required_properties).

#### 4.1.2 Internal state

```lua
placeholder_to_botid         = {}   -- [area_id][placeholder_id(string)] = global bot ID (non-exclusive NPCs)
exclusive_npcs               = {}   -- [player_id][placeholder_id(string)] = bot_id
exclusive_placeholders       = {}   -- list of { area_id, object_id }
quest_exclusive_placeholders = {}   -- list of { area_id, object_id, quest_name, required_state }
quest_exclusive_npcs         = {}   -- [player_id][placeholder_id(string)] = bot_id
npcs                         = {}   -- [bot_id] = npc_data
current_player_conversation  = {}   -- [player_id] = bot_id
custom_events_script_loaded  = false
events                       = require('scripts/ezlibs-scripts/eznpcs/dialogue_types')
```

#### 4.1.3 npc_data (bot) schema

```lua
{
  asset_name         = string,
  bot_id             = string,
  name               = string|nil,
  area_id            = string,
  texture_path       = string,
  animation_path     = string,
  mug_animation_path = string,
  x, y, z            = numbers,
  direction          = string,
  solid              = true,
  size               = 0.2,
  speed              = 1,
  dont_face_player   = boolean,
  warp_in            = true,
  first_dialogue     = TiledObject,  -- set if object has "Dialogue Type"
  on_interact        = behaviour,    -- set by chat_behaviour()
  on_tick            = behaviour,    -- set by waypoint_follow_behaviour()
  next_waypoint      = TiledObject|nil,
  wait_time          = number|nil,
}
```

#### 4.1.4 Behaviours (internal)

Each behaviour is { type=string, action=function, initialize=function? }.

| Behaviour | Type | Description |
| --- | --- | --- |
| chat_behaviour() | on_interact | Locks player input, turns bot to face player (Direction.from_points), runs do_dialogue recursively from npc.first_dialogue, then clears conversation. |
| waypoint_follow_behaviour(first_waypoint_id) | on_tick | On init, looks up first waypoint. On tick, calls move_npc. |

add_behaviour(npc, behaviour) stores it as npc[behaviour.type] and calls initialize if present.

#### 4.1.5 Waypoint logic

move_npc(npc, delta_time):

Returns early if anyone is talking to the NPC or if the NPC is still wait_time‑paused.

Computes distance to npc.next_waypoint. If < npc.size, calls on_npc_reached_waypoint.

Otherwise moves toward the waypoint using speed * delta_time along the angle; rejects movement if helpers.position_overlaps_something.

on_npc_reached_waypoint(npc, waypoint):

Reads "Wait Time" (number) and "Direction" (sets bot direction).

"Waypoint Type" values:

"first" → first_value_from_table(next_waypoints)

"random" → random index

"before" → next_waypoints[1] if helpers.is_now_before_date("Date"), else [2]

"after" → next_waypoints[1] if NOT before date, else [2]

next_waypoints extracted via helpers.extract_numbered_properties(waypoint, "Next Waypoint ").

#### 4.1.6 Public API (returned table keys)

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `eznpcs.get_dialogue_mugshot(npc, player_id, dialogue)` |  | {texture_path, animation_path} | Uses dialogue's "Mugshot" override if present; supports "player" for the player's own mugshot. |
| `eznpcs.load_npcs()` |  | — | Loops all areas calling add_npcs_to_area. |
| `eznpcs.add_npcs_to_area(area_id)` |  | — | Legacy scan; may add duplicate placeholder entries for quest‑exclusive NPCs. |
| `eznpcs.add_event(event_object)` | {name, action} | — | Adds to dialogue event table (warns if replace). |
| `eznpcs.create_npc_from_object(area_id, object_id)` |  | npc_data |  |
| `eznpcs.handle_actor_interaction(player_id, actor_id)` |  | — | Calls do_actor_interaction. |
| `eznpcs.on_tick(delta_time)` |  | — | Lazily loads custom_events_script_path; ticks all NPCs with on_tick. |
| `eznpcs.create_npc(area_id, asset_name, x, y, z, direction, bot_name, animation_name, mug_animation_name)` |  | npc_data |  |
| `eznpcs.handle_player_transfer(player_id)` |  | — | Clears conversation. |
| `eznpcs.handle_player_join(player_id)` |  | — | Creates player‑exclusive NPCs, quest‑exclusive NPCs; excludes others' exclusive NPCs. |
| `eznpcs.handle_player_disconnect(player_id)` |  | — | Clears conversation and removes all player‑/quest‑exclusive bots. |
| `eznpcs.handle_object_interaction(player_id, object_id)` |  | — | Handles exclusive NPC placement, quest‑exclusive, and generic "Interact Relay" mapping to a bot. |
| `eznpcs.remove_exclusive_npc(player_id, placeholder_id)` |  | — | Removes the bot and clears its slot. |
| `eznpcs.remove_quest_exclusive_npc(player_id, placeholder_id)` |  | — | Same for quest‑exclusive. |
| `eznpcs.get_bot_id_for_placeholder(area_id, placeholder_id)` |  | bot_id\|nil |  |

#### 4.1.7 Registered Tiled object types

| Object type | Handler | Cache? |
| --- | --- | --- |
| `"NPC"` | inline (see 4.1.8) | default (true) |

#### 4.1.8 NPC registration logic

For each NPC object:

If "Quest Exclusive" string is set, it's treated as a quest‑exclusive placeholder; it's recorded and never created globally. Required state read from "Quest State" (default "active").

Else if "Quest NPC" or "Player Exclusive" is true:

Not created globally.

If "Player Exclusive", its placeholder is added to exclusive_placeholders.

Else it's a normal global NPC: create_bot_from_object(area_id, object) (no player_id).

#### 4.1.9 NPC object properties consumed

| Property | Type | Meaning |
| --- | --- | --- |
| `"Direction"` | Direction enum | Required. |
| `"Asset Name"` | string | Required. |
| `"Animation Name"` | string | Optional override. |
| `"Mug Animation Name"` | string | Optional override. |
| `"Dont Face Player"` | bool/string | Truthy. |
| `"Dialogue Type"` | string | If present, adds chat behaviour with object as first_dialogue. |
| `"Next Waypoint 1"` | object id | If present, adds waypoint behaviour. |
| `"Player Exclusive"` | bool/string | Truthy. |
| `"Quest NPC"` | bool/string | Truthy. |
| `"Quest Exclusive"` | string (quest name) | Triggers quest‑exclusive placeholder behavior. |
| `"Quest State"` | string | Default "active". Required quest state for spawning. |

#### 4.1.10 handle_object_interaction dispatch

If object type is "NPC":

Player Exclusive: if player doesn't yet have a bot for this placeholder, create one (with player_id). Then dispatch to do_actor_interaction.

Quest Exclusive: if player doesn't yet have a bot and their quest state matches, create and dispatch. If no match, skip.

Otherwise, if object has an "Interact Relay" property: look up the bot id from placeholder_to_botid[area_id][relay_id] and dispatch.

#### 4.1.11 Exclusivity system

Non‑exclusive bots visible to everyone (via include_for_all).

Player‑exclusive bots are created per player and excluded from everyone else via Net.exclude_actor_for_player.

On player_join, other players' exclusive bots are excluded for the joiner.

On player_disconnect, all of that player's exclusive bots are removed (Net.remove_bot).

#### 4.1.12 Quest events

ezbus:on("quest_event", function(event) update_quest_exclusive_for_player(event.player_id) end). When any quest event is emitted, the player's quest‑exclusive NPCs are recomputed.

#### 4.1.13 Conversation clearing

clear_player_conversation(player_id) unlocks input, resets bot direction (if not dont_face_player), clears the conversation slot, and emits ezbus:emit("dialogue_ended", {player_id, npc_id}).

#### 4.1.14 do_dialogue dispatcher

Recursive:

Reads dialogue.custom_properties["Dialogue Type"] (or legacy "Event Name").

Calls events[dialogue_type].action(npc, player_id, dialogue, relay_object) which must return a Promise resolving to a next_id.

Looks up the next dialogue via ezcache.get_object_by_id_cached(area_id, next_id) and recurses.

### 4.2 eznpcs/dialogue_types.lua

Dialogue state‑machine nodes. Each type is a table {name=string, action=function(npc, player_id, dialogue, relay_object) -> Promise} returning the next dialogue object id (or nil to end).

#### 4.2.1 Helper used

helpers.extract_numbered_properties(object, "Text ") → array of Text 1, Text 2, ...
helpers.extract_numbered_properties(object, "Next ") → array of Next 1, Next 2, ...
helpers.extract_numbered_properties(object, "Item ") → array of Item 1, Item 2, ...
helpers.extract_numbered_properties(object, "Body ") → array of Body 1..10

Mugshot resolution: eznpcs.get_dialogue_mugshot(npc, player_id, dialogue).

#### 4.2.2 Dialogue types

##### `first`

Reads Text 1 and Next 1.

Plays a single message and continues to the first Next.

##### `question`

Reads Text 1.

Async.question_player(player_id, text, mug.texture, mug.anim) → returns 1 or 0.

Picks next_dialogues[2 - res] (so answer 1 → Next 1, answer 0 → Next 2).

Returns next id.

##### `quiz`

Reads Text 1..3 (question + two options).

Async.quiz_player(player_id, text1, text2, text3, mug.texture, mug.anim) → returns 0‑based index.

Returns next_dialogues[res + 1].

##### `random`

Picks a random index among Text 1..N.

Plays that text.

Returns next_dialogues[chosen_index] or next_dialogues[1].

##### `itemcheck`

Reads Item 1..N (references to Item objects) and Next 1, Next 2.

Reads "Take Item" custom property (string, "true" triggers consumption).

For each item reference, reads item info via helpers.read_item_information.

If type == "money", uses condition.money(player_id, amount, take_item).

Otherwise uses condition.item(player_id, name, amount, take_item).

All must pass; returns Next 1 on success, Next 2 otherwise.

##### `questcheck`

Reads "Quest Name", "Flag Name", "Flag Value", "Operator" (or "Op"), "Invert" (string "true").

Builds a condition.evaluate call with type="quest_flag".

If "Invert" == "true", negates result.

Returns Next 1 if passed, else Next 2.

##### `before`

Reads "Date" (string: sec min hour day month year, with * as wildcard).

Uses condition.date_before(date).

Picks text and next accordingly:

Text 1 + Next 1 if before

Text 2 + Next 2 otherwise

##### `after`

Same as before, but uses condition.date_after(date).

##### `shop`

Reads Item 1..N (references to Item objects) and Next 1.

Builds shop item entries {name, price, description, is_key}.

Calls ezmemory.open_shop_async(player_id, shop_items, mug.texture, mug.anim).

Returns Next 1 after shop closes.

##### `password`

Correct password = dialogue.custom_properties["Text 1"].

Async.prompt_player(player_id) for input.

If equal, returns "Next 1" (from custom properties), else "Next 2".

##### `quest_switch`

Reads "Quest Name".

ezquests.get_player_quest_state(player_id, quest_name) → state string.

Returns dialogue.custom_properties[state] (i.e., a property named after the state holds the next dialogue id).

Warns if no matching property exists.

##### `quest_event`

Reads "Quest Name", "Event Value", Next 1.

Calls ezquests.quest_event(player_id, quest_name, event_value) (a Promise).

Emits ezbus:emit("quest_event", {player_id, quest_name, event_value}).

Returns Next 1.

##### `item`

Reads Item 1..N.

"Dont Notify" suppresses the item‑get toast (notify_player = "Dont Notify" ~= "true").

For each item, calls ezmemory.give_item_with_optional_notify(player_id, area_id, item_id, nil, notify_player).

Returns Next 1.

##### `email`

Reads "Email Id" (required, warns if missing).

Reads "Email Icon" (default 1), "Email Title" (default "Mail"), "Email From" (default "???").

Body: joins Body 1..N with "\n\n"; else uses "Email Body".

"Dont Notify" (string "true") disables ring/message.

"Notify Delay" (number), "Notify Message" (string).

"Persist" (string, "false" → temporary mail).

Mugshot rules:

"Mug Texture Path" / "Mug Animation Path" custom properties.

Shorthand names resolve relative to /server/assets/ezlibs-assets/eznpcs/mug/.

Full paths (with /) are kept with extension appended if missing.

If either texture or animation asset doesn't exist (Net.has_asset), mug is stripped and a warning is printed.

Default mug animation path: <MUG_DIR>/mug.animation.

Uses ezemail.send_once (persist=true) or ezemail.send_temp (persist=false).

Returns Next 1.

##### `battle_npc`

Reads "Text 1" (intro, optional), "Text 2" (question, default "Ready to fight?"), "Encounter Name" (required), "Failure Message" (default "You hesitated...").

Plays intro message with mugshot (if any).

Async.question_player for yes/no. Yes=0 → return (declined).

ezencounters.begin_encounter_by_name(player_id, encounter_name) → stats.

Determines win via stats.reason == 1 and stats.health > 0.

On win:

ezbus:emit("explode", {actor_id=npc.bot_id, area_id, max_explosions=3}).

If "Player Exclusive" was true, calls eznpcs.remove_exclusive_npc(player_id, npc.first_dialogue.id).

Calls ezmemory.hide_object_from_player(player_id, area_id, npc.first_dialogue.id).

Waits 2.5 s.

On loss:

ezbus:emit("explode", {actor_id=player_id, area_id, max_explosions=3}).

Waits 2.5 s.

Net.kick_player(player_id, "You were defeated!", true).

#### 4.2.3 Local Net event

```lua
Net:on("battle_results", function (event)
    Net.is_player_battling(event.player_id)
    print(Net.is_player_battling(event.player_id))
end)
```

Just logs battle state — informational.

---

<a id="part-5"></a>
## 🌀 Part 5 — ezwarps (Warp Objects & Animations)

Two categories of files:

ezwarps/main.lua — warp registry, landing registry, transfer logic, player arrival animations.

Animation modules:

arrow_animation_factory.lua

fall_in_animation.lua

fall_off_2.lua

lev_beast_in_animation.lua

lev_beast_out_animation.lua

log_in_animation.lua

### 5.1 ezwarps/main.lua

#### 5.1.1 Internal state

```lua
landings            = {}   -- [incoming_data] = landing record
player_animations   = {}   -- [player_id] = animation name to run on arrival
players_in_animations = {} -- [player_id] = true (locked during animation)
warp_types_with_landings = {"Server Warp", "Custom Warp", "Interact Warp", "Radius Warp"}
```

#### 5.1.2 Landing record schema

Created by add_landing(area_id, incoming_data, x, y, z, direction, warp_in, arrival_animation):

```lua
{
  area_id             = string,
  warp_in             = boolean,
  x, y, z             = numbers,     -- actual spawn position
  pre_animation_x, y, z = numbers,   -- pre‑offset positions (same as x/y/z when added)
  direction           = string,
  arrival_animation   = string|nil,  -- special animation name
}
```

Keyed by incoming_data in the landings table.

#### 5.1.3 Special animation registry

```lua
local special_animations = {
    fall_in              = require('.../fall_in_animation'),
    lev_beast_in         = require('.../lev_beast_in_animation'),
    lev_beast_out        = require('.../lev_beast_out_animation'),
    arrow_up_left_out    = create_arrow_animation(false,"Up Left"),
    arrow_up_right_out   = create_arrow_animation(false,"Up Right"),
    arrow_down_left_out  = create_arrow_animation(false,"Down Left"),
    arrow_down_right_out = create_arrow_animation(false,"Down Right"),
    arrow_up_left_in     = create_arrow_animation(true,"Up Left"),
    arrow_up_right_in    = create_arrow_animation(true,"Up Right"),
    arrow_down_left_in   = create_arrow_animation(true,"Down Left"),
    arrow_down_right_in  = create_arrow_animation(true,"Down Right"),
    fall_off_2           = require('.../fall_off_2'),
    log_in               = create_jack_in_out_animation(true),
    log_out              = create_jack_in_out_animation(false),
}
```

Each special animation is a module/table with fields:

pre_animation_offsets = {x, y, z} (numbers)

animate = function(player_id, warp_object?) -> Promise

Optional: duration = number (only lev_beast_out_animation and similar custom entries use this)

#### 5.1.4 Helper: property_is_true(value)

Accepts true, "true", "True" as true. Anything else (including nil, false, "false", numbers) is false.

#### 5.1.5 Helper: table_has_value(table, val)

Linear search via ipairs.

#### 5.1.6 add_landing(area_id, incoming_data, x, y, z, direction, warp_in, arrival_animation)

Stores a landing at landings[incoming_data]. Logs the record.

#### 5.1.7 add_interact_warp(object, object_id, area_id, area_name)

Creates an interact trigger via eztriggers.add_interact_trigger(area_id, object). On "interaction":

If players_in_animations[event.player_id] is not set, calls use_warp(event.player_id, object).

#### 5.1.8 add_radius_warp(object, object_id, area_id, area_name)

Reads "Activation Radius" (number) and doubles it to get diameter.

Creates a radius trigger via eztriggers.add_radius_trigger(area_id, object, diameter, diameter, 0, 0).

On "entered":

If not in an animation → use_warp.

Otherwise → clears players_in_animations[player_id] (so the warp will fire when the animation ends).

#### 5.1.9 add_custom_warp(object, object_id, area_id, area_name)

Currently a no‑op beyond logging. The comment says triggers are handled in process_warp_object. It only validates the target (looks up "Target Object" in "Target Area" via ezcache) and logs a warning when the target can't be found.

#### 5.1.10 process_warp_object(area_id, object) (local)

Runs for each "Server Warp", "Custom Warp", "Interact Warp", and "Radius Warp" object:

If the object has an "Incoming Data" property, calls add_landing using:

x = object.x + 0.5, y = object.y + 0.5, z = object.z

direction = object.custom_properties.Direction or "Down"

warp_in = property_is_true(object.custom_properties["Warp In"])

arrival_animation = object.custom_properties["Arrival Animation"]

Registers the trigger based on object.type:

"Radius Warp" → add_radius_warp

"Custom Warp" → add_custom_warp

"Interact Warp" → add_interact_warp

"Server Warp" → no trigger; landings handled above.

#### 5.1.11 Registered object types (all non‑cached)

```lua
object_registry.register_handler("Radius Warp",  process_warp_object, false)
object_registry.register_handler("Custom Warp",  process_warp_object, false)
object_registry.register_handler("Interact Warp",process_warp_object, false)
```

> 💡 **Note:** "Server Warp" does not register a handler here, so it must be handled elsewhere (or the landings registry via "Incoming Data" is expected to be pre‑registered by the user, since Server Warps typically live on remote servers).

#### 5.1.12 prepare_player_arrival(player_id, x, y, z, special_animation_name)

Returns {x, y, z}. If a special animation exists for the name, applies its pre_animation_offsets and stores player_animations[player_id] = special_animation_name. Returns the offset‑adjusted position.

#### 5.1.13 doAnimationForWarp(player_id, animation_name, is_leave_animation, warp_object?)

Async:

Sets players_in_animations[player_id] = true.

If warp_object["Dont Teleport"] is true, immediately clears the flag (no input lock, no animation).

Locks player input.

Looks up the animation; if it exists, calls animate(player_id, warp_object) and awaits it.

Clears player_animations[player_id].

Unlocks player input.

The is_leave_animation argument is passed but unused in the current implementation. animation_duration local is computed but unused.

#### 5.1.14 use_warp(player_id, warp_object, warp_meta?)

Async. Reads:

"Address", "Port" → remote warp.

"Target Object", "Target Area" → local warp.

"Dont Teleport" (bool).

"Warp Out", "Warp In" (bools).

"Data" (string, sent as data in remote warp).

"Leave Animation" (string).

Flow:

Determines if the warp is valid (is_remote_warp or has target object+area, or Dont Teleport).

If "Leave Animation" set, await(doAnimationForWarp(..., true, warp_object)).

Pre‑transfer Minish adjustment (only for local warps with a target area):

Requires ezpress.

Reads ezpress.get_area_minish_mode(target_area).

If true → ezpress.compress(player_id, true) (immediate); else ezpress.decompress(player_id, true).

Remote warp:

Net.transfer_server(player_id, Address, Port, warp_out, data).

ezbus:emit("warp", {player_id, from_area, to_area=Address, warp_type="server"}).

Local warp:

Looks up target_object via ezcache.get_object_by_id_cached(target_area, tostring(target_object_id)). Errors and unlocks input if missing.

Reads target's "Direction" (default "Down").

Reads target's "Arrival Animation".

If arrival animation: prepare_player_arrival and Net.transfer_player(player_id, target_area, warp_in, entry_pos.x, entry_pos.y, entry_pos.z, direction).

Else: Net.transfer_player(player_id, target_area, true, target_object.x+0.5, target_object.y+0.5, target_object.z, direction).

ezbus:emit("warp", {player_id, from_area, to_area=target_area, warp_type="custom"}).

#### 5.1.15 Net event handlers exported

| Function | Called by main.lua root when | Behavior |
| --- | --- | --- |
| `ezwarps.handle_player_request(player_id, data)` | Net:on("player_request") | Looks up landings[data]; if found, calls prepare_player_arrival, then Net.transfer_player(player_id, area_id, warp_in, x, y, z, direction). |
| `ezwarps.handle_custom_warp(player_id, object_id)` | Net:on("custom_warp") | Looks up object in player's current area; calls use_warp. Skips if player_is_in_animation. |
| `ezwarps.handle_player_join(player_id)` | Net:on("player_join") | If player_animations[player_id] is set, calls doAnimationForWarp(player_id, name, false). |
| `ezwarps.handle_player_transfer(player_id)` | Net:on("player_area_transfer") | Same as above. |
| `ezwarps.player_is_in_animation(player_id)` | used internally | Returns true if players_in_animations[player_id]. |

### 5.2 Special animation module contract

Each module/table must expose:

pre_animation_offsets = {x=number, y=number, z=number}

animate = function(player_id, warp_object?) -> Promise

warp_object is only passed when the caller provides it (i.e., use_warp). For arrival animations triggered from handle_player_request, warp_object is nil.

Some modules also define duration (used by the caller to delay the warp; only lev_beast_out_animation currently defines it, but the caller code in main.lua does not actually use it — the animation itself handles timing).

### 5.3 arrow_animation_factory.lua

Returns a function create_arrow_animation(is_arriving, direction_str) that returns a special‑animation table.

Accepted direction_str (from Direction):

"Up Left" → x_distance = -1

"Down Right" → x_distance = 1

"Up Right" → y_distance = -1

"Down Left" → y_distance = 1

When is_arriving == true, the start offset equals the delta direction, and the animation distance is negated (player slides INTO position).

pre_animation_offsets: set to the (negated for arrival) delta so the player starts off‑tile.

animate(player_id):

Reads current position and area, plus weather tint via ezweather.get_area_weather.

Arrival: fade camera to weather tint, move_player_camera and unlock_player_camera.

Departure: fade camera to black {r=0,g=0,b=0,a=255}, slide_player_camera, unlock_player_camera.

Animates player X/Y from current to (current + x_distance, current + y_distance) over 1 s.

Sleeps 1 s.

### 5.4 fall_in_animation.lua

pre_animation_offsets = {x=0, y=0, z=40}.

animate(player_id):

landing_z = player_pos.z - 40.

fall_duration = 2.

Keyframes animate Z from player_pos.z to landing_z.

Plays '/server/assets/ezlibs-assets/ezwarps/earthquake.ogg' in the area.

Net.shake_player_camera(player_id, 3, 2).

Unlocks player input.

### 5.5 fall_off_2.lua

pre_animation_offsets = {x=0, y=0, z=0}.

animate(player_id, warp_object):

fall_layers = 2 (or warp_object.custom_properties["Layers"] when provided).

landing_z = player_pos.z - fall_layers.

fall_duration = 0.3.

Animates Z from player_pos.z to landing_z.

Plays '/server/assets/ezlibs-assets/ezwarps/earthquake.ogg'.

Net.shake_player_camera(player_id, 1, 0.5).

Unlocks player input.

### 5.6 lev_beast_in_animation.lua

pre_animation_offsets = {x=0, y=0, z=0}.

animate(player_id):

Spawns bot lev_beast<player_id> at (player_pos.x, player_pos.y-5, player_pos.z+5) using "/server/assets/ezlibs-assets/ezwarps/lev-beast-64-65.png" and matching .animation.

beast_z_offset = 3

seconds_arriving = 3

seconds_here = 1

seconds_leaving = 3

Player keyframes: start at (y-3, z+17), ease Out to (y, z) over seconds_arriving.

Beast keyframes: start at (y-3, z+17+beast_z_offset), ease Out to (y, z+beast_z_offset) over seconds_arriving, then hold seconds_here, then ease In to (y+3, z+17+beast_z_offset) over seconds_leaving.

Net.shake_player_camera(player_id, 3, 1), plays "IDLE_DL".

Plays '/server/assets/ezlibs-assets/ezwarps/lev-bus-arrive.ogg', waits, plays 'resources/sfx/falzar.ogg', shakes camera, waits, plays '/server/assets/ezlibs-assets/ezwarps/lev-bus-leave.ogg', unlocks input, waits seconds_leaving, removes bot.

### 5.7 lev_beast_out_animation.lua

pre_animation_offsets = {x=0, y=0, z=0}.
duration = 8 (declared on the module).

animate(player_id):

Same beast spawn as lev_beast_in.

seconds_intro = 1, seconds_arriving = 3, seconds_here = 1, seconds_leaving = 3.

Player keyframes: hold current (y, z) for seconds_arriving + seconds_here, then ease In to (y+3, z+17) over seconds_arriving.

Beast keyframes: identical pattern to lev_beast_in.

Plays 'resources/sfx/falzar.ogg', shakes camera, "IDLE_DL", then '/server/assets/ezlibs-assets/ezwarps/lev-bus-arrive.ogg', Net.animate_player_properties, Net.animate_bot_properties, messages the player with their own mugshot "AHHH! The Lev Beast is here!?", then '/server/assets/ezlibs-assets/ezwarps/lev-bus-leave.ogg', waits, removes bot.

### 5.8 log_in_animation.lua

Exposes create_jack_in_out_animation(is_arriving) which returns a special‑animation table.

pre_animation_offsets = {x=0, y=0, z=0}.

animate(player_id):

Provides logout.png / logout.animation assets.

Spawns bot warp_in_effect_<player_id> at (player_pos.x+0.2, player_pos.y+0.2, player_pos.z).

If is_arriving, plays "JACK_IN" and sound '/server/assets/ezlibs-assets/ezwarps/log_in.ogg'.

Else plays "JACK_OUT" and sound '/server/assets/ezlibs-assets/ezwarps/log_out.ogg'.

duration = 1.0, vanish_time = 0.4.

Player keyframes: hold (y, z) for duration (no movement).

Sleeps vanish_time, then includes (if arriving) or excludes (if leaving) the player from all nearby players in the area.

Sleeps duration, unlocks camera, removes bot.

---

<a id="part-6"></a>
## ✉️ Part 6 — ezemail, ezmail, and ezannounce

Three files provide the in‑game email/inbox system and the server announcement feed:

ezemail.lua — the canonical module (also duplicated at ezmail.lua).

ezmail.lua — appears to be a byte‑for‑byte duplicate of ezemail.lua.

ezannounce/ezannounce.lua + ezannounce/announcements_feed.lua — server announcement feed that turns feed entries into emails.

### 6.1 ezemail.lua (and ezmail.lua)

#### 6.1.1 Module constants

```lua
local NEW_MAIL_MESSAGE_DELAY   = CONFIG.NEW_MAIL_MESSAGE_DELAY or 1.5
local ENABLE_TEST_EMAIL_ON_JOIN = false
local TEST_EMAIL_DELAY         = 2.0
local EZEMAIL_DEBUG            = true
local ANNOUNCEMENTS_FEED_MODULE = 'scripts/ezlibs-scripts/announcements_feed'
```

> 💡 **Note:** in ezemail.lua, ANNOUNCEMENTS_FEED_MODULE is set to 'scripts/ezlibs-scripts/announcements_feed'. In ezannounce.lua, the feed module constant is 'scripts/ezlibs-scripts/ezannounce/announcements_feed'. Depending on which script is actually loaded, this path may differ.

Requires:

helpers

ezmemory

ezbus

CONFIG (scripts/ezlibs-scripts/ezconfig)

#### 6.1.2 Mail record schema (memory bucket)

Stored in mem.emails.by_id[mail.id]:

```lua
{
  id                = string,
  icon              = number,
  title             = string,
  from              = string,
  body              = string,
  mug_texture_path  = string|nil,
  mug_animation_path= string|nil,
  read              = boolean,
}
```

If mug_texture_path / mug_animation_path are missing or empty, no mugshot is sent with the notification.

#### 6.1.3 Internal helpers

_preload_email_assets(player_id, mail) — calls Net.provide_asset_for_player for both mug paths if they are non‑empty and the API exists. Wrapped in pcall.

_get_bucket(player_id) — returns safe_secret, mem.emails.by_id. Ensures mem.emails and mem.emails.by_id exist.

_dbg(...) — conditional debug print when EZEMAIL_DEBUG.

_percent_decode(s) — decodes %XX sequences.

_get_tombstone_set() — reads feed.tombstones from the announcements feed (list or map form) and returns a set of ids and their percent‑decoded variants. Used to block sending tombstoned mails.

_find_mail_in_bucket(bucket, email_id) — finds a mail by exact id or by percent‑decoded equivalence. Returns (stored, key).

_mark_email_read(player_id, email_id) — marks a stored mail read = true and saves player memory.

_notify_new_mail(player_id, msg, delay_seconds) — rings the player HUD (Net.ring_player_hud), then after delay_seconds calls Net.message_player(player_id, msg, mug.texture, mug.anim) using the player's own mugshot.

#### 6.1.4 Public API

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `ezemail.resend_all(player_id)` | player_id | — | Prunes tombstoned mails from memory. Re‑sends every stored mail to the current session, marking them read = true (both in memory and in the copy sent). |
| `ezemail.send_once(player_id, mail, opts)` | mail: table, opts: table? | — | Persists + sends if new. Only notifies the first time. opts = {notify=bool, notify_message=string, notify_delay=number, notify_use_player_mug=bool} (last is unused). |
| `ezemail.send_temp(player_id, mail, opts)` | mail: table, opts: table? | — | Sends without persisting. Notifies when opts.notify ~= false. |
| `ezemail.send_test_email(player_id, delay_seconds)` |  | — | Builds a test mail with id "EZTEST_<safe_secret>_<os.time()>", title "Test", from "MailSys", body with the delay, mug paths for denpa-warp-sf2.png / mug.animation. Sends via send_temp. |

opts keys (both send_once and send_temp):

notify — boolean (default: true for send_temp, first‑only for send_once)

notify_message — string (default "Looks like you got an e-mail.")

notify_delay — number (default NEW_MAIL_MESSAGE_DELAY)

#### 6.1.5 send_once semantics

If the mail id is tombstoned → blocked, returns.

If Net.send_player_email is missing → returns.

first_time = (bucket[mail.id] == nil).

If first_time: store the mail, default read = false, ezmemory.save_player_memory(safe_secret).

Always send Net.send_player_email(player_id, mail) for the current session; emits ezbus:emit("email_sent", {player_id, email_id, persistent=true}).

Notify only when first_time and opts.notify ~= false.

#### 6.1.6 send_temp semantics

Always sends (no memory persistence).

Emits ezbus:emit("email_sent", {player_id, email_id, persistent=false}).

Notifies when opts.notify ~= false.

#### 6.1.7 Events registered

Net:on("player_join", ...): calls ezemail.resend_all(player_id), then require('scripts/ezlibs-scripts/ezannounce/ezannounce').send_missing(player_id) inside a pcall. Optionally calls send_test_email when ENABLE_TEST_EMAIL_ON_JOIN.

Net:on("email_read", ...): calls _mark_email_read(event.player_id, event.email_id).

#### 6.1.8 Event bus emissions

ezbus:emit("email_sent", {player_id, email_id, persistent}).

### 6.2 ezmail.lua

Content matches ezemail.lua exactly (same constants, same functions, same event registrations). It appears to be a duplicate file. If the runtime requires only one, ezemail is the one used by main.lua (require('scripts/ezlibs-scripts/ezemail')).

### 6.3 ezannounce/announcements_feed.lua

Static data module. Returns an array of announcement tables:

```lua
{
  id                 = string,
  icon               = number,
  title              = string,
  from               = string,
  body               = string,
  mug_texture_path   = string,
  mug_animation_path = string,
  starts_at          = number|nil,  -- os.time() gate
  ends_at            = number|nil,  -- expiry
  priority           = number,      -- higher = more likely to trigger the ring
  notify_message     = string,
}
```

Ships with a single example entry ANN_EXAMPLE_001.

May also carry a top‑level field tombstones (list or map form) which ezemail reads to prune/block mails.

### 6.4 ezannounce/ezannounce.lua

#### 6.4.1 Module constants

```lua
local FEED_MODULE = 'scripts/ezlibs-scripts/ezannounce/announcements_feed'
local POLL_SECONDS = 10
```

State:

```lua
_feed_cache   = nil
_feed_sig     = nil
_watch_started = false
_online       = {}   -- [player_id] = true
```

Requires:

helpers

ezmemory

ezemail (scripts/ezlibs-scripts/ezemail)

ezbus

#### 6.4.2 ezannounce.ANNOUNCEMENTS

An additional optional list on the module table. Not used internally by the code (the feed is loaded via FEED_MODULE), but exposed for user editing.

#### 6.4.3 Internal helpers

_get_email_bucket(player_id) — returns mem.emails.by_id.

_is_active(ann, now) — true when starts_at is not in the future and ends_at is not reached.

_feed_signature(feed) — concatenation of tostring(ann.id or "") for each entry; used to detect changes when the feed module is reloaded.

_reload_feed() — clears package.loaded[FEED_MODULE], re‑requires it, compares signature. On change, updates _feed_cache / _feed_sig and returns true. Logs reloads.

#### 6.4.4 Public API

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `ezannounce.get_feed()` | — | table | Loads the feed if not cached. |
| `ezannounce.send_missing(player_id)` | player_id | — | Loads feed; builds a tombstone set; finds every feed entry that (a) is not tombstoned, (b) passes _is_active, (c) has not been sent to this player yet. Sorts pending entries by priority desc, then starts_at desc. Sends each via ezemail.send_once, but only the first entry triggers a notify. Emits ezbus:emit("announcement_sent", {player_id, announcement_id}) for each entry. |
| `ezannounce.broadcast_missing_to_online()` | — | — | Iterates _online and calls send_missing(pid). |
| `ezannounce.start_watch(interval)` | number? (default 10) | — | Starts a polling loop that reloads the feed and broadcasts to online players when it changes. Idempotent (_watch_started). |

#### 6.4.5 Tombstone support

feed.tombstones may be:

List style: { "ID1", "ID2" }

Map style: { ID1=true, ID2=true }

Both are flattened into tomb[normalized_id] = true.

#### 6.4.6 Notification behavior in send_missing

For each pending announcement, a mail table is built:

```lua
mail = {
  id = ann.id,
  icon = ann.icon or 1,
  title = ann.title or "Announcement",
  from = ann.from or "Server",
  body = ann.body or "",
  mug_texture_path = ann.mug_texture_path,
  mug_animation_path = ann.mug_animation_path,
  read = false,
}
```

Then ezemail.send_once(player_id, mail, {notify = not did_notify, notify_message = ann.notify_message or ("New announcement: " .. (mail.title or "Update")), notify_delay = ann.notify_delay}).

Only the first announcement (highest priority) triggers the ring/HUD notification.

#### 6.4.7 Events registered

Net:on("player_disconnect", ...) — removes player_id from _online.

#### 6.4.8 Startup

Calls ezannounce.start_watch() at module load.

#### 6.4.9 Event bus emissions

ezbus:emit("announcement_sent", {player_id, announcement_id}).

---

<a id="part-7"></a>
## 📌 Part 7 — ezbbs (Bulletin Board System)

Single file: ezbbs.lua.

### 7.1 Purpose

Provides a shared Bulletin Board System (BBS) usable via Tiled "BBS" objects placed in the world. Allows players to post, read, pin, and delete messages. Persists each board's posts to BOARDS_DIR/<board_name>.json. Uses ezusers for permission checks (pin/delete/admin posting).

### 7.2 Module constants

```lua
local BOARDS_DIR   = ezconfig.BOARD_PATH_FOLDER     -- from ezconfig; should end with '/'
local TITLE_LIMIT  = 14
local AUTHOR_LIMIT = 7
```

TITLE_LIMIT and AUTHOR_LIMIT are used by sanitize_title to truncate. Pinned titles are prefixed with "PIN: " (5 chars), so the title is truncated to TITLE_LIMIT - 5 for pinned posts.

### 7.3 Module state

```lua
local last_read_time = {}    -- [player_id] = os.time() when they last opened a board
local player_states  = {}    -- [player_id] = { status, area_id, board_id, board_name,
                             --                 current_board_postable,
                             --                 submission_text, submission_title }
local board_cache    = {}    -- [board_name] = { posts = { post, ... }, next_id = number }
```

Post record schema (stored in board_cache[name].posts):

```lua
{
  time  = os.time(),
  author= string,         -- sanitized to AUTHOR_LIMIT
  title = string,         -- sanitized to TITLE_LIMIT
  id    = string,         -- tostring(next_id)
  body  = string,         -- truncated to "Character Limit" (default 256)
  pin   = boolean,        -- false by default
  pin_time = number|nil,  -- set when pinned
  read  = boolean,        -- computed per display
}
```

Board record schema (board_cache[name]):

```lua
{
  posts   = { post, ... },
  next_id = number,
}
```

player_states[player_id] schema:

```lua
{
  status                   = string,   -- "READING" | "EDITING" | "SUBMITTING" | "INFORMED_OF_INPUT" | "TITLING"
  area_id                  = string,
  board_id                 = string,   -- object id of the board
  board_name               = string,
  current_board_postable   = boolean,  -- whether the board accepts new posts
  submission_text          = string|nil,
  submission_title         = string|nil,
}
```

### 7.4 Board save lifecycle

save_board(board_name):

Skips if a save is already in flight (saving[board_name]), setting pending_save[board_name] = true instead.

Reads board_cache[board_name]; returns if missing.

Sets saving[board_name] = true.

Filename: BOARDS_DIR .. board_name:gsub("[^%w_%-]", "_") .. ".json".

Uses Async.write_file(filename, json.encode(data, true)).and_then(...).

On completion, clears saving[board_name] and re‑triggers a save if pending_save[board_name] was set.

### 7.5 Post creation & display (internal)

push_post(board_name, area_id, post)
Reads board_cache[board_name].posts.

Determines the anchor id (next_id) — the last non‑pinned post's id, or nil.

Uses Net.prepend_posts if there is a non‑pinned post, else Net.append_posts (anchor nil).

Pushes the new post to every player currently in area_id via Net.list_players(area_id).

show_post(player_id, post_id)
Reads player_states[player_id]; returns if missing.

Looks up the post in board_cache[state.board_name].posts by id.

Sends Net.message_player(player_id, post.body).

create_post(player_id, state)
Reads board object via Net.get_object_by_id(state.area_id, state.board_id).

Reads board_cache[state.board_name]; creates it (with default {posts={}, next_id=1}) and saves if missing.

Reads "Character Limit" custom property (default 256) and "Post Limit" (default 50).

Title = state.submission_title (or state.submission_text if the title is all whitespace).

Builds the post:

time = os.time()

author = sanitize_title(player_name, AUTHOR_LIMIT)

title = sanitize_title(title, TITLE_LIMIT)

id = tostring(board_data.next_id)

body = string.sub(state.submission_text, 1, char_limit)

pin = false

Increments next_id.

If #posts >= post_limit, removes the oldest non‑pinned post (first iteration over ipairs that is not pinned, using table.remove).

Inserts the post, saves the board, and push_posts it.

### 7.6 Board load & open (internal)

load_board(name, callback)
If board_cache[name] exists, calls callback(board_cache[name]) immediately.

Else reads BOARDS_DIR .. name:gsub("[^%w_%-]", "_") .. ".json" via Async.read_file.

Decodes JSON; on failure or empty content, defaults to {posts={}, next_id=1}.

Saves the newly created board if it was empty.

Stores into board_cache[name], prints a log, and invokes callback(data).

open_board_with_data(board_data, player_id, board_name, color, postable, area_id, board_id)
Builds the display list: starts with { id="POST", read=true, title="POST" }.

Reads last_time = last_read_time[player_id].

Uses bbs_display_order_ids(board_data) to get pinned and unpinned.

For each source post, builds a shallow copy, prepends "PIN: " if pinned (truncated to TITLE_LIMIT - 5), else truncates to TITLE_LIMIT. If last_time == nil or post.time < last_time, marks it read = true.

Calls Net.open_board(player_id, board_name, color, posts).

Stores player_states[player_id] = { status="READING", area_id, board_id, board_name, current_board_postable=postable }.

load_board_and_open(name, player_id, area_id, object, color, postable)
Wraps load_board(name, ...) and calls open_board_with_data in the callback.

### 7.7 Preload

preload_boards() (called at module load):

Iterates every area via Net.list_areas().

For each object with custom_properties.BBS, reads custom_properties.Name.

Calls load_board(name, function() end) once per unique name (ensures the JSON file exists).

Prints the number of unique boards found.

### 7.8 Display ordering

bbs_display_order_ids(board_data) — splits posts into pinned/unpinned, sorts pinned by bbs_compare_pinned, unpinned by bbs_compare_unpinned, and returns the ordered ids plus the two sorted arrays.

bbs_compare_pinned(a, b) — compares pin_time or time desc; then time desc; then id desc (string compare).

bbs_compare_unpinned(a, b) — time desc, then id desc.

### 7.9 Helper functions (internal)

shallow_copy(original) — copies top‑level keys.

contains_only_whitespace(text) — true when there is no non‑whitespace character.

sanitize_title(text, limit) — replaces \t\r\n with spaces and truncates to limit.

### 7.10 Registered Net events

main.lua dispatches player_join, player_disconnect, object_interaction, post_selection, board_close, and textbox_response to ezbbs where present.

ezbbs.handle_player_join(player_id)
Sets last_read_time[player_id] = os.time().

ezbbs.handle_player_disconnect(player_id)
Clears last_read_time[player_id] and player_states[player_id].

ezbbs.handle_object_interaction(player_id, object_id, button)
Returns unless button == 0.

Resolves area and object via Net.get_player_area / Net.get_object_by_id.

Returns unless object.custom_properties.BBS is set.

Reads "Name" (board name) and "Color" (hex string #RRGGBB).

Reads "Postable" (default true).

Parses color into {r, g, b}.

Calls load_board_and_open(name, player_id, area_id, object, color, postable).

ezbbs.handle_post_selection(player_id, post_id)
Requires player_states[player_id].

Reads board_data = board_cache[board_name]; logs and returns if missing.

Reads has_admin_perm = ezusers.has_permission(player_id, "BBS.CanPin").

For post_id == "POST":

If state.current_board_postable or has_admin_perm → Net.prompt_player(player_id, char_limit) and sets state.status = "EDITING".

Else → messages "It appears you do not have permission to post here...".

For a regular post selection:

If has_admin_perm: uses async(function() ... end) to call Async.quiz_player(player_id, "Show Post", "Pin Post", "Delete Post").

choice == 0 → show_post.

choice == 1 → pin/unpin. Requires BBS.CanPin. Toggles post.pin, sets/clears post.pin_time, saves board, then for every viewer in the same board recomputes display order, removes the old post UI, and re‑inserts at the new anchor position.

choice == 2 → delete. Requires BBS.CanDelete. Removes the post from board_data.posts, saves, then for every viewer in the same board calls Net.remove_post.

Else (non‑admin): show_post(player_id, post_id).

ezbbs.handle_textbox_response(player_id, response)
Reads state = player_states[player_id]; returns if missing.

state.status == "EDITING":

If the response contains non‑whitespace, stores it as submission_text, sets status "SUBMITTING", and calls Net.question_player(player_id, "Do you want to submit?").

Else resets status to "READING".

state.status == "SUBMITTING":

If response == 1, messages "Title:" and Net.prompt_player(player_id, TITLE_LIMIT, sanitize_title(state.submission_text, TITLE_LIMIT)), sets status to "INFORMED_OF_INPUT".

Else resets status to "READING".

state.status == "INFORMED_OF_INPUT": sets status to "TITLING".

state.status == "TITLING":

Stores state.submission_title = response, calls create_post(player_id, state), then sets status back to "READING".

ezbbs.handle_board_close(player_id)
Sets last_read_time[player_id] = os.time().

### 7.11 Board object custom properties

| Property | Type | Used by |
| --- | --- | --- |
| `BBS (flag)` | any non‑nil value | Identifies the object as a BBS |
| `Name` | string | Board key, also its display title |
| `Color` | string #RRGGBB | Board UI color |
| `Postable` | bool | If true (or missing), allows regular users to post |
| `"Character Limit"` | number | Default 256 |
| `"Post Limit"` | number | Default 50 |

### 7.12 Permissions checked

ezusers.has_permission(player_id, "BBS.CanPin") — treats as admin for admin‑only flows.

ezusers.has_permission(player_id, "BBS.CanPin") — pin/unpin toggle.

ezusers.has_permission(player_id, "BBS.CanDelete") — delete post.

---

<a id="part-8"></a>
## 🌱 Part 8 — ezfarms

Single file: ezfarms.lua.

### 8.1 Purpose

A grid‑based farming system operating on a single designated map (CONFIG.FARM_MAP). Players till soil, water it, plant seeds, and harvest vegetables over real time (with a configurable timescale). Uses the Reference Seed tile object on the farm map as the anchor for computing plant GIDs.

### 8.2 Module constants

```lua
farm_area          = CONFIG.FARM_MAP
period_multiplier  = CONFIG.FARM_TIMESCALE or 1.0
delay_till_update  = 5     -- seconds between update_all_tiles calls (not multiplied)
```

On load, reference_seed = Net.get_object_by_name(farm_area, "Reference Seed"). If this fails (object not found), the module prints an error and returns {} early, effectively disabling the system.

### 8.3 PlantData table

Key = plant name; value = {price, growth_time_multi, local_gid, harvest = {min, max}}.

| Plant | price | growth_time_multi | local_gid | harvest (min, max) |
| --- | --- | --- | --- | --- |
| Parsnip | 300 | 0.4 | 0 | 1, 2 |
| Cauli | 1200 | 1.2 | 7 | 1, 1 |
| Garlic | 600 | 0.4 | 14 | 2, 3 |
| Tomato | 350 | 1.1 | 21 | 1, 3 |
| Chili | 600 | 0.5 | 28 | 1, 1 |
| Radish | 550 | 0.6 | 35 | 1, 1 |
| Star | 1800 | 1.3 | 42 | 1, 2 |
| Eggplant | 320 | 0.5 | 49 | 2, 3 |
| Pumpkin | 1200 | 1.3 | 56 | 1, 1 |
| Yam | 900 | 1.0 | 63 | 2, 4 |
| Beetroot | 400 | 1.8 | 70 | 1, 1 |
| Ancient | 2800 | 2.8 | 77 | 1, 1 |
| Sweet | 3000 | 2.4 | 84 | 1, 2 |
| Blueberry | 800 | 1.5 | 91 | 2, 6 |
| Dead | (none) | (none) | 98 | (none) |

ToolNames: mapping of a tool/seed's in‑game item name to its tool/plant key.

CyberHoe = "CyberHoe"

CyberWtrCan = "CyberWtrCan"

CyberScythe = "CyberScythe"

GigFreez = "GigFreez"

For every plant X (not Dead): ToolNames["X seed"] = "X".

### 8.4 Growth stage descriptions

```lua
growth_stage_descriptions = {
  ["0"] = "like it was just planted",
  ["1"] = "to be growing steadily",
  ["2"] = "to be healthy",
  ["3"] = "almost ripe for picking!",
  ["4"] = "ready for harvest!",
  ["5"] = "very sad..."
}
```

### 8.5 Tile IDs

```lua
Tiles = {
  Dirt     = 85,
  Grass    = 86,
  DirtWet  = 87,
}
```

### 8.6 Sound effect paths

```lua
sfx = {
  item_get   = '/server/assets/ezlibs-assets/sfx/item_get.ogg',
  card_error = '/server/assets/ezlibs-assets/ezfarms/card_error.ogg',
  hoe        = '/server/assets/ezlibs-assets/ezfarms/hoe.ogg',
  rain       = '/server/assets/ezlibs-assets/ezfarms/rain.ogg',
  scythe     = '/server/assets/ezlibs-assets/ezfarms/scythe.ogg',
  swap_tool  = '/server/assets/ezlibs-assets/ezfarms/swap_tool.ogg',
  water_tile = '/server/assets/ezlibs-assets/ezfarms/water_tile.ogg',
  wind       = '/server/assets/ezlibs-assets/ezfarms/wind.ogg',
}
```

All of these are provided to every player on join.

### 8.7 Time periods

```lua
Period = {
  Minute = 60,
  Hour   = 3600,
}
```

Period.EmptyDirtToGrass       = 10 * Minute
Period.GrowthStageTime        = 12 * Hour
Period.PlantedDirtWetToDirt   = 4 * Hour
Period.UnwateredPlantDeath    = 36 * Hour
Period.JustPlantedGracePeriod = 4 * Hour
Period.RainDuration           = 1 * Hour
Period.WitherTime             = 48 * Hour
Every value is then multiplied by period_multiplier.

### 8.8 Sell price formula

```lua
sell_price = floor(plant.price * ((((plant.growth_time_multi * 0.4) ^ 1.1) + 1) / av_harvest))
```

Where av_harvest = (harvest[1] + harvest[2]) / 2.

Computed for all plants except Dead and stored as PlantData[name].sell_price.

### 8.9 GID calculation

calculate_plant_gid(plant_name, growth_stage):

first_gid = reference_seed.data.gid.

Stage 0 (seeds): first_gid + PlantData[name].local_gid + random(0, 1).

Stages 1..4 (growing/grown): (first_gid + 1) + PlantData[name].local_gid + growth_stage.

Stage 5 (dead): uses Dead.local_gid + random(0, 3).

### 8.10 Growth stage determination

determine_growth_stage(plant_name, elapsed_since_planted, elapsed_since_water, death_time):

If death_time ~= 0, return 5.

unique_growth_stage_time = plant.growth_time_multi * Period.GrowthStageTime.

death_time = (unique_growth_stage_time * 4) + Period.WitherTime.

growth_stage = min(4, floor(elapsed_since_planted / unique_growth_stage_time)).

If elapsed_since_water > Period.UnwateredPlantDeath and elapsed_since_planted > Period.JustPlantedGracePeriod → dies at 5, logs "dried up and died".

If elapsed_since_planted > death_time → stage 5, logs "died of old age".

### 8.11 Runtime state

```lua
players_using_bbs = {}   -- [player_id] = "Buy Seeds" | "Select Tool" | "Sell Veggies"
player_tools      = {}   -- [player_id] = string tool/seed name
plant_ram         = {}   -- [loc_string] = { growth_stage = number, id = object_id }
area_memory       = nil  -- set on first load_farm()
farm_loaded       = false
```

area_memory.tile_states[loc_string] schema (persisted in ezmemory):

```lua
{
  gid    = number,
  x, y, z = numbers,
  plant  = string|nil,   -- plant name or nil
  owner  = string|nil,   -- safe_secret of the planter
  time   = {
    tilled  = number,
    watered = number,
    planted = number,
    death   = number,
  }
}
```

loc_string = "x,y,z".

### 8.12 Public API (returned table keys)

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `ezfarms.handle_player_join(player_id)` |  | — | Provides all sfx to the player and calls load_farm(). |
| `ezfarms.on_tick(delta_time)` |  | — | Updates every tile when delay_till_update <= 0; resets delay to 5. Called by root main on every tick. |
| `ezfarms.handle_post_selection(player_id, post_id)` |  | — | Dispatches BBS selection. |
| `ezfarms.handle_board_close(player_id)` |  | — | Clears players_using_bbs[player_id]. |
| `ezfarms.handle_object_interaction(player_id, object_id)` |  | — | Handles "Water Refill" objects. |
| `ezfarms.handle_tile_interaction(player_id, x, y, z, button)` |  | — | Main farming interaction. |
| `ezfarms.list_player_tools(player_id)` |  | table | Returns {tool_name = count} for tools held by the player. |
| `ezfarms.open_held_item_select(player_id)` |  | — | Opens a "Select Tool" BBS with held tools. |

### 8.13 load_farm()

Gets area_memory = ezmemory.get_area_memory(farm_area).

Ensures area_memory.tile_states exists (creates {}).

Calls update_all_tiles().

Saves area memory.

Sets farm_loaded = true.

### 8.14 update_all_tiles()

current_time = os.time().

If weather is not clear and rain_started is set and older than Period.RainDuration, clears weather.

For each loc_string, tile_memory in area_memory.tile_states, calls update_tile.

Returns something_changed (boolean).

### 8.15 update_tile(current_time, loc_string, area_weather) (internal)

Steps:

Computes elapsed times since water, till, plant, death.

If a plant exists:

Computes its growth stage.

If stage reached 5 for the first time, records time.death = current_time.

If no runtime plant object exists, creates one via Net.create_object with:

```text
name = tile_memory.plant,
visible = true,
x = tile_memory.x + 0.6,
y = tile_memory.y + 0.6,
z = tile_memory.z,
width = 1, height = 2,
data = {type="tile", gid=..., flipped_horizontally=false, flipped_vertically=false}
```

Otherwise, if the growth stage changed, calls Net.set_object_data to update the gid.

If no plant exists but plant_ram[loc_string] does, remove the object via Net.remove_object.

If raining, keeps the ground wet (time.watered = current_time).

Tile transitions:

DirtWet → Dirt when elapsed_since_water > Period.PlantedDirtWetToDirt.

Dirt → DirtWet when elapsed_since_water < Period.PlantedDirtWetToDirt.

Dirt → Grass when no plant and elapsed_since_tilled > Period.EmptyDirtToGrass.

Sets tile memory gid and calls Net.set_tile.

### 8.16 BBS interactions

Triggered from handle_object_interaction when a player opens a BBS the farm system manages. handle_post_selection reads players_using_bbs[player_id] to decide which BBS:

"Buy Seeds": try_buy_seed(player_id, post_id).

"Select Tool": sets player_tools[player_id] = post_id, messages "You are now holding <post_id>", closes BBS.

"Sell Veggies": counts item, computes worth = plant.sell_price * count, gives money (via spend_player_money(player_id, -worth)), removes items, removes the post from the BBS, messages "Sold all <name> for <worth>$!", plays item_get.

try_buy_seed(player_id, plant_name)
Reads price.

If ezmemory.spend_player_money(player_id, price): plays item_get, ensures the seed item exists (<plant_name> seed), gives 1 seed.

Else: messages "Not enough $" and plays card_error.

list_plants(player_id)
Reads player items; returns {plant_name = quantity} for items whose name matches a plant with a price.

veggie_stall NPC event
Registered via eznpcs.add_event:

Opens a BBS "Sell Veggies" with a light‑green color.

Lists each plant the player has with its sell price as author.

Sets players_using_bbs[player_id] = "Sell Veggies".

ezfarms.list_player_tools(player_id)
Iterates player items; matches against ToolNames. Returns {tool_name = count}.

ezfarms.open_held_item_select(player_id)
Opens a "Select Tool" BBS with a red color.

Each row: {id=tool_name, read=true, title=tool_name, author="x " .. count}.

### 8.17 Tile interactions (handle_tile_interaction)

Flow:

Floor x/y/z.

Returns if not on the farm map.

button == 1 → opens tool selection BBS.

Returns if no tool selected.

Reads player_tool = player_tools[player_id], tile, pre‑existing plant.

Dispatch:

"GigFreez" — if held: plays wind, cycles weather (clear → rain, rain → snow), removes the item, messages flavor text.

"CyberHoe" — if a plant exists: try_harvest; else till_tile.

"CyberWtrCan" — water_tile.

"CyberScythe" — scythe_plant.

Otherwise (a seed) — try_plant_seed.

till_tile(tile, x, y, z, player_id)
Only on Tiles.Grass: creates a fresh tile_states entry with gid=Tiles.Dirt, time fields, plays hoe, calls update_tile, saves area memory.

water_tile(tile, tile_loc_string, player_id, safe_secret)
Only on Dirt or DirtWet: if player_memory.farming.water > 0, decrement, set time.watered, set gid=DirtWet, play water_tile, update_tile, save. Else messages "CyberWtrCan is out of water...".

plant(tile_loc_string, player_id, seed, current_time)
plant_to_plant = ToolNames[seed].

Sets time.planted = current_time, time.death = 0, plant = plant_to_plant, owner = safe_secret.

Removes 1 seed via ezmemory.remove_player_item. If none left, messages "You ran out of <seed>" and clears tool.

update_tile, saves.

deleet_plant(tile_loc_string, current_time)
Clears plant, owner, time.planted, time.death.

Resets time.tilled = current_time (so dirt doesn't turn to grass immediately).

update_tile, save.

scythe_plant(tile_loc_string, current_time, prexisting_plant, player_id)
Only kills plants at stage 5. Otherwise messages "Oak's words echoed... There's a time and place for everything, but not now.".

harvest(tile_loc_string, player_id, safe_secret, current_time)
Reads plant name, rolls math.random(plant_info.harvest[1], plant_info.harvest[2]), messages "Harvested N <name>!", plays item_get, ensures item exists, gives items, calls deleet_plant.

try_harvest(tile_loc_string, prexisting_plant, player_id, safe_secret, current_time)
If the player is the owner:

Stage 4 → harvest.

Else → messages "the <name> looks <growth_stage_description>".

If not the owner: messages "<owner_name>'s <name> looks <growth_stage_description>".

try_plant_seed(tile, tile_loc_string, player_id, seed)
Only on Dirt or DirtWet. If no existing plant or one is dead, calls plant. Else calls try_harvest.

### 8.18 handle_object_interaction(player_id, object_id)

Returns unless on the farm map.

Reads object = Net.get_object_by_id(player_area, object_id).

If object.type == "Water Refill":

If player_tools[player_id] == "CyberWtrCan":

If player_memory.farming.water == 50 → "CyberWtrCan is already full...".

Else: sets farming.water = 50, plays water_tile, messages "Filled CyberWtrCan".

Else: uses Net.get_player_mugshot and messages "\x02I could fill something here...\x02" with the player's own mugshot.

### 8.19 Tiled object types used

| Type | Used by | Notes |
| --- | --- | --- |
| (any) with name "Reference Seed" | module init | Source of base GID. Required. |
| "Water Refill" | handle_object_interaction | Refills the water can. |

Farm tiles themselves are regular tiles, not objects — the module reads/writes them with Net.get_tile / Net.set_tile.

### 8.20 Reference Seed object

The Reference Seed must:

Be a tile object with a data.gid field.

Be found by name in CONFIG.FARM_MAP.

Its data.gid is the base for computing every plant sprite.

---

<a id="part-9"></a>
## 💎 Part 9 — ezmystery

Single file: ezmystery.lua.

### 9.1 Purpose

Implements the "Mystery Data" collectible objects. Supports:

Randomized hiding of mystery data per player per area.

Reward types: item, keyitem, money, fragments, tokens, random, quiz, encounter.

Locked mysteries (require an "Unlocker" item), password‑locked mysteries, and cost‑gated mysteries (money/fragments/tokens).

Quiz puzzles (chains of question objects referenced from a "Quiz List").

Explosion on quiz failure.

Anonymous data collection (hidden permanently or until disconnect).

### 9.2 Module state

```lua
local object_cache = {}                    -- unused in current code
local revealed_mysteries_for_players = {}  -- [player_id][area_id] = list of mystery object ids
local player_avatars = {}                  -- [player_secret] = { texture_path, anim_path }
local player_animations = {}               -- [player_secret] = parsed animation table
```

Constants:

```lua
local sfx = { item_get = '/server/assets/ezlibs-assets/sfx/item_get.ogg' }
```

Requires:

ezmemory

ezcache

helpers

ezlocks

condition

ezencounters (scripts/ezlibs-scripts/ezencounters/main)

math

ezbus

AvatarCache (avatar_utils/main)

AvatarUtils (avatar_utils/avatar_utils)

### 9.3 Helpers

is_property_true(val)
Truthy for true, string "true" (case insensitive), and any nonzero number.

resource_name(cost_type)
Maps "money" → "Money", "fragments" → "Bug Fragments", "tokens" → "Tokens", otherwise returns the input.

object_is_mystery_data(object)
Returns true when object.type == "Mystery Data" or object.type == "Mystery Datum".

fetch_player_avatar_and_details(player_id)
Uses AvatarCache.get_player_avatar_paths(player_secret) to look up the sheet texture / animation paths.

Stores in player_avatars[player_secret] = { texture_path, anim_path }.

Parses the animation file with AvatarUtils.parse_animation_file(anim_path) and stores in player_animations[player_secret].

Called on:

Net:on("player_join", ...).

Net:on("avatar_change", ...).

Net:on("object_interaction", ...)
If the interacted object is Mystery Data, calls try_collect_datum(player_id, area_id, object).

### 9.4 Public API

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `ezmystery.handle_player_disconnect(player_id)` |  | — | Clears revealed_mysteries_for_players[player_id]. |
| `ezmystery.hide_random_data(player_id)` |  | — | Chooses a random subset of mystery data in the player's current area to remain visible; hides the rest for the session. |
| `ezmystery.handle_player_transfer(player_id)` |  | — | Calls hide_random_data. |
| `ezmystery.handle_player_join(player_id)` |  | — | Calls hide_random_data. |

### 9.5 hide_random_data(player_id)

Flow:

Reads the player's area and its objects.

Reads custom area properties "Mystery Data Minimum" (default 1) and "Mystery Data Maximum" (default 0). If min > max, returns.

Returns if this area has already been decided for this player.

Computes desired_mystery_count = math.random(min, max).

Collects datum_list = all mystery object ids that are not Once and not Locked.

While #datum_list > desired_mystery_count, hides one at random via ezmemory.hide_object_from_player_till_disconnect and removes it from the list.

Stores the remaining list under revealed_mysteries_for_players[player_id][area_id].

### 9.6 Quiz subsystem

run_quiz_from_list(player_id, area_id, quiz_list_id, failure_message)
Loads quiz_list via ezcache.get_object_by_id_cached. Returns false if missing.

Reads question ids via helpers.extract_numbered_properties(quiz_list, "Next ").

For each question:

Reads qobj.custom_properties["Question"], Option 1, Option 2, Option 3, Correct Answer (default 1).

Collects options into an array.

Messages the question via Async.message_player.

Calls Async.quiz_player(player_id, option1, option2, option3). If the result is not a table, fails. Otherwise awaits the choice.

On choice nil, < 0, or choice + 1 ~= correct_answer, shows the failure message and returns false.

Returns true when all questions are answered correctly.

### 9.7 Collection flow (try_collect_datum)

Returns a Promise.

If the object is hidden from the player, return.

Acquire a lock: helpers.get_lock(player_id, player_id.."_"..area_id.."_"..object.id). If already locked, return.

Password ("Password Locked" non‑empty string): ezlocks.check_password(player_id, "Enter password:", password). On failure, release lock, return.

Cost ("Cost Type" non‑empty):

cost_amount = tonumber("Cost Amount" or 1).

Dry‑run condition.evaluate(player_id, {type=cost_type, amount=cost_amount, consume=false}). On failure, message "Cost Failure Message" or a default, release lock, return.

Question: "Spend N <resource> to unlock this Mystery Data?". Declining releases the lock and returns.

Then actually consume with {type=cost_type, amount=cost_amount, consume=true}. On failure, message, release lock, return.

Locked ("Locked" == true): messages "The Mystery Data is locked." and asks "Use an Unlocker to open it?" via ezlocks.check_item(..., "Unlocker", 1, true). On failure, release lock, return.

Quiz (Type == "quiz"): reads "Quiz List", calls run_quiz_from_list with "Failure Message" (default "Incorrect answer."). Result stored in can_collect.

If can_collect is true:

Messages "Accessing the mystery data\x01...\x01".

Awaits collect_datum(player_id, object, object.id, datum_type == "quiz").

Else (quiz failed):

on_fail = "On Fail" or "retry".

"hide_once" → ezmemory.hide_object_from_player.

"hide_temp" → ezmemory.hide_object_from_player_till_disconnect.

"explode" → ezbus:emit("explode", {actor_id=object.id, area_id, max_explosions=tonumber("Explosion Count" or 3)}), then hide_object_from_player_till_disconnect.

"retry" → no change.

Releases lock.

### 9.8 read_datum_information(area_id, object)

Calls helpers.read_item_information(area_id, object.id).

If it succeeds and item_info.type == "random", extracts Next N options; returns false if none are present.

Returns the item_info table.

### 9.9 collect_datum(player_id, object, datum_id_override, is_quiz)

Returns a Promise.

Reads the area.

Builds item_info:

Quiz: {type = "Reward Type" or "item", name = "Reward Name", amount = tonumber("Reward Amount" or 1), description = "Reward Description" or "???", price = 0}.

Otherwise: uses read_datum_information.

Returns if the info is missing or false.

random: picks a random Next N, recursively calls collect_datum on the selected object (same datum_id_override, is_quiz=false).

encounter:

Reads item_info.name (encounter name). Warns and returns if missing.

Messages "Oh no! The Mystery Data was a virus!".

ezmemory.hide_object_from_player_till_disconnect(player_id, area_id, datum_id_override).

Awaits ezencounters.begin_encounter_by_name(player_id, encounter_name).

Other: reads the player's direction, calls ezmemory.play_anim_get(player_id), gives the item with notify, then ezmemory.set_direction_anim(player_id, direction).

Emits ezbus:emit("mystery_collected", {player_id, area_id, object_id=datum_id_override, item_info}).

For non‑encounter types:

If "Once" is true → ezmemory.hide_object_from_player.

Always ezmemory.hide_object_from_player_till_disconnect.

### 9.10 Tiled object types and properties

Object types
| Type | Handler |
| --- | --- |
| "Mystery Data" | try_collect_datum via object_interaction |
| "Mystery Datum" | same |

Custom properties on a Mystery Data object
| Property | Type | Used as |
| --- | --- | --- |
| `"Once"` | bool/string | Permanent hide on collection |
| `"Locked"` | bool/string | Requires Unlocker item |
| `"Password Locked"` | string | Requires matching password |
| `"Cost Type"` | string | "money", "fragments", "tokens", "item" |
| `"Cost Amount"` | number | Cost |
| `"Cost Failure Message"` | string | Message on cost failure |
| `"Type"` | string | "keyitem", "item", "money", "random", "quiz", "fragments", "tokens", "encounter" |
| `"Name"` | string | Item/encounter name |
| `"Description"` | string | Item description |
| `"Amount"` | number | Item amount |
| `"Price"` | number | Item price |
| `"Quiz List"` | object id | Points to a Quiz List object |
| `"Failure Message"` | string | Shown on quiz failure |
| `"On Fail"` | string | "retry" (default), "hide_once", "hide_temp", "explode" |
| `"Explosion Count"` | number | Default 3 |
| `"Reward Type"` | string | For quiz rewards |
| `"Reward Name"` | string | For quiz rewards |
| `"Reward Amount"` | number | Default 1 |
| `"Reward Description"` | string | Default "???" |
| `"Next N"` | object id | For "random" type; selected at random |

Area custom properties
| Property | Type | Default |
| --- | --- | --- |
| `"Mystery Data Minimum"` | number | 1 |
| `"Mystery Data Maximum"` | number | 0 |

If min > max, hiding is skipped (no mysteries visible).

### 9.11 Quiz objects (referenced, not handled here)

"Quiz List" type: has numbered properties "Next 1..10" pointing to "Quiz Question" objects.

"Quiz Question" type: has "Question", "Option 1..3", "Correct Answer" (default 1).

These are built by the user in Tiled; ezmystery just reads them via ezcache.

---

<a id="part-10"></a>
## 🧩 Part 10 — ezquests, ezpress, ezchristmas, ezrushroads, ezweather, ezmenus

### 10.1 ezquests.lua

Quest framework. A quest is a Lua table registered at runtime via ezquests.add_quest.

#### 10.1.1 Internal state

```lua
ezquests.quests = {}   -- [quest_name] = quest table
```

#### 10.1.2 Quest schema

A quest must be:

```lua
{
  name                = string,                        -- required
  handle_event_async  = function(self, player_id, event_value) -> Promise,  -- required
  determine_state     = function(self, player_id) -> string,                -- required
}
```

#### 10.1.3 Public API

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `ezquests.add_quest(quest)` | table | — | Warns if name missing, handle_event_async missing, determine_state missing. Replaces existing with a warning. |
| `ezquests.set_player_quest_flag(player_id, quest_name, flag_name, flag_state)` |  | — | Writes to player_memory.quests[quest_name][flag_name] and saves. Logs. |
| `ezquests.get_player_quest_flag(player_id, quest_name, flag_name, flag_state?)` |  | any\|nil | Reads from memory. The 4th argument is unused. |
| `ezquests.clear_player_quest_flags(player_id, quest_name)` |  | — | Resets player_memory.quests[quest_name] = {} and saves. |
| `ezquests.get_quest(quest_name)` |  | quest\|nil | Warns if not found. |
| `ezquests.get_player_quest_state(player_id, quest_name)` |  | string\|nil | Calls quest:determine_state(player_id). Returns nil (with warning) if quest missing. |
| `ezquests.quest_event(player_id, quest_name, event_value)` |  | Promise | Calls quest:handle_event_async(player_id, event_value). If quest missing, warns and returns an empty async Promise. |

#### 10.1.4 Persistent quest memory layout

Stored under player_memory.quests:

```lua
{
  [quest_name] = {
    [flag_name] = any_value,
  }
}
```

#### 10.1.5 Bundled example quest

Get Punched — demonstrates the API:

handle_event_async: if accepted flag is set OR event_value == "accepted", sets the flag named after event_value. If event_value == "reset", clears all flags for this quest.

determine_state: returns "punched", "accepted", or "unaccepted" based on flags.

It is added to ezquests.quests via ezquests.add_quest(quest_get_punched).

#### 10.1.6 Relationship with other systems

dialogue_types.quest_switch — reads state via ezquests.get_player_quest_state.

dialogue_types.quest_event — calls ezquests.quest_event and emits ezbus:emit("quest_event", {player_id, quest_name, event_value}).

condition.quest_flag — reads flag via ezquests.get_player_quest_flag.

eznpcs — listens on quest_event to refresh quest‑exclusive NPCs.

### 10.2 ezpress.lua

"Minish Mode" — scales players up/down via ScaleX / ScaleY animations.

#### 10.2.1 Module constants

```lua
local compressSfx = "/server/assets/ezlibs-assets/sfx/compress.ogg"
```

#### 10.2.2 Internal state

```lua
compressed_players = {}    -- [player_id] = true
area_triggers      = {}    -- [area_id] = array of { x, y, z, width, height, type = "compress"|"decompress" }
```

#### 10.2.3 Public API

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `ezpress.get_area_minish_mode(area_id)` |  | boolean | Reads "Minish Mode" live (string "true" or boolean true). |
| `ezpress.compress(player_id, immediate)` |  | — | Scales to 3/8. Duration is 0 when immediate, else 0.15 s. Plays compressSfx. Sets compressed_players[player_id] = true. Emits ezbus:emit("player_compressed", {player_id}). |
| `ezpress.decompress(player_id, immediate)` |  | — | Scales to 1. Duration same as above. Plays compressSfx. Clears compressed_players[player_id]. Emits ezbus:emit("player_decompressed", {player_id}). |
| `ezpress.apply_map_property(player_id, area_id, immediate)` |  | — | Reads get_area_minish_mode(area_id) and compresses/decompresses. |
| `ezpress.check_and_apply(player_id, area_id, pos)` | pos: {x,y,z} | — | Looks up area_triggers[area_id] and applies the first matching tile (strictly inside: pos.x > t.x and pos.x < t.x+t.width etc.). |
| `ezpress.handle_player_join(player_id)` |  | — | Provides compressSfx to the player. Applies map property immediately, then checks tiles (animated). |
| `ezpress.handle_player_transfer(player_id)` |  | — | Applies map property immediately, then checks tiles (animated). |
| `ezpress.handle_player_disconnect(player_id)` |  | — | Clears compressed_players[player_id]. |

#### 10.2.4 Init scan (runs at module load)

Scans every area for objects with Compress == true or Decompress == true (either boolean or string "true"). For each, creates a rectangle trigger via eztriggers.add_rectangle_trigger(area_id, obj, obj.width, obj.height).

Wires:

"entered" — calls compress / decompress with animation.

"departed" — re‑applies the area's minish mode.

Also stores the tile rect in area_triggers[area_id] for the manual check on join/transfer.

#### 10.2.5 Tiled object properties

| Property | Type | Meaning |
| --- | --- | --- |
| `"Compress"` | bool/string | Identifies a compress tile |
| `"Decompress"` | bool/string | Identifies a decompress tile |

#### 10.2.6 Area custom property

| Property | Type | Meaning |
| --- | --- | --- |
| `"Minish Mode"` | string "true" / bool true | Applies compression on area enter |

#### 10.2.7 Cross‑module behavior

ezwarps/main.lua calls ezpress.get_area_minish_mode(target_area) before a warp and immediately compresses/decompresses the player (no animation) so the arriving sprite is already scaled.

### 10.3 ezchristmas.lua

Very small module. On require:

Lists all areas.

Calls ezweather.start_snow_in_area(area_id) for each.

Prints "[ezchristmas] let it snow, let it snow, let it snow. in <area_id>".

Returns ezchristmas (empty table). It has no public API; loading it is the effect.

### 10.4 ezrushroads.lua

A "Rush Road" minigame where eating Rush Food activates tiles that launch the player across a grid.

#### 10.4.1 Module constants

```lua
local rush_texture   = "/server/assets/ezlibs-assets/ezrushroads/rushy.png"
local rush_animation = "/server/assets/ezlibs-assets/ezrushroads/rushy.anim"

local FED_RUSH_TEXTURE = "/server/assets/ezlibs-assets/ezrushroads/fed_rush.png"
local RUSH_DL_ANIM     = "/server/assets/ezlibs-assets/ezrushroads/rush_dl.anim"
local RUSH_DR_ANIM     = "/server/assets/ezlibs-assets/ezrushroads/rush_dr.anim"

local BASE_FOOD_NAME = "Rush Food"
local BASE_FOOD_DESC = "You have %d Rush Food."

local OFFMAP_X = -1000
local OFFMAP_Y = -1000
```

Local helpers:

async, await (built on Async).

get_table_length(tbl).

get_anim_state_from_direction(direction) — returns "IDLE_DR" for "Down Right", "IDLE_DL" for "Down Left", otherwise nil.

#### 10.4.2 State

```lua
rush_roads          = {}   -- [area_id][road_id] = road info
player_temp_bots    = {}   -- [player_id][area_id][road_id] = bot_name
player_active_animation = {} -- [player_id] = { seq, area, group_id, roads = { [road_id] = bot_name } }
bot_occupants       = {}   -- [bot_name] = { players = {[player_id]=true}, road = road_ref }
any_player          = {}   -- [player_id] = true
```

#### 10.4.3 Food memory layout (persisted)

Stored under player_memory.rushroads:

```lua
{
  food    = number,
  cleared = { [area_id] = { [road_id_string] = true } },
}
```

Item schema (created per player):

```lua
{
  name        = "Rush Food",
  description = "You have N Rush Food.",
  type        = "keyitem",
}
```

Item id: "rush_food_" .. player_id.

#### 10.4.4 Public API

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `ezrushroads.get_food(player_id)` |  | number |  |
| `ezrushroads.add_food(player_id, amount?)` |  | number | Default amount 1. Refreshes the key item description. |
| `ezrushroads.remove_food(player_id, amount?)` |  | number (new total) or -1 if insufficient |  |
| `ezrushroads.init()` |  | — | Scans every area for "Rush Road" objects, registers them, creates permanent bots, creates rectangle triggers, then groups roads. Called once from root main. |
| `ezrushroads.handle_player_join(player_id)` |  | — | Gives starting food (10, +6 if name is "D3str0y3d"), ensures food item exists, creates temp bots, updates visibility. |
| `ezrushroads.handle_player_disconnect(player_id)` |  | — | Cleans up temp bots, removes from bot_occupants, resets occupied bots to their original position. |
| `ezrushroads.handle_player_transfer(player_id)` |  | — | Updates visibility, clears the active animation. |
| `ezrushroads.handle_object_interaction(player_id, object_id)` |  | Promise\|nil | Handles activation of a Rush Road group. |

#### 10.4.5 Road info schema (per area in rush_roads[area_id][road_id])

```lua
{
  id, x, y, z,
  custom_properties,
  group_id,               -- assigned during grouping
  bot_name,               -- permanent bot name if created
  original_x, y, z,       -- resting positions
  down_x, down_y, down_z, -- pressed positions (original + 0.1)
  anim_state,             -- "IDLE_DR" | "IDLE_DL"
}
```

#### 10.4.6 Grouping (group_rush_roads_in_area)

Builds a list of all road ids in the area.

Runs a DFS over cardinal‑adjacency (|dx|+|dy| == 1 after rounding x/y to int) to assign a group_id.

Prints how many groups were formed.

#### 10.4.7 Permanent bot creation (create_permanent_bot)

Bot name: "rush_perm_" .. area_id .. "_" .. road_id.

Position: linked_obj.x - 0.5, linked_obj.y - 0.5, linked_obj.z - 1.

Uses FED_RUSH_TEXTURE and either RUSH_DL_ANIM or RUSH_DR_ANIM depending on the "Direction" of the road object ("Down Left" → DL, "Down Right" → DR).

Animation state: "IDLE_DL" or "IDLE_DR".

Registers in bot_occupants[bot_name] = { players = {}, road = road }.

#### 10.4.8 Trigger setup (process_rush_road)

Registers the road in rush_roads[area_id].

If the object has a "Rush Object" property pointing to a linked object, creates a permanent bot at that linked object's position using the road's "Direction".

Creates a rectangle trigger of width 64 and height 32 via eztriggers.add_rectangle_trigger(area_id, object, width, height, "rush_trigger").

Wires:

"entered" → ezbus:emit("rush_tile_entered", {player_id, area_id, road_id, bot_name}).

"departed" → ezbus:emit("rush_tile_departed", {player_id, area_id, road_id, bot_name}).

#### 10.4.9 ezbus:on("rush_tile_entered", ...)

Adds the player to bot_occupants[bot_name].players. When the first player steps in, moves the permanent bot from (original_x, original_y) to (down_x, down_y, down_z).

#### 10.4.10 ezbus:on("rush_tile_departed", ...)

Removes the player. When the last leaves, returns the bot to (original_x, original_y, original_z).

#### 10.4.11 Visibility control (update_visibility_for_player)

Reads player_memory.rushroads.cleared[area_id] set.

For each road:

If cleared: Net.exclude_object_for_player.

Else: Net.include_object_for_player.

For the road's permanent bot: include_actor_for_player if cleared, exclude_actor_for_player otherwise.

#### 10.4.12 handle_object_interaction(player_id, object_id)

Triggered by a Rush Road object interaction.

Flow:

Reads area, object (must be "Rush Road").

Reads road = rush_roads[area][object_id].

Counts group_size (number of roads with the same group_id; or 1 if no group).

food = ezrushroads.get_food(player_id). If food < group_size, messages "You don't have enough Rush Food..." and returns.

Returns a Promise that:

Asks "Would you like to use N Rush Food to activate this group?". If declined, returns.

Locks player input.

Spends group_size food (via remove_food).

Collects all roads in the same group (or the single road).

Marks them cleared in player_memory.rushroads.cleared[area].

Immediately excludes the road objects from the player.

Runs the animation sequence on temp bots:

Moves each temp bot to (road.x + 0.5, road.y + 0.5) instantly.

Runs a keyframe sequence: IDLE_D, WIND_UP, LAUNCH, SPIN × several, END.

Stores the animation state in player_active_animation[player_id].

After 3.6 s, if the sequence hasn't been superseded:

Moves temp bots off‑map.

Includes the permanent bots for all cleared roads.

Unlocks input.

Clears the animation state.

### 10.5 ezweather.lua

#### 10.5.1 Module constants

```lua
weather_properties = {
  "Song",
  "Foreground Animation",
  "Foreground Texture",
  "Foreground Parallax",
  "Foreground Vel X",
  "Foreground Vel Y"
}
```

#### 10.5.2 State

```lua
volatile_memory        = {}  -- [area_id] = { type, camera_tint }
fine_weather_properties= {}  -- [area_id][property_name] = default value
```

#### 10.5.3 Init scan

On module load, for each area:

Reads area custom properties.

Records each weather_properties entry (or "" if missing) in fine_weather_properties[area_id].

#### 10.5.4 Public API

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `ezweather.start_rain_in_area(area_id)` |  | — | Sets volatile_memory with type="rain" and camera tint {10,10,40,120}. Optionally sets "Rain Song". Sets foreground animation/texture/parallax/vel. Fades camera for players. Emits ezbus:emit("weather_changed", {area_id, new_type="rain"}). |
| `ezweather.start_snow_in_area(area_id)` |  | — | Tint {255,255,255,40}. Optionally "Snow Song". Foreground snow asset. Vel Y = -0.1. |
| `ezweather.start_fog_in_area(area_id)` |  | — | Tint {0,0,0,0}. Foreground fog asset. Parallax 0.0. |
| `ezweather.get_area_weather(area_id)` |  | {type, camera_tint} | Defaults to {type="clear", camera_tint={0,0,0,0}}. |
| `ezweather.clear_weather_in_area(area_id)` |  | — | Resets tint, restores all default properties, emits weather_changed with new_type="clear". |
| `ezweather.handle_player_transfer(player_id)` |  | — | Fades the player's camera to the current area's tint. |
| `ezweather.handle_player_join(player_id)` |  | — | Same as transfer. |

#### 10.5.5 Asset paths

Rain: "/server/assets/ezlibs-assets/ezweather/rain.animation" + "/server/assets/ezlibs-assets/ezweather/rain.png", parallax 1.3, Vel X 0.2, Vel Y 0.3.

Snow: "/server/assets/ezlibs-assets/ezweather/snow.animation" + "/server/assets/ezlibs-assets/ezweather/snow.png", parallax 1.3, Vel X 0.2, Vel Y -0.1.

Fog: "/server/assets/ezlibs-assets/ezweather/fog.animation" + "/server/assets/ezlibs-assets/ezweather/fog.png", parallax 0.0, Vel X 0.05, Vel Y 0.05.

#### 10.5.6 Area custom properties used

| Property | Type | Meaning |
| --- | --- | --- |
| `"Rain Song"` | string | Optional song path to play when raining |
| `"Snow Song"` | string | Optional song path to play when snowing |

### 10.6 ezmenus.lua

A small helper for building open‑board menus with async await helpers.

#### 10.6.1 Public API

| Function | Parameters | Returns | Notes |
| --- | --- | --- | --- |
| `ezmenus.open_menu(player_id, board_name, color, posts)` |  | board_emitter | Calls Net.open_board, then augments the returned emitter with two new methods. |

#### 10.6.2 Extended emitter methods

board_emitter.close_async() — returns a Promise. Registers a one‑time "board_close" listener, calls Net.close_bbs(player_id), then polls until the close event fires or a 2‑second timeout elapses.

board_emitter.selection_once() — returns a Promise resolving to the selected post_id, false if the player disconnected, or false if the board was closed without selecting. Registers a player_disconnect listener (removed on completion), post_selection and board_close listeners on the emitter, and polls every 0.02 s until one of those events fires.

color is {r, g, b}. posts is the array of post entries passed through to Net.open_board.

---

<a id="part-11"></a>
## 🧱 Part 11 — generate-ezlibs-tiled.lua (Tiled Type Generator)

This script generates a Tiled‑compatible JSON file (ezlibs-tiled-types.json by default) containing every custom enum and object type (class) used by ezlibs. Run it once and import into Tiled to get autocomplete/defaults for all the custom properties.

### 11.1 How it runs

At the end of the file:

```lua
if arg and arg[0] and arg[0]:find("generate_tiled_types_json.lua") then
    local out = arg[1]
    main(out)
else
    return { generate = main }
end
```

If invoked as a script (lua generate-ezlibs-tiled.lua [output_path]), it writes the JSON and prints "Generated Tiled types: <path>".

If required as a module, returns { generate = main } so a caller can run main(output_path, pretty?).

json.encode(types, pretty) uses the ezlibs json.lua. Pretty printing is only enabled when explicitly passed as truthy.

### 11.2 Output structure

The output is a JSON array of objects. Each entry has:

id — sequential starting at 1.

name, storageType, type, values, valuesAsFlags for enums.

id, name, color, drawFill, type, useAs, members for classes.

Enums are emitted first (alphabetically iterated over pairs(Enums)), then classes in source order.

### 11.3 Enums (Enums table)

##### `Direction (string)`

**Values:** Up, Down, Left, Right, Up Left, Up Right, Down Left, Down Right

##### `MysteryType (string)`

**Values:** keyitem, item, money, random, quiz, fragments, tokens, encounter

##### `WaypointType (string)`

**Values:** first, random, before, after

##### `DialogueType (string)`

**Values:** first, question, quiz, random, itemcheck, before, after, shop, password, quest_switch, quest_event, item, email, questcheck, battle_npc

##### `ItemType (string)`

**Values:** item, keyitem, money, fragments, tokens

##### `CurrencyType (string)`

**Values:** money, fragments, tokens

##### `QuizFailAction (string)`

**Values:** retry, hide_once, hide_temp, explode

##### `TriggerShape (string)`

**Values:** rect, ellipse

##### `ButtonBehavior (string)`

**Values:** Repeatable, One-Time, Dynamic, Custom, Timed

##### `KeyType (string)`

**Values:** money, fragments, tokens, item, bossgate

##### `ButtonChainType (string)`

**Values:** Any, Exclusive

### 11.4 Object types (classes)

For each class, the properties are listed as name, type, default value, and (where applicable) an enum reference.

Type tokens used in the members array: string, number, bool, object, file.

##### `Checkpoint`

**Color:** `#ffaa00`

| Property | Type | Default | Enum |
| --- | --- | --- | --- |
| `Password` | string | "" |  |
| `Key Type` | string | "money" | KeyType |
| `Key Item Name` | string | "" |  |
| `Required Keys` | number | 1 |  |
| `Consume` | bool | false |  |
| `Once` | bool | false |  |
| `Unlocking Asset Name` | string | "bn5cubegreen_bot" |  |
| `Unlocking Animation Time` | number | 0 |  |
| `Unlocking Sound Path` | string | "/server/assets/ezlibs-assets/sfx/panel_change.ogg" |  |
| `Skip Prompt` | bool | false |  |
| `Description` | string | "It's a Security Cube" |  |
| `Unlocked Message` | string | "The Security Cube was unlocked!" |  |
| `Unlock Failed Message` | string | "You were unable to unlock the Security Cube" |  |

##### `Mystery Data`

**Color:** `#00aaff`

| Property | Type | Default | Enum |
| --- | --- | --- | --- |
| `Locked` | bool | false |  |
| `Password Locked` | string | "" |  |
| `Once` | bool | false |  |
| `Type` | string | "item" | MysteryType |
| `Name` | string | "" |  |
| `Description` | string | "" |  |
| `Amount` | number | 1 |  |
| `Quiz List` | object | "" |  |
| `Failure Message` | string | "" |  |
| `On Fail` | string | "retry" | QuizFailAction |
| `Explosion Count` | number | 3 |  |
| `Reward Type` | string | "item" | ItemType |
| `Reward Name` | string | "" |  |
| `Reward Amount` | number | 1 |  |
| `Reward Description` | string | "" |  |
| `Cost Type` | string | "" | CurrencyType |
| `Cost Amount` | number | 1 |  |
| `Cost Failure Message` | string | "" |  |
| `Next 1..10` | object | "" |  |

##### `Quiz List`

**Color:** `#aa66cc`

| Property | Type | Default |
| --- | --- | --- |
| `Next 1..10` | object | "" |

##### `Quiz Question`

**Color:** `#88aa44`

| Property | Type | Default |
| --- | --- | --- |
| `Question` | string | "" |
| `Option 1` | string | "" |
| `Option 2` | string | "" |
| `Option 3` | string | "" |
| `Correct Answer` | number | 1 |

##### `Location Trigger`

**Color:** `#88ff88`

| Property | Type | Default |
| --- | --- | --- |
| `Event Name` | string | "" |
| `Name` | string | "" |

##### `Server Warp`

**Color:** `#ff8888`

| Property | Type | Default | Enum |
| --- | --- | --- | --- |
| `Incoming Data` | string | "" |  |
| `Direction` | string | "Down" | Direction |
| `Warp In` | bool | false |  |
| `Arrival Animation` | string | "" |  |
| `Dont Teleport` | bool | false |  |
| `Address` | string | "" |  |
| `Port` | number | 0 |  |
| `Data` | string | "" |  |
| `Warp Out` | bool | false |  |

##### `Custom Warp`

**Color:** `#ff8888`

| Property | Type | Default | Enum |
| --- | --- | --- | --- |
| `Incoming Data` | string | "" |  |
| `Direction` | string | "Down" | Direction |
| `Warp In` | bool | false |  |
| `Arrival Animation` | string | "" |  |
| `Dont Teleport` | bool | false |  |
| `Target Area` | string | "" |  |
| `Target Object` | string | "" |  |
| `Leave Animation` | string | "" |  |

##### `Interact Warp`

**Color:** `#ff8888`

Same property set as Custom Warp.

##### `Radius Warp`

**Color:** `#ff8888`

| Property | Type | Default | Enum |
| --- | --- | --- | --- |
| `Incoming Data` | string | "" |  |
| `Direction` | string | "Down" | Direction |
| `Warp In` | bool | false |  |
| `Arrival Animation` | string | "" |  |
| `Dont Teleport` | bool | false |  |
| `Activation Radius` | number | 1 |  |
| `Target Area` | string | "" |  |
| `Target Object` | string | "" |  |
| `Leave Animation` | string | "" |  |

##### `NPC`

**Color:** `#aaaaaa`

| Property | Type | Default | Enum |
| --- | --- | --- | --- |
| `Direction` | string | "Down" | Direction |
| `Asset Name` | string | "" |  |
| `Animation Name` | string | "" |  |
| `Mug Animation Name` | string | "" |  |
| `Dont Face Player` | bool | false |  |
| `Next Waypoint 1` | object | "" |  |
| `Dialogue Type` | string | "" | DialogueType |
| `Mugshot` | string | "" |  |
| `Text 1` | string | "" |  |
| `Text 2` | string | "" |  |
| `Text 3` | string | "" |  |
| `Next 1` | object | "" |  |
| `Next 2` | object | "" |  |
| `Item 1` | object | "" |  |
| `Item 2` | object | "" |  |
| `Take Item` | bool | false |  |
| `Date` | string | "" |  |
| `Quest Name` | string | "" |  |
| `Event Value` | string | "" |  |
| `Dont Notify` | bool | false |  |
| `Encounter Name` | string | "" |  |
| `Failure Message` | string | "" |  |
| `Player Exclusive` | bool | false |  |
| `Quest NPC` | bool | false |  |
| `Quest Exclusive` | string | "" |  |
| `Quest State` | string | "active" |  |

##### `Waypoint`

**Color:** `#55ff55`

| Property | Type | Default | Enum |
| --- | --- | --- | --- |
| `Wait Time` | number | 0 |  |
| `Direction` | string | "" | Direction |
| `Waypoint Type` | string | "first" | WaypointType |
| `Date` | string | "" |  |
| `Next Waypoint 1..5` | object | "" |  |

##### `Radius Encounter`

**Color:** `#ff5555`

| Property | Type | Default |
| --- | --- | --- |
| `Radius` | number | 1 |
| `Name` | string | "" |
| `Path` | file | "" |
| `Once` | bool | false |

##### `Water Refill`

**Color:** `#4444ff`

No members.

##### `Item`

**Color:** `#ffdd44`

| Property | Type | Default | Enum |
| --- | --- | --- | --- |
| `Name` | string | "" |  |
| `Type` | string | "item" | ItemType |
| `Description` | string | "" |  |
| `Amount` | number | 1 |  |
| `Price` | number | 999999 |  |

##### `Dialogue`

**Color:** `#cc66cc`

| Property | Type | Default | Enum |
| --- | --- | --- | --- |
| `Dialogue Type` | string | "first" | DialogueType |
| `Mugshot` | string | "" |  |
| `Text 1` | string | "" |  |
| `Text 2` | string | "" |  |
| `Text 3` | string | "" |  |
| `Next 1..5` | object | "" |  |
| `Item 1` | object | "" |  |
| `Item 2` | object | "" |  |
| `Take Item` | bool | false |  |
| `Date` | string | "" |  |
| `Quest Name` | string | "" |  |
| `Event Value` | string | "" |  |
| `Dont Notify` | bool | false |  |
| `Email Id` | string | "" |  |
| `Email Icon` | number | 1 |  |
| `Email Title` | string | "Mail" |  |
| `Email From` | string | "???" |  |
| `Body 1..10` | string | "" |  |
| `Notify Delay` | number | 1.5 |  |
| `Notify Message` | string | "Looks like you got an e-mail." |  |
| `Mug Texture Path` | string | "" |  |
| `Mug Animation Path` | string | "" |  |
| `Persist` | bool | true |  |
| `Encounter Name` | string | "" |  |
| `Failure Message` | string | "" |  |

##### `Explosion Trigger`

**Color:** `#ff6600`

| Property | Type | Default |
| --- | --- | --- |
| `Target` | string | "" |
| `Follow` | bool | false |
| `Once` | bool | false |

##### `Rush Road`

**Color:** `#ffaa00`

| Property | Type | Default | Enum |
| --- | --- | --- | --- |
| `Rush Object` | object | "" |  |
| `Direction` | string | "Down Left" | Direction |

##### `Compression Tile`

**Color:** `#88aaff`

| Property | Type | Default |
| --- | --- | --- |
| `Compress` | bool | false |
| `Decompress` | bool | false |

##### `Admin Console`

**Color:** `#ffaa00`

No members.

##### `Button Bot Details`

**Color:** `#99ddff`

| Property | Type | Default | Enum |
| --- | --- | --- | --- |
| `Asset Name` | string | "" |  |
| `Direction` | string | "Down" | Direction |
| `Animation Name` | string | "" |  |
| `Mug Animation Name` | string | "" |  |
| `Active Animation` | string | "ACTIVE" |  |
| `Inactive Animation` | string | "INACTIVE" |  |
| `Activated Animation` | string | "" |  |
| `Deactivated Animation` | string | "" |  |
| `Activation Animation Duration` | number | 0.5 |  |
| `Deactivation Animation Duration` | number | 0.5 |  |

##### `OW Button`

**Color:** `#66ccff`

| Property | Type | Default | Enum |
| --- | --- | --- | --- |
| `Bot Details` | object | "" |  |
| `Next 1` | object | "" |  |
| `Button Behavior` | string | "One-Time" | ButtonBehavior |
| `Script Path` | file | "" |  |
| `Trigger Object` | object | "" |  |
| `Button Activated Behavior` | object | "" |  |
| `Button Deactivated Behavior` | object | "" |  |
| `Button Chain Type` | string | "Any" | ButtonChainType |
| `Activated Time` | number | 1 |  |

##### `Unlock Behavior`

**Color:** `#ffcc00`

| Property | Type | Default |
| --- | --- | --- |
| `Unlock This` | object | "" |
| `Unlock Permanently` | bool | false |
| `Area Wide` | bool | false |

##### `Relock Behavior`

**Color:** `#ff8888`

| Property | Type | Default |
| --- | --- | --- |
| `Relock This` | object | "" |
| `Area Wide` | bool | false |

##### `Button Trigger`

**Color:** `#aaddff`

| Property | Type | Default | Enum |
| --- | --- | --- | --- |
| `Trigger Type` | string | "rect" | TriggerShape |

### 11.5 Type mapping notes

type = "object" — a reference to another Tiled object's id (usually used together with numbered properties Next 1..N).

type = "file" — a path string in Tiled's file field.

type = "bool" — Tiled emits these as booleans in the map JSON. The runtime reads them mostly with is_property_true (accepts true, "true", "True", or nonzero numbers) because Tiled sometimes serializes them as strings when edited manually.

propertyType — set only when the enum name is passed. The Tiled JSON key is propertyType.

### 11.6 Registration mapping (which scripts actually consume each class)

| Tiled type | Consumer(s) |
| --- | --- |
| Checkpoint | ezcheckpoints |
| Mystery Data | ezmystery |
| Quiz List | ezmystery (read via ezcache) |
| Quiz Question | ezmystery (read via ezcache) |
| Location Trigger | eztriggers |
| Server Warp | ezwarps (landing registered only if "Incoming Data" is set) |
| Custom Warp | ezwarps |
| Interact Warp | ezwarps |
| Radius Warp | ezwarps |
| NPC | eznpcs |
| Waypoint | eznpcs (read via ezcache when following) |
| Radius Encounter | ezencounters |
| Water Refill | ezfarms |
| Item | helpers.read_item_information (referenced by dialogue/NPC/shop) |
| Dialogue | eznpcs.dialogue_types (via do_dialogue) — note: NPCs commonly embed dialogue properties directly, but a dedicated Dialogue object is also supported. |
| Explosion Trigger | Declared but no handler in provided files. |
| Rush Road | ezrushroads |
| Compression Tile | ezpress |
| Admin Console | ezusers |
| Button Bot Details | ezbuttons (read by reference) |
| OW Button | ezbuttons |
| Unlock Behavior | ezbuttons (read by reference) |
| Relock Behavior | ezbuttons (read by reference) |
| Button Trigger | ezbuttons (read by reference via Trigger Object) |

Types declared here but not appearing in any object_registry.register_handler in the provided scripts:

Quiz List, Quiz Question — read by ezmystery via ezcache.get_object_by_id_cached.

Waypoint — read by eznpcs via ezcache.

Item — read by helpers.read_item_information.

Dialogue — read by do_dialogue via ezcache.

Explosion Trigger — no consumer in the code shown.

Button Bot Details, Unlock Behavior, Relock Behavior, Button Trigger — read only as referenced objects from OW Button properties.

---

<a id="part-12"></a>
## 🔎 Part 12 — Final Combined Cross‑Reference

This part consolidates information that appears across multiple parts, so you can find every consumer of an event, every registered Tiled object type, every asset path, etc., in one place.

### 12.1 Net event matrix

main.lua (root) routes each Net:on(<event>) to all plugins that define the corresponding handle_* (or on_tick). Handlers listed per plugin are those that exist in the supplied files.

##### `battle_results`

| Plugin | Handler |
| --- | --- |
| main.lua (own handler) | builds stats, iterates plugins calling plugin.handle_battle_results(player_id, stats) |
| ezencounters | own Net:on("battle_results", ...): dispatches stored callbacks and clears the encounter; emits encounter_finished |
| eznpcs/dialogue_types.lua | own Net:on("battle_results", ...): just logs Net.is_player_battling |

##### `shop_purchase`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_shop_purchase(player_id, item_name) |

##### `shop_close`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_shop_close(player_id) |

##### `custom_warp`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_custom_warp(player_id, object_id) |
| ezwarps | ezwarps.handle_custom_warp (dispatched via main) |

##### `player_move`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_player_move(player_id, x, y, z) |
| eztriggers | eztriggers.handle_player_move (dispatched via main) |
| ezencounters | ezencounters.handle_player_move (dispatched via main) |

##### `player_request`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_player_request(player_id, data) |
| ezmemory | own Net:on("player_request", ...) — kicks player if memory not loaded |
| ezwarps | ezwarps.handle_player_request (landing lookup by data) |

##### `tile_interaction`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_tile_interaction(player_id, x, y, z, button) |
| ezfarms | ezfarms.handle_tile_interaction |

##### `post_selection`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_post_selection(player_id, post_id) |
| ezbbs | ezbbs.handle_post_selection |
| ezfarms | ezfarms.handle_post_selection |

##### `board_close`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_board_close(player_id) |
| ezbbs | ezbbs.handle_board_close |
| ezfarms | ezfarms.handle_board_close |

##### `player_avatar_change`

| Plugin | Handler |
| --- | --- |
| main.lua | builds details, calls plugin.handle_player_avatar_change(player_id, details) |
| ezmemory | ezmemory.handle_player_avatar_change |
| avatar_utils/main.lua | own Net:on("player_avatar_change", ...): calls update_player_avatar |
| ezmystery | own Net:on("avatar_change", ...) (note the event name differs) |

##### `player_join`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_player_join(player_id), then provides global sfx |
| ezmemory | ezmemory.handle_player_join |
| ezuser | handle_player_join |
| eznpcs | eznpcs.handle_player_join |
| ezwarps | ezwarps.handle_player_join |
| ezemail | own Net:on("player_join", ...): resend_all + ezannounce.send_missing |
| ezpress | ezpress.handle_player_join |
| ezrushroads | ezrushroads.handle_player_join |
| ezmystery | own Net:on("player_join", ...): fetch_player_avatar_and_details |
| ezbuttons | own Net:on("player_join", ...): hides placeholders, syncs, applies unlocks |
| ezfarms | ezfarms.handle_player_join |
| ezweather | ezweather.handle_player_join |

##### `actor_interaction`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_actor_interaction(player_id, actor_id, button) |
| eznpcs | eznpcs.handle_actor_interaction |

##### `tick`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.on_tick(delta_time) |
| eznpcs | eznpcs.on_tick |
| ezfarms | ezfarms.on_tick |

##### `player_disconnect`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_player_disconnect(player_id) |
| helpers | own Net:on("player_disconnect", ...): releases locks |
| ezmemory | ezmemory.handle_player_disconnect |
| ezuser | handle_player_disconnect |
| eznpcs | eznpcs.handle_player_disconnect |
| ezwarps | (no public handler defined) |
| ezannounce | own Net:on("player_disconnect", ...): removes from _online |
| ezbbs | ezbbs.handle_player_disconnect |
| ezmystery | ezmystery.handle_player_disconnect |
| ezpress | ezpress.handle_player_disconnect |
| ezrushroads | ezrushroads.handle_player_disconnect |
| ezencounters | ezencounters.handle_player_disconnect |
| ezfarms | (no explicit handler; handle_board_close clears its per‑player BBS state) |

##### `object_interaction`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_object_interaction(player_id, object_id, button) |
| ezbbs | ezbbs.handle_object_interaction |
| ezcheckpoints | own Net:on("object_interaction", ...) (button==0 filter) |
| eznpcs | eznpcs.handle_object_interaction |
| ezrushroads | ezrushroads.handle_object_interaction |
| ezfarms | ezfarms.handle_object_interaction |

##### `player_area_transfer`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_player_transfer(player_id) |
| ezmemory | ezmemory.handle_player_transfer |
| eznpcs | eznpcs.handle_player_transfer |
| ezwarps | ezwarps.handle_player_transfer |
| ezpress | ezpress.handle_player_transfer |
| ezrushroads | ezrushroads.handle_player_transfer |
| ezmystery | ezmystery.handle_player_transfer |
| ezencounters | ezencounters.handle_player_transfer |
| ezweather | ezweather.handle_player_transfer |
| ezbuttons | own Net:on("player_area_transfer", ...) (hides/syncs/unlocks) |

##### `textbox_response`

| Plugin | Handler |
| --- | --- |
| main.lua | plugin.handle_textbox_response(player_id, response) |
| ezbbs | ezbbs.handle_textbox_response |

#### Standalone Net:on registrations (not routed by main)

helpers: player_disconnect

ezmemory: handle_player_join (adds item_get sfx), player_request

ezcheckpoints: object_interaction

ezemail: player_join, email_read

ezannounce: player_disconnect

eznpcs/dialogue_types.lua: battle_results

ezmystery: player_join, avatar_change, object_interaction

ezbuttons: player_join, player_area_transfer

avatar_utils/main.lua: player_avatar_change

#### Net events consumed but not emitted by main.lua in this library

email_read (only ezemail listens)

avatar_change (only ezmystery listens)

### 12.2 Tiled object type → handler map

Every object_registry.register_handler call in the supplied files:

| Tiled object type | Registered by | Cache? | Handler behavior |
| --- | --- | --- | --- |
| `Location Trigger` | eztriggers | default (true) | eztriggers.add_location_event_trigger(area_id, object) |
| `OW Button` | ezbuttons | default (true) | Full button initialization (see Part 3) |
| `Admin Console` | ezusers | false | Creates interact trigger; prompts for password and assigns admin role |
| `NPC` | eznpcs | default (true) | Creates global NPC or registers as exclusive/quest‑exclusive placeholder |
| `Radius Encounter` | ezencounters | default (true) | Creates radius trigger that initiates a named encounter |
| `Radius Warp` | ezwarps | false | Registers landing (if Incoming Data) + radius trigger for use_warp |
| `Custom Warp` | ezwarps | false | Registers landing (if Incoming Data) + placeholder add_custom_warp (no‑op) |
| `Interact Warp` | ezwarps | false | Registers landing (if Incoming Data) + interact trigger |

Tiled object types read only via ezcache or Net.get_object_by_id (no handler registered)
Server Warp — ezwarps handles landings when they are registered by the user; the .id is otherwise not registered.

Checkpoint — ezcheckpoints finds checkpoints by Net.get_object_by_id from the object_interaction event.

Mystery Data / Mystery Datum — ezmystery handles via Net:on("object_interaction"), checking object.type.

Water Refill — ezfarms handles via Net:on("tile_interaction")/object_interaction logic.

Rush Road — ezrushroads.init() finds them by scanning all areas for object.type == "Rush Road".

Quiz List, Quiz Question — ezmystery loads via ezcache.get_object_by_id_cached.

Waypoint — eznpcs loads via ezcache.get_object_by_id_cached when a bot reaches a waypoint.

Item — helpers.read_item_information loads via ezcache.

Dialogue — eznpcs.do_dialogue loads via ezcache.

Button Bot Details, Unlock Behavior, Relock Behavior, Button Trigger — ezbuttons reads by id from OW Button properties.

Compression Tile — ezpress.init() scans for objects with Compress or Decompress (type name doesn't need to be exactly Compression Tile).

Explosion Trigger — declared in the Tiled type generator, but no consumer in the supplied scripts.

### 12.3 ezbus event matrix

| Event | Emitter | Listener(s) |
| --- | --- | --- |
| `announcement_sent` | ezannounce | (none in supplied code) |
| `email_sent` | ezemail | (none) |
| `item_gained / item_lost / money_spent / money_changed / fragments_changed / tokens_changed / health_changed` | ezmemory | (none) |
| `object_hidden` | ezmemory | (none) |
| `checkpoint_unlocked` | ezcheckpoints | (none) |
| `lock_attempt` | ezlocks | (none) |
| `explode` | various (ezmystery, dialogue_types.battle_npc) | ezexplosions (creates an ExplodingEffect) |
| `weather_changed` | ezweather | (none) |
| `ezbuttons.chain_unlocked` | ezbuttons | (none) |
| `player_compressed / player_decompressed` | ezpress | (none) |
| `mystery_collected` | ezmystery | (none) |
| `encounter_started / encounter_finished` | ezencounters | (none) |
| `rush_tile_entered / rush_tile_departed` | ezrushroads | ezrushroads (own listeners adjust permanent bot positions) |
| `quest_event` | dialogue_types.quest_event | eznpcs (refreshes quest‑exclusive NPCs) |
| `warp` | ezwarps.use_warp | (none) |
| `dialogue_ended` | eznpcs.clear_player_conversation | (none) |

### 12.4 Permissions matrix

Only ezbbs and ezusers consult ezusers.has_permission in the supplied files.

| Permission path | Consumer | Meaning |
| --- | --- | --- |
| `BBS.CanPin` | ezbbs.handle_post_selection | Treats the player as admin and enables the "Pin Post" option in the quiz. Also gates the actual pin/unpin toggle. |
| `BBS.CanDelete` | ezbbs.handle_post_selection | Gates the "Delete Post" option. |
| `BBS.CanPost` | (defined role defaults) | Not consulted directly in code; a postable board is required to post unless the player has BBS.CanPin. |
| `BBS.CanRead, BBS.CanEdit` | (defined role defaults) | Not consulted in the supplied code. |
| `Commands.CanAccess` | (defined role defaults) | Not consulted in the supplied code. |
| `Commands.CanWarp, Commands.CanGiftItem, Commands.CanTakeItem, Commands.CanKickUser` | (defined role defaults) | Not consulted in the supplied code. |

Default role assignments:

New players get role = "user" with user permissions.

Correct admin password assigns role = "admin" and copies the admin permission set.

### 12.5 Config keys (ezlibs-config.lua)

Consumed by the library. None are provided by ezconfig.lua; the user must supply them in ezlibs-config.lua at the server root.

| Key | Consumers |
| --- | --- |
| `PLAYERS_PATH` | ezmemory (players index JSON) |
| `ITEMS_PATH` | ezmemory (items registry JSON) |
| `AREA_PATH_FOLDER` | ezmemory (per‑area memory JSON prefix) |
| `PLAYER_PATH_FOLDER` | ezmemory (per‑player memory JSON prefix) |
| `BOARD_PATH_FOLDER` | ezbbs (BBS board JSON directory) |
| `FARM_MAP` | ezfarms (farm area id) |
| `FARM_TIMESCALE` | ezfarms (period multiplier) |
| `ENCOUNTERS_PATH` | ezencounters (encounter table module prefix) |
| `ADMIN_SEED` | ezusers (SHA‑256 seed for admin password) |
| `NEW_MAIL_MESSAGE_DELAY` | ezemail (default 1.5 s) |

ENCOUNTERS_PATH must be a directory prefix such that <prefix><area_id> is a Lua module returning {minimum_steps_before_encounter = number, encounter_chance_per_step = number, encounters = { {name=string|nil, path=string, weight=number, results_callback=function|nil}, ... }}.

### 12.6 Asset paths referenced by the library

#### SFX

| Path | Used by |
| --- | --- |
| `/server/assets/ezlibs-assets/sfx/hurt.ogg` | main.lua (provided on join) |
| `/server/assets/ezlibs-assets/sfx/item_get.ogg` | main.lua, ezmemory, ezfarms |
| `/server/assets/ezlibs-assets/sfx/recover.ogg` | main.lua |
| `/server/assets/ezlibs-assets/sfx/panel_change.ogg` | default for ezcheckpoints |
| `/server/assets/ezlibs-assets/sfx/compress.ogg` | ezpress |
| `/server/assets/ezlibs-assets/sfx/explode.ogg` | ezexplosions |
| `/server/assets/ezlibs-assets/ezfarms/card_error.ogg` | main.lua, ezfarms |
| `/server/assets/ezlibs-assets/ezfarms/hoe.ogg` | ezfarms |
| `/server/assets/ezlibs-assets/ezfarms/rain.ogg` | ezfarms |
| `/server/assets/ezlibs-assets/ezfarms/scythe.ogg` | ezfarms |
| `/server/assets/ezlibs-assets/ezfarms/swap_tool.ogg` | ezfarms |
| `/server/assets/ezlibs-assets/ezfarms/water_tile.ogg` | ezfarms |
| `/server/assets/ezlibs-assets/ezfarms/wind.ogg` | ezfarms |
| `/server/assets/ezlibs-assets/ezwarps/earthquake.ogg` | fall_in_animation, fall_off_2 |
| `/server/assets/ezlibs-assets/ezwarps/lev-bus-arrive.ogg` | lev_beast_in/out |
| `/server/assets/ezlibs-assets/ezwarps/lev-bus-leave.ogg` | lev_beast_in/out |
| `/server/assets/ezlibs-assets/ezwarps/log_in.ogg` | log_in_animation |
| `/server/assets/ezlibs-assets/ezwarps/log_out.ogg` | log_in_animation |
| `resources/sfx/falzar.ogg` | lev_beast_in/out |

#### Textures / Animations

| Path | Used by |
| --- | --- |
| `/server/assets/ezlibs-assets/ezbuttons/<Asset Name>.png` | ezbuttons |
| `/server/assets/ezlibs-assets/ezbuttons/<Asset Name>.animation` | ezbuttons |
| `/server/assets/ezlibs-assets/ezbuttons/<Animation Name>.animation` | ezbuttons (override) |
| `/server/assets/ezlibs-assets/ezcheckpoints/<Unlocking Asset Name>.png` | ezcheckpoints |
| `/server/assets/ezlibs-assets/ezcheckpoints/<Unlocking Asset Name>.animation` | ezcheckpoints |
| `/server/assets/ezlibs-assets/ezexplosions/explosion.png` | ezexplosions |
| `/server/assets/ezlibs-assets/ezexplosions/explosion.animation` | ezexplosions |
| `/server/assets/ezlibs-assets/eznpcs/sheet/<Asset Name>.png` | eznpcs |
| `/server/assets/ezlibs-assets/eznpcs/sheet/<Asset Name>.animation` | eznpcs |
| `/server/assets/ezlibs-assets/eznpcs/sheet/<Animation Name>.animation` | eznpcs (override) |
| `/server/assets/ezlibs-assets/eznpcs/mug/<Mugshot>.png` | eznpcs |
| `/server/assets/ezlibs-assets/eznpcs/mug/<Mug Animation Name>.animation` | eznpcs (override) |
| `/server/assets/ezlibs-assets/eznpcs/mug/mug.animation` | eznpcs (default) |
| `/server/assets/ezlibs-assets/eznpcs/mug/denpa-warp-sf2.png` | ezemail.send_test_email |
| `/server/assets/ezlibs-assets/eznpcs/mug/mug.animation` | ezemail.send_test_email |
| `/server/assets/ezlibs-assets/ezrushroads/rushy.png` | ezrushroads (temp bots) |
| `/server/assets/ezlibs-assets/ezrushroads/rushy.anim` | ezrushroads (temp bots) |
| `/server/assets/ezlibs-assets/ezrushroads/fed_rush.png` | ezrushroads (perm bots) |
| `/server/assets/ezlibs-assets/ezrushroads/rush_dl.anim` | ezrushroads |
| `/server/assets/ezlibs-assets/ezrushroads/rush_dr.anim` | ezrushroads |
| `/server/assets/ezlibs-assets/ezwarps/lev-beast-64-65.png` | lev_beast_in/out |
| `/server/assets/ezlibs-assets/ezwarps/lev-beast-64-65.animation` | lev_beast_in/out |
| `/server/assets/ezlibs-assets/ezwarps/logout.png` | log_in_animation |
| `/server/assets/ezlibs-assets/ezwarps/logout.animation` | log_in_animation |
| `/server/assets/ezlibs-assets/ezweather/rain.animation` | ezweather |
| `/server/assets/ezlibs-assets/ezweather/rain.png` | ezweather |
| `/server/assets/ezlibs-assets/ezweather/snow.animation` | ezweather |
| `/server/assets/ezlibs-assets/ezweather/snow.png` | ezweather |
| `/server/assets/ezlibs-assets/ezweather/fog.animation` | ezweather |
| `/server/assets/ezlibs-assets/ezweather/fog.png` | ezweather |

#### Avatar cache paths (avatar_utils/main.lua)

assets/avatars/sheet/<secret>.png

assets/avatars/sheet/<secret>.animation

assets/avatars/mug/<secret>.png

assets/avatars/mug/<secret>.animation

(avatar_utils.copy_player_avatar_to also registers these as /server/‑prefixed assets via set_or_update_asset.)

### 12.7 Item schema (persisted)

Generated by ezmemory.create_or_update_item:

```lua
{
  name        = string,
  description = string,
  key_item    = boolean,   -- "is_key"
}
```

Player item ownership is player_memory.items[item_id] = quantity.

helpers.read_item_information(area_id, item_object_id) returns:

```lua
{
  name        = string,
  amount      = number (default 1),
  description = string (default "???"),
  type        = string (default "item"),
  price       = number (default 999999),
}
```

Accepted type values used throughout the library: item, keyitem, money, fragments, tokens, random, quiz, encounter.

### 12.8 Memory namespace cross‑reference

player_memory[safe_secret] (persisted at <PLAYER_PATH_FOLDER><safe_secret>.json)
| Field | Managed by |
| --- | --- |
| items, money, fragments, tokens, meta, area_memory, emails | ezmemory |
| health, max_health | ezmemory (cache of engine values) |
| role, permissions | ezusers |
| quests | ezquests |
| farming (water) | ezfarms |
| rushroads (food, cleared) | ezrushroads |

area_memory[area_id] (persisted at <AREA_PATH_FOLDER><area_id>.json)
| Field | Managed by |
| --- | --- |
| hidden_objects | ezmemory (area‑hidden objects) |
| buttons | ezbuttons |
| tile_states, rain_started | ezfarms |
| timed_button_unlock_info, area_wide_unlock | ezbuttons |

players.json (index)
safe_secret → player name (ezmemory.update_player_list).

items.json (item registry)
item_id → item record (see §12.7).

Board files: <BOARD_PATH_FOLDER><sanitized_board_name>.json
{posts = { post, ... }, next_id = number}.

### 12.9 Global symbols defined by the library

These are defined as globals (not module‑scoped) by helpers.lua:

async(p)

await(v)

first_value_from_table(tbl)

get_table_length(tbl)

ezbuttons.lua and ezrushroads.lua also define their own local async and await (same shape), so those two files behave independently of the helpers globals.

ezusers.lua defines local async / await internally as well.

### 12.10 Things the library does not do

> ⚠️ **To avoid over‑claiming:**

- No area of the supplied scripts uses Net.get_player_avatar except avatar_utils (via copy_player_avatar_to).
- ezmail.lua is a duplicate of ezemail.lua; nothing requires it separately.
- ezchristmas.lua has no public API — requiring it is the effect.
- No scripts register handlers for the following types declared in the Tiled type generator: Explosion Trigger.
- ezfarms.list_player_tools is exposed publicly but only ezfarms.open_held_item_select calls it in the supplied code.
- ezfarms.players_using_bbs is per‑player BBS state only; it does not persist.
- ezbbs.preload_boards creates a board file for each unique board Name found on any object with the BBS flag, using BOARDS_DIR as the directory.
- ezannounce.start_watch runs at require time with the default interval of 10 seconds; it will not re‑start if called again (_watch_started guard).
- ezbuttons.build_chains is idempotent (chains_built guard) once called.
- ezbuttons and ezrushroads reuse global async/await but define them locally, so the global async/await from helpers.lua is still usable by everything else.

### 12.11 Loading order (from main.lua)

1. helpers
2. ezbus (via ezemitter)
3. eztriggers
4. ezcache
5. ezencounters (via ezencounters/main)
6. eznpcs (via eznpcs/eznpcs)
7. ezmemory
8. ezmystery
9. ezweather
10. ezwarps (via ezwarps/main)
11. ezfarms
12. helpers.safe_require('scripts/events/eznpcs_onceitem')
13. ezcheckpoints
14. ezannouncement (via ezannounce/ezannounce)
15. ezemail
16. ezexplosions
17. ezrushroads
18. ezpress
19. ezusers
20. ezbbs
21. ezbuttons
22. Optional: scripts/ezlibs-custom/custom (if present)
23. object_registry.load_all()
24. eznpcs.load_npcs()
25. ezrushroads.init()

Then all Net:on handlers are wired up and [main] ezlibs loaded in <seconds>s is printed.

### 12.12 Quick action cheat sheet

- Add a new Tiled custom type → add an entry to object_types in generate-ezlibs-tiled.lua and register a handler with object_registry.register_handler(...).
- Add a new dialogue type → add a table with name and action to dialogue_types.lua, or eznpcs.add_event({name, action}).
- Add a new bus event → ezbus:emit("name", payload) and listen via ezbus:on("name", function(event) ... end).
- Persist a player value → store it in ezmemory.get_player_memory(safe_secret) under a unique key and call ezmemory.save_player_memory(safe_secret).
- Persist an area value → ezmemory.get_area_memory(area_id) + ezmemory.save_area_memory(area_id).
- Hide/show an object for a player → ezmemory.hide_object_from_player / unhide_object_from_player (permanent) or ..._till_disconnect (session).


---

<a id="part-13"></a>
## 🧰 Part 13 — Utility Modules

The `utils/` directory contains small, reusable helpers intended to reduce duplicated table handling, validation, and logging code. These modules are dependency-free and use Lua 5.2 language and standard-library features; they do not require the server's `Net` API.

> 💡 **Integration note:** These are opt-in utility modules. Use `require` to load the module you need. The documented helper changes in `helpers.lua` reuse `ezutil` for table counting and deep copying; the other utilities do not need to be adopted by existing systems unless useful.

### 13.1 `utils/ezutil.lua` — General Utilities

| Function | Parameters | Returns | Notes |
|---|---|---|---|
| `ezutil.clamp(value, minimum, maximum)` | three numbers | `number` | Restricts `value` to the inclusive range. Asserts that arguments are numbers and `minimum <= maximum`. |
| `ezutil.table_contains(list, value)` | `table`, any value | `boolean` | Searches array-style entries with `ipairs`; does not search arbitrary keys. |
| `ezutil.table_remove_value(list, value, remove_all?)` | `table`, value, `boolean?` | `number` | Removes the first matching array entry by default. If `remove_all` is true, removes all matches. Returns the number removed. |
| `ezutil.table_count(value)` | `table` | `number` | Counts all keys by iterating with `pairs`, including non-array keys. |
| `ezutil.table_is_empty(value)` | `table` | `boolean` | Returns whether `next(value)` is `nil`. |
| `ezutil.shallow_copy(source)` | `table` | `table` | Copies key/value pairs into a new table; nested tables remain shared references. |
| `ezutil.deep_copy(source, seen?)` | any value | same kind of value | Recursively copies table keys and values, handles cycles/shared references, and preserves the source table's metatable. Non-table values are returned unchanged. |
| `ezutil.table_merge(target, source)` | two tables | `table` | Copies source key/value pairs into `target`; source values overwrite matching target keys. Mutates and returns `target`. |

Example:

```lua
local ezutil = require('scripts/ezlibs-scripts/utils/ezutil')

local health = ezutil.clamp(125, 0, 100) -- 100
local has_key = ezutil.table_contains({"Key", "Potion"}, "Key") -- true

local settings = {volume = 5, enabled = true}
ezutil.table_merge(settings, {volume = 8})
-- settings.volume is now 8
```

### 13.2 `utils/ezvalidate.lua` — Validation Helpers

Validation functions return `true` when validation succeeds. On failure, they return `false` plus a reason string.

| Function | Parameters | Returns | Notes |
|---|---|---|---|
| `ezvalidate.is_type(value, expected_type)` | any value, type-name string | `boolean` | Compares Lua's `type(value)` with `expected_type`. |
| `ezvalidate.number_range(value, minimum?, maximum?)` | any value, optional numeric bounds | `boolean, string?` | Checks that the value is a number and falls within the supplied inclusive bounds. Either bound may be omitted. |
| `ezvalidate.required_fields(value, fields)` | table, array of field names | `boolean, string?` | Checks that the value is a table and every listed field is not `nil`. A field containing `false` counts as present. |
| `ezvalidate.table_field_types(value, expected)` | table, map of field names to type-name strings | `boolean, string?` | Checks that each named field has the requested Lua `type()`. |

Example:

```lua
local ezvalidate = require('scripts/ezlibs-scripts/utils/ezvalidate')

local ok, reason = ezvalidate.number_range(player_level, 1, 99)
if not ok then
    print("Invalid player level: " .. reason)
end

local valid = ezvalidate.required_fields(
    {name = "Lan", enabled = false},
    {"name", "enabled"}
) -- true
```

### 13.3 `utils/ezdebug.lua` — Logging Helpers

`ezdebug` provides a small logger wrapper. By default, logging is enabled, the prefix is `[ezlibs]`, and output is sent to `print`.

| Function/Field | Parameters | Returns | Notes |
|---|---|---|---|
| `ezdebug.configure(options)` | table | — | Updates any supplied `enabled`, `prefix`, or `sink` settings; validates their types. |
| `ezdebug.info(...)` | any number of values | — | Writes an `INFO` message when logging is enabled. |
| `ezdebug.warn(...)` | any number of values | — | Writes a `WARN` message when logging is enabled. |
| `ezdebug.error(...)` | any number of values | — | Writes an `ERROR` message when logging is enabled. |
| `ezdebug.traceback(message?, level?)` | optional message and stack level | `string` | Returns a traceback string using Lua's `debug.traceback`; it does not automatically log the result. |
| `enabled` | boolean | field | Defaults to `true`. |
| `prefix` | string | field | Defaults to `[ezlibs]`. |
| `sink` | function | field | Defaults to `print`; receives the fully formatted log line. |

Example:

```lua
local ezdebug = require('scripts/ezlibs-scripts/utils/ezdebug')

ezdebug.configure({
    prefix = "[my-system]",
    enabled = true
})

ezdebug.info("Loaded", "player", player_id)
ezdebug.warn("Unexpected state:", state)

local trace = ezdebug.traceback("Unexpected error")
ezdebug.error(trace)
```

A custom sink can redirect formatted log messages:

```lua
ezdebug.configure({
    sink = function(message)
        -- Replace this body with the project's chosen log destination.
        print(message)
    end
})
```

### 13.4 Practical Notes and Limitations

- `table_contains` and `table_remove_value` operate on array-style lists, because they use `ipairs` and numeric sequence operations.
- `table_count` counts all keys, not just the length of an array.
- `shallow_copy` does not recursively copy nested values. Use `deep_copy` when recursive copying is needed.
- `table_merge` is a shallow merge and mutates the target table.
- `required_fields` checks for `nil`; it does not reject `false`, empty strings, or other values.
- `table_field_types` checks Lua type names, not application-specific schemas or value ranges.
- `ezdebug.traceback` depends on the standard `debug` library being available in the runtime.
- The modules do not replace the host-specific `Net`, `Async`, or other ezlibs systems.

### 13.5 Tests

The utility additions include a Lua test file at `tests/test_utilities.lua`. From the library directory, run it with a Lua 5.2 interpreter:

```sh
lua tests/test_utilities.lua
```

The test file should be run in the target environment before relying on the additions. The tests were not executed as part of preparing this documentation.

