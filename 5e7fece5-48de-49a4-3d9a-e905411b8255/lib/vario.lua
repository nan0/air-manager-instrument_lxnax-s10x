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
    self.navbox1 = Navbox.new(1, "Avg.vario", 0)
    self.navbox2 = Navbox.new(2, "Netto", 0)
    self.navbox3 = Navbox.new(3, "Altitude", 0)
    self.navbox4 = Navbox.new(4, "True airspeed", 0)


    return self
end