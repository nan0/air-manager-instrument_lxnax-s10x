-- Creates and displays the wind information in the left part of the screen
-- @param relativeDirection : the wind direction relative to the plane heading
-- @param velocity : the wind velocity in knots
-- @returns : the Windbox object
Windbox = {}
Windbox.new = function(windDirection, relativeDirection, velocity)
    local self = {}

    windDirection = string.format(windDirection or 0)
    relativeDirection = string.format(relativeDirection or 0)
    velocity = string.format(velocity or 0)

    local imgWindArrow = img_add("ls100_wind_arrow.png", 120, 225, 35, 35)
    local windDirectionTxt = txt_add(relativeDirection, "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.TEXT_SIZE .. ";  halign: right;", 90, 265, 55, G.TEXT_SIZE)
    txt_add("/", "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.TEXT_SIZE .. ";  halign: left;", 145, 265, 35, G.TEXT_SIZE)
    local velocityTxt = txt_add(velocity, "font:" .. G.FONT .. "; color:" .. G.COLOR_SECONDARY .. ";size:" .. G.TEXT_SIZE .. ";  halign: left;", 155, 265, 35, G.TEXT_SIZE)

    -- Displays the wind direction as a text
    -- @param windDirection : the wind direction
    function self.setWindDirection(windDirection)
        windDirection = string.format("%.0f°", windDirection)
        txt_set(windDirectionTxt, windDirection)
    end

    -- Rotates the wind arrow according to the relative wind direction
    -- @param direction : the relative wind direction
    function self.setRelativeDirection(direction)
        rotate(imgWindArrow, direction)
    end

    -- Displays the wind velocity as a text
    -- @param velocity : the velocity as a text
    function self.setVelocity(velocity)
        txt_set(velocityTxt, velocity)
    end

    return self
end