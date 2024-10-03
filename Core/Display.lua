Display = {
    frame = nil,
    last = nil,
    onStart = nil,
    onReset = nil,
}

function Display:New(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.frame = CreateFrame("Frame", "LooterFrame", UIParent)
    o.frame:SetSize(200, 200)
    o.frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 200, -100)

    o.frame.reset = CreateFrame("Button", nil, o.frame, "UIPanelButtonTemplate")
    o.frame.reset:SetSize(100, 24)
    o.frame.reset:SetPoint("TOPLEFT", o.frame, "TOPLEFT", 0, 0)
    o.frame.reset:SetText("Reset")

    o.frame.reset:SetScript("OnClick", function(_, _, _)
        o:Update(0, 0, 0)

        if o.onReset then
            o:onReset()
        end
    end)

    o.frame.total = o.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    o.frame.total:SetPoint("TOPLEFT", o.frame.reset, "BOTTOMLEFT", 0, -8)

    o.frame.elapsed = o.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    o.frame.elapsed:SetPoint("TOPLEFT", o.frame.total, "BOTTOMLEFT", 0, -4)

    o:Update(0, 0, 0)

    return o
end

function Display:OnReset(callback)
    self.onReset = callback
end

function Display:Update(total, estimate, elapsed)
    self.frame.total:SetText("Total: " .. GetMoneyString(total) .. "  (" .. GetMoneyString(estimate) .. "/h)")
    self.frame.elapsed:SetText("Elapsed: " .. SecondsToTime(elapsed, false, true))
end
