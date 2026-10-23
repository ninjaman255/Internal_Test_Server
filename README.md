# OpenNetBattle Server Lua API — Reference and Repository Cross-Check

> **Scope and accuracy**
>
> This document follows the formatting used by `scripts/_DOCUMENTATION/`. The server API definitions and parameter descriptions in the “Server-provided API” sections are transcribed and organized from the server API reference supplied for this task. Repository usage is cross-checked against Lua files in the supplied `internal_test_server.zip`. Calls that appear in the repository but are not present in the supplied server API reference are explicitly marked **repository-only / verify against runtime**; their presence in code is not proof that the server officially supports them.
>
> Lua baseline: Lua 5.2. `Net`, `Async`, `Net.EventEmitter`, and APIs injected by the server are runtime-provided, not Lua standard-library functions. This reference does not claim live runtime testing.

## 🗂️ Table of Contents

- [Part 1 — Runtime and Path Model](#part-1)
- [Part 2 — Event API](#part-2)
- [Part 3 — Area API](#part-3)
- [Part 4 — Object API](#part-4)
- [Part 5 — Bot API](#part-5)
- [Part 6 — Player API](#part-6)
- [Part 7 — Widget API](#part-7)
- [Part 8 — Player Data and Items](#part-8)
- [Part 9 — Asset API](#part-9)
- [Part 10 — Async API](#part-10)
- [Part 11 — Asyncified Net API](#part-11)
- [Part 12 — Event Emitters](#part-12)
- [Part 13 — Repository Cross-Check](#part-13)
- [Part 14 — Async and Await Conventions](#part-14)
- [Part 15 — Safe Usage Checklist](#part-15)
- [Part 16 — API Ownership: Server vs. Repository Scripts](#part-16)

<a id="part-1"></a>
## ⚙️ Part 1 — Runtime and Path Model

Scripts run in the OpenNetBattle server's Lua environment. Entry points are described by the server as `scripts/*/main.lua` for script projects and `scripts/*.lua` for single-file scripts. The global `Net` table exposes world, player, map, UI, and event operations; `Async` exposes promise and coroutine helpers.

### Asset paths versus system paths

- `/server/assets/...` refers to server-managed assets made available from the server's `./assets` tree.
- `/server/players/...` refers to player-uploaded avatar assets.
- `/server/maps/...` refers to generated area/map data.
- Paths used by `Async.read_file`, `Async.write_file`, `Async.download`, and other filesystem operations are **system paths**, not asset paths.
- Paths are case-sensitive outside Windows. Use `/` separators rather than Windows `\` separators.
- Client resource paths and `/server/...` asset paths are not interchangeable. Use the exact path convention expected by the API being called.

### Event callback shape

The project uses the one-argument event convention:

```lua
Net:on("player_join", function(event)
  local player_id = event.player_id
end)
```

The event name and fields vary by event. Check fields before use when the server can omit values. Do not substitute a guessed event schema for one documented below or verified in server source.

<a id="part-2"></a>
## 📡 Part 2 — Event API

Register callbacks with `Net:on(event_name, function(event) ... end)`. The supplied server reference lists these event names and payloads:

| Event | Documented payload / purpose |
|---|---|
| `tick` | `{ delta_time: number }`, elapsed seconds for the tick. |
| `authorization` | `{ identity, host, port, data }`, cross-server authentication request. Avoid sharing identity with other servers; use short-lived link data instead. |
| `player_request` | `{ player_id, data }`, connection/transfer request; server guidance says transfers and kicks only should occur here. |
| `player_connect` | `{ player_id }`, player connected; useful for setup while loading. |
| `player_join` | `{ player_id }`, player entered their first area after connecting. |
| `player_area_transfer` | `{ player_id }`, player changed area. |
| `player_disconnect` | `{ player_id }`; player is invalid after callback execution. |
| `player_move` | `{ player_id, x, y, z }`; `Net.get_player_position` still reports the old position during this callback. |
| `player_avatar_change` | `{ player_id, texture_path, animation_path, name, element, max_health, prevent_default }`; health/max-health/element are updated before callback. |
| `player_emote` | `{ player_id, emote, prevent_default }`. |
| `custom_warp` | `{ player_id, object_id }`, custom warp or custom server warp activation. |
| `object_interaction` | `{ player_id, object_id, button }`. |
| `actor_interaction` | `{ player_id, actor_id, button }`; actor can be a player or bot. |
| `tile_interaction` | `{ player_id, x, y, z, button }`. |
| `textbox_response` | `{ player_id, response }`, response can be a number or string. |
| `board_open` | Deprecated. |
| `board_close` | `{ player_id }`. |
| `post_request` | `{ player_id }`, board infinite-scroll request after posts are exhausted. |
| `post_selection` | `{ player_id, post_id }`. |
| `shop_close` | `{ player_id }`. |
| `shop_purchase` | `{ player_id, item_name }`. |
| `battle_results` | `{ player_id, health, score, time, ran, emotion, turns, enemies }`; enemy entries are `{ id, health }`. Validate optional/possibly absent fields before relying on them. |
| `server_message` | `{ host, port, data }`, message from another server. |
| `email_read` | `{ player_id, email_id }`. |

The supplied API excerpt uses `player_id` for `battle_results`; repository code has also been observed reading `event.player_id`, `event.health`, `event.time`, and `event.ran`. Treat fields such as score, emotion, turns, and enemies as optional unless confirmed by the runtime version.

<a id="part-3"></a>
## 🗺️ Part 3 — Area API

`area_id` is the filename without its extension. For example, `./assets/my_area.tmx` corresponds to `my_area`.

| Function | Purpose / return |
|---|---|
| `Net.list_areas()` | Returns area IDs. |
| `Net.create_area(new_area_id)` | Marked in the supplied reference as in development/commented. Do not assume availability. |
| `Net.update_area(area_id, map_string)` | Replace/update area map content. |
| `Net.clone_area(area_id, new_area_id)` | Clone an area. |
| `Net.remove_area(area_id)` | Remove an area. |
| `Net.map_to_string(area_id)` | Serialize area map. |
| `Net.get_width(area_id)` / `Net.get_height(area_id)` | Map dimensions. |
| `Net.get_layer_count(area_id)` | Layer count. |
| `Net.get_tile_width(area_id)` / `Net.get_tile_height(area_id)` | Tile dimensions. |
| `Net.get_area_custom_properties(area_id)` | Area custom-properties table. |
| `Net.get_area_custom_property(area_id, name)` | Read one custom property. |
| `Net.set_area_custom_property(area_id, name, value)` | Set one custom property. |
| `Net.get_area_name(area_id)` / `Net.set_area_name(area_id, name)` | Read/set display name. The supplied signature lists `set_area_name(area_id)` without a value; confirm the runtime signature before relying on it. |
| `Net.get_song(area_id)` / `Net.set_song(area_id, song_path)` | Read/set area music. |
| `Net.get_background(area_id)` | `{ texture_path, animation_path }`. |
| `Net.get_background_velocity(area_id)` | `{ x, y }`. |
| `Net.get_background_parallax(area_id)` | Parallax value. |
| `Net.set_background(area_id, texture_path, animation_path?, vel_x?, vel_y?, parallax?)` | Set background and optional movement/parallax. |
| `Net.get_foreground(area_id)` | `{ texture_path, animation_path }`. |
| `Net.get_foreground_velocity(area_id)` | `{ x, y }`. |
| `Net.get_foreground_parallax(area_id)` | Parallax value. |
| `Net.set_foreground(area_id, texture_path, animation_path?, vel_x?, vel_y?, parallax?)` | Set foreground and optional movement/parallax. |
| `Net.get_spawn_position(area_id)` / `Net.set_spawn_position(area_id, x, y, z)` | Read/set spawn coordinates. |
| `Net.get_spawn_direction(area_id)` / `Net.set_spawn_direction(area_id, direction)` | Read/set spawn direction. |
| `Net.list_tilesets(area_id)` | Tileset paths. |
| `Net.get_tileset(area_id, tileset_path)` | `{ path, first_gid }` or nil. |
| `Net.get_tileset_for_tile(area_id, tile_gid)` | Tileset containing a tile GID, or nil. |
| `Net.get_tile(area_id, x, y, z)` | Tile data including GID and flip/rotation flags. |
| `Net.set_tile(area_id, x, y, z, tile_gid, flip_h?, flip_v?, rotate?)` | Change a tile. |
| `Net.provide_asset(area_id, path, hint)` | Provide an asset to an area; hint contains `asset_type` and `package_type`. |
| `Net.play_sound(area_id, path)` | Play sound in an area. |

<a id="part-4"></a>
## 🧱 Part 4 — Object API

| Function | Purpose / return |
|---|---|
| `Net.list_objects(area_id)` | Object IDs in an area. |
| `Net.get_object_by_id(area_id, object_id)` | Object record or nil. Documented fields include `id`, `name`, `class`, `type`, `visible`, position, size, rotation, data, and custom properties. |
| `Net.get_object_by_name(area_id, name)` | Object record or nil. |
| `Net.create_object(area_id, definition)` | Create object and return object ID. Optional fields include name/type/visibility/position/size/rotation/data/custom properties. |
| `Net.remove_object(area_id, object_id)` | Remove object. |
| `Net.set_object_name(area_id, object_id, name)` | Rename object. |
| `Net.set_object_class(area_id, object_id, class)` | Set object class. |
| `Net.set_object_type(area_id, object_id, type)` | Deprecated. |
| `Net.set_object_custom_property(area_id, object_id, name, value)` | Set custom property. |
| `Net.resize_object(area_id, object_id, width, height)` | Resize object. |
| `Net.set_object_rotation(area_id, object_id, rotation)` | Set rotation. |
| `Net.set_object_visibility(area_id, object_id, visibility)` | Set visibility. |
| `Net.move_object(area_id, object_id, x, y, layer)` | Move object. |
| `Net.set_object_data(area_id, object_id, data)` | Set object geometry/data. |

Supported `data` forms described in the supplied reference:

```lua
{ type = "point" | "rect" | "ellipse" }
{ type = "polygon" | "polyline", points = { { x = 0, y = 0 } } }
{ type = "tile", gid = 1, flipped_horizontally = false,
  flipped_vertically = false, rotated = false }
```

<a id="part-5"></a>
## 🤖 Part 5 — Bot API

| Function | Purpose / return |
|---|---|
| `Net.list_bots(area_id)` | Bot IDs in an area. |
| `Net.create_bot(bot_id, definition)` | Create bot with explicit ID. |
| `Net.create_bot(definition)` | Create bot with generated ID. |
| `Net.is_bot(bot_id)` | Whether ID identifies a bot. |
| `Net.remove_bot(bot_id, warp_out?)` | Remove bot, optionally warping out. |
| `Net.get_bot_area(bot_id)` | Current area ID. |
| `Net.get_bot_name(bot_id)` / `Net.set_bot_name(bot_id, name)` | Read/set name. |
| `Net.get_bot_direction(bot_id)` / `Net.set_bot_direction(bot_id, direction)` | Read/set direction. |
| `Net.animate_bot_properties(bot_id, keyframes)` | Animate bot properties; marked unstable. |
| `Net.get_bot_position(bot_id)` | `{ x, y, z }`. |
| `Net.move_bot(bot_id, x, y, z)` | Move bot. |
| `Net.set_bot_avatar(bot_id, texture_path, animation_path)` | Set texture and animation. |
| `Net.set_bot_emote(bot_id, emote_id, use_custom_emotes?)` | Set bot emote. |
| `Net.set_bot_minimap_color(bot_id, color)` | Color `{ r, g, b, a? }`, channels 0–255. |
| `Net.animate_bot(bot_id, state_name, loop?)` | Play animation state. |
| `Net.transfer_bot(bot_id, area_id, warp_in?, x?, y?, z?)` | Transfer bot to another area. |

`Net.create_bot` definitions can include name, area, warp-in behavior, texture/animation paths, animation, coordinates, direction, and solidity. Keyframes contain a `properties` array and `duration`; each property specifies a name/value and may specify easing. Supported property names in the supplied reference include `Animation`, `Animation Speed`, `X`, `Y`, `Z`, `ScaleX`, `ScaleY`, `Rotation`, `Direction`, `Sound Effect`, and `Sound Effect Loop`.

<a id="part-6"></a>
## 🧑 Part 6 — Player API

### Identity, location, avatar, and animation

| Function | Purpose / return |
|---|---|
| `Net.list_players(area_id)` | Player IDs in area. |
| `Net.is_player(player_id)` | Check whether player ID is valid. |
| `Net.get_player_area(player_id)` | Current area ID. |
| `Net.get_player_ip(player_id)` | Address; handle as sensitive data. |
| `Net.get_player_name(player_id)` / `Net.set_player_name(player_id, name)` | Read/set name. |
| `Net.get_player_direction(player_id)` | Facing direction. |
| `Net.get_player_position(player_id)` | `{ x, y, z }`. |
| `Net.get_player_mugshot(player_id)` | `{ texture_path, animation_path }`. |
| `Net.get_player_avatar(player_id)` / `Net.set_player_avatar(player_id, texture_path, animation_path)` | Read/set avatar. |
| `Net.set_player_emote(player_id, emote_id, use_custom_emotes?)` | Set emote. |
| `Net.exclusive_player_emote(player_id, emoter_id, emote_id, use_custom_emotes?)` | Play an emote with a specified emoter. |
| `Net.set_player_minimap_color(player_id, color)` | Set minimap color `{ r, g, b, a? }`, channels 0–255. |
| `Net.animate_player(player_id, state_name, loop?)` | Play animation state. |
| `Net.animate_player_properties(player_id, keyframes)` | Animate properties; marked unstable. |

### State, assets, sound, camera, and visibility

| Function | Purpose / return |
|---|---|
| `Net.is_player_battling(player_id)` | Whether player is in battle. |
| `Net.is_player_busy(player_id)` | Whether player is busy. |
| `Net.provide_asset_for_player(player_id, path, hint)` | Provide asset; hint has `asset_type` and `package_type`. |
| `Net.play_sound_for_player(player_id, path)` | Play sound for one player. |
| `Net.set_song_for_player(player_id, song_path)` / `Net.stop_song_for_player(player_id)` | Control player music. |
| `Net.exclude_object_for_player(player_id, object_id)` / `Net.include_object_for_player(player_id, object_id)` | Hide/show an object for one player. |
| `Net.exclude_actor_for_player(player_id, actor_id)` / `Net.include_actor_for_player(player_id, actor_id)` | Hide/show an actor for one player. |
| `Net.move_player_camera(player_id, x, y, z, holdTimeInSeconds?)` | Move camera. |
| `Net.fade_player_camera(player_id, color, durationInSeconds)` | Fade camera using `{ r, g, b, a? }`, channels 0–255. |
| `Net.slide_player_camera(player_id, x, y, z, durationInSeconds)` | Slide camera. |
| `Net.shake_player_camera(player_id, strength, durationInSeconds)` | Shake camera. |
| `Net.track_with_player_camera(player_id, actor_id?)` | Track an actor; omitted actor may stop/change tracking depending on runtime. |
| `Net.is_player_input_locked(player_id)` | Check input lock state. |
| `Net.unlock_player_camera(player_id)` | Unlock camera. |
| `Net.lock_player_input(player_id)` / `Net.unlock_player_input(player_id)` | Lock/unlock player input. Keep ownership/handoff consistent across scripts. |
| `Net.teleport_player(player_id, warp, x, y, z, direction?)` | Teleport via warp/coordinates. |
| `Net.offer_package(player_id, package_path)` | Offer package to player. |
| `Net.set_mod_whitelist_for_player(player_id, whitelist_path)` | Set whitelist file path; expected lines are `[md5] [package_id]`. |
| `Net.initiate_encounter(player_id, package_path, data?)` | Start encounter; data is passed to encounter package's `package_build`. |
| `Net.initiate_pvp(player_1_id, player_2_id, field_script_path?)` | Start PvP. |
| `Net.transfer_player(player_id, area_id, warp_in?, x?, y?, z?, direction?)` | Transfer player to area. |
| `Net.transfer_server(player_id, address, port, warp_out?, data?)` | Transfer to another server; data is a string. |
| `Net.request_authorization(player_id, address, port, data?)` | Request authorization from another server. |
| `Net.kick_player(player_id, reason, warp_out?)` | Kick player. |

<a id="part-7"></a>
## 💬 Part 7 — Widget API

| Function | Purpose / return |
|---|---|
| `Net.is_player_in_widget(player_id)` | Whether a widget is open. |
| `Net.is_player_shopping(player_id)` | Whether shop UI is active. |
| `Net.message_player(player_id, message, mug_texture_path?, mug_animation_path?)` | Open message widget. |
| `Net.question_player(player_id, question, mug_texture_path?, mug_animation_path?)` | Open question widget. |
| `Net.quiz_player(player_id, option_a?, option_b?, option_c?, mug_texture_path?, mug_animation_path?)` | Open quiz widget. |
| `Net.prompt_player(player_id, character_limit?, default_text?)` | Open text prompt. |
| `Net.open_board(player_id, board_name, color, posts)` | Open board; color `{ r, g, b }`; posts are `{ id, read?, title?, author? }[]`; returns emitter for `post_selection`, `post_request`, and `board_close`. |
| `Net.prepend_posts(player_id, posts, post_id?)` / `Net.append_posts(player_id, posts, post_id?)` | Add board posts; marked unstable when multiple scripts create boards concurrently. |
| `Net.remove_post(player_id, post_id)` | Remove board post; marked unstable. |
| `Net.close_bbs(player_id)` | Close board UI. |
| `Net.open_shop(player_id, items, mug_texture_path?, mug_animation_path?)` | Open shop; item shape `{ name, description, price }[]`; returns emitter for `shop_purchase` and `shop_close`. |

<a id="part-8"></a>
## 💾 Part 8 — Player Data and Items

| Function | Purpose / return |
|---|---|
| `Net.get_player_secret(player_id)` | Secret identifier similar to a password. Do not share or log it. |
| `Net.get_player_element(player_id)` | Element string. |
| `Net.get_player_health(player_id)` / `Net.set_player_health(player_id, health)` | Read/set health. |
| `Net.get_player_max_health(player_id)` / `Net.set_player_max_health(player_id, health)` | Read/set maximum health. |
| `Net.get_player_emotion(player_id)` / `Net.set_player_emotion(player_id, emotion)` | Read/set emotion. |
| `Net.get_player_money(player_id)` / `Net.set_player_money(player_id, money)` | Read/set money. |
| `Net.get_player_items(player_id)` | Item ID strings. |
| `Net.give_player_item(player_id, item_id)` / `Net.remove_player_item(player_id, item_id)` | Add/remove item. |
| `Net.player_has_item(player_id, item_id)` | Check possession. |
| `Net.create_item(item_id, { name, description })` | Define/create item. |
| `Net.get_item_name(item_id)` / `Net.get_item_description(item_id)` | Read item metadata. |

<a id="part-9"></a>
## 📦 Part 9 — Asset API

| Function | Purpose / return |
|---|---|
| `Net.update_asset(server_path, content)` | Create/update server asset content. |
| `Net.remove_asset(server_path)` | Remove server asset. |
| `Net.has_asset(server_path)` | Check whether asset exists. |
| `Net.get_asset_type(server_path)` | Asset type. |
| `Net.get_asset_size(server_path)` | Asset size. |
| `Net.read_asset(server_path)` | Text content for text assets or base64 string for binary assets. |

<a id="part-10"></a>
## ⏱️ Part 10 — Async API

The supplied server documentation recommends `Async` for I/O while players are connected to avoid blocking server processing. These functions generally return promises; use `Async.await` from a coroutine where a resolved value is required.

| Function | Purpose / result |
|---|---|
| `Async.await(async_iterator)` | Await iterator item. |
| `Async.await(promise)` | Await promise result in coroutine context. |
| `Async.await_all(promises)` | Await all promises and return results array. |
| `Async.promisify(coroutine)` | Convert coroutine to promise. |
| `Async.create_promise(function(resolve) ... end)` | Create promise; resolve callback supplied by runtime. |
| `Async.request(url, options?)` | HTTP request; result may include `{ status, headers, body }`. |
| `Async.download(path, url, options?)` | Download to system path; resolves boolean. |
| `Async.read_file(path)` | Read system file; resolves string. |
| `Async.write_file(path, content)` | Write system file; resolves boolean. |
| `Async.poll_server(address, port)` | Poll server; may return `{ max_message_size }`. |
| `Async.message_server(address, port, data)` | Send server message; sender cannot know success unless other server replies. |
| `Async.sleep(duration)` | Wait duration; resolves nil. |

`options` for request/download may include `method`, `headers`, and `body`. These paths are system paths, not `/server/assets/...` paths.

<a id="part-11"></a>
## 🔁 Part 11 — Asyncified Net API

Asyncified functions return promises and may resolve to `nil` if the player disconnects before completion, according to the supplied reference.

| Function | Promise result |
|---|---|
| `Async.message_player(player_id, message, mug_texture_path?, mug_animation_path?)` | Numeric response or nil. |
| `Async.question_player(player_id, question, mug_texture_path?, mug_animation_path?)` | Numeric response or nil. |
| `Async.quiz_player(player_id, option_a?, option_b?, option_c?, mug_texture_path?, mug_animation_path?)` | Numeric response or nil. |
| `Async.prompt_player(player_id, character_limit?, default_text?)` | String response or nil. |
| `Async.initiate_encounter(player_id, package_path, data?)` | Battle result table or nil. |
| `Async.initiate_pvp(player_1_id, player_2_id, field_script_path?)` | Battle result table or nil. |

The battle result table in the supplied reference contains `player_id`, `health`, `score`, `time`, `ran`, `emotion`, `turns`, and `enemies` (`{ id, health }[]`). Validate values before using them.

<a id="part-12"></a>
## 📣 Part 12 — Event Emitters

```lua
local emitter = Net.EventEmitter.new()
emitter:emit(event_name, ...)
emitter:on(event_name, function(...) end)
emitter:once(event_name, function(...) end)
emitter:on_any(function(event_name, ...) end)
emitter:on_any_once(function(event_name, ...) end)
emitter:remove_listener(event_name, callback)
emitter:remove_on_any_listener(callback)
emitter:async_iter(event_name)       -- iterator yielding promises
emitter:async_iter_all(event_name)   -- yields event name and arguments
emitter:destroy()                    -- allows async iterators to complete
```

The server reference describes event emitters as a way to subscribe to widget events and custom events. Destroy emitters when their owning flow ends, and avoid leaving listeners attached to completed UI sessions.

<a id="part-13"></a>
## 🔎 Part 13 — Repository Cross-Check

The archive contains **197 Lua files under `scripts/`**. The inventory below is based on static text scanning of those files, so it identifies referenced symbols and likely integration areas; it cannot prove the exact runtime signature or whether a call succeeds at runtime.

### Core documented calls used by repository code

| API family | Examples of repository usage | Notes |
|---|---|---|
| Lifecycle/events | `Net:on`, `player_join`, `player_disconnect`, `player_area_transfer`, `actor_interaction`, `object_interaction`, `tick`, `battle_results` | Most scripts register callbacks at module startup. Event schemas should match the event reference above; disconnect callbacks must not continue using invalid player IDs. |
| Area/map | `list_areas`, `clone_area`, `remove_area`, `list_objects`, `get_object_by_id`, `get_object_by_name`, `get_area_custom_property`, `get_tile`, `get_tileset` | Used by map utilities, instances, NPC placement, and area-specific features. |
| Bots | `create_bot`, `remove_bot`, `is_bot`, `get_bot_position`, `move_bot`, `set_bot_direction`, `animate_bot`, `animate_bot_properties`, `transfer_bot` | Used by NPCs, minigames, battle/game staging, and presentation. |
| Players | `is_player`, `get_player_area`, `get_player_position`, `get_player_name`, `get_player_mugshot`, `get_player_secret`, `transfer_player`, `lock_player_input`, `unlock_player_input` | Used throughout lifecycle, UI, instances, and games. Treat secrets/IP as sensitive. |
| Widgets | `message_player`, `question_player`, `quiz_player`, `prompt_player`, `open_board`, `close_bbs`, `open_shop` | Async flows should use the documented `Async.*` versions when awaiting user response. |
| Camera/audio | `move_player_camera`, `fade_player_camera`, `slide_player_camera`, `shake_player_camera`, `track_with_player_camera`, `unlock_player_camera`, `play_sound`, `play_sound_for_player`, `set_song_for_player`, `stop_song_for_player` | Used for scenes, selectors, transitions, and UI/game feedback. |
| Assets/sprites | `has_asset`, `provide_asset`, `provide_asset_for_player`, `read_asset`, `update_asset`, `remove_asset`, `player_alloc_sprite`, `player_draw_sprite`, `player_erase_sprite`, `player_dealloc_sprite` | `player_*_sprite` and `provide_asset_for_player` are documented in root `API_CHANGES.md`; `read_asset`, `update_asset`, and `remove_asset` still require checking against the supplied server reference/runtime. |
| Async | `Async.await`, `Async.promisify`, `Async.create_promise`, `Async.sleep`, `Async.read_file`, `Async.write_file`, `Async.message_player`, `Async.question_player`, `Async.quiz_player`, `Async.prompt_player`, `Async.initiate_encounter`, `Async.initiate_pvp` | Distinguish uppercase `Async` runtime APIs from lowercase `async` helpers defined locally or by `promise_api.lua`. |

### Net symbols observed in scripts

| Symbol | Lua files referencing it | Status against supplied API excerpt |
|---|---|---|
| `Net.EventEmitter` | 2 | Documented in supplied server reference — `scripts/ezlibs-scripts/eztriggers.lua`, `scripts/utils/utility.lua` |
| `Net.animate_bot` | 8 | Documented in supplied server reference — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua`, and 6 more |
| `Net.animate_bot_properties` | 8 | Documented in supplied server reference — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, and 6 more |
| `Net.animate_player` | 4 | Documented in supplied server reference — `scripts/example_pvp_script.lua`, `scripts/ezlibs-scripts/ezmemory.lua`, and 2 more |
| `Net.animate_player_properties` | 8 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezpress.lua`, `scripts/ezlibs-scripts/ezwarps/arrow_animation_factory.lua`, and 6 more |
| `Net.append_posts` | 1 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezbbs.lua` |
| `Net.clone_area` | 2 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, `scripts/ezlibs-scripts/ezmapinstance.lua` |
| `Net.close_bbs` | 3 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-scripts/ezfarms.lua`, and 1 more |
| `Net.create_bot` | 35 | Documented in supplied server reference — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, and 33 more |
| `Net.create_item` | 2 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezmemory.lua`, `scripts/ezlibs-scripts/ezrushroads.lua` |
| `Net.create_object` | 4 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, and 2 more |
| `Net.create_timer` | 1 | **Not listed in supplied API excerpt; verify runtime/source** — `scripts/net-games/helpers/net-helpers.lua` |
| `Net.emit` | 1 | Documented in supplied server reference — `scripts/displayer/timer-system.lua` |
| `Net.exclude_actor_for_player` | 5 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezmemory.lua`, `scripts/ezlibs-scripts/eznpcs/eznpcs.lua`, and 3 more |
| `Net.exclude_object_for_player` | 4 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, `scripts/ezlibs-scripts/ezbuttons.lua`, and 2 more |
| `Net.exclusive_player_emote` | 2 | Documented in supplied server reference — `scripts/example_pvp_script.lua`, `scripts/ezlibs-custom/nebulous-liberations/utils/parties.lua` |
| `Net.fade_player_camera` | 6 | Documented in supplied server reference — `scripts/camera/camera-controller.lua`, `scripts/ezlibs-custom/footbomb/main.lua`, and 4 more |
| `Net.get_area_custom_properties` | 3 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, `scripts/ezlibs-custom/nebulous-liberations/main.lua`, and 1 more |
| `Net.get_area_custom_property` | 7 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua`, and 5 more |
| `Net.get_area_name` | 6 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua`, and 4 more |
| `Net.get_bot_area` | 7 | Documented in supplied server reference — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua`, and 5 more |
| `Net.get_bot_by_id` | 1 | **Not listed in supplied API excerpt; verify runtime/source** — `scripts/events/eznpcs_onceitem.lua` |
| `Net.get_bot_direction` | 5 | Documented in supplied server reference — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, and 3 more |
| `Net.get_bot_name` | 8 | Documented in supplied server reference — `scripts/net-games/npcs/prog_basic_nameplate.lua`, `scripts/net-games/npcs/prog_prompt_dialogue.lua`, and 6 more |
| `Net.get_bot_position` | 6 | Documented in supplied server reference — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`, and 4 more |
| `Net.get_height` | 2 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua` |
| `Net.get_layer_count` | 1 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua` |
| `Net.get_object_by_id` | 20 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/footbomb/main.lua`, and 18 more |
| `Net.get_object_by_name` | 18 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, `scripts/ezlibs-custom/nebulous-liberations/main.lua`, and 16 more |
| `Net.get_player_area` | 34 | Documented in supplied server reference — `scripts/camera/main.lua`, `scripts/events/eznpcs_onceitem.lua`, and 32 more |
| `Net.get_player_avatar` | 2 | Documented in supplied server reference — `scripts/avatar_utils/avatar_utils.lua`, `scripts/ezlibs-scripts/avatar_utils/avatar_utils.lua` |
| `Net.get_player_direction` | 2 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-scripts/ezmystery.lua` |
| `Net.get_player_fragments` | 1 | Server-provided in root `API_CHANGES.md` — `scripts/ezlibs-scripts/ezmemory.lua` |
| `Net.get_player_health` | 2 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezmemory.lua`, `scripts/net-game-tourney/tournament-flow.lua` |
| `Net.get_player_max_health` | 3 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, `scripts/ezlibs-scripts/ezmemory.lua`, and 1 more |
| `Net.get_player_money` | 5 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/player_session.lua`, and 3 more |
| `Net.get_player_mugshot` | 10 | Documented in supplied server reference — `scripts/avatar_utils/avatar_utils.lua`, `scripts/example_pvp_script.lua`, and 8 more |
| `Net.get_player_name` | 6 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/nebulous-liberations/main.lua`, and 4 more |
| `Net.get_player_position` | 35 | Documented in supplied server reference — `scripts/camera/camera-controller.lua`, `scripts/events/eznpcs_onceitem.lua`, and 33 more |
| `Net.get_player_secret` | 6 | Documented in supplied server reference — `scripts/avatar_utils/main.lua`, `scripts/ezlibs-scripts/avatar_utils/main.lua`, and 4 more |
| `Net.get_song` | 1 | Documented in supplied server reference — `scripts/net-game-tourney/tournament-ui.lua` |
| `Net.get_spawn_position` | 2 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/main.lua`, `scripts/ezlibs-custom/nebulous-liberations/player.lua` |
| `Net.get_tile` | 3 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua`, `scripts/ezlibs-scripts/ezencounters/main.lua`, and 1 more |
| `Net.get_tileset` | 4 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_selection.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, and 2 more |
| `Net.get_tileset_for_tile` | 2 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-scripts/ezencounters/main.lua` |
| `Net.get_width` | 2 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua` |
| `Net.give_player_item` | 2 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezmemory.lua`, `scripts/ezlibs-scripts/ezrushroads.lua` |
| `Net.has_asset` | 8 | Documented in supplied server reference — `scripts/avatar_utils/avatar_utils.lua`, `scripts/displayer/text-display.lua`, and 6 more |
| `Net.include_actor_for_player` | 3 | Documented in supplied server reference — `scripts/ezlibs-scripts/eznpcs/eznpcs.lua`, `scripts/ezlibs-scripts/ezrushroads.lua`, and 1 more |
| `Net.include_object_for_player` | 4 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, `scripts/ezlibs-scripts/ezcheckpoints.lua`, and 2 more |
| `Net.initiate_encounter` | 2 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/player.lua`, `scripts/libs/encounters.lua` |
| `Net.initiate_pvp` | 1 | Documented in supplied server reference — `scripts/example_pvp_script.lua` |
| `Net.is_bot` | 8 | Documented in supplied server reference — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy.lua`, and 6 more |
| `Net.is_player` | 9 | Documented in supplied server reference — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`, and 7 more |
| `Net.is_player_battling` | 4 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezencounters/main.lua`, `scripts/ezlibs-scripts/eznpcs/dialogue_types.lua`, and 2 more |
| `Net.is_player_busy` | 1 | Documented in supplied server reference — `scripts/libs/encounters.lua` |
| `Net.is_player_in_widget` | 1 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua` |
| `Net.is_player_input_locked` | 1 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy.lua` |
| `Net.kick_player` | 2 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezmemory.lua`, `scripts/ezlibs-scripts/eznpcs/dialogue_types.lua` |
| `Net.list_areas` | 16 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/panel_encounters.lua`, and 14 more |
| `Net.list_bots` | 2 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua` |
| `Net.list_objects` | 15 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/footbomb/main.lua`, and 13 more |
| `Net.list_players` | 6 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezbbs.lua`, `scripts/ezlibs-scripts/ezbuttons.lua`, and 4 more |
| `Net.list_tilesets` | 1 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua` |
| `Net.lock_player_input` | 20 | Documented in supplied server reference — `scripts/camera/camera-controller.lua`, `scripts/events/eznpcs_onceitem.lua`, and 18 more |
| `Net.lua` | 1 | **Not listed in supplied API excerpt; verify runtime/source** — `scripts/utils/utility.lua` |
| `Net.map_to_string` | 1 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua` |
| `Net.message_player` | 12 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/nebulous-liberations/player.lua`, and 10 more |
| `Net.move_bot` | 4 | Documented in supplied server reference — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/ezlibs-scripts/eznpcs/eznpcs.lua`, and 2 more |
| `Net.move_object` | 1 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua` |
| `Net.move_player` | 2 | **Not listed in supplied API excerpt; verify runtime/source** — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/net-games/main.lua` |
| `Net.move_player_camera` | 8 | Documented in supplied server reference — `scripts/camera/camera-controller.lua`, `scripts/events/eznpcs_onceitem.lua`, and 6 more |
| `Net.on` | 1 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezlogger.lua` |
| `Net.open_board` | 3 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezbbs.lua`, `scripts/ezlibs-scripts/ezfarms.lua`, and 1 more |
| `Net.open_shop` | 1 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezmemory.lua` |
| `Net.play_sound` | 16 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`, `scripts/ezlibs-custom/nebulous-liberations/utils/paralyze_effect.lua`, and 14 more |
| `Net.play_sound_for_player` | 21 | Documented in supplied server reference — `scripts/animation-engine/animation-sequences.lua`, `scripts/displayer/text-display.lua`, and 19 more |
| `Net.player_alloc_sprite` | 13 | Server-provided in root `API_CHANGES.md` — `scripts/displayer/font-system.lua`, `scripts/displayer/nameplate.lua`, and 11 more |
| `Net.player_dealloc_sprite` | 7 | Server-provided in root `API_CHANGES.md` — `scripts/displayer/font-system.lua`, `scripts/displayer/nameplate.lua`, and 5 more |
| `Net.player_draw_sprite` | 13 | Server-provided in root `API_CHANGES.md` — `scripts/displayer/font-system.lua`, `scripts/displayer/nameplate.lua`, and 11 more |
| `Net.player_erase_sprite` | 13 | Server-provided in root `API_CHANGES.md` — `scripts/displayer/font-system.lua`, `scripts/displayer/nameplate.lua`, and 11 more |
| `Net.prepend_posts` | 1 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezbbs.lua` |
| `Net.prompt_player` | 1 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezbbs.lua` |
| `Net.provide_asset` | 6 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/preloader.lua`, `scripts/ezlibs-scripts/ezbuttons.lua`, and 4 more |
| `Net.provide_asset_for_player` | 27 | Documented in supplied server reference — `scripts/displayer/font-system.lua`, `scripts/displayer/nameplate.lua`, and 25 more |
| `Net.question_player` | 3 | Documented in supplied server reference — `scripts/example_pvp_script.lua`, `scripts/ezlibs-custom/nebulous-liberations/player.lua`, and 1 more |
| `Net.quiz_player` | 1 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/player.lua` |
| `Net.read_asset` | 2 | Documented in supplied server reference — `scripts/avatar_utils/avatar_utils.lua`, `scripts/ezlibs-scripts/avatar_utils/avatar_utils.lua` |
| `Net.remove_area` | 2 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, `scripts/ezlibs-scripts/ezmapinstance.lua` |
| `Net.remove_asset` | 2 | Documented in supplied server reference — `scripts/avatar_utils/avatar_utils.lua`, `scripts/ezlibs-scripts/avatar_utils/avatar_utils.lua` |
| `Net.remove_bot` | 20 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/footbomb/main.lua`, and 18 more |
| `Net.remove_object` | 6 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, and 4 more |
| `Net.remove_player_item` | 2 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezmemory.lua`, `scripts/ezlibs-scripts/ezrushroads.lua` |
| `Net.remove_post` | 2 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezbbs.lua`, `scripts/ezlibs-scripts/ezfarms.lua` |
| `Net.ring_player_hud` | 2 | Server-provided in root `API_CHANGES.md` — `scripts/ezlibs-scripts/ezemail.lua`, `scripts/ezlibs-scripts/ezmail.lua` |
| `Net.send_player_email` | 2 | Server-provided in root `API_CHANGES.md` — `scripts/ezlibs-scripts/ezemail.lua`, `scripts/ezlibs-scripts/ezmail.lua` |
| `Net.set_area_custom_property` | 1 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezweather.lua` |
| `Net.set_area_name` | 1 | Documented in supplied server reference — `scripts/net-game-tourney/tournament-ui.lua` |
| `Net.set_background` | 1 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua` |
| `Net.set_bot_avatar` | 2 | Documented in supplied server reference — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/test-runner/tests/demo.lua` |
| `Net.set_bot_direction` | 17 | Documented in supplied server reference — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua`, and 15 more |
| `Net.set_bot_minimap_color` | 4 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, and 2 more |
| `Net.set_bot_name` | 2 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua` |
| `Net.set_object_data` | 2 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, `scripts/ezlibs-scripts/ezfarms.lua` |
| `Net.set_player_animation` | 1 | **Not listed in supplied API excerpt; verify runtime/source** — `scripts/net-games/main.lua` |
| `Net.set_player_emote` | 2 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/player_session.lua` |
| `Net.set_player_emotion` | 1 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/player_session.lua` |
| `Net.set_player_fragments` | 1 | **Not listed in supplied API excerpt; verify runtime/source** — `scripts/ezlibs-scripts/ezmemory.lua` |
| `Net.set_player_health` | 3 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, `scripts/ezlibs-scripts/ezmemory.lua`, and 1 more |
| `Net.set_player_max_health` | 2 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezmemory.lua`, `scripts/net-game-tourney/tournament-flow.lua` |
| `Net.set_player_money` | 3 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/player_session.lua`, `scripts/ezlibs-scripts/ezmemory.lua`, and 1 more |
| `Net.set_player_position` | 1 | **Not listed in supplied API excerpt; verify runtime/source** — `scripts/net-games/main.lua` |
| `Net.set_song` | 4 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/instance.lua`, and 2 more |
| `Net.set_tile` | 1 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezfarms.lua` |
| `Net.shake_player_camera` | 8 | Documented in supplied server reference — `scripts/camera/camera-controller.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, and 6 more |
| `Net.slide_player_camera` | 7 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/camera_sequence.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy.lua`, and 5 more |
| `Net.toggle_player_hud` | 4 | Server-provided in root `API_CHANGES.md` — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/net-game-tourney/tournament-flow.lua`, and 2 more |
| `Net.track_with_player_camera` | 3 | Documented in supplied server reference — `scripts/camera/camera-controller.lua`, `scripts/events/eznpcs_onceitem.lua`, and 1 more |
| `Net.transfer_bot` | 4 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy_helpers.lua`, `scripts/ezlibs-custom/nebulous-liberations/utils/exploding_effect.lua`, and 2 more |
| `Net.transfer_player` | 6 | Documented in supplied server reference — `scripts/ezlibs-custom/footbomb/main.lua`, `scripts/ezlibs-custom/nebulous-liberations/main.lua`, and 4 more |
| `Net.transfer_server` | 1 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezwarps/main.lua` |
| `Net.unlock_player_camera` | 9 | Documented in supplied server reference — `scripts/camera/camera-controller.lua`, `scripts/events/eznpcs_onceitem.lua`, and 7 more |
| `Net.unlock_player_input` | 22 | Documented in supplied server reference — `scripts/camera/camera-controller.lua`, `scripts/events/eznpcs_onceitem.lua`, and 20 more |
| `Net.update_asset` | 2 | Documented in supplied server reference — `scripts/avatar_utils/avatar_utils.lua`, `scripts/ezlibs-scripts/avatar_utils/avatar_utils.lua` |

### Async symbols observed in scripts

| Symbol | Lua files referencing it | Status / interpretation |
|---|---:|---|
| `Async.await` | 23 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, and 21 more |
| `Async.create_promise` | 11 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemy.lua`, and 9 more |
| `Async.create_validator` | 1 | **Not listed in supplied Async reference; inspect its defining module before use** — `scripts/utils/async.lua` |
| `Async.initiate_encounter` | 2 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezencounters/main.lua`, `scripts/net-game-tourney/tournament-flow.lua` |
| `Async.initiate_pvp` | 2 | Documented in supplied server reference — `scripts/net-game-tourney/tournament-flow.lua`, `scripts/net-game-tourney/tournament-manager.lua` |
| `Async.lua` | 1 | **Not listed in supplied Async reference; inspect its defining module before use** — `scripts/utils/async.lua` |
| `Async.message_player` | 10 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/footbomb/main.lua`, and 8 more |
| `Async.promisify` | 22 | Documented in supplied server reference — `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/bigbrute.lua`, `scripts/ezlibs-custom/nebulous-liberations/liberations/enemies/blizzardman.lua`, and 20 more |
| `Async.prompt_player` | 5 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-scripts/ezcheckpoints.lua`, and 3 more |
| `Async.question_player` | 8 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-scripts/ezcheckpoints.lua`, and 6 more |
| `Async.quiz_player` | 6 | Documented in supplied server reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-custom/footbomb/main.lua`, and 4 more |
| `Async.read_file` | 3 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezbbs.lua`, `scripts/ezlibs-scripts/ezmemory.lua`, and 1 more |
| `Async.run` | 2 | **Not listed in supplied Async reference; inspect its defining module before use** — `scripts/utils/async.lua`, `scripts/utils/utility.lua` |
| `Async.sleep` | 39 | Documented in supplied server reference — `scripts/displayer/font-system.lua`, `scripts/events/eznpcs_onceitem.lua`, and 37 more |
| `Async.write_file` | 3 | Documented in supplied server reference — `scripts/ezlibs-scripts/ezbbs.lua`, `scripts/ezlibs-scripts/ezmemory.lua`, and 1 more |

### Event names observed in scripts

The repository also subscribes to custom or module-level event names. The list below is an inventory of string literals passed to `Net:on`; not every name is guaranteed to be a built-in server event.

| Event string | Lua files referencing it | Classification |
|---|---|---|
| `actor_interaction` | 18 | Listed in supplied server event reference — `scripts/example_pvp_script.lua`, `scripts/ezlibs-scripts/main.lua`, and 16 more |
| `avatar_change` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/ezlibs-scripts/ezmystery.lua` |
| `battle_results` | 5 | Listed in supplied server event reference — `scripts/ezlibs-scripts/ezencounters/main.lua`, `scripts/ezlibs-scripts/eznpcs/dialogue_types.lua`, and 3 more |
| `board_close` | 1 | Listed in supplied server event reference — `scripts/ezlibs-scripts/main.lua` |
| `countdown_ended` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/simon-says.lua` |
| `countdown_global_create` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/displayer/timer-display.lua` |
| `countdown_global_remove` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/displayer/timer-display.lua` |
| `countdown_global_update` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/displayer/timer-display.lua` |
| `countdown_remove` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/displayer/timer-display.lua` |
| `countdown_update` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/displayer/timer-display.lua` |
| `cursor_move` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/net-games/main.lua` |
| `cursor_selection` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/test-runner/tests/demo.lua` |
| `custom_warp` | 1 | Listed in supplied server event reference — `scripts/ezlibs-scripts/main.lua` |
| `email_read` | 2 | Listed in supplied server event reference — `scripts/ezlibs-scripts/ezemail.lua`, `scripts/ezlibs-scripts/ezmail.lua` |
| `handle_player_join` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/ezlibs-scripts/ezmemory.lua` |
| `object_interaction` | 5 | Listed in supplied server event reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-scripts/ezcheckpoints.lua`, and 3 more |
| `player_area_transfer` | 5 | Listed in supplied server event reference — `scripts/events/eznpcs_onceitem.lua`, `scripts/ezlibs-scripts/ezbuttons.lua`, and 3 more |
| `player_avatar_change` | 3 | Listed in supplied server event reference — `scripts/avatar_utils/main.lua`, `scripts/ezlibs-scripts/avatar_utils/main.lua`, and 1 more |
| `player_connect` | 1 | Listed in supplied server event reference — `scripts/example_pvp_script.lua` |
| `player_disconnect` | 26 | Listed in supplied server event reference — `scripts/displayer/displayer.lua`, `scripts/displayer/font-system.lua`, and 24 more |
| `player_join` | 19 | Listed in supplied server event reference — `scripts/camera/main.lua`, `scripts/displayer/displayer.lua`, and 17 more |
| `player_join_area` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/events/eznpcs_onceitem.lua` |
| `player_move` | 2 | Listed in supplied server event reference — `scripts/ezlibs-scripts/main.lua`, `scripts/net-games/main.lua` |
| `player_request` | 4 | Listed in supplied server event reference — `scripts/displayer/font-system.lua`, `scripts/ezlibs-scripts/ezmemory.lua`, and 2 more |
| `post_selection` | 1 | Listed in supplied server event reference — `scripts/ezlibs-scripts/main.lua` |
| `shop_close` | 1 | Listed in supplied server event reference — `scripts/ezlibs-scripts/main.lua` |
| `shop_purchase` | 1 | Listed in supplied server event reference — `scripts/ezlibs-scripts/main.lua` |
| `textbox_response` | 2 | Listed in supplied server event reference — `scripts/example_pvp_script.lua`, `scripts/ezlibs-scripts/main.lua` |
| `tick` | 24 | Listed in supplied server event reference — `scripts/animation-engine/animation-engine.lua`, `scripts/displayer/scrolling-sprite-list.lua`, and 22 more |
| `tile_interaction` | 3 | Listed in supplied server event reference — `scripts/camera/main.lua`, `scripts/example_pvp_script.lua`, and 1 more |
| `timer_global_create` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/displayer/timer-display.lua` |
| `timer_global_remove` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/displayer/timer-display.lua` |
| `timer_global_update` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/displayer/timer-display.lua` |
| `timer_remove` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/displayer/timer-display.lua` |
| `timer_update` | 1 | Repository-defined / not listed in supplied server event reference — `scripts/displayer/timer-display.lua` |
| `virtual_input` | 5 | Server-provided in root `API_CHANGES.md`; scripts consume/register handling for this event — `scripts/events/eznpcs_onceitem.lua`, `scripts/input-controller/main.lua`, and 3 more |

### Important repository-only symbols

These are directly referenced by the codebase but are not present in the supplied server API reference **or** root `API_CHANGES.md`. They may be extensions, version-specific APIs, or functions added by a project module. Do not document them as guaranteed server built-ins without checking the matching server implementation/version.

- Player positioning/animation aliases: `Net.move_player`, `Net.set_player_position`, `Net.set_player_animation`.
- Other names discovered by the scanner are individually marked in the `Net` and `Async` tables above. APIs documented by `API_CHANGES.md` (including player sprite operations, HUD/email/fragments operations, `virtual_input`, and player-specific music) are server-provided and should not be listed as unverified merely because they are absent from the shorter server API excerpt.

<a id="part-14"></a>
## ⏳ Part 14 — Async and Await Conventions

### Uppercase `Async` is not lowercase `async`

- `Async` is the server-provided table documented by the server API.
- Lowercase `async` is a separate helper used in this project and may be defined locally or by `promise_api.lua`.
- Do not replace `Async.await(...)` with `await ...`, and do not assume lowercase `async(...)` is the same as `Async.promisify(...)`.
- A local helper's behavior is defined by its implementation. Inspect the module before assuming it accepts a function, promise, or coroutine.

### Await player widgets

When a flow needs the player's response, use the Asyncified API from a coroutine-compatible context:

```lua
local response = Async.await(Async.quiz_player(
  player_id,
  "VS [NPC]",
  "VS Player",
  "No"
))

if response == nil then
  -- Player may have disconnected; stop this flow safely.
  return
end
```

This example uses only signatures listed in the supplied server reference. Adapt option handling to the actual response values returned by your runtime. The synchronous `Net.message_player`, `Net.question_player`, and `Net.quiz_player` forms are not promises unless the runtime explicitly says otherwise.

### Non-blocking waits and battle checks

Prefer `Async.sleep(duration)` over busy loops or blocking delays. For long-lived gameplay, keep event handlers short and avoid waiting inside a callback unless it explicitly starts a coroutine/promise flow. Before using a player ID after an await, check `Net.is_player(player_id)`; disconnects can invalidate IDs. Battle result events can contain missing fields, so validate values before calculations.

### Input-lock discipline

`Net.lock_player_input` and `Net.unlock_player_input` are global player controls, not a lock ownership system in the supplied API reference. When multiple modules can control the same player, track which module acquired the lock and only unlock it when that module is done. Always clean up on cancellation, disconnect, and early return. Do not assume the engine automatically balances locks.

<a id="part-15"></a>
## ✅ Part 15 — Safe Usage Checklist

- Verify the function exists in the target server version before using it, especially symbols marked repository-only.
- Use the correct `Net` versus `Async` API and preserve the documented argument order.
- Treat system paths and `/server/...` asset paths as different namespaces.
- Validate player IDs after any await or asynchronous pause; disconnects may invalidate them.
- Validate event fields that may be absent before arithmetic or indexing.
- Do not expose `Net.get_player_secret` or unnecessarily log player IPs.
- Do not assume an API marked deprecated or unstable is safe for new features.
- Clean up event listeners, emitters, timers, sprites, temporary bots/areas, input locks, and per-player UI when a session ends.
- Keep the API reference versioned alongside the server version; the provided API excerpt may differ from the installed runtime.


<a id="part-16"></a>
## 🧭 Part 16 — API Ownership: Server vs. Repository Scripts

Use this section to determine **where an API comes from before calling it**. The ownership distinction is important: server-provided APIs are injected by the OpenNetBattle runtime, while repository-provided APIs are Lua modules/functions loaded from this repository. Repository modules may themselves call server APIs, but that does not make the module's public functions part of `Net`.

### Ownership labels used in this reference

| Label | Meaning |
|---|---|
| **Server-provided** | Listed in the supplied server API reference or root `API_CHANGES.md`; exposed by the running server, not implemented by this repository's Lua scripts. |
| **Repository-provided** | Defined by Lua source in `scripts/` (or loaded from a repository Lua dependency). Its availability depends on the relevant script/module being loaded. |
| **Observed / verify** | A symbol is referenced by repository code but is not confirmed by the supplied server documentation. Code usage alone is not proof of server support. |
| **Lua standard library** | Provided by Lua itself (for example `table`, `string`, `math`, `pairs`, `ipairs`, `pcall`, `require`), not by the game server or this repository. |

### Server-provided globals and APIs

These are runtime APIs, not repository helper modules:

- `Net` and its documented methods, including event registration (`Net:on`), map/area/object APIs, player and bot APIs, widgets, battles, sound/music, camera and movement APIs, and asset operations.
- `Async` and the documented asynchronous/promise helpers, including `Async.await`, `Async.await_all`, `Async.promisify`, `Async.create_promise`, `Async.sleep`, filesystem/network helpers, and asyncified player-widget/battle calls described in Parts 10–11.
- `Net.EventEmitter`, as described in Part 12.
- The APIs explicitly listed in the root `API_CHANGES.md`. That file is a server API changelog/reference; its listed `Net.*` functions and events are **server-provided**, not functions implemented by scripts in this archive.

#### APIs listed in `API_CHANGES.md`

| API | Owner | Notes |
|---|---|---|
| `Net.toggle_player_hud(player_id)` | Server | Toggle HUD visibility. |
| `Net.set_player_hud_mode(player_id, mode)` | Server | `mode`: `health = 0`, `icon = 1`. |
| `Net.send_player_battle_rewards(player_id, rewards)` | Server | Sends the documented reward list. |
| `Net.ring_player_hud(player_id)` | Server | Triggers HUD ring feedback. |
| `Net.get_player_fragments(player_id)` / `Net.set_player_fragments(player_id, count)` | Server | Read/set fragment count. |
| `Net.send_player_email(player_id, mail)` | Server | Sends an email object using the fields documented in `API_CHANGES.md`. |
| `Net:on("email_read", function(event) ... end)` | Server event | Event payload includes `player_id` and `email_id`. Register it through server-provided `Net:on`. |
| `Net.player_alloc_sprite(player_id, sprite_id, params)` | Server | Allocates a client sprite resource for a player. |
| `Net.player_draw_sprite(player_id, sprite_id, obj)` | Server | Draws/updates a player-specific sprite instance. |
| `Net.player_erase_sprite(player_id, obj_id)` | Server | Erases a player-specific sprite instance. |
| `Net.player_dealloc_sprite(player_id, sprite_id)` | Server | Deallocates a sprite resource and its instances. |
| `Net.virtual_input(event)` | Server event/API | Virtual input events for locked-player custom input flows. |
| `Net.provide_asset(area_id, asset_path, hint)` | Server | Provides an asset to an area; `hint` is optional metadata. |
| `Net.provide_asset_for_player(player_id, asset_path, hint)` | Server | Provides an asset to one player; `hint` is optional metadata. |
| `Net.set_song_for_player(player_id, path)` | Server | Changes music for one player, not the whole area. |
| `Net.stop_song_for_player(player_id)` | Server | Stops music for one player. |

`API_CHANGES.md` also records behavior changes: sprite objects cannot change their animation document via `anim_path` after creation (allocate/use a new `sprite_id` for a new texture/animation document); sprite draw color accepts `r`, `g`, `b`, and `color_mode`; `a` may be used as an alternative to `opacity`; and asset `hint` values use server-defined asset/package enums. These are server behavior/API notes, not script helpers.

### Repository-provided Lua APIs and modules

The following are examples of repository APIs. They are not built-in `Net` methods unless explicitly documented as such above.

| Module / API family | Source area in this archive | What it provides |
|---|---|---|
| `ezlibs-scripts` | `scripts/ezlibs-scripts/` | Shared game helpers and feature modules such as `ezmemory`, `eznpcs`, `eztriggers`, `ezbuttons`, `ezmapinstance`, `ezcheckpoints`, `ezlogger`, and related utilities. Call the functions exported by each module, not as if they were server globals. |
| `net-games` | `scripts/net-games/` | Shared minigame/gameplay, UI and presentation helpers. These are repository code that use the server API underneath. |
| `displayer` | `scripts/displayer/` | Text/sprite presentation and display abstractions implemented by repository scripts. |
| `input-controller` | `scripts/input-controller/` | Controller/input ownership, claims, consumption, and release behavior implemented by repository code. |
| `camera` | `scripts/camera/` | Camera management/controllers layered on server camera APIs. |
| `animation-engine` | `scripts/animation-engine/` | Script-side animation sequencing and interpolation helpers. |
| `world-attachment` | `scripts/world-attachment.lua` (where present) | Script-side world attachment behavior; not a native server API. Confirm the exact path and exported functions in the current source before requiring it. |
| `net-game-tourney` | `scripts/net-game-tourney/` | Tournament bracket, flow, UI, and match coordination implemented by scripts. |
| Individual games/features | For example `scripts/ezlibs-custom/footbomb/`, `scripts/events/`, and other feature directories | Feature-specific logic and exports; not automatically available unless the relevant script is loaded. |
| Lowercase `async` | Repository file(s), including `promise_api.lua` when included by the server setup | Distinct from uppercase server-provided `Async`. Do not assume their functions or calling conventions are interchangeable. |
| `helpers`, `enums`, and other local utility modules | Their defining Lua files in the archive | Script-side utilities/constants, not server globals unless code explicitly installs them globally. |

This list is a module-family map, not a guarantee that every module exports a particular function. For exact function names and signatures, inspect the module's current `main.lua` or entry file and its `_DOCUMENTATION` page. Use the module's documented `require`/loading convention from this repository.

### Practical examples

```lua
-- Server-provided API: the runtime invokes this callback.
Net:on("player_join", function(event)
  local player_id = event.player_id
end)

-- Server-provided async widget API: use uppercase Async when awaiting a response.
local choice = Async.await(Async.quiz_player(player_id, "Option A", "Option B", "Option C"))

-- Repository-provided APIs: these names must be loaded from their Lua modules.
-- Example only: use the actual module path and exported function documented by the repository.
local module = require("path.to.repository.module")
-- module.some_function(...)
```

The last example is intentionally schematic; `path.to.repository.module` and `some_function` are placeholders, not claimed exports. Do not copy them as working server code.

### Classification rules for uncertain symbols

- A `Net.*` or `Async.*` symbol documented in Parts 2–12 or the supplied root `API_CHANGES.md` is server-provided.
- A function defined in a Lua source file under `scripts/` is repository-provided, unless the file is explicitly vendored as a dependency with its own documented origin; it is still not automatically a server API.
- A symbol that appears only at call sites, and has no supplied server documentation or local definition, remains **observed / verify**. This applies to APIs listed in Part 13 as missing from the supplied API excerpt.
- Do not infer support merely because a function is named `Net.*`; the server may inject undocumented methods, but this archive alone cannot establish that.
- Check the current server build and current script source before using APIs whose signatures or availability are marked uncertain.
