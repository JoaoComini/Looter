Price = {}

function Price:New(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Price:FindPriceByItemLink(link)
    local price = Auctionator.API.v1.GetAuctionPriceByItemLink("Looter", link)

    if price then
        return price
    end

    return Auctionator.API.v1.GetVendorPriceByItemLink("Looter", link) 
end
