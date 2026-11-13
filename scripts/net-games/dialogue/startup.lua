-- net-games dialogue startup. Controllers are registered exactly once by
-- scripts/input-controller/main.lua; dialogue modules acquire sessions only
-- when screens are opened. Do not register a second virtual-input listener.
return true
