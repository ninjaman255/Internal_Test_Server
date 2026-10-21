-- EventEmitter.lua
-- A flexible event system with async capabilities.
--
-- Design notes:
--   * emit() snapshots callback lists before iterating, so listeners may
--     safely add/remove other listeners during a call.
--   * once-listeners are cleared BEFORE invocation, so a re-emitted event
--     from inside a once-handler does not fire it twice.
--   * Every callback is isolated with pcall when an error handler is
--     installed; by default errors propagate (previous behavior). Install a
--     handler with `set_error_handler(fn)` for non-fatal diagnostics.
--   * async_iter / async_iter_all return (next_fn, close_fn). Calling
--     close_fn tears down the listener and wakes any pending waiter.
local EventEmitter = {}
EventEmitter.__index = EventEmitter

-- Create a new EventEmitter instance
function EventEmitter.new()
    local self = setmetatable({}, EventEmitter)
    self._events = {}
    self._once_events = {}
    self._any_events = {}
    self._any_once_events = {}
    self._destroyed = false
    self._iterators = {}       -- event -> array of iterator records
    self._any_iterators = {}
    self._on_error = nil       -- nil = propagate; function(err, ...) = isolate
    return self
end

-- Install (or clear) an error handler for callbacks. When set, each listener
-- is pcall'd and any failure is forwarded to `fn(err, ...)`; the emit loop
-- continues. When nil (default), errors propagate synchronously.
function EventEmitter:set_error_handler(fn)
    self._on_error = fn
    return self
end

-- Internal: dispatch a callback, honoring the current error mode.
function EventEmitter:_call(callback, ...)
    if not self._on_error then
        callback(...)
        return
    end
    local ok, err = pcall(callback, ...)
    if not ok then
        local hok, herr = pcall(self._on_error, err, ...)
        if not hok then
            -- Last-ditch so a broken error handler can't kill the emit loop.
            print("[ezemitter] error handler failed: " .. tostring(herr))
        end
    end
end

-- Register a listener for a specific event
function EventEmitter:on(event, callback)
    if self._destroyed then return self end
    if not self._events[event] then self._events[event] = {} end
    table.insert(self._events[event], callback)
    return self
end

-- Register a one-time listener for a specific event
function EventEmitter:once(event, callback)
    if self._destroyed then return self end
    if not self._once_events[event] then self._once_events[event] = {} end
    table.insert(self._once_events[event], callback)
    return self
end

-- Register a listener for any event
function EventEmitter:on_any(callback)
    if self._destroyed then return self end
    table.insert(self._any_events, callback)
    return self
end

-- Register a one-time listener for any event
function EventEmitter:on_any_once(callback)
    if self._destroyed then return self end
    table.insert(self._any_once_events, callback)
    return self
end

-- Copy a list so listeners mutating it during emit can't corrupt the loop.
local function snapshot(list)
    local s = {}
    for i = 1, #list do s[i] = list[i] end
    return s
end

-- Emit an event
function EventEmitter:emit(event, ...)
    if self._destroyed then return self end

    local regular = self._events[event]
    if regular and #regular > 0 then
        local s = snapshot(regular)
        for i = 1, #s do self:_call(s[i], ...) end
    end

    local once = self._once_events[event]
    if once and #once > 0 then
        -- Clear BEFORE calling so a re-emit from inside a once-handler
        -- registers a *new* once, and does not re-fire the current one.
        self._once_events[event] = nil
        local s = snapshot(once)
        for i = 1, #s do self:_call(s[i], ...) end
    end

    if #self._any_events > 0 then
        local s = snapshot(self._any_events)
        for i = 1, #s do self:_call(s[i], event, ...) end
    end

    if #self._any_once_events > 0 then
        local once_any = self._any_once_events
        self._any_once_events = {}
        local s = snapshot(once_any)
        for i = 1, #s do self:_call(s[i], event, ...) end
    end

    return self
end

-- Remove a specific listener (from both `on` and `once`). Removes every
-- occurrence. Returns (self, removed_any).
function EventEmitter:remove_listener(event, callback)
    if self._destroyed then return self, false end
    local removed = false

    local function prune(list)
        if not list then return list end
        for i = #list, 1, -1 do
            if list[i] == callback then
                table.remove(list, i)
                removed = true
            end
        end
        if #list == 0 then return nil end
        return list
    end

    self._events[event] = prune(self._events[event])
    self._once_events[event] = prune(self._once_events[event])
    return self, removed
end

-- Remove a specific on_any listener
function EventEmitter:remove_on_any_listener(callback)
    if self._destroyed then return self end
    for i = #self._any_events, 1, -1 do
        if self._any_events[i] == callback then
            table.remove(self._any_events, i)
        end
    end
    return self
end

-- Remove every listener for one event (or everything when `event` is nil).
function EventEmitter:remove_all_listeners(event)
    if self._destroyed then return self end
    if event == nil then
        self._events = {}
        self._once_events = {}
        self._any_events = {}
        self._any_once_events = {}
    else
        self._events[event] = nil
        self._once_events[event] = nil
    end
    return self
end

-- Introspection
function EventEmitter:has_listeners(event)
    if event == nil then
        for _ in pairs(self._events) do return true end
        for _ in pairs(self._once_events) do return true end
        return #self._any_events > 0 or #self._any_once_events > 0
    end
    local ev = self._events[event]
    local on = self._once_events[event]
    return (ev and #ev > 0) or (on and #on > 0) or false
end

function EventEmitter:listener_count(event)
    local count = 0
    if event == nil then
        for _, list in pairs(self._events) do count = count + #list end
        for _, list in pairs(self._once_events) do count = count + #list end
        count = count + #self._any_events + #self._any_once_events
        return count
    end
    local ev = self._events[event]
    local on = self._once_events[event]
    if ev then count = count + #ev end
    if on then count = count + #on end
    return count
end

-- Build the shared (queue + waiter) machinery used by both iterator variants.
local function make_iterator_state()
    return { queue = {}, waiting = nil, closed = false }
end

local function iterator_next(state)
    if state.closed then return nil end
    if #state.queue > 0 then
        return table.unpack(table.remove(state.queue, 1))
    end
    return function(resolve) state.waiting = resolve end
end

-- Create an async iterator for a specific event.
-- Returns (next_fn, close_fn). close_fn unregisters the underlying listener
-- and wakes any pending waiter with nil.
function EventEmitter:async_iter(event)
    if self._destroyed then return nil end

    local state = make_iterator_state()
    state.event = event
    state.emitter = self

    local function on_event(...)
        if state.closed then return end
        table.insert(state.queue, {...})
        if state.waiting then
            local item = table.remove(state.queue, 1)
            local wait = state.waiting
            state.waiting = nil
            wait(table.unpack(item))
        end
    end
    state.listener = on_event

    self:on(event, on_event)

    if not self._iterators[event] then self._iterators[event] = {} end
    table.insert(self._iterators[event], state)

    local function close_fn()
        if state.closed then return end
        state.closed = true
        self:remove_listener(event, on_event)
        local list = self._iterators[event]
        if list then
            for i = #list, 1, -1 do
                if list[i] == state then table.remove(list, i) end
            end
            if #list == 0 then self._iterators[event] = nil end
        end
        if state.waiting then
            local wait = state.waiting
            state.waiting = nil
            wait(nil)
        end
    end

    return function() return iterator_next(state) end, close_fn
end

-- Create an async iterator for all events.
-- Returns (next_fn, close_fn) just like async_iter.
function EventEmitter:async_iter_all()
    if self._destroyed then return nil end

    local state = make_iterator_state()
    state.emitter = self

    local function on_any(event, ...)
        if state.closed then return end
        table.insert(state.queue, {event, ...})
        if state.waiting then
            local item = table.remove(state.queue, 1)
            local wait = state.waiting
            state.waiting = nil
            wait(table.unpack(item))
        end
    end
    state.listener = on_any

    self:on_any(on_any)
    table.insert(self._any_iterators, state)

    local function close_fn()
        if state.closed then return end
        state.closed = true
        self:remove_on_any_listener(on_any)
        for i = #self._any_iterators, 1, -1 do
            if self._any_iterators[i] == state then
                table.remove(self._any_iterators, i)
            end
        end
        if state.waiting then
            local wait = state.waiting
            state.waiting = nil
            wait(nil)
        end
    end

    return function() return iterator_next(state) end, close_fn
end

-- Clean up all resources
function EventEmitter:destroy()
    if self._destroyed then return end
    self._destroyed = true
    self._events = {}
    self._once_events = {}
    self._any_events = {}
    self._any_once_events = {}

    for _, iterators in pairs(self._iterators) do
        for _, state in ipairs(iterators) do
            state.closed = true
            if state.waiting then
                local wait = state.waiting
                state.waiting = nil
                wait(nil)
            end
        end
    end
    for _, state in ipairs(self._any_iterators) do
        state.closed = true
        if state.waiting then
            local wait = state.waiting
            state.waiting = nil
            wait(nil)
        end
    end

    self._iterators = {}
    self._any_iterators = {}
end

return EventEmitter