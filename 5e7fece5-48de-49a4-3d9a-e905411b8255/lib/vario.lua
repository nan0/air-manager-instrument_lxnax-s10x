-- The vario main object
-- @returns : the Vario object
Vario = {}
Vario.new = function()
    local self = {}

    function addNavbox(position, label, value, unit)
        if (position < 1 or position > 4) then
            error("The position must be between 1 and 4")
        end

        local y = 30 + position * 75
        return Navbox.new(y, label, value, unit)
    end

    img_add_fullscreen("ls100_bg.png")
    txt_add("m/s", "font:" .. G.FONT .. "; color:" .. G.COLOR_INVERTED .. "; size:23; halign: right;", 310, 440, 30, 23)

    self.redDiamond = RedDiamond.new()
    self.needle = Needle.new()
    self.windbox = Windbox.new()
    self.navboxAvgVario = addNavbox(1, "Avg.vario", 0, "m/s")
    self.navboxNetto = addNavbox(2, "Netto", 0, "m/s")
    self.navboxAltitude = addNavbox(3, "Altitude", 0, "m")
    self.navboxTAS = addNavbox(4, "True airspeed", 0, "km/h")

    return self
end