# 🎵 Jukebox — Initialization guard

[Jukebox index](index.md) · [Main reference](main/index.md)

## Observation and code path

Earlier `_MAIN.log` files contained two identical `45 track(s) across 2 album(s)` messages at each server start. The log alone does not reveal whether the same file was loaded under two names or a logger emitted duplicates. An inspection of the shipped Lua found that `scripts/hp_manager/main.lua` dynamically loads Jukebox through `constants.jukebox = "scripts/jukebox/main.lua"`, strips the `.lua` suffix, and calls `require`. The source archive does not establish every runtime plugin loader path.

## Implementation

At the **top** of `scripts/jukebox/main.lua`, `rawget(_G, "__jukebox_main_initialized")` returns an existing exported instance if one was installed. After the music catalog, area music restoration, internal emitter handlers, and four `Net:on` listeners have successfully initialized, the module stores the final public API with `rawset(_G, "__jukebox_main_initialized", public_api)`.

This ensures two `require`/`dofile` routes in the **same Lua global environment** reuse the same instance and do not rescan the catalog or register another set of event handlers. The public exports (`open`, `close`, `emitter`, `get_tracks`, `unlock_music`, `unlock_album`, and `get_albums`) remain unchanged.

It does **not** unify separate operating-system processes, separate Lua states, or logging duplication introduced outside the module. New startup logs should be compared after a fresh server restart.

## Testing

The provided regression test executes the Jukebox file twice through `loadfile`, verifies the same exported table is returned, confirms four Net listeners are only registered once, and checks one catalog scan and one startup log. This test mocks engine APIs; live OpenNetBattle validation is still required.
