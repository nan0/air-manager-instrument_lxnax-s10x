-- Creates and displays a Navbox
-- @param position : the position of the navbox, between 1 and 4
-- @param label : the label of the navbox
-- @param value : the value of the navbox
-- @param unit : the unit of the navbox
-- @returns : the navbox object
Navbox = {}
Navbox.new = function(position, label, value, unit)
    if (position < 1 or position > 4) then
        error("The position must be between 1 and 4")
    end

    local self = {}
    local y = 30 + position * 75;
    label = string.format(label or "")
    value = string.format(value or "")
    unit = string.format(unit or "")
    self.label = txt_add(label, "font:" .. G.FONT .. ";color:" .. G.COLOR_SECONDARY .. ";size:" .. G.TEXT_SIZE .. ";halign:right;", 175, y, 155, G.TEXT_SIZE)
    self.value = txt_add(value, "font:" .. G.FONT .. ";color:" .. G.COLOR_PRIMARY .. ";size:70;halign:right;", 145, y + 10, 155, 70)
    self.unit = txt_add(unit, " font:" .. G.FONT .. "; color:" .. G.COLOR_PRIMARY .. ";  size:" .. 20 .. "; valign:center; halign: left;", 300, y + 50, 35, 20)

    function self.setValue(value, unit)
        txt_set(self.value, value)
        txt_set(self.unit, unit)
    end

    return self
end