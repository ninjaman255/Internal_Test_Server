# 🪵 Logger

[🏠 Documentation home](../index.md) · [🪵 Programmer guide](README.md) · [🔄 Migration](MIGRATION.md) · [🧪 Validation](TESTING.md)

## 🗂️ Contents

| Document | Purpose |
|---|---|
| [Programmer guide](README.md) | API, log hierarchy, options, system and subsystem conventions |
| [Logger migration](MIGRATION.md) | Shared import paths and compatibility adapters |
| [Tests](TESTING.md) | Regression checks and suggested live-server verification |
| [Current `logger.lua` reference](logger/index.md) | Source-derived functions and dependencies |
| [Compatibility `ezlogger.lua`](../ezlibs-scripts/ezlogger/index.md) | Shim to the shared logger, no separate runtime |
| [Compatibility `persistence/logger.lua`](../persistence/logger/index.md) | Legacy `createLogger` adapter |

All generated logs now go beneath `scripts/_DEBUGGING/` in the root of `scripts/`.
