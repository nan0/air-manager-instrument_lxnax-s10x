-- Creates and displays a Navbox
-- @param y : the y axis position of the navbox
-- @param label : the label of the navbox
-- @param value : the value of the navbox
-- @param unit : the unit of the navbox
-- @returns : the navbox object
Navbox = {}
Navbox.new = function(y, label, value, unit)
    local self = {}
    label = string.format(label or "")
    label = txt_add(label, "font:" .. G.FONT .. ";color:" .. G.COLOR_SECONDARY .. ";size:" .. G.TEXT_SIZE .. ";halign:right;", 175, y, 155, G.TEXT_SIZE)
    value = string.format(value or "")
    value = txt_add(value, "font:" .. G.FONT .. ";color:" .. G.COLOR_PRIMARY .. ";size:70;halign:right;", 145, y + 10, 155, 70)
    unit = string.format(unit or "")
    unit = txt_add(unit, " font:" .. G.FONT .. "; color:" .. G.COLOR_PRIMARY .. ";  size:" .. 20 .. "; valign:center; halign: left;", 300, y + 50, 35, 20)

    -- Sets the text value and unit of the navbox
    -- @param currentValue : the value to display
    function self.setValue(currentValue)
        txt_set(value, currentValue)
    end

    return self
end