-- Creates and displays a big central box
-- @param label : the label of the Centralbox
-- @param value : the value of the Centralbox
-- @param unit : the unit of the Centralbox
-- @returns : the Centralbox object
Centralbox = {}
Centralbox.new = function(label, value, unit)
    local self = Navbox.new(210, label, value, unit)
    local x = 145
    move(self.labelTxt, x)
    move(self.valueTxt, x - 30)
    move(self.unitTxt, x + 125)

    return self
end