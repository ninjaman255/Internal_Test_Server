# HP Manager — Tiled object setup

[Documentation home](../index.md) · [HP Manager](../hp_manager/README.md)

The supplied `areas/default.tmx` defines **object ID 185**, name `hp_manager`, type `HP_Manager`, and GID `73` at `(624, 624)`. The HP Manager Lua listener checks the interacting object's `type` or `class` against `HP_Manager` and accepts interaction button `0` (or an omitted button).

The original `internal_test_server(4).zip` map uses a tileset source path with uppercase `HP_Manager`: `../assets/HP_Manager/Tilesets/machine.tsx`. Previous drop-in updates addressed casing; on case-sensitive servers confirm the installed map's source matches the actual directory (`assets/hp_manager/Tilesets/`). Do not rename object type `HP_Manager`, which is the event-dispatch contract.

The recent debugging log confirms object `185` produces interaction events and the listener is registered. The unresolved save/close bugs are in editor state and native-dialog handoff, not evidence of missing object interaction.
