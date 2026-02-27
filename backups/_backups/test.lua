local Utility = require("scripts/tests/utility")

 local promise2 = Utility.create_promise(function (resolve)
            resolve(Async.sleep(1))
            print("1 second passed")
        end)
        
    local promise1 =   
        Utility.create_promise(function(resolve)
            resolve(Async.sleep(3))
            print("Resolving...")
            print("We waited 3 seconds")
        end)

local function async_test_function()
    return Utility.run(
    function()
        local result1 = Utility.await(promise1)
        local res1 = Utility.await(result1)
        print(result1)
        local result2 = Utility.await(promise2)
        print(result2)
        return "Success"
    end
    )
end

Net:on("player_join", function (event)
    --local EmitterTest = Utility.EventEmitter.new()
    -- local results = async_test_function()
    -- Utility.resolve_multi(Utility.await(promise1), Utility.await(promise2))
    -- print(results)
    --EmitterTest:once("once_test", function (event)
    --    print(event)
    --end)

    --EmitterTest:on("Test", function(event)
    --    print(event)
    --end)    
    --EmitterTest:emit("Test", {player_id = event.player_id})
    --EmitterTest:emit("once_test", {"TESTING ONCE"})
    --EmitterTest:emit("once_test", {"TESTING TWICE (WE SHOULD NOT SEE THIS)"})

    -- local async_function = Utility.run(function()
    --     print("Async function started")
    --     Async.sleep(3)
    --     -- Create a promise that resolves after delay
    --     -- AWAIT the promise
    --     print("SLEPT FOR 3 SECONDS")
    --     return "Finished"
    -- end)
    -- async_function:and_then(function()
    --     print("Was rejected")
    -- end
end)
