-- Async.lua
-- Async/await and Promise utilities for Lua 5.2.
--
-- Supports both coroutine functions and already-created coroutine threads.
-- Async.await() may yield either a Promise or a continuation function. The
-- latter is the protocol used by EventEmitter:async_iter() and by pending
-- Promise waits.

local Async = {}

local PROMISE_STATE = {
    PENDING = "pending",
    FULFILLED = "fulfilled",
    REJECTED = "rejected",
}

local function pack(...)
    return {
        n = select("#", ...),
        ...,
    }
end

local function unpack_values(values, first, last)
    return table.unpack(values, first or 1, last or values.n or #values)
end

local function is_promise(value)
    return type(value) == "table"
        and type(value.and_then) == "function"
        and (value.state == PROMISE_STATE.PENDING
            or value.state == PROMISE_STATE.FULFILLED
            or value.state == PROMISE_STATE.REJECTED)
end

-- Create a Promise.
function Async.create_promise(executor)
    if type(executor) ~= "function" then
        error("Async.create_promise expected an executor function", 2)
    end

    local promise = {
        state = PROMISE_STATE.PENDING,
        value = nil,
        error = nil,
        on_fulfilled = {},
        on_rejected = {},
    }

    local function resolve(...)
        if promise.state ~= PROMISE_STATE.PENDING then
            return
        end

        promise.state = PROMISE_STATE.FULFILLED
        promise.value = pack(...)

        -- Detach handlers before invoking them. This prevents callbacks that
        -- register more callbacks from mutating the list being traversed.
        local handlers = promise.on_fulfilled
        promise.on_fulfilled = {}
        promise.on_rejected = {}

        for _, handler in ipairs(handlers) do
            handler(unpack_values(promise.value))
        end
    end

    local function reject(reason)
        if promise.state ~= PROMISE_STATE.PENDING then
            return
        end

        promise.state = PROMISE_STATE.REJECTED
        promise.error = reason

        local handlers = promise.on_rejected
        promise.on_fulfilled = {}
        promise.on_rejected = {}

        for _, handler in ipairs(handlers) do
            handler(reason)
        end
    end

    -- Retain the existing project's and_then contract: callbacks are invoked
    -- with the resolved values, and and_then returns this same Promise.
    function promise:and_then(on_fulfilled, on_rejected)
        if on_fulfilled ~= nil and type(on_fulfilled) ~= "function" then
            error("Promise:and_then expected on_fulfilled to be a function or nil", 2)
        end
        if on_rejected ~= nil and type(on_rejected) ~= "function" then
            error("Promise:and_then expected on_rejected to be a function or nil", 2)
        end

        if self.state == PROMISE_STATE.FULFILLED then
            if on_fulfilled then
                on_fulfilled(unpack_values(self.value))
            end
        elseif self.state == PROMISE_STATE.REJECTED then
            if on_rejected then
                on_rejected(self.error)
            end
        else
            if on_fulfilled then
                table.insert(self.on_fulfilled, on_fulfilled)
            end
            if on_rejected then
                table.insert(self.on_rejected, on_rejected)
            end
        end

        return self
    end

    local ok, err = pcall(executor, resolve, reject)
    if not ok then
        reject(err)
    end

    return promise
end

-- Convert a coroutine function or an existing coroutine thread to a Promise.
function Async.promisify(coroutine_or_function)
    local co

    if type(coroutine_or_function) == "function" then
        co = coroutine.create(coroutine_or_function)
    elseif type(coroutine_or_function) == "thread" then
        co = coroutine_or_function
        if coroutine.status(co) ~= "suspended" then
            error("Async.promisify expected a new or suspended coroutine thread", 2)
        end
    else
        error("Async.promisify expected a function or coroutine thread", 2)
    end

    return Async.create_promise(function(resolve, reject)
        local finished = false
        local waiting = false
        local wait_id = 0

        local step

        local function fail(reason)
            if finished then
                return
            end
            finished = true
            waiting = false
            reject(reason)
        end

        step = function(...)
            if finished then
                return
            end

            waiting = false

            local resumed = pack(coroutine.resume(co, ...))
            if not resumed[1] then
                fail(resumed[2])
                return
            end

            if coroutine.status(co) == "dead" then
                finished = true
                resolve(unpack_values(resumed, 2, resumed.n))
                return
            end

            -- coroutine.resume returns: success, yielded_value(s).
            local yielded = resumed[2]

            if is_promise(yielded) then
                wait_id = wait_id + 1
                local this_wait = wait_id
                waiting = true

                local ok, err = pcall(function()
                    yielded:and_then(
                        function(...)
                            if finished or not waiting or wait_id ~= this_wait then
                                return
                            end
                            waiting = false
                            step(...)
                        end,
                        function(reason)
                            if finished or not waiting or wait_id ~= this_wait then
                                return
                            end
                            fail(reason)
                        end
                    )
                end)

                if not ok and waiting and wait_id == this_wait then
                    fail(err)
                end
                return
            end

            if type(yielded) == "function" then
                -- Async.await() yields a continuation function. EventEmitter
                -- iterators call resolve(...) when an event arrives; pending
                -- Promise waits call either resolve(...) or reject(reason).
                wait_id = wait_id + 1
                local this_wait = wait_id
                waiting = true

                local function resume_wait(...)
                    if finished or not waiting or wait_id ~= this_wait then
                        return
                    end
                    waiting = false
                    step(...)
                end

                local function reject_wait(reason)
                    if finished or not waiting or wait_id ~= this_wait then
                        return
                    end
                    fail(reason)
                end

                local ok, err = pcall(yielded, resume_wait, reject_wait)
                if not ok and waiting and wait_id == this_wait then
                    fail(err)
                end
                return
            end

            -- Preserve the original behavior for ordinary coroutine yields:
            -- immediately resume with the yielded values.
            step(unpack_values(resumed, 2, resumed.n))
        end

        step()
    end)
end

-- Await a Promise or an EventEmitter async iterator inside a coroutine.
function Async.await(promise_or_iterator)
    if type(promise_or_iterator) == "function" then
        local result = promise_or_iterator()

        if type(result) == "function" then
            -- The promisify runner invokes this continuation with resolve and
            -- reject callbacks when the awaited event becomes available.
            return coroutine.yield(result)
        end

        return result
    end

    if not is_promise(promise_or_iterator) then
        error("Async.await expected a Promise or async iterator function; got "
            .. type(promise_or_iterator), 2)
    end

    if promise_or_iterator.state == PROMISE_STATE.FULFILLED then
        return unpack_values(promise_or_iterator.value)
    end

    if promise_or_iterator.state == PROMISE_STATE.REJECTED then
        error(promise_or_iterator.error, 2)
    end

    return coroutine.yield(function(resolve, reject)
        promise_or_iterator:and_then(resolve, reject)
    end)
end

-- Run a coroutine function and return its Promise.
function Async.run(main_function)
    if type(main_function) ~= "function" then
        error("Async.run expected a function", 2)
    end

    return Async.promisify(main_function)
end

-- Create a function that validates positional arguments.
function Async.create_validator(expected_values, error_message)
    if type(expected_values) ~= "table" then
        error("Async.create_validator expected expected_values to be a table", 2)
    end

    return function(...)
        local args = pack(...)
        for i, expected in ipairs(expected_values) do
            if args[i] ~= expected then
                error(error_message, 2)
            end
        end
    end
end

return Async
