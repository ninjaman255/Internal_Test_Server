# Utility modules

These modules use Lua 5.2 language and standard-library features only. They do not call the server-specific `Net` or `Async` APIs.

## `ezutil.lua`

```lua
local ezutil = require('scripts/ezlibs-scripts/utils/ezutil')

local count = ezutil.table_count({a = 1, b = 2})
local copy = ezutil.deep_copy({nested = {value = 1}})
local merged = ezutil.table_merge({enabled = false}, {enabled = true})
local bounded = ezutil.clamp(10, 0, 5)
```

Functions: `clamp`, `table_contains` (array-style tables), `table_remove_value`, `table_count`, `table_is_empty`, `shallow_copy`, `deep_copy`, and `table_merge`. `table_merge` mutates and returns its target; keys in the source overwrite matching target keys.

`helpers.lua` now uses `ezutil.table_count` for the existing global `get_table_length` helper and `ezutil.deep_copy` for `helpers.deep_copy`. These keep the public helper names while sharing the implementation. The deep-copy implementation also handles cyclic references and shared table references.

## `ezvalidate.lua`

Provides `is_type`, `number_range`, `required_fields`, and `table_field_types`. Validation functions return a boolean and, for failures, a message where applicable. They are opt-in and are not wired into existing server handlers, to avoid changing their runtime behavior without a confirmed call-site contract.

## `ezdebug.lua`

Provides configurable `info`, `warn`, `error`, and `traceback` helpers. It defaults to `print`, can be configured with `ezdebug.configure({ enabled = ..., prefix = ..., sink = ... })`, and is opt-in. Existing `warn`/`print` calls were not replaced because the server's logging contract is not established by the Lua standard library alone.

## Tests

Run from this folder with Lua 5.2 installed: `lua tests/test_utilities.lua`. Tests use Lua standard libraries only. The test file is included but was not executed in the build environment because a Lua interpreter was not available.
