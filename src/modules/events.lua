-- Created by: SiriusLatte
-- Version: 1.0.0

-- Documentation not necessary, the file is already self explanatory and the methods are even more
-- this is a light-weight version of a more "complete" module called Signals (my own implementation as well).
-- Works well to whatever we want to do, and for the sake of facility I just wanted to focus on the main
-- methods, which are the ones that I need for this plugin to work all right.

-- Variables
local Event = {}
local createdEvents = {}

-- Types
type Event = typeof(Event.new("")) -- Idiomatic OOP

-- Functions
function Event.new(identifier: string?): Event
    local self = setmetatable({
        currentCallbacks = {}
    }, {
        __index = Event,
        __tostring = function()
            return string.format("Event<%s>", identifier or "EmptyEvent")
        end
    })

    local id
    if not identifier then
        id = #createdEvents + 1
        createdEvents[id] = self
    else
        createdEvents[identifier] = self
    end

    return self, id
end

function Event.getEvent(identifier: string | number): Event
    return createdEvents[identifier]
end

function Event:connect(functionToConnect: () -> nil): nil
    self.CurrentCallbacks[#self.CurrentCallbacks + 1] = functionToConnect
end

function Event:fire<T>(...: T): any
    local Result
    do
        local Invoke
        for _, Callback in ipairs(self.CurrentCallbacks) do
            Invoke = Callback(...)
            if Invoke then
                Result = Invoke
            end
        end
    end

    return Result
end

function Event:fireAsync<T>(...: T): any
    local Result
    task.spawn(function(...)
        Result = Event:fire(...)
    end, ...)

    return Result
end

-- Returning value
return Event