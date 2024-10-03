LootHistoryMixin = {
    Buttons = {},
}

LootHistoryScrollMixin = {
    Items = {},
}

function LootHistoryScrollMixin:OnShow()
    self:Update()
end

function LootHistoryScrollMixin:OnVerticalScroll(offset)
    FauxScrollFrame_OnVerticalScroll(self, offset, 16, self.Update);
end

function LootHistoryScrollMixin:Update()
    FauxScrollFrame_Update(self, 50, 5, 16)

    local offset = FauxScrollFrame_GetOffset(self)

    for i = 1, 5 do

    end
end
