# 🔌 HP Manager bootstrap registration

[🏠 Documentation home](../index.md) · [🖥️ HP Manager](../hp_manager/README.md) · [📄 Boot source](main/index.md)

The current `scripts/ezlibs-scripts/main.lua` has an early guarded import:

```lua
local hp_manager_ok, hp_manager_err = pcall(require, 'scripts/hp_manager/main')
if not hp_manager_ok then
  print('[HP_Manager] startup require failed: ' .. tostring(hp_manager_err))
end
```

This registers HP Manager's `object_interaction` handler as the module loads; `object_registry.load_all()` is invoked later in the bootstrap. If a server uses a different entry script, verify it actually loads `scripts/ezlibs-scripts/main.lua`. A `pcall` failure is logged, so absence of an exception does not prove success. Check the [Tiled map guide](../areas/HP_MANAGER_TILED.md) for object ID, type, tileset and interaction diagnostics.
