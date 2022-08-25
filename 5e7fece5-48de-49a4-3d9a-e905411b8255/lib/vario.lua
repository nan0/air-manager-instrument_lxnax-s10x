-- Displays and rotate the vario Vario
-- @param value : the value for the Vario to display
-- @returns : the Vario object
Vario = {}
Vario.new = function(value)
    local self = {}
    img_add_fullscreen("ls100_bg.png")
    txt_add("m/s", " font:" .. G.FONT .. "; color:" .. G.COLOR_INVERTED .. ";  size:23;  halign: right;", 310, 440, 30, 23)

    self.redDiamond = RedDiamond.new()
    self.needle = Needle.new()
    self.windbox = Windbox.new()

    function addNavbox(position, label, value, unit)
        if (position < 1 or position > 4) then
            error("The position must be between 1 and 4")
        end

        local y = 30 + position * 75
        return Navbox.new(y, label, value, unit)
    end

    self.navbox1 = addNavbox(1, "Avg.vario", 0, "m/s")
    self.navbox2 = addNavbox(2, "Netto", 0, "m/s")
    self.navbox3 = addNavbox(3, "Altitude", 0, "m")
    self.navbox4 = addNavbox(4, "True airspeed", 0, "km/h")

    return self
end