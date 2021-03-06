UIMenuSliderHeritageItem = setmetatable({}, UIMenuSliderHeritageItem)
UIMenuSliderHeritageItem.__index = UIMenuSliderHeritageItem
UIMenuSliderHeritageItem.__call = function() return "UIMenuItem", "UIMenuSliderHeritageItem" end

---New
---@param Text string
---@param Items table
---@param Index boolean
---@param Description string
---@param SliderColors table
---@param BackgroundSliderColors table
function UIMenuSliderHeritageItem.New(Text, Items, Index, Description, SliderColors, BackgroundSliderColors)
    if type(Items) ~= "table" then Items = {} end
    if Index == 0 then Index = 1 end

    if type(SliderColors) ~= "table" or  SliderColors == nil then
        _SliderColors = { R = 57, G = 119, B = 200, A = 255 }
    else
       _SliderColors = SliderColors
    end

    if type(BackgroundSliderColors) ~= "table" or  BackgroundSliderColors == nil then
        _BackgroundSliderColors = { R = 4, G = 32, B = 57, A = 255 }
    else
        _BackgroundSliderColors = BackgroundSliderColors
    end

    local _UIMenuSliderHeritageItem = {
        Base = UIMenuItem.New(Text or "", Description or ""),
        Items = Items,
        ShowDivider = 1,
        LeftArrow = Sprite.New("mpleaderboard", "leaderboard_male_icon", 0, 0, 30, 30, 0, 255, 255, 255, 255),
        RightArrow = Sprite.New("mpleaderboard", "leaderboard_female_icon", 0, 0, 30, 30, 0, 255, 255, 255, 255),
        Background = UIResRectangle.New(0, 0, 150, 10, _BackgroundSliderColors.R, _BackgroundSliderColors.G, _BackgroundSliderColors.B, _BackgroundSliderColors.A),
        Slider = UIResRectangle.New(0, 0, 75, 10, _SliderColors.R, _SliderColors.G, _SliderColors.B, _SliderColors.A),
        Divider = UIResRectangle.New(0, 0, 4, 20, 255, 255, 255, 255),
        _Index = tonumber(Index) or 1,
        Audio = { Slider = "CONTINUOUS_SLIDER", Library = "HUD_FRONTEND_DEFAULT_SOUNDSET", Id = nil },
        OnSliderChanged = function(menu, item, newindex) end,
        OnSliderSelected = function(menu, item, newindex) end,
    }
    return setmetatable(_UIMenuSliderHeritageItem, UIMenuSliderHeritageItem)
end

---SetParentMenu
---@param Menu table
function UIMenuSliderHeritageItem:SetParentMenu(Menu)
    if Menu() == "UIMenu" then
        self.Base.ParentMenu = Menu
    else
        return self.Base.ParentMenu
    end
end

---Position
---@param Y number
function UIMenuSliderHeritageItem:Position(Y)
    if tonumber(Y) then
        self.Background:Position(250 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, Y + 158.5 + self.Base._Offset.Y)
        self.Slider:Position(250 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, Y + 158.5 + self.Base._Offset.Y)
        self.Divider:Position(323.5 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, Y + 153 + self.Base._Offset.Y)
        self.LeftArrow:Position(220 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, 148.5 + Y + self.Base._Offset.Y)
        self.RightArrow:Position(400 + self.Base._Offset.X + self.Base.ParentMenu.WidthOffset, 148.5 + Y + self.Base._Offset.Y)
        self.Base:Position(Y)
    end
end

---Selected
---@param bool boolean
function UIMenuSliderHeritageItem:Selected(bool)
    if bool ~= nil then
        self.Base._Selected = tobool(bool)
    else
        return self.Base._Selected
    end
end

---Hovered
---@param bool boolean
function UIMenuSliderHeritageItem:Hovered(bool)
    if bool ~= nil then
        self.Base._Hovered = tobool(bool)
    else
        return self.Base._Hovered
    end
end

---Enabled
---@param bool boolean
function UIMenuSliderHeritageItem:Enabled(bool)
    if bool ~= nil then
        self.Base._Enabled = tobool(bool)
    else
        return self.Base._Enabled
    end
end

---Description
---@param str string
function UIMenuSliderHeritageItem:Description(str)
    if tostring(str) and str ~= nil then
        self.Base._Description = tostring(str)
    else
        return self.Base._Description
    end
end

---Offset
---@param X number
---@param Y number
function UIMenuSliderHeritageItem:Offset(X, Y)
    if tonumber(X) or tonumber(Y) then
        if tonumber(X) then
            self.Base._Offset.X = tonumber(X)
        end
        if tonumber(Y) then
            self.Base._Offset.Y = tonumber(Y)
        end
    else
        return self.Base._Offset
    end
end

---Text
---@param Text string
function UIMenuSliderHeritageItem:Text(Text)
    if tostring(Text) and Text ~= nil then
        self.Base.Text:Text(tostring(Text))
    else
        return self.Base.Text:Text()
    end
end

---Index
---@param Index number
function UIMenuSliderHeritageItem:Index(Index)
    if tonumber(Index) then
        if tonumber(Index) > #self.Items then
            self._Index = 1
        elseif tonumber(Index) < 1 then
            self._Index = #self.Items
        else
            self._Index = tonumber(Index)
        end
    else
        return self._Index
    end
end

---ItemToIndex
---@param Item table
function UIMenuSliderHeritageItem:ItemToIndex(Item)
    for i = 1, #self.Items do
        if type(Item) == type(self.Items[i]) and Item == self.Items[i] then
            return i
        end
    end
end

---IndexToItem
---@param Index number
function UIMenuSliderHeritageItem:IndexToItem(Index)
    if tonumber(Index) then
        if tonumber(Index) == 0 then Index = 1 end
        if self.Items[tonumber(Index)] then
            return self.Items[tonumber(Index)]
        end
    end
end

---SetLeftBadge
function UIMenuSliderHeritageItem:SetLeftBadge()
    error("This item does not support badges")
end

---SetRightBadge
function UIMenuSliderHeritageItem:SetRightBadge()
    error("This item does not support badges")
end

---RightLabel
function UIMenuSliderHeritageItem:RightLabel()
    error("This item does not support a right label")
end

---Draw
function UIMenuSliderHeritageItem:Draw()
    self.Base:Draw()

    if self:Enabled() then
        if self:Selected() then
            self.LeftArrow:Colour(0, 0, 0, 255)
            self.RightArrow:Colour(0, 0, 0, 255)
        else
            self.LeftArrow:Colour(255, 255, 255, 255)
            self.RightArrow:Colour(255, 255, 255, 255)
        end
    else
        self.LeftArrow:Colour(255, 255, 255, 255)
        self.RightArrow:Colour(255, 255, 255, 255)
    end

    local Offset = ((self.Background.Width - self.Slider.Width) / (#self.Items - 1)) * (self._Index - 1)

    self.Slider:Position(250 + self.Base._Offset.X + Offset + self.Base.ParentMenu.WidthOffset, self.Slider.Y)

    self.LeftArrow:Draw()
    self.RightArrow:Draw()

    self.Background:Draw()
    self.Slider:Draw()

    if self.ShowDivider then
        self.Divider:Draw()
        if self:Selected() then
            self.Divider:Colour(0, 0, 0, 255)
        else
            self.Divider:Colour(255, 255, 255, 255)
        end
    end

end