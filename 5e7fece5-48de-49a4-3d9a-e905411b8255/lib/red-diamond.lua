-- Displays and rotate the red diamond
-- @param value : the value for the red diamond to display
-- @returns : the RedDiamond object
RedDiamond = {}
RedDiamond.new = function(value)
    local self = {}
    local imgRedDiamond = img_add("ls100_red_diamond.png", 0, 0, 512, 512)

    -- Rotates the RedDiamond according to the value provided
    -- @param value : the value to display
    function self.setValue(value)
        rotate(imgRedDiamond, 240 / 10 * value)
    end

    return self
end