-- Creates and displays the wind information in the left part of the screen
-- @param relativeDirection : the wind direction relative to the plane heading
-- @param velocity : the wind velocity in knots
-- @returns : the Windbox object
Windbox = {}
Windbox.new = function(relativeDirection, velocity)
    local self = {}
    local imgWindArrow = img_add("ls100_wind_arrow.png", 120, 225, 35, 35)
    txt_add("/", "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.TEXT_SIZE .. ";  halign: left;", 145, 265, 35, G.TEXT_SIZE)

    relativeDirection = string.format(relativeDirection or "")
    velocity = string.format(velocity or "")

    self.relativeDirection = txt_add(relativeDirection, "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.TEXT_SIZE .. ";  halign: right;", 90, 265, 55, G.TEXT_SIZE)
    self.velocity = txt_add(velocity, "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.TEXT_SIZE .. ";  halign: left;", 155, 265, 35, G.TEXT_SIZE)

    function self.setRelativeDirection(direction)
        rotate(imgWindArrow, direction)
        direction = string.format("%.0f°", direction)
        txt_set(self.relativeDirection, direction)
    end

    function self.setVelocity(velocity)
        txt_set(self.velocity, velocity)
    end

    return self
end