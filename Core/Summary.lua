Summary = {
    start = 0,
    total = 0,
    history = {}
}

function Summary:New()
    local o = {}
    setmetatable(o, self)
    self.__index = self

    return o
end

function Summary:Start()
    self.start = GetTimePreciseSec()
    self.total = 0
    self.history = {}
end

function Summary:AddLoot(link, price, quantity)
    self.total = self.total + price * quantity

    table.insert(self.history, {
        link = link,
        price = price,
        quantity = quantity
    })
end

function Summary:GetEstimates()
    local estimate = 0
    local elapsed = GetTimePreciseSec() - self.start

    if elapsed > 0 then
        estimate = self.total / elapsed * 3600
    end

    return self.total, math.floor(estimate), elapsed
end

