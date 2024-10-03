BACKDROP_16_16_4444 = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileEdge = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
};

Looter = Addon:New()

Looter.Price = Price:New()
Looter.Display = Display:New()
Looter.Summary = Summary:New()

function OnAddonLoaded(name)
    if name ~= "Looter" then
        return
    end

    Looter.Display:OnReset(function()
        Looter.Summary:Start()
    end)

    C_Timer.NewTicker(1, function()
        local total, estimate, elapsed = Looter.Summary:GetEstimates()
        Looter.Display:Update(total, estimate, elapsed)
    end)
end

function OnChatMsgLoot(message)
    local link, quantity = string.match(message, "(|c%x+|Hitem:.*|r)(.*)")

    if not link then
        return
    end

    quantity = string.match(quantity, "x(%d+)")
    quantity = tonumber(quantity) or 1

    local price = Looter.Price:FindPriceByItemLink(link)

    if not price then
        price = 0
    end

    Looter.Summary:AddLoot(link, price, quantity)
end

Looter:RegisterCallback("ADDON_LOADED", OnAddonLoaded)
Looter:RegisterCallback("CHAT_MSG_LOOT", OnChatMsgLoot)
