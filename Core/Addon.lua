Addon = {
    frame = nil,
    callbacks = {}
}

function Addon:New()
    local o = {}
    setmetatable(o, self)
    self.__index = self

    self.frame = CreateFrame("Frame")
    self.frame:SetScript("OnEvent", function(_, event, ...)
            self.callbacks[event](...)
        end
    )

    return o
end

function Addon:RegisterCallback(event, callback)
    self.callbacks[event] = callback
    self.frame:RegisterEvent(event)
end
