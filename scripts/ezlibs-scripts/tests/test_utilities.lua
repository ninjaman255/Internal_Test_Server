-- Run from the package root with:
-- lua tests/test_utilities.lua

package.path = "./?.lua;./?/init.lua;./utils/?.lua;" .. package.path

local ezutil = require("ezutil")
local ezvalidate = require("ezvalidate")
local ezdebug = require("ezdebug")

local function test(name, callback)
    local ok, err = pcall(callback)
    if not ok then
        io.stderr:write("FAIL: " .. name .. ": " .. tostring(err) .. "\n")
        os.exit(1)
    end
    io.write("PASS: " .. name .. "\n")
end

test("clamp", function()
    assert(ezutil.clamp(5, 1, 4) == 4)
    assert(ezutil.clamp(-2, 1, 4) == 1)
    assert(ezutil.clamp(3, 1, 4) == 3)
end)

test("table_contains and removal", function()
    local values = {"a", "b", "b", "c"}
    assert(ezutil.table_contains(values, "b"))
    assert(not ezutil.table_contains(values, "missing"))
    assert(ezutil.table_remove_value(values, "b", true) == 2)
    assert(#values == 2)
end)

test("copy and merge", function()
    local source = {nested = {value = 7}, a = 1}
    local copy = ezutil.deep_copy(source)
    copy.nested.value = 9
    assert(source.nested.value == 7)

    local target = {a = 1}
    ezutil.table_merge(target, {a = 2, b = 3})
    assert(target.a == 2 and target.b == 3)
end)

test("validation", function()
    assert(ezvalidate.number_range(5, 1, 9))
    local ok = ezvalidate.number_range(10, 1, 9)
    assert(not ok)

    assert(ezvalidate.required_fields({id = 1, name = "test"}, {"id", "name"}))
    local fields_ok = ezvalidate.required_fields({id = 1}, {"id", "name"})
    assert(not fields_ok)

    assert(ezvalidate.table_field_types({id = 1, name = "test"}, {
        id = "number",
        name = "string"
    }))
end)

test("debug sink and disabled mode", function()
    local messages = {}
    ezdebug.configure({
        enabled = true,
        prefix = "test",
        sink = function(message) messages[#messages + 1] = message end
    })
    ezdebug.info("hello", 123)
    assert(#messages == 1)
    assert(messages[1]:find("hello 123", 1, true))

    ezdebug.configure({enabled = false})
    ezdebug.info("ignored")
    assert(#messages == 1)

    ezdebug.configure({enabled = true, prefix = "[ezlibs]", sink = print})
end)

io.write("All utility tests passed.\n")
