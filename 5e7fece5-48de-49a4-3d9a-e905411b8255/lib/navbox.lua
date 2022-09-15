-- Creates and displays a Navbox
-- @param y : the y axis position of the navbox
-- @param label : the label of the navbox
-- @param value : the value of the navbox
-- @param unit : the unit of the navbox
-- @returns : the navbox object
Navbox = {}
Navbox.new = function(y, label, value, unit)
    local self = {}
    self.y = y

    label = string.format(label or "")
    self.labelTxt = txt_add(label, "font:" .. G.CONSTANTS.FONT .. ";color:" .. G.CONSTANTS.COLOR_SECONDARY .. ";size:" .. G.CONSTANTS.TEXT_SIZE .. ";halign:right;", 175, self.y, 155, G.CONSTANTS.TEXT_SIZE)

    value = prependPlus(value)
    value = string.format(value or "")
    self.valueTxt = txt_add(value, "font:" .. G.CONSTANTS.FONT .. ";color:" .. G.CONSTANTS.COLOR_PRIMARY .. ";size:70;halign:right;", 145, self.y + 10, 155, 70)

    unit = string.format(unit or "")
    self.unitTxt = txt_add(unit, " font:" .. G.CONSTANTS.FONT .. "; color:" .. G.CONSTANTS.COLOR_PRIMARY .. ";  size:" .. 20 .. "; valign:center; halign: left;", 300, self.y + 50, 35, 20)

    -- Sets the text value and unit of the navbox
    -- @param currentValue : the value to display
    function self.setValue(currentValue)
        txt_set(self.valueTxt, currentValue)
    end

    -- Returns the lua node id of the navbox group
    function self.getNode()
        return group_add(self.labelTxt, self.valueTxt, self.unitTxt)
    end

    return self
end