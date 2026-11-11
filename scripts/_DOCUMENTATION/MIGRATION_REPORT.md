# 📦 Centralized Documentation — Migration Report

**Snapshot:** 2026-11-11
**Destination:** `scripts/_DOCUMENTATION/`

All Markdown guides and READMEs outside the documentation tree were moved here while preserving their original relative hierarchy. 
The non-runtime encounter-mod audit text file was moved as well. Source files and binary assets are unchanged. 
The external `LICENSE.md` files remain next to their corresponding third-party source packages.

## ✅ Migrated paths

| Former source path | New documentation path |
|---|---|
| `assets/ezlibs-assets/ezencounters/MOD_PACKAGE_AUDIT.txt` | [MOD_PACKAGE_AUDIT.txt](assets/ezlibs-assets/ezencounters/MOD_PACKAGE_AUDIT.txt) |
| `assets/ezlibs-assets/eznpcs/sheet/readme.md` | [readme.md](assets/ezlibs-assets/eznpcs/sheet/readme.md) |
| `assets/ezlibs-assets/readme.md` | [readme.md](assets/ezlibs-assets/readme.md) |
| `assets/tiles/README.md` | [README.md](assets/tiles/README.md) |
| `scripts/animation-engine/README.md` | [README.md](animation-engine/README.md) |
| `scripts/avatar_utils/lua_yes_parser/README.md` | [README.md](avatar_utils/lua_yes_parser/README.md) |
| `scripts/avatar_utils/lua_yes_parser/spec/README.md` | [README.md](avatar_utils/lua_yes_parser/spec/README.md) |
| `scripts/camera/README.md` | [README.md](camera/README.md) |
| `scripts/displayer/readme.md` | [readme.md](displayer/readme.md) |
| `scripts/ezlibs-custom/footbomb/README.md` | [README.md](ezlibs-custom/footbomb/README.md) |
| `scripts/ezlibs-custom/nebulous-liberations/README.md` | [README.md](ezlibs-custom/nebulous-liberations/README.md) |
| `scripts/ezlibs-custom/nebulous-liberations/spirits/todo.md` | [todo.md](ezlibs-custom/nebulous-liberations/spirits/todo.md) |
| `scripts/ezlibs-scripts/MODULE_DEPENDENCIES.md` | [MODULE_DEPENDENCIES.md](ezlibs-scripts/MODULE_DEPENDENCIES.md) |
| `scripts/ezlibs-scripts/README-UPDATED.md` | [README-UPDATED.md](ezlibs-scripts/README-UPDATED.md) |
| `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/README.md` | [README.md](ezlibs-scripts/avatar_utils/lua_yes_parser/README.md) |
| `scripts/ezlibs-scripts/avatar_utils/lua_yes_parser/spec/README.md` | [README.md](ezlibs-scripts/avatar_utils/lua_yes_parser/spec/README.md) |
| `scripts/ezlibs-scripts/ezlibs-tiled-reference.md` | [ezlibs-tiled-reference.md](ezlibs-scripts/ezlibs-tiled-reference.md) |
| `scripts/ezlibs-scripts/readme.md` | [readme.md](ezlibs-scripts/readme.md) |
| `scripts/ezlibs-scripts/utils/README.md` | [README.md](ezlibs-scripts/utils/README.md) |
| `scripts/input-controller/README.md` | [README.md](input-controller/README.md) |
| `scripts/libs/stardust/README.md` | [README.md](libs/stardust/README.md) |
| `scripts/net-games/UI-SUPPRESSION.md` | [UI-SUPPRESSION.md](net-games/UI-SUPPRESSION.md) |
| `scripts/net-games/menuAPI/README.md` | [README.md](net-games/menuAPI/README.md) |
| `scripts/net-games/npcs/readme.md` | [readme.md](net-games/npcs/readme.md) |
| `scripts/net-games/readme.md` | [readme.md](net-games/readme.md) |
| `scripts/net-games/utilities/README.md` | [README.md](net-games/utilities/README.md) |
| `scripts/persistence/README.md` | [README.md](persistence/README.md) |
| `scripts/utils/README.md` | [README.md](utils/README.md) |

## 📌 Drop-in deployment

- **Complete server archive:** extract into a clean server directory, or explicitly delete the paths above before merging into an existing installation. ZIP extraction alone cannot remove old files.
- **Documentation-only archive:** contains only `scripts/_DOCUMENTATION/`. Place it in your server folder and remove the former paths listed above to achieve a single documentation location.
- All runtime Lua code, map data, battle mods, and artwork are identical to the documented server snapshot.

## 🔎 Navigation

- [📚 Master documentation index](index.md)
- [🧭 Current systems guide](CURRENT_SYSTEMS.md)
- [📋 Project snapshot report](SNAPSHOT_REPORT.md)
